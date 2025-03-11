//  AddFarm.swift
//  Zoetis -Feathers
//  Created by "" on 09/11/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit
import MBProgressHUD
protocol AddFarmPop: class {
    func anv ()
}
protocol refreshPageafterAddFeed {
    func refreshPageafterAddFeed(_ formName: String)
}

class AddFarm: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    var hud: MBProgressHUD = MBProgressHUD()
    var AddFarmDelegate: AddFarmPop!
    var asb = Bool()
    var delegeterefreshPage: refreshPageafterAddFeed!
    var postingIdFromExistingNavigate = String()
    var postingIdFromExisting = Int()
    var trimmedString = String()
    var countFarmId = Int()
    var timeStamp1 = String()
    var HouseNo = NSArray()
    var AgeOp = NSArray()
    var NoOFbirds = NSArray()
    var btnTag = Int()
    let buttonbg = UIButton()
    var myPickerView = UIPickerView()
    var pickerIndex = Int()
    var backroundPop = UIButton()
    var  postingId = Int()
    var  feedId = Int()
    var feedProgramArray = NSArray()
    var count = Int()
    var necIdExist = Int()
    var necIdExIsting = String()
    let buttonbg1 = UIButton()
    var lngId = NSInteger()
    var droperTableView  =  UITableView()
    @IBOutlet weak var farmNameTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var feedProgramLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var houseNoLbl: UILabel!
    @IBOutlet weak var flockIdTextField: UITextField!
    @IBOutlet weak var noOfBirdsLbl: UILabel!
    @IBOutlet weak var sickBtnOutlet: UIButton!
    @IBOutlet weak var feedProgramDisplayLabel: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var feedProgramOutlet: UIButton!
    @IBOutlet weak var ageUperBtnOutlet1: UIButton!

    @IBOutlet weak var feedDisplyLbl: UILabel!
    @IBOutlet weak var feedProgramdropDwnIcon: UIImageView!
    /********************************/

    var complexTypeFetchArray = NSMutableArray()
    var complexTypeFetchArray1 = NSMutableArray()
    var autoSerchTable = UITableView()
    var autocompleteUrls = NSMutableArray()
    var autocompleteUrls1 = NSMutableArray()
    var autocompleteUrls2 = NSMutableArray()
    var fetchcomplexArray = NSArray()
    var fetchcomplexArray1 = NSArray()
    var buttonDroper = UIButton()
    var existingArray = NSMutableArray()
    var fetchcustRep = NSArray()
    let cellReuseIdentifier = "cell"
    let complexDate =  UserDefaults.standard.value(forKey: "date") as? String
    let complexName = UserDefaults.standard.value(forKey: "complex") as? String

    class func instanceFromNib() -> UIView {
        return UINib(nibName: "AddFarm", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func removeDuplicates(_ array: NSMutableArray) -> NSMutableArray {
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

    func removeDuplicatesOnArr(_ array: NSArray) -> NSArray {
        var encountered = Set<String>()
        let result = NSMutableArray()
        for value in array {
            if encountered.contains(value as! String) {
                // Do not add a duplicate element.
            } else {
                // Add value to the set.
                encountered.insert(value as! String)
                // ... Append the value.
                result.add(value as! String)
            }
        }

        var arra = NSArray()
        arra = result.mutableCopy()  as! NSArray

        return arra
    }

    override func draw(_ rect: CGRect) {

        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            postingId = 0
            feedProgramOutlet.isUserInteractionEnabled = false
            feedProgramOutlet.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.1)

            if lngId == 3 {
                feedDisplyLbl.text = "Programme alimentaire"
            } else if lngId == 5 {
                feedDisplyLbl.text = "Programa de alimentación"
            } else if lngId == 1 {
                feedDisplyLbl.text = "Feed Program"
            }

            feedProgramdropDwnIcon.isHidden = true
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
            feedProgramOutlet.isUserInteractionEnabled = true
            if lngId == 3 {
                feedDisplyLbl.text = "Programme alimentaire *"
            } else if lngId == 5 {
                feedDisplyLbl.text = "Programa de alimentación *"
            } else if lngId == 1 {
                feedDisplyLbl.text = "Feed Program *"
            }

            feedProgramdropDwnIcon.isHidden = false

        }

        flockIdTextField.tag = 11
        flockIdTextField.keyboardType = .numberPad
        flockIdTextField.delegate = self

        NoOFbirds = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        AgeOp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]

        HouseNo = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
        feedProgramDisplayLabel?.text = NSLocalizedString("- Select -", comment: "")
        count = 0

        self.spacingTextField()

        self.bgView.layer.cornerRadius = 7
        self.bgView.layer.borderWidth = 3
        self.bgView.layer.borderColor = UIColor.white.cgColor

        flockIdTextField.delegate = self
        feedProgramOutlet.layer.borderWidth = 1
        feedProgramOutlet.layer.borderColor = UIColor.gray.cgColor
        farmNameTextField.delegate = self
        feedProgramOutlet.layer.cornerRadius = 4
        feedProgramOutlet.layer.borderWidth = 1
        feedProgramOutlet.layer.borderColor = UIColor.gray.cgColor
        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1
        farmNameTextField.layer.borderColor = UIColor.black.cgColor

        complexTypeFetchArray = CoreDataHandler().fetchFarmsDataDatabase().mutableCopy() as! NSMutableArray

        //complexTypeFetchArray = self.removeDuplicates(complexTypeFetchArray1)
        //        if  let data: NSArray = CoreDataHandler().fetchFarmsDataDatabase()
        //        {
        //            fetchcustRep = data
        //        }

        buttonDroper.frame = CGRect(x: 0, y: 0, width: 994, height: 339)
        buttonDroper.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.addSubview(buttonDroper)
        autoSerchTable.delegate = self
        autoSerchTable.dataSource = self
        autoSerchTable.delegate = self
        autoSerchTable.layer.cornerRadius = 7
        autoSerchTable.layer.borderWidth = 1
        autoSerchTable.layer.borderColor = UIColor.black.cgColor
        self.autoSerchTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        buttonDroper .addSubview(autoSerchTable)
        buttonDroper.alpha = 0
        flockIdTextField.layer.borderWidth = 1
        flockIdTextField.layer.borderColor = UIColor.black.cgColor
    }

    func buttonPressedDroper() {

        buttonDroper.alpha = 0
    }

    func spacingTextField() {

        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        farmNameTextField.leftView = cusPaddingView
        farmNameTextField.leftViewMode = .always
        let cusPaddingView1 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        flockIdTextField.leftView = cusPaddingView1
        flockIdTextField.leftViewMode = .always

    }

    @IBAction func sickBtnAction(_ sender: AnyObject) {
        self.endEditing(true)

        if (sender.tag == 200) {
            sickBtnOutlet.isSelected = !sickBtnOutlet.isSelected
            if  sickBtnOutlet.isSelected {
                sickBtnOutlet.isSelected = true

                sender.setImage(UIImage(named: "Check_")!, for: UIControl.State())
                asb = true
                ////print(asb)

            } else {

                sickBtnOutlet.setImage(nil, for: UIControl.State())
                sickBtnOutlet.setImage(UIImage(named: "Uncheck_")!, for: UIControl.State())
                asb = false
                ////print(asb)
            }
        } else {

        }

    }

    @IBAction func doneBtnAction(_ sender: AnyObject) {

        trimmedString = farmNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            if (trimmedString == "" ||  lblAge.text == "" ) {

                Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))

                if trimmedString == ""{
                     farmNameTextField.layer.borderColor = UIColor.red.cgColor
                    farmNameTextField.text = ""
                }

                ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: UIControl.State())

                if lblAge.text != "" {
                    ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: UIControl.State())
                }
            } else {
                feedProgramDisplayLabel.text = ""

                self.hudAnimated1()

                self.insertData({ (status) in
                    if status == true {
                        self.hud.hide(animated: true)
                    }
                })

            }

        } else if (trimmedString == "" || feedProgramDisplayLabel.text == NSLocalizedString("- Select -", comment: "") ||  lblAge.text == "" ) {

            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))

            feedProgramOutlet.layer.borderColor = UIColor.red.cgColor

            if trimmedString == ""{
                farmNameTextField.layer.borderColor = UIColor.red.cgColor
                farmNameTextField.text = ""
            }

            ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: UIControl.State())

            if feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "") {

                feedProgramOutlet.layer.borderColor = UIColor.gray.cgColor
            }

            if lblAge.text != "" {

                ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: UIControl.State())
            }
        } else {

            self.hudAnimated1()

            self.insertData({ (status) in
                if status == true {
                    self.hud.hide(animated: true)
                }
            })
        }
    }

    func hudAnimated1() {

        hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.contentColor = UIColor.white
        hud.bezelView.color = UIColor.black
        hud.label.text = "Adding Farm..."
    }

    func insertData( _ completion: (_ status: Bool) -> Void) {
        CoreDataHandler().FarmsDataDatabase("", stateId: 0, farmName: trimmedString, farmId: 0, countryName: "", countryId: 0, city: "")

        var  necId = Int()

        if  necIdExIsting == "Exting"{

            necId = necIdExist
        CoreDataHandler().updateisSyncTrueOnPostingSessionISSync(necId as NSNumber)
             let captdata = CoreDataHandler().FetchNecropsystep1NecId(necId as NSNumber)
            let countData = captdata.lastObject as! CaptureNecropsyData
            count = countData.farmcount as! Int
            if count == 0 {
                count = captdata.count
            }
            count = count+1

            //print(countData)
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int

            count =  UserDefaults.standard.integer(forKey: "count")
            if count == 0 {
                count = count+1
            } else {
                count = count+1
            }
        }

        UserDefaults.standard.set(self.count, forKey: "count")

        let appendfeedProgramwithCount = String(format: "%d. %@", self.count, trimmedString )
        let complexId = UserDefaults.standard.integer(forKey: "UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey: "unCustId")

        UserDefaults.standard.set(appendfeedProgramwithCount, forKey: "farm")
        UserDefaults.standard.synchronize()
        let captdata = CoreDataHandler().FetchNecropsystep1NecId(necId as NSNumber)
        if captdata.count>0 {
            timeStamp1 = (captdata.object(at: 0) as AnyObject).value(forKey: "timeStamp") as! String
        } else {
            timeStamp1 =  UserDefaults.standard.value(forKey: "timestamp") as! String
        }
             if  necIdExIsting == "Exting"{
                    let captdata = CoreDataHandler().FetchNecropsystep1NecId(necId as NSNumber)
                for i in 0..<captdata.count {
                    let farmId = captdata.object(at: i) as! CaptureNecropsyData
                    countFarmId = farmId.farmId as! Int
                }
                countFarmId = countFarmId+1
        } else {
                countFarmId = UserDefaults.standard.integer(forKey: "farmId")
                countFarmId = countFarmId+1
                UserDefaults.standard.set(countFarmId, forKey: "farmId")

        }

           print(countFarmId)
        var imageAutoIncrementId = Int()

        imageAutoIncrementId = UserDefaults.standard.integer(forKey: "imageAutoIncrementId")

        if imageAutoIncrementId == 0 {

            imageAutoIncrementId = imageAutoIncrementId + 1
        } else {

            imageAutoIncrementId = imageAutoIncrementId + 1
        }

        UserDefaults.standard.set(imageAutoIncrementId, forKey: "imageAutoIncrementId")

        CoreDataHandler().SaveNecropsystep1(necId as NSNumber, age: self.lblAge
            .text!, farmName: appendfeedProgramwithCount, feedProgram: feedProgramDisplayLabel.text!, flockId: flockIdTextField.text!, houseNo: houseNoLbl.text!, noOfBirds: noOfBirdsLbl.text!, sick: asb as NSNumber, necId: necId as NSNumber, compexName: complexName!, complexDate: complexDate!, complexId: complexId as NSNumber, custmerId: custMid as NSNumber, feedId: feedId as NSNumber, isSync: true, timeStamp: timeStamp1, actualTimeStamp: timeStamp1, lngId: 1, farmId: countFarmId as NSNumber, imageId: NSNumber(value: imageAutoIncrementId), count: count as NSNumber)

        let numberofbirds = Int(noOfBirdsLbl.text!)
        let data =  CoreDataHandler().FetchNecropsystep1neccId(necId as NSNumber)
        print( data)

        self.saveSkeletonCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveCocoiCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveGiTractCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveResCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveImmuneCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.AddFarmDelegate.anv()
        self.delegeterefreshPage.refreshPageafterAddFeed(appendfeedProgramwithCount)

        completion(true)
    }

    func saveSkeletonCat(_ formName: String, numberofBirds: Int) {
        var necId = Int()

        if necIdExIsting == "Exting"{

            necId = necIdExist
        } else {
            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }

        lngId = UserDefaults.standard.integer(forKey: "lngId")
        let skeletenArr = CoreDataHandler().fetchAllSeettingdataWithLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<skeletenArr.count {
            for j in 0..<numberofBirds {
                if ((skeletenArr.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {

                    let skleta: Skeleta = skeletenArr.object(at: i) as! Skeleta

                    if skleta.measure! == "Y,N" {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)
                    } else if ( skleta.measure! == "Actual") {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)
                    } else {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        let neciIdStep = UserDefaults.standard.integer(forKey: "necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)

                    }

                }

            }
        }

    }

    func saveCocoiCat(_ formName: String, numberofBirds: Int) {

        var  necId = Int()

        if  necIdExIsting == "Exting"{

            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        let cocoii = CoreDataHandler().fetchAllCocoiiDataUsinglngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<cocoii.count {
            for j in 0..<numberofBirds {
                if ((cocoii.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let cocoiDis: Coccidiosis = cocoii.object(at: i) as! Coccidiosis

                    if cocoiDis.measure! == "Y,N" {

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")
                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    } else if ( cocoiDis.measure! == "Actual") {

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    } else {
                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    }
                }

            }
        }

    }

    func saveGiTractCat(_ formName: String, numberofBirds: Int) {

        var  necId = Int()

        if  necIdExIsting == "Exting"{

            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        let gitract = CoreDataHandler().fetchAllGITractDataUsingLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<gitract.count {
            for j in 0..<numberofBirds {
                if ((gitract.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let gitract: GITract = gitract.object(at: i) as! GITract

                    if gitract.measure! == "Y,N" {
                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        // let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    } else if ( gitract.measure! == "Actual") {

                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    } else {
                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")
                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    }

                }

            }
        }
    }

    func saveResCat(_ formName: String, numberofBirds: Int) {
        var  necId = Int()

        if  necIdExIsting == "Exting"{

            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }

        lngId = UserDefaults.standard.integer(forKey: "lngId")
        let resp = CoreDataHandler().fetchAllRespiratoryusingLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<resp.count {
            for j in 0..<numberofBirds {
                if ((resp.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let resp: Respiratory = resp.object(at: i) as! Respiratory

                    if resp.measure! == "Y,N" {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        // let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId!)
                    } else if ( resp.measure! == "Actual") {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId!)
                    } else {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        // let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")
                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId! )
                    }

                }

            }
        }

    }

    func saveImmuneCat(_ formName: String, numberofBirds: Int) {
        var  necId = Int()

        if  necIdExIsting == "Exting"{

            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        UserDefaults.standard.synchronize()
        let immu =   CoreDataHandler().fetchAllImmuneUsingLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<immu.count {
            for j in 0..<numberofBirds {
                if ((immu.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let immune: Immune = immu.object(at: i) as! Immune

                    if immune.measure! == "Y,N" {
                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)
                    } else if ( immune.measure! == "Actual") {

                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")

                        CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)
                    } else {

                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        if immune.refId == 58 {

                            CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[3])!, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId! )

                        } else {

                            //let neciIdStep = NSUserDefaults.standardUserDefaults().integerForKey("necId")
                            CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)

                        }

                    }

                }

            }
        }

    }

    @IBAction func crossBtnAction(_ sender: AnyObject) {

        AddFarmDelegate.anv()
        self.removeFromSuperview()

    }

    @IBAction func houseNoBtnAction(_ sender: AnyObject) {

        self.endEditing(true)

        btnTag = 0
        myPickerView.frame = CGRect(x: 572, y: 45, width: 100, height: 120)
        pickerView()
        if(houseNoLbl.text == "") {
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        } else {
            for i in 0..<HouseNo.count {

                if (houseNoLbl.text! == HouseNo[i] as! String) {
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        myPickerView.reloadInputViews()
    }

    @IBAction func ageBtnAction(_ sender: AnyObject) {
        self.endEditing(true)

        ageDaata()
    }
    func ageDaata() {

        btnTag = 1
        myPickerView.frame = CGRect(x: 572, y: 122, width: 100, height: 120)
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

        ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: UIControl.State())

    }

    @IBAction func noOfbirdsAction(_ sender: AnyObject) {
        self.endEditing(true)

        btnTag = 2
        myPickerView.frame = CGRect(x: 785, y: 122, width: 100, height: 120)
        pickerView()
        var pickerIndex = Int()
        for i in 0..<NoOFbirds.count {

            if (noOfBirdsLbl.text! == NoOFbirds[i] as! String) {
                pickerIndex = i
                break
            }
        }
        myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        myPickerView.reloadInputViews()

    }

    func buttonPressed1() {
        // self.view.endEditing(true)
        buttonbg.removeFromSuperview()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (btnTag == 0) {

            if let value = HouseNo.count as? Int {
                return value
            } else {
                return 0
            }

          //  return HouseNo.count

        } else if ( btnTag == 1) {

            if let value = AgeOp.count as? Int {
                return value
            } else {
                return 0
            }

          //  return AgeOp.count

        } else if (btnTag == 2) {
            if let value = NoOFbirds.count as? Int {
                return value
            } else {
                return 0
            }

            //return NoOFbirds.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        pickerView.showsSelectionIndicator = false

        if btnTag == 0 {

            if let value = HouseNo[row] as? String {
                return value
            } else {
                return nil
            }

           // return HouseNo[row] as? String
        } else if btnTag == 1 {
            myPickerView.showsSelectionIndicator = false

            if let value = AgeOp[row] as? String {
                return value
            } else {
                return nil
            }

        //    return AgeOp[row] as? String
        } else {
            myPickerView.showsSelectionIndicator = false
            if let value = NoOFbirds[row] as? String {
                return value
            } else {
                return nil
            }
        //    return NoOFbirds[row] as? String
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if btnTag == 0 {

            if let value = HouseNo[row] as? String {
                return houseNoLbl.text = value
            } else {
                return houseNoLbl.text = ""
            }

          //  houseNoLbl.text = HouseNo[row] as? String
        } else if btnTag == 1 {

            if let ageCheck = AgeOp[row] as? String {
                return lblAge.text = ageCheck
            } else {
                return lblAge.text = ""
            }

           // lblAge.text = AgeOp[row] as? String
        } else {

            if let noOfBirdCheck = NoOFbirds[row] as? String {
                return noOfBirdsLbl.text = noOfBirdCheck

            } else {
                return noOfBirdsLbl.text = ""
            }

            //noOfBirdsLbl.text =   NoOFbirds[row] as? String
        }
        myPickerView.endEditing(true)
        buttonbg.removeFromSuperview()
    }

    ///////////////////
    @IBAction func feedProgramBttn(_ sender: AnyObject) {

        farmNameTextField.resignFirstResponder()
        flockIdTextField.resignFirstResponder()
        feedProgramOutlet.layer.borderColor = UIColor.black.cgColor

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            postingId = 0
        } else if necIdExIsting == "Exting"{

            postingId = necIdExist
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
        }

        //postingId = NSUserDefaults.standardUserDefaults().integerForKey("postingId")
        ////print(postingId)
        feedProgramArray =  CoreDataHandler().FetchFeedProgram(postingId as NSNumber)
        self.tableViewpop()
        droperTableView.frame = CGRect( x: 147, y: 205, width: 200, height: 100)
        droperTableView.reloadData()

    }

    func tableViewpop() {

        buttonbg1.frame = CGRect(x: 0, y: 0, width: 945, height: 340)

        buttonbg1.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPreddDroper), for: .touchUpInside)

        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.2)
        self.addSubview(buttonbg1)

        droperTableView.delegate = self
        droperTableView.dataSource = self

        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.white.cgColor

        buttonbg1.addSubview(droperTableView)

    }
    func pickerView () {

        buttonbg.frame = CGRect(x: 0, y: 0, width: 945, height: 340)
        // X, Y, width, height
        buttonbg.addTarget(self, action: #selector(captureNecropsyStep1Data.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.addSubview(buttonbg)
        myPickerView.layer.borderWidth = 1
        myPickerView.layer.cornerRadius = 5
        myPickerView.layer.borderColor = UIColor.clear.cgColor
        myPickerView.dataSource = self
        myPickerView.delegate = self

        myPickerView.backgroundColor = UIColor.white

        buttonbg.addSubview(myPickerView)

    }
    func buttonPreddDroper() {

        buttonbg1.removeFromSuperview()
    }

    ///TableView...///

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == droperTableView {
            return feedProgramArray.count
        } else if tableView == autoSerchTable {

            return autocompleteUrls.count
        }
        return 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == autoSerchTable {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            //let cuatomerep : FarmsList = autocompleteUrls.objectAtIndex(indexPath.row) as! FarmsList

            if indexPath.row  < autocompleteUrls.count {
                cell.textLabel?.text = autocompleteUrls.object(at: indexPath.row) as? String
            }
            return cell

        } else {

            let cell = UITableViewCell()

            let vet: FeedProgram = feedProgramArray.object(at: indexPath.row) as! FeedProgram
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel!.text = vet.feddProgramNam
            return cell

        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ////print("You selected cell #\(indexPath.row)!")

        if tableView == droperTableView {
            let str = feedProgramArray[indexPath.row] as! FeedProgram
            feedProgramDisplayLabel.text = str.feddProgramNam

            feedId = str.feedId as! Int

            buttonPreddDroper()

        } else if tableView == autoSerchTable {
            //            let cuatomerep : FarmsList = autocompleteUrls.objectAtIndex(indexPath.row) as! FarmsList
            //            cell.textLabel?.text = autocompleteUrls.objectAtIndex(indexPath.row) as? String
            farmNameTextField.text = autocompleteUrls.object(at: indexPath.row) as? String

            //NSUserDefaults.standardUserDefaults().setObject(farmNameTextField.text, forKey: "complex")
            autoSerchTable.alpha = 0
            farmNameTextField.endEditing(true)
            buttonDroper.alpha = 0
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()

        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1
     //   farmNameTextField.layer.borderColor = UIColor.black.cgColor
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {

        } else if ((textField.text?.characters.count)! > 50  ) {
            return false
        }
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if (textField.tag == 101) {

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
            autocompleteUrls =   self.removeDuplicates(autocompleteUrls2)

            // autocompleteUrls = fetchcomplexArray.mutableCopy() as! NSMutableArray
            //            autoSerchTable.frame = CGRectMake(150, 40, 250, 200)
            autoSerchTable.frame = CGRect(x: 150, y: 0, width: 200, height: 100)

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
}
