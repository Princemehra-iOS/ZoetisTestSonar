//  captureNecropsyStep1Data.swift
//  Zoetis -Feathers
//  Created by "" on 21/10/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit
import CoreData

import ReachabilitySwift

class captureNecropsyStep1Data: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    var isComesFromUnlikedWithPostind = Bool()
    @IBOutlet weak var syncNotiCountLbl: UILabel!
    var trimmedString = String()
    var timeStampString = String()
     var strDateEn = String()
     var strDateFr = String()
    var metricArray: [BirdSizePosting]  = []
    var birdArray: [BirdSizePosting]  = []
    var ell = Int()
    var countFarmId = Int()
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var btnAddLablel: UILabel!
    @IBOutlet weak var targetWeightOutlet: UIButton!
    var strMsgforDelete =  String()

    @IBOutlet weak var targetWeightLbl: UILabel!
    @IBOutlet weak var feedProgramDropDwnIcon: UIImageView!

    @IBOutlet weak var feedProgramOutlet: UIButton!
    @IBOutlet weak var btnAdd: UIButton!

    @IBOutlet weak var feedProgramTextLebl: UILabel!

    var myPickerView = UIPickerView()
    let buttonbg = UIButton()
    let buttonbg1 = UIButton()
    var feedProgramArray = NSArray()
    var count = Int()
    var necId = Int()
    var feeId = Int()
    var lngId = NSInteger()
    var hideDropDwnB = true
    var navigatefronInlinked = String()
    //var timeStampString = String()
    var actualTimestamp = String()

    var complexTypeFetchArray = NSMutableArray()
    var complexTypeFetchArray1 = NSMutableArray()
    var autoSerchTable = UITableView()
    var autocompleteUrls = NSMutableArray()
    var autocompleteUrls2 = NSMutableArray()
    var autocompleteUrls1 = NSMutableArray()
    var fetchcomplexArray = NSArray()
    var fetchcomplexArray1 = NSArray()
    var buttonDroper = UIButton()
    var existingArray = NSMutableArray()
    var fetchcustRep = NSArray()
    let cellReuseIdentifier = "cell"

    var HouseNo = NSArray()
    var AgeOp = NSArray()
    var NoOFbirds = NSArray()
    var btnTag = Int()
    var postingId = Int()
    var droperTableView  = UITableView()

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lblCustmer: UILabel!

    @IBOutlet weak var lblHouse: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblNoBirds: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    @IBOutlet weak var lblComplex: UILabel!
    @IBOutlet weak var houseIMAGEvIEW: UIImageView!
    @IBOutlet weak var ageImageView: UIImageView!

    @IBOutlet weak var myAgepickerView: UIPickerView!
    @IBOutlet weak var noOfBirdsPickerView: UIView!

    @IBOutlet weak var farmNameTextField: UITextField!
    @IBOutlet weak var flockIdTextField: UITextField!
    @IBOutlet weak var ageUperBtnOutlet1: UIButton!

    @IBOutlet weak var ageDownBtnOutlet: UIButton!
    @IBOutlet weak var feedProgramDisplayLabel: UILabel!
    @IBOutlet weak var huseNoDwnOutlet: UIButton!
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var noOfDownoutlet: UIButton!
    @IBOutlet weak var noOfBirdsTextField: UITextField!
    @IBOutlet weak var noOfDownOutlet: UIButton!
    @IBOutlet weak var houseNotextField: UITextField!

    @IBOutlet weak var huseNoUperBttnOutlet: UIButton!
    @IBOutlet weak var noOFiMAGEVIEW: UIImageView!
    var captureNecropsy = [NSManagedObject]()

    @IBOutlet weak var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var houseNO :Int?
