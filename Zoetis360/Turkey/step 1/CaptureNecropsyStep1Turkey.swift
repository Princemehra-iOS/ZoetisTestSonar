//
//  CaptureNecropsyStep1Turkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 15/03/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import CoreData
import Reachability

class CaptureNecropsyStep1Turkey: UIViewController,UITextFieldDelegate {
    
    var droperTableView  =  UITableView ()
    
    @IBOutlet weak var feedProgramDisplayLabel: UILabel!
    // MARK: - Label Outlet
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postingDateLbl: UILabel!
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var complexLbl: UILabel!
    @IBOutlet weak var noOfBirdsLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var houseNoLBL: UILabel!
    @IBOutlet weak var ageUperBtnOutlet: UIButton!
    @IBOutlet weak var btnAddLablel: UILabel!
    @IBOutlet weak var feedProgramDropDwnIcon: UIImageView!
    // MARK: - Button Outlet
    @IBOutlet weak var sexLightHenOutlet: UIButton!
    @IBOutlet weak var sexHeavyHenOutlet: UIButton!
    @IBOutlet weak var sexTomsOutlet: UIButton!
    @IBOutlet weak var breedNicholasOutlet: UIButton!
    @IBOutlet weak var breedHybridOutlet: UIButton!
    @IBOutlet weak var breedMixedOutlet: UIButton!
    @IBOutlet weak var abfBtnOutlet: UIButton!
    @IBOutlet weak var feedProgramBtn: UIButton!
    @IBOutlet weak var sickBtnOutlet: UIButton!
    
    @IBOutlet weak var genLbl: UILabel!
    
    @IBOutlet weak var genBtn: UIButton!
    var geneId = Int()
    
    var strMsgforDelete = String()
    var countFarmId = Int()
    
    // MARK: - TextField Outlet
    @IBOutlet weak var farmNameTextfield: UITextField!
    @IBOutlet weak var flockIdTextField: UITextField!
    var valueStore = Bool()
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    let buttonbg = UIButton ()
    var feedProgramArray = NSArray ()
    var farmWeightArray = NSArray ()
    let buttonbg1 = UIButton ()
    var abfArray = NSArray ()
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var uprView: UIView!
    @IBOutlet weak var abfLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var myPickerView = UIPickerView()
    var pickerIndex = Int()
    var btnTag = Int()
    var isComesFromUnlikedWithPostind = Bool()
    var trimmedString = String()
    var timeStampString = String()
    var birdIndex = Int()
    @IBOutlet weak var feedProgramTextLbl: UILabel!
    var count = Int()
    var necId = Int()
    var feeId = Int()
    var lngId = NSInteger()
    var hideDropDwnB = true
    var navigatefronInlinked = String()
    var actualTimestamp = String()
    var complexTypeFetchArray = NSMutableArray()
    var complexTypeFetchArray1 = NSMutableArray()
    var autoSerchTable = UITableView ()
    var autocompleteUrls = NSMutableArray ()
    var autocompleteUrls2 = NSMutableArray ()
    var autocompleteUrls1 = NSMutableArray ()
    var fetchcomplexArray = NSArray ()
    var fetchcomplexArray1 = NSArray ()
    var buttonDroper = UIButton ()
    var existingArray = NSMutableArray()
    var fetchcustRep = NSArray ()
    let cellReuseIdentifier = "cell"
    var HouseNoArr = NSArray ()
    var AgeOp = NSArray ()
    var NoOFbirds = NSArray ()
    var postingId = Int()
    var captureNecropsy = [NSManagedObject]()
    var houseNO = Int()
    var age = Int()
    var noOfBirdscount = Int()
    var asb = Bool()
    var breedString = String()
    var sexString = String()
    var butttnTag1 = 0
    var indexOfSelectedPerson = Int()
    var birdArray: [BirdSizePostingTurkey]  = []
    var metricArray: [BirdSizePostingTurkey]  = []
    var butttnTag = Int()
    var GenerationTypeArr  = NSArray()
    var bursaSelectedIndex :IndexPath?
    @IBOutlet weak var farmWeightLbl: UILabel!
    @IBOutlet weak var farmWeightTextField: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var houseNoTextFld: UITextField!
    
    // MARK: View Did Load
    
    let buttonEdit: UIButton = UIButton()
    
    let editView = UIView(frame:CGRect(x: 250, y: 130, width: 500, height: 400))
    let titleView = UIView(frame:CGRect(x: 0, y: 0, width: 500, height: 50))
    let nameLabel = UILabel(frame:CGRect(x: 42, y: 43, width: 300, height: 50))
    let titleLabel = UILabel(frame:CGRect(x: 182, y: 0, width: 400, height: 50))
    let ageLabel = UILabel(frame:CGRect(x: 42, y: 132, width: 100, height: 50))
    let nameText = UITextField(frame:CGRect(x: 40, y: 88, width: 280, height: 50))
    let ageButton = UIButton(frame:CGRect(x: 43, y: 174, width: 100, height: 50))
    let submitButton = UIButton(frame:CGRect(x: 30, y: 345, width: 175, height: 40))
    let cancelButton = UIButton(frame:CGRect(x: 290, y: 345, width: 175, height: 40))
    let paddingView = UIView(frame: CGRect(x:0 ,y: 0,width: 15,height:50))
    let paddingView1 = UIView(frame: CGRect(x:0 ,y: 0,width: 15,height:50))
    let feedLabel = UILabel(frame:CGRect(x: 200, y: 132, width: 370, height: 50))
    let farmWeightText = UITextField(frame:CGRect(x: 200, y: 174, width: 260, height: 50))
    let feedButton = UIButton(frame:CGRect(x: 40, y:262, width: 420, height: 50))
    let targetWeightLbl = UILabel(frame:CGRect(x: 42, y: 219, width: 200, height: 50))
    var buttonbgNew2 = UIButton()
    
    // New Addition House No
    let paddingViewHouseTurkey = UIView(frame: CGRect(x:0 ,y: 0,width: 15,height:50))
    let houseLabelTurkey = UILabel(frame:CGRect(x: 345, y: 43, width: 120, height: 50))
    let houseNoTxtFldTurkey = UITextField(frame:CGRect(x: 345, y: 88, width: 115, height: 50))
    var strHouseNumberTurkey = String()
    var farmArray = NSMutableArray ()
    var strfarmName  = String()
    var strFeddUpdate = String()
    var oldFarmName = NSString()
    var strFarmNameFeedId = String()
    var strfarmNameArray = NSArray()
    var strFeedCheck = String()
    var str = String()
    var feedIdUpdate = NSNumber()
    
    var editfeed = String()
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableView.automaticDimension
        
        
        farmWeightTextField.delegate = self
        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        farmWeightTextField.leftView = cusPaddingView
        farmWeightTextField.leftViewMode = .always
        breedString = "N"
        sexString = "L"
        
        NoOFbirds = ["1", "2", "3", "4", "5", "6", "7","8",  "9", "10"]
        AgeOp = ["1", "2", "3", "4", "5", "6", "7","8",  "9", "10","11", "12", "13", "14", "15", "16", "17","18","19", "20","21", "22", "23", "24", "25", "26", "27","28",  "29", "30","31", "32", "33", "34", "35", "36", "37","38",  "39", "40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80"]
        HouseNoArr = ["1", "2", "3", "4", "5", "6", "7","8",  "9", "10","11", "12", "13", "14", "15", "16", "17","18",  "19", "20","21", "22", "23", "24", "25", "26", "27","28",  "29", "30","31", "32", "33", "34", "35", "36", "37","38",  "39", "40","41","42","43","44","45","46","47","48","49","50"]
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
            
