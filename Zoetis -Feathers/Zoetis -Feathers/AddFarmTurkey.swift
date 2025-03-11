//
//  AddFarmTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 20/03/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//
import UIKit
import MBProgressHUD
protocol AddFarmPopTurkey: class {
    func addPopBack ()
}
protocol refreshPageafterAddFeedTurkey {
    func refreshPageafterAddFeedTurkey(_ formName: String)
}
class AddFarmTurkey: UIView, UITextFieldDelegate {
    var asb = Bool()
    var hud: MBProgressHUD = MBProgressHUD()
    var valueStore = Bool()
    var abc = String()

    @IBOutlet weak var farmNameTextField: UITextField!
    @IBOutlet weak var flockIdTextField: UITextField!
    @IBOutlet weak var feedProgramLbl: UILabel!
    @IBOutlet weak var noOfBirdsLbl: UILabel!
    @IBOutlet weak var abfLbl: UILabel!
    @IBOutlet weak var houseNoLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    var delegeterefreshPage: refreshPageafterAddFeedTurkey!

    @IBOutlet weak var ageUperBtnOutlet1: UIButton!
    @IBOutlet weak var mixedBtnOutlet: UIButton!
    @IBOutlet weak var nicholasBtnOutlet: UIButton!
    @IBOutlet weak var hybridBtnOutlet: UIButton!
    @IBOutlet weak var lightHensOutlet: UIButton!
    @IBOutlet weak var heavyHensOutlet: UIButton!
    @IBOutlet weak var sickBtnOutlet: UIButton!
    @IBOutlet weak var tomsOutlet: UIButton!
    var myPickerView = UIPickerView()
    var countFarmId = Int()
    var feedProgramArray = NSArray()
    var abfArray = NSArray()
    var autoSerchTable = UITableView()
    var btnTag = Int()
    let buttonbg = UIButton()
    var necIdExIsting = String()
    var necIdExist = Int()
    var arrayTag = 0
    @IBOutlet weak var feedProgramdropDwnIcon: UIImageView!
    @IBOutlet weak var feedProgramBtnOtlet: UIButton!
    @IBOutlet weak var abfBttnOutlet: UIButton!
    var AddFarmDelegate: AddFarmPopTurkey!
    let buttonbg1 = UIButton()
    let buttonbg2 = UIButton()
    var lngId = NSInteger()
    var postingIdFromExistingNavigate = String()
    var postingIdFromExisting = Int()
    var trimmedString = String()

    var timeStamp1 = String()
    var HouseNo = NSArray()
    var AgeOp = NSArray()
    var NoOFbirds = NSArray()

    var backroundPop = UIButton()
    var  postingId = Int()
    @IBOutlet weak var farmWeightTextField: UITextField!

    @IBOutlet weak var farmWeightLbl: UILabel!
    var  feedId = Int()
    var count = Int()

    var complexTypeFetchArray = NSMutableArray()
    var complexTypeFetchArray1 = NSMutableArray()
    var autocompleteUrls = NSMutableArray()
    var autocompleteUrls1 = NSMutableArray()
    var autocompleteUrls2 = NSMutableArray()
    var fetchcomplexArray = NSArray()
    var fetchcomplexArray1 = NSArray()
    var buttonDroper = UIButton()
    var existingArray = NSMutableArray()
    var fetchcustRep = NSArray()
    @IBOutlet weak var feedDisplyLbl: UILabel!
    var droperTableView  =  UITableView()
    @IBOutlet weak var bgView: UIView!
    let complexDate =  UserDefaults.standard.value(forKey: "date") as? String
    let complexName = UserDefaults.standard.value(forKey: "complex") as? String

    var sexString = String()
    var breedString = String()
    var indexOfSelectedPerson = Int()
    var birdArray: [BirdSizePostingTurkey]  = []
    var metricArray: [BirdSizePostingTurkey]  = []

