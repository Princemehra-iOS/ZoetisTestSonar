//
//  DropDown.swift
//
//  Created by "" ""on 21/11/18.
//  Copyright © "" Kumar Panday. All rights reserved.
//




import UIKit

public typealias Index = Int
public typealias Closure = () -> Void
public typealias SelectionClosure = (Index, String) -> Void
public typealias ConfigurationClosure = (Index, String) -> String
private typealias ComputeLayoutTuple = (x: CGFloat, y: CGFloat, width: CGFloat, offscreenHeight: CGFloat)

/// A Material Design drop down in replacement for `UIPickerView`.
public final class DropDown: UIView {
	
	//TODO: handle iOS 7 landscape mode
	
	/// The dismiss mode for a drop down.
	public enum DismissMode {
		
		/// A tap outside the drop down is required to dismiss.
		case onTap
		
		/// No tap is required to dismiss, it will dimiss when interacting with anything else.
		case automatic
		
		/// Not dismissable by the user.
		case manual
		
	}
	
	/// The direction where the drop down will show from the `anchorView`.
	public enum Direction {
		
		/// The drop down will show below the anchor view when possible, otherwise above if there is more place than below.
		case any
		
		/// The drop down will show above the anchor view or will not be showed if not enough space.
		case top
		
		/// The drop down will show below or will not be showed if not enough space.
		case bottom
		
	}
	
	//MARK: - Properties
	
	/// The current visible drop down. There can be only one visible drop down at a time.
	public static weak var VisibleDropDown: DropDown?
	
	//MARK: UI
	fileprivate let dismissableView = UIView()
	fileprivate let tableViewContainer = UIView()
    let tableView = UITableView()
	
	/// The view to which the drop down will displayed onto.
	public weak var anchorView: UIView? {
		didSet { setNeedsUpdateConstraints() }
	}
	
	/**
	The possible directions where the drop down will be showed.
	
	See `Direction` enum for more info.
	*/
	public var direction = Direction.any
	
	/**
	The offset point relative to `anchorView` when the drop down is shown above the anchor view.
	
	By default, the drop down is showed onto the `anchorView` with the top
	left corner for its origin, so an offset equal to (0, 0).
	You can change here the default drop down origin.
	*/
	public var topOffset: CGPoint = CGPoint.zero {
		didSet { setNeedsUpdateConstraints() }
	}
	
	/**
	The offset point relative to `anchorView` when the drop down is shown below the anchor view.
	
	By default, the drop down is showed onto the `anchorView` with the top
	left corner for its origin, so an offset equal to (0, 0).
	You can change here the default drop down origin.
	*/
	public var bottomOffset: CGPoint = CGPoint.zero {
		didSet { setNeedsUpdateConstraints() }
	}
	
	/**
	The width of the drop down.
	
	Defaults to `anchorView.bounds.width - offset.x`.
	*/
	public var width: CGFloat? {
		didSet { setNeedsUpdateConstraints() }
	}
	
	//MARK: Constraints
	fileprivate var heightConstraint: NSLayoutConstraint!
	fileprivate var widthConstraint: NSLayoutConstraint!
	fileprivate var xConstraint: NSLayoutConstraint!
	fileprivate var yConstraint: NSLayoutConstraint!
    var heightConstantCut : CGFloat = 0
	//MARK: Appearance
	public override var backgroundColor: UIColor? {
		get { return tableView.backgroundColor }
		set { tableView.backgroundColor = newValue }
	}
	
	/**
	The background color of the selected cell in the drop down.
	
	Changing the background color automatically reloads the drop down.
	*/
    @objc public dynamic var selectionBackgroundColor = DPDConstant.UI.SelectionBackgroundColor {
		didSet { reloadAllComponents() }
	}
	
	/**
	The color of the text for each cells of the drop down.
	
	Changing the text color automatically reloads the drop down.
	*/
    @objc public dynamic var textColor = UIColor.black {
		didSet { reloadAllComponents() }
	}
	
	/**
	The font of the text for each cells of the drop down.
	
	Changing the text font automatically reloads the drop down.
	*/
    @objc public dynamic var textFont = UIFont.systemFont(ofSize: 15) {
		didSet { reloadAllComponents() }
	}
	
	//MARK: Content
	
	/**
	The data source for the drop down.
	
	Changing the data source automatically reloads the drop down.
	*/
	public var dataSource = [AnyObject]() {
		didSet { reloadAllComponents() }
	}
	
	fileprivate var selectedRowIndex: Index?
	