//    var age = Int()
//    var noOfBirdscount = Int()
    var asb = Bool()
    var targetWeigh = UserDefaults.standard.integer(forKey: "targetWeightSelection")

    override func viewDidLoad() {
        super.viewDidLoad()
         lngId = UserDefaults.standard.integer(forKey: "lngId")

        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        NoOFbirds = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        AgeOp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]
        HouseNo = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            postingId = 0
            feedProgramOutlet.isUserInteractionEnabled = false
            feedProgramOutlet.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.1)

            feedProgramDropDwnIcon.isHidden = true
            customerLbl.isHidden
                = true
            lblCustmer.isHidden = true
            feedProgramDisplayLabel.text = ""
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
            feedProgramOutlet.isUserInteractionEnabled = true
            lblCustmer.isHidden = false

            if lngId == 1 {
                feedProgramTextLebl.text = "Feed Program *"
            } else if lngId == 3 {
                feedProgramTextLebl.text = "Programme alimentaire *"
            } else if lngId == 5 {
                feedProgramTextLebl.text = "Programa de alimentación *"
            }

            feedProgramDropDwnIcon.isHidden = false
            customerLbl.isHidden = false

            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")

        }

        flockIdTextField.tag = 11

        lblAge.text = ""
        farmNameTextField.text = ""
        flockIdTextField.text = ""
        lblHouse.text = "1"
        lblNoBirds.text = "5"
        flockIdTextField.keyboardType = .numberPad

        if lngId == 3 {
            lblDate.text = UserDefaults.standard.value(forKey: "dateFrench") as? String
        } else {
              lblDate.text = UserDefaults.standard.value(forKey: "date") as? String
        }
        strDateEn  = UserDefaults.standard.value(forKey: "date") as! String
        lblComplex.text = UserDefaults.standard.value(forKey: "complex") as? String
        lblCustmer.text = UserDefaults.standard.value(forKey: "custmer") as? String
        tableView.delegate = self
        tableView.dataSource = self
        feedProgramOutlet.layer.borderWidth = 1
        feedProgramOutlet.layer.cornerRadius = 3.5
        feedProgramOutlet.layer.borderColor = UIColor.black.cgColor

        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1
        farmNameTextField.layer.borderColor = UIColor.black.cgColor
        farmNameTextField.delegate = self
        flockIdTextField.delegate = self
        flockIdTextField.layer.borderWidth = 1
        flockIdTextField.layer.borderColor = UIColor.black.cgColor

    }
    func removeDuplicates(array: NSMutableArray) -> NSMutableArray {
        var encountered = Set<String>()
        let result = NSMutableArray()
        for value in array {
            if encountered.contains(value as! String) {
            } else {
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
            } else {
                encountered.insert(value as! String)
                result.add(value as! String)
            }
        }

        var arra = NSArray()
        arra = result.mutableCopy()  as! NSArray

        return arra
    }
    override func viewWillAppear(_ animated: Bool) {
        checkBoxOutlet.layer.borderWidth = 1
        checkBoxOutlet.layer.borderColor = UIColor.black.cgColor
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")

        }

        if lngId == 1 {
            feedProgramTextLebl.text = "Feed Program *"
        } else if lngId == 3 {
            feedProgramTextLebl.text = "Programme alimentaire *"
        } else if lngId == 5 {
            feedProgramTextLebl.text = "Programa de alimentación *"
            btnAddLablel.text = "Añadir"
        }

        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        spacingTextField()
        let nec =  UserDefaults.standard.bool(forKey: "nec")
        if nec ==

            false {
            let neciIdStep = UserDefaults.standard.integer(forKey: "necId")
            self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1neccId(neciIdStep  as NSNumber) as! [NSManagedObject]
        }
        buttonDroper.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonDroper.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
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
        if   self.captureNecropsy.count<0 {
            count = 0
        }
        tableView.reloadData()

        let allBireType = CoreDataHandler().fetchBirdSize()
        if(birdArray.count == 0) {
            //print(allBireType)
            for dict in allBireType {
                // let type =  dict.valueForKey("breedType") as! String
                if (dict as AnyObject).value(forKey: "scaleType") as! String == "Imperial"{
                    birdArray.append(dict as! BirdSizePosting)
                    //print(birdArray)
                } else {
                    metricArray.append(dict as! BirdSizePosting)
                }
            }
        }
    }
    @objc func buttonPressedDroper() {

        buttonDroper.alpha = 0
    }
    @IBAction func backButton(sender: AnyObject) {
        UserDefaults.standard.set(true, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)

    }
    var pickerIndex = Int()

    @IBAction func huseNoUpperBtnAction(sender: AnyObject) {
        self.view.endEditing(true)
        btnTag = 0
        myPickerView.frame = CGRect(x: 628, y: 151, width: 100, height: 120)
        pickerView()

        if(lblHouse.text == "") {
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        } else {

            for i in 0..<HouseNo.count {

                if (lblHouse.text! == HouseNo[i] as! String) {
                    pickerIndex = i
                    break
                }

            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)

        }
        myPickerView.reloadInputViews()

    }

    @IBAction func ageUperBtnaction(sender: AnyObject) {
        self.view.endEditing(true)
        btnTag = 1
        myPickerView.frame = CGRect(x: 628, y: 240, width: 100, height: 120)
        pickerView()

        if(lblAge.text == "") {
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        } else {
            var pickerIndex = Int()
            for i in 0..<AgeOp.count {
                if (lblAge.text! == AgeOp[i] as! String) {
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)

        }
        myPickerView.reloadInputViews()
        ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: .normal)

    }
    @IBAction func noOfUperBtnAction(sender: AnyObject) {

        self.view.endEditing(true)
        btnTag = 2
        myPickerView.frame = CGRect(x: 881, y: 237, width: 100, height: 120)
        pickerView()
        var pickerIndex = Int()

        for i in 0..<NoOFbirds.count {

            if (lblNoBirds.text! == NoOFbirds[i] as! String) {
                pickerIndex = i
                break
            }
        }
        myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        myPickerView.reloadInputViews()
    }

    @IBAction func feedProrgramAction(sender: AnyObject) {
        btnTag = 5
        do {

            farmNameTextField.resignFirstResponder()
            flockIdTextField.resignFirstResponder()

            feedProgramOutlet.layer.borderColor = UIColor.black.cgColor

            if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            } else {
                self.necId = UserDefaults.standard.integer(forKey: "postingId")
            }
            feedProgramArray = CoreDataHandler().FetchFeedProgram(postingId as NSNumber)

            self.tableViewpop()
            droperTableView.frame = CGRect(x: 175, y: 320, width: 200, height: 100)
            droperTableView.reloadData()

            buttonDroper.alpha = 0
            autoSerchTable.alpha = 0

        } catch {

        }

    }

    func tableViewpop() {
        buttonbg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg1.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPreddDroper), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonbg1)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg1.addSubview(droperTableView)

    }

    func pickerView () {

        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonbg.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
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
    @objc func buttonPreddDroper() {
        buttonbg1.removeFromSuperview()
    }

    @IBAction func checkBtnAction(sender: AnyObject) {

        if (sender.tag == 200) {

            checkBoxOutlet.isSelected = !checkBoxOutlet.isSelected
            if  checkBoxOutlet.isSelected {
                checkBoxOutlet.isSelected = true

                sender.setImage(UIImage(named: "Check_")!, for: .normal)
                asb = true

            } else {

                checkBoxOutlet.setImage(nil, for: .normal)
                checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
                asb = false
            }
        } else {

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var managedObjectContext = (UIApplication.shared.delegate
        as! AppDelegate).managedObjectContext

    @IBAction func addMoreAction(sender: AnyObject) {

        trimmedString = farmNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            if (trimmedString == "" ||  lblAge.text == "") {

            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))

                if trimmedString == ""{
                    farmNameTextField.layer.borderColor = UIColor.red.cgColor

                } else {
                    farmNameTextField.layer.borderColor = UIColor.black.cgColor
                }
            ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: .normal)

                if lblAge.text != "" {
                    ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: .normal)
                }
            } else {

                feedProgramDisplayLabel.text = ""
                self.insertdata()
            }
        } else  if ( trimmedString == "" || feedProgramDisplayLabel.text == NSLocalizedString("- Select -", comment: "") ||  lblAge.text == "" ) {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))

            if trimmedString == ""{
                farmNameTextField.layer.borderColor = UIColor.red.cgColor

            } else {
                farmNameTextField.layer.borderColor = UIColor.black.cgColor
            }
            feedProgramOutlet.layer.borderColor = UIColor.red.cgColor
            ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: .normal)
            if feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "") {
                feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
            }
            if lblAge.text != "" {
                ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: .normal)
            }
        } else {
            self.insertdata()
        }

        for i in 0..<NoOFbirds.count {
            if (lblNoBirds.text! == NoOFbirds[i] as! String) {
                pickerIndex = i
                break
            }
        }
        myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        myPickerView.reloadInputViews()
    }

    func insertdata() {
        farmNameTextField.layer.borderColor = UIColor.black.cgColor

         countFarmId = UserDefaults.standard.integer(forKey: "farmId")
        if countFarmId == 0 {
            countFarmId = countFarmId+1
            UserDefaults.standard.set(countFarmId, forKey: "farmId")
        } else {
            countFarmId = countFarmId+1
            UserDefaults.standard.set(countFarmId, forKey: "farmId")
        }

        CoreDataHandler().FarmsDataDatabase("", stateId: 0, farmName: trimmedString, farmId: 0, countryName: "", countryId: 0, city: "")

        let postingArr = CoreDataHandler().fetchAllPostingSessionWithNumber()
        let nec = UserDefaults.standard.bool(forKey: "nec")
        if nec == true {

            if postingArr.count == 0 {
                CoreDataHandler().autoIncrementidtable()
                let autoD  = CoreDataHandler().fetchFromAutoIncrement()
                self.necId = autoD
                if nec == true {
                    ///save posting session with necid
                    self.saveDataforposting()
                }
                saveStep1Data()
            } else {
                if UserDefaults.standard.bool(forKey: "Unlinked") == true {

                    //self.necId = postingArr.count + 1
                    CoreDataHandler().autoIncrementidtable()
                    let autoD  = CoreDataHandler().fetchFromAutoIncrement()
                    self.necId = autoD

                    if nec == true {
                        ///save posting session with necid
                        self.saveDataforposting()

                    }
                    saveStep1Data()
                } else {
                    self.necId = UserDefaults.standard.integer(forKey: "postingId")
                    saveStep1Data()
                    CoreDataHandler().updateFinalizeDataWithNec( self.necId as NSNumber, finalizeNec: 1)
                    CoreDataHandler().updateisSyncTrueOnPostingSession(self.necId as NSNumber)

                }

            }

        } else {
            CoreDataHandler().updateFinalizeDataWithNec( self.necId as NSNumber, finalizeNec: 1)
                self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1neccId(self.necId as NSNumber) as! [NSManagedObject]
            if  self.captureNecropsy.count == 0 {

                if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                     self.saveDataforposting()
                }

            }
            saveStep1Data()
        }

    }
    func saveDataforposting() {
        let complexId = UserDefaults.standard.integer(forKey: "UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey: "unCustId")
        self.timeStampString  = self.timeStamp()
        CoreDataHandler().PostingSessionDb("", birdBreesId: 0, birdbreedName: "", birdBreedType: "", birdSize: "", birdSizeId: 0, cocciProgramId: 0, cociiProgramName: "", complexId: complexId as NSNumber, complexName: lblComplex.text!, convential: "", customerId: custMid as NSNumber, customerName: "", customerRepId: 0, customerRepName: "", imperial: "", metric: "", notes: "", salesRepId: 0, salesRepName: "", sessiondate: strDateEn, sessionTypeId: 0, sessionTypeName: "", vetanatrionName: "", veterinarianId: 0, loginSessionId: 1, postingId: self.necId as NSNumber, mail: "", female: "", finilize: 0, isSync: true, timeStamp: timeStampString, lngId: lngId as NSNumber)

        _ = CoreDataHandler().fetchAllPostingSession(self.necId as NSNumber)

        CoreDataHandler().updateFinalizeDataWithNec(self.necId as NSNumber, finalizeNec: 2)
    }

    func saveStep1Data() {
        UserDefaults.standard.set(self.necId, forKey: "necId")
        UserDefaults.standard.set(self.necId, forKey: "postingId")
        UserDefaults.standard.synchronize()
        let neciIdStep = UserDefaults.standard.integer(forKey: "necId")
        let complexId = UserDefaults.standard.integer(forKey: "UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey: "unCustId")
        _ = CoreDataHandler().FetchNecropsystep1NecId(neciIdStep as NSNumber)
        count =  UserDefaults.standard.integer(forKey: "count")
        if count == 0 {
             count = count+1
        } else {
            count = count+1
        }

        var imageAutoIncrementId = Int()
        imageAutoIncrementId = UserDefaults.standard.integer(forKey: "imageAutoIncrementId")

        if imageAutoIncrementId == 0 {

            imageAutoIncrementId = imageAutoIncrementId + 1
        } else {

            imageAutoIncrementId = imageAutoIncrementId + 1
        }

        UserDefaults.standard.set(imageAutoIncrementId, forKey: "imageAutoIncrementId")
         print(countFarmId)
        UserDefaults.standard.set(count, forKey: "count")
        UserDefaults.standard.synchronize()
        let appendfeedProgramwithCount = String(format: "%d. %@", count, trimmedString )
        _ = self.timeStamp()
        CoreDataHandler().SaveNecropsystep1(neciIdStep as NSNumber, age: self.lblAge.text!, farmName: appendfeedProgramwithCount, feedProgram: feedProgramDisplayLabel.text!, flockId: flockIdTextField.text!, houseNo: lblHouse.text!, noOfBirds: lblNoBirds.text!, sick: asb as NSNumber, necId: neciIdStep as NSNumber, compexName: lblComplex.text!, complexDate: strDateEn, complexId: complexId as NSNumber, custmerId: custMid as NSNumber, feedId: feedId as NSNumber, isSync: true, timeStamp: timeStampString, actualTimeStamp: timeStampString, lngId: lngId as NSNumber, farmId: countFarmId as NSNumber, imageId: NSNumber(value: imageAutoIncrementId), count: count as NSNumber  )
        UserDefaults.standard.set(false, forKey: "nec")
        UserDefaults.standard.synchronize()
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

        } else {

            postingId = UserDefaults.standard.integer(forKey: "postingId")
        }

        UserDefaults.standard.set(timeStampString, forKey: "timestamp")
        UserDefaults.standard.synchronize()
        CoreDataHandler().updateFinalizeDataActualNec(necId as NSNumber, deviceToken: actualTimestamp)
        lblAge.text = ""
        farmNameTextField.text = ""
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            feedProgramDisplayLabel.text = ""
        } else {
            self.feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
        }

        flockIdTextField.text = ""
        lblHouse.text = "1"
        lblNoBirds.text = "5"
     //   farmNameTextField.layer.borderColor = UIColor.black.cgColor
        checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
        asb = false

        self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1neccId(neciIdStep as NSNumber) as! [NSManagedObject]
        tableView.reloadData()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == droperTableView {

            if btnTag == 5 {
                return feedProgramArray.count
            } else if btnTag == 6 {

                if targetWeigh == 0 {
                    return metricArray.count
                } else if targetWeigh == 1 {
                    return birdArray.count
                }

            }

        } else if tableView == autoSerchTable {

            return autocompleteUrls.count
        } else {
            return captureNecropsy.count
        }

        return 0
    }
    /******** Genrate Time Stamp *********************/

    func timeStamp() -> String {
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            let nectimeStamp = UserDefaults.standard.bool(forKey: "timeStampTrue")
            if nectimeStamp == true {
                if (UserDefaults.standard.value(forKey: "timeStamp") as? String) != nil {
                    timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as! String
                } else {
                    let postingArr = CoreDataHandler().fetchAllPostingSession(postingId as NSNumber)
                    timeStampString = (postingArr.object(at: 0) as AnyObject).value( forKey: "timeStamp") as! String

                }

                UserDefaults.standard.set(false, forKey: "timeStampTrue")
                UserDefaults.standard.synchronize()
            } else {
                timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as! String
            }

            timeStampString = timeStampString.replacingOccurrences(of: "/", with: "", options: .regularExpression)
            timeStampString = timeStampString.replacingOccurrences(of: ":", with: "", options: .regularExpression)

            let string = timeStampString
            let character: Character = "i"

            if (string.contains(character)) {

            } else {
                let  udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String

                let sessionGUID1 =   timeStampString + "_" + String(describing: self.necId as NSNumber)
                timeStampString = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
            }
        } else {
            let postinSeesion =  CoreDataHandler().fetchAllPostingSession(self.postingId  as NSNumber) as NSArray

            self.timeStampString = (postinSeesion.object(at: 0) as AnyObject).value(forKey: "timeStamp") as! String

        }
        return timeStampString
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == droperTableView {

            do {
                let cell = UITableViewCell()

                if  btnTag == 5 {

                    let vet: FeedProgram = feedProgramArray.object(at: indexPath.row) as! FeedProgram
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = vet.feddProgramNam
                    return cell

                } else if  btnTag == 6 {

                    if targetWeigh == 0 {

                        cell.selectionStyle = UITableViewCell.SelectionStyle.none

                        if let value = metricArray[indexPath.row].birdSize {
                            cell.textLabel!.text = value
                        }
                    } else {
                        cell.selectionStyle = UITableViewCell.SelectionStyle.none
                        if let value = birdArray[indexPath.row].birdSize {
                            cell.textLabel!.text = value

                        }
                    }

                }
                return cell

            }
        } else if tableView == autoSerchTable {

            do {
                // your code from above

                let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
                if indexPath.row  < autocompleteUrls.count {
                    if let value = autocompleteUrls.object(at: indexPath.row) as? String {
                        cell.textLabel?.text = value
                    }
                }
                return cell

            }

        } else {

            let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! captureTableViewCell
            let person = captureNecropsy[indexPath.row]
            var farmName = person.value(forKey: "farmName") as? String
            let age = person.value(forKey: "age") as! String
            farmName = farmName! + " " + "[" + age + "]"

            var farmName2 = String()
            let range = farmName?.range(of: ".")
            if range != nil {
                let abc = String(farmName![range!.upperBound...]) as NSString
                print(abc)
                farmName2 = String(indexPath.row+1) + "." + " " + String(describing: abc)

            }

//            let farmNamestr = farmName?.components(separatedBy: ". ") as! NSArray
//            var farmName1 = farmNamestr[1]
//            farmName1 = String(indexPath.row+1) + "." + String(describing:farmName1)

            Cell.farmLabel.text = farmName2
            Cell.backgroundColor = UIColor.clear
            Cell.feedProgramLabel.text = person.value(forKey: "feedProgram") as? String
            Cell.flockIdLabel.text = person.value(forKey: "flockId") as? String
            Cell.houseNo.text = person.value(forKey: "houseNo") as? String
            let noofBirds = Int((person.value(forKey: "noOfBirds") as? String)!)
            Cell.deleteButton.tag = indexPath.row
            Cell.deleteButton.addTarget(self, action: #selector(captureNecropsyStep1Data.ClickDeleteBtton(_:)), for: .touchUpInside)

            if (noofBirds == 11) {
                let val = 10
                Cell.noOfBirdsLabel.text = String(val)
            } else {
                Cell.noOfBirdsLabel.text = person.value(forKey: "noOfBirds") as? String
            }
            let checkVal  = person.value(forKey: "sick") as! Int
            if checkVal == 0 {
                Cell.sickLabel.text = NSLocalizedString("No", comment: "")
            } else {
                Cell.sickLabel.text = NSLocalizedString("Yes", comment: "")
            }
            return Cell
        }
    }

    @objc func ClickDeleteBtton(_ sender: UIButton) {
        let person = captureNecropsy[sender.tag]
        let indexpath = NSIndexPath(row: sender.tag, section: 0)
         let cell = self.tableView.cellForRow(at: indexpath as IndexPath) as? captureTableViewCell
        cell?.backgroundColor = UIColor.gray
        let farmArrayWithoutAge = (person.value(forKey: "farmName") as? String)!
        let necId = (person.value(forKey: "necropsyId") as? Int)!

      let dataArr =  CoreDataHandler().fecthFrmWithCatnameWithBirdAndObservationWithDelete(farmname: farmArrayWithoutAge, necId: necId as NSNumber)
        if dataArr.count > 0 {
        for i in 0..<dataArr.count {

            let obspoint = (dataArr.object(at: i) as AnyObject).value(forKey: "obsPoint") as! Int
            let obsVal = (dataArr.object(at: i) as AnyObject).value(forKey: "objsVisibilty") as! Int

            if obspoint > 0 || obsVal > 0 {
                //print("tum mile ")
                strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm? You have observation recorded for this farm.", comment: "")

                break
            } else {
               strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm?", comment: "")
            }
        }
        } else {
              strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm?", comment: "")
        }

            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString(strMsgforDelete, comment: ""), preferredStyle: .alert)
        let action1 = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { (_) in
            print("Default is pressed.....")
            CoreDataHandler().deleteDataWithPostingIdStep1dataWithfarmName(necId as NSNumber, farmName: farmArrayWithoutAge, { (success) in
                if success == true {
                    CoreDataHandler().deleteDataWithPostingIdStep2dataCaptureNecViewWithfarmName(necId as NSNumber, farmName: farmArrayWithoutAge, { (success) in
                        if success == true {

                            CoreDataHandler().deleteDataWithPostingIdStep2NotesBirdWithFarmName(necId as NSNumber, farmName: farmArrayWithoutAge, { (success) in
                                if success == true {

                                    CoreDataHandler().deleteDataWithPostingIdStep2CameraIamgeWithFarmName(necId as NSNumber, farmName: farmArrayWithoutAge, { (success) in
                                        if success == true {

            self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1neccId(necId as NSNumber) as! [NSManagedObject]

            if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                if  self.captureNecropsy.count == 0 {
                    CoreDataHandler().deleteDataWithPostingId(necId as NSNumber)
                }

            } else if self.captureNecropsy.count == 0 {
                CoreDataHandler().updateFinalizeDataWithNec( necId as NSNumber, finalizeNec: 0)
            }

            self.appDelegate.saveContext()
            self.tableView.reloadData()
                    }
        })
    }})

        }})

    }})
        }
        let action2 = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel) { (_) in
            print("Cancel is pressed......")
            cell?.backgroundColor = UIColor.clear
        }

        alertController.addAction(action1)
        alertController.addAction(action2)

        self.present(alertController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == droperTableView {

            if btnTag == 5 {

                let str = feedProgramArray[indexPath.row] as! FeedProgram
                feedProgramDisplayLabel.text = str.feddProgramNam
                feedId =  str.feedId as! Int
                buttonPreddDroper()

            } else if btnTag == 6 {

                if targetWeigh == 0 {
                    let objMedtricarray = metricArray[indexPath.row]
                    targetWeightLbl.text = objMedtricarray.birdSize

                } else {
                    let objstr = birdArray[indexPath.row]

                    targetWeightLbl.text = objstr.birdSize

                }
                buttonPreddDroper()
            }
        } else if tableView == autoSerchTable {

            farmNameTextField.text = autocompleteUrls.object(at: indexPath.row) as? String

            autoSerchTable.alpha = 0
            farmNameTextField.endEditing(true)
            buttonDroper.alpha = 0
        }

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print(replacementString)

        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {

        } else if ((textField.text?.count)! > 49  ) {
            return false
        }

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if (textField.tag == 101) {
           let farm =  CoreDataHandler().fetchFarmsDataDatabase()
            print(farm)
            let bPredicate: NSPredicate = NSPredicate(format: "farmName contains[cd] %@", newString)

            let complexId = UserDefaults.standard.integer(forKey: "UnlinkComplex")

            fetchcomplexArray = CoreDataHandler().fetchFarmsDataDatabaseUsingCompexId(complexId: complexId as NSNumber).filtered(using: bPredicate) as NSArray

            autocompleteUrls1 = fetchcomplexArray.mutableCopy() as! NSMutableArray

            autocompleteUrls.removeAllObjects()
            autocompleteUrls2.removeAllObjects()

            for i in 0..<autocompleteUrls1.count {

                let f = autocompleteUrls1.object(at: i) as! FarmsList
                let  farmName = f.farmName
                autocompleteUrls2.add(farmName!)

            }
            autocompleteUrls =   self.removeDuplicates(array: autocompleteUrls2)
            autoSerchTable.frame = CGRect(x: 175, y: 240, width: 200, height: 200)
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

            case 11 :
                let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")

                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                let newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString

                return string == numberFiltered && newString.length <= maxLength

            case 1 : break
                //print( "Value of index is either 10 or 15")

            default : break
                //print( "default case")
            }
        }
        return true
    }

    /////////// Picker View Delegate //////

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if btnTag == 0 {
            return HouseNo.count
        } else if btnTag == 1 {
            return AgeOp.count
        } else {
           return NoOFbirds.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        pickerView.showsSelectionIndicator = false

        if btnTag == 0 {
           // return HouseNo[row] as? String
            if let value = HouseNo[row] as? String {
                return value
            } else {
                return nil
            }
        } else if btnTag == 1 {
            myPickerView.showsSelectionIndicator = false
         //   return AgeOp[row] as? String
            if let value = AgeOp[row] as? String {
                return value
            } else {
                return nil
            }
        } else {
            myPickerView.showsSelectionIndicator = false
          //  return NoOFbirds[row] as? String
            if let value = NoOFbirds[row] as? String {
                return value
            } else {
                return nil
            }
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if btnTag == 0 {
         //   lblHouse.text = HouseNo[row] as? String
            if let value = HouseNo[row] as? String {
                return lblHouse.text = value
            } else {
                return lblHouse.text = ""
            }
        } else if btnTag == 1 {
          //  lblAge.text = AgeOp[row] as? String
            if let value = AgeOp[row] as? String {
                return lblAge.text = value
            } else {
                return lblAge.text = ""
            }
        } else {
          //  lblNoBirds.text =   NoOFbirds[row] as? String
            if let value = NoOFbirds[row] as? String {
                return lblNoBirds.text = value
            } else {
                return lblNoBirds.text = ""
            }
        }
    }

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var uprView: UIView!

    @IBAction func uperViewTab(sender: AnyObject) {

        uprView.endEditing(true)
    }

    @IBAction func innerTabView(sender: AnyObject) {
        innerView.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        Dropper.sharedInstance.hideWithAnimation(0.1)

        if (textField == farmNameTextField ) {
            farmNameTextField.returnKeyType = UIReturnKeyType.done
        } else {
            flockIdTextField.returnKeyType = UIReturnKeyType.done
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == farmNameTextField ) {

        if farmNameTextField.text?.isEmpty == true {
            farmNameTextField.layer.borderColor = UIColor.red.cgColor

        } else {
            farmNameTextField.layer.borderColor = UIColor.black.cgColor
        }
      }
    }

    @IBAction func logOutButton(sender: AnyObject) {
        droperTableView.removeFromSuperview()

    }

    @objc func  buttonPressedPopAction() {

        buttonbg1.removeFromSuperview()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1

        if trimmedString == ""{
            farmNameTextField.layer.borderColor = UIColor.red.cgColor

        } else {
            farmNameTextField.layer.borderColor = UIColor.black.cgColor
        }
        if farmNameTextField.text?.isEmpty == true {
            farmNameTextField.layer.borderColor = UIColor.red.cgColor

        } else {
            farmNameTextField.layer.borderColor = UIColor.black.cgColor
        }
           //farmNameTextField.layer.borderColor = UIColor.black.cgColor

        return true
    }

    var index = 10

    @IBAction func nextBttnAction(sender: AnyObject) {

   //     feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            feedProgramDisplayLabel.text = NSLocalizedString("- Select -", comment: "")
        }

        if farmNameTextField.text != "" || feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "") || lblAge.text != "" {

            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please add farm & bird details.", comment: ""))
        } else if captureNecropsy.count == 0 {

            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please add farm & bird details.", comment: ""))

        } else {

            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "capture") as? CaptureNecropsyDataViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        }
    }

    func spacingTextField() {

        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        farmNameTextField.leftView = cusPaddingView
        farmNameTextField.leftViewMode = .always
        let cusPaddingView1 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        flockIdTextField.leftView = cusPaddingView1
        flockIdTextField.leftViewMode = .always
    }

    func allSessionArr() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        let allPostingSessionArr = NSMutableArray()

        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSession
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }

        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyData
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }

        return allPostingSessionArr
    }

    @IBAction func targetWeightBtnAction(_ sender: UIButton) {
        view.endEditing(true)
        btnTag = 6
        if targetWeigh == 0 {

            tableViewpop()
            droperTableView.frame = CGRect( x: 162, y: 385, width: 200, height: 200)
            droperTableView.reloadData()
        } else if targetWeigh == 1 {

            tableViewpop()
            droperTableView.frame = CGRect( x: 162, y: 385, width: 200, height: 200)
            droperTableView.reloadData()

        }
    }
}