    override func draw(_ rect: CGRect) {
        let allBireType = CoreDataHandlerTurkey().fetchBirdSizeTurkey()
        if(birdArray.count == 0) {
            print(allBireType)
            for dict in allBireType {
                if (dict as AnyObject).value(forKey: "scaleType") as! String == "Imperial"{
                    birdArray.append(dict as! BirdSizePostingTurkey)
                    print(birdArray)
                } else {
                    metricArray.append(dict as! BirdSizePostingTurkey)
                    print(metricArray)
                }
            }
        }
        valueStore = false

        sexString = "L"
        breedString = "N"
//        if abfLbl.text == "- Select -" {
//            abfLbl.text = ""
//        }

        self.autoSerchTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        flockIdTextField.keyboardType = .numberPad
        flockIdTextField.delegate = self

        abfBttnOutlet.layer.borderWidth = 1
        abfBttnOutlet.layer.cornerRadius = 3.5
        abfBttnOutlet.layer.borderColor = UIColor.black.cgColor

        feedProgramBtnOtlet.layer.borderWidth = 1
        feedProgramBtnOtlet.layer.cornerRadius = 3.5
        feedProgramBtnOtlet.layer.borderColor = UIColor.black.cgColor
        self.droperTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        self.bgView.layer.cornerRadius = 7
        self.bgView.layer.borderWidth = 3
        self.bgView.layer.borderColor = UIColor.white.cgColor
        spacingTextField()
        lightHensOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        nicholasBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            postingId = 0
            feedProgramBtnOtlet.isUserInteractionEnabled = false
            feedProgramBtnOtlet.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.1)

            if lngId == 5 {
                feedDisplyLbl.text = "Programa de alimentación"
            } else {
                feedDisplyLbl.text = "Feed Program"
            }

