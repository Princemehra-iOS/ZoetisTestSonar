//
 //  FeedProgramViewController.swift
 //  Zoetis -Feathers
 //
 //  Created by "" on 07/10/16.
 //  Copyright © 2016 "". All rights reserved.
 //f

 import UIKit
 import CoreData
 import Alamofire
 import ReachabilitySwift

 class FeedProgramViewController: UIViewController, popUPnavigation, userLogOut, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, syncApi {

    var isClickOnAnyField = Bool()
    let objApiSync = ApiSync()

    var exitPopUP: popUP!

    @IBOutlet weak var syncFinalizedCount: UILabel!
    var finializeCount = NSNumber()
    @IBOutlet weak var doneBtnOutlet: UIButton!
    var buttoCocodaciVac = UIButton()
    var flag = 1
    var strYesPop = String()
    var btnTagsave = Int()
    @objc var count: Int = 0
    var index = 10
    var feedArr = NSMutableArray()
    var feedNameArr = NSMutableArray()
    var farmArrayTrue = NSArray()
    var feedIdFromFarm = Int()
    var backBtnnFrame = UIButton()
    var mPid = Int()

    @IBOutlet weak var farmTableView: UITableView!
    @IBOutlet weak var selectFarmsLabel: UILabel!
    @IBOutlet weak var addFarmSelectLbl: UILabel!
    @IBOutlet weak var addFarmDroper: UIImageView!
    @IBOutlet weak var addFarmBtnOutlet: UIButton!
    //  var addFarmArray : [String] = []
    var addFarmArrayWithUnCheckForm = NSMutableArray()
    var addFarmArray = NSMutableArray()
    var addFarmArray1 = NSMutableArray()
    var set = NSSet()
    var FarmArray = NSMutableArray()
    var postingIdFromExisting = Int()
    var FeedIdFromExisting = Int()
    var postingIdFromExistingNavigate = String()

    @IBOutlet weak var feedType5CocciOutlet: UIButton!
    @IBOutlet weak var feedType6CocciOutlet: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fivthMoleculelBL: UILabel!
    @IBOutlet weak var sixthMoleculeLbl: UILabel!
    @IBOutlet weak var feed5textField: UITextField!
    @IBOutlet weak var feed6TextField: UITextField!
    @IBOutlet weak var from5TextField: UITextField!
    @IBOutlet weak var from6teXTfield: UITextField!
    @IBOutlet weak var toFeed5TextFeidl: UITextField!
    @IBOutlet weak var toFeed6TextField: UITextField!
    /////

    @IBOutlet weak var moleculeFeedType1Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType2Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType3Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType4Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType5Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType6Alternativ: UITextField!

    @IBOutlet weak var altrNativeDosage5Text: UITextField!
    @IBOutlet weak var altrNativeDosage6Text: UITextField!
    @IBOutlet weak var from5TextAlternative: UITextField!
    @IBOutlet weak var from6TextAlternative: UITextField!
    @IBOutlet weak var to5TextAlternative: UITextField!
    @IBOutlet weak var to6TextAlternative: UITextField!
    ///////
    @IBOutlet weak var moleculeFeedType1MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType2MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType3MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType4MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType5MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType6MyCoxtin: UITextField!

    @IBOutlet weak var feed5DisplayLblMycoxtin: UILabel!
    @IBOutlet weak var feed6DisplayLblMycoxtin: UILabel!
    @IBOutlet weak var myCoxtin5DosageTextField: UITextField!
    @IBOutlet weak var myCoxtin6DosageTextField: UITextField!
    @IBOutlet weak var from5TextFieldMycoxtin: UITextField!
    @IBOutlet weak var from6TextFieldMycoxtin: UITextField!
    @IBOutlet weak var to5TextFieldMycoxtin: UITextField!
    @IBOutlet weak var to6TextFieldMycoxtin: UITextField!
    ////////

    @IBOutlet weak var antiMoleculeFeedType1: UITextField!
    @IBOutlet weak var antiMoleculeFeedType2: UITextField!
    @IBOutlet weak var antiMoleculeFeedType3: UITextField!
    @IBOutlet weak var antiMoleculeFeedType4: UITextField!
    @IBOutlet weak var antiMoleculeFeedType5: UITextField!
    @IBOutlet weak var antiMoleculeFeedType6: UITextField!

    @IBOutlet weak var antiDosageFivthTextField: UITextField!
    @IBOutlet weak var antiDosageSixTextField: UITextField!
    @IBOutlet weak var antiFromFivthTextField: UITextField!
    @IBOutlet weak var antiFromSixthTextField: UITextField!
    @IBOutlet weak var antiToDurationfivthTextField: UITextField!
    @IBOutlet weak var antiToDurationSixTextField: UITextField!
    @IBOutlet weak var sixMoleculeLabelAnti: UILabel!
    @IBOutlet weak var fivthMoleculeLabel: UILabel!

    @IBOutlet weak var coccidsisStartrDrinking: UILabel!
    @IBOutlet weak var coccidsisGrowerDrinking: UILabel!
    @IBOutlet weak var coccidiosisWdDrinking: UILabel!
    @IBOutlet weak var cocciFinisherDrinkingWater: UILabel!
    var lngId = NSInteger()
    @IBOutlet weak var myCoxtinStarterDrinking: UILabel!
    @IBOutlet weak var myCoxtinGrowerDrinking: UILabel!
    @IBOutlet weak var myCoxtinFinisherDrinking: UILabel!
    @IBOutlet weak var myCoxtinWDDrinking: UILabel!
    /****************************************************/

    @IBOutlet weak var myCoxtinStarterDosage: UITextField!
    @IBOutlet weak var myCoxtinGrowerDosage: UITextField!
    @IBOutlet weak var myCoxtinFinisherDosge: UITextField!
    @IBOutlet weak var myCoxtinWDDosage: UITextField!

    /************************************************************/

    @IBOutlet weak var antiboticStarterDrinking: UILabel!
    @IBOutlet weak var antiboticGrowerDrink: UILabel!
    @IBOutlet weak var antiboticFinisherDrinking: UILabel!
    @IBOutlet weak var antiboticWDDrinking: UILabel!
    @IBOutlet weak var alternatieStarterDrinking: UILabel!
    @IBOutlet weak var alternatieGrowerDrink: UILabel!
    @IBOutlet weak var alternatieFinisherDrinking: UILabel!
    @IBOutlet weak var alternatieWDDrinking: UILabel!

    @IBOutlet weak var coccidiosisVaccineDrinkin: UILabel!
    var postingId = NSNumber()
    var CocoiVacId = NSNumber()
    var feedProgramArray = NSMutableArray()
    var arrTagetMetric = NSMutableArray()
    var arrTargetImp = NSMutableArray()
    var navigatePostingsession = String()
    var feedPostingId = Int()
    var feedImpandMetric = String()
    var mySet = NSOrderedSet()
    var customPopView1: popUP!
    @IBOutlet weak var uprTapViewOutlet: UIControl!
    @IBOutlet weak var finsiherDrinkingOutlet: UIButton!

    @IBOutlet weak var coccidiosisStarterDrinkingWater: UIButton!
    @IBOutlet weak var coccidiosisGrowerDrinkingWater: UIButton!
    @IBOutlet weak var cocciWDDrinkingWater: UIButton!
    @IBOutlet weak var antiboticGrowerDrinking: UIButton!
    @IBOutlet weak var antiboticWdDrinkingWater: UIButton!
    @IBOutlet weak var antiboticFinisherDrinkingWater: UIButton!
    @IBOutlet weak var antiboticStarterDrinkingWater: UIButton!
    @IBOutlet weak var myCoxGrowerDrinkingWater: UIButton!
    @IBOutlet weak var myCoxFinisherDrinkingWater: UIButton!

    @IBOutlet weak var myCoxiWdDrinking: UIButton!
    @IBOutlet weak var myCoxiStarterDrinking: UIButton!
    @IBOutlet weak var coccidiosisControlOutlet: UIButton!
    @IBOutlet weak var antiboticControlOutlet: UIButton!
    @IBOutlet weak var alternativeControlOutlet: UIButton!
    @IBOutlet weak var myCotoxiinOutlet: UIButton!
    @IBOutlet weak var targetWeightDrinkingOutlet: UIButton!
    @IBOutlet weak var coccidiosisVaccineOutlet: UIButton!

    let buttonbg = UIButton()
    let buttonbg11 = UIButton()
    var droperTableView  =  UITableView()

    var timer = Timer()

    /******************************************************/
    var cocciControlArray = NSArray()
    var AlternativeArray = NSArray()
    var AntiboticArray = NSArray()
    var MyCoxtinBindersArray = NSArray()
    var serviceDataHldArr = NSArray()
    var targetArray = NSArray()
    var cocodiceVacine = NSMutableArray()

    //var dataArray = NSMutableArray()
    var btnTag = NSInteger()
    var Allbuttonbg =  Int()
    /*************************************************************/
    var cocciControlArrayfromServer = NSMutableArray()
    var AlternativeArrayfromServer = NSMutableArray()
    var AntiboticArrayfromServer = NSMutableArray()
    var MyCoxtinBindersArrayfromServer = NSMutableArray()
    var serviceDataHldArrfromServer = NSMutableArray()
    /******************************************************/
    var feedId = Int()

    @IBOutlet weak var feedProgramTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        objApiSync.delegeteSyncApi = self
        addFarmBtnOutlet.isHidden = true
        addFarmSelectLbl.isHidden = true
        addFarmDroper.isHidden = true
        selectFarmsLabel.isHidden = true
        farmTableView.alpha = 0

        alternativeToFourTextField.tag = 11
        alternativeTothirdTextField.tag = 12
        alternativeToFirstTextField.tag = 13
        alternativeToSecondTextField.tag = 14
        alternativeDosageFirstText.tag = 15
        alternativeDosageSecoondText.tag = 16
        alternativeDosageThirdText.tag = 17
        alternativeDosageFourText.tag = 18
        alternativeFromFirstTextField.tag = 19
        alternativeFromthirdTextField.tag = 20
        alternativeFromFourTextField.tag = 21
        growerDosageCoccidiosisTEXT.tag = 22
        starterDosageTextField.tag = 23
        finisherDosageTxtField.tag = 24
        wdDosageTextField.tag = 25
        FromstarterDurationTextField.tag = 26
        FromGrowerTextField.tag = 27
        fromFinisherTextField.tag = 28
        fromWDtextField.tag = 29
        toStarterTextField.tag = 30
        toGrowerTextField.tag = 31
        toFinisherTextField.tag = 32
        toWdTextField.tag = 33
        myCoxtinStarterDosage.tag = 34
        myCoxtinGrowerDosage.tag = 35
        myCoxtinFinisherDosge.tag = 36
        myCoxtinWDDosage.tag = 37
        myFromFirstTextField.tag = 38
        myFromSecondTextField.tag = 39
        myFromThirdTextField.tag = 40
        myFromFourTextField.tag = 41
        myToFirstTextField.tag = 42
        myToSecondTextField.tag = 43
        myToThirdTextField.tag = 44
        myFromFourTextField.tag = 45
        myToFourTextField.tag = 46
        antiDosageFirstTextField.tag = 47
        antiDosageSecondTextField.tag = 48
        antiDosageThirdTextField.tag = 49
        antiDosageFourTextField.tag = 50
        antiFromDurationFourTextField.tag = 51
        antiFromDurationFirstTextField.tag = 52
        antiFromDurationThirdTextField.tag = 53
        antiFromDurationSecondTextField.tag = 54
        antiToDurationFourTextField.tag = 55
        antiToDurationFirstTextField.tag = 56
        antiToDurationThirdTextField.tag = 57
        antiToDurationSecondTextField.tag = 58
        FromstarterDurationTextField.tag = 104
        FromGrowerTextField.tag = 105
        fromFinisherTextField.tag = 106
        fromWDtextField.tag = 107
        toStarterTextField.tag = 108
        toGrowerTextField.tag = 109
        toFinisherTextField.tag = 110
        toWdTextField.tag = 111
        feed5textField.tag = 112
        feed6TextField.tag = 113
        from5TextField.tag = 114
        from6teXTfield.tag = 115
        toFeed5TextFeidl.tag = 116
        toFeed6TextField.tag = 117
        altrNativeDosage5Text.tag = 118
        altrNativeDosage6Text.tag = 119
        from5TextAlternative.tag = 120
        from6TextAlternative.tag = 121
        to5TextAlternative.tag = 122
        to6TextAlternative.tag = 123
        myCoxtin5DosageTextField.tag = 124
        myCoxtin6DosageTextField.tag = 125
        from5TextFieldMycoxtin.tag = 126
        from6TextFieldMycoxtin.tag = 127
        to5TextFieldMycoxtin.tag = 128

        to6TextFieldMycoxtin.tag = 129
        antiDosageFivthTextField.tag = 130
        antiDosageSixTextField.tag = 131
        antiFromFivthTextField.tag = 132
        antiFromSixthTextField.tag = 133
        antiToDurationfivthTextField.tag = 134
        alternativeFromSecondTextField.tag = 136
        antiToDurationSixTextField.tag = 135
        //////////

        feedProgramTextField.delegate = self
        alternativeToFourTextField.delegate = self
        alternativeTothirdTextField.delegate = self
        alternativeToFirstTextField.delegate = self
        alternativeToSecondTextField.delegate = self
        alternativeDosageFirstText.delegate = self
        alternativeDosageSecoondText.delegate = self
        alternativeDosageThirdText.delegate = self
        alternativeDosageFourText.delegate = self
        alternativeFromFirstTextField.delegate = self
        alternativeFromthirdTextField.delegate = self
        alternativeFromFourTextField.delegate = self
        growerDosageCoccidiosisTEXT.delegate = self
        starterDosageTextField.delegate = self
        finisherDosageTxtField.delegate = self
        wdDosageTextField.delegate = self
        FromstarterDurationTextField.delegate = self
        FromGrowerTextField.delegate = self
        fromFinisherTextField.delegate = self
        fromWDtextField.delegate = self
        toStarterTextField.delegate = self
        toGrowerTextField.delegate = self
        toFinisherTextField.delegate = self
        toWdTextField.delegate = self
        myCoxtinStarterDosage.delegate = self
        myCoxtinGrowerDosage.delegate = self
        myCoxtinFinisherDosge.delegate = self
        myCoxtinWDDosage.delegate = self
        myFromFirstTextField.delegate = self
        myFromSecondTextField.delegate = self
        myFromThirdTextField.delegate = self
        myFromFourTextField.delegate = self
        myToFirstTextField.delegate = self
        myToSecondTextField.delegate = self
        myToThirdTextField.delegate = self
        myFromFourTextField.delegate = self
        myToFourTextField.delegate = self
        antiDosageFirstTextField.delegate = self
        antiDosageSecondTextField.delegate = self
        antiDosageThirdTextField.delegate = self
        antiDosageFourTextField.delegate = self
        antiFromDurationFourTextField.delegate = self
        antiFromDurationFirstTextField.delegate = self
        antiFromDurationThirdTextField.delegate = self
        antiFromDurationSecondTextField.delegate = self
        antiToDurationFourTextField.delegate = self
        antiToDurationFirstTextField.delegate = self
        antiToDurationThirdTextField.delegate = self
        antiToDurationSecondTextField.delegate = self
        starterDosageTextField.delegate = self
        growerDosageCoccidiosisTEXT.delegate = self
        finisherDosageTxtField.delegate = self
        wdDosageTextField.delegate = self
        FromstarterDurationTextField.delegate = self
        FromGrowerTextField.delegate = self
        fromFinisherTextField.delegate = self
        fromWDtextField.delegate = self
        toStarterTextField.delegate = self
        toGrowerTextField.delegate = self
        toFinisherTextField.delegate = self
        toWdTextField.delegate = self

        moleculeFeedType1Alternativ.delegate = self
        moleculeFeedType2Alternativ.delegate = self
        moleculeFeedType3Alternativ.delegate = self
        moleculeFeedType4Alternativ.delegate = self
        moleculeFeedType5Alternativ.delegate = self
        moleculeFeedType5Alternativ.delegate = self
        feed5textField.delegate = self
        feed6TextField.delegate = self
        from5TextField.delegate = self
        from6teXTfield.delegate = self
        toFeed5TextFeidl.delegate = self
        toFeed6TextField.delegate = self
        altrNativeDosage5Text.delegate = self
        altrNativeDosage6Text.delegate = self
        from5TextAlternative.delegate = self
        from6TextAlternative.delegate = self
        to5TextAlternative.delegate = self
        to6TextAlternative.delegate = self

        antiDosageFivthTextField.delegate = self
        antiDosageSixTextField.delegate = self
        antiFromFivthTextField.delegate = self
        antiFromSixthTextField.delegate = self
        antiToDurationfivthTextField.delegate = self
        antiToDurationSixTextField.delegate = self
        antiMoleculeFeedType1.delegate = self
        antiMoleculeFeedType2.delegate = self
        antiMoleculeFeedType3.delegate = self
        antiMoleculeFeedType4.delegate = self
        antiMoleculeFeedType5.delegate = self
        antiMoleculeFeedType6.delegate = self
        to6TextFieldMycoxtin.delegate = self
        to5TextFieldMycoxtin.delegate = self
        from5TextFieldMycoxtin.delegate = self
        from6TextFieldMycoxtin.delegate = self
        myCoxtin6DosageTextField.delegate = self
        myCoxtin5DosageTextField.delegate = self
        moleculeFeedType1MyCoxtin.delegate = self
        moleculeFeedType2MyCoxtin.delegate = self
        moleculeFeedType3MyCoxtin.delegate = self
        moleculeFeedType4MyCoxtin.delegate = self
        moleculeFeedType5MyCoxtin.delegate = self
        moleculeFeedType6MyCoxtin.delegate = self
        to6TextFieldMycoxtin.delegate = self
        from6TextFieldMycoxtin.delegate = self
        moleculeFeedType6MyCoxtin.delegate = self
        myCoxtin6DosageTextField.delegate = self

        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting as NSNumber
        } else if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            postingId =  UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        }

        btnTag = 0

        coccidiosisControlOutlet.layer.cornerRadius = 7
        myCotoxiinOutlet.layer.cornerRadius = 7
        alternativeControlOutlet.layer.cornerRadius = 7
        antiboticControlOutlet.layer.cornerRadius = 7

        coccidiosisStarterDrinkingWater.layer.borderWidth = 1
        coccidiosisStarterDrinkingWater.layer.cornerRadius = 3.5
        coccidiosisStarterDrinkingWater.layer.borderColor = UIColor.black.cgColor

        coccidiosisGrowerDrinkingWater.layer.borderWidth = 1
        coccidiosisGrowerDrinkingWater.layer.cornerRadius = 3.5
        coccidiosisGrowerDrinkingWater.layer.borderColor = UIColor.black.cgColor

        finsiherDrinkingOutlet.layer.borderWidth = 1
        finsiherDrinkingOutlet.layer.cornerRadius = 3.5
        finsiherDrinkingOutlet.layer.borderColor = UIColor.black.cgColor

        cocciWDDrinkingWater.layer.borderWidth = 1
        cocciWDDrinkingWater.layer.cornerRadius = 3.5
        cocciWDDrinkingWater.layer.borderColor = UIColor.black.cgColor

        feedType5CocciOutlet.layer.borderWidth = 1
        feedType5CocciOutlet.layer.cornerRadius = 3.5
        feedType5CocciOutlet.layer.borderColor = UIColor.black.cgColor

        feedType6CocciOutlet.layer.borderWidth = 1
        feedType6CocciOutlet.layer.cornerRadius = 3.5
        feedType6CocciOutlet.layer.borderColor = UIColor.black.cgColor

        coccidiosisVaccineOutlet.layer.cornerRadius = 3.5
        coccidiosisVaccineOutlet.layer.borderColor = UIColor.black.cgColor
        coccidiosisVaccineOutlet.layer.borderWidth = 1.0

        addFarmBtnOutlet.layer.cornerRadius = 3.5
        addFarmBtnOutlet.layer.borderColor = UIColor.black.cgColor
        addFarmBtnOutlet.layer.borderWidth = 1.0

        coccidiosisView.isHidden = false
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true

        serviceDataHldArr = (UserDefaults.standard.value(forKey: "Molucule") as? NSArray)!

        self.callSaveMethod(commonAray: serviceDataHldArr, tag: btnTag)

        cocodiceVacine =  CoreDataHandler().fetchCociVacLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        print(cocodiceVacine)
        targetArray =  (UserDefaults.standard.value(forKey: "target") as? NSArray)!

    }

    override func viewWillAppear(_ animated: Bool) {
        spacingInTxtField()
        self.printSyncLblCount()
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        if finializeCount == 1 {

            feedProgramTextField.isUserInteractionEnabled = false
            coccidiosisView.isUserInteractionEnabled = false
            alterNativeView.isUserInteractionEnabled = false
            antiboticView.isUserInteractionEnabled = false
            myCotoxinBindersView.isUserInteractionEnabled = false
            doneBtnOutlet.isHidden = true
        } else {

            feedProgramTextField.isUserInteractionEnabled = true
            coccidiosisView.isUserInteractionEnabled = true
            alterNativeView.isUserInteractionEnabled = true
            antiboticView.isUserInteractionEnabled = true
            myCotoxinBindersView.isUserInteractionEnabled = true
            doneBtnOutlet.isHidden = false

        }

        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        arrTargetImp.removeAllObjects()
        arrTagetMetric.removeAllObjects()
        for i in 0..<targetArray.count {
            let scaleType = (targetArray.value(forKey: "ScaleType") as AnyObject).object(at: i) as! String
            ////print(targetArray)

            ////print(targetArray.value(forKey:"TargetWeightProcessingName").object(at:i) as! String)

            if "Metric" == scaleType {

                arrTagetMetric.add((targetArray.value(forKey: "TargetWeightProcessingName") as AnyObject).object(at: i) as! String)

            } else if("Imperial" == scaleType) {
                arrTargetImp.add((targetArray.value(forKey: "TargetWeightProcessingName") as AnyObject).object(at: i) as! String)
            }

        }
        // ////print(arrTaget)

        if navigatePostingsession == "PostingFeedProgram"{
            // feedPostingId

            cocciControlArray = CoreDataHandler().fetchAllCocciControl(feedPostingId as NSNumber)
            AntiboticArray = CoreDataHandler().fetchAntibotic(feedPostingId as NSNumber)
            AlternativeArray = CoreDataHandler().fetchAlternative(feedPostingId as NSNumber)
            MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(feedPostingId as NSNumber)
        } else if postingIdFromExistingNavigate == "Exting"{

            cocciControlArray = CoreDataHandler().fetchAllCocciControl(self.FeedIdFromExisting as NSNumber)
            AntiboticArray = CoreDataHandler().fetchAntibotic(self.FeedIdFromExisting as NSNumber)
            AlternativeArray = CoreDataHandler().fetchAlternative(self.FeedIdFromExisting as NSNumber)
            MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(self.FeedIdFromExisting as NSNumber)

        } else {

            feedId =   UserDefaults.standard.integer(forKey: "feedId")
            cocciControlArray = CoreDataHandler().fetchAllCocciControl(feedId as NSNumber)
            AntiboticArray = CoreDataHandler().fetchAntibotic(feedId as NSNumber)
            AlternativeArray = CoreDataHandler().fetchAlternative(feedId as NSNumber)
            MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(feedId as NSNumber)

        }

        if cocciControlArray.count > 0 {

            for  i in 0..<cocciControlArray.count {

                let str = (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 0) as? String
                if ((str?.characters.count)! > 0) {
                    coccidsisStartrDrinking.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 0) as? String
                } else {
                    coccidsisStartrDrinking.text = NSLocalizedString("- Select -", comment: "")
                }
                var str1 = String()
                if cocciControlArray.count == 1 {
                    str1 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String)!
                } else {

                    str1 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 1) as? String)!
                }
                if (str1.characters.count) > 0 {
                    coccidsisGrowerDrinking.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 1) as? String
                } else {
                    coccidsisGrowerDrinking.text = NSLocalizedString("- Select -", comment: "")

                }
                var str2 = String()
                if cocciControlArray.count == 1 {
                    str2 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String)!
                } else {

                    str2 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 2) as? String)!
                }

                if (str2.characters.count) > 0 {

                    cocciFinisherDrinkingWater.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 2) as? String
                } else {
                    cocciFinisherDrinkingWater.text = NSLocalizedString("- Select -", comment: "")

                }
                var str3 = String()
                if cocciControlArray.count == 1 {
                    str3 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String)!
                } else {

                    str3 = ((cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 3) as? String)!
                }

                if (str3.characters.count) > 0 {

                    coccidiosisWdDrinking.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 3) as? String
                } else {
                    coccidiosisWdDrinking.text = NSLocalizedString("- Select -", comment: "")

                }
                var str4 = String()
                if cocciControlArray.count == 1 {
                    str4 = (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: i) as! String
                } else {

                    str4 = (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 4) as! String
                }

                if (str4.characters.count) > 0 {
                    fivthMoleculelBL.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 4) as? String
                } else {
                    fivthMoleculelBL.text = NSLocalizedString("- Select -", comment: "")

                }
                var str5 = String()
                if cocciControlArray.count == 1 {
                    str5 = (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: i) as! String
                } else {

                    str5 = (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 5) as! String
                }

                if (str5.characters.count) > 0 {
                    sixthMoleculeLbl.text =  (cocciControlArray.value(forKey: "molecule") as AnyObject).object(at: 5) as? String
                } else {
                    sixthMoleculeLbl.text = NSLocalizedString("- Select -", comment: "")
                }

                if cocciControlArray.count == 1 {
                    starterDosageTextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    starterDosageTextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 0) as? String
                }
                if cocciControlArray.count == 1 {
                    growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 1) as? String
                }
                if cocciControlArray.count == 1 {
                    finisherDosageTxtField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    finisherDosageTxtField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 2) as? String
                }
                if cocciControlArray.count == 1 {
                    wdDosageTextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    wdDosageTextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 3) as? String
                }
                if cocciControlArray.count == 1 {
                    feed5textField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    feed5textField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 4) as? String
                }
                if cocciControlArray.count == 1 {
                    feed6TextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    feed6TextField.text =  (cocciControlArray.value(forKey: "dosage") as AnyObject).object(at: 5) as? String
                }
                if cocciControlArray.count == 1 {
                    FromstarterDurationTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    FromstarterDurationTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                }
                if cocciControlArray.count == 1 {
                    FromGrowerTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    FromGrowerTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 1) as? String
                }
                if cocciControlArray.count == 1 {
                    fromFinisherTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    fromFinisherTextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 2) as? String
                }
                if cocciControlArray.count == 1 {
                    fromWDtextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    fromWDtextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 3) as? String
                }
                if cocciControlArray.count == 1 {
                    from5TextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    from5TextField.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 4) as? String
                }
                if cocciControlArray.count == 1 {
                    from6teXTfield.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    from6teXTfield.text =  (cocciControlArray.value(forKey: "fromDays") as AnyObject).object(at: 5) as? String
                }
                if cocciControlArray.count == 1 {
                    toStarterTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toStarterTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 0) as? String
                }
                if cocciControlArray.count == 1 {
                    toGrowerTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toGrowerTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 1) as? String
                }
                if cocciControlArray.count == 1 {
                    toFinisherTextField.text = (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toFinisherTextField.text = (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 2) as? String
                }
                if cocciControlArray.count == 1 {
                    toWdTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toWdTextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 3) as? String
                }
                if cocciControlArray.count == 1 {
                    toFeed5TextFeidl.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toFeed5TextFeidl.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 4) as? String
                }
                if cocciControlArray.count == 1 {
                    toFeed6TextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    toFeed6TextField.text =  (cocciControlArray.value(forKey: "toDays") as AnyObject).object(at: 5) as? String
                }
                if cocciControlArray.count == 1 {
                    coccidiosisVaccineDrinkin.text =  (cocciControlArray.value(forKey: "coccidiosisVaccine") as AnyObject).object(at: i) as? String
                } else {
                    coccidiosisVaccineDrinkin.text =  (cocciControlArray.value(forKey: "coccidiosisVaccine") as AnyObject).object(at: 0) as? String
                }
                if cocciControlArray.count == 1 {
                    feedProgramTextField.text =
                        (cocciControlArray.value(forKey: "feedProgram") as AnyObject).object(at: i) as? String
                } else {
                    feedProgramTextField.text =
                        (cocciControlArray.value(forKey: "feedProgram") as AnyObject).object(at: 0) as? String
                }
            }
            /*********************** Antiboitic  ****************************/
            //////print("fetch all \(arrResults)")
        }

        ////print(AntiboticArray.count)

        if AntiboticArray.count > 0 {

            for i in 0..<AntiboticArray.count {

                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType1.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType1.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 0) as? String
                }
                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType2.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType2.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 1) as? String
                }
                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType3.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType3.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 2) as? String
                }

                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType4.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType4.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 3) as? String
                }
                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType5.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType5.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 4) as? String
                }
                if AntiboticArray.count == 1 {
                    antiMoleculeFeedType6.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    antiMoleculeFeedType6.text =  (AntiboticArray.value(forKey: "molecule") as AnyObject).object(at: 5) as? String
                }

                if AntiboticArray.count == 1 {
                    antiDosageFirstTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageFirstTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 0) as? String
                }

                if AntiboticArray.count == 1 {
                    antiDosageSecondTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageSecondTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 1) as? String
                }
                if AntiboticArray.count == 1 {
                    antiDosageThirdTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageThirdTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 2) as? String
                }

                if AntiboticArray.count == 1 {
                    antiDosageFourTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageFourTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 3) as? String
                }
                if AntiboticArray.count == 1 {
                    antiDosageFivthTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageFivthTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 4) as? String
                }

                if AntiboticArray.count == 1 {
                    antiDosageSixTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    antiDosageSixTextField.text =  (AntiboticArray.value(forKey: "dosage") as AnyObject).object(at: 5) as? String
                }
                if AntiboticArray.count == 1 {
                    antiFromDurationFirstTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    antiFromDurationFirstTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                }

                if AntiboticArray.count == 1 {
                    antiFromDurationSecondTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    antiFromDurationSecondTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: 1) as? String
                }
                if AntiboticArray.count == 1 {
                    antiFromDurationThirdTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    antiFromDurationThirdTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: 2) as? String
                }

                if AntiboticArray.count == 1 {
                    antiFromDurationFourTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject
                        ).object(at: i) as? String
                } else {
                    antiFromDurationFourTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject
                        ).object(at: 3) as? String
                }

                if AntiboticArray.count == 1 {
                    antiFromFivthTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    antiFromFivthTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: 4) as? String
                }
                if AntiboticArray.count == 1 {
                    antiFromSixthTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    antiFromSixthTextField.text =  (AntiboticArray.value(forKey: "fromDays") as AnyObject).object(at: 5) as? String
                }

                if AntiboticArray.count == 1 {
                    antiToDurationFirstTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    antiToDurationFirstTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 0) as? String
                }
                if AntiboticArray.count == 1 {
                    antiToDurationSecondTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 0) as? String
                } else {
                    antiToDurationSecondTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 1) as? String
                }
                if AntiboticArray.count == 1 {
                    antiToDurationThirdTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    antiToDurationThirdTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 2) as? String
                }
                if AntiboticArray.count == 1 {
                    antiToDurationFourTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    antiToDurationFourTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 3) as? String
                }
                if AntiboticArray.count == 1 {
                    antiToDurationfivthTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    antiToDurationfivthTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 4) as? String
                }

                if AntiboticArray.count == 1 {
                    antiToDurationSixTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    antiToDurationSixTextField.text =  (AntiboticArray.value(forKey: "toDays") as AnyObject).object(at: 5) as? String
                }

                if AntiboticArray.count == 1 {
                    feedProgramTextField.text = (AntiboticArray.value(forKey: "feedProgram") as AnyObject).object(at: i) as? String
                } else {
                    feedProgramTextField.text = (AntiboticArray.value(forKey: "feedProgram") as AnyObject).object(at: 0) as? String
                }

            }

            //////print("fetch all \(arrResults)")
        }

        /**********************  *************************************/

        if AlternativeArray.count > 0 {

            for i in 0..<AlternativeArray.count {

                if AlternativeArray.count == 1 {
                    moleculeFeedType1Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType1Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 0) as? String
                }
                if AlternativeArray.count == 1 {
                    moleculeFeedType2Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType2Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 1) as? String
                }

                if AlternativeArray.count == 1 {
                    moleculeFeedType3Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType3Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 2) as? String
                }
                if AlternativeArray.count == 1 {
                    moleculeFeedType4Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType4Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 3) as? String
                }
                if AlternativeArray.count == 1 {
                    moleculeFeedType5Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType5Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 4) as? String
                }

                if AlternativeArray.count == 1 {
                    moleculeFeedType6Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType6Alternativ.text =  (AlternativeArray.value(forKey: "molecule") as AnyObject).object(at: 5) as? String
                }

                if AlternativeArray.count == 1 {
                    alternativeDosageFirstText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    alternativeDosageFirstText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 0) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeDosageSecoondText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    alternativeDosageSecoondText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 1) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeDosageThirdText.text = (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    alternativeDosageThirdText.text = (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 2) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeDosageFourText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    alternativeDosageFourText.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 3) as? String
                }

                if AlternativeArray.count == 1 {
                    altrNativeDosage5Text.text = (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    altrNativeDosage5Text.text = (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 4) as? String
                }
                if AlternativeArray.count == 1 {
                    altrNativeDosage6Text.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    altrNativeDosage6Text.text =  (AlternativeArray.value(forKey: "dosage") as AnyObject).object(at: 5) as? String
                }

                if AlternativeArray.count == 1 {
                    alternativeFromFirstTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeFromFirstTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeFromSecondTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeFromSecondTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 1) as? String
                }

                if AlternativeArray.count == 1 {
                    alternativeFromthirdTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeFromthirdTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 2) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeFromFourTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeFromFourTextField.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 3) as? String
                }
                if AlternativeArray.count == 1 {
                    from5TextAlternative.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    from5TextAlternative.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 4) as? String
                }

                if AlternativeArray.count == 1 {
                    from6TextAlternative.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    from6TextAlternative.text =  (AlternativeArray.value(forKey: "fromDays") as AnyObject).object(at: 5) as? String
                }

                if AlternativeArray.count == 1 {
                    alternativeToFirstTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeToFirstTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 0) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeToSecondTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeToSecondTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 1) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeTothirdTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeTothirdTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 2) as? String
                }
                if AlternativeArray.count == 1 {
                    alternativeToFourTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    alternativeToFourTextField.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 3) as? String
                }

                if AlternativeArray.count == 1 {
                    to5TextAlternative.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    to5TextAlternative.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 4) as? String
                }

                if AlternativeArray.count == 1 {
                    to6TextAlternative.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    to6TextAlternative.text =  (AlternativeArray.value(forKey: "toDays") as AnyObject).object(at: 5) as? String
                }

                if AlternativeArray.count == 1 {
                    feedProgramTextField.text = (AlternativeArray.value(forKey: "feedProgram") as AnyObject).object(at: i) as? String
                } else {
                    feedProgramTextField.text = (AlternativeArray.value(forKey: "feedProgram") as AnyObject).object(at: 0) as? String
                }

            }

            //////print("fetch all \(arrResults)")
        }

        /*********************  MyBlinder  ****************************/

        if MyCoxtinBindersArray.count > 0 {

            for i in 0..<MyCoxtinBindersArray.count {

                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType1MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType1MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 0) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType2MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType2MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 1) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType3MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType3MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 2) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType4MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType4MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 3) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType5MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType5MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 4) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    moleculeFeedType6MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: i) as? String
                } else {
                    moleculeFeedType6MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey: "molecule") as AnyObject).object(at: 5) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myCoxtinStarterDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    myCoxtinStarterDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 0) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myCoxtinGrowerDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    myCoxtinGrowerDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 1) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myCoxtinFinisherDosge.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    myCoxtinFinisherDosge.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 2) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myCoxtinWDDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    myCoxtinWDDosage.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 3) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myCoxtin5DosageTextField.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 0) as? String
                } else {
                    myCoxtin5DosageTextField.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 4) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myCoxtin6DosageTextField.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: i) as? String
                } else {
                    myCoxtin6DosageTextField.text =  (MyCoxtinBindersArray.value(forKey: "dosage") as AnyObject).object(at: 5) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myFromFirstTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    myFromFirstTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myFromSecondTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    myFromSecondTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 1) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myFromThirdTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    myFromThirdTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 1) as? String
                }

                //                if MyCoxtinBindersArray.count == 1{
                //                    (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                //                }
                //                else{
                //                    (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:2) as? String
                //                }
                if MyCoxtinBindersArray.count == 1 {
                    myFromFourTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: i) as? String
                } else {
                    myFromFourTextField.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 3) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    from5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                } else {
                    from5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 4) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    from6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 0) as? String
                } else {
                    from6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "fromDays") as AnyObject).object(at: 5) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myToFirstTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    myToFirstTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 0) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myToSecondTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    myToSecondTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 1) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    myToThirdTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    myToThirdTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 2) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    myToFourTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    myToFourTextField.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 3) as? String
                }
                if MyCoxtinBindersArray.count == 1 {
                    to5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    to5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 4) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    to6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: i) as? String
                } else {
                    to6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey: "toDays") as AnyObject).object(at: 5) as? String
                }

                if MyCoxtinBindersArray.count == 1 {
                    feedProgramTextField.text = (MyCoxtinBindersArray.value(forKey: "feedProgram") as AnyObject).object(at: i) as? String
                } else {
                    feedProgramTextField.text = (MyCoxtinBindersArray.value(forKey: "feedProgram") as AnyObject).object(at: 0) as? String
                }

            }

            //////print("fetch all \(arrResults)")
        }

        if (UserDefaults.standard.bool(forKey: "Unlinked") == true) {

            addFarmBtnOutlet.isHidden = false
            addFarmSelectLbl.isHidden = false
            addFarmDroper.isHidden = false
            selectFarmsLabel.isHidden = false

            if (feedProgramTextField.text == "") {

            } else {
                let necId =  UserDefaults.standard.integer(forKey: ("necUnLinked"))

                if (navigatePostingsession == "PostingFeedProgram") {

                    feedNameArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedPostingId as NSNumber).mutableCopy()as! NSMutableArray
                } else {
                    feedNameArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedId as NSNumber).mutableCopy() as! NSMutableArray
                }

                //                feedNameArr = CoreDataHandler().FetchFeedProgramWithFeedName(postingId as NSNumber, feedName:feedProgramTextField.text!,feedId:feedId ).mutableCopy() as! NSMutableArray
                if (feedNameArr.count > 0) {
                    let ftitle = NSMutableString()

                    for i in 0..<feedNameArr.count {
                        let farms = feedNameArr.object(at: i) as! CaptureNecropsyData
                        let strfarmName = farms.farmName! as String
                        // addFarmSelectLbl.text = strfarmName
                        var label: UILabel
                        if (i == 0) {
                            label = UILabel()
                            label.frame = CGRect(x: 50, y: 519, width: 111, height: 21)
                            ftitle.append( strfarmName + " " )

                        } else {

                            label  = UILabel()
                            label.frame = CGRect(x: 50, y: 519, width: 111*(CGFloat(i)+1)+10, height: 21)

                            ftitle.append(", " + strfarmName + " " )

                        }

                        //label.center = CGPointMake(160, 284)

                        label.textAlignment = NSTextAlignment.center
                        label.backgroundColor = UIColor.red

                        addFarmSelectLbl.text = ftitle as String
                        //feedProgramOutlet.addSubview(label)
                    }

                }

            }

        } else {
            addFarmBtnOutlet.isHidden = true
            addFarmSelectLbl.isHidden = true
            addFarmDroper.isHidden = true
            selectFarmsLabel.isHidden = true

        }
        coccidiosisControlOutlet.setTitle(NSLocalizedString("Coccidiosis Control", comment: ""), for: .normal)
        antiboticControlOutlet.setTitle(NSLocalizedString("Antibiotic", comment: ""), for: .normal)
        alternativeControlOutlet.setTitle(NSLocalizedString("Alternative", comment: ""), for: .normal)
        myCotoxiinOutlet.setTitle(NSLocalizedString("Mycotoxin Binders", comment: ""), for: .normal)

        coccidiosisControlOutlet.setTitle(NSLocalizedString("Coccidiosis Control", comment: ""), for: .selected)
        antiboticControlOutlet.setTitle(NSLocalizedString("Antibiotic", comment: ""), for: .selected)
        alternativeControlOutlet.setTitle(NSLocalizedString("Alternative", comment: ""), for: .selected)
        myCotoxiinOutlet.setTitle(NSLocalizedString("Mycotoxin Binders", comment: ""), for: .selected)

    }

    @IBAction func backBtnAction(sender: AnyObject) {
        btnTagsave = 2
        callSaveMethod(btnTagSave: btnTagsave)
    }

    @IBAction func cancelBtnAct(sender: AnyObject) {

        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func coccidiosisControlBtnActoin(sender: AnyObject) {
        flag = 1
        self.view.endEditing(true)
        btnTag = 0

        for btn in self.view.subviews {
            if btn.isKind(of: UIButton.self) {
                let bt = btn as! UIButton
                if bt.titleLabel?.text == NSLocalizedString("Coccidiosis Control", comment: "") {
                    bt.isSelected = true
                } else {
                    bt.isSelected = false
                }
            }
        }

        coccidiosisView.isHidden = false
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true

        serviceDataHldArr = (UserDefaults.standard.value(forKey: "Molucule") as? NSArray)!
        //        ////print(serviceDataHldArr)

        if (cocciControlArrayfromServer.count == 0) {
            self.callSaveMethod(commonAray: serviceDataHldArr, tag: btnTag)
        }

    }

    /***************************** Save Data in to DataBase ************************************************/

    func callSaveMethod( commonAray: NSArray, tag: Int) {
        CoreDataHandler().deleteAllData("MoleCuleFeed")
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let dict = commonAray[tag] as AnyObject

        let arrayMoleculeDetails = dict["MoleculeDetails"] as AnyObject

        for i in 0 ..< arrayMoleculeDetails.count {

            let dictDat = NSMutableDictionary()
            let tempDict = arrayMoleculeDetails.object(at: i) as AnyObject
            print(tempDict)
            let mid = tempDict["MoleculeId"] as? Int
            let lngId =   tempDict["LanguageId"] as? Int
            let catId =  tempDict["FeedProgramCategoryId"] as? Int
            let desc =  tempDict["MoleculeDescription"] as? String
      CoreDataHandler().saveMoleCule(catId!, decscMolecule: desc!, moleculeId: mid!, lngId: lngId!)

        }

        if (tag == 0 ) {

            cocciControlArrayfromServer =  CoreDataHandler().fetchMoleCuleLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
            print(cocciControlArrayfromServer)
        } else if (tag == 1) {
            AlternativeArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        } else if (tag == 2) {
            AntiboticArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        } else if (tag == 3) {
            MyCoxtinBindersArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        } else {
            serviceDataHldArrfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        }
    }
    /******* Create Custom TableView ************************************/
    func tableViewpop() {
        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg.addTarget(self, action: #selector(PostingViewController.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonbg)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg.addSubview(droperTableView)
    }

    func buttonPressed1() {
        buttonbg.removeFromSuperview()
    }
    @IBAction func myCoxtinBtnAction(sender: AnyObject) {

        flag = 4
        self.view.endEditing(true)
        btnTag = 3

        for btn in self.view.subviews {
            if btn.isKind(of: UIButton.self) {
                let bt = btn as! UIButton
                if bt.titleLabel?.text == NSLocalizedString("Mycotoxin Binders", comment: "") {
                    bt.isSelected = true
                } else {
                    bt.isSelected = false
                }
            }
        }
        coccidiosisView.isHidden = true
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = false
//        serviceDataHldArr = (UserDefaults.standard.value(forKey:"Molucule") as? NSArray)!
//        if (MyCoxtinBindersArrayfromServer.count == 0){
//            self.callSaveMethod(commonAray: serviceDataHldArr,tag: btnTag)
//        }
    }

    @IBAction func alternativeBtnAction(sender: AnyObject) {
        flag = 3
        self.view.endEditing(true)

        btnTag =  1
        for btn in self.view.subviews {
            if btn.isKind(of: UIButton.self) {
                let bt = btn as! UIButton
                if bt.titleLabel?.text == NSLocalizedString("Alternative", comment: "") {
                    bt.isSelected = true
                } else {
                    bt.isSelected = false
                }
            }
        }

        coccidiosisView.isHidden = true
        antiboticView.isHidden = true
        alterNativeView.isHidden = false
        myCotoxinBindersView.isHidden = true

//        serviceDataHldArr = (UserDefaults.standard.value(forKey:"Molucule") as? NSArray)!
//
//        if (AlternativeArrayfromServer.count == 0){
//            self.callSaveMethod(commonAray: serviceDataHldArr,tag: btnTag)
//        }
    }

    @IBAction func antoboticBtnAction(sender: AnyObject) {
        flag = 2
        self.view.endEditing(true)

        btnTag =  2
        for btn in self.view.subviews {
            if btn.isKind(of: UIButton.self) {
                let bt = btn as! UIButton
                if bt.titleLabel?.text == NSLocalizedString("Antibiotic", comment: "") {
                    bt.isSelected = true
                } else {
                    bt.isSelected = false
                }
            }
        }

        coccidiosisView.isHidden = true
        antiboticView.isHidden = false
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true

//        serviceDataHldArr = (UserDefaults.standard.value(forKey:"Molucule") as? NSArray)!
//
//        if (AntiboticArrayfromServer.count == 0){
//            self.callSaveMethod(commonAray: serviceDataHldArr,tag: btnTag)
//        }
    }

    @IBAction func starterCheckBoxAction(sender: AnyObject) {
    }

    @IBAction func growerCheckBoxAction(sender: AnyObject) {
    }

    @IBAction func finisherCoccidiosisCheckBoxAction(sender: AnyObject) {
    }

    @IBAction func wdCoccidiosisAction(sender: AnyObject) {
    }

    @IBAction func starterDrinkngWaterAction(sender: AnyObject) {

        view.endEditing(true)

        Allbuttonbg = 0

        tableViewpop()

        droperTableView.frame = CGRect(x: 183, y: 309, width: 237, height: 150)
        droperTableView.reloadData()
    }

    @IBAction func growerDrinkingWater(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 1

        tableViewpop()

        droperTableView.frame = CGRect(x: 183, y: 365, width: 237, height: 150)
        droperTableView.reloadData()

    }

    @IBAction func finisherDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 2
        tableViewpop()

        droperTableView.frame = CGRect(x: 183, y: 422, width: 237, height: 150)
        droperTableView.reloadData()

    }

    @IBAction func wdDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 3
        tableViewpop()

        droperTableView.frame = CGRect(x: 183, y: 477, width: 237, height: 150)
        droperTableView.reloadData()

    }

    @IBAction func feedType5CoccidiosisA(sender: AnyObject) {

        view.endEditing(true)

        Allbuttonbg = 40
        tableViewpop()
        droperTableView.frame = CGRect(x: 183, y: 530, width: 237, height: 150)
        droperTableView.reloadData()

    }

    @IBAction func feedType6CoccidiosisA(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 50

        tableViewpop()

        droperTableView.frame = CGRect(x: 183, y: 580, width: 237, height: 150)
        droperTableView.reloadData()
    }

    @IBAction func coccidiosisVaccineAction(sender: AnyObject) {
        view.endEditing(true)

        btnTag = 4

        btnCocoTagetPopp()

        droperTableView.frame = CGRect(x: 450, y: 455, width: 245, height: 150)

        droperTableView.reloadData()

    }

    func btnCocoTagetPopp() {

        buttoCocodaciVac.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttoCocodaciVac.addTarget(self, action: #selector(FeedProgramViewController.buttonCocotarget), for: .touchUpInside)
        buttoCocodaciVac.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttoCocodaciVac)

        droperTableView.delegate = self
        droperTableView.dataSource = self

        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor

        buttoCocodaciVac.addSubview(droperTableView)

    }

    @objc func buttonCocotarget() {
        btnTag = 0
        buttoCocodaciVac.removeFromSuperview()
    }

    @IBAction func targetWeightDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        btnTag = 5

        btnCocoTagetPopp()

        droperTableView.frame = CGRect(x: 420, y: 410, width: 245, height: 150)

        droperTableView.reloadData()

    }

    @IBOutlet weak var starterDosageTextField: UITextField!
    @IBOutlet weak var growerDosageCoccidiosisTEXT: UITextField!
    @IBOutlet weak var finisherDosageTxtField: UITextField!
    @IBOutlet weak var wdDosageTextField: UITextField!

    @IBOutlet weak var FromstarterDurationTextField: UITextField!
    @IBOutlet weak var FromGrowerTextField: UITextField!
    @IBOutlet weak var fromFinisherTextField: UITextField!
    @IBOutlet weak var fromWDtextField: UITextField!

    @IBOutlet weak var toStarterTextField: UITextField!
    @IBOutlet weak var toGrowerTextField: UITextField!
    @IBOutlet weak var toFinisherTextField: UITextField!
    @IBOutlet weak var toWdTextField: UITextField!

    @IBOutlet weak var coccidiosisView: UIView!

    ////////////

    @IBOutlet weak var antiboticView: UIView!

    @IBAction func uperTapView(sender: AnyObject) {

        coccidiosisView.endEditing(true)
        antiboticView.endEditing(true)
        alterNativeView.endEditing(true)
        myCotoxinBindersView.endEditing(true)
        uprTapViewOutlet.endEditing(true)

    }

    @IBOutlet weak var antiboticStarterCheckBoxOutlet: UIButton!
    @IBAction func antiboticStarterCheckBoxAction(sender: AnyObject) {

    }

    @IBAction func antiboticGrowerAction(sender: AnyObject) {

    }

    @IBOutlet weak var antiboticGrowerCheckBoxOutlet: UIButton!

    @IBOutlet weak var antiboticFinisherCheckBoxoutlet: UIButton!

    @IBAction func antiboticFinisherAction(sender: AnyObject) {

    }

    @IBAction func antiboticWDAction(sender: AnyObject) {

    }

    @IBOutlet weak var antiboticWDcheckBoxOutlet: UIButton!

    @IBAction func antiStarterDrinkingWater(sender: AnyObject) {
        //        view.endEditing(true)
        //
        //        Allbuttonbg = 4
        //        tableViewpop()
        //        droperTableView.frame = CGRectMake( 220, 318, 245, 150)
        //        droperTableView.reloadData()
        //

    }

    @IBAction func antiGrowerDrinkngWater(sender: AnyObject) {
        //        view.endEditing(true)
        //
        //        Allbuttonbg = 5
        //
        //        tableViewpop()
        //
        //        droperTableView.frame = CGRectMake( 220, 375, 245, 150)
        //        droperTableView.reloadData()

    }

    @IBAction func antiFinisherDrinkingWater(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 6
        tableViewpop()

        droperTableView.frame = CGRect(x: 220, y: 432, width: 245, height: 150)

        droperTableView.reloadData()

    }

    @IBAction func antiWdDrinkingWater(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 7
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 492, width: 245, height: 150)

        droperTableView.reloadData()
    }

    @IBOutlet weak var antiDosageFirstTextField: UITextField!
    @IBOutlet weak var antiDosageSecondTextField: UITextField!
    @IBOutlet weak var antiDosageThirdTextField: UITextField!
    @IBOutlet weak var antiDosageFourTextField: UITextField!

    @IBOutlet weak var antiFromDurationFirstTextField: UITextField!
    @IBOutlet weak var antiFromDurationSecondTextField: UITextField!
    @IBOutlet weak var antiFromDurationThirdTextField: UITextField!
    @IBOutlet weak var antiFromDurationFourTextField: UITextField!

    @IBOutlet weak var antiToDurationFirstTextField: UITextField!
    @IBOutlet weak var antiToDurationSecondTextField: UITextField!
    @IBOutlet weak var antiToDurationThirdTextField: UITextField!
    @IBOutlet weak var antiToDurationFourTextField: UITextField!

    /////////////////////////////////////////////////

    @IBOutlet weak var alterNativeView: UIView!

    @IBOutlet weak var alternativeStarterOutlet: UIButton!
    @IBAction func alternativeStartrAction(sender: AnyObject) {
    }

    @IBOutlet weak var alternativeGrowerOutlet: UIButton!
    @IBAction func altrnativeGrowerAction(sender: AnyObject) {
    }

    @IBOutlet weak var alternativeFinsiherOutlet: UIButton!
    @IBAction func alternativeFinisherAction(sender: AnyObject) {
    }

    @IBOutlet weak var alternativeWdOutlet: UIButton!
    @IBAction func alternativeWdAction(sender: AnyObject) {
    }

    @IBOutlet weak var alternativeStarterMoleculeOutlet: UIButton!
    @IBAction func alternativeStarterMoleculeAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 8
        tableViewpop()

        droperTableView.frame = CGRect(x: 220, y: 318, width: 245, height: 150)
        droperTableView.reloadData()
    }

    @IBOutlet weak var alternativeGrowerMoleculeOutlet: UIButton!
    @IBAction func alternativeGrowerMoleculeAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 9

        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 375, width: 245, height: 150)

        droperTableView.reloadData()
    }

    @IBOutlet weak var alternativeFinisherMoleculeOutlet: UIButton!
    @IBAction func alternativeFinisherMoleculeAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 10
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 432, width: 245, height: 150)

        droperTableView.reloadData()

    }

    @IBOutlet weak var alternativeWDMoleculeOutlet: UIButton!
    @IBAction func alternativeWDMoleculeAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 11
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 492, width: 245, height: 150)

        droperTableView.reloadData()
    }

    @IBOutlet weak var alternativeDosageFirstText: UITextField!
    @IBOutlet weak var alternativeDosageSecoondText: UITextField!
    @IBOutlet weak var alternativeDosageThirdText: UITextField!
    @IBOutlet weak var alternativeDosageFourText: UITextField!

    @IBOutlet weak var alternativeFromFirstTextField: UITextField!
    @IBOutlet weak var alternativeFromSecondTextField: UITextField!
    @IBOutlet weak var alternativeFromthirdTextField: UITextField!
    @IBOutlet weak var alternativeFromFourTextField: UITextField!

    @IBOutlet weak var alternativeToFirstTextField: UITextField!
    @IBOutlet weak var alternativeToSecondTextField: UITextField!
    @IBOutlet weak var alternativeTothirdTextField: UITextField!
    @IBOutlet weak var alternativeToFourTextField: UITextField!

    //////////////////////
    @IBOutlet weak var myCotoxinBindersView: UIView!

    @IBOutlet weak var myStarterCheckBox: UIButton!

    @IBOutlet weak var myGrowerCheckBox: UIButton!
    @IBOutlet weak var myFinisherCheckBox: UIButton!

    @IBOutlet weak var myWdCheckBox: UIButton!

    @IBAction func myStarterDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 12
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 318, width: 245, height: 150)

        droperTableView.reloadData()
    }

    @IBAction func myGrowerDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 13

        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 375, width: 245, height: 150)

        droperTableView.reloadData()
    }

    @IBAction func myFinisherDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 14
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 432, width: 245, height: 150)

        droperTableView.reloadData()
    }
    @IBAction func myWDDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)

        Allbuttonbg = 15
        tableViewpop()
        droperTableView.frame = CGRect(x: 220, y: 492, width: 245, height: 150)

        droperTableView.reloadData()

    }

    @IBOutlet weak var  myFromFirstTextField: UITextField!
    @IBOutlet weak var  myFromSecondTextField: UITextField!
    @IBOutlet weak var  myFromThirdTextField: UITextField!
    @IBOutlet weak var  myFromFourTextField: UITextField!

    @IBOutlet weak var  myToFirstTextField: UITextField!
    @IBOutlet weak var  myToSecondTextField: UITextField!
    @IBOutlet weak var  myToThirdTextField: UITextField!
    @IBOutlet weak var  myToFourTextField: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapOnView(sender: AnyObject) {
        coccidiosisView.endEditing(true)
        //hideDropDown()        // DropDown.sharedInstance.closeDropperDropDown()
    }
    @IBAction func tapOnViewAntobotic(sender: AnyObject) {
        antiboticView.endEditing(true)
        //hideDropDown()        // DropDown.sharedInstance.closeDropperDropDown()
    }
    @IBAction func tapOnViewAlternative(sender: AnyObject) {
        alterNativeView.endEditing(true)
        //hideDropDown()        // DropDown.sharedInstance.closeDropperDropDown()
    }
    @IBAction func tapOnViewMyCotoxin(sender: AnyObject) {
        myCotoxinBindersView.endEditing(true)
        //hideDropDown()        // DropDown.sharedInstance.closeDropperDropDown()
    }
    var buttonPopUP: UIButton!
    @IBAction func doneButtonAction(sender: AnyObject) {

        btnTagsave = 1
        isClickOnAnyField = true
        callSaveMethod(btnTagSave: btnTagsave)

        let allCocciControl = CoreDataHandler().fetchAllCocciControlviaPostingid(postingId as NSNumber)

        let outerDict = NSMutableDictionary()

        let FinalArray = NSMutableArray()

        for i in 0..<allCocciControl.count {

            let mainDict = NSMutableDictionary()

            let cocciControl = allCocciControl.object(at: i) as! CoccidiosisControlFeed

            let coccidiosisVaccine = cocciControl.coccidiosisVaccine

            let dosage = cocciControl.dosage

            let feedId = cocciControl.feedId

            let feedProgram = cocciControl.feedProgram

            let formName = cocciControl.formName

            let fromDays = cocciControl.fromDays

            let loginSessionId = cocciControl.loginSessionId

            let molecule = cocciControl.molecule

            let postingId = cocciControl.postingId

            let targetWeight = cocciControl.targetWeight

            let toDays = cocciControl.toDays

            let moleculeId = cocciControl.moleculeId

            let cocoId = cocciControl.coccidiosisVaccineId
            let feedType = cocciControl.feedType

            mainDict.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")

            mainDict.setValue(dosage, forKey: "dose")

            mainDict.setValue(feedId, forKey: "feedId")

            mainDict.setValue(feedProgram, forKey: "feedName")

            mainDict.setValue(fromDays, forKey: "durationFrom")

            mainDict.setValue(molecule, forKey: "molecule")

            mainDict.setValue(toDays, forKey: "durationTo")

            mainDict.setValue(5, forKey: "feedProgramCategoryId")

            mainDict.setValue(moleculeId, forKey: "moleculeId")

            mainDict.setValue(cocoId, forKey: "cocciVaccineId")
            mainDict.setValue(feedType, forKey: "feedType")

            FinalArray.add(mainDict)

        }

        let fetchAntibotic = CoreDataHandler().fetchAntiboticViaPostingId(postingId as NSNumber)

        for i in 0..<fetchAntibotic.count {

            let mainDict = NSMutableDictionary()

            let antiboticFeed = fetchAntibotic.object(at: i) as! AntiboticFeed

            let postingId = antiboticFeed.postingId

            let dosage = antiboticFeed.dosage

            let feedId = antiboticFeed.feedId

            let feedProgram = antiboticFeed.feedProgram

            let formName = antiboticFeed.formName

            let fromDays = antiboticFeed.fromDays

            let loginSessionId = antiboticFeed.loginSessionId

            let molecule = antiboticFeed.molecule

            let toDays = antiboticFeed.toDays
            let feedType = antiboticFeed.feedType

            mainDict.setValue(dosage, forKey: "dose")

            mainDict.setValue(feedId, forKey: "feedId")

            mainDict.setValue(feedProgram, forKey: "feedName")

            mainDict.setValue(fromDays, forKey: "durationFrom")

            mainDict.setValue(molecule, forKey: "molecule")

            mainDict.setValue(toDays, forKey: "durationTo")

            mainDict.setValue(12, forKey: "feedProgramCategoryId")

            mainDict.setValue(0, forKey: "moleculeId")
            mainDict.setValue(feedType, forKey: "feedType")

            FinalArray.add(mainDict)
        }

        let fetchAlternative = CoreDataHandler().fetchAlternativeFeedPostingid(postingId as NSNumber)

        for i in 0..<fetchAlternative.count {

            let mainDict = NSMutableDictionary()

            let antiboticFeed = fetchAlternative.object(at: i) as! AlternativeFeed

            let postingId = antiboticFeed.postingId

            let dosage = antiboticFeed.dosage

            let feedId = antiboticFeed.feedId

            let feedProgram = antiboticFeed.feedProgram

            let formName = antiboticFeed.formName

            let fromDays = antiboticFeed.fromDays

            let loginSessionId = antiboticFeed.loginSessionId

            let molecule = antiboticFeed.molecule

            let toDays = antiboticFeed.toDays
            let feedType = antiboticFeed.feedType

            mainDict.setValue(dosage, forKey: "dose")

            mainDict.setValue(feedId, forKey: "feedId")

            mainDict.setValue(feedProgram, forKey: "feedName")

            mainDict.setValue(fromDays, forKey: "durationFrom")

            mainDict.setValue(molecule, forKey: "molecule")

            mainDict.setValue(toDays, forKey: "durationTo")

            mainDict.setValue(6, forKey: "feedProgramCategoryId")

            mainDict.setValue(0, forKey: "moleculeId")
            mainDict.setValue(feedType, forKey: "feedType")

            FinalArray.add(mainDict)

        }

        let fetchMyBinde = CoreDataHandler().fetchMyBindersViaPostingId(postingId as NSNumber)

        for i in 0..<fetchMyBinde.count {

            let mainDict = NSMutableDictionary()

            let antiboticFeed = fetchMyBinde.object(at: i) as! MyCotoxinBindersFeed

            let dosage = antiboticFeed.dosage
            let feedId = antiboticFeed.feedId
            let feedProgram = antiboticFeed.feedProgram
            let fromDays = antiboticFeed.fromDays

            let loginSessionId = antiboticFeed.loginSessionId

            let molecule = antiboticFeed.molecule

            let toDays = antiboticFeed.toDays
            let feedType = antiboticFeed.feedType
            mainDict.setValue(dosage, forKey: "dose")

            mainDict.setValue(feedId, forKey: "feedId")

            mainDict.setValue(feedProgram, forKey: "feedName")

            mainDict.setValue(fromDays, forKey: "durationFrom")

            mainDict.setValue(molecule, forKey: "molecule")

            mainDict.setValue(toDays, forKey: "durationTo")

            mainDict.setValue(18, forKey: "feedProgramCategoryId")

            mainDict.setValue(0, forKey: "moleculeId")
            mainDict.setValue(feedType, forKey: "feedType")

            FinalArray.add(mainDict)

        }

        outerDict.setValue(postingId as NSNumber, forKey: "sessionId")

        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        let sessionGUID1 = "iOS" + (udid as! String) +  "_" + String(describing: postingId)
        outerDict.setValue(sessionGUID1, forKey: "deviceSessionId")

        let id = UserDefaults.standard.integer(forKey: ("Id"))

        outerDict.setValue(id, forKey: "UserId")

        outerDict.setValue(false, forKey: "finalized")

        outerDict.setValue(FinalArray, forKey: "feedProgramDetail")

        do {

            var error: NSError?

            let jsonData = try! JSONSerialization.data(withJSONObject: outerDict, options: JSONSerialization.WritingOptions.prettyPrinted)

            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            jsonString =  jsonString.trimmingCharacters(in: (NSCharacterSet.whitespaces))

        } catch let error as NSError {

            //print(error)

        }

    }

    func callSaveMethod (btnTagSave: Int) {
        var feed = Int()
        var trimmedString = feedProgramTextField.text!.trimmingCharacters(in: .whitespaces)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
            NSString.CompareOptions.literal, range: nil)
        feedProgramTextField.text = trimmedString
        if (trimmedString == "" ) {
            if (btnTagSave == 2) {
                let feeid  = UserDefaults.standard.integer(forKey: ("feedId"))

                if (feeid == 0 ) {
                    UserDefaults.standard.set("feed0", forKey: "feed0")
                    UserDefaults.standard.synchronize()
                    feed = 0
                } else {
                    if (strYesPop == NSLocalizedString("Yes", comment: "")) {

                        feed = feeid
                    } else {
                        if (navigatePostingsession == "PostingFeedProgram") {
                            feed = feeid
                        } else {
                            feed = feeid-1
                        }
                    }
                    UserDefaults.standard.set(" ", forKey: "feed0")
                    UserDefaults.standard.synchronize()

                }
                UserDefaults.standard.set(feed, forKey: "feedId")
                UserDefaults.standard.set("back", forKey: "back")
                UserDefaults.standard.synchronize()

                let appDelegate = UIApplication.shared.delegate as! AppDelegate

                appDelegate.isFeedProgramClick = true

                appDelegate.sendFeedVariable = "Feed"

                appDelegate.strImpFedd = feedImpandMetric

                appDelegate.newColor = datCount + 1

                UserDefaults.standard.set(true, forKey: "isNewPostingId")
                UserDefaults.standard.synchronize()

                self.navigationController?.popViewController(animated: true)
                UserDefaults.standard.set(0, forKey: "isBackWithoutFedd")
                UserDefaults.standard.synchronize()
            } else {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter feed program.", comment: ""))
            }
        } else {

            if (btnTagSave == 2) {

                bckButtonCall()

            }
            if (isClickOnAnyField == true) {
                isClickOnAnyField = false

                if (navigatePostingsession == "PostingFeedProgram") {
                    self.saveFeedProgrameInDatabase(feedId: feedPostingId, postingId: Int(postingId as NSNumber), completion: { (status) -> Void in

                        if status == true {

                            self.saveCoccoiControlDatabase(feedId: self.feedPostingId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                if status == true {

                                    self.saveAntibioticDatabase(feedId: self.feedPostingId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                        if status == true {

                                            ////print("Antibiotic")

                                            self.saveAlternativeDatabase(feedId: self.feedPostingId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                if status == true {

                                                    ////print("Alternative")

                                                    self.saveMyCoxtinDatabase(feedId: self.feedPostingId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                        if status == true {

                                                            ////print("MyCoxtin")

                                                            //UserDefaults.standard.setBool(false, forKey: "isNewPostingId")

                                                        }})
                                                }})
                                        }})
                                }})
                        }})
                } else if postingIdFromExistingNavigate == "Exting"{
                    self.saveFeedProgrameInDatabase(feedId: self.FeedIdFromExisting, postingId: Int(self.postingId), completion: { (status) -> Void in

                        if status == true {

                            self.saveCoccoiControlDatabase(feedId: self.FeedIdFromExisting, postingId: Int(self.postingId), completion: { (status) -> Void in

                                if status == true {

                                    self.saveAntibioticDatabase(feedId: self.FeedIdFromExisting, postingId: Int(self.postingId), completion: { (status) -> Void in

                                        if status == true {

                                            ////print("Antibiotic")

                                            self.saveAlternativeDatabase(feedId: self.FeedIdFromExisting, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                if status == true {

                                                    ////print("Alternative")

                                                    self.saveMyCoxtinDatabase(feedId: self.FeedIdFromExisting, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                        if status == true {

                                                            if self.postingIdFromExistingNavigate == "Exting"{
                                                                CoreDataHandler().updateisSyncTrueOnPostingSession(self.postingId)
                                                            }

                                                            ////print("MyCoxtin")

                                                        }})
                                                }})
                                        }})
                                }})
                        }})

                } else {

                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        postingId = UserDefaults.standard.integer(forKey: "necUnLinked") as NSNumber

                    } else {
                        postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
                    }

                    self.saveFeedProgrameInDatabase(feedId: feedId, postingId: Int(self.postingId), completion: { (status) -> Void in

                        ////print("Feed")

                        if status == true {

                            self.saveCoccoiControlDatabase(feedId: self.feedId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                if status == true {

                                    ////print("Cocoi")

                                    self.saveAntibioticDatabase(feedId: self.feedId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                        if status == true {

                                            ////print("Antibiotic")

                                            self.saveAlternativeDatabase(feedId: self.feedId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                if status == true {

                                                    ////print("Alternative")

                                                    self.saveMyCoxtinDatabase(feedId: self.feedId, postingId: Int(self.postingId), completion: { (status) -> Void in

                                                        if status == true {

                                                            UserDefaults.standard.set(false, forKey: "isNewPostingId")
                                                            UserDefaults.standard.synchronize()
                                                            ////print("MyCoxtin")

                                                        }})
                                                }})
                                        }})
                                }})
                        }})
                }

            }

            if btnTagsave == 1 {

                if postingIdFromExistingNavigate == "Exting"{

                    self.navigationController?.popViewController(animated: true)
                } else {

                    self.clickHelpPopUp()
                }

            } else {

                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isFeedProgramClick = true
                appDelegate.sendFeedVariable = "Feed"
                appDelegate.strImpFedd = feedImpandMetric
                appDelegate.newColor = datCount + 1
                if (exitPopUP != nil) {
                    if self.exitPopUP.tag == 10 {
                        if self.allSessionArr().count > 0 {
                            if Reachability()?.isReachable == true {

                                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data syncing...", comment: ""))
                                self.callSyncApi()
                            } else {

                                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
                            }
                        } else {

                            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data not available for syncing.", comment: ""))
                        }

                    } else if self.exitPopUP.tag == 20 {
                        self.clickHelp()
                    } else {
                        self.navigationController?.popViewController(animated: true)}
                } else {
                    self.navigationController?.popViewController(animated: true)}

            }
            UserDefaults.standard.set("notback", forKey: "back")
            UserDefaults.standard.set(1, forKey: "isBackWithoutFedd")
            UserDefaults.standard.synchronize()
        }

    }

    func saveFeedProgrameInDatabase(feedId: Int, postingId: Int, completion: (_ status: Bool) -> Void) {

        var tempArr = CoreDataHandler().FetchFeedProgramAll()

        feedProgramArray = tempArr.mutableCopy() as! NSMutableArray

        if feedProgramArray.count == 0 {

            CoreDataHandler().SaveFeedProgram(postingId as NSNumber, sessionId: 1, feedProgrameName: feedProgramTextField.text!, feedId: feedId as NSNumber, dbArray: feedProgramArray, index: 0, formName: addFarmSelectLbl.text!, isSync: true, lngId: lngId as NSNumber)

            CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
        } else {

            if navigatePostingsession == "PostingFeedProgram"{

                ////print(feedProgramArray.count)

                CoreDataHandler().updateFeedProgram(feedId as NSNumber, isSync: true, feedProgrameName: feedProgramTextField.text!, formName: addFarmSelectLbl.text!)

                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
            } else if postingIdFromExistingNavigate == "Exting"{

                CoreDataHandler().updateFeedProgram(feedId as NSNumber, isSync: true, feedProgrameName: feedProgramTextField.text!, formName: addFarmSelectLbl.text!)
                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
                CoreDataHandler().updateFeddProgramInStep1(postingId as NSNumber, feedname: feedProgramTextField.text!, feedId: feedId as NSNumber)
                CoreDataHandler().updateisSyncOnAllCocciControlviaFeedProgram(postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                CoreDataHandler().updateisSyncOnMyCotxinViaFeedProgram(postingId: postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                CoreDataHandler().updateisSyncOnAlterNativeViaFeedProgram(postingId: postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                CoreDataHandler().updateisSyncOnAntiboticViaFeedProgram(postingId: postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)

            } else {

                feedProgramArray.removeAllObjects()

                CoreDataHandler().SaveFeedProgram(postingId as NSNumber, sessionId: 1, feedProgrameName: feedProgramTextField.text!, feedId: feedId as NSNumber, dbArray: feedProgramArray, index: feedId, formName: addFarmSelectLbl.text!, isSync: true, lngId: lngId as NSNumber)

                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
            }

            //}

        }

        completion(true)
    }

    func saveCoccoiControlDatabase (feedId: Int, postingId: Int, completion: (_ status: Bool) -> Void) {

        for i in 0..<7 {

            if i == 0 {

                if coccidsisStartrDrinking.text == NSLocalizedString("- Select -", comment: "") {

                    coccidsisStartrDrinking.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: coccidsisStartrDrinking.text!, dosage: starterDosageTextField.text!, fromDays: FromstarterDurationTextField.text!, toDays: toStarterTextField.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 1", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 1 {

                if coccidsisGrowerDrinking.text == NSLocalizedString("- Select -", comment: "") {

                    coccidsisGrowerDrinking.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: coccidsisGrowerDrinking.text!, dosage: growerDosageCoccidiosisTEXT.text!, fromDays: FromGrowerTextField.text!, toDays: toGrowerTextField.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 2", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)

            } else if i == 2 {
                if cocciFinisherDrinkingWater.text == NSLocalizedString("- Select -", comment: "") {

                    cocciFinisherDrinkingWater.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: cocciFinisherDrinkingWater.text!, dosage: finisherDosageTxtField.text!, fromDays: fromFinisherTextField.text!, toDays: toFinisherTextField.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 3", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
                //

            } else if i == 3 {
                if coccidiosisWdDrinking.text == NSLocalizedString("- Select -", comment: "") {

                    coccidiosisWdDrinking.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: coccidiosisWdDrinking.text!, dosage: wdDosageTextField.text!, fromDays: fromWDtextField.text!, toDays: toWdTextField.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 4", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)       //

            } else if i == 4 {

                if fivthMoleculelBL.text == NSLocalizedString("- Select -", comment: "") {

                    fivthMoleculelBL.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: fivthMoleculelBL.text!, dosage: feed5textField.text!, fromDays: from5TextField.text!, toDays: toFeed5TextFeidl.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 5", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
                //

            } else if i == 5 {

                if sixthMoleculeLbl.text == NSLocalizedString("- Select -", comment: "") {

                    sixthMoleculeLbl.text = ""

                }

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: sixthMoleculeLbl.text!, dosage: feed6TextField.text!, fromDays: from6teXTfield.text!, toDays: toFeed6TextField.text!, coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 6", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)      //

            } else if i == 6 {

                CoreDataHandler().saveCoccoiControlDatabase(1, postingId: postingId as NSNumber, molecule: "", dosage: "", fromDays: "", toDays: "", coccidiosisVaccine: coccidiosisVaccineDrinkin.text!, targetWeight: "", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            }
            //            else if i == 5 {
            //                CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId , molecule  :"", dosage:"", fromDays: "", toDays:"", coccidiosisVaccine:coccidiosisVaccineDrinkin.text!, targetWeight:coccidiosTargetWeightfor.text!, index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text!)
            //
            //
            //            }

        }

        completion(true)
    }

    func saveAntibioticDatabase ( feedId: Int, postingId: Int, completion: (_ status: Bool) -> Void) {

        for i in 0..<6 {

            if i == 0 {
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType1.text!, dosage: antiDosageFirstTextField.text!, fromDays: antiFromDurationFirstTextField.text!, toDays: antiToDurationFirstTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 1", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )
            } else if i == 1 {

                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType2.text!, dosage: antiDosageSecondTextField.text!, fromDays: antiFromDurationSecondTextField.text!, toDays: antiToDurationSecondTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 2", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 2 {

                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType3.text!, dosage: antiDosageThirdTextField.text!, fromDays: antiFromDurationThirdTextField.text!, toDays: antiToDurationThirdTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 3", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 3 {

                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType4.text!, dosage: antiDosageFourTextField.text!, fromDays: antiFromDurationFourTextField.text!, toDays: antiToDurationFourTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 4", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            } else if i == 4 {

                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType5.text!, dosage: antiDosageFivthTextField
                    .text!, fromDays: antiFromFivthTextField.text!, toDays: antiToDurationfivthTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 5", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)

            } else if i == 5 {

                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType6.text!, dosage: antiDosageSixTextField.text!, fromDays: antiDosageSixTextField.text!, toDays: antiToDurationSixTextField.text!, index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 6", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            }

        }

        completion(true)
    }

    func saveAlternativeDatabase ( feedId: Int, postingId: Int, completion: (_ status: Bool) -> Void) {

        for i in 0..<6 {

            if i == 0 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType1Alternativ.text!, dosage: alternativeDosageFirstText.text!, fromDays: alternativeFromFirstTextField.text!, toDays: alternativeToFirstTextField.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 1", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 1 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType2Alternativ.text!, dosage: alternativeDosageSecoondText.text!, fromDays: alternativeFromSecondTextField.text!, toDays: alternativeToSecondTextField.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 2", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 2 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType3Alternativ.text!, dosage: alternativeDosageThirdText.text!, fromDays: alternativeFromthirdTextField.text!, toDays: alternativeTothirdTextField.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 3", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)

            } else if i == 3 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType4Alternativ.text!, dosage: alternativeDosageFourText.text!, fromDays: alternativeFromFourTextField.text!, toDays: alternativeToFourTextField.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 4", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )
            } else if i == 4 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType5Alternativ.text!, dosage: altrNativeDosage5Text.text!, fromDays: from5TextAlternative.text!, toDays: to5TextAlternative.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 5", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 5 {

                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType6Alternativ.text!, dosage: altrNativeDosage6Text.text!, fromDays: from6TextAlternative.text!, toDays: to6TextAlternative.text!, index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 6", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            }

        }

        completion(true)
    }

    func saveMyCoxtinDatabase ( feedId: Int, postingId: Int, completion: (_ status: Bool) -> Void) {

        for i in 0..<6 {

            if i == 0 {

                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType1MyCoxtin.text!, dosage: myCoxtinStarterDosage.text!, fromDays: myFromFirstTextField.text!, toDays: myToFirstTextField.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 1", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 1 {

                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType2MyCoxtin.text!, dosage: myCoxtinGrowerDosage.text!, fromDays: myFromSecondTextField.text!, toDays: myToSecondTextField.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 2", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)

            } else if i == 2 {
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType3MyCoxtin.text!, dosage: myCoxtinFinisherDosge.text!, fromDays: myFromThirdTextField.text!, toDays: myToThirdTextField.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 3", cocoVacId: CocoiVacId, lngId: lngId as NSNumber )

            } else if i == 3 {

                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType4MyCoxtin.text!, dosage: myCoxtinWDDosage.text!, fromDays: myFromFourTextField.text!, toDays: myToFourTextField.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 4", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            } else if i == 4 {
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType5MyCoxtin.text!, dosage: myCoxtin5DosageTextField.text!, fromDays: from5TextFieldMycoxtin.text!, toDays: to5TextFieldMycoxtin.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 5", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)

            } else if i == 5 {

                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType6MyCoxtin.text!, dosage: myCoxtin6DosageTextField.text!, fromDays: from6TextFieldMycoxtin.text!, toDays: to6TextFieldMycoxtin.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!, formName: addFarmSelectLbl.text!, isSync: true, feedType: "Feed type 6", cocoVacId: CocoiVacId, lngId: lngId as NSNumber)
            }
        }
        completion(true)
    }

    func buttonAction(sender: UIButton!) {
        buttonPopUP.alpha = 0
        ////print("Button tapped")

    }

    func clickHelpPopUp() {

        exitPopUP = popUP.loadFromNibNamed("popUP") as! popUP
        exitPopUP.tag = 0
        exitPopUP.delegatenEW = self
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)

    }

    func bckButtonCall() {

        isClickOnAnyField = true

        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")

        feedId = UserDefaults.standard.integer(forKey: "feedId")

        UserDefaults.standard.set(feedId, forKey: "feedId")
        UserDefaults.standard.synchronize()
    }

    func YesPopUpPosting() {

        if exitPopUP.tag == 10 || exitPopUP.tag == 20 {
            exitPopUP.tag = 200
            return
        }

        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        UserDefaults.standard.synchronize()

        ////print("value")
        strYesPop = ""
        self.CocoiVacId = 0
        navigatePostingsession = ""
        feedId = UserDefaults.standard.integer(forKey: "feedId")
        feedId = feedId + 1

        UserDefaults.standard.set(feedId, forKey: "feedId")
        UserDefaults.standard.synchronize()

        coccidsisStartrDrinking.text = NSLocalizedString("- Select -", comment: "")
        coccidsisGrowerDrinking.text = NSLocalizedString("- Select -", comment: "")
        cocciFinisherDrinkingWater.text = NSLocalizedString("- Select -", comment: "")
        coccidiosisWdDrinking.text = NSLocalizedString("- Select -", comment: "")
        fivthMoleculelBL.text = NSLocalizedString("- Select -", comment: "")
        sixthMoleculeLbl.text = NSLocalizedString("- Select -", comment: "")
        feed5textField.text = ""
        from5TextField.text = ""
        sixthMoleculeLbl.text = NSLocalizedString("- Select -", comment: "")
        feed6TextField.text = ""
        from6teXTfield.text = ""
        toFeed5TextFeidl.text = ""
        toFeed6TextField.text = ""
        antiMoleculeFeedType1.text = ""
        antiMoleculeFeedType2.text = ""
        antiMoleculeFeedType3.text = ""
        antiMoleculeFeedType4.text = ""
        antiMoleculeFeedType5.text = ""
        antiMoleculeFeedType6.text = ""
        antiDosageFivthTextField.text = ""
        antiFromFivthTextField.text = ""
        antiToDurationfivthTextField.text = ""
        antiDosageSixTextField.text = ""
        antiToDurationSixTextField.text = ""
        moleculeFeedType1Alternativ.text = ""
        moleculeFeedType2Alternativ.text = ""
        moleculeFeedType3Alternativ.text = ""
        moleculeFeedType4Alternativ.text = ""
        moleculeFeedType5Alternativ.text = ""
        moleculeFeedType6Alternativ.text = ""
        altrNativeDosage5Text.text = ""
        from5TextAlternative.text = ""
        to5TextAlternative.text = ""
        altrNativeDosage6Text.text = ""
        from6TextAlternative.text = ""
        to6TextAlternative.text = ""
        moleculeFeedType1MyCoxtin.text = ""
        moleculeFeedType2MyCoxtin.text = ""
        moleculeFeedType3MyCoxtin.text = ""
        moleculeFeedType4MyCoxtin.text = ""
        moleculeFeedType5MyCoxtin.text = ""
        myCoxtin5DosageTextField.text = ""
        from5TextFieldMycoxtin.text = ""
        to5TextFieldMycoxtin.text = ""
        moleculeFeedType6MyCoxtin.text = ""
        myCoxtin6DosageTextField.text = ""
        from6TextFieldMycoxtin.text = ""
        to6TextFieldMycoxtin.text = ""
        antiFromSixthTextField.text = ""
        starterDosageTextField.text = ""
        growerDosageCoccidiosisTEXT.text = ""
        finisherDosageTxtField.text = ""
        wdDosageTextField.text = ""
        FromstarterDurationTextField.text = ""
        FromGrowerTextField.text = ""
        fromFinisherTextField.text = ""
        fromWDtextField.text = ""
        toStarterTextField.text = ""
        toGrowerTextField.text = ""
        toFinisherTextField.text = ""
        toWdTextField.text = ""
        coccidiosisVaccineDrinkin.text = NSLocalizedString("- Select -", comment: "")
        antiDosageFirstTextField.text = ""
        antiDosageSecondTextField.text = ""
        antiDosageThirdTextField.text = ""
        antiDosageFourTextField.text = ""
        antiFromDurationFirstTextField.text = ""
        antiFromDurationSecondTextField.text = ""
        antiFromDurationThirdTextField.text = ""
        antiFromDurationFourTextField.text = ""
        antiToDurationFirstTextField.text = ""
        antiToDurationSecondTextField.text = ""
        antiToDurationThirdTextField.text = ""
        antiToDurationFourTextField.text = ""
        alternativeDosageFirstText.text = ""
        alternativeDosageSecoondText.text = ""
        alternativeDosageThirdText.text = ""
        alternativeDosageFourText.text = ""
        alternativeFromFirstTextField.text = ""
        alternativeFromSecondTextField.text = ""

        alternativeFromthirdTextField.text = ""
        alternativeFromFourTextField.text = ""
        alternativeToFirstTextField.text = ""
        alternativeToSecondTextField.text = ""
        alternativeTothirdTextField.text = ""
        alternativeToFourTextField.text = ""
        myCoxtinStarterDosage.text = ""
        myCoxtinGrowerDosage.text =  ""
        myCoxtinFinisherDosge.text = ""
        myCoxtinWDDosage.text = ""
        myFromFirstTextField.text = ""
        myFromSecondTextField.text = ""
        myFromThirdTextField.text = ""
        myFromFourTextField.text = ""
        myToFirstTextField.text = ""
        myToSecondTextField.text = ""
        myToThirdTextField.text = ""
        myToFourTextField.text = ""
        feedProgramTextField.text = ""
        addFarmSelectLbl.text = NSLocalizedString("- Select -", comment: "")
        self.coccidiosisControlBtnActoin(sender: "0" as AnyObject)

        self.printSyncLblCount()

    }
    var datCount = 0

    func noPopUpPosting() {

        if exitPopUP.tag == 10 {
            btnTagsave = 2
            callSaveMethod(btnTagSave: btnTagsave)
        } else if exitPopUP.tag == 20 {
            btnTagsave = 2
            callSaveMethod(btnTagSave: btnTagsave)

        } else {
            UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isFeedProgramClick = true
            appDelegate.sendFeedVariable = "Feed"
            appDelegate.strImpFedd = feedImpandMetric
            appDelegate.newColor = datCount + 1
            self.navigationController?.popViewController(animated: true)

        }
    }

    /******************** TableView Delegate and dataSource Method **************************************/

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == farmTableView {
            return addFarmArray.count

        } else {

            switch btnTag {
            case 0:
                return cocciControlArrayfromServer.count
            case 1:
                return AlternativeArrayfromServer.count
            case 2:
                return AntiboticArrayfromServer.count
            case 3:
                return MyCoxtinBindersArrayfromServer.count
            case 4:
                return cocodiceVacine.count

            default:

                if feedImpandMetric == "Metric"{
                    return arrTagetMetric.count
                } else {
                    return arrTargetImp.count

                }

            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if  tableView == farmTableView {

            let cell: secTableViewCell = self.farmTableView
                .dequeueReusableCell(withIdentifier: "cell") as! secTableViewCell

            cell.farmsShowLbl?.text = addFarmArray.object(at: indexPath.row) as? String

            if addFarmArrayWithUnCheckForm.count>0 {
                let c = addFarmArrayWithUnCheckForm.object(at: indexPath.row) as! CaptureNecropsyData
                if c.isChecked == 1 {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }

            } else {
                cell.accessoryType = .none
            }

            return cell

        } else {

            let cell = UITableViewCell()

            if btnTag == 0 {
                let cocoiControll = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as! String
                cell.textLabel!.text = cocoiControll

            } else if btnTag == 1 {

                let cocoiControll = (AlternativeArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as! String
                cell.textLabel!.text = cocoiControll

            } else if btnTag == 2 {

                let cocoiControll = (AntiboticArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as! String
                cell.textLabel!.text = cocoiControll

            } else if btnTag == 3 {
                let cocoiControll = (MyCoxtinBindersArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as! String
                cell.textLabel!.text = cocoiControll

            } else if btnTag == 4 {
                cell.textLabel!.text = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocoiiVacname") as? String

            } else if btnTag == 5 {

                if feedImpandMetric == "Metric"{
                    cell.textLabel!.text = arrTagetMetric[indexPath.row] as? String
                    } else {
                    cell.textLabel!.text = arrTargetImp[indexPath.row] as? String
                }

            }
            return cell
        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == farmTableView {

            let newCell: secTableViewCell = self.farmTableView.cellForRow(at: indexPath as IndexPath) as! secTableViewCell

            UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
            UserDefaults.standard.synchronize()

            //print(addFarmArray)

            let formName = addFarmArray.object(at: indexPath.row) as! String
            //feedIdFromFarm = addFarmArray.object(at:indexPath.row) as! Int

            if (newCell.accessoryType == .checkmark) {

                if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                    let necId1 =  UserDefaults.standard.integer(forKey: "necUnLinked")
                    postingId = necId1 as NSNumber

                }

                if navigatePostingsession == "PostingFeedProgram"{

                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: false, feedId: feedPostingId as NSNumber)
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccIdFeddprogramBlank(postingId as NSNumber, formName: formName, feedId: feedPostingId as NSNumber)
                } else {
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: false, feedId: feedId as NSNumber)
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccIdFeddprogramBlank(postingId as NSNumber, formName: formName, feedId: feedPostingId as NSNumber)
                }

                newCell.accessoryType = .none

                isClickOnAnyField = true

            } else {

                if navigatePostingsession == "PostingFeedProgram"{

                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        let necId =  UserDefaults.standard.integer(forKey: "necUnLinked")

                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: true, feedId: feedPostingId as NSNumber)
                    } else {
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: true, feedId: feedPostingId as NSNumber)
                    }

                } else {
                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        let necId =  UserDefaults.standard.integer(forKey: "necUnLinked")
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: true, feedId: feedId as NSNumber)

                    } else {
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!, formName: formName, isCheckForm: true, feedId: feedId as NSNumber)
                    }

                }

                newCell.accessoryType = .checkmark

                isClickOnAnyField = true

            }

        } else {

            let cell: UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
            if btnTag == 0 {

                if Allbuttonbg == 0 {

                    coccidsisStartrDrinking.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                } else if Allbuttonbg == 1 {
                    coccidsisGrowerDrinking.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                } else if Allbuttonbg == 2 {
                    cocciFinisherDrinkingWater.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                } else if Allbuttonbg == 3 {

                    coccidiosisWdDrinking.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                } else if Allbuttonbg == 40 {
                    fivthMoleculelBL.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                } else if Allbuttonbg == 50 {

                    sixthMoleculeLbl.text = (cocciControlArrayfromServer.value(forKey: "desc") as AnyObject).object(at: indexPath.row) as? String

                    isClickOnAnyField = true
                }
            } else if btnTag == 1 {

            } else if btnTag == 2 {

            } else if btnTag == 3 {

            } else if btnTag == 4 {
               // let cocoiControll = cocodiceVacine.object(at: indexPath.row) as! CocoiVaccine
                coccidiosisVaccineDrinkin.text = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocoiiVacname") as? String
                CocoiVacId = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocvaccId") as! NSNumber

                  //  cocoiControll.cocvaccId!

                buttonCocotarget()

                isClickOnAnyField = true

            } else if btnTag == 5 {
                if feedImpandMetric == "Metric"{
                } else {

                }
                buttonCocotarget()

                isClickOnAnyField = true
            }

        }
        buttonPressed1()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        farmTableView.alpha = 0

        let fullString = textField.text
        var ffullStringArr = fullString?.components(separatedBy: ".")
        let firstStr: String = ffullStringArr![0]
        let lastStr: String? = ffullStringArr!.count > 1 ? ffullStringArr![1] : nil
        textField.text = lastStr?.count == 0 ? firstStr : fullString
        isClickOnAnyField = true

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == coccidsisStartrDrinking ) {
            feedProgramTextField.returnKeyType = UIReturnKeyType.done
        } else {
            antiToDurationFourTextField.returnKeyType = UIReturnKeyType.done
            antiToDurationThirdTextField.returnKeyType = UIReturnKeyType.done
            starterDosageTextField.returnKeyType = UIReturnKeyType.done
            growerDosageCoccidiosisTEXT.returnKeyType = UIReturnKeyType.done
            finisherDosageTxtField.returnKeyType = UIReturnKeyType.done
            wdDosageTextField.returnKeyType = UIReturnKeyType.done
            FromstarterDurationTextField.returnKeyType = UIReturnKeyType.done
            FromGrowerTextField.returnKeyType = UIReturnKeyType.done
            fromFinisherTextField.returnKeyType = UIReturnKeyType.done
            fromWDtextField.returnKeyType = UIReturnKeyType.done
            toStarterTextField.returnKeyType = UIReturnKeyType.done
            toGrowerTextField.returnKeyType = UIReturnKeyType.done
            toFinisherTextField.returnKeyType = UIReturnKeyType.done
            toWdTextField.returnKeyType = UIReturnKeyType.done
            antiFromDurationFirstTextField.returnKeyType = UIReturnKeyType.done
            antiFromDurationSecondTextField.returnKeyType = UIReturnKeyType.done
            antiFromDurationThirdTextField.returnKeyType = UIReturnKeyType.done
            antiFromDurationFourTextField.returnKeyType = UIReturnKeyType.done
            antiToDurationFirstTextField.returnKeyType = UIReturnKeyType.done
            antiToDurationSecondTextField.returnKeyType = UIReturnKeyType.done
            antiDosageFirstTextField.returnKeyType = UIReturnKeyType.done
            antiDosageSecondTextField.returnKeyType = UIReturnKeyType.done
            antiDosageThirdTextField.returnKeyType = UIReturnKeyType.done
            antiDosageFourTextField.returnKeyType = UIReturnKeyType.done
            alternativeFromFourTextField.returnKeyType = UIReturnKeyType.done
            alternativeToFirstTextField.returnKeyType = UIReturnKeyType.done
            alternativeToSecondTextField.returnKeyType = UIReturnKeyType.done
            alternativeTothirdTextField.returnKeyType = UIReturnKeyType.done
            alternativeDosageFirstText.returnKeyType = UIReturnKeyType.done
            alternativeDosageSecoondText.returnKeyType = UIReturnKeyType.done
            alternativeDosageThirdText.returnKeyType = UIReturnKeyType.done
            alternativeDosageFourText.returnKeyType = UIReturnKeyType.done
            alternativeFromFirstTextField.returnKeyType = UIReturnKeyType.done
            alternativeFromSecondTextField.returnKeyType = UIReturnKeyType.done
            alternativeFromthirdTextField.returnKeyType = UIReturnKeyType.done
            alternativeToFourTextField.returnKeyType = UIReturnKeyType.done
            feedProgramTextField.returnKeyType = UIReturnKeyType.done
            myFromThirdTextField.returnKeyType = UIReturnKeyType.done
            myToFourTextField.returnKeyType = UIReturnKeyType.done
            myToThirdTextField.returnKeyType = UIReturnKeyType.done
            myToSecondTextField.returnKeyType = UIReturnKeyType.done
            myToFirstTextField.returnKeyType = UIReturnKeyType.done
            myFromFourTextField.returnKeyType = UIReturnKeyType.done
            farmTableView.alpha = 0

        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    func touchMoved() {
        ////print("touch moved")
    }

    func touchBegan() {
        ////print("touch began")
    }

    func animateView (movement: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        feedProgramTextField.becomeFirstResponder()
        feedProgramTextField.resignFirstResponder()

        return true
    }

    //////////////////////// Logout /////////////////////

    var logOutPopView1: UserListView!

    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView, indexValue: String) {

        if indexValue == "Log Out" {

            UserDefaults.standard.removeObject(forKey: "login")
            if (Reachability()?.isReachable)! {

                CoreDataHandler().deleteAllData("Custmer")
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)

            buttonbg.removeFromSuperview()
            logOutPopView1.removeView(view)

        }
    }
    let buttonbg1 = UIButton()

    @IBAction func logOUT(sender: AnyObject) {
        let feedProgramArray = CoreDataHandler().FetchFeedProgram(postingId as NSNumber)
        let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(postingId as NSNumber)
        if feedProgramArray.count<1 || feedProgramTextField.text == "" {
            // Create the alert controller
            if farms.count > 0 {
                self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 20)

                return
            }
        } else if farms.count > 0 {
            self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 20)
        } else {
            clickHelp()
        }

    }
    ///////////////////////////////////// Numeric Keypad set //////////////////////////

    func clickHelp() {

        buttonbg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)

        buttonbg1.addTarget(self, action: #selector(FeedProgramViewController.logOytButtn), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonbg1)

        logOutPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        logOutPopView1.logoutDelegate = self

        logOutPopView1.layer.cornerRadius = 8
        logOutPopView1.layer.borderWidth = 3
        logOutPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1 .addSubview(logOutPopView1)
        logOutPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200, y: 60, width: 150, height: 60))
    }

    @objc func logOytButtn () {
        buttonbg1.removeFromSuperview()
        logOutPopView1.removeFromSuperview()

    }

    func textFeildValidation() -> Bool {

        if(flag == 1) {

            if(FromstarterDurationTextField.text! >= toStarterTextField.text!) {
            }

            if (FromstarterDurationTextField.text! >= toStarterTextField.text! ) ||
                ( FromGrowerTextField.text! >= toGrowerTextField.text! ) ||
                ( fromFinisherTextField.text! >= toFinisherTextField.text! ) ||
                ( fromWDtextField.text! >= toWdTextField.text! ) {
                return false
            } else {
                return true
            }
        } else if( flag == 2) {

            if(( antiFromDurationFirstTextField.text! >= antiToDurationFirstTextField.text! ) ||
                ( antiFromDurationSecondTextField.text! >= antiToDurationSecondTextField.text!) ||
                ( antiFromDurationThirdTextField.text! >= antiToDurationThirdTextField.text!) ||
                ( antiFromDurationFourTextField.text! >= antiToDurationFourTextField.text!)) {
                return false
            } else {
                return true
            }
        } else if(flag == 3) {

            if(( alternativeFromFirstTextField.text! >= alternativeToFirstTextField.text! ) || ( alternativeFromSecondTextField.text! >=
                alternativeToSecondTextField.text! ) || ( alternativeFromthirdTextField.text! >= alternativeTothirdTextField.text! ) || ( alternativeFromFourTextField.text! >= alternativeToFourTextField.text! )) {
                return false
            } else {
                return true
            }
        }

        if(flag == 4) {

            if(( myFromFirstTextField.text! >= myToFirstTextField.text! ) || ( myFromSecondTextField.text! >= myToSecondTextField.text! ) || ( myFromThirdTextField.text! >= myToFirstTextField.text! ) || ( myFromFourTextField.text! >= myToFourTextField.text! )) {
                return false
            } else {
                return true
            }
        } else {
            return false
        }
    }

    @IBAction func toStarterTextField(sender: AnyObject) {

        if antiFromDurationFirstTextField.text! < antiToDurationFirstTextField.text! {
            // 10 < 12
            //not fill < 10 alert please fill first value
            //10 not fill
        } else if antiFromDurationFirstTextField.text! > antiToDurationFirstTextField.text! {
            //fromToAlert()
            //12 < 10 alert

        }

    }

    @IBAction func fromStarterTextField(sender: AnyObject) {

        if antiFromDurationFirstTextField.text?.isEmpty == true {

            antiToDurationFirstTextField.isUserInteractionEnabled = true

        } else if antiFromDurationFirstTextField.text?.isEmpty == true {

            antiToDurationFirstTextField.isUserInteractionEnabled = false

        }

    }

    @IBAction func toAntiboticSecondTextField(sender: AnyObject) {

        if antiFromDurationSecondTextField.text! < antiToDurationSecondTextField.text! {

        } else if antiFromDurationSecondTextField.text! > antiToDurationSecondTextField.text! {
            // fromToAlert()

        }
    }
    @IBAction func toAntiboticThreeTextField(sender: AnyObject) {

        if antiFromDurationThirdTextField.text! < antiToDurationThirdTextField.text! {

        } else if antiFromDurationThirdTextField.text! > antiToDurationThirdTextField.text! {
            //  fromToAlert()

        }

    }
    @IBAction func toAntiboticFourTextField(sender: AnyObject) {

        if antiFromDurationFourTextField.text! < antiToDurationFourTextField.text! {

        } else if antiFromDurationFourTextField.text! > antiToDurationFourTextField.text! {

            // fromToAlert()
        }

    }
    @IBAction func toAntiboticFiveTextField(sender: AnyObject) {

        if antiFromFivthTextField.text! < antiToDurationfivthTextField.text! {

        } else if antiFromFivthTextField.text! > antiToDurationfivthTextField.text! {

            //  fromToAlert()
        }

    }
    @IBAction func toAntiboticSixTextField(sender: AnyObject) {

        if antiFromSixthTextField.text! < antiToDurationSixTextField.text! {

        } else if antiFromSixthTextField.text! > antiToDurationSixTextField.text! {

            //  fromToAlert()
        }

    }
    func spacingInTxtField() {

        let cusPaddingView = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        antiMoleculeFeedType1.leftView = cusPaddingView
        antiMoleculeFeedType1.leftViewMode = .always

        let cusPaddingView1 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiMoleculeFeedType2.leftView = cusPaddingView1
        antiMoleculeFeedType2.leftViewMode = .always

        let cusPaddingView2 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiMoleculeFeedType3.leftView = cusPaddingView2
        antiMoleculeFeedType3.leftViewMode = .always

        let cusPaddingView3 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiMoleculeFeedType4.leftView = cusPaddingView3
        antiMoleculeFeedType4.leftViewMode = .always

        let cusPaddingView4 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiMoleculeFeedType5.leftView = cusPaddingView4
        antiMoleculeFeedType5.leftViewMode = .always

        let cusPaddingView5 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiMoleculeFeedType6.leftView = cusPaddingView5
        antiMoleculeFeedType6.leftViewMode = .always

        let cusPaddingView6 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        feedProgramTextField.leftView = cusPaddingView6
        feedProgramTextField.leftViewMode = .always

        let cusPaddingView7 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiDosageFirstTextField.leftView = cusPaddingView7
        antiDosageFirstTextField.leftViewMode = .always

        let cusPaddingView8 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromDurationFirstTextField.leftView = cusPaddingView8
        antiFromDurationFirstTextField.leftViewMode = .always

        let cusPaddingView9 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiToDurationFirstTextField.leftView = cusPaddingView9
        antiToDurationFirstTextField.leftViewMode = .always

        let cusPaddingView10 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiDosageSecondTextField.leftView = cusPaddingView10
        antiDosageSecondTextField.leftViewMode = .always

        let cusPaddingView11 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromDurationSecondTextField.leftView = cusPaddingView11
        antiFromDurationSecondTextField.leftViewMode = .always

        let cusPaddingView12 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiToDurationSecondTextField.leftView = cusPaddingView12
        antiToDurationSecondTextField.leftViewMode = .always

        let cusPaddingView13 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        antiDosageThirdTextField.leftView = cusPaddingView13
        antiDosageThirdTextField.leftViewMode = .always

        let cusPaddingView14 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromDurationThirdTextField.leftView = cusPaddingView14
        antiFromDurationThirdTextField.leftViewMode = .always

        let cusPaddingView15 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiToDurationThirdTextField.leftView = cusPaddingView15
        antiToDurationThirdTextField.leftViewMode = .always

        let cusPaddingView16 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiDosageFourTextField.leftView = cusPaddingView16
        antiDosageFourTextField.leftViewMode = .always

        let cusPaddingView17 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromDurationFourTextField.leftView = cusPaddingView17
        antiFromDurationFourTextField.leftViewMode = .always

        let cusPaddingView18 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        antiToDurationFourTextField.leftView = cusPaddingView18
        antiToDurationFourTextField.leftViewMode = .always

        let cusPaddingView19 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiDosageFivthTextField.leftView = cusPaddingView19
        antiDosageFivthTextField.leftViewMode = .always

        let cusPaddingView20 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromFivthTextField.leftView = cusPaddingView20
        antiFromFivthTextField.leftViewMode = .always

        let cusPaddingView21 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiToDurationfivthTextField.leftView = cusPaddingView21
        antiToDurationfivthTextField.leftViewMode = .always

        let cusPaddingView22 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiDosageSixTextField.leftView = cusPaddingView22
        antiDosageSixTextField.leftViewMode = .always

        let cusPaddingView23 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiFromSixthTextField.leftView = cusPaddingView23
        antiFromSixthTextField.leftViewMode = .always

        let cusPaddingView24 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        antiToDurationSixTextField.leftView = cusPaddingView24
        antiToDurationSixTextField.leftViewMode = .always

        /////
        let cusPaddingView25 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        starterDosageTextField.leftView = cusPaddingView25
        starterDosageTextField.leftViewMode = .always

        let cusPaddingView26 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        FromstarterDurationTextField.leftView = cusPaddingView26
        FromstarterDurationTextField.leftViewMode = .always

        let cusPaddingView27 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        toStarterTextField.leftView = cusPaddingView27
        toStarterTextField.leftViewMode = .always

        let cusPaddingView28 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        growerDosageCoccidiosisTEXT.leftView = cusPaddingView28
        growerDosageCoccidiosisTEXT.leftViewMode = .always
        let cusPaddingView29 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        FromGrowerTextField.leftView = cusPaddingView29
        FromGrowerTextField.leftViewMode = .always
        let cusPaddingView30 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        toGrowerTextField.leftView = cusPaddingView30
        toGrowerTextField.leftViewMode = .always

        let cusPaddingView31 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        finisherDosageTxtField.leftView = cusPaddingView31
        finisherDosageTxtField.leftViewMode = .always

        let cusPaddingView32 = UIView()
        cusPaddingView32.frame = CGRect(x: 15, y: 0, width: 10, height: 20)

        let cusPaddingView33 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView34 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView35 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView36 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView37 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView38 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView39 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView40 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView41 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView42 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView43 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView44 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView45 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView46 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView47 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView48 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView49 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView50 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView51 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView52 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView53 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView54 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView55 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView56 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView57 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView58 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView59 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView60 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView61 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView62 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView63 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView64 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView65 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView66 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView67 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView68 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView69 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView70 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView71 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView72 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView73 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView74 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView75 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView76 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView77 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView78 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView79 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView80 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView81 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView82 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView83 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView84 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView85 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView86 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView87 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView88 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView89 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))
        let cusPaddingView90 = UIView(frame: CGRect(x: 15, y: 0, width: 10, height: 20))

        fromFinisherTextField.leftView = cusPaddingView32
        fromFinisherTextField.leftViewMode = .always
        toFinisherTextField.leftView = cusPaddingView33
        toFinisherTextField.leftViewMode = .always

        wdDosageTextField.leftView = cusPaddingView34
        wdDosageTextField.leftViewMode = .always
        fromWDtextField.leftView = cusPaddingView35
        fromWDtextField.leftViewMode = .always
        toWdTextField.leftView = cusPaddingView36
        toWdTextField.leftViewMode = .always

        feed5textField.leftView = cusPaddingView37
        feed5textField.leftViewMode = .always
        from5TextField.leftView = cusPaddingView38
        from5TextField.leftViewMode = .always
        toFeed5TextFeidl.leftView = cusPaddingView39
        toFeed5TextFeidl.leftViewMode = .always

        feed6TextField.leftView = cusPaddingView40
        feed6TextField.leftViewMode = .always
        from6teXTfield.leftView = cusPaddingView41
        from6teXTfield.leftViewMode = .always
        toFeed6TextField.leftView = cusPaddingView42
        toFeed6TextField.leftViewMode = .always

        ////
        moleculeFeedType1Alternativ.leftView = cusPaddingView43
        moleculeFeedType1Alternativ.leftViewMode = .always
        alternativeDosageFirstText.leftView = cusPaddingView44
        alternativeDosageFirstText.leftViewMode = .always
        alternativeFromFirstTextField.leftView = cusPaddingView45
        alternativeFromFirstTextField.leftViewMode = .always
        alternativeToFirstTextField.leftView = cusPaddingView46
        alternativeToFirstTextField.leftViewMode = .always

        moleculeFeedType2Alternativ.leftView = cusPaddingView47
        moleculeFeedType2Alternativ.leftViewMode = .always
        alternativeDosageSecoondText.leftView = cusPaddingView48
        alternativeDosageSecoondText.leftViewMode = .always
        alternativeFromSecondTextField.leftView = cusPaddingView49
        alternativeFromSecondTextField.leftViewMode = .always
        alternativeToSecondTextField.leftView = cusPaddingView50
        alternativeToSecondTextField.leftViewMode = .always

        moleculeFeedType3Alternativ.leftView = cusPaddingView51
        moleculeFeedType3Alternativ.leftViewMode = .always
        alternativeDosageThirdText.leftView = cusPaddingView52
        alternativeDosageThirdText.leftViewMode = .always
        alternativeFromthirdTextField.leftView = cusPaddingView53
        alternativeFromthirdTextField.leftViewMode = .always
        alternativeTothirdTextField.leftView = cusPaddingView54
        alternativeTothirdTextField.leftViewMode = .always

        moleculeFeedType4Alternativ.leftView = cusPaddingView55
        moleculeFeedType4Alternativ.leftViewMode = .always
        alternativeDosageFourText.leftView = cusPaddingView56
        alternativeDosageFourText.leftViewMode = .always
        alternativeFromFourTextField.leftView = cusPaddingView57
        alternativeFromFourTextField.leftViewMode = .always
        alternativeToFourTextField.leftView = cusPaddingView58
        alternativeToFourTextField.leftViewMode = .always

        moleculeFeedType5Alternativ.leftView = cusPaddingView59
        moleculeFeedType5Alternativ.leftViewMode = .always
        altrNativeDosage5Text.leftView = cusPaddingView60
        altrNativeDosage5Text.leftViewMode = .always
        from5TextAlternative.leftView = cusPaddingView61
        from5TextAlternative.leftViewMode = .always
        to5TextAlternative.leftView = cusPaddingView62
        to5TextAlternative.leftViewMode = .always

        moleculeFeedType6Alternativ.leftView = cusPaddingView63
        moleculeFeedType6Alternativ.leftViewMode = .always
        altrNativeDosage6Text.leftView = cusPaddingView64
        altrNativeDosage6Text.leftViewMode = .always
        from6TextAlternative.leftView = cusPaddingView65
        from6TextAlternative.leftViewMode = .always
        to6TextAlternative.leftView = cusPaddingView66
        to6TextAlternative.leftViewMode = .always

        moleculeFeedType1MyCoxtin.leftView = cusPaddingView67
        moleculeFeedType1MyCoxtin.leftViewMode = .always
        myCoxtinStarterDosage.leftView = cusPaddingView68
        myCoxtinStarterDosage.leftViewMode = .always
        myFromFirstTextField.leftView = cusPaddingView69
        myFromFirstTextField.leftViewMode = .always
        myToFirstTextField.leftView = cusPaddingView70
        myToFirstTextField.leftViewMode = .always

        moleculeFeedType2MyCoxtin.leftView = cusPaddingView71
        moleculeFeedType2MyCoxtin.leftViewMode = .always
        myCoxtinGrowerDosage.leftView = cusPaddingView72
        myCoxtinGrowerDosage.leftViewMode = .always
        myFromSecondTextField.leftView = cusPaddingView73
        myFromSecondTextField.leftViewMode = .always
        myToSecondTextField.leftView = cusPaddingView74
        myToSecondTextField.leftViewMode = .always

        moleculeFeedType3MyCoxtin.leftView = cusPaddingView75
        moleculeFeedType3MyCoxtin.leftViewMode = .always
        myCoxtinFinisherDosge.leftView = cusPaddingView76
        myCoxtinFinisherDosge.leftViewMode = .always
        myFromThirdTextField.leftView = cusPaddingView77
        myFromThirdTextField.leftViewMode = .always
        myToThirdTextField.leftView = cusPaddingView78
        myToThirdTextField.leftViewMode = .always

        moleculeFeedType4MyCoxtin.leftView = cusPaddingView79
        moleculeFeedType4MyCoxtin.leftViewMode = .always
        myCoxtinWDDosage.leftView = cusPaddingView80
        myCoxtinWDDosage.leftViewMode = .always
        myFromFourTextField.leftView = cusPaddingView81
        myFromFourTextField.leftViewMode = .always
        myToFourTextField.leftView = cusPaddingView82
        myToFourTextField.leftViewMode = .always

        moleculeFeedType5MyCoxtin.leftView = cusPaddingView83
        moleculeFeedType5MyCoxtin.leftViewMode = .always
        myCoxtin5DosageTextField.leftView = cusPaddingView84
        myCoxtin5DosageTextField.leftViewMode = .always
        from5TextFieldMycoxtin.leftView = cusPaddingView85
        from5TextFieldMycoxtin.leftViewMode = .always
        to5TextFieldMycoxtin.leftView = cusPaddingView86
        to5TextFieldMycoxtin.leftViewMode = .always

        moleculeFeedType6MyCoxtin.leftView = cusPaddingView87
        moleculeFeedType6MyCoxtin.leftViewMode = .always
        myCoxtin6DosageTextField.leftView = cusPaddingView88
        myCoxtin6DosageTextField.leftViewMode = .always
        from6TextFieldMycoxtin.leftView = cusPaddingView89
        from6TextFieldMycoxtin.leftViewMode = .always
        to6TextFieldMycoxtin.leftView = cusPaddingView90
        to6TextFieldMycoxtin.leftViewMode = .always

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField.tag {

        case 11, 12, 13, 14, 19, 20, 21, 26, 27, 28, 29, 30, 31, 32, 33, 38, 39, 40, 41, 42, 43, 44, 45, 46, 51, 52, 53, 54, 55, 56, 57, 58, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 114, 115, 116, 117, 120, 121, 122, 123, 126, 127, 128, 129, 132, 133, 134, 135, 136 :

            let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString

            return string == numberFiltered && newString.length <= maxLength
        case 15, 16, 17, 18, 23, 22, 24, 25, 34, 35, 36, 37, 47, 48, 49, 50, 112, 113, 118, 119, 124, 125, 130, 131 :

            let aSet = NSCharacterSet(charactersIn: "0123456789.").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 7
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
            if countdots > 0 && string == "." {
                return false
            }
            return string == numberFiltered && newString.length <= maxLength

        case 333 :

            let maxLength = 50
            let currentString: NSString = feedProgramTextField.text as! NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength

        default : break
            //print( "default case")
        }
        isClickOnAnyField = true
        return true

    }
    @IBAction func addFarmBtnAction(sender: AnyObject) {

        if  feedProgramTextField.text == "" {

            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please enter feed program.", comment: ""))

        } else {

            feedArr.removeAllObjects()
            addFarmArray.removeAllObjects()
            addFarmArrayWithUnCheckForm.removeAllObjects()
            let necId =  UserDefaults.standard.integer(forKey: "necUnLinked")

            let isUpadateFeedFromUnlinked = UserDefaults.standard.bool(forKey: "isUpadteFeedFromUnlinked")

            if isUpadateFeedFromUnlinked == true {

                if navigatePostingsession == "PostingFeedProgram"{

                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedPostingId as NSNumber).mutableCopy() as! NSMutableArray
                } else {
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedId as NSNumber).mutableCopy() as!  NSMutableArray
                }

                let feedArr1 = CoreDataHandler().FetchNecropsystep1neccIdWithCheckFarm(necId as NSNumber).mutableCopy() as! NSMutableArray

                feedArr.addObjects(from: feedArr1 as [AnyObject])

                for i in  0..<feedArr.count {
                    let  c = feedArr.object(at: i) as! CaptureNecropsyData
                    addFarmArray.add(c.farmName!)
                    addFarmArrayWithUnCheckForm.add(feedArr.object(at: i))

                }

            } else {
                if navigatePostingsession == "PostingFeedProgram"{
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedPostingId as NSNumber).mutableCopy() as! NSMutableArray
                } else {
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!, feedId: feedId as NSNumber).mutableCopy() as! NSMutableArray
                }

                // FarmArray = CoreDataHandler().FetchNecropsystep1neccIdWithCheckFarm(necId).mutableCopy() as! NSMutableArray

                let feedArr1 = CoreDataHandler().FetchNecropsystep1neccIdWithCheckFarm(necId as NSNumber).mutableCopy() as AnyObject

                feedArr.addObjects(from: feedArr1 as! [AnyObject])

                for i in  0..<feedArr.count {
                    let  c = feedArr.object(at: i) as! CaptureNecropsyData
                    addFarmArray.add(c.farmName!)
                    addFarmArrayWithUnCheckForm.add(feedArr.object(at: i))

                }

            }

            if addFarmArray.count == 0 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "You don't have any farm to add in feed.")

                //                addFarmBtnOutlet.backgroundColor =  UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.1)
                //                addFarmSelectLbl.textColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.1)
                //                addFarmBtnOutlet.isUserInteractionEnabled = false
            } else {
                //                addFarmBtnOutlet.isUserInteractionEnabled = true
                //
                //                addFarmBtnOutlet.backgroundColor =  UIColor.whiteColor()
                //                addFarmSelectLbl.textColor = UIColor.blackColor()
                addFarmPopp()
                farmTableView.alpha = 1

                farmTableView.layer.borderWidth = 1
                farmTableView.layer.cornerRadius = 7
                farmTableView.layer.borderColor =  UIColor.clear.cgColor

                farmTableView.frame = CGRect(x: 335, y: 500, width: 375, height: 150)

                farmTableView.reloadData()
            }

        }

    }

    func removeDuplicates(array: NSMutableArray) -> NSMutableArray {
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

    func addFarmPopp() {

        backBtnnFrame.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        backBtnnFrame.addTarget(self, action: #selector(FeedProgramViewController.addFarmEnd), for: .touchUpInside)
        backBtnnFrame.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view.addSubview(backBtnnFrame)
        backBtnnFrame.addSubview(farmTableView)
    }

    @objc func addFarmEnd() {

        let necId =  UserDefaults.standard.integer(forKey: "necUnLinked")

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            let necId1 =  UserDefaults.standard.integer(forKey: "necUnLinked")
            postingId = necId1 as NSNumber

        }

        if navigatePostingsession == "PostingFeedProgram"{
            farmArrayTrue = CoreDataHandler().FetchNecropsystep1neccIdTrueVal(postingId as NSNumber, formTrueValue: true, feedProgram: feedProgramTextField.text!, feedId: feedPostingId as NSNumber)
        } else {

            farmArrayTrue = CoreDataHandler().FetchNecropsystep1neccIdTrueVal(postingId as NSNumber, formTrueValue: true, feedProgram: feedProgramTextField.text!, feedId: feedId as NSNumber)
        }

        if farmArrayTrue.count > 0 {

            let ftitle = NSMutableString()
            for i in 0..<farmArrayTrue.count {

                var label = UILabel()
                let feepRGMR = (farmArrayTrue.object(at: i) as AnyObject).value(forKey: "farmName") as! String

                //print(feepRGMR)

                if i == 0 {
                    //label  = UILabel(frame: CGRectMake(239, 519, 111, 21))

                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111, height: 21))

                    ftitle.append( feepRGMR + " " )

                } else {

                    //label  = UILabel(frame: CGRectMake(239*(CGFloat(i)+1)+10, 519, 111, 21))

                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111*(CGFloat(i)+1)+10, height: 21))

                    ftitle.append(", " + feepRGMR + " " )

                }

                //label.center = CGPointMake(160, 284)

                label.textAlignment = NSTextAlignment.center
                label.backgroundColor = UIColor.red

                addFarmSelectLbl.text = ftitle as String
                //feedProgramOutlet.addSubview(label)
            }

        } else {
            addFarmSelectLbl.text = NSLocalizedString("- Select -", comment: "")
        }

        btnTag = 0
        backBtnnFrame.removeFromSuperview()
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
    @IBAction func syncBttnAction(sender: AnyObject) {
        let feedProgramArray = CoreDataHandler().FetchFeedProgram(postingId as NSNumber)
        let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(postingId as NSNumber)
        if feedProgramArray.count < 1 {
            // Create the alert controller
            if feedProgramTextField.text == ""{
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: NSLocalizedString("Please enter feed program.", comment: ""))
                return
            } else if farms.count > 0 {
                self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 10)

                return
            } else {
                self.showExitAlertWith(msg: "Do you want to add more information to this page?", tag: 10)
                return

            }

        } else if farms.count > 0 {
            self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 10)
        } else {
            if self.allSessionArr().count > 0 {
                if Reachability()?.isReachable == true {

                    btnTagsave = 2
                    callSaveMethod(btnTagSave: btnTagsave)

                    Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data syncing...", comment: ""))
                    self.callSyncApi()
                } else {

                    Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
                }
            } else {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data not available for syncing.", comment: ""))
            }

        }

    }
    func showExitAlertWith(msg: String, tag: Int) {

        exitPopUP = popUP.loadFromNibNamed("popUP") as! popUP!
        exitPopUP.lblFedPrgram.text = msg
        exitPopUP.tag = tag
        exitPopUP.lblFedPrgram.textAlignment = .center
        exitPopUP.delegatenEW = self
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)

    }
    func callSyncApi() {
        objApiSync.feedprogram()
    }

    // MARK: -- Delegate SyNC Api

    func failWithError(statusCode: Int) {

        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()

        if statusCode == 0 {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        } else {

            if lngId == 1 {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again. \n(\(statusCode))")

            } else if lngId == 3 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alerte", comment: ""), messageStr: "Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")

            }

          //  Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
        }
    }
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)

        self.printSyncLblCount()

        //Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:" Server error please try again .")

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }

    func didFinishApi() {
        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)
        if (exitPopUP != nil) {
            if exitPopUP.tag == 10 {
                exitPopUP.tag = 11
                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
                self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
            } else {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
                self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)

            }
        } else {
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)

            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
        }
    }
    func failWithInternetConnection() {

        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }

    func printSyncLblCount() {
        //
        syncFinalizedCount.text = String(self.allSessionArr().count)
    }

 }