	/**
	The format for the cells' text.
	
	By default, the cell's text takes the plain `dataSource` value.
	Changing `cellConfiguration` automatically reloads the drop down.
	*/
	public var cellConfiguration: ConfigurationClosure? {
		didSet { reloadAllComponents() }
	}
	
	/// The action to execute when the user selects a cell.
	public var selectionAction: SelectionClosure?
	
	/// The action to execute when the user cancels/hides the drop down.
	public var cancelAction: Closure?
	
	/// The dismiss mode of the drop down. Default is `OnTap`.
	public var dismissMode = DismissMode.onTap {
		willSet {
			if newValue == .onTap {
				let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DropDown.dismissableViewTapped))
				dismissableView.addGestureRecognizer(gestureRecognizer)
			} else if let gestureRecognizer = dismissableView.gestureRecognizers?.first {
				dismissableView.removeGestureRecognizer(gestureRecognizer)
			}
		}
	}
	
	fileprivate var minHeight: CGFloat {
		return tableView.rowHeight
	}
	
	fileprivate var didSetupConstraints = false
	
	//MARK: - Init's
	
	deinit {
		stopListeningToNotifications()
	}
	
	/**
	Creates a new instance of a drop down.
	Don't forget to setup the `dataSource`,
	the `anchorView` and the `selectionAction`
	at least before calling `show()`.
	*/
	public convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	/**
	Creates a new instance of a drop down.
	
	- parameter anchorView:        The view to which the drop down will displayed onto.
	- parameter selectionAction:   The action to execute when the user selects a cell.
	- parameter dataSource:        The data source for the drop down.
	- parameter topOffset:         The offset point relative to `anchorView` used when drop down is displayed on above the anchor view.
	- parameter bottomOffset:      The offset point relative to `anchorView` used when drop down is displayed on below the anchor view.
	- parameter cellConfiguration: The format for the cells' text.
	- parameter cancelAction:      The action to execute when the user cancels/hides the drop down.
	
	- returns: A new instance of a drop down customized with the above parameters.
	*/
	public convenience init(anchorView: UIView, selectionAction: SelectionClosure? = nil, dataSource: [String] = [], topOffset: CGPoint? = nil, bottomOffset: CGPoint? = nil, cellConfiguration: ConfigurationClosure? = nil, cancelAction: Closure? = nil) {
		self.init(frame: CGRect.zero)
		
		self.anchorView = anchorView
		self.selectionAction = selectionAction
		self.dataSource = dataSource as [AnyObject]
		self.topOffset = topOffset ?? CGPoint.zero
		self.bottomOffset = bottomOffset ?? CGPoint.zero
		self.cellConfiguration = cellConfiguration
		self.cancelAction = cancelAction
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
}

//MARK: - Setup

private extension DropDown {
	
	func setup() {
		updateConstraintsIfNeeded()
		setupUI()
		
		dismissMode = .onTap
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(DropDownCell.Nib, forCellReuseIdentifier: DPDConstant.ReusableIdentifier.DropDownCell)
		
		startListeningToKeyboard()
	}
	
	func setupUI() {
		super.backgroundColor = UIColor.clear
		
		tableViewContainer.layer.masksToBounds = false
		tableViewContainer.layer.cornerRadius = DPDConstant.UI.CornerRadius
//		tableViewContainer.layer.shadowColor = DPDConstant.UI.Shadow.Color
//		tableViewContainer.layer.shadowOffset = DPDConstant.UI.Shadow.Offset
//		tableViewContainer.layer.shadowOpacity = DPDConstant.UI.Shadow.Opacity
//		tableViewContainer.layer.shadowRadius = DPDConstant.UI.Shadow.Radius
//
        tableViewContainer.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            
		setupTableViewUI()
		
		setHiddentState()
		isHidden = true
	}
	
	func setupTableViewUI() {
		backgroundColor = DPDConstant.UI.BackgroundColor
		tableView.rowHeight = DPDConstant.UI.RowHeight
		tableView.separatorColor = DPDConstant.UI.SeparatorColor
		tableView.separatorStyle = DPDConstant.UI.SeparatorStyle
		tableView.separatorInset = DPDConstant.UI.SeparatorInsets
		tableView.layer.cornerRadius = DPDConstant.UI.CornerRadius
		tableView.layer.masksToBounds = true
	}
	
}

//MARK: - UI

extension DropDown {
	