            feedProgramdropDwnIcon.isHidden = true
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
            feedProgramBtnOtlet.isUserInteractionEnabled = true
            if lngId == 5 {
                feedDisplyLbl.text = "Programa de alimentación *"
            } else {
                feedDisplyLbl.text = "Feed Program *"
            }
            feedProgramdropDwnIcon.isHidden = false
        }

        flockIdTextField.tag = 11
           farmWeightTextField.tag = 12
        flockIdTextField.keyboardType = .numberPad
        flockIdTextField.delegate = self
        farmWeightTextField.keyboardType = .numberPad
        farmWeightTextField.delegate = self
        NoOFbirds = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        AgeOp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]

        HouseNo = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
        feedProgramDisplayLabel?.text = NSLocalizedString("- Select -", comment: "")
        count = 0

        self.spacingTextField()

        self.bgView.layer.cornerRadius = 7
        self.bgView.layer.borderWidth = 3
        self.bgView.layer.borderColor = UIColor.white.cgColor

        sickBtnOutlet.layer.borderWidth = 1
        sickBtnOutlet.layer.borderColor = UIColor.black.cgColor

        flockIdTextField.delegate = self
        feedProgramBtnOtlet.layer.borderWidth = 1
        feedProgramBtnOtlet.layer.borderColor = UIColor.black.cgColor
        farmNameTextField.delegate = self
        farmWeightTextField.delegate = self

        feedProgramBtnOtlet.layer.cornerRadius = 4
        feedProgramBtnOtlet.layer.borderWidth = 1
        feedProgramBtnOtlet.layer.borderColor = UIColor.black.cgColor
        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1
        farmNameTextField.layer.borderColor = UIColor.black.cgColor
        farmWeightTextField.layer.borderWidth = 1
        farmWeightTextField.layer.cornerRadius = 1
        farmWeightTextField.layer.borderColor = UIColor.black.cgColor
        complexTypeFetchArray = CoreDataHandlerTurkey().fetchFarmsDataDatabaseTurkey().mutableCopy() as! NSMutableArray
        buttonDroper.frame = CGRect(x: 0, y: 0, width: 942, height: 428)
        buttonDroper.addTarget(self, action: #selector(CaptureNecropsyStep1Turkey.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.addSubview(buttonDroper)
        autoSerchTable.delegate = self
        autoSerchTable.dataSource = self
        autoSerchTable.delegate = self
        autoSerchTable.layer.cornerRadius = 7
        autoSerchTable.layer.borderWidth = 1
        autoSerchTable.layer.borderColor = UIColor.black.cgColor

        buttonDroper .addSubview(autoSerchTable)
        buttonDroper.alpha = 0

        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        farmWeightTextField.leftView = cusPaddingView
        farmWeightTextField.leftViewMode = .always
        flockIdTextField.layer.borderWidth = 1
        flockIdTextField.layer.borderColor = UIColor.black.cgColor

        birdIndex = UserDefaults.standard.integer(forKey: "birdIndex")
        print(birdIndex)

        if birdIndex == 0 {

            farmWeightLbl.text = "(lbs)"

        } else if birdIndex == 1 {

            farmWeightLbl.text = "(Kgs)"
        }

    }
    var birdIndex = Int()

    func buttonPressedDroper() {
        buttonDroper.alpha = 0
    }

    @IBOutlet weak var feedProgramDisplayLabel: UILabel!
    func removeDuplicates(_ array: NSMutableArray) -> NSMutableArray {
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
    // Mask :- Button Action

    @IBAction func closePopUpAction(_ sender: UIButton) {

        AddFarmDelegate.addPopBack()
        self.removeFromSuperview()

    }

    func saveResCat(_ formName: String, numberofBirds: Int) {
        var  necId = Int()

        if  necIdExIsting == "Exting"{
            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }

        lngId = UserDefaults.standard.integer(forKey: "lngId")
        let resp = CoreDataHandlerTurkey().fetchAllRespiratoryusingLngIdTurkey(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<resp.count {
            for j in 0..<numberofBirds {
                if ((resp.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let resp: RespiratoryTurkey = resp.object(at: i) as! RespiratoryTurkey

                    if resp.measure! == "Y,N" {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId!)

                    } else if ( resp.measure! == "Actual") {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId!)

                    } else {

                        let trimmed = resp.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Resp", obsName: resp.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(resp.observationId!), measure: trimmed, quickLink: resp.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: resp.refId! )
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
        let immu =   CoreDataHandlerTurkey().fetchAllImmuneUsingLngIdTurkey(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<immu.count {
            for j in 0..<numberofBirds {
                if ((immu.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let immune: ImmuneTurkey = immu.object(at: i) as! ImmuneTurkey

                    if immune.measure! == "Y,N" {
                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)

                    } else if ( immune.measure! == "Actual") {

                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let farmWeight =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkeyWithFarmName(formName, necropsyId: necId as NSNumber)
                        let arrdata = farmWeight.object(at: 0) as! CaptureNecropsyDataTurkey
                        var result: Float
                        if arrdata.farmWeight! != ""{
                            result = Float(arrdata.farmWeight!)! / Float(arrdata.noOfBirds!)!
                        } else {
                            result = 0.0
                        }

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: NSInteger(result), index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)
                    } else {

                        let trimmed = immune.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        if immune.refId == 58 {

                            CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[3])!, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId! )

                        } else {

                            CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Immune", obsName: immune.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(immune.observationId!), measure: trimmed, quickLink: immune.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: immune.refId!)

                        }
                    }
                }
            }
        }
    }

    @IBAction func abfBtnAction(_ sender: UIButton) {
        arrayTag = 1
        abfArray = ["Antibiotic free", "Conventional"]

        droperTableView.isHidden = false

        self.tableViewpop()
        droperTableView.frame = CGRect( x: 150, y: 253, width: 202, height: 100)
        droperTableView.reloadData()

    }
    var farmWeightArray = NSArray()
    var butttnTag1 = 0
//
//    @IBAction func farmWeightAction(_ sender: Any) {
//        farmWeightBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
//        arrayTag = 4
//
//        if butttnTag1 == 0 {
//            tableViewpop()
//            droperTableView.frame = CGRect( x: 700, y: 200, width: 205, height: 200)
//            droperTableView.reloadData()
//        } else {
//            tableViewpop()
//            droperTableView.frame = CGRect( x: 700, y: 200, width: 205  , height: 200)
//            droperTableView.reloadData()
//        }
//
//    }
    @IBAction func sickBtnAction(_ sender: UIButton) {

        self.endEditing(true)

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

    @IBAction func feedProgramBtnAction(_ sender: UIButton) {

        arrayTag = 2

        farmNameTextField.resignFirstResponder()
        flockIdTextField.resignFirstResponder()
        feedProgramBtnOtlet.layer.borderColor = UIColor.black.cgColor

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            postingId = 0
        } else if necIdExIsting == "Exting"{

            postingId = necIdExist
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
        }

        feedProgramArray =  CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        self.tableViewpop()
        droperTableView.frame = CGRect( x: 150, y: 192, width: 202, height: 100)

        droperTableView.reloadData()
    }

    @IBAction func donebtnAction(_ sender: UIButton) {

        trimmedString = farmNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            if (trimmedString == "" ||  ageLbl.text == "" ) {

                Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
                if  trimmedString == ""{
                    farmNameTextField.layer.borderColor = UIColor.red.cgColor
                } else if farmWeightTextField.text == ""{
                   // farmWeightTextField.layer.borderColor = UIColor.red.cgColor

                } else if ageLbl.text == ""{
                   ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: UIControl.State())
                }

                //farmNameTextField.text = ""

                if ageLbl.text != "" {

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
        } else if (trimmedString == "" || feedProgramDisplayLabel.text == NSLocalizedString("- Select -", comment: "") ||  ageLbl.text == "" ) {

            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))

          //  farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            feedProgramBtnOtlet.layer.borderColor = UIColor.red.cgColor
            ageUperBtnOutlet1.setImage(UIImage(named: "dialer01-1"), for: UIControl.State())

            if feedProgramDisplayLabel.text != NSLocalizedString("- Select -", comment: "") {
                feedProgramBtnOtlet.layer.borderColor = UIColor.black.cgColor
            }
            if farmNameTextField.text == "" {
                farmNameTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                farmNameTextField.layer.borderColor = UIColor.black.cgColor
            }
            if farmWeightTextField.text == "" {
                //farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                farmWeightTextField.layer.borderColor = UIColor.black.cgColor
            }

            if ageLbl.text != "" {
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

        CoreDataHandlerTurkey().FarmsDataDatabaseTurkey("", stateId: 0, farmName: trimmedString, farmId: 0, countryName: "", countryId: 0, city: "")

        var necId = Int()
        if necIdExIsting == "Exting"{
            necId = necIdExist
        CoreDataHandlerTurkey().updatedPostigSessionwithIsFarmSyncPostingIdTurkey(necId as NSNumber, isFarmSync: false)
            let captdata = CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(necId as NSNumber)
            let countData = captdata.lastObject as! CaptureNecropsyDataTurkey
            count = countData.farmcount as! Int
            if count == 0 {
                count = captdata.count
            }
            count = count+1

        } else {
            necId = UserDefaults.standard.integer(forKey: "necId") as Int
            count =  UserDefaults.standard.integer(forKey: "count")
            if count == 0 {
                count = count+1
            } else {
                count = count+1
            }
        }

//        let fetchFeedByPostingId =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(necId as NSNumber)
//
//        if fetchFeedByPostingId.count > 0 {
//            self.count = fetchFeedByPostingId.count + 1
//        }

        UserDefaults.standard.set(self.count, forKey: "count")

        if necIdExIsting == "Exting"{
            let captdata = CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(necId as NSNumber)
            for i in 0..<captdata.count {
                let farmId = captdata.object(at: i) as! CaptureNecropsyDataTurkey
                countFarmId = farmId.farmId as! Int
            }
            countFarmId = countFarmId+1
        } else {
            countFarmId = UserDefaults.standard.integer(forKey: "farmIdTurkey")
            countFarmId = countFarmId+1
            UserDefaults.standard.set(countFarmId, forKey: "farmIdTurkey")
        }

        //let appendfeedProgramwithCount = String(format:"%d. %@",self.count,trimmedString )
 //   let appendfeedProgramwithCount = String(format:"%d. %@ [%@]",count,trimmedString,self.ageLbl.text!)
        let appendfeedProgramwithCount = String(format: "%d. %@", count, trimmedString )

        let complexId = UserDefaults.standard.integer(forKey: "UnlinkComplex")
        let custMid = UserDefaults.standard.integer(forKey: "unCustId")

        UserDefaults.standard.set(appendfeedProgramwithCount, forKey: "farm")
        UserDefaults.standard.synchronize()
        let captdata = CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(necId as NSNumber)
        if captdata.count>0 {
            timeStamp1 = (captdata.object(at: 0) as AnyObject).value(forKey: "timeStamp") as! String
        } else {
            timeStamp1 =  UserDefaults.standard.value(forKey: "timestamp") as! String
        }

        if abfLbl.text == "Conventional" {

            abfLbl.text = "C"

        } else if abfLbl.text == "Antibiotic free" {

            abfLbl.text = "A"

        } else if abfLbl.text == "- Select -" {

            abfLbl.text = ""

        }

        if farmWeightTextField.text == "."{
            farmWeightTextField.text = ""
        }

        var imageAutoIncrementId = Int()
        imageAutoIncrementId = UserDefaults.standard.integer(forKey: "imageAutoIncrementIdTurkey")
        if imageAutoIncrementId == 0 {
            imageAutoIncrementId = imageAutoIncrementId + 1
        } else {
            imageAutoIncrementId = imageAutoIncrementId + 1
        }
        UserDefaults.standard.set(imageAutoIncrementId, forKey: "imageAutoIncrementIdTurkey")

        CoreDataHandlerTurkey().SaveNecropsystep1Turkey(necId as NSNumber, age: self.ageLbl
            .text!, farmName: appendfeedProgramwithCount, feedProgram: feedProgramDisplayLabel.text!, flockId: flockIdTextField.text!, houseNo: houseNoLbl.text!, noOfBirds: noOfBirdsLbl.text!, sick: asb as NSNumber, necId: necId as NSNumber, compexName: complexName!, complexDate: complexDate!, complexId: complexId as NSNumber, custmerId: custMid as NSNumber, feedId: feedId as NSNumber, isSync: true, timeStamp: timeStamp1, actualTimeStamp: timeStamp1, lngId: 1, farmWeight: farmWeightTextField.text!, abf: abfLbl.text!, breed: breedString, sex: sexString, farmId: countFarmId as NSNumber, imageId: NSNumber(value: imageAutoIncrementId), count: count as NSNumber)

        let numberofbirds = Int(noOfBirdsLbl.text!)

        self.saveSkeletonCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveCocoiCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveGiTractCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveResCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)
        self.saveImmuneCat(appendfeedProgramwithCount, numberofBirds: numberofbirds!)

        self.AddFarmDelegate.addPopBack()
        self.delegeterefreshPage.refreshPageafterAddFeedTurkey(appendfeedProgramwithCount)

        completion(true)
    }

    func saveSkeletonCat(_ formName: String, numberofBirds: Int) {
        var  necId = Int()
        if  necIdExIsting == "Exting"{
            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        let skeletenArr = CoreDataHandlerTurkey().fetchAllSeettingdataWithLngIdTurkey(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<skeletenArr.count {
            for j in 0..<numberofBirds {
                if ((skeletenArr.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {

                    let skleta: SkeletaTurkey = skeletenArr.object(at: i) as! SkeletaTurkey

                    if skleta.measure! == "Y,N" {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)
                    } else if ( skleta.measure! == "Actual") {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)
                    } else {
                        let trimmed = skleta.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        let neciIdStep = UserDefaults.standard.integer(forKey: "necId")

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "skeltaMuscular", obsName: skleta.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(skleta.observationId!), measure: trimmed, quickLink: skleta.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: skleta.refId!)

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
        let cocoii = CoreDataHandlerTurkey().fetchAllCocoiiDataUsinglngIdTurkey(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<cocoii.count {
            for j in 0..<numberofBirds {
                if ((cocoii.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let cocoiDis: CoccidiosisTurkey = cocoii.object(at: i) as! CoccidiosisTurkey

                    if cocoiDis.measure! == "Y,N" {

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    } else if ( cocoiDis.measure! == "Actual") {

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    } else {

                        let trimmed = cocoiDis.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])
                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "Coccidiosis", obsName: cocoiDis.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(cocoiDis.observationId!), measure: trimmed, quickLink: cocoiDis.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: cocoiDis.refId!)
                    }
                }
            }
        }
    }

    func saveGiTractCat(_ formName: String, numberofBirds: Int) {

        var necId = Int()
        if  necIdExIsting == "Exting"{

            necId = necIdExist
        } else {

            necId = UserDefaults.standard.integer(forKey: "necId") as Int
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        let gitract = CoreDataHandlerTurkey().fetchAllGITractDataUsingLngIdTurkey(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray

        for i in 0..<gitract.count {
            for j in 0..<numberofBirds {
                if ((gitract.object(at: i) as AnyObject).value(forKey: "visibilityCheck") as AnyObject).int32Value == 1 {
                    let gitract: GITractTurkey = gitract.object(at: i) as! GITractTurkey

                    if gitract.measure! == "Y,N" {
                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    } else if ( gitract.measure! == "Actual") {

                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: 0, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    } else {
                        let trimmed = gitract.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: "GITract", obsName: gitract.observationField!, formName: formName, obsVisibility: false, birdNo: j + 1 as NSNumber, obsPoint: Int(array[0])!, index: j, obsId: Int(gitract.observationId!), measure: trimmed, quickLink: gitract.quicklinks!, necId: necId as NSNumber, isSync: true, lngId: lngId as NSNumber, refId: gitract.refId!)
                    }
                }
            }
        }
    }
    @IBAction func lightHensBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

            lightHensOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            heavyHensOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            tomsOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }

        sexString = "L"
    }

    @IBAction func heavyHensBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

            lightHensOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            heavyHensOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            tomsOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())

        }
        sexString = "H"
    }

    @IBAction func tomsBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

            lightHensOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            heavyHensOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            tomsOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        }
        sexString = "T"
    }

    @IBAction func nicholasBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

            nicholasBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            hybridBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            mixedBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        breedString = "N"
    }

    @IBAction func hybridBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            nicholasBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            hybridBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            mixedBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        breedString = "H"
    }

    @IBAction func mixedBtnAction(_ sender: UIButton) {

        if sender.isSelected == false {
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())

            nicholasBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            hybridBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            mixedBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        }
        breedString = "M"
    }

    func tableViewpop() {

        buttonbg1.frame = CGRect(x: 0, y: 0, width: 945, height: 454)
        buttonbg1.addTarget(self, action: #selector(AddFarmTurkey.buttonPreddDroper), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.2)
      ///  buttonbg1.backgroundColor = UIColor.red

        self.addSubview(buttonbg1)

        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg1.addSubview(droperTableView)
    }
    func autoSearch () {

        buttonbg2.frame = CGRect(x: 0, y: 0, width: 945, height: 340)
        buttonbg2.addTarget(self, action: #selector(AddFarmTurkey.buttonPreddDroper), for: .touchUpInside)
        buttonbg2.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.2)
        self.addSubview(buttonbg2)
        autoSerchTable.delegate = self
        autoSerchTable.dataSource = self
        autoSerchTable.layer.cornerRadius = 8.0
        autoSerchTable.layer.borderWidth = 1.0
        autoSerchTable.layer.borderColor =  UIColor.white.cgColor
        buttonbg2.addSubview(autoSerchTable)
    }

    @objc func buttonPreddDroper() {
        buttonbg1.removeFromSuperview()
        buttonbg2.removeFromSuperview()

    }

    func spacingTextField() {

        let farmField = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        farmNameTextField.leftView = farmField
        farmNameTextField.leftViewMode = .always

        let flockIdd = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        flockIdTextField.leftView = flockIdd
        flockIdTextField.leftViewMode = .always
    }

    @IBAction func houseNoBtnAction(_ sender: UIButton) {

        self.endEditing(true)

        btnTag = 10
        myPickerView.frame = CGRect(x: 570, y: 51, width: 100, height: 120)
        pickerView()
        var pickerIndex = Int()
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

    func pickerView () {

        buttonbg.frame = CGRect(x: 0, y: 0, width: 945, height: 454)
        buttonbg.addTarget(self, action: #selector(AddFarmTurkey.buttonPressed1), for: .touchUpInside)
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
    @objc func buttonPressed1() {

        buttonbg.removeFromSuperview()
    }
    @IBAction func ageBtnAction(_ sender: UIButton) {
        self.endEditing(true)

        btnTag = 11
        myPickerView.frame = CGRect(x: 570, y: 110, width: 100, height: 120)
        pickerView()
        if(ageLbl.text == "") {
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        } else {
            var pickerIndex = Int()
            for i in 0..<AgeOp.count {
                if (ageLbl.text! == AgeOp[i] as! String) {
                    pickerIndex = i
                    break
                }
            }
        myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)
        }
        myPickerView.reloadInputViews()

        ageUperBtnOutlet1.setImage(UIImage(named: "dialer01"), for: UIControl.State())
    }

    @IBAction func noOfBirdsAction(_ sender: UIButton) {
        self.endEditing(true)

        btnTag = 12
        myPickerView.frame = CGRect(x: 570, y: 173, width: 100, height: 120)
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

    func textFieldDidEndEditing(_ textField: UITextField) {

        if (textField == farmNameTextField ) {

            if farmNameTextField.text?.isEmpty == true {
                farmNameTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                farmNameTextField.layer.borderColor = UIColor.black.cgColor
            }
        }

        if (textField == farmWeightTextField ) {

            if farmWeightTextField.text?.isEmpty == true {
               // farmWeightTextField.layer.borderColor = UIColor.red.cgColor
            } else {
                farmWeightTextField.layer.borderColor = UIColor.black.cgColor
            }
        }

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        farmWeightTextField.returnKeyType = UIReturnKeyType.done

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //delegate method
        textField.resignFirstResponder()

        farmNameTextField.layer.borderWidth = 1
        farmNameTextField.layer.cornerRadius = 1
      //  farmNameTextField.layer.borderColor = UIColor.black.cgColor

        return true
    }
    let digitBeforeDecimal = 3
    let digitAfterDecimal = 3
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
            fetchcomplexArray = CoreDataHandlerTurkey().fetchFarmsDataDatabaseUsingCompexIdTurkey(complexId: complexId as NSNumber).filtered(using: bPredicate) as NSArray
            autocompleteUrls1 = fetchcomplexArray.mutableCopy() as! NSMutableArray
            autocompleteUrls.removeAllObjects()
            autocompleteUrls2.removeAllObjects()

            for i in 0..<autocompleteUrls1.count {

                let f = autocompleteUrls1.object(at: i) as! FarmsListTurkey
                let  farmName = f.farmName
                autocompleteUrls2.add(farmName!)

            }
            autocompleteUrls =   self.removeDuplicates(autocompleteUrls2)
            autoSerchTable.frame = CGRect(x: 150, y: -12, width: 200, height: 100)

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

            case 12 :
                let maxLength = 6
                let currentString: NSString = textField.text! as NSString
                var newString: NSString =
                    currentString.replacingCharacters(in: range, with: string) as NSString
                var result = true
                if textField == farmWeightTextField {

                    let inverseSet = NSCharacterSet(charactersIn: "0123456789").inverted
                    let components = string.components(separatedBy: inverseSet)
                    let filtered = components.joined(separator: "")
                    if filtered == string {
                        return newString.length <= maxLength
                    } else {
                        if string == "." {
                            let countdots = textField.text!.components(separatedBy: ".").count - 1
                            if countdots == 0 {
                                print(newString.length)

                                if (newString.length) > 6 {
                                    newString = newString.substring(to: newString.length - 1) as NSString
                                    print("heloo")
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

            default : break
            }
        }
        return true
    }

func checkCharacter( _ inputChar: String, textfield11: UITextField ) -> Bool {

    let newCharacters = CharacterSet(charactersIn: inputChar)
    let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
    if boolIsNumber == true {
        return true
    } else {

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
    }}
}
// MARK: - Picker View
extension AddFarmTurkey: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if (btnTag == 10) {

            if let value = HouseNo.count as? Int {
                return value
            } else {
                return 0
            }

         //   return HouseNo.count

        } else if ( btnTag == 11) {
            if let value = AgeOp.count as? Int {
                return value
            } else {
                return 0
            }

        //    return AgeOp.count

        } else if (btnTag == 12) {
            if let value = NoOFbirds.count as? Int {
                return value
            } else {
                return 0
            }

         //   return NoOFbirds.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        pickerView.showsSelectionIndicator = false

        if btnTag == 10 {

//            if let houseCheck = HouseNo[row] as? String {
//
//                return HouseNo[row] as! String
//            }else {
//                return nil
//            }

            if let value = HouseNo[row] as? String {
                return value
            } else {
                return nil
            }

        } else if btnTag == 11 {

            myPickerView.showsSelectionIndicator = false

//            if let ageCheck = AgeOp[row] as? String {
//            return AgeOp[row] as? String
//            }
            if let value = AgeOp[row] as? String {
                return value
            } else {
                return nil
            }

        } else {
//            if let noOfBirdCheck = NoOFbirds[row] as? String {
//            return NoOFbirds[row] as? String
//            }
            myPickerView.showsSelectionIndicator = false

            if let value = NoOFbirds[row] as? String {
                return value
            } else {
                return nil
            }
        }
    //    return abc
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if btnTag == 10 {

            if let value = HouseNo[row] as? String {
                return houseNoLbl.text = value
            } else {
                return houseNoLbl.text = ""
            }

        } else if btnTag == 11 {

            if let ageCheck = AgeOp[row] as? String {
            return ageLbl.text = ageCheck
            } else {
            return ageLbl.text = ""
        }
        } else {

            if let noOfBirdCheck = NoOFbirds[row] as? String {
           return noOfBirdsLbl.text = noOfBirdCheck

            } else {
                return noOfBirdsLbl.text = ""
            }
        }
        myPickerView.endEditing(true)
        buttonbg.removeFromSuperview()
    }
}
// MARK: - Table View

extension AddFarmTurkey: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == droperTableView {

            if arrayTag == 1 {

                return abfArray.count

            } else  if arrayTag == 2 {

                return feedProgramArray.count
            } else if arrayTag == 4 {

                if butttnTag1 == 0 {
                return metricArray.count
            } else {
                return birdArray.count
            }
            }
        } else if tableView == autoSerchTable {
            return autocompleteUrls.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        if tableView == droperTableView {

            if arrayTag == 1 {
                let vet  = abfArray.object(at: indexPath.row) as! String
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet
                return cell

            } else if arrayTag == 2 {

                let vet: FeedProgramTurkey = feedProgramArray.object(at: indexPath.row) as! FeedProgramTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet.feddProgramNam
                return cell

            } else if arrayTag == 4 {

                if butttnTag1 == 0 {
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = metricArray[indexPath.row].birdSize

                } else {
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = birdArray[indexPath.row].birdSize
                }
              }
            } else if tableView == autoSerchTable {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!

            if indexPath.row  < autocompleteUrls.count {
                cell.textLabel?.text = autocompleteUrls.object(at: indexPath.row) as? String
            }
            return cell
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == droperTableView {

            if arrayTag == 1 {

                let str = abfArray[indexPath.row] as! String
                abfLbl.text = str
                buttonPreddDroper()

            } else if arrayTag == 2 {
                let str = feedProgramArray[indexPath.row] as! FeedProgramTurkey
                feedProgramDisplayLabel.text = str.feddProgramNam
                feedId = str.feedId as! Int
                buttonPreddDroper()

            } else if arrayTag == 4 {

                if butttnTag1 == 0 {
                    let objMedtricarray = metricArray[indexPath.row]
                    indexOfSelectedPerson = indexPath.row
                    print(indexOfSelectedPerson)

                } else {
                    let objstr = birdArray[indexPath.row]
                    indexOfSelectedPerson = indexPath.row
                    print(indexOfSelectedPerson)
                }
                valueStore = true
            }
            buttonPreddDroper()

        } else if tableView == autoSerchTable {
            farmNameTextField.text = autocompleteUrls.object(at: indexPath.row) as? String
            autoSerchTable.alpha = 0
            farmNameTextField.endEditing(true)
            buttonDroper.alpha = 0
        }
    }
}
