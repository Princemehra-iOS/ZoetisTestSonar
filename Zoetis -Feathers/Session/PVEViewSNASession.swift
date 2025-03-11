//
//  PVEViewSNASession.swift
//  Zoetis -Feathers
//
//  Created by NITIN KUMAR KANOJIA on 31/03/20.
//  Copyright © 2020 . All rights reserved.
//
import UIKit
import Foundation

class PVEViewSNASession: BaseViewController {
    
    let sharedManager = PVEShared.sharedInstance
    
    @IBOutlet weak var headerView: UIView!
    var peHeaderViewController:PEHeaderViewController!
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    private var breedOfBirdsArray : [String] = []
    private var farmNameArr = [[String:Any]]()
    
    @IBOutlet weak var viewForGradient: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var syncToWebBtn: UIButton!
    var assesssmentCellHeight : CGFloat = 435.0
    
    var currentTimeStamp = ""
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupHeader()
        setupUI()
        
    }
    
    func getDraftValueForKey(key:String) -> Any{
        let valuee = CoreDataHandlerPVE().fetchDraftForSyncId(type: "sync", syncId: currentTimeStamp)
        let valueArr = valuee.value(forKey: key) as! NSArray
        return valueArr[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        peHeaderViewController.onGoingSessionView.isHidden = true
        peHeaderViewController.syncView.isHidden = true
        
        tblView.reloadData()
        
        if  let cell = self.tblView.cellForRow(at: IndexPath(row: 0, section: 0) ) as? StartNewAssignmentCell
        {
            self.reloadCellUI(cell: cell)
        }
        tblView.reloadData()
        
    }
    
    func setupUI(){
        btnNext.setNextButtonUI()
        btnNext.titleLabel?.textColor = .white
        tblView.backgroundView = nil
        tblView.backgroundView?.backgroundColor = .clear
        
    }
    
    private func setupHeader() {
        
        peHeaderViewController = PEHeaderViewController()
        peHeaderViewController.titleOfHeader = "Completed Assessment"
        
        self.headerView.addSubview(peHeaderViewController.view)
        self.topviewConstraint(vwTop: peHeaderViewController.view)
    }
    
    func generateSeveyNumber(dateStr:String) -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/YYYY"
        var generatedServeyNo = String()
        let siteId = sharedManager.getSessionValueForKeyFromDB(key: "siteId") as! Int
        let evaluationDateStr = sharedManager.getSessionValueForKeyFromDB(key: "evaluationDate") as? String
        let savedDateString = evaluationDateStr?.replacingOccurrences(of: "/", with: "", options: .literal, range: nil)
        generatedServeyNo = "S-" + savedDateString! + "\(siteId)"
        return generatedServeyNo
        
    }
    
    @IBAction func actionMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
    }
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
}