	public override func updateConstraints() {
		if !didSetupConstraints {
			setupConstraints()
		}
		
		didSetupConstraints = true
		
		let layout = computeLayout()
		
		if !layout.canBeDisplayed {
			super.updateConstraints()
			hide()
			
			return
		}
		
		xConstraint.constant = layout.x
		yConstraint.constant = layout.y
		widthConstraint.constant = layout.width
		heightConstraint.constant = layout.visibleHeight
		
		tableView.isScrollEnabled = layout.offscreenHeight > 0
		
		DispatchQueue.main.async { [unowned self] in
            

			//self.tableView.flashScrollIndicators()
		}
		
		super.updateConstraints()
	}
	
	fileprivate func setupConstraints() {
		translatesAutoresizingMaskIntoConstraints = false
		
		// Dismissable view
		addSubview(dismissableView)
		dismissableView.translatesAutoresizingMaskIntoConstraints = false
		
		addUniversalConstraints("|[dismissableView]|", views: ["dismissableView": dismissableView])
		
		
		// Table view container
		addSubview(tableViewContainer)
		tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
		
		xConstraint = NSLayoutConstraint(
			item: tableViewContainer,
			attribute: .leading,
			relatedBy: .equal,
			toItem: self,
			attribute: .leading,
			multiplier: 1,
			constant: 0)
		addConstraint(xConstraint)
		
		yConstraint = NSLayoutConstraint(
			item: tableViewContainer,
			attribute: .top,
			relatedBy: .equal,
			toItem: self,
			attribute: .top,
			multiplier: 1,
			constant: 0)
		addConstraint(yConstraint)
		
		widthConstraint = NSLayoutConstraint(
			item: tableViewContainer,
			attribute: .width,
			relatedBy: .equal,
			toItem: nil,
			attribute: .notAnAttribute,
			multiplier: 1,
			constant: 0)
		tableViewContainer.addConstraint(widthConstraint)
		
		heightConstraint = NSLayoutConstraint(
			item: tableViewContainer,
			attribute: .height,
			relatedBy: .equal,
			toItem: nil,
			attribute: .notAnAttribute,
			multiplier: 1,
			constant: 0)
		tableViewContainer.addConstraint(heightConstraint)
		
		// Table view
		tableViewContainer.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		tableViewContainer.addUniversalConstraints("|[tableView]|", views: ["tableView": tableView])
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		// When orientation changes, layoutSubviews is called
		// We update the constraint to update the position
		setNeedsUpdateConstraints()
		
		let shadowPath = UIBezierPath(rect: tableViewContainer.bounds)
		tableViewContainer.layer.shadowPath = shadowPath.cgPath
	}
	
	fileprivate func computeLayout() -> (x: CGFloat, y: CGFloat, width: CGFloat, offscreenHeight: CGFloat, visibleHeight: CGFloat, canBeDisplayed: Bool, Direction: Direction) {
		var layout: ComputeLayoutTuple = (0, 0, 0, 0)
		var direction = self.direction
		
		if let window = UIWindow.visibleWindow() {
			switch direction {
			case .any:
				layout = computeLayoutBottomDisplay(window)
				direction = .bottom
				
				if layout.offscreenHeight > 0 {
					let topLayout = computeLayoutForTopDisplay(window)
					
					if topLayout.offscreenHeight < layout.offscreenHeight {
						layout = topLayout
						direction = .top
					}
				}
			case .bottom:
				layout = computeLayoutBottomDisplay(window)
				direction = .bottom
			case .top:
				layout = computeLayoutForTopDisplay(window)
				direction = .top
			}
		}
		
		let visibleHeight = tableHeight - layout.offscreenHeight - heightConstantCut
		let canBeDisplayed = visibleHeight >= minHeight
		
		return (layout.x, layout.y + heightConstantCut, layout.width, layout.offscreenHeight, visibleHeight, canBeDisplayed, direction)
	}
	
	fileprivate func computeLayoutBottomDisplay(_ window: UIWindow) -> ComputeLayoutTuple {
		var offscreenHeight: CGFloat = 0
		
		let anchorViewX = (anchorView?.windowFrame?.minX ?? 0)
		let anchorViewY = (anchorView?.windowFrame?.minY ?? 0)
		
		let x = anchorViewX + bottomOffset.x
		let y = anchorViewY + bottomOffset.y
		
		let maxY = y + tableHeight
		let windowMaxY = window.bounds.maxY - DPDConstant.UI.HeightPadding
		
		let keyboardListener = KeyboardListener.sharedInstance
		let keyboardMinY = keyboardListener.keyboardFrame.minY - DPDConstant.UI.HeightPadding
		
		if keyboardListener.isVisible && maxY > keyboardMinY {
			offscreenHeight = abs(maxY - keyboardMinY)
		} else if maxY > windowMaxY {
			offscreenHeight = abs(maxY - windowMaxY)
		}
		
		let width = self.width ?? (anchorView?.bounds.width ?? 0) - bottomOffset.x
		
		return (x, y, width, offscreenHeight)
	}
	
