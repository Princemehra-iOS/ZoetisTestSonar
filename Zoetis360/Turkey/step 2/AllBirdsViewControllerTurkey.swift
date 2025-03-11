//
//  AllBirdsViewControllerTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 06/04/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit

class AllBirdsViewControllerTurkey:BaseViewController,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource,UITextFieldDelegate {
    
    // MARK: - VARIABLES
    var quickLinkArray  = NSMutableArray()
    var obsNameArray = NSMutableArray()
    var obsFiledArray = NSMutableArray()
    var observationArray = NSMutableArray()
    var birdArray = NSMutableArray()
    var categoryArray = NSMutableArray()
    var birdNo = Int()
    var formName = String()
    var  necId = Int()
    var index = Int()
    var ageValue = String()
    var obsArr = NSMutableArray()
    var storedOffsets = [Int: CGFloat]()
    var postingIdFromExistingNavigate = NSString()
    var dragger: TableViewDragger!
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var bgTableView: UITableView!
    @IBOutlet weak var lblForm: UILabel!
    @IBOutlet weak var lblHouseNo: UILabel!
    
    var BirdSex = NSArray ()
    var selectedSexValue: String = "N/A"
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        
        self.loadData()
        self.bgTableView.estimatedRowHeight = 100
        BirdSex = ["Male", "Female" , "N/A"]
        