extension PVEViewSNASession: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return  self.assesssmentCellHeight
        case 1:
            return  250
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: do {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SessionStartNewAssignmentCell", for: indexPath) as! StartNewAssignmentCell
            cell.selectionStyle = .none
            cell.timeStampStr = currentTimeStamp
            
            
            cell.customerTxtfield.text = sharedManager.getCustomerAndSitePopupValueFromDB(key: "customer") as? String
            cell.siteIdTxtfield.text = sharedManager.getCustomerAndSitePopupValueFromDB(key: "complexName") as? String
            
            
            let valuee = CoreDataHandlerPVE().fetchCurrentSessionInDB()
            if valuee.count > 0{
                
                cell.evaluationDateTxtfield.text = getDraftValueForKey(key: "evaluationDate") as? String
                cell.accManagerTxtfield.text = getDraftValueForKey(key: "accountManager") as? String
                cell.breedOfBirdsTxtfield.text = getDraftValueForKey(key: "breedOfBirds") as? String
                cell.breedOfBirdsFemaleTxtfield.text = getDraftValueForKey(key: "breedOfBirdsFemale") as? String
                cell.housingTxtfield.text = getDraftValueForKey(key: "housing") as? String
                cell.evaluationForTxtfield.text = getDraftValueForKey(key: "evaluationFor") as? String
                cell.breedOfBirdsOtherTxtfield.text = getDraftValueForKey(key: "breedOfBirdsOther") as? String
                cell.breedOfBirdsFemaleOtherTxtfield.text = getDraftValueForKey(key: "breedOfBirdsFemaleOther") as? String
                cell.farmNameTxtfield.text = getDraftValueForKey(key: "farm") as? String
                cell.houseNoTxtfield.text = getDraftValueForKey(key: "houseNumber") as? String
                cell.noOfBirdsTxtfield.text = "\(getDraftValueForKey(key: "noOfBirds"))"
                cell.evaluatorTxtfield.text = getDraftValueForKey(key: "evaluator") as? String
                cell.ageOfBirdsTxtfield.text = "\(getDraftValueForKey(key: "ageOfBirds"))"
                
                if getDraftValueForKey(key: "noOfBirds") as! Int == 0 {
                    cell.noOfBirdsTxtfield.text = ""
                }
                if getDraftValueForKey(key: "ageOfBirds") as! Int == 0 {
                    cell.ageOfBirdsTxtfield.text = ""
                }
                
                let cameraState = getDraftValueForKey(key: "cameraEnabled") as? String
                if cameraState == "true"{
                    cell.switchBtn.isOn = true
                    
                }else{
                    cell.switchBtn.isOn = false
                    
                }
                
                var selectedBirdTypeId = Int()
                selectedBirdTypeId = getDraftValueForKey(key: "selectedBirdTypeId") as! Int
                if selectedBirdTypeId == 14 {
                    cell.birdWelfareImg.image = UIImage(named: "checkIconPE")
                    cell.birdPresentationImg.image = UIImage(named: "uncheckIconPE")
                }else{
                    cell.birdWelfareImg.image = UIImage(named: "uncheckIconPE")
                    cell.birdPresentationImg.image = UIImage(named: "checkIconPE")
                }
                
                cell.backgroundColor = UIColor.clear
                
            }
            return cell
        }
            
        default: do {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.addNote_StartNewAssCell, for: indexPath) as! AddNote_StartNewAssCell
            cell.notetxtView.isEditable = false
            
            cell.notetxtView.isScrollEnabled = true
            cell.notetxtView.textContainer.lineFragmentPadding = 12
            cell.selectionStyle = .none
            cell.timeStampStr = currentTimeStamp
            cell.notetxtView.text = getDraftValueForKey(key: "notes") as? String
            
            cell.backgroundColor = UIColor.clear
            
            return cell
            
        }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}
//  MARK:------------------------------Button Action and Set Values in Fields-----------------

extension PVEViewSNASession{
    