	fileprivate func computeLayoutForTopDisplay(_ window: UIWindow) -> ComputeLayoutTuple {
		var offscreenHeight: CGFloat = 0
		
		let anchorViewX = (anchorView?.windowFrame?.minX ?? 0)
		let anchorViewMaxY = (anchorView?.windowFrame?.maxY ?? 0)
		
		let x = anchorViewX + topOffset.x
		var y = (anchorViewMaxY + topOffset.y) - tableHeight
		
		let windowY = window.bounds.minY + DPDConstant.UI.HeightPadding
		
		if y < windowY {
			offscreenHeight = abs(y - windowY)
			y = windowY
		}
		
		let width = self.width ?? (anchorView?.bounds.width ?? 0) - topOffset.x
		
		return (x, y, width, offscreenHeight)
	}
	
}

//MARK: - Actions

extension DropDown {
	
	/**
	Shows the drop down if enough height.
	
	- returns: Wether it succeed and how much height is needed to display all cells at once.
	*/
	public func show() -> (canBeDisplayed: Bool, offscreenHeight: CGFloat?) {
		if self == DropDown.VisibleDropDown {
			return (true, 0)
		}
		
		if let visibleDropDown = DropDown.VisibleDropDown {
			visibleDropDown.cancel()
		}
		
		DropDown.VisibleDropDown = self
		
		setNeedsUpdateConstraints()
		
		let visibleWindow = UIWindow.visibleWindow()
		visibleWindow?.addSubview(self)
        visibleWindow?.bringSubviewToFront(self)
		
		self.translatesAutoresizingMaskIntoConstraints = false
		visibleWindow?.addUniversalConstraints("|[dropDown]|", views: ["dropDown": self])
		
		let layout = computeLayout()
		
		if !layout.canBeDisplayed {
			hide()
			return (layout.canBeDisplayed, layout.offscreenHeight)
		}
		
		isHidden = false
		tableViewContainer.transform = DPDConstant.Animation.DownScaleTransform
		
		UIView.animate(
			withDuration: DPDConstant.Animation.Duration,
			delay: 0,
			options: DPDConstant.Animation.EntranceOptions,
			animations: { [unowned self] in
				self.setShowedState()
			},
			completion: nil)
		
		selectRowAtIndex(selectedRowIndex)
		
		return (layout.canBeDisplayed, layout.offscreenHeight)
	}
    
    
    public func showNew() -> (canBeDisplayed: Bool, offscreenHeight: CGFloat?) {
        if self == DropDown.VisibleDropDown {
            return (true, 0)
        }
        
        if let visibleDropDown = DropDown.VisibleDropDown {
            visibleDropDown.cancel()
        }
        
        DropDown.VisibleDropDown = self
        
        setNeedsUpdateConstraints()
        
        let visibleWindow = UIWindow.visibleWindow()
        visibleWindow?.addSubview(self)
        visibleWindow?.bringSubviewToFront(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        visibleWindow?.addUniversalConstraints("|[dropDown]|", views: ["dropDown": self])
        
        let layout = computeLayout()
        
        if !layout.canBeDisplayed {
            hide()
            return (layout.canBeDisplayed, layout.visibleHeight)
        }
       
        isHidden = false
        tableViewContainer.transform = DPDConstant.Animation.DownScaleTransform
        
        UIView.animate(
            withDuration: DPDConstant.Animation.Duration,
            delay: 0,
            options: DPDConstant.Animation.EntranceOptions,
            animations: { [unowned self] in
                self.setShowedState()
            },
            completion: nil)
        
        selectRowAtIndex(selectedRowIndex)
        
        return (layout.canBeDisplayed, 0.0)
    }
	
	/// Hides the drop down.
	public func hide() {
		if self == DropDown.VisibleDropDown {
			/*
			If one drop down is showed and another one is not
			but we call `hide()` on the hidden one:
			we don't want it to set the `VisibleDropDown` to nil.
			*/
			DropDown.VisibleDropDown = nil
		}
		
		if isHidden {
			return
		}
		
		UIView.animate(
			withDuration: DPDConstant.Animation.Duration,
			delay: 0,
			options: DPDConstant.Animation.ExitOptions,
			animations: { [unowned self] in
				self.setHiddentState()
			},
			completion: { [unowned self] finished in
				self.isHidden = true
				self.removeFromSuperview()
			})
	}
	
	fileprivate func cancel() {
		hide()
		cancelAction?()
	}
	
	fileprivate func setHiddentState() {
		alpha = 0
	}
	
	fileprivate func setShowedState() {
		alpha = 1
		tableViewContainer.transform = CGAffineTransform.identity
	}
	
}

//MARK: - UITableView

extension DropDown {
	