        dragger = TableViewDragger(tableView: bgTableView)
        dragger.availableHorizontalScroll = false
        dragger.dataSource = self
        dragger.delegate = self
        dragger.alphaForCell = 0.7
    }
    
    // MARK: - METHOD & FUNCTIONS
    func loadData() {
        
        let farmName =  formName + " " + "[" + ageValue + "]"
        var farmName2 = String()
        let range = farmName.range(of: ".")
        if range != nil{
            var abc = String(farmName[range!.upperBound...]) as NSString
            farmName2 = String(index+1) + "." + " " + String(describing:abc)
        }
        
        lblForm.text = farmName2
        
        var dict = [String: AnyObject]()
        var i = Int()
        i = -1
        let farmWeight =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkeyWithFarmName(formName ,necropsyId:necId as NSNumber)
        if farmWeight.count > 0{
            let hNo = farmWeight.object(at: 0) as! CaptureNecropsyDataTurkey
            lblHouseNo.text = hNo.houseNo
        }
        let arr =  CoreDataHandlerTurkey().fetchCaptureWithFormNameNecSkeltonDataTurkey(farmName: formName, necID : necId as NSNumber)
        
        for  j in 0..<arr.count
        {
            if ((arr.object(at: j) as AnyObject).value(forKey: "quickLink") as AnyObject).int32Value == 1 {
                
                self.obsNameArray.add((arr.object(at: j) as AnyObject).value(forKey: "obsName")!)
                
                self.observationArray.add(arr.object(at: j))
                i = i + 1
                
                let obsName = (self.observationArray.object(at: i) as AnyObject).value(forKey: "obsName") as! String
                let matchObsName = self.obsNameArray.object(at: i) as! String
                
                if obsName == matchObsName
                {
                    dict[matchObsName] = arr.object(at: j) as AnyObject
                }
            }
        }
        
        let arrKeys =  [String] (dict.keys) as NSArray
        
        let sortedArrKeys = arrKeys.sortedArray(using: [NSSortDescriptor(key: "self", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]) as NSArray
        
        
        self.obsNameArray.removeAllObjects()
        
        for i in 0..<sortedArrKeys.count
        {
            let obsName = sortedArrKeys.object(at: i) as! String
            self.obsNameArray.add(obsName)
            let captureN = dict[obsName] as! CaptureNecropsyViewDataTurkey
            let noOfBird = self.birdNo
            let obsDictVal = NSMutableDictionary()
            
            for j in 0..<noOfBird {
                obsDictVal.setObject(captureN, forKey: j+1 as NSCopying)
            }
            
            obsArr.add(obsDictVal)
        }
        
        if obsArr.count > 0 {
            self.setTemperaryObsNameArray()
            
            self.bgTableView.reloadData()
        }
        else{
            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"No quicklink is selected. Please go to Settings and select quicklink.")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @objc func plusButtonClick (_ sender: UIButton){
        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {
            return
            
        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int
        
        if cellIndexPath?.row == nil{
            return
        }
        
        let obsName = self.obsNameArray.object(at: (cellIndexPath?.row)!)
        let formNameValue  = self.formName as String
        
        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray
        
        let noofBirdArrOnObs = NSMutableArray()
        
        for i in 0..<arr.count
        {
            noofBirdArrOnObs.add(i+1)
        }
        
        let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!
        
        let trimmed = captureNec.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let array = (trimmed.components(separatedBy: ",") as [String])
        
        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)
        
        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
        
        if c.obsPoint == 0
        {
            if Int(array[0]) != 0
            {
                cell.displayLabel.text = String(array[0])
                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[0])!, necId :necId as NSNumber)
            }
            else
            {
                cell.displayLabel.text = String(array[1])
                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[1])!, necId :necId as NSNumber)
            }
        }
        else
        {
            for  i in 0..<array.count
            {
                let lastElement = (Int(array.last!)! as Int)
                if lastElement == Int(array[i])!
                {
                    
                }
                else
                {
                    let value =  Int(array[i] as String)!
                    if  (value as NSNumber == c.obsPoint)
                    {
                        cell.displayLabel.text = String(array[i+1])
                        CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[i+1])!, necId :necId as NSNumber)
                        break
                    }
                }
            }
        }
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync : true)
        }
        else
        {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }
    
    @objc func minusButtonClick (_ sender: UIButton){
        
        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {
            
            return
        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int
        if cellIndexPath?.row == nil{
            return
        }
        let obsName = self.obsNameArray.object(at: (cellIndexPath?.row)!)
        let formNameValue  = self.formName as String
        
        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()
        
        for i in 0..<arr.count
        {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!
        
        let trimmed = captureNec.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let array = (trimmed.components(separatedBy: ",") as [String])
        
        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)
        
        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
        
        if fethchArr.count > 0 {
            if c.obsPoint == 0
            {
                
            }
            else
            {
                for  i in 0..<array.count
                {
                    
                    if Int(array[i]) == 1
                    {
                        
                    }
                    else
                    {
                        if c.obsPoint == 1
                        {
                            if Int(array[i]) == 0
                            {
                                cell.displayLabel.text = array[0]
                                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[0])!, necId :necId as NSNumber)
                                break
                            }
                        }
                        let value = Int(array[i])
                        if ((value! as NSNumber) == c.obsPoint)
                        {
                            cell.displayLabel.text = array[i-1]
                            CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[i-1])!, necId :necId as NSNumber)
                            break
                        }
                    }
                }
                
            }
            
        }
        if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync : true)
        }
        else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }
    
    @objc func switchClick(_ sender:UISwitch){
        
        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {
            return
        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int
        
        let formNameValue  = self.formName as String
        if cellIndexPath?.row == nil{
            return
        }
        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()
        
        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!
        
        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)
        
        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
        
        CoreDataHandlerTurkey().updateSwitchDataInCaptureSkeletaInDatabaseOnSwitchTurkey(formNameValue, birdNo: noOfBird as NSNumber, obsId: c.obsID!, obsVisibility: sender.isOn, necId : necId as NSNumber)
        
        cell.switchQuickLink.isOn = sender.isOn
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            
            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync : true)
        }
        else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }
    
    @objc func birdSexClick(_ sender:UIButton){
        
        guard let cell = getCellFromSender(sender) else {
            return
        }
        
        if  BirdSex.count > 0 {
            self.dropDownVIewNew(arrayData: BirdSex as? [String] ?? [String](), kWidth: cell.birdSexView.frame.width, kAnchor: cell.birdSexView, yheight: cell.birdSexView.bounds.height) { [unowned self] selectedVal, index  in
                cell.sexLabel.text = selectedVal
                selectedSexValue = selectedVal
                
                if selectedVal == "Female"
                {
                    selectedSexValue = "2"
                }
                else if selectedVal == "N/A"
                {
                    selectedSexValue = "0"
                }
                else
                {
                    selectedSexValue = "1"
                }
                
                let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
                let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
                let noOfBird =  cell.incrementBtnOutlet.tag as Int
                
                let formNameValue  = self.formName as String
                if cellIndexPath?.row == nil{
                    return
                }
                
                guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
                    return
                }
                let arr = d.allKeys as NSArray
                let noofBirdArrOnObs = NSMutableArray()
                
                for i in 0..<arr.count
                {
                    noofBirdArrOnObs.add(i+1)
                }
                let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!
                
                let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)
                
                let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
                
                CoreDataHandlerTurkey().updateBirdSexDataInCaptureSkeletaInDatabaseTurkey(formNameValue, birdNo: noOfBird as NSNumber, obsId: c.obsID!, BirdSex: selectedSexValue, necId : necId as NSNumber)
                
                if UserDefaults.standard.bool(forKey: "Unlinked") == true{
                    
                    CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync : true)
                }
                else {
                    CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
                }
                
            }
            self.dropHiddenAndShow()
        }
        
    }
    
    
    // MARK: - DROP DOWN HIDDEN AND SHOW
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    func getCellFromSender(_ sender: UIView) -> obsFieldCollectionViewCell? {
        var view: UIView? = sender
        
        while view != nil {
            if let cell = view as? obsFieldCollectionViewCell {
                return cell
            }
            view = view?.superview
        }
        
        return nil
    }
    
    
    // MARK: - IBACTION
    @IBAction func cancelBtn(_ sender: AnyObject) {
        navigateRoot()
    }
    
    @IBAction func doneButton(_ sender: AnyObject) {
        navigateRoot()
    }
    
    func navigateRoot()  {
        let isQuickLink : Bool = true
        
        UserDefaults.standard.set(isQuickLink, forKey: "isQuickLink")
        UserDefaults.standard.synchronize()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - TABLE VIEW DATA SOURCE AND DELEGATES
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.obsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? allBirdsTableViewCell
        
        if cell == nil {
            cell = allBirdsTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 180, height: 100)
        
        cell!.backgroundColor = UIColor.white
        return cell!
    }
    
    func tableView(_ tableView: UITableView,willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? allBirdsTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell as? allBirdsTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    // MARK: - COLLECTION VIEW DATA SOURCE AND DELEGATES
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.obsArr[section] as AnyObject).count + 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "obsName", for: indexPath) as! ObsNameCollectionViewCell
            cell.obsNameLabel.text = self.obsNameArray.object(at: collectionView.tag) as? String
            return cell
        }
        
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "obsField", for: indexPath) as! obsFieldCollectionViewCell
            cell.backgroundColor = UIColor.white
            let d  = self.obsArr.object(at: collectionView.tag) as! NSDictionary
            let arr = d.allKeys as NSArray
            let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: arr.object(at: indexPath.row - 1)) as? CaptureNecropsyViewDataTurkey)!
            
            let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(indexPath.row as NSNumber, farmname: captureNec.formName!, obsId: captureNec.obsID!, necId: necId as NSNumber)
            
            let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
            cell.birdSexView.isHidden = true
            cell.sexLabel.isHidden = true
            cell.birdSexBtn.isHidden = true
            
            if c.measure == "Y,N"
            {
                cell.switchQuickLink.alpha = 1
                cell.actualTexField?.alpha = 0
                cell.incrementBtnOutlet.alpha = 0
                cell.minusBtnOutlet.alpha = 0
                cell.displayLabel.alpha = 0
                
                if c.objsVisibilty == 1
                {
                    cell.switchQuickLink.isOn = true
                }
                else
                {
                    cell.switchQuickLink.isOn = false
                }
                
                
            }
            else if c.measure == "Actual"
            {
                
                let farmWeight =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkeyWithFarmName(captureNec.formName! ,necropsyId:necId as NSNumber)
                let arrdata = farmWeight.object(at: 0) as! CaptureNecropsyDataTurkey
                let result: Float = Float(arrdata.farmWeight!)! / Float(arrdata.noOfBirds!)!
                cell.actualTexField?.delegate = self as UITextFieldDelegate
                cell.switchQuickLink.alpha = 0
                cell.actualTexField?.alpha = 1
                cell.incrementBtnOutlet.alpha = 0
                cell.minusBtnOutlet.alpha = 0
                cell.displayLabel.alpha = 0
                cell.actualTexField?.tag = indexPath.row
                cell.actualTexField?.text = String(describing: result)
                cell.actualTexField?.isUserInteractionEnabled = false
            }
            else if c.measure == "F,M" {
                
                cell.switchQuickLink.alpha = 0
                cell.actualTexField?.alpha = 0
                cell.incrementBtnOutlet.alpha = 0
                cell.minusBtnOutlet.alpha = 0
                cell.displayLabel.alpha = 0
                cell.birdSexView.isHidden = false
                cell.sexLabel.isHidden = false
                cell.birdSexBtn.isHidden = false
                
                cell.birdSexView.alpha = 1
                cell.sexLabel.alpha = 1
                cell.birdSexBtn.alpha = 1
                cell.birdSexView.layer.borderColor = UIColor.black.cgColor
                cell.birdSexView.layer.borderWidth = 1.0
                
                // Set rounded corners
                cell.birdSexView.layer.cornerRadius = 5.0
                cell.birdSexView.clipsToBounds = true
                if c.actualText == "1.00" || c.actualText == "1"  || c.actualText == "1.0"
                {
                    cell.sexLabel.text = "Male"
                    
                }
                else if c.actualText == "2" || c.actualText == "2.00"  || c.actualText == "2.0"
                {
                    cell.sexLabel.text = "Female"
                    
                }
                else
                {
                    cell.sexLabel.text = "N/A"
                }
                
                
            }
            else{
                cell.switchQuickLink.alpha = 0
                cell.actualTexField?.alpha = 0
                cell.incrementBtnOutlet.alpha = 1
                cell.minusBtnOutlet.alpha = 1
                cell.displayLabel.alpha = 1
                cell.displayLabel.text = String(c.obsPoint!.int32Value)
                cell.actualTexField?.isUserInteractionEnabled = false
            }
            
            
            cell.lblBirdSize.text = String(indexPath.row)
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.black.cgColor
            
            cell.incrementBtnOutlet.addTarget(self, action: #selector(AllBirdsViewControllerTurkey.plusButtonClick(_:)), for: .touchUpInside)
            cell.incrementBtnOutlet.tag = indexPath.row
            cell.minusBtnOutlet.addTarget(self, action: #selector(AllBirdsViewControllerTurkey.minusButtonClick(_:)), for: .touchUpInside)
            cell.minusBtnOutlet.tag = indexPath.row
            cell.switchQuickLink .addTarget(self, action: #selector(AllBirdsViewControllerTurkey.switchClick(_:)) , for:.valueChanged)
            cell.switchQuickLink.tag = indexPath.row
            
            cell.birdSexBtn.addTarget(self, action: #selector(AllBirdsViewControllerTurkey.birdSexClick(_:)), for: .touchUpInside)
            cell.birdSexBtn.tag = indexPath.row
            
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        appDelegate.testFuntion()
    }
    
    // MARK: - TEXTFIELD DELEGATES
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        let rowIndex :Int = textField.tag
        let cell = textField.superview!.superview as! obsFieldCollectionViewCell
        let pointInTable: CGPoint = textField.convert(textField.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =   cell.actualTexField?.tag
        
        let formNameValue  = self.formName as String
        if cellIndexPath?.row == nil{
            return
        }
        
        let d  = self.obsArr.object(at: (cellIndexPath?.row)!) as! NSDictionary
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()
        
        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec :  CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!
        
        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird! as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)
        
        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey
        
        CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnActualTurkey(formName , formName: formNameValue, birdNo: noOfBird! as NSNumber, obsId: captureNec.obsID!, actualName: textField.text!, necId: necId as NSNumber)
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            
            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync : true)
        } else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (string == "1" || string == "2" || string == "3" || string == "4" || string == "5" || string == "6" || string == "7" || string == "8" || string == "9" || string == "0" || string == "." || isBackSpace == -92 ){
            var _ : Bool!
            if(self.checkCharacter(string, textField: textField)){
                let cell = textField.superview!.superview as! obsFieldCollectionViewCell
                if textField == cell.actualTexField {
                    
                    var computationString: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let length = computationString.count
                    if (length > 5) {
                        return false;
                    }
                }
            }
            return true
        }
        return false
    }
    
    func checkCharacter( _ inputChar : String , textField : UITextField ) -> Bool {
        
        let newCharacters = CharacterSet(charactersIn: inputChar)
        let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
        if boolIsNumber == true {
            return true
            
        } else {
            
            if inputChar == "." {
                let countdots = textField.text!.components(separatedBy: ".").count - 1
                if countdots == 0 {
                    return true
                    
                } else {
                    if countdots > 0 && inputChar == "." {
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - EXTENSION
extension AllBirdsViewControllerTurkey {
    //Checking in sequence of birds list is changed previously by swaping cells
    func setTemperaryObsNameArray() {
        let savedMovedBirdsSequences = CoreDataHandlerTurkey().fetchAllBirdsSwapedIndexes()
        if savedMovedBirdsSequences.count > 0 {
            let savedBirdNameArray = NSMutableArray()
            for (_, object) in savedMovedBirdsSequences.enumerated() {
                savedBirdNameArray.add(object.birdName ?? "")
            }
            for (index, bird) in savedBirdNameArray.enumerated() {
                for (birdIndex, object) in obsArr.enumerated() {
                    let obsName = ((object as! NSDictionary).allValues[0] as! CaptureNecropsyViewDataTurkey).obsName
                    if obsName == bird as? String {
                        if index < self.obsArr.count {
                            let movedOBS = self.obsArr[birdIndex]
                            self.obsArr.removeObject(at: birdIndex)
                            self.obsArr.insert(movedOBS, at: index)
                        }
                    }
                }
            }
            
            for (index, bird) in savedBirdNameArray.enumerated() {
                for (birdIndex, obsBird) in obsNameArray.enumerated() {
                    if let obsName = obsBird as? String {
                        if obsName == bird as? String {
                            if index < self.obsNameArray.count {
                                let movedOBSBird = self.obsNameArray[birdIndex]
                                self.obsNameArray.removeObject(at: birdIndex)
                                self.obsNameArray.insert(movedOBSBird, at: index)
                            }
                        }
                    }
                    
                }
            }
        }
        else {
            
            struct QuickIndexObject {
                var quickIndex = 0
                var obsName = ""
            }
            
            var arrOfIndex = [QuickIndexObject]()
            
            for iteam in self.obsArr {
                
                var catName = ((iteam as! NSDictionary).allValues[0] as? CaptureNecropsyViewDataTurkey)?.catName
                let obsName = ((iteam as! NSDictionary).allValues[0] as? CaptureNecropsyViewDataTurkey)?.obsName
                
                if catName == "skeltaMuscular" {
                    catName = "SkeletaTurkey"
                }
                else if catName == "GITract" {
                    catName = "GITractTurkey"
                }
                else if catName == "Coccidiosis" {
                    catName = "CoccidiosisTurkey"
                }
                else if catName == "Resp" {
                    catName = "RespiratoryTurkey"
                }
                else if catName == "Immune" {
                    catName = "ImmuneTurkey"
                }
                
                let fetchdata =  CoreDataHandler().fetchAllSeetingByObs(entityName: catName!, obsName: obsName!)
                switch catName {
                case "SkeletaTurkey":
                    let objTable  = fetchdata.object(at: 0) as! SkeletaTurkey //: Skeleta = (fetchdata as? Skeleta)!
                    
                    if let quickIndex = objTable.quicklinkIndex as? Int {
                        if quickIndex > 0 {
                            let quickIndexObject = QuickIndexObject(quickIndex: quickIndex, obsName: obsName!)
                            arrOfIndex.append(quickIndexObject)
                        }
                    }
                    
                case "CoccidiosisTurkey":
                    let objTable  = fetchdata.object(at: 0) as! CoccidiosisTurkey //: Skeleta = (fetchdata as? Skeleta)!
                    
                    if let quickIndex = objTable.quicklinkIndex as? Int {
                        if quickIndex > 0 {
                            let quickIndexObject = QuickIndexObject(quickIndex: quickIndex, obsName: obsName!)
                            arrOfIndex.append(quickIndexObject)
                        }
                    }
                case "GITractTurkey":
                    let objTable  = fetchdata.object(at: 0) as! GITractTurkey //: Skeleta = (fetchdata as? Skeleta)!
                    
                    if let quickIndex = objTable.quicklinkIndex as? Int {
                        if quickIndex > 0 {
                            let quickIndexObject = QuickIndexObject(quickIndex: quickIndex, obsName: obsName!)
                            arrOfIndex.append(quickIndexObject)
                        }
                    }
                case "RespiratoryTurkey":
                    let objTable  = fetchdata.object(at: 0) as! RespiratoryTurkey //: Skeleta = (fetchdata as? Skeleta)!
                    
                    if let quickIndex = objTable.quicklinkIndex as? Int {
                        if quickIndex > 0 {
                            let quickIndexObject = QuickIndexObject(quickIndex: quickIndex, obsName: obsName!)
                            arrOfIndex.append(quickIndexObject)
                        }
                    }
                case "ImmuneTurkey":
                    let objTable  = fetchdata.object(at: 0) as! ImmuneTurkey //: Skeleta = (fetchdata as? Skeleta)!
                    
                    if let quickIndex = objTable.quicklinkIndex as? Int {
                        if quickIndex > 0 {
                            let quickIndexObject = QuickIndexObject(quickIndex: quickIndex, obsName: obsName!)
                            arrOfIndex.append(quickIndexObject)
                        }
                    }
                    
                default:
                    break
                }
            }
            
            for (_, quickIndexObject) in arrOfIndex.enumerated() {
                for (birdIndex, object) in obsArr.enumerated() {
                    let obsName = ((object as! NSDictionary).allValues[0] as! CaptureNecropsyViewDataTurkey).obsName
                    if quickIndexObject.quickIndex < self.obsArr.count {
                        if obsName == quickIndexObject.obsName {
                            let movedOBS = self.obsArr[birdIndex]
                            self.obsArr.removeObject(at: birdIndex)
                            self.obsArr.insert(movedOBS, at: quickIndexObject.quickIndex)
                        }
                    }
                }
            }
            
            for (_, object) in arrOfIndex.enumerated() {
                for (birdIndex, obsBird) in obsNameArray.enumerated() {
                    if let obsName = obsBird as? String {
                        if object.quickIndex < self.obsNameArray.count {
                            if obsName == object.obsName {
                                let movedOBSBird = self.obsNameArray[birdIndex]
                                self.obsNameArray.removeObject(at: birdIndex)
                                self.obsNameArray.insert(movedOBSBird, at: object.quickIndex)
                            }
                        }
                        
                    }
                }
            }
            
        }
        
    }
    
    
    func saveBirdsSequencesInDB() {
        CoreDataHandlerTurkey().deleteAllBirdsSwapedIndexes()
        for (index, birdName) in self.obsNameArray.enumerated() {
            if let name = birdName as? String {
                CoreDataHandlerTurkey().saveAllBirdsSwapedIndexes(name, index: index)
            }
        }
    }
}

// MARK: - EXTENSION
extension AllBirdsViewControllerTurkey: TableViewDraggerDataSource, TableViewDraggerDelegate {
    func dragger(_ dragger: TableViewDragger, moveDraggingAt indexPath: IndexPath, newIndexPath: IndexPath) -> Bool {
        if indexPath != newIndexPath {
            let movedOBS = self.obsArr[indexPath.row]
            self.obsArr.removeObject(at: indexPath.row)
            self.obsArr.insert(movedOBS, at: newIndexPath.row)
            
            let movedBirdName = self.obsNameArray[indexPath.row]
            self.obsNameArray.removeObject(at: indexPath.row)
            self.obsNameArray.insert(movedBirdName, at: newIndexPath.row)
            
            self.bgTableView.moveRow(at: indexPath, to: newIndexPath)
            
            if let obsId = ((movedOBS as! NSDictionary).allValues[0] as? CaptureNecropsyViewDataTurkey)?.obsName,
               var catName = ((movedOBS as! NSDictionary).allValues[0] as? CaptureNecropsyViewDataTurkey)?.catName {
                if catName == "skeltaMuscular" {
                    catName = "SkeletaTurkey"
                }
                else if catName == "GITract" {
                    catName = "GITractTurkey"
                }
                else if catName == "Coccidiosis" {
                    catName = "CoccidiosisTurkey"
                }
                else if catName == "Resp" {
                    catName = "RespiratoryTurkey"
                }
                else if catName == "Immune" {
                    catName = "ImmuneTurkey"
                }
                CoreDataHandlerTurkey().updateSettingDataQuickIndex(obsId, obsId: 0, quicklinkIndex: newIndexPath.row, entityName: catName)
            }
            
            self.saveBirdsSequencesInDB()
        }
        return true
    }
    
    func dragger(_ dragger: TableViewDragger, shouldDragAt indexPath: IndexPath) -> Bool {
        return true
    }
}