    @IBAction func evaluationDateBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.selection, bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier:  Constants.ControllerIdentifier.datePickerPopupViewController) as! DatePickerPopupViewController
        datePickerPopupViewController.isPVE = true
        present(datePickerPopupViewController, animated: false, completion: nil)
    }
    
    @IBAction func customerBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "Customer_PVE")
        let namesArray = array.value(forKey: "customerName") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.customer, dropDownArr: namesArray)
    }
    
    @IBAction func evaluationForBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "PVE_EvaluationFor")
        let namesArray = array.value(forKey: "name") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.evaluationFor, dropDownArr: namesArray)
    }
    
    @IBAction func siteIdBtnAction(_ sender: UIButton) {
        
        let dataArr = CoreDataHandlerPVE().fetchCurrentSessionInDB()
        let arr = dataArr.value(forKey: "customerId") as! NSArray
        let custId = arr[0] as! Int
        
        var siteNameArr = NSArray()
        let namesArray = CoreDataHandlerPVE().fetchCustomerWithCustId( custId as NSNumber)
        siteNameArr = namesArray.value(forKey: "complexName") as? NSArray ?? NSArray()
        
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.siteId, dropDownArr: siteNameArr as? [String])
    }
    
    @IBAction func accountManagerBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "PVE_AssignUserDetails")
        let namesArray = array.value(forKey: "fullName") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.accountManager, dropDownArr: namesArray)
    }
    
    @IBAction func evaluatorBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "PVE_Evaluator")
        let namesArray = array.value(forKey: "fullName") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.evaluationDetails, dropDownArr: namesArray)
    }
    
    @IBAction func breedOfBirdsBtnAction(_ sender: UIButton) {
        
        let evaluationForId = getDraftValueForKey(key: "evaluationForId") as! Int
        let array = CoreDataHandlerPVE().fetchDetailsForBreedOfBirds(evaluationForId: NSNumber(value: evaluationForId), type: 1)
        
        let namesArray = array.value(forKey: "name") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.breedOfBirds, dropDownArr: namesArray)
    }
    
    @IBAction func breedOfBirdsFemaleBtnAction(_ sender: UIButton) {
        
        let evaluationForId = getDraftValueForKey(key: "evaluationForId") as! Int
        let array = CoreDataHandlerPVE().fetchDetailsForBreedOfBirds(evaluationForId: NSNumber(value: evaluationForId), type: 2)
        
        let namesArray = array.value(forKey: "name") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.breedOfBirdsFemale, dropDownArr: namesArray)
    }
    
    @IBAction func ageOfBirdsBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "PVE_AgeOfBirds")
        let namesArray = array.value(forKey: "age") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.ageOfBirds, dropDownArr: namesArray)
    }
    
    @IBAction func syncToWebBtnAction(_ sender: UIButton) {
        let errorMSg = "Are you sure, you want to sync this session data to web?"
        let alertController = UIAlertController(title: "PVE", message: errorMSg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            self.singleDataSync()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func singleDataSync(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: PVEDashboardViewController.self) {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "forceSync"),object: nil, userInfo:["id": currentTimeStamp]))
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }
    }
    @IBAction func housingBtnAction(_ sender: UIButton) {
        let array = CoreDataHandlerPVE().fetchDetailsFor(entityName: "PVE_Housing")
        let namesArray = array.value(forKey: "housingName") as! [String]
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.housing, dropDownArr: namesArray)
    }
    
    func setDropdrown(_ sender: UIButton, clickedField:String, dropDownArr:[String]?){
        
        if  dropDownArr!.count > 0 {
            self.dropDownVIewNew(arrayData: dropDownArr!, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) {  selectedVal,index  in
                self.tblView.reloadData()
                self.tblView.reloadInputViews()
            }
            self.dropHiddenAndShow()
        } else {
            print("test message")
        }
        
        let dataSavedInDB =  CoreDataHandlerPVE().fetchCurrentSessionInDB()
    }
    
    func reloadCellUI(cell:StartNewAssignmentCell)  {
        
        let dataSavedInDB = CoreDataHandlerPVE().fetchDraftForSyncId(type: "sync", syncId: currentTimeStamp)
        
        let arr = dataSavedInDB.value(forKey: "evaluationForId") as! NSArray
        let evaluationForId = arr[0] as! Int
        
        if evaluationForId == 4 {
            cell.breesOfBirdsTitleLbl.text = "Breed of Birds*"
            cell.breesOfBirdsSuperView.isHidden = true
        }
        else if evaluationForId == 5 {
            cell.breesOfBirdsTitleLbl.text = "Breed of Birds (Male)"
            cell.breesOfBirdsSuperView.isHidden = false
        }
        
        var viewHeight : CGFloat = 0
        let viewX : CGFloat = cell.frame.size.width - cell.cameraToggleSuperView.frame.size.width
        
        if evaluationForId == 4{
            
            self.assesssmentCellHeight = 435.0
            viewHeight = 170 + 60 + 10
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
            
        }
        if evaluationForId == 4 && getDraftValueForKey(key: "breedOfBirds") as? String == "Other" {
            
            self.assesssmentCellHeight = 475.0 + 5
            viewHeight = 170 + 65 + 45 + 5
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
        }
        
        if evaluationForId == 5 {
            
            viewHeight = 170
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
            
        }
        if evaluationForId == 5 && getDraftValueForKey(key: "breedOfBirds") as? String == "Other" {
            
            self.assesssmentCellHeight = 475.0 + 5
            viewHeight = 170 + 10
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
            
        }
        if evaluationForId == 5 && getDraftValueForKey(key: "breedOfBirds") as? String != "Other" {
            self.assesssmentCellHeight = 435.0
            viewHeight = 170 + 10
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
        }
        
        if evaluationForId == 5 && getDraftValueForKey(key: "breedOfBirdsFemale") as? String == "Other" {
            
            self.assesssmentCellHeight = 475.0 + 5
            viewHeight = 170 + 10
            let viewY : CGFloat = cell.frame.size.height - viewHeight
            
            cell.cameraToggleSuperView.frame = CGRect(x: viewX, y: viewY, width: cell.cameraToggleSuperView.frame.size.width, height: viewHeight)
            
        }
        
        
        self.setupOtherFields(cell: cell)
        
    }
    
    
    func setupOtherFields(cell:StartNewAssignmentCell) {
        
        cell.breesOfBirdsFemaleOtherSuperView.isHidden = true
        
        let dataSavedInDB = CoreDataHandlerPVE().fetchDraftForSyncId(type: "sync", syncId: currentTimeStamp)
        
        let arr = dataSavedInDB.value(forKey: "evaluationForId") as! NSArray
        let evaluationForId = arr[0] as! Int
        
        if evaluationForId == 4 && getDraftValueForKey(key: "breedOfBirds") as? String == "Other"  {
            cell.breesOfBirdsMaleOtherSuperView.isHidden = false
            
        }else if evaluationForId == 5 && getDraftValueForKey(key: "breedOfBirds") as? String == "Other"  {
            cell.breesOfBirdsMaleOtherSuperView.isHidden = false
        }else{
            cell.breesOfBirdsMaleOtherSuperView.isHidden = true
        }
        
        
        if evaluationForId == 5 && getDraftValueForKey(key: "breedOfBirdsFemale") as? String == "Other"  {
            cell.breesOfBirdsFemaleOtherSuperView.isHidden = false
        }else{
            cell.breesOfBirdsFemaleOtherSuperView.isHidden = true
        }
        
    }
    
    func getTodayDateSring() -> String {
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var DateInFormat = dateFormatter.string(from: todaysDate as Date)
        return DateInFormat
    }
    
    
    func setBorderBlueForCalender(btn:UIButton) {
        
        let superviewCurrent =  btn.superview
        for view in superviewCurrent!.subviews {
            if view.isKind(of:UIButton.self) {
                if view == btn{
                    view.setDropdownStartAsessmentView(imageName:"calendarIconPE")
                }
            }
        }
        
    }
    
    func setBorderBlue(btn:UIButton) {
        
        let superviewCurrent =  btn.superview
        for view in superviewCurrent!.subviews {
            if view.isKind(of:UIButton.self) {
                if view == btn{
                    view.setDropdownStartAsessmentView(imageName:"dd")
                }
            }
        }
        
    }
    
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        //checkValidation()
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.pveStoryboard, bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PVEViewFinalizeAssement") as! PVEViewFinalizeAssement
        vc.currentTimeStamp = currentTimeStamp
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Other Delegates -------------Date Picker Delegate------------------



extension PVEViewSNASession {
    
    private func setBorderRedForMandatoryFiels(forBtn:UIButton) {
        
        let superviewCurrent =  forBtn.superview
        for view in superviewCurrent!.subviews {
            if view.isKind(of:UIButton.self) {
                view.layer.borderColor = UIColor.red.cgColor
                view.layer.borderWidth = 2.0
            }
        }
    }
    
    private func setBorderBlackFiels(forBtn:UIButton) {
        
        let superviewCurrent =  forBtn.superview
        for view in superviewCurrent!.subviews {
            if view.isKind(of:UIButton.self) {
                view.layer.borderColor = UIColor.black.cgColor
                view.layer.borderWidth = 2.0
            }
        }
    }
}