	/**
	Reloads all the cells.
	
	It should not be necessary in most cases because each change to
	`dataSource`, `textColor`, `textFont`, `selectionBackgroundColor`
	and `cellConfiguration` implicitly calls `reloadAllComponents()`.
	*/
	public func reloadAllComponents() {
		if #available(iOS 9, *) {
			setupTableViewUI()
		}
        tableView.layer.cornerRadius = 8.0
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
		tableView.reloadData()
		setNeedsUpdateConstraints()
	}
	
	/// (Pre)selects a row at a certain index.
	public func selectRowAtIndex(_ index: Index?) {
		if let index = index {
			tableView.selectRow(
				at: IndexPath(row: index, section: 0),
				animated: false,
				scrollPosition: .middle)
		} else {
			deselectRowAtIndexPath(selectedRowIndex)
		}
		
		selectedRowIndex = index
	}
	
	public func deselectRowAtIndexPath(_ index: Index?) {
		selectedRowIndex = nil
		
		guard let index = index, index > 0 
			else { return }
		
		tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
	}
	
	/// Returns the index of the selected row.
	public var indexForSelectedRow: Index? {
		return tableView.indexPathForSelectedRow?.row
	}
	
	/// Returns the selected item.
	public var selectedItem: String? {
		guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
		
        return dataSource[row] as? String
	}
	
	/// Returns the height needed to display all cells.
	fileprivate var tableHeight: CGFloat {
		return tableView.rowHeight * CGFloat(dataSource.count)
	}
	
}

//MARK: - UITableViewDataSource - UITableViewDelegate

extension DropDown: UITableViewDataSource, UITableViewDelegate {
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSource.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DPDConstant.ReusableIdentifier.DropDownCell, for: indexPath) as! DropDownCell
		
		cell.optionLabel.textColor = textColor
		cell.optionLabel.font = textFont
		cell.selectedBackgroundColor = selectionBackgroundColor
		
		if let cellConfiguration = cellConfiguration {
			let index = indexPath.row
			cell.optionLabel.text = cellConfiguration(index, dataSource[index] as! String)
		} else {
            
            if dataSource[indexPath.row] is String
            {
                cell.optionLabel.text = dataSource[indexPath.row] as? String
                
            }
            else
            {

            }
        }
		
		return cell
	}
	
	public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.isSelected = indexPath.row == selectedRowIndex
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedRowIndex = indexPath.row
        if dataSource[indexPath.row] is String
        {

		selectionAction?(selectedRowIndex!, dataSource[selectedRowIndex!] as! String)
        }
        else
        {


        }
		hide()
	}
	
}

//MARK: - Auto dismiss

extension DropDown {
	
	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		
		if dismissMode == .automatic && view === dismissableView {
			cancel()
			return nil
		} else {
			return view
		}
	}
	
	@objc
	fileprivate func dismissableViewTapped() {
		cancel()
	}
	
}

//MARK: - Keyboard events

extension DropDown {
	
	/**
	Starts listening to keyboard events.
	Allows the drop down to display correctly when keyboard is showed.
	*/
	public static func startListeningToKeyboard() {
		KeyboardListener.sharedInstance.startListeningToKeyboard()
	}
	
	fileprivate func startListeningToKeyboard() {
		KeyboardListener.sharedInstance.startListeningToKeyboard()
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(DropDown.keyboardUpdate),
			name: UIApplication.keyboardDidShowNotification,
			object: nil)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(DropDown.keyboardUpdate),
			name: UIApplication.keyboardDidHideNotification,
			object: nil)
	}
	
	fileprivate func stopListeningToNotifications() {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc
	fileprivate func keyboardUpdate() {
		self.setNeedsUpdateConstraints()
	}
	
}