            postingId = 0
            feedProgramBtn.isUserInteractionEnabled = false
            feedProgramBtn.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.1)
            feedProgramDropDwnIcon.isHidden = true
            customerLbl.isHidden = true
            customerLbl.isHidden = true
            feedProgramDisplayLabel.text = ""
            abfLbl.text = "- Select -"
            feedProgramTextLbl.text = "Feed Program"
            
        }  else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
            feedProgramBtn.isUserInteractionEnabled = true
            customerLbl.isHidden = false
            if lngId == 5 {
                feedProgramTextLbl.text = "Programa de alimentación *"
            }
            if lngId == 1000{
                feedProgramTextLbl.text = NSLocalizedString("Feed Program * :", comment: "")
            }
            else {
                feedProgramTextLbl.text = "ad *"
            }
            feedProgramDropDwnIcon.isHidden = false
            customerLbl.isHidden = false
            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
            abfLbl.text = NSLocalizedString("- Select -", comment: "")
            abfLbl.text = "- Select -"
            feedProgramTextLbl.text = "Feed Program *"
            
        }
        flockIdTextField.tag = 11
        farmWeightTextField.tag = 12
        houseNoTextFld.tag = 18
        
        genLbl.text = "Commercial"
        geneId =  1
        
        ageLbl.text = ""
        farmNameTextfield.text = ""
        farmWeightTextField.text = ""
        flockIdTextField.text = ""
        houseNoTextFld.text = "1"
        noOfBirdsLbl.text = "5"
        flockIdTextField.keyboardType = .numberPad
        farmWeightTextField.keyboardType = .numberPad
        houseNoTextFld.keyboardType = .numberPad
        
        postingDateLbl.text = UserDefaults.standard.value(forKey: "date") as? String
        complexLbl.text = UserDefaults.standard.value(forKey: "complex") as? String
        customerLbl.text = UserDefaults.standard.value(forKey: "custmer") as? String
        tblView.delegate = self
        tblView.dataSource = self
        feedProgramBtn.layer.borderWidth = 1
        feedProgramBtn.layer.cornerRadius = 3.5
        feedProgramBtn.layer.borderColor = UIColor.black.cgColor
        farmNameTextfield.layer.borderWidth = 1
        farmNameTextfield.layer.cornerRadius = 1
        farmNameTextfield.layer.borderColor = UIColor.black.cgColor
        farmWeightTextField.layer.borderWidth = 1
        farmWeightTextField.layer.cornerRadius = 1
        farmWeightTextField.layer.borderColor = UIColor.black.cgColor
        farmWeightTextField.delegate = self
        farmNameTextfield.delegate = self
        flockIdTextField.delegate = self
        flockIdTextField.layer.borderWidth = 1
        flockIdTextField.layer.borderColor = UIColor.black.cgColor
        feedProgramBtn.layer.borderWidth = 1
        feedProgramBtn.layer.cornerRadius = 3.5
        feedProgramBtn.layer.borderColor = UIColor.black.cgColor
        abfBtnOutlet.layer.borderWidth = 1
        abfBtnOutlet.layer.cornerRadius = 3.5
        abfBtnOutlet.layer.borderColor = UIColor.black.cgColor
        
        houseNoTextFld.layer.borderWidth = 1
        houseNoTextFld.layer.cornerRadius = 1
        houseNoTextFld.layer.borderColor = UIColor.black.cgColor
        houseNoTextFld.delegate = self
        houseNoTextFld.keyboardType = .numberPad
        
        genBtn.layer.borderWidth = 1
        genBtn.layer.cornerRadius = 3.5
        genBtn.layer.borderColor = UIColor.black.cgColor
        
        
        spacingTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        birdIndex = UserDefaults.standard.integer(forKey: "birdIndex")
        valueStore = false
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
            abfLbl.text = NSLocalizedString("- Select -", comment: "")
        }
        if lngId == 5 {
            feedProgramTextLbl.text = "Programa de alimentación"
            btnAddLablel.text = "Añadir"
        }
        if lngId == 1000{
            // doubted case here please check for the secound label
            feedProgramTextLbl.text = NSLocalizedString("Feed Program :", comment: "")
            btnAddLablel.text = "Añadir"
        }
        
        else {
            print("test message")
        }
        
        userNameLbl.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        
        spacingTextField()
        let nec =  UserDefaults.standard.bool(forKey: "nec")
        if nec == false {
            let neciIdStep = UserDefaults.standard.integer(forKey: "necId")
            self.captureNecropsy =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(neciIdStep  as NSNumber) as! [NSManagedObject]
        }
        buttonDroper.frame = CGRect(x:0,y: 0,width: 1024,height: 768)
        buttonDroper.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonDroper)
        autoSerchTable.delegate = self
        autoSerchTable.dataSource = self
        autoSerchTable.delegate = self
        autoSerchTable.layer.cornerRadius = 7
        autoSerchTable.layer.borderWidth = 1
        autoSerchTable.layer.borderColor = UIColor.black.cgColor
        self.autoSerchTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        buttonDroper .addSubview(autoSerchTable)
        buttonDroper.alpha = 0
        if self.captureNecropsy.count<0 {
            count = 0
        }
        tblView.reloadData()
        
        let allBireType = CoreDataHandlerTurkey().fetchBirdSizeTurkey()
        if(birdArray.count == 0) {
            
            for dict in allBireType {
                if (dict as AnyObject).value(forKey: "scaleType") as! String == "Imperial"{
                    birdArray.append(dict as! BirdSizePostingTurkey)
                    
                }
                else{
                    metricArray.append(dict as! BirdSizePostingTurkey)
                    
                }
            }
        }
        
        if birdIndex == 0 {
            
            farmWeightLbl.text = "(lbs)"
            
        } else if birdIndex == 1 {
            
            farmWeightLbl.text = "(Kgs)"
        }
        
        farmNameTextfield.layer.borderColor = UIColor.black.cgColor
        farmWeightTextField.layer.borderColor = UIColor.black.cgColor
        feedProgramBtn.layer.borderColor = UIColor.black.cgColor
        ageUperBtnOutlet.setImage(UIImage(named: "dialer01"), for: .normal)
        
        sickBtnOutlet.layer.borderWidth = 1
        sickBtnOutlet.layer.borderColor = UIColor.black.cgColor
    }
    // MARK: - Button Action
    func removeDuplicates(array: NSMutableArray) -> NSMutableArray {
        var encountered = Set<String>()
        let result = NSMutableArray()
        for value in array {
            if encountered.contains(value as! String) {
            }
            else {
                // Add value to the set.
                encountered.insert(value as! String)
                // ... Append the value.
                result.add(value as! String)
            }
        }
        return result
    }
    
    func removeDuplicatesOnArr(array: NSArray) -> NSArray {
        var encountered = Set<String>()
        let result = NSMutableArray()
        for value in array {
            if encountered.contains(value as! String) {
            }
            else {
                encountered.insert(value as! String)
                result.add(value as! String)
            }
        }
        var arra = NSArray()
        arra = result.mutableCopy()  as! NSArray
        return arra
    }
    
    @objc func buttonPressedDroper() {
        
        buttonDroper.alpha = 0
    }
    
    @IBAction func bckBtnAction(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func abfBtnAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        btnnTag = 1
        abfArray = ["Antibiotic free","Conventional"]
        self.tableViewpop()
        droperTableView.frame = CGRect(x: 175,y: 337,width: 200,height: 100)
        droperTableView.reloadData()
        autoSerchTable.alpha = 0
    }
    
    @IBAction func genBtnAction(_ sender: Any) {
        
        btnnTag = 3
        autoSerchTable.alpha = 0
        GenerationTypeArr = CoreDataHandler().fetchGenerationType()
        tableViewpop()
        droperTableView.frame = CGRect(x: 175,y: 397,width: 200,height: 100)
        droperTableView.reloadData()
    }
    
    @IBAction func feedProgramAction(_ sender: UIButton) {
        self.view.endEditing(true)        
        btnnTag = 2
        do {
            farmNameTextfield.resignFirstResponder()
            flockIdTextField.resignFirstResponder()
            feedProgramBtn.layer.borderColor = UIColor.black.cgColor
            if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
                
            } else {
                self.necId = UserDefaults.standard.integer(forKey: "postingId")
            }
            feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(self.necId as NSNumber)
            self.tableViewpop()
            droperTableView.frame = CGRect(x: 175,y: 285,width: 200,height: 100)
            droperTableView.reloadData()
            buttonDroper.alpha = 0
            autoSerchTable.alpha = 0
            
        } catch {
            
        }
    }
    
    @IBAction func noOfBirdsAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        myPickerView.frame = CGRect(x:628,y: 257,width: 100,height: 120)
        pickerView()
        btnTag = 2
        
        if(noOfBirdsLbl.text == ""){
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            
        } else {
            for i in 0..<NoOFbirds.count{
                
                if (noOfBirdsLbl.text! == NoOFbirds[i] as! String){
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        myPickerView.reloadInputViews()
    }
    
    func pickerView (){
        
        buttonbg.frame = CGRect(x:0,y: 0,width: 1024,height: 768)
        buttonbg.addTarget(self, action: #selector(CaptureNecropsyStep1Turkey.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg)
        myPickerView.layer.borderWidth = 1
        myPickerView.layer.cornerRadius = 5
        myPickerView.layer.borderColor = UIColor.clear.cgColor
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.backgroundColor = UIColor.white
        buttonbg.addSubview(myPickerView)
    }
    
    @objc func buttonPressed1() {
        
        self.view.endEditing(true)
        buttonbg.removeFromSuperview()
    }
    
    @IBAction func houseNoAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        btnTag = 0
        myPickerView.frame = CGRect(x:628,y: 153,width: 100,height: 120)
        pickerView()
        
        if(houseNoLBL.text == ""){
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            
        } else {
            for i in 0..<HouseNoArr.count{
                
                if (houseNoLBL.text! == HouseNoArr[i] as! String){
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        myPickerView.reloadInputViews()
    }
    
    @IBAction func sickBtnAction(_ sender: UIButton) {
        
        if (sender.tag == 103) {
            
            sickBtnOutlet.isSelected = !sickBtnOutlet.isSelected
            if  sickBtnOutlet.isSelected {
                sickBtnOutlet.isSelected = true
                sender.setImage(UIImage(named: "Check_")!, for: UIControl.State())
                asb = true
            } else {
                
                sickBtnOutlet.setImage(nil, for: UIControl.State())
                sickBtnOutlet.setImage(UIImage(named: "Uncheck_")!, for: UIControl.State())
                asb = false
            }
        } else {
            
        }
    }
    
    @IBAction func ageBtnAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        btnTag = 1
        myPickerView.frame = CGRect(x:628,y: 205,width: 100,height: 120)
        pickerView()
        
        if(ageLbl.text == ""){
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            
        } else {
            var pickerIndex = Int()
            
            for i in 0..<AgeOp.count{
                
                if (ageLbl.text! == AgeOp[i] as! String){
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        myPickerView.reloadInputViews()
        
        ageUperBtnOutlet.setImage(UIImage(named: "dialer01"), for: .normal)
    }
    
    @IBAction func uperViewTab(_ sender: Any) {
        uprView.endEditing(true)
    }
    @IBAction func innerTabView(_ sender: Any) {
        innerView.endEditing(true)
    }
    var countFarm = Int()
    @IBAction func addMoreAction(_ sender: UIButton) {
        
        countFarm =  (farmNameTextfield.text?.count)!
        
        if farmWeightTextField.text?.count == 1 && farmWeightTextField.text == "."  {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
            farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            farmWeightTextField.text = nil
        }
        else if farmWeightTextField.text == ""
        {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
            farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            farmWeightTextField.text = nil
        }
        
        else  {
           trimmedString = farmNameTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
                
                if (trimmedString == "" ||  ageLbl.text == "" || farmNameTextfield.text == ""){
                    
                    Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
                    
                    if farmNameTextfield.text == ""  {
                        farmNameTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                    if farmWeightTextField.text == ""  {
                        farmWeightTextField.layer.borderColor = UIColor.red.cgColor
                    }
                    ageUperBtnOutlet.setImage(UIImage(named: "dialer01-1"), for: .normal)
                    
                    if ageLbl.text != ""  {
                        ageUperBtnOutlet.setImage(UIImage(named: "dialer01"), for: .normal)
                    }
                } else {
                    
                    feedProgramDisplayLabel.text = ""
                    self.insertdata()
                }
            }
            
            else  if (feedProgramDisplayLabel.text == NSLocalizedString("- Select -", comment: "") ||  ageLbl.text == "" || farmNameTextfield.text == "" )
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
                
                feedProgramBtn.layer.borderColor = UIColor.red.cgColor
                ageUperBtnOutlet.setImage(UIImage(named: "dialer01-1"), for: UIControl.State())
                
                if feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "")  {
                    feedProgramBtn.layer.borderColor = UIColor.black.cgColor
                }
                if farmNameTextfield.text == "" {
                    farmNameTextfield.layer.borderColor = UIColor.red.cgColor
                } else {
                    farmNameTextfield.layer.borderColor = UIColor.black.cgColor
                }
                if farmWeightTextField.text == "" {
                    farmWeightTextField.layer.borderColor = UIColor.red.cgColor
                } else {
                    farmWeightTextField.layer.borderColor = UIColor.black.cgColor
                }
                
                if ageLbl.text != ""  {
                    ageUperBtnOutlet.setImage(UIImage(named: "dialer01"), for: UIControl.State())
                }
            } else {
                self.insertdata()
            }
            for i in 0..<NoOFbirds.count{
                
                if (noOfBirdsLbl.text! == NoOFbirds[i] as! String){
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
            myPickerView.reloadInputViews()
            valueStore = false
            
        }
        
    }
    func insertdata()  {
        farmNameTextfield.layer.borderColor = UIColor.black.cgColor
        
        countFarmId = UserDefaults.standard.integer(forKey: "farmIdTurkey")
        if countFarmId == 0{
            countFarmId = countFarmId+1
            UserDefaults.standard.set(countFarmId, forKey: "farmIdTurkey")
        }
        else{
            countFarmId = countFarmId+1
            UserDefaults.standard.set(countFarmId, forKey: "farmIdTurkey")
        }
        CoreDataHandlerTurkey().FarmsDataDatabaseTurkey("", stateId: 0, farmName: trimmedString, farmId: 0, countryName: "", countryId: 0, city: "")
        
        let postingArr = CoreDataHandlerTurkey().fetchAllPostingSessionWithNumberTurkey()
        let nec = UserDefaults.standard.bool(forKey:"nec")
        if nec == true {
            
            if postingArr.count == 0 {
                CoreDataHandlerTurkey().autoIncrementidtableTurkey()
                let autoD  = CoreDataHandlerTurkey().fetchFromAutoIncrementTurkey()
                self.necId = autoD
                if nec == true {
                    self.saveDataforposting()
                }
                saveStep1Data()
            }
            else {
                if UserDefaults.standard.bool(forKey:"Unlinked") == true {
                    
                    CoreDataHandlerTurkey().autoIncrementidtableTurkey()
                    let autoD  = CoreDataHandlerTurkey().fetchFromAutoIncrementTurkey()
                    self.necId = autoD
                    
                    if nec == true {
                        self.saveDataforposting()
                    }
                    saveStep1Data()
                }
                else{
                    self.necId = UserDefaults.standard.integer(forKey:"postingId")
                    saveStep1Data()
                    CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey( self.necId as NSNumber, finalizeNec: 1)
                    CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(self.necId as NSNumber)
                }
            }
        }
        else{
            CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey( self.necId as NSNumber, finalizeNec: 1)
            self.captureNecropsy =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(self.necId as NSNumber) as! [NSManagedObject]
            if  self.captureNecropsy.count == 0{
                if UserDefaults.standard.bool(forKey:"Unlinked") == true {
                    self.saveDataforposting()
                }
                
            }
            
            saveStep1Data()
        }
    }
    func saveDataforposting(){
        let complexId = UserDefaults.standard.integer(forKey:"UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey:"unCustId")
        self.timeStampString  = self.timeStamp()
        CoreDataHandlerTurkey().PostingSessionDbTurkey("", birdBreesId: 0, birdbreedName: "", birdBreedType: "", birdSize:"", birdSizeId: 0, cocciProgramId: 0, cociiProgramName: "", complexId: complexId as NSNumber, complexName: complexLbl.text ?? "", convential:"", customerId: custMid as NSNumber, customerName:"", customerRepId: 0, customerRepName: "", imperial: "", metric: "", notes: "", salesRepId: 0, salesRepName: "", sessiondate:  postingDateLbl.text!, sessionTypeId: 0, sessionTypeName: "", vetanatrionName: "", veterinarianId: 0 , loginSessionId: 1, postingId: self.necId as NSNumber,mail: "",female: "",finilize:0, isSync : true,timeStamp:timeStampString,lngId:lngId as NSNumber,birdType:"",birdTypeId:-1,birdbreedId:0,capNec:0 , avgAge: "" , avgWeight: "" , outTime: "" , FCR: "" , Livability: "" , mortality: "")
        CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey(self.necId as NSNumber, finalizeNec: 2)
    }
    
    func saveStep1Data(){
        
        UserDefaults.standard.set(self.necId, forKey: "necId")
        UserDefaults.standard.set(self.necId, forKey: "postingId")
        UserDefaults.standard.synchronize()
        let neciIdStep = UserDefaults.standard.integer(forKey:"necId")
        let complexId = UserDefaults.standard.integer(forKey:"UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey:"unCustId")
        
        count =  UserDefaults.standard.integer(forKey: "count")
        if count == 0{
            count = count+1
        }
        else{
            count = count+1
        }
        
        var imageAutoIncrementId = Int()
        imageAutoIncrementId = UserDefaults.standard.integer(forKey: "imageAutoIncrementIdTurkey")
        if imageAutoIncrementId == 0 {
            imageAutoIncrementId = imageAutoIncrementId + 1
        } else {
            imageAutoIncrementId = imageAutoIncrementId + 1
        }
        UserDefaults.standard.set(imageAutoIncrementId, forKey: "imageAutoIncrementIdTurkey")
        UserDefaults.standard.set(count, forKey: "count")
        UserDefaults.standard.synchronize()
        let appendfeedProgramwithCount = String(format:"%d. %@",count,trimmedString )
        
        
        self.timeStamp()
        if farmWeightTextField.text == "."{
            farmWeightTextField.text = ""
        }
        
        CoreDataHandlerTurkey().SaveNecropsystep1Turkey(neciIdStep as NSNumber, age: self.ageLbl.text!, farmName: appendfeedProgramwithCount, feedProgram: feedProgramDisplayLabel.text!, flockId: flockIdTextField.text!, houseNo: houseNoTextFld.text!, noOfBirds: noOfBirdsLbl.text!, sick: asb as NSNumber,necId:neciIdStep as NSNumber,compexName:complexLbl.text ?? "",complexDate:postingDateLbl.text!,complexId:complexId as NSNumber,custmerId:custMid as NSNumber,feedId: feedId as NSNumber,isSync:true,timeStamp:timeStampString,actualTimeStamp:timeStampString,lngId:lngId as NSNumber,farmWeight: farmWeightTextField.text!,abf: abfLbl.text!,breed: breedString,sex: sexString,farmId:countFarmId as NSNumber, imageId: NSNumber(value: imageAutoIncrementId),count: count as NSNumber , genName: genLbl.text! , genId: geneId as! NSNumber)
        
        UserDefaults.standard.set(false, forKey: "nec")
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.bool(forKey:"Unlinked") == true {
            
        } else {
            
            postingId = UserDefaults.standard.integer(forKey:"postingId")
        }
        
        UserDefaults.standard.set(timeStampString, forKey: "timestamp")
        UserDefaults.standard.synchronize()
        CoreDataHandlerTurkey().updateFinalizeDataActualNecTurkey(necId as NSNumber, deviceToken: actualTimestamp)
        ageLbl.text = ""
        farmNameTextfield.text = ""
        farmWeightTextField.text = ""
        abfLbl.text = "- Select -"
        sexLightHenOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        sexHeavyHenOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        sexTomsOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        breedMixedOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        breedNicholasOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        breedHybridOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        if UserDefaults.standard.bool(forKey:"Unlinked") == true{
            feedProgramDisplayLabel.text = ""
            abfLbl.text = "- Select -"
        }
        else{
            self.feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
            self.abfLbl.text = NSLocalizedString("- Select -", comment: "")
        }
        if birdIndex == 0 {
            
            farmWeightLbl.text = "(lbs)"
            
        } else if birdIndex == 1 {
            
            farmWeightLbl.text = "(Kgs)"
        }
        flockIdTextField.text = ""
        houseNoTextFld.text = "1"
        noOfBirdsLbl.text = "5"
        genLbl.text = "Commercial"
        geneId =  1
        
        
        sickBtnOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
        asb = false
        farmWeightTextField.layer.borderColor = UIColor.black.cgColor
        
        self.captureNecropsy =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(neciIdStep as NSNumber) as! [NSManagedObject]
        
        breedString = "N"
        sexString = "L"
        tblView.reloadData()
        
    }
    
    /******** Genrate Time Stamp *********************/
    
    func timeStamp() -> String{
        if UserDefaults.standard.bool(forKey:"Unlinked") == true {
            
            let nectimeStamp = UserDefaults.standard.bool(forKey:"timeStampTrue")
            if nectimeStamp == true{
                if (UserDefaults.standard.value(forKey: "timeStamp") as? String) != nil{
                    timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as! String
                }
                else{
                    let postingArr = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId as NSNumber)
                    timeStampString = (postingArr.object(at:0) as AnyObject).value( forKey:  "timeStamp") as! String
                    
                }
                UserDefaults.standard.set(false, forKey: "timeStampTrue")
                UserDefaults.standard.synchronize()
            }
            else{
                timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as! String
            }
            
            timeStampString = timeStampString.replacingOccurrences(of: "/", with: "", options: .regularExpression)
            timeStampString = timeStampString.replacingOccurrences(of: ":", with: "", options: .regularExpression)
            
            let string = timeStampString
            let character: Character = "i"
            
            if string.contains(character) {
                
            } else {
                let  udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
                
                let sessionGUID1 =   timeStampString + "_" + String(describing: self.necId as NSNumber)
                timeStampString = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
            }
        }
        else{
            let postinSeesion =  CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(self.postingId  as NSNumber) as NSArray
            self.timeStampString = (postinSeesion.object(at: 0) as AnyObject).value(forKey: "timeStamp") as! String
            
            
        }
        return timeStampString
    }
    var btnnTag = 0
    //*********
    let digitBeforeDecimal = 3
    let digitAfterDecimal = 3
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92){
            
        } else if ((textField.text?.count)! > 49  ){
            return false
        }
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (textField.tag == 101){
            
            let bPredicate: NSPredicate = NSPredicate(format: "farmName contains[cd] %@", newString)
            let countryId =  UserDefaults.standard.integer(forKey:"UnlinkComplex")
            
            fetchcomplexArray = CoreDataHandlerTurkey().fetchFarmsDataDatabaseUsingCompexIdTurkey(complexId: countryId as NSNumber).filtered(using: bPredicate) as NSArray
            
            autocompleteUrls1 = fetchcomplexArray.mutableCopy() as! NSMutableArray
            autocompleteUrls.removeAllObjects()
            autocompleteUrls2.removeAllObjects()
            
            for i in 0..<autocompleteUrls1.count {
                
                let f = autocompleteUrls1.object(at:i) as! FarmsListTurkey
                let  farmName = f.farmName
                autocompleteUrls2.add(farmName!)
            }
            autocompleteUrls = self.removeDuplicates(array: autocompleteUrls2)
            autoSerchTable.frame = CGRect(x:180,y: 240,width: 200,height: 200)
            buttonDroper.alpha = 1
            autoSerchTable.alpha = 1
            
            if autocompleteUrls.count == 0 {
                buttonDroper.alpha = 0
                autoSerchTable.alpha = 0
            } else {
                autoSerchTable.reloadData()
            }
        } else {
            
            switch textField.tag {
                
            case 40 :
                let aSet = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                
                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                
                return string == numberFiltered && newString.length <= maxLength
                
            case 18 :
                
                let aSet = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                
                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                
                return string == numberFiltered && newString.length <= maxLength
                
            case 11 :
                
                // let aSet = NSCharacterSet(charactersIn: "0123456789/-&*.{print("Test message")}[],=").inverted
                let aSet = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                
                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                
                return string == numberFiltered && newString.length <= maxLength
            case 12 :
                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                var newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
                
                var result = true
                if textField == farmWeightTextField {
                    
                    let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
                    let components = string.components(separatedBy: inverseSet)
                    let filtered = components.joined(separator: "")
                    if filtered == string {
                        return newString.length <= maxLength
                    } else {
                        if string == "." {
                            let countdots = textField.text!.components(separatedBy:".").count - 1
                            if countdots == 0 {
                                if (newString.length) > 6 {
                                    newString = newString.substring(to: newString.length - 1) as NSString
                                    return false
                                }
                            } else {
                                if countdots > 0 && string == "." {
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
                return true
            default:
                break
            }
        }
        return true
    }
    
    func checkCharacter( _ inputChar : String , textfield11 : UITextField ) -> Bool {
        
        let newCharacters = CharacterSet(charactersIn: inputChar)
        let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
        if boolIsNumber == true {
            return true
        }
        else {
            
            if inputChar == "." {
                let countdots = textfield11.text!.components(separatedBy: ".").count - 1
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DropperTurkey.sharedInstance.hideWithAnimation(0.1)
        
        if (textField == farmNameTextfield ) {
            farmNameTextfield.returnKeyType = UIReturnKeyType.done
        } else {
            flockIdTextField.returnKeyType = UIReturnKeyType.done
        }
        
        if (textField == farmWeightTextField ) {
            farmWeightTextField.returnKeyType = UIReturnKeyType.done
        } else {
            farmWeightTextField.returnKeyType = UIReturnKeyType.done
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        farmNameTextfield.layer.borderWidth = 1
        farmNameTextfield.layer.cornerRadius = 1
        farmWeightTextField.layer.borderWidth = 1
        farmWeightTextField.layer.cornerRadius = 1
        return true
    }
    
    var index = 10
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField == farmNameTextfield) {
            
            if farmNameTextfield.text?.isEmpty == true{
                farmNameTextfield.layer.borderColor = UIColor.red.cgColor
            }
            else {
                farmNameTextfield.layer.borderColor = UIColor.black.cgColor
            }
        }
        
        if (textField == farmWeightTextField ) {
            
            if farmWeightTextField.text?.isEmpty == true{
                farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            }
            else {
                farmWeightTextField.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    func tableViewpop() {
        buttonbg1.frame = CGRect(x:0,y: 0,width: 1024,height: 768)
        buttonbg1.addTarget(self, action:#selector(CaptureNecropsyStep1Turkey.buttonPreddDroper), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg1)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor = UIColor.black.cgColor
        buttonbg1.addSubview(droperTableView)
    }
    @objc func buttonPreddDroper() {
        buttonbg1.removeFromSuperview()
    }
    @IBAction func breedMixedAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            breedMixedOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            breedNicholasOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            breedHybridOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        breedString = "M"
        
    }
    @IBAction func breedHybridAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            breedMixedOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            breedNicholasOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            breedHybridOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        }
        breedString = "H"
    }
    
    @IBAction func breedNicholasAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            
            breedMixedOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            breedNicholasOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            breedHybridOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        breedString = "N"
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
        }
        
        if  farmWeightTextField.text != "" || farmNameTextfield.text != "" || feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "") || ageLbl.text != "" {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please add farm & bird details.", comment:""))
            
        }  else if captureNecropsy.count == 0 {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please add farm & bird details.", comment:""))
        } else {
            let navigateNxt = self.storyboard?.instantiateViewController(withIdentifier: "CaptureNecroStep2Turkey") as? CaptureNecroStep2Turkey
            self.navigationController?.pushViewController(navigateNxt!, animated: false)
        }
    }
    
    @IBAction func sexLightHensAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            sexLightHenOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            sexHeavyHenOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            sexTomsOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        sexString = "L"
        
    }
    @IBAction func sexHeavyHenAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            sexHeavyHenOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            sexLightHenOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            sexTomsOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        sexString = "H"
    }
    
    @IBAction func sexTomsAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            
            sexLightHenOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            sexHeavyHenOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            sexTomsOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        }
        sexString = "T"
    }
    
    func spacingTextField() {
          // Create an array of all the text fields
          let textFields: [UITextField] = [
            farmNameTextfield, flockIdTextField, houseNoTextFld
          ]
          
          // Loop through each text field and apply the padding
          for textField in textFields {
              let paddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
              textField.leftView = paddingView
              textField.leftViewMode = .always
          }
      }
    
    
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at:j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at:w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        let allPostingSessionArr = NSMutableArray()
        
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at:i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }
        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at:i) as! CaptureNecropsyDataTurkey
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }
        return allPostingSessionArr
    }
    
}


// MARK: Table View

extension CaptureNecropsyStep1Turkey : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == droperTableView {
            
            if btnnTag == 1 {
                return abfArray.count
            } else if btnnTag == 2 {
                return feedProgramArray.count
            }
            else if btnnTag == 3 {
                return GenerationTypeArr.count
            }
            else {
                if butttnTag1 == 0 {
                    return metricArray.count
                } else {
                    return birdArray.count
                }
            }
        } else if tableView == autoSerchTable {
            
            return autocompleteUrls.count
        } else {
            return captureNecropsy.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == droperTableView {
            let cell = UITableViewCell ()
            
            if btnnTag == 1 {
                do {
                    let vet = abfArray.object(at: indexPath.row) as! String
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = vet
                    return cell
                }
            } else if btnnTag == 2 {
                let vet : FeedProgramTurkey = feedProgramArray.object(at: indexPath.row) as! FeedProgramTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet.feddProgramNam
            }
            else if btnnTag == 3 {
                
                let vet : GenerationType = GenerationTypeArr.object(at: indexPath.row) as! GenerationType
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet.generationName
            }
            
            else {
                
                if butttnTag1 == 0 {
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = metricArray[indexPath.row].birdSize
                    
                } else {
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = birdArray[indexPath.row].birdSize
                }
            }
            return cell
            
        } else if tableView == autoSerchTable {
            
            do {
                let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
                if indexPath.row  < autocompleteUrls.count {
                    cell.textLabel?.text = autocompleteUrls.object(at:indexPath.row) as? String
                }
                return cell
            }
        } else {
            
            let Cell:CapNecropsyStep1TblCell = self.tblView.dequeueReusableCell(withIdentifier: "cell") as! CapNecropsyStep1TblCell
            let person = captureNecropsy[indexPath.row]
            
            var farmName = person.value(forKey: "farmName") as? String
            let age = person.value(forKey: "age") as! String
            farmName = farmName! + " " + "[" + age + "]"
            var farmName2 = String()
            let range = farmName?.range(of: ".")
            if range != nil{
                var abc = String(farmName![range!.upperBound...]) as NSString
                farmName2 = String(indexPath.row+1) + "." + " " + String(describing:abc)
            }
            
            Cell.farmNameLbl.text = farmName2 as? String
            Cell.feedProgramLbl.text = person.value(forKey: "feedProgram") as? String
            
            let flockId = person.value(forKey: "flockId") as? String
            var truncated1 = String()
            let count1 = flockId?.count
            
            if count1 == 1 && flockId?.first == "0"{
                truncated1 = ""
                
            } else {
                truncated1 = flockId!
                
            }
            Cell.contentView.backgroundColor = UIColor.clear
            Cell.flockIdLbl?.text = truncated1
            Cell.houseNoLbl.text = person.value(forKey: "houseNo") as? String
            let noofBirds = Int((person.value(forKey: "noOfBirds") as? String)!)
            Cell.breedLbl.text = person.value(forKey: "breed") as? String
            
            Cell.generationLbl.text = person.value(forKey: "generName") as? String
            Cell.deleteButton.tag = indexPath.row
            Cell.deleteButton.addTarget(self, action: #selector(CaptureNecropsyStep1Turkey.ClickDeleteBtton(_:)), for: .touchUpInside)
            Cell.editBtn.tag = indexPath.row
            Cell.editBtn.addTarget(self, action: #selector(CaptureNecropsyStep1Turkey.ClickEditBtton(_:)), for: .touchUpInside)
            let abfLbl = person.value(forKey: "abf") as? String
            
            if abfLbl == "Conventional" || abfLbl == "C" {
                
                Cell.abfLbl.text = "C"
                
            } else if abfLbl == "Antibiotic free" || abfLbl == "A" {
                
                Cell.abfLbl.text = "A"
                
            } else if abfLbl == "- Select -" {
                
                Cell.abfLbl.text = ""
            }
            
            Cell.sexLbl.text = person.value(forKey: "sex") as? String
            Cell.sickLbl.text = person.value(forKey: "sick") as? String
            
            let farmWeight = person.value(forKey: "farmWeight") as? String
            
            if farmWeight != ""{
                var truncated = String()
                let lastVarble = farmWeight?.last!
                
                let count = farmWeight?.count
                
                if count == 1 && farmWeight?.first == "."{
                    
                    truncated = ""
                    
                } else if lastVarble == "." {
                    truncated = (farmWeight?.substring(to: (farmWeight?.index(before: (farmWeight?.endIndex)!))!))!
                }
                else {
                    
                    truncated = farmWeight!
                    
                }
                Cell.farmWeightLbl.text = truncated
            }
            else{
                Cell.farmWeightLbl.text = ""
            }
            
            if (noofBirds == 11){
                let val = 10
                Cell.noOfBirdsLbl.text = String(val)
            } else {
                Cell.noOfBirdsLbl.text = person.value(forKey: "noOfBirds") as? String
            }
            let checkVal  = person.value(forKey: "sick") as! Int
            if checkVal == 0 {
                Cell.sickLbl?.text = NSLocalizedString("No", comment: "")
            } else {
                Cell.sickLbl?.text = NSLocalizedString("Yes", comment: "")
            }
            return Cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    @objc func ClickEditBtton(_ sender: UIButton){
        
        let person = captureNecropsy[sender.tag]
        let indexpath = NSIndexPath(row:sender.tag, section: 0)
        editfeed = "yes"
        buttonEdit.setTitleColor(UIColor.blue, for: UIControl.State())
        buttonEdit.frame = CGRect(x: 0, y:1460, width: 1024, height: 768)
        buttonEdit.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        buttonEdit.addTarget(self, action: #selector( PostingSessionDetailTurkey.buttonPressed), for: .touchUpInside)
        editView.backgroundColor = UIColor.white
        editView.layer.cornerRadius = 25
        editView.layer.masksToBounds = true
        titleView.backgroundColor = UIColor(red: 11/255, green:88/255, blue:160/255, alpha:1.0)
        
        titleLabel.text = NSLocalizedString("Update Farm", comment: "")
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textColor = UIColor.white
        nameLabel.text = NSLocalizedString("Farm Name * : ", comment: "")
        ageLabel.text = NSLocalizedString("Age * :", comment: "")
        feedLabel.text = NSLocalizedString("Farm Weight :", comment: "")
        targetWeightLbl.text = NSLocalizedString("Feed Program * :", comment: "")
        houseLabelTurkey.text = NSLocalizedString("House No. * : ", comment: "")
        nameText.layer.borderColor = UIColor.black.cgColor
        nameText.delegate = self
        nameText.layer.borderWidth = 1
        nameText.leftView = paddingView
        nameText.leftViewMode = UITextField.ViewMode.always
        
        houseNoTxtFldTurkey.layer.borderColor = UIColor.black.cgColor
        houseNoTxtFldTurkey.delegate = self
        houseNoTxtFldTurkey.layer.cornerRadius = 5.0
        houseNoTxtFldTurkey.layer.borderWidth = 1
        houseNoTxtFldTurkey.leftView = paddingViewHouseTurkey
        houseNoTxtFldTurkey.leftViewMode = UITextField.ViewMode.always
        houseNoTxtFldTurkey.tag = 40
        
        farmWeightText.layer.borderColor = UIColor.black.cgColor
        farmWeightText.delegate = self
        farmWeightText.layer.borderWidth = 1
        farmWeightText.leftView = paddingView1
        farmWeightText.leftViewMode = UITextField.ViewMode.always
        farmWeightText.isUserInteractionEnabled = false
        
        strfarmName = (person.value(forKey: "farmName") as? String)!
        strFarmNameFeedId = (person.value(forKey: "feedProgram") as? String)!
        feedButton.setTitle(strFarmNameFeedId, for: .normal)
        strfarmNameArray = strfarmName.components(separatedBy: ". ") as NSArray
        strHouseNumberTurkey = (person.value(forKey: "houseNo") as? String)!
        houseNoTxtFldTurkey.text = strHouseNumberTurkey
        
        let farmName = strfarmNameArray[1]
        nameText.text = farmName as? String
        nameText.layer.cornerRadius = 5.0
        nameText.layer.borderWidth = 1
        nameText.returnKeyType = UIReturnKeyType.done
        
        var strFarmWeight = (person.value(forKey: "farmWeight") as? String)!
        
        var truncated = String()
        if strFarmWeight != "" {
            
            let lastVarble = strFarmWeight.last!
            let count = strFarmWeight.count
            if count == 1 && strFarmWeight.first == "."{
                truncated = ""
                
            } else if lastVarble == "." {
                truncated = (strFarmWeight.substring(to: (strFarmWeight.index(before: (strFarmWeight.endIndex)))))
            }
            else {
                truncated = strFarmWeight
            }
        }
        
        farmWeightText.text = truncated
        farmWeightText.layer.cornerRadius = 5.0
        farmWeightText.layer.borderWidth = 1
        farmWeightText.returnKeyType = UIReturnKeyType.done
        
        oldFarmName = strfarmName as NSString
        ageButton.layer.borderColor =  UIColor.black.cgColor
        ageButton.layer.cornerRadius = 5.0
        ageButton.layer.borderWidth = 1
        ageButton.setTitleColor(UIColor.black, for: .normal)
        ageButton.contentVerticalAlignment = .center
        ageButton.titleEdgeInsets = UIEdgeInsets.init(top: 5.0, left: 10.0, bottom: 0.0, right: 0.0)
        ageButton.setTitle("\((person.value(forKey: "age") as? String)!)", for: .normal)
        ageButton.addTarget(self, action: #selector( CaptureNecropsyStep1Turkey.updateAge), for: .touchUpInside)
        ageButton.setBackgroundImage(UIImage(named:"dialer01"), for: .normal)
        ageButton.contentHorizontalAlignment = .left
        feedButton.layer.cornerRadius = 5.0
        feedButton.layer.borderWidth = 1
        feedButton.contentHorizontalAlignment = .left
        feedButton.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0);
        
        feedButton.setTitle(strFarmNameFeedId, for: .normal)
        if let value = feedButton.titleLabel?.text{
            strFeedCheck = value
        }
        feedButton.setTitleColor(UIColor.black, for: .normal)
        feedButton.layer.borderColor =  UIColor.black.cgColor
        feedButton.addTarget(self, action: #selector( CaptureNecropsyStep1Turkey.feedPressed), for: .touchUpInside)
        let btnView = UIView()
        let btnView1 = UIView()
        
        btnView.frame = CGRect(x: 20, y:335, width: 470, height: 0.5)
        btnView.backgroundColor = UIColor.black
        btnView1.frame = CGRect(x: 250, y:352, width: 1, height:40)
        btnView1.backgroundColor = UIColor.black
        editView.addSubview(btnView)
        editView.addSubview(btnView1)
        submitButton.backgroundColor = UIColor.clear
        submitButton.tintColor = UIColor.white
        submitButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        submitButton.titleLabel!.font =  UIFont(name: "Arial", size: 20)
        submitButton.setTitleColor(UIColor(red: 0/255, green:122/255, blue:228/255, alpha:1.0), for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector( CaptureNecropsyStep1Turkey.updatePressed), for: .touchUpInside)
        
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.tintColor = UIColor.white
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.titleLabel!.font =  UIFont(name: "Arial", size: 20)
        cancelButton.setTitleColor(UIColor(red: 0/255, green:122/255, blue:228/255, alpha:1.0), for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector( CaptureNecropsyStep1Turkey.buttonPressed), for: .touchUpInside)
        editView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        editView.addSubview(nameLabel)
        editView.addSubview(ageLabel)
        editView.addSubview(feedLabel)
        editView.addSubview(nameText)
        editView.addSubview(farmWeightText)
        editView.addSubview(houseLabelTurkey)
        editView.addSubview(houseNoTxtFldTurkey)
        
        editView.addSubview(ageButton)
        editView.addSubview(submitButton)
        editView.addSubview(cancelButton)
        editView.addSubview(feedButton)
        editView.addSubview(targetWeightLbl)
        buttonEdit.addSubview(editView)
        
        self.view.addSubview(buttonEdit)
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonEdit.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        })
        
    }
    
    @objc func feedPressed(){
        editfeed = "yes"
        btnnTag = 2
        feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(self.necId as NSNumber)
        self.tableViewpop()
        droperTableView.frame = CGRect(x: 245,y: 285,width: 200,height: 100)
        droperTableView.reloadData()
    }
    
    @objc func buttonPressed() {
        strFeddUpdate = ""
        strFarmNameFeedId = ""
        strFeedCheck = ""
        UIView.animate(withDuration:0.5, animations: {
            self.buttonEdit.frame = CGRect(x: 0, y: 768, width: 1024, height: 768)
        })
        DispatchQueue.main.async {
            sleep(1)
            self.buttonbgNew2.removeFromSuperview()
            self.buttonEdit.removeFromSuperview()
        }
    }
    
    
    @objc func updateAge(){
        view.endEditing(true)
        showAgesList()
    }
    
    func showAgesList(){
        
        self.myPickerView.frame = CGRect(x:401,y: 272,width: 100,height: 120)
        pickerView()
        editfeed == "yes"
        btnTag = 1
        let lblAge = ageButton.titleLabel?.text
        if(lblAge == ""){
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        }
        else{
            let lblAge = ageButton.titleLabel?.text
            var pickerIndex = Int()
            
            for i in 0..<AgeOp.count{
                
                if (ageLbl.text! == AgeOp[i] as! String){
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
            
        }
        myPickerView.reloadInputViews()
    }
    
    
    @objc func updatePressed(){
        Constants.isFromPsotingTurkey = true
        UserDefaults.standard.setValue(true, forKey: "postingTurkey")
        UserDefaults.standard.synchronize()
        var trimmedString = nameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
                                                            NSString.CompareOptions.literal, range: nil)
        
        let farmWeightTrim = farmWeightText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
                                                            NSString.CompareOptions.literal, range: nil)
        
        if trimmedString == "" && strFeddUpdate == "" {
            
            nameText.layer.borderColor = UIColor.red.cgColor
            let abc = feedButton.currentTitle!
            
            if abc == "" {
                feedButton.layer.borderColor = UIColor.red.cgColor
            } else{
                feedButton.layer.borderColor = UIColor.black.cgColor
            }
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
            
        }else if trimmedString == ""  {
            
            nameText.layer.borderColor = UIColor.red.cgColor
            let abc = feedButton.currentTitle!
            if abc == ""{
                feedButton.layer.borderColor = UIColor.red.cgColor
            }else {
                feedButton.layer.borderColor = UIColor.black.cgColor
            }
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
            
        } else if trimmedString == "" && strFeedCheck == ""{
            let abc = feedButton.currentTitle!
            
            if abc == "" {
                feedButton.layer.borderColor = UIColor.red.cgColor
            }else{
                feedButton.layer.borderColor = UIColor.black.cgColor
            }
            nameText.layer.borderColor = UIColor.red.cgColor
            farmWeightText.layer.borderColor = UIColor.black.cgColor
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Fields marked as (*) are mandatory. Please fill all the fields.")
        }
        
        if houseNoTxtFldTurkey.text == ""
        {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
            houseNoTxtFldTurkey.layer.borderColor = UIColor.red.cgColor
            return
            
        }
        
        else if trimmedString == "" {
            nameText.layer.borderColor = UIColor.red.cgColor
            feedButton.layer.borderColor = UIColor.black.cgColor
            farmWeightText.layer.borderColor = UIColor.black.cgColor
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Please enter farm name.")
            
        }else if strFarmNameFeedId == "" && strFeddUpdate == ""{
            if strFeddUpdate == "" {
                feedButton.layer.borderColor = UIColor.red.cgColor
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select a feed program.", comment: ""))
            }
            if trimmedString == "" {
                nameText.layer.borderColor = UIColor.red.cgColor
                
            } else {
                nameText.layer.borderColor = UIColor.black.cgColor
                
            }
        }
        else if strFeedCheck == "" &&  strFeddUpdate == ""{
            farmWeightText.layer.borderColor = UIColor.black.cgColor
            nameText.layer.borderColor = UIColor.black.cgColor
            feedButton.layer.borderColor = UIColor.red.cgColor
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Please select a feed program.")
        }
        
        else {
            str = strfarmNameArray[0] as! String
            let strNewFarm = str+". "+trimmedString
            if strFeddUpdate == ""{
                CoreDataHandlerTurkey().updateFeddProgramInStep1UsingFarmNameTurkey(self.postingId as NSNumber, feedname: strFeedCheck, feedId: feedIdUpdate , formName: strfarmName)
            }
            else if strFarmNameFeedId == ""{
                CoreDataHandlerTurkey().updateFeddProgramInStep1UsingFarmNameTurkey(self.postingId as NSNumber, feedname: strFeddUpdate, feedId: feedIdUpdate , formName: strfarmName)
            }
            else {
                CoreDataHandlerTurkey().updateFeddProgramInStep1UsingFarmNameTurkey(self.postingId as NSNumber, feedname: strFeddUpdate, feedId: feedIdUpdate , formName: strfarmName)
            }
            if farmWeightText.text == "."{
                farmWeightText.text = ""
            }
            CoreDataHandlerTurkey().updateNecropsystep1WithNecIdAndFarmNameTurkey(postingId as NSNumber, farmName: oldFarmName as NSString, newFarmName: strNewFarm as NSString  , age: (ageButton.titleLabel?.text!)!, isSync: true, farmWeight: farmWeightText.text!, newHouseNoTurkey: houseNoTxtFldTurkey.text! as NSString)
            
            CoreDataHandlerTurkey().updateNewFarmAndAgeOnCaptureNecropsyViewDataTurkey(postingId as NSNumber as NSNumber, oldFarmName: oldFarmName as String, newFarmName: strNewFarm,isSync: true)
            CoreDataHandlerTurkey().updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdNotesTurkey(postingId as NSNumber, oldFarmName: oldFarmName as String, newFarmName: strNewFarm,isSync: true)
            CoreDataHandlerTurkey().updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdPhotoTurkey(postingId as NSNumber, oldFarmName: oldFarmName as String, newFarmName: strNewFarm,isSync: false)
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(postingId as NSNumber)
            self.tblView.reloadData()
            
            self.buttonbgNew2.removeFromSuperview()
            self.buttonEdit.removeFromSuperview()
        }
    }
    
    @objc func ClickDeleteBtton(_ sender: UIButton){
        let person = captureNecropsy[sender.tag]
        let indexpath = NSIndexPath(row:sender.tag, section: 0)
        let cell = self.tblView.cellForRow(at: indexpath as IndexPath) as? CapNecropsyStep1TblCell
        cell?.contentView.backgroundColor = UIColor.gray
        let farmArrayWithoutAge = (person.value(forKey: "farmName") as? String)!
        let necId = (person.value(forKey: "necropsyId") as? Int)!
        
        let dataArr =  CoreDataHandlerTurkey().fecthFrmWithCatnameWithBirdAndObservationWithDeleteTurkey(farmname: farmArrayWithoutAge, necId: necId as NSNumber)
        if dataArr.count > 0{
            for i in 0..<dataArr.count{
                
                let obspoint = (dataArr.object(at: i) as AnyObject).value(forKey: "obsPoint") as! Int
                let obsVal = (dataArr.object(at: i) as AnyObject).value(forKey: "objsVisibilty") as! Int
                
                if obspoint > 0 || obsVal > 0{
                    
                    strMsgforDelete = "Are you sure you want to delete this farm? You have observation recorded for this farm."
                    break
                }
                else{
                    strMsgforDelete = "Are you sure you want to delete this farm?"
                }
            }
        }
        else{
            strMsgforDelete = "Are you sure you want to delete this farm?"
        }
        
        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString(strMsgforDelete, comment: ""), preferredStyle: .alert)
        let action1 = UIAlertAction(title:NSLocalizedString("Yes", comment: ""), style: .default) { (action) in
            
            let data =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(necId as NSNumber) as! [NSManagedObject]
            if UserDefaults.standard.bool(forKey: "Unlinked") == true   {
                if data.count == 1{
                    CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(necId as NSNumber)
                }
            }
            else if data.count == 1{
                CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey( necId as NSNumber, finalizeNec: 0)
            }
            
            CoreDataHandlerTurkey().deleteDataWithPostingIdStep1dataWithfarmNameTurkey(necId as NSNumber, farmName: farmArrayWithoutAge)
            CoreDataHandlerTurkey().deleteDataWithPostingIdStep2dataCaptureNecViewWithfarmNameTurkey(necId as NSNumber, farmName: farmArrayWithoutAge)
            CoreDataHandlerTurkey().deleteDataWithPostingIdStep2NotesBirdWithFarmNameTurkey(necId as NSNumber, farmName: farmArrayWithoutAge)
            CoreDataHandlerTurkey().deleteDataWithPostingIdStep2CameraIamgeWithFarmNameTurkey(necId as NSNumber, farmName: farmArrayWithoutAge)
            
            self.captureNecropsy =   CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(necId as NSNumber) as! [NSManagedObject]
            self.appDelegate.saveContext()
            self.tblView.reloadData()
        }
        let action2 = UIAlertAction(title:NSLocalizedString("No", comment: "") , style: .cancel) { (action) in
            cell?.contentView.backgroundColor = UIColor.clear
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == droperTableView {
            
            if btnnTag == 1 {
                
                let str = abfArray[indexPath.row] as! String
                abfLbl.text = str
                
                if indexPath.row == 0 {
                    butttnTag1 = 0
                    if valueStore == true {
                        
                        let sdds = metricArray[indexOfSelectedPerson]
                    }
                } else if indexPath.row == 1 {
                    butttnTag1 = 1
                    if valueStore == true {
                        
                        let sdds = birdArray[indexOfSelectedPerson]
                    }
                }
                buttonPreddDroper()
            } else if btnnTag == 2 {
                
                let str = feedProgramArray[indexPath.row] as! FeedProgramTurkey
                feedProgramDisplayLabel.text = str.feddProgramNam
                feedId =  str.feedId as! Int
                buttonPreddDroper()
                
                if editfeed == "yes"
                {
                    CoreDataHandler().updatedPostigSessionwithIsFarmSyncPostingId(self.postingId as NSNumber, isFarmSync: false)
                    feedButton.setTitle(str.feddProgramNam!, for: .normal)
                    feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
                    feeId = Int(truncating: str.feedId!)
                    strFeddUpdate = str.feddProgramNam ?? ""
                }
            }
            
            else if btnnTag == 3 {
                
                let str = GenerationTypeArr[indexPath.row] as! GenerationType
                genLbl.text = str.generationName
                geneId =  str.generationId as! Int
                buttonPreddDroper()
            }
            else {
                
                buttonPreddDroper()
                
                if butttnTag1 == 0 {
                    let objMedtricarray = metricArray[indexPath.row]
                    indexOfSelectedPerson = indexPath.row
                }  else {
                    let objstr = birdArray[indexPath.row]
                    indexOfSelectedPerson = indexPath.row
                    
                }
                valueStore = true
            }
        } else if tableView == autoSerchTable {
            
            farmNameTextfield.text = autocompleteUrls.object(at:indexPath.row) as? String
            autoSerchTable.alpha = 0
            farmNameTextfield.endEditing(true)
            buttonDroper.alpha = 0
        }
    }
}

// MARK: Picker  View

extension CaptureNecropsyStep1Turkey :UIPickerViewDelegate,UIPickerViewDataSource{
    /////////// Picker View Delegate //////
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if btnTag == 0 {
            
            if let value = HouseNoArr.count as? Int {
                return value
            } else {
                return 0
            }
            
        } else if ( btnTag == 1) {
            
            if let value = AgeOp.count as? Int {
                return value
            } else {
                return 0
            }
        } else if (btnTag == 2){
            
            if let value = NoOFbirds.count as? Int {
                return value
            } else {
                return 0
            }
            
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
      
        
        if btnTag == 0 {
            
            if let value = HouseNoArr[row] as? String {
                return value
            } else {
                return nil
            }
            
        } else if btnTag == 1 {
            myPickerView.showsSelectionIndicator = false
            if let value = AgeOp[row] as? String{
                return value
            } else {
                return nil
            }
        }
        else {
            myPickerView.showsSelectionIndicator = false
            if let value = NoOFbirds[row] as? String{
                return value
            } else {
                return nil
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if btnTag == 0 {
            
            if let value = HouseNoArr[row] as? String {
                return houseNoLBL.text = value
            } else {
                return houseNoLBL.text = ""
            }
            
        } else if btnTag == 1 {
            
            if editfeed == "yes"
            {
                if let value = AgeOp[row] as? String {
                    editfeed = "no"
                    return ageButton.setTitle("\(value)", for: .normal)
                    
                } else {
                    return ageLbl.text = ""
                }
            }
            else
            {
                if let value = AgeOp[row] as? String {
                    return ageLbl.text = value
                } else {
                    return ageLbl.text = ""
                }
            }
        } else {
            
            if let value = NoOFbirds[row] as? String {
                return noOfBirdsLbl.text = value
            } else {
                return noOfBirdsLbl.text = ""
            }
        }
        myPickerView.endEditing(true)
        buttonbg.removeFromSuperview()
    }
    
}

extension NSRange {
    
    func toRangeTurkey(_ string: String) -> Range<String.Index> {
        
        let startIndex = string.index(string.startIndex, offsetBy: location)
        let endIndex = string.index(string.endIndex, offsetBy: location)
        return startIndex..<endIndex
        
    }
}
