
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
import Reachability
import Gigya
import GigyaTfa
import GigyaAuth

class FeedProgramViewController: UIViewController,popUPnavigation,userLogOut,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate , syncApi{
    
    // MARK: - VARIABLES
    var buttonPopUP : UIButton!
    var fetchDosage = NSArray()
    var isClickOnAnyField = Bool()
    let objApiSync = ApiSync()
    var datePicker : UIDatePicker!
    var exitPopUP :popUP!
    var buttonBg1 = UIButton()
    
    var buttoCocodaciVac = UIButton ()
    var flag = 1
    var strYesPop = String()
    var btnTagsave = Int()
    @objc var count:Int = 0
    var index = 10
    var feedArr = NSMutableArray()
    var feedNameArr = NSMutableArray()
    var farmArrayTrue = NSArray ()
    var feedIdFromFarm = Int()
    var backBtnnFrame = UIButton ()
    var mPid = Int()
    var finializeCount = NSNumber()
    var addFarmArrayWithUnCheckForm = NSMutableArray()
    var addFarmArray = NSMutableArray()
    var addFarmArray1 = NSMutableArray()
    var set = NSSet()
    var FarmArray = NSMutableArray()
    var postingIdFromExisting = Int()
    var FeedIdFromExisting = Int()
    var postingIdFromExistingNavigate = String()
    var lngId = NSInteger()
    var postingId = NSNumber()
    var CocoiVacId = NSNumber()
    var feedProgramArray = NSMutableArray()
    var arrTagetMetric = NSMutableArray ()
    var arrTargetImp = NSMutableArray ()
    var navigatePostingsession = String()
    var feedPostingId = Int ()
    var feedImpandMetric = String()
    var mySet = NSOrderedSet()
    var customPopView1 :popUP!
    let buttonbg = UIButton ()
    let buttonbg11 = UIButton ()
    var droperTableView  =  UITableView ()
    var timer = Timer()
    var cocciControlArray = NSArray()
    var AlternativeArray = NSArray()
    var AntiboticArray = NSArray()
    var MyCoxtinBindersArray = NSArray()
    var serviceDataHldArr = NSArray()
    var targetArray = NSArray()
    var cocodiceVacine = NSMutableArray()
    var btnTag = NSInteger()
    var Allbuttonbg = Int()
    var AllDosageTag = Int()
    var cocciControlArrayfromServer = NSMutableArray()
    var AlternativeArrayfromServer = NSMutableArray()
    var AntiboticArrayfromServer = NSMutableArray()
    var MyCoxtinBindersArrayfromServer = NSMutableArray()
    var serviceDataHldArrfromServer = NSMutableArray()
    var feedId = Int()
    var feedProgadd = String()
    var addfeed = String()
    let buttonbg1 = UIButton ()
    var logOutPopView1 :UserListView!
    var datCount = 0
    
    var firstMolID = Int()
    var secoundMolID = Int()
    var thirdMolID = Int()
    var fourthMolID = Int()
    var fifthMolID = Int()
    var sixthMolID = Int()
    // MARK: - OUTLET
    
    @IBOutlet weak var antiFromDurationFirstTextField: UITextField!
    @IBOutlet weak var antiFromDurationSecondTextField: UITextField!
    @IBOutlet weak var antiFromDurationThirdTextField: UITextField!
    @IBOutlet weak var antiFromDurationFourTextField: UITextField!
    
    @IBOutlet weak var antiToDurationFirstTextField: UITextField!
    @IBOutlet weak var antiToDurationSecondTextField: UITextField!
    @IBOutlet weak var antiToDurationThirdTextField: UITextField!
    @IBOutlet weak var antiToDurationFourTextField: UITextField!
    
    @IBOutlet weak var alterNativeView: UIView!
    
    @IBOutlet weak var alternativeStarterOutlet: UIButton!
    @IBOutlet weak var syncFinalizedCount: UILabel!
    @IBOutlet weak var doneBtnOutlet: UIButton!
    @IBOutlet weak var feedProgrmTitle: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var dateBtn: UIButton!
    @IBOutlet weak var farmTableView: UITableView!
    @IBOutlet weak var selectFarmsLabel: UILabel!
    @IBOutlet weak var addFarmSelectLbl: UILabel!
    @IBOutlet weak var addFarmDroper: UIImageView!
    @IBOutlet weak var addFarmBtnOutlet: UIButton!
    @IBOutlet weak var feedType5CocciOutlet: UIButton!
    @IBOutlet weak var feedType6CocciOutlet: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var fivthMoleculelBL: UILabel!
    @IBOutlet weak var sixthMoleculeLbl: UILabel!
    @IBOutlet weak var feed5textField: UILabel!
    @IBOutlet weak var feed6TextField: UILabel!
    @IBOutlet weak var from5TextField: UITextField!
    @IBOutlet weak var from6teXTfield: UITextField!
    @IBOutlet weak var toFeed5TextFeidl: UITextField!
    @IBOutlet weak var toFeed6TextField: UITextField!
    @IBOutlet weak var moleculeFeedType1Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType2Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType3Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType4Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType5Alternativ: UITextField!
    @IBOutlet weak var moleculeFeedType6Alternativ: UITextField!
    @IBOutlet weak var altrNativeDosage5Text: UILabel!
    @IBOutlet weak var altrNativeDosage6Text: UILabel!
    @IBOutlet weak var from5TextAlternative: UITextField!
    @IBOutlet weak var from6TextAlternative: UITextField!
    @IBOutlet weak var to5TextAlternative: UITextField!
    @IBOutlet weak var to6TextAlternative: UITextField!
    @IBOutlet weak var moleculeFeedType1MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType2MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType3MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType4MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType5MyCoxtin: UITextField!
    @IBOutlet weak var moleculeFeedType6MyCoxtin: UITextField!
    @IBOutlet weak var feed5DisplayLblMycoxtin: UILabel!
    @IBOutlet weak var feed6DisplayLblMycoxtin: UILabel!
    @IBOutlet weak var myCoxtin5DosageTextField: UILabel!
    @IBOutlet weak var myCoxtin6DosageTextField: UILabel!
    @IBOutlet weak var from5TextFieldMycoxtin: UITextField!
    @IBOutlet weak var from6TextFieldMycoxtin: UITextField!
    @IBOutlet weak var to5TextFieldMycoxtin: UITextField!
    @IBOutlet weak var to6TextFieldMycoxtin: UITextField!
    
    @IBOutlet weak var antiMoleculeFeedType1: UITextField!
    @IBOutlet weak var antiMoleculeFeedType2: UITextField!
    @IBOutlet weak var antiMoleculeFeedType3: UITextField!
    @IBOutlet weak var antiMoleculeFeedType4: UITextField!
    @IBOutlet weak var antiMoleculeFeedType5: UITextField!
    @IBOutlet weak var antiMoleculeFeedType6: UITextField!
    
    @IBOutlet weak var antiDosageFivthTextField: UILabel!
    @IBOutlet weak var antiDosageSixTextField: UILabel!
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
    
    @IBOutlet weak var myCoxtinStarterDrinking: UILabel!
    @IBOutlet weak var myCoxtinGrowerDrinking: UILabel!
    @IBOutlet weak var myCoxtinFinisherDrinking: UILabel!
    @IBOutlet weak var myCoxtinWDDrinking: UILabel!
    /****************************************************/
    
    @IBOutlet weak var myCoxtinStarterDosage: UILabel!
    @IBOutlet weak var myCoxtinGrowerDosage: UILabel!
    @IBOutlet weak var myCoxtinFinisherDosge: UILabel!
    @IBOutlet weak var myCoxtinWDDosage: UILabel!
    
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
    
    @IBOutlet weak var drop1Icon: UIImageView!
    @IBOutlet weak var drop2Icon: UIImageView!
    @IBOutlet weak var drop3Icon: UIImageView!
    @IBOutlet weak var drop4Icon: UIImageView!
    @IBOutlet weak var drop5Icon: UIImageView!
    @IBOutlet weak var drop6Icon: UIImageView!
    @IBOutlet weak var feedProgramTextField: UITextField!
    @IBOutlet weak var startDatellbl: UILabel!
    @IBOutlet weak var FromstarterDurationTextField: UITextField!
    @IBOutlet weak var FromGrowerTextField: UITextField!
    @IBOutlet weak var fromFinisherTextField: UITextField!
    @IBOutlet weak var fromWDtextField: UITextField!
    
    @IBOutlet weak var toStarterTextField: UITextField!
    @IBOutlet weak var toGrowerTextField: UITextField!
    @IBOutlet weak var toFinisherTextField: UITextField!
    @IBOutlet weak var toWdTextField: UITextField!
    @IBOutlet weak var coccidiosisView: UIView!
    @IBOutlet weak var antiboticView: UIView!
    
    @IBOutlet weak var  myFromFirstTextField: UITextField!
    @IBOutlet weak var  myFromSecondTextField: UITextField!
    @IBOutlet weak var  myFromThirdTextField: UITextField!
    @IBOutlet weak var  myFromFourTextField: UITextField!
    
    @IBOutlet weak var  myToFirstTextField: UITextField!
    @IBOutlet weak var  myToSecondTextField: UITextField!
    @IBOutlet weak var  myToThirdTextField: UITextField!
    @IBOutlet weak var  myToFourTextField: UITextField!
    @IBOutlet weak var alternativeDosageFirstText: UILabel!
    @IBOutlet weak var alternativeDosageSecoondText: UILabel!
    @IBOutlet weak var alternativeDosageThirdText: UILabel!
    @IBOutlet weak var alternativeDosageFourText: UILabel!
    @IBOutlet weak var alternativeFromFirstTextField: UITextField!
    @IBOutlet weak var alternativeFromSecondTextField: UITextField!
    @IBOutlet weak var alternativeFromthirdTextField: UITextField!
    @IBOutlet weak var alternativeFromFourTextField: UITextField!
    @IBOutlet weak var alternativeToFirstTextField: UITextField!
    @IBOutlet weak var alternativeToSecondTextField: UITextField!
    @IBOutlet weak var alternativeTothirdTextField: UITextField!
    @IBOutlet weak var alternativeToFourTextField: UITextField!
    @IBOutlet weak var myCotoxinBindersView: UIView!
    
    @IBOutlet weak var myStarterCheckBox: UIButton!
    @IBOutlet weak var myGrowerCheckBox: UIButton!
    @IBOutlet weak var myFinisherCheckBox: UIButton!
    @IBOutlet weak var myWdCheckBox: UIButton!
    
    ///  Coccidios Dossgae text field
    @IBOutlet weak var cocciDosFirstTextField: UITextField!
    @IBOutlet weak var cocciDosSecTextField: UITextField!
    @IBOutlet weak var cocciDosThrdTextField: UITextField!
    @IBOutlet weak var cocciDosFourTextField: UITextField!
    
    @IBOutlet weak var cocciDosFiveTextField: UITextField!
    @IBOutlet weak var cocciDosSixTextField: UITextField!
    
    @IBOutlet weak var antiboticDosageFeed1Outlet: UIButton!
    @IBOutlet weak var antiboticDosageFeed2Outlet: UIButton!
    @IBOutlet weak var antiboticDosageFeed3Outlet: UIButton!
    @IBOutlet weak var antiboticDosageFeed4Outlet: UIButton!
    @IBOutlet weak var antiboticDosageFeed5Outlet: UIButton!
    @IBOutlet weak var antiboticDosageFeed6Outlet: UIButton!
    @IBOutlet weak var antiDosageFirstTextField: UILabel!
    @IBOutlet weak var antiDosageSecondTextField: UILabel!
    @IBOutlet weak var antiDosageThirdTextField: UILabel!
    @IBOutlet weak var antiDosageFourTextField: UILabel!
    
    /////Mycoxtin Binders
    
    @IBOutlet weak var coxtinDosageFeed1Outlet: UIButton!
    @IBOutlet weak var coxtinDosageFeed2Outlet: UIButton!
    @IBOutlet weak var coxtinDosageFeed3Outlet: UIButton!
    @IBOutlet weak var coxtinDosageFeed4Outlet: UIButton!
    @IBOutlet weak var coxtinDosageFeed5Outlet: UIButton!
    @IBOutlet weak var coxtinDosageFeed6Outlet: UIButton!
    
    //// aLTERNATIVE DOSAGE TEXT
    
    @IBOutlet weak var alternativeDosageFeed1Outlet: UIButton!
    @IBOutlet weak var alternativeDosageFeed2Outlet: UIButton!
    @IBOutlet weak var alternativeDosageFeed3Outlet: UIButton!
    @IBOutlet weak var alternativeDosageFeed4Outlet: UIButton!
    @IBOutlet weak var alternativeDosageFeed5Outlet: UIButton!
    @IBOutlet weak var alternativeDosageFeed6Outlet: UIButton!
    
    
    @IBOutlet weak var cocciDosageFeed1Outlet: UIButton!
    @IBOutlet weak var cocciDosageFeed2Outlet: UIButton!
    @IBOutlet weak var cocciDosageFeed3Outlet: UIButton!
    @IBOutlet weak var cocciDosageFeed4Outlet: UIButton!
    @IBOutlet weak var cocciDosageFeed5Outlet: UIButton!
    @IBOutlet weak var cocciDosageFeed6Outlet: UIButton!
    
    @IBOutlet weak var starterDosageTextField: UILabel!
    @IBOutlet weak var growerDosageCoccidiosisTEXT: UILabel!
    @IBOutlet weak var finisherDosageTxtField: UILabel!
    @IBOutlet weak var wdDosageTextField: UILabel!
    @IBOutlet weak var antiboticStarterCheckBoxOutlet: UIButton!
    @IBOutlet weak var antiboticGrowerCheckBoxOutlet: UIButton!
    @IBOutlet weak var antiboticWDcheckBoxOutlet: UIButton!
    @IBOutlet weak var alternativeGrowerOutlet: UIButton!
    @IBOutlet weak var antiboticFinisherCheckBoxoutlet: UIButton!
    @IBOutlet weak var alternativeFinsiherOutlet: UIButton!
    @IBOutlet weak var alternativeWdOutlet: UIButton!
    @IBOutlet weak var alternativeStarterMoleculeOutlet: UIButton!
    @IBOutlet weak var alternativeGrowerMoleculeOutlet: UIButton!
    @IBOutlet weak var alternativeFinisherMoleculeOutlet: UIButton!
    @IBOutlet weak var alternativeWDMoleculeOutlet: UIButton!
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        
        if addfeed == "addfeed" {
            feedId = UserDefaults.standard.integer(forKey:"feedId")
            feedId = feedId + 1
            UserDefaults.standard.set(feedId , forKey: "feedId")
            feedProgadd = "ExtingFeeed"
        }
        
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.black.cgColor
        
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
        cocciDosFirstTextField.tag = 23
        cocciDosSecTextField.tag = 22
        cocciDosThrdTextField.tag = 24
        cocciDosFourTextField.tag = 25
        cocciDosFiveTextField.tag = 112
        cocciDosSixTextField.tag = 113
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
        
        feedProgramTextField.delegate = self
        alternativeToFourTextField.delegate = self
        alternativeTothirdTextField.delegate = self
        alternativeToFirstTextField.delegate = self
        alternativeToSecondTextField.delegate = self
        alternativeFromFirstTextField.delegate = self
        alternativeFromthirdTextField.delegate = self
        alternativeFromFourTextField.delegate = self
        FromstarterDurationTextField.delegate = self
        FromGrowerTextField.delegate = self
        fromFinisherTextField.delegate = self
        fromWDtextField.delegate = self
        toStarterTextField.delegate = self
        toGrowerTextField.delegate = self
        toFinisherTextField.delegate = self
        toWdTextField.delegate = self
        myFromFirstTextField.delegate = self
        myFromSecondTextField.delegate = self
        myFromThirdTextField.delegate = self
        myFromFourTextField.delegate = self
        myToFirstTextField.delegate = self
        myToSecondTextField.delegate = self
        myToThirdTextField.delegate = self
        myFromFourTextField.delegate = self
        myToFourTextField.delegate = self
        antiFromDurationFourTextField.delegate = self
        antiFromDurationFirstTextField.delegate = self
        antiFromDurationThirdTextField.delegate = self
        antiFromDurationSecondTextField.delegate = self
        antiToDurationFourTextField.delegate = self
        antiToDurationFirstTextField.delegate = self
        antiToDurationThirdTextField.delegate = self
        antiToDurationSecondTextField.delegate = self
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
        from5TextField.delegate = self
        from6teXTfield.delegate = self
        toFeed5TextFeidl.delegate = self
        toFeed6TextField.delegate = self
        from5TextAlternative.delegate = self
        from6TextAlternative.delegate = self
        to5TextAlternative.delegate = self
        to6TextAlternative.delegate = self
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
        moleculeFeedType1MyCoxtin.delegate = self
        moleculeFeedType2MyCoxtin.delegate = self
        moleculeFeedType3MyCoxtin.delegate = self
        moleculeFeedType4MyCoxtin.delegate = self
        moleculeFeedType5MyCoxtin.delegate = self
        moleculeFeedType6MyCoxtin.delegate = self
        to6TextFieldMycoxtin.delegate = self
        from6TextFieldMycoxtin.delegate = self
        moleculeFeedType6MyCoxtin.delegate = self
        
        if postingIdFromExistingNavigate == "Exting"{
            postingId = postingIdFromExisting as NSNumber
        }
        else if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            postingId =  UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        }
        else{
            postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
        }
        
        btnTag = 0
        coccidiosisControlOutlet.layer.cornerRadius = 7
        myCotoxiinOutlet.layer.cornerRadius = 7
        alternativeControlOutlet.layer.cornerRadius = 7
        antiboticControlOutlet.layer.cornerRadius = 7
        
        styleButton(addFarmBtnOutlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coccidiosisStarterDrinkingWater, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coccidiosisGrowerDrinkingWater, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(finsiherDrinkingOutlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciWDDrinkingWater, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(feedType5CocciOutlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(feedType6CocciOutlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed1Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed2Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed3Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed4Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed5Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(cocciDosageFeed6Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed1Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed2Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed3Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed4Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed5Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coxtinDosageFeed6Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(coccidiosisVaccineOutlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed1Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed2Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed3Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed4Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed5Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(antiboticDosageFeed6Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed1Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed2Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed3Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed4Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed5Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        styleButton(alternativeDosageFeed6Outlet, cornerRadius: 3.5, borderColor: .black, borderWidth: 1.0)
        
        coccidiosisView.isHidden = false
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true
        
        serviceDataHldArr = (UserDefaults.standard.value(forKey: "Molucule") as? NSArray)!
        
        self.callSaveMethod(commonAray: serviceDataHldArr,tag: btnTag)
        
        cocodiceVacine =  CoreDataHandler().fetchCociVacLngId(lngId: lngId as NSNumber).mutableCopy() as! NSMutableArray
        print(cocodiceVacine)
        targetArray =  (UserDefaults.standard.value(forKey:"target") as? NSArray)!
        
        
        if lngId == 3 {
            
            feedProgrmTitle.text = "Programme alimentaire"
            startDatellbl.text = "Date de début"
            lblDate.text =  "Sélectionner une date"
            
            if myCoxtinStarterDosage.text == "- Select -" {
                myCoxtinStarterDosage.text = "- Sélectionner -"
            }
            if myCoxtinGrowerDosage.text == "- Select -" {
                myCoxtinGrowerDosage.text = "- Sélectionner -"
            }
            if myCoxtinFinisherDosge.text == "- Select -" {
                myCoxtinFinisherDosge.text = "- Sélectionner -"
            }
            if myCoxtinWDDosage.text == "- Select -" {
                myCoxtinWDDosage.text = "- Sélectionner -"
            }
            if myCoxtin5DosageTextField.text == "- Select -" {
                myCoxtin5DosageTextField.text = "- Sélectionner -"
            }
            if myCoxtin6DosageTextField.text == "- Select -" {
                myCoxtin6DosageTextField.text = "- Sélectionner -"
            }
            if antiDosageFirstTextField.text == "- Select -" {
                antiDosageFirstTextField.text = "- Sélectionner -"
            }
            if antiDosageSecondTextField.text == "- Select -" {
                antiDosageSecondTextField.text = "- Sélectionner -"
            }
            if antiDosageThirdTextField.text == "- Select -" {
                antiDosageThirdTextField.text = "- Sélectionner -"
            }
            if antiDosageFourTextField.text == "- Select -" {
                antiDosageFourTextField.text = "- Sélectionner -"
            }
            if antiDosageFivthTextField.text == "- Select -" {
                antiDosageFivthTextField.text = "- Sélectionner -"
            }
            if antiDosageSixTextField.text == "- Select -" {
                antiDosageSixTextField.text = "- Sélectionner -"
            }
            if alternativeDosageFirstText.text == "- Select -" {
                alternativeDosageFirstText.text = "- Sélectionner -"
            }
            if alternativeDosageSecoondText.text == "- Select -" {
                alternativeDosageSecoondText.text = "- Sélectionner -"
            }
            if alternativeDosageThirdText.text == "- Select -" {
                alternativeDosageThirdText.text = "- Sélectionner -"
            }
            if alternativeDosageFourText.text == "- Select -" {
                alternativeDosageFourText.text = "- Sélectionner -"
            }
            if altrNativeDosage5Text.text == "- Select -" {
                altrNativeDosage5Text.text = "- Sélectionner -"
            }
            if altrNativeDosage6Text.text == "- Select -" {
                altrNativeDosage6Text.text = "- Sélectionner -"
            }
            if lngId == 1{
                if starterDosageTextField.text == "- Select -" {
                    starterDosageTextField.text = "- Sélectionner -"
                }
                if growerDosageCoccidiosisTEXT.text == "- Select -" {
                    growerDosageCoccidiosisTEXT.text = "- Sélectionner -"
                }
                if finisherDosageTxtField.text == "- Select -" {
                    finisherDosageTxtField.text = "- Sélectionner -"
                }
                if wdDosageTextField.text == "- Select -" {
                    wdDosageTextField.text = "- Sélectionner -"
                }
                if feed5textField.text == "- Select -" {
                    feed5textField.text = "- Sélectionner -"
                }
                if feed6TextField.text == "- Select -" {
                    feed6TextField.text = "- Sélectionner -"
                }
            }
        }
        
        if lngId == 4 {
            cocciDosFirstTextField.placeholder = " Digitar"
            cocciDosSecTextField.placeholder   = " Digitar"
            cocciDosThrdTextField.placeholder  = " Digitar"
            cocciDosFourTextField.placeholder  = " Digitar"
            cocciDosFiveTextField.placeholder  = " Digitar"
            cocciDosSixTextField.placeholder   = " Digitar"
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        spacingInTxtField()
        self.printSyncLblCount()
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        
        
        if lngId == 4{
            self.hideTextField(hide: false)
            self.hideDropButtons(hide: true)
        }else{
            self.hideTextField(hide: true)
            self.hideDropButtons(hide: false)
        }
        
        feedProgramTextField.isUserInteractionEnabled = true
        coccidiosisView.isUserInteractionEnabled = true
        alterNativeView.isUserInteractionEnabled = true
        antiboticView.isUserInteractionEnabled = true
        myCotoxinBindersView.isUserInteractionEnabled = true
        doneBtnOutlet.isHidden = false
        
        userNameLabel.text! = UserDefaults.standard.value(forKey:"FirstName") as! String
        arrTargetImp.removeAllObjects()
        arrTagetMetric.removeAllObjects()
        for i in 0..<targetArray.count{
            let scaleType = (targetArray.value(forKey:"ScaleType") as AnyObject).object(at:i) as! String
            
            if "Metric" == scaleType {
                
                arrTagetMetric.add((targetArray.value(forKey:"TargetWeightProcessingName") as AnyObject).object(at:i) as! String)
                
            }
            else if("Imperial" == scaleType){
                arrTargetImp.add((targetArray.value(forKey:"TargetWeightProcessingName") as AnyObject).object(at:i) as! String)
            }
            
        }
        
        if navigatePostingsession == "PostingFeedProgram"{
            cocciControlArray = CoreDataHandler().fetchAllCocciControl(feedPostingId as NSNumber)
            AntiboticArray = CoreDataHandler().fetchAntibotic(feedPostingId as NSNumber)
            AlternativeArray = CoreDataHandler().fetchAlternative(feedPostingId as NSNumber)
            MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(feedPostingId as NSNumber)
        }
        
        else if postingIdFromExistingNavigate == "Exting"{
            if addfeed == "addfeed" {
                feedProgadd = "ExtingFeeed"
            }
            else{
                
                cocciControlArray = CoreDataHandler().fetchAllCocciControl(self.FeedIdFromExisting as NSNumber)
                AntiboticArray = CoreDataHandler().fetchAntibotic(self.FeedIdFromExisting as NSNumber)
                AlternativeArray = CoreDataHandler().fetchAlternative(self.FeedIdFromExisting as NSNumber)
                MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(self.FeedIdFromExisting as NSNumber)
            }
            
        }
        else{
            
            feedId =   UserDefaults.standard.integer(forKey: "feedId")
            cocciControlArray = CoreDataHandler().fetchAllCocciControl(feedId as NSNumber)
            AntiboticArray = CoreDataHandler().fetchAntibotic(feedId as NSNumber)
            AlternativeArray = CoreDataHandler().fetchAlternative(feedId as NSNumber)
            MyCoxtinBindersArray = CoreDataHandler().fetchMyBinders(feedId as NSNumber)
            
        }
        
        if cocciControlArray.count > 0 {
            
            for  i in 0..<cocciControlArray.count {
                
                let str = (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:0) as? String
                if ((str?.count)! > 0)
                {
                    coccidsisStartrDrinking.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:0) as? String
                    firstMolID =  (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:0) as? Int ?? 0
                    
                }
                else
                {
                    coccidsisStartrDrinking.text = NSLocalizedString("- Select -", comment: "")
                }
                var str1 = String()
                if cocciControlArray.count == 1{
                    str1 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String)!
                }
                else{
                    
                    str1 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:1) as? String)!
                }
                if (str1.count) > 0
                {
                    coccidsisGrowerDrinking.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:1) as? String
                    secoundMolID = (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:1) as? Int ?? 0
                }
                else
                {
                    coccidsisGrowerDrinking.text = NSLocalizedString("- Select -", comment: "")
                    
                }
                var str2 = String()
                if cocciControlArray.count == 1{
                    str2 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String)!
                }
                else{
                    
                    str2 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:2) as? String)!
                }
                
                if (str2.count) > 0
                {
                    
                    cocciFinisherDrinkingWater.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:2) as? String
                    thirdMolID = (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:2) as? Int ?? 0
                }
                else
                {
                    cocciFinisherDrinkingWater.text = NSLocalizedString("- Select -", comment: "")
                    
                }
                var str3 = String()
                if cocciControlArray.count == 1{
                    str3 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String)!
                }
                else{
                    
                    str3 = ((cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:3) as? String)!
                }
                
                if (str3.count) > 0
                {
                    
                    coccidiosisWdDrinking.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:3) as? String
                    fourthMolID = (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:3) as? Int ?? 0
                }
                else
                {
                    coccidiosisWdDrinking.text = NSLocalizedString("- Select -", comment: "")
                    
                }
                var str4 = String()
                if cocciControlArray.count == 1{
                    str4 = (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:i) as! String
                }
                else{
                    
                    str4 = (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:4) as! String
                }
                
                if (str4.count) > 0
                {
                    fivthMoleculelBL.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:4) as? String
                    fifthMolID = (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:4) as? Int ?? 0
                }
                else
                {
                    fivthMoleculelBL.text = NSLocalizedString("- Select -", comment: "")
                    
                }
                var str5 = String()
                if cocciControlArray.count == 1{
                    str5 = (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:i) as! String
                }
                else{
                    
                    str5 = (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:5) as! String
                }
                
                if (str5.count) > 0
                {
                    sixthMoleculeLbl.text =  (cocciControlArray.value(forKey:"molecule") as AnyObject).object(at:5) as? String
                    sixthMolID = (cocciControlArray.value(forKey:"dosemoleculeId") as AnyObject).object(at:5) as? Int ?? 0
                }
                else
                {
                    sixthMoleculeLbl.text = NSLocalizedString("- Select -", comment: "")
                }
                
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        starterDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosFirstTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        starterDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                }
                else{
                    if lngId == 1{
                        starterDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                    }else if lngId == 4{
                        cocciDosFirstTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                    }else{
                        starterDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosSecTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                }
                else{
                    if lngId == 1{
                        growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                    }else if lngId == 4{
                        cocciDosSecTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                    }else{
                        growerDosageCoccidiosisTEXT.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        finisherDosageTxtField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosThrdTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        finisherDosageTxtField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                    
                }
                else{
                    if lngId == 1{
                        finisherDosageTxtField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                    }else if lngId == 4{
                        cocciDosThrdTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                    }else{
                        finisherDosageTxtField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        wdDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosFourTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        wdDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                    
                }
                else{
                    if lngId == 1{
                        wdDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                    }else if lngId == 4{
                        cocciDosFourTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                    }else{
                        wdDosageTextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        feed5textField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosFiveTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        feed5textField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                    
                }
                else{
                    if lngId == 1{
                        feed5textField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                    }else if lngId == 4{
                        cocciDosFiveTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                    }else{
                        feed5textField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    if lngId == 1{
                        feed6TextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else if lngId == 4{
                        cocciDosSecTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }else{
                        cocciDosSixTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                    }
                    
                }
                else{
                    if lngId == 1{
                        feed6TextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                    }else if lngId == 4{
                        cocciDosSixTextField.text = (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                    }else{
                        feed6TextField.text =  (cocciControlArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                    }
                    
                }
                if cocciControlArray.count == 1{
                    FromstarterDurationTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    FromstarterDurationTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                if cocciControlArray.count == 1{
                    FromGrowerTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    FromGrowerTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:1) as? String
                }
                if cocciControlArray.count == 1{
                    fromFinisherTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    fromFinisherTextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:2) as? String
                }
                if cocciControlArray.count == 1{
                    fromWDtextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    fromWDtextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:3) as? String
                }
                if cocciControlArray.count == 1{
                    from5TextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    from5TextField.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:4) as? String
                }
                if cocciControlArray.count == 1{
                    from6teXTfield.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    from6teXTfield.text =  (cocciControlArray.value(forKey:"fromDays") as AnyObject).object(at:5) as? String
                }
                if cocciControlArray.count == 1{
                    toStarterTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toStarterTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:0) as? String
                }
                if cocciControlArray.count == 1{
                    toGrowerTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toGrowerTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:1) as? String
                }
                if cocciControlArray.count == 1{
                    toFinisherTextField.text = (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toFinisherTextField.text = (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:2) as? String
                }
                if cocciControlArray.count == 1{
                    toWdTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toWdTextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:3) as? String
                }
                if cocciControlArray.count == 1{
                    toFeed5TextFeidl.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toFeed5TextFeidl.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:4) as? String
                }
                if cocciControlArray.count == 1{
                    toFeed6TextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    toFeed6TextField.text =  (cocciControlArray.value(forKey:"toDays") as AnyObject).object(at:5) as? String
                }
                if cocciControlArray.count == 1{
                    coccidiosisVaccineDrinkin.text =  (cocciControlArray.value(forKey:"coccidiosisVaccine") as AnyObject).object(at:i) as? String
                }
                else{
                    coccidiosisVaccineDrinkin.text =  (cocciControlArray.value(forKey:"coccidiosisVaccine") as AnyObject).object(at:0) as? String
                }
                if cocciControlArray.count == 1{
                    feedProgramTextField.text =
                    (cocciControlArray.value(forKey:"feedProgram") as AnyObject).object(at:i) as? String
                }
                else{
                    feedProgramTextField.text =
                    (cocciControlArray.value(forKey:"feedProgram") as AnyObject).object(at:0) as? String
                }
                if cocciControlArray.count == 1{
                    lblDate.text =
                    (cocciControlArray.value(forKey:"feedDate") as AnyObject).object(at:i) as? String
                }
                else{
                    lblDate.text =
                    (cocciControlArray.value(forKey:"feedDate") as AnyObject).object(at:0) as? String
                }
                
            }
            
        }
        
        
        if AntiboticArray.count > 0 {
            
            
            
            
            for i in 0..<AntiboticArray.count{
                
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType1.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType1.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:0) as? String
                }
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType2.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType2.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:1) as? String
                }
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType3.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType3.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:2) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType4.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType4.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:3) as? String
                }
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType5.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType5.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:4) as? String
                }
                if AntiboticArray.count == 1{
                    antiMoleculeFeedType6.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    antiMoleculeFeedType6.text =  (AntiboticArray.value(forKey:"molecule") as AnyObject).object(at:5) as? String
                }
                
                
                if AntiboticArray.count == 1{
                    antiDosageFirstTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageFirstTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiDosageSecondTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageSecondTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                }
                if AntiboticArray.count == 1{
                    antiDosageThirdTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageThirdTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                }
                
                
                if AntiboticArray.count == 1{
                    antiDosageFourTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageFourTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                }
                if AntiboticArray.count == 1{
                    antiDosageFivthTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageFivthTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiDosageSixTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    antiDosageSixTextField.text =  (AntiboticArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                }
                if AntiboticArray.count == 1{
                    antiFromDurationFirstTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiFromDurationFirstTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiFromDurationSecondTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiFromDurationSecondTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:1) as? String
                }
                if AntiboticArray.count == 1{
                    antiFromDurationThirdTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiFromDurationThirdTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:2) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiFromDurationFourTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject
                    ).object(at:i) as? String
                }
                else{
                    antiFromDurationFourTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject
                    ).object(at:3) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiFromFivthTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiFromFivthTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:4) as? String
                }
                if AntiboticArray.count == 1{
                    antiFromSixthTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiFromSixthTextField.text =  (AntiboticArray.value(forKey:"fromDays") as AnyObject).object(at:5) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiToDurationFirstTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiToDurationFirstTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:0) as? String
                }
                if AntiboticArray.count == 1{
                    antiToDurationSecondTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:0) as? String
                }
                else{
                    antiToDurationSecondTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:1) as? String
                }
                if AntiboticArray.count == 1{
                    antiToDurationThirdTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiToDurationThirdTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:2) as? String
                }
                if AntiboticArray.count == 1{
                    antiToDurationFourTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiToDurationFourTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:3) as? String
                }
                if AntiboticArray.count == 1{
                    antiToDurationfivthTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiToDurationfivthTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:4) as? String
                }
                
                if AntiboticArray.count == 1{
                    antiToDurationSixTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    antiToDurationSixTextField.text =  (AntiboticArray.value(forKey:"toDays") as AnyObject).object(at:5) as? String
                }
                
                if AntiboticArray.count == 1{
                    feedProgramTextField.text = (AntiboticArray.value(forKey:"feedProgram") as AnyObject).object(at:i) as? String
                }
                else{
                    feedProgramTextField.text = (AntiboticArray.value(forKey:"feedProgram") as AnyObject).object(at:0) as? String
                }
                
            }
            
        }
        
        if AlternativeArray.count > 0 {
            
            for i in 0..<AlternativeArray.count{
                
                if AlternativeArray.count == 1{
                    moleculeFeedType1Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType1Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:0) as? String
                }
                if AlternativeArray.count == 1{
                    moleculeFeedType2Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType2Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:1) as? String
                }
                
                if AlternativeArray.count == 1{
                    moleculeFeedType3Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType3Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:2) as? String
                }
                if AlternativeArray.count == 1{
                    moleculeFeedType4Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType4Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:3) as? String
                }
                if AlternativeArray.count == 1{
                    moleculeFeedType5Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType5Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:4) as? String
                }
                
                if AlternativeArray.count == 1{
                    moleculeFeedType6Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType6Alternativ.text =  (AlternativeArray.value(forKey:"molecule") as AnyObject).object(at:5) as? String
                }
                
                
                if AlternativeArray.count == 1{
                    alternativeDosageFirstText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeDosageFirstText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeDosageSecoondText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeDosageSecoondText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeDosageThirdText.text = (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeDosageThirdText.text = (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeDosageFourText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeDosageFourText.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                }
                
                if AlternativeArray.count == 1{
                    altrNativeDosage5Text.text = (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    altrNativeDosage5Text.text = (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                }
                if AlternativeArray.count == 1{
                    altrNativeDosage6Text.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    altrNativeDosage6Text.text =  (AlternativeArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                }
                
                
                if AlternativeArray.count == 1{
                    alternativeFromFirstTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeFromFirstTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeFromSecondTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeFromSecondTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:1) as? String
                }
                
                if AlternativeArray.count == 1{
                    alternativeFromthirdTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeFromthirdTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:2) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeFromFourTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeFromFourTextField.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:3) as? String
                }
                if AlternativeArray.count == 1{
                    from5TextAlternative.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    from5TextAlternative.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:4) as? String
                }
                
                if AlternativeArray.count == 1{
                    from6TextAlternative.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    from6TextAlternative.text =  (AlternativeArray.value(forKey:"fromDays") as AnyObject).object(at:5) as? String
                }
                
                if AlternativeArray.count == 1{
                    alternativeToFirstTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeToFirstTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:0) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeToSecondTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeToSecondTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:1) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeTothirdTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeTothirdTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:2) as? String
                }
                if AlternativeArray.count == 1{
                    alternativeToFourTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    alternativeToFourTextField.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:3) as? String
                }
                
                if AlternativeArray.count == 1{
                    to5TextAlternative.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    to5TextAlternative.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:4) as? String
                }
                
                if AlternativeArray.count == 1{
                    to6TextAlternative.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    to6TextAlternative.text =  (AlternativeArray.value(forKey:"toDays") as AnyObject).object(at:5) as? String
                }
                
                
                if AlternativeArray.count == 1{
                    feedProgramTextField.text = (AlternativeArray.value(forKey:"feedProgram") as AnyObject).object(at:i) as? String
                }
                else{
                    feedProgramTextField.text = (AlternativeArray.value(forKey:"feedProgram") as AnyObject).object(at:0) as? String
                }
                
            }
            
        }
        
        /*********************  MyBlinder  ****************************/
        
        if MyCoxtinBindersArray.count > 0 {
            
            for i in 0..<MyCoxtinBindersArray.count{
                
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType1MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType1MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:0) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType2MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType2MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:1) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType3MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType3MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:2) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType4MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType4MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:3) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType5MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType5MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:4) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    moleculeFeedType6MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:i) as? String
                }
                else{
                    moleculeFeedType6MyCoxtin.text =  (MyCoxtinBindersArray.value(forKey:"molecule") as AnyObject).object(at:5) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myCoxtinStarterDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    myCoxtinStarterDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myCoxtinGrowerDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    myCoxtinGrowerDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:1) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myCoxtinFinisherDosge.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    myCoxtinFinisherDosge.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:2) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myCoxtinWDDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    myCoxtinWDDosage.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:3) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myCoxtin5DosageTextField.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:0) as? String
                }
                else{
                    myCoxtin5DosageTextField.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:4) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myCoxtin6DosageTextField.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:i) as? String
                }
                else{
                    myCoxtin6DosageTextField.text =  (MyCoxtinBindersArray.value(forKey:"dosage") as AnyObject).object(at:5) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myFromFirstTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myFromFirstTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myFromSecondTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myFromSecondTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:1) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myFromThirdTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myFromThirdTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:2) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myFromFourTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myFromFourTextField.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:3) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    from5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                else{
                    from5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:4) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    from6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:0) as? String
                }
                else{
                    from6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"fromDays") as AnyObject).object(at:5) as? String
                }
                
                
                
                if MyCoxtinBindersArray.count == 1{
                    myToFirstTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myToFirstTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:0) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myToSecondTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myToSecondTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:1) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    myToThirdTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myToThirdTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:2) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    myToFourTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    myToFourTextField.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:3) as? String
                }
                if MyCoxtinBindersArray.count == 1{
                    to5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    to5TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:4) as? String
                }
                
                if MyCoxtinBindersArray.count == 1{
                    to6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:i) as? String
                }
                else{
                    to6TextFieldMycoxtin.text =  (MyCoxtinBindersArray.value(forKey:"toDays") as AnyObject).object(at:5) as? String
                }
                
                
                if MyCoxtinBindersArray.count == 1{
                    feedProgramTextField.text = (MyCoxtinBindersArray.value(forKey:"feedProgram") as AnyObject).object(at:i) as? String
                }
                else{
                    feedProgramTextField.text = (MyCoxtinBindersArray.value(forKey:"feedProgram") as AnyObject).object(at:0) as? String
                }
            }
            
        }
        
        if (UserDefaults.standard.bool(forKey:"Unlinked") == true){
            
            addFarmBtnOutlet.isHidden = false
            addFarmSelectLbl.isHidden = false
            addFarmDroper.isHidden = false
            selectFarmsLabel.isHidden = false
            
            if (feedProgramTextField.text == "")
            {
                
            }
            else
            {
                let necId =  UserDefaults.standard.integer(forKey:("necUnLinked"))
                
                if (navigatePostingsession == "PostingFeedProgram"){
                    
                    feedNameArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedPostingId as NSNumber).mutableCopy()as! NSMutableArray
                }
                else
                {
                    feedNameArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedId as NSNumber).mutableCopy() as! NSMutableArray
                }
                
                if (feedNameArr.count > 0)
                {
                    let ftitle = NSMutableString()
                    
                    for i in 0..<feedNameArr.count
                    {
                        let farms = feedNameArr.object(at:i) as! CaptureNecropsyData
                        let strfarmName = farms.farmName! as String
                        // addFarmSelectLbl.text = strfarmName
                        var label:UILabel
                        if (i == 0){
                            label = UILabel()
                            label.frame = CGRect(x: 50, y: 519, width: 111, height: 21)
                            ftitle.append( strfarmName + " " )
                            
                        }
                        
                        else{
                            
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
            
        }
        else{
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
    
    // MARK: - Set Corner Radius , color & Border Width of button's
    func styleButton(_ button: UIButton, cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth
    }
    
    
    // MARK: - METHODS AND FUNCTIONS
    func hideTextField(hide: Bool){
        cocciDosFirstTextField.isHidden = hide
        cocciDosSecTextField.isHidden = hide
        cocciDosThrdTextField.isHidden = hide
        cocciDosFourTextField.isHidden = hide
        cocciDosFiveTextField.isHidden = hide
        cocciDosSixTextField.isHidden = hide
        
        cocciDosFirstTextField.isUserInteractionEnabled = !hide
        cocciDosSecTextField.isUserInteractionEnabled = !hide
        cocciDosThrdTextField.isUserInteractionEnabled = !hide
        cocciDosFourTextField.isUserInteractionEnabled = !hide
        cocciDosFiveTextField.isUserInteractionEnabled = !hide
        cocciDosSixTextField.isUserInteractionEnabled = !hide
    }
    
    func hideDropButtons(hide: Bool){
        cocciDosageFeed1Outlet.isHidden = hide
        cocciDosageFeed2Outlet.isHidden = hide
        cocciDosageFeed3Outlet.isHidden = hide
        cocciDosageFeed4Outlet.isHidden = hide
        cocciDosageFeed5Outlet.isHidden = hide
        cocciDosageFeed6Outlet.isHidden = hide
        
        cocciDosageFeed1Outlet.isUserInteractionEnabled = !hide
        cocciDosageFeed2Outlet.isUserInteractionEnabled = !hide
        cocciDosageFeed3Outlet.isUserInteractionEnabled = !hide
        cocciDosageFeed4Outlet.isUserInteractionEnabled = !hide
        cocciDosageFeed5Outlet.isUserInteractionEnabled = !hide
        cocciDosageFeed6Outlet.isUserInteractionEnabled = !hide
        
        starterDosageTextField.isHidden = hide
        growerDosageCoccidiosisTEXT.isHidden = hide
        finisherDosageTxtField.isHidden = hide
        wdDosageTextField.isHidden = hide
        feed5textField.isHidden = hide
        feed6TextField.isHidden = hide
        
        drop1Icon.isHidden = hide
        drop2Icon.isHidden = hide
        drop3Icon.isHidden = hide
        drop4Icon.isHidden = hide
        drop5Icon.isHidden = hide
        drop6Icon.isHidden = hide
    }
    
    
    @IBAction func dateAction(sender: AnyObject) {
        view.endEditing(true)
        // btnDate.layer.borderColor = UIColor.black.cgColor
        let buttons  = CommonClass.sharedInstance.pickUpDateFeed()
        buttonBg1  = buttons.0
        buttonBg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonBg1.addTarget(self, action: #selector(FeedProgramViewController.buttonPressed), for: .touchUpInside)
        let donebutton : UIBarButtonItem = buttons.1
        
        donebutton.action =  #selector(FeedProgramViewController.doneClick)
        
        let cancelbutton : UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(FeedProgramViewController.cancelClick)
        
        datePicker = buttons.4
        self.view.addSubview(buttonBg1)
    }
    @objc func doneClick() {
        
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 3{
            let dateFormatter2 = DateFormatter()
            //            dateFormatter2.calendar = Calendar(identifier: .gregorian)
            //            dateFormatter2.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter2.dateFormat="dd/MM/yyyy"
            lblDate.text = dateFormatter2.string(from: datePicker.date) as String
        }
        else{
            let dateFormatter2 = DateFormatter()
            //            dateFormatter2.calendar = Calendar(identifier: .gregorian)
            //            dateFormatter2.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter2.dateFormat="MM/dd/yyyy"
            lblDate.text = dateFormatter2.string(from: datePicker.date) as String
        }
        buttonBg1.removeFromSuperview()
    }
    @objc func cancelClick() {
        buttonBg1.removeFromSuperview()
    }
    
    @objc func buttonPressed() {
        buttonBg1.removeFromSuperview()
    }
    @IBAction func backBtnAction(sender: AnyObject) {
        btnTagsave = 2
        callSaveMethod(btnTagSave: btnTagsave)
    }
    
    @IBAction func cancelBtnAct(sender: AnyObject) {
        
        self.navigationController?.popViewController(animated:true)
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
                } else{
                    bt.isSelected = false
                }
            }
        }
        
        coccidiosisView.isHidden = false
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true
        
        serviceDataHldArr = (UserDefaults.standard.value(forKey:"Molucule") as? NSArray)!
        //        ////print(serviceDataHldArr)
        
        if (cocciControlArrayfromServer.count == 0){
            self.callSaveMethod(commonAray: serviceDataHldArr,tag: btnTag)
        }
        
    }
    
    /***************************** Save Data in to DataBase ************************************************/
    
    func callSaveMethod( commonAray : NSArray , tag : Int) {
        CoreDataHandler().deleteAllData("MoleCuleFeed")
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let dict = commonAray[tag] as AnyObject
        
        let arrayMoleculeDetails = dict["MoleculeDetails"] as AnyObject
        
        
        for i in 0 ..< arrayMoleculeDetails.count {
            
            let dictDat = NSMutableDictionary()
            let tempDict = arrayMoleculeDetails.object(at:i) as AnyObject
            print(tempDict)
            let mid = tempDict["MoleculeId"] as? Int
            let lngId =   tempDict["LanguageId"] as? Int
            let catId =  tempDict["FeedProgramCategoryId"] as? Int
            let desc =  tempDict["MoleculeDescription"] as? String
            CoreDataHandler().saveMoleCule(catId!, decscMolecule: desc!, moleculeId: mid!, lngId: lngId!)
            
        }
        
        if (tag == 0 ){
            
            cocciControlArrayfromServer =  CoreDataHandler().fetchMoleCuleLngId(lngId:lngId as NSNumber).mutableCopy() as! NSMutableArray
            print(cocciControlArrayfromServer)
        }
        else if (tag == 1){
            AlternativeArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId:lngId as NSNumber).mutableCopy() as! NSMutableArray
        }
        else if (tag == 2){
            AntiboticArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId:lngId as NSNumber).mutableCopy() as! NSMutableArray
        }
        else if (tag == 3){
            MyCoxtinBindersArrayfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId:lngId as NSNumber).mutableCopy() as! NSMutableArray
        }
        else{
            serviceDataHldArrfromServer = CoreDataHandler().fetchMoleCuleLngId(lngId:lngId as NSNumber).mutableCopy() as! NSMutableArray
        }
    }
    /******* Create Custom TableView ************************************/
    func tableViewpop()  {
        
        buttonbg.frame = CGRect(x: 0,y: 0,width: 1024,height: 768)
        buttonbg.isUserInteractionEnabled = true
        buttonbg.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)
        
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg.addSubview(droperTableView)
    }
    
    @objc func dismissPopUp() {
        buttonbg.removeFromSuperview()
    }
    
    func buttonPressed1() {
        buttonbg.removeFromSuperview()
    }
    // MARK:  IBACTION
    @IBAction func myCoxtinBtnAction(sender: AnyObject) {
        
        flag = 4
        self.view.endEditing(true)
        btnTag = 3
        
        for btn in self.view.subviews {
            if btn.isKind(of: UIButton.self) {
                let bt = btn as! UIButton
                if bt.titleLabel?.text == NSLocalizedString("Mycotoxin Binders", comment: "") {
                    bt.isSelected = true
                } else{
                    bt.isSelected = false
                }
            }
        }
        coccidiosisView.isHidden = true
        antiboticView.isHidden = true
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = false
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
                } else{
                    bt.isSelected = false
                }
            }
        }
        
        coccidiosisView.isHidden = true
        antiboticView.isHidden = true
        alterNativeView.isHidden = false
        myCotoxinBindersView.isHidden = true
        
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
                } else{
                    bt.isSelected = false
                }
            }
        }
        
        coccidiosisView.isHidden = true
        antiboticView.isHidden = false
        alterNativeView.isHidden = true
        myCotoxinBindersView.isHidden = true
        
    }
    
    @IBAction func starterCheckBoxAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func growerCheckBoxAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func finisherCoccidiosisCheckBoxAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func wdCoccidiosisAction(sender: AnyObject) {print("Test message")}
    
    
    @IBAction func starterDrinkngWaterAction(sender: AnyObject) {
        
        view.endEditing(true)
        btnTag = 0
        
        Allbuttonbg = 0
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            starterDosageTextField.text = "- Select -"
        }
        
        
        droperTableView.frame = CGRect(x: 183,y: 309,width: 237,height: 150)
        droperTableView.reloadData()
    }
    
    @IBAction func growerDrinkingWater(sender: AnyObject) {
        view.endEditing(true)
        btnTag = 0
        Allbuttonbg = 1
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            growerDosageCoccidiosisTEXT.text = "- Select -"
        }
        
        droperTableView.frame = CGRect(x: 183,y: 365,width: 237,height: 150)
        droperTableView.reloadData()
        
    }
    
    @IBAction func finisherDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        btnTag = 0
        
        Allbuttonbg = 2
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            finisherDosageTxtField.text = "- Select -"
        }
        
        droperTableView.frame = CGRect(x: 183,y: 422,width: 237,height: 150)
        droperTableView.reloadData()
    }
    
    @IBAction func wdDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        btnTag = 0
        
        Allbuttonbg = 3
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            wdDosageTextField.text =  "- Select -"
        }
        
        droperTableView.frame = CGRect(x: 183,y: 477,width: 237,height: 150)
        droperTableView.reloadData()
        
    }
    
    @IBAction func feedType5CoccidiosisA(sender: AnyObject) {
        btnTag = 0
        
        view.endEditing(true)
        Allbuttonbg = 40
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            feed5textField.text = "- Select -"
        }
        
        droperTableView.frame = CGRect(x: 183,y: 530,width: 237,height: 150)
        droperTableView.reloadData()
        
    }
    
    
    @IBAction func feedType6CoccidiosisA(sender: AnyObject) {
        view.endEditing(true)
        btnTag = 0
        
        Allbuttonbg = 50
        buttonbg.removeFromSuperview()
        tableViewpop()
        if  Bundle.main.versionNumber > "7.5.1"
        {
            feed6TextField.text = "- Select -"
        }
        
        droperTableView.frame = CGRect(x: 183,y: 580,width: 237,height: 150)
        droperTableView.reloadData()
    }
    
    
    @IBAction func coccidiosisVaccineAction(sender: AnyObject) {
        view.endEditing(true)
        btnTag = 4
        btnCocoTagetPopp()
        
        droperTableView.frame = CGRect(x: 450,y: 455,width: 245,height: 150)
        droperTableView.reloadData()
    }
    
    
    // MARK: - IBACTIONS
    @IBAction func targetWeightDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        
        btnTag = 5
        btnCocoTagetPopp()
        droperTableView.frame = CGRect(x: 420,y: 410,width: 245,height: 150)
        droperTableView.reloadData()
    }
    
    @IBAction func uperTapView(sender: AnyObject) {
        
        coccidiosisView.endEditing(true)
        antiboticView.endEditing(true)
        alterNativeView.endEditing(true)
        myCotoxinBindersView.endEditing(true)
        uprTapViewOutlet.endEditing(true)
        
        
    }
    
    
    @IBAction func antiboticStarterCheckBoxAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func antiboticGrowerAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func antiboticFinisherAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func antiboticWDAction(sender: AnyObject) {print("Test message")}
    
    
    @IBAction func antiFinisherDrinkingWater(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 6
        buttonbg.removeFromSuperview()
        tableViewpop()
        
        droperTableView.frame = CGRect(x: 220,y: 432,width: 245,height: 150)
        
        droperTableView.reloadData()
        
    }
    
    
    @IBAction func antiWdDrinkingWater(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 7
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 492,width: 245,height: 150)
        
        droperTableView.reloadData()
    }
    
    @IBAction func alternativeStartrAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func altrnativeGrowerAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func alternativeFinisherAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func alternativeWdAction(sender: AnyObject) {print("Test message")}
    
    @IBAction func alternativeStarterMoleculeAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 8
        buttonbg.removeFromSuperview()
        tableViewpop()
        
        droperTableView.frame = CGRect(x: 220,y: 318,width: 245,height: 150)
        droperTableView.reloadData()
    }
    
    
    @IBAction func alternativeGrowerMoleculeAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 9
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 375,width: 245,height: 150)
        
        droperTableView.reloadData()
    }
    
    
    @IBAction func alternativeFinisherMoleculeAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 10
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 432,width: 245,height: 150)
        
        droperTableView.reloadData()
        
    }
    
    @IBAction func alternativeWDMoleculeAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 11
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 492,width: 245,height: 150)
        
        droperTableView.reloadData()
    }
    
    @IBAction func myStarterDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 12
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 318,width: 245,height: 150)
        
        droperTableView.reloadData()
    }
    
    @IBAction func myGrowerDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 13
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 375,width: 245,height: 150)
        
        droperTableView.reloadData()
    }
    
    @IBAction func myFinisherDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 14
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 432,width: 245,height: 150)
        droperTableView.reloadData()
    }
    @IBAction func myWDDrinkingWaterAction(sender: AnyObject) {
        view.endEditing(true)
        
        Allbuttonbg = 15
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 220,y: 492,width: 245,height: 150)
        
        droperTableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func tapOnView(sender: AnyObject) {
        coccidiosisView.endEditing(true)
    }
    @IBAction func tapOnViewAntobotic(sender: AnyObject) {
        antiboticView.endEditing(true)
    }
    @IBAction func tapOnViewAlternative(sender: AnyObject) {
        alterNativeView.endEditing(true)
    }
    @IBAction func tapOnViewMyCotoxin(sender: AnyObject) {
        myCotoxinBindersView.endEditing(true)
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        
        btnTagsave = 1
        isClickOnAnyField = true
        callSaveMethod(btnTagSave: btnTagsave)
        
        
        let allCocciControl = CoreDataHandler().fetchAllCocciControlviaPostingid(postingId as NSNumber)
        
        let outerDict = NSMutableDictionary()
        
        let FinalArray = NSMutableArray()
        
        for i in 0..<allCocciControl.count
                
        {
            
            let mainDict = NSMutableDictionary()
            
            let cocciControl = allCocciControl.object(at:i) as! CoccidiosisControlFeed
            
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
        
        
        for i in 0..<fetchAntibotic.count
                
        {
            
            let mainDict = NSMutableDictionary()
            
            let antiboticFeed = fetchAntibotic.object(at:i) as! AntiboticFeed
            
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
        
        for i in 0..<fetchAlternative.count
                
        {
            
            let mainDict = NSMutableDictionary()
            
            let antiboticFeed = fetchAlternative.object(at:i) as! AlternativeFeed
            
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
        
        for i in 0..<fetchMyBinde.count
                
        {
            
            let mainDict = NSMutableDictionary()
            
            let antiboticFeed = fetchMyBinde.object(at:i) as! MyCotoxinBindersFeed
            
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
        
        let udid = UserDefaults.standard.value(forKey:"ApplicationIdentifier")!
        let sessionGUID1 = "iOS" + (udid as! String) +  "_" + String(describing: postingId)
        outerDict.setValue(sessionGUID1, forKey: "deviceSessionId")
        
        let id = UserDefaults.standard.integer(forKey:("Id"))
        
        outerDict.setValue(id, forKey: "UserId")
        
        outerDict.setValue(false, forKey: "finalized")
        
        outerDict.setValue(FinalArray, forKey: "feedProgramDetail")
        
        
        do {
            
            var error : NSError?
            
            let jsonData = try! JSONSerialization.data(withJSONObject: outerDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            
            
            jsonString =  jsonString.trimmingCharacters(in: (NSCharacterSet.whitespaces))
            
        } catch let error as NSError {
            
        }
        
    }
    
    
    @IBAction func toStarterTextField(sender: AnyObject) {
        
        if antiFromDurationFirstTextField.text! < antiToDurationFirstTextField.text! {
            
        }
        else if antiFromDurationFirstTextField.text! > antiToDurationFirstTextField.text! {
            
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
            print("test message")
        }
    }
    @IBAction func toAntiboticThreeTextField(sender: AnyObject) {
        
        if antiFromDurationThirdTextField.text! < antiToDurationThirdTextField.text! {
            print("test message")
        } else if antiFromDurationThirdTextField.text! > antiToDurationThirdTextField.text! {
            print("test message")
        }
        
    }
    @IBAction func toAntiboticFourTextField(sender: AnyObject) {
        
        if antiFromDurationFourTextField.text! < antiToDurationFourTextField.text! {
            
        } else if antiFromDurationFourTextField.text! > antiToDurationFourTextField.text! {
            
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
            
        }
        
    }
    
    @IBAction func syncBttnAction(sender: AnyObject) {
        let feedProgramArray = CoreDataHandler().FetchFeedProgram(postingId as NSNumber)
        let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(postingId as NSNumber)
        if feedProgramArray.count < 1  {
            // Create the alert controller
            if feedProgramTextField.text == ""{
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: NSLocalizedString("Please enter feed program.", comment: ""))
                return
            }
            
            else if farms.count > 0 {
                self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 10)
                
                return
            }
            else{
                self.showExitAlertWith(msg: "Do you want to add more information to this page?", tag: 10)
                return
                
            }
            
        }
        else if farms.count > 0{
            self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 10)
        }
        else{
            if self.allSessionArr().count > 0
            {
                if ConnectionManager.shared.hasConnectivity() {
                    
                    btnTagsave = 2
                    callSaveMethod(btnTagSave: btnTagsave)
                    
                    Helper.showGlobalProgressHUDWithTitle(self.view,title : NSLocalizedString("Data syncing...", comment: ""))
                    self.callSyncApi()
                }
                else {
                    
                    Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
                }
            } else{
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data not available for syncing.", comment: ""))
            }
            
        }
    }
    
    
    @IBAction func cocciDosageFeed1(_ sender: Any) {
 
        if  Bundle.main.versionNumber > "7.5.1"
        {
            if coccidsisStartrDrinking.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(firstMolID as NSNumber)
            
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        
        
        view.endEditing(true)
        btnTag = 101
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 309,width: 230,height: 150)
        droperTableView.reloadData()
 
    }
    
    @IBAction func cocciDosageFeed2(_ sender: Any) {
        
        
        
        if  Bundle.main.versionNumber > "7.5.1"
        {
            
            if coccidsisGrowerDrinking.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(secoundMolID as NSNumber)
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        view.endEditing(true)
        btnTag = 102
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 365,width: 230,height: 150)
        droperTableView.reloadData()
  }
    
    @IBAction func cocciDosageFeed3(_ sender: Any) {
        
        if  Bundle.main.versionNumber > "7.5.1"
        {
            if cocciFinisherDrinkingWater.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(thirdMolID as NSNumber)
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        view.endEditing(true)
        btnTag = 103
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 421,width: 230,height: 150)
        droperTableView.reloadData()
        
        
        
    }
    
    @IBAction func cocciDosageFeed4(_ sender: Any) {
        
        
        if  Bundle.main.versionNumber > "7.5.1"
        {
            if coccidiosisWdDrinking.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(fourthMolID as NSNumber)
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        view.endEditing(true)
        btnTag = 104
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 477,width: 230,height: 150)
        droperTableView.reloadData()
        
        
    }
    
    @IBAction func cocciDosageFeed5(_ sender: Any) {
        
        
        if  Bundle.main.versionNumber > "7.5.1"
        {
            if fivthMoleculelBL.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(fifthMolID as NSNumber)
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        
        view.endEditing(true)
        btnTag = 105
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 533,width: 230,height: 150)
        droperTableView.reloadData()
        
        
    }
    
    @IBAction func cocciDosageFeed6(_ sender: Any) {
        
        if  Bundle.main.versionNumber > "7.5.1"
        {
            if sixthMoleculeLbl.text == "- Select -"
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select the molecule feed.", comment: ""))
                return
            }
            fetchDosage = CoreDataHandler().fetchDossgaeWithMoleculeId(sixthMolID as NSNumber)
            if fetchDosage.count == 0
            {
                fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
            }
            
        }
        else
        {
            fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        }
        
        view.endEditing(true)
        btnTag = 106
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 589,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    
    @IBAction func alternativeDosageFeed1(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 111
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 320,width: 230,height: 150)
        droperTableView.reloadData()
        
        
    }
    @IBAction func alternativeDosageFeed2(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 112
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 376,width: 230,height: 150)
        droperTableView.reloadData()
        
        
    }
    @IBAction func alternativeDosageFeed3(_ sender: Any) {
        view.endEditing(true)
        btnTag = 113
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 432,width: 230,height: 150)
        droperTableView.reloadData()
        
        
    }
    @IBAction func alternativeDosageFeed4(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 114
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 489,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func alternativeDosageFeed5(_ sender: Any) {
        view.endEditing(true)
        btnTag = 115
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 544,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func alternativeDosageFeed6(_ sender: Any) {
        view.endEditing(true)
        btnTag = 116
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 600,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    
    @IBAction func coxtinDosageFeed1(_ sender: Any) {
        view.endEditing(true)
        btnTag = 121
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 320,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func coxtinDosageFeed2(_ sender: Any) {
        view.endEditing(true)
        btnTag = 122
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 376,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func coxtineDosageFeed3(_ sender: Any) {
        view.endEditing(true)
        btnTag = 123
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 432,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func coxtinDosageFeed4(_ sender: Any) {
        view.endEditing(true)
        btnTag = 124
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 489,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func coxtinDosageFeed5(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 125
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 544,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func coxtinDosageFeed6(_ sender: Any) {
        view.endEditing(true)
        btnTag = 126
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 445,y: 600,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    
    @IBAction func antiboticDosageFeed1(_ sender: Any) {
        view.endEditing(true)
        btnTag = 131
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 320,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func antiboticDosageFeed2(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 132
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 376,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func antiboticDosageFeed3(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        
        btnTag = 133
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 438,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func antiboticDosageFeed4(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 134
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 498,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func antiboticDosageFeed5(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 135
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 559,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    @IBAction func antiboticDosageFeed6(_ sender: Any) {
        view.endEditing(true)
        fetchDosage = CoreDataHandler().fetchDataDatabaseWithEntity(entityName: "GetDosage")
        
        btnTag = 136
        buttonbg.removeFromSuperview()
        tableViewpop()
        droperTableView.frame = CGRect(x: 443,y: 610,width: 230,height: 150)
        droperTableView.reloadData()
        
    }
    
    // MARK: - METHODS AND FUNCTIONS
    
    func showExitAlertWith(msg: String,tag: Int) {
        
        exitPopUP = popUP.loadFromNibNamed("popUP") as? popUP
        exitPopUP.lblFedPrgram.text = msg
        exitPopUP.tag = tag
        exitPopUP.lblFedPrgram.textAlignment = .center
        exitPopUP.delegatenEW = self
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)
        
    }
    func callSyncApi()
    {
        objApiSync.feedprogram()
    }
    
    func failWithError(statusCode:Int)
    {
        
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        
        if statusCode == 0 {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        }
        else{
            
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
                
            } else if lngId == 3 {
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alerte", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
                
            }
        }
    }
    func failWithErrorInternal(){
        
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }
    
    func didFinishApi() {
        
        self.printSyncLblCount()
        
        Helper.dismissGlobalHUD(self.view)
        if (exitPopUP != nil){
            if exitPopUP.tag == 10{
                exitPopUP.tag = 11
                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
                self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data sync has been completed.", comment: ""))
            }
            else{
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data sync has been completed.", comment: ""))
                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
                self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
                
            }
        }
        else{
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data sync has been completed.", comment: ""))
        }
    }
    func failWithInternetConnection()
    {
        
        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }
    
    func printSyncLblCount()
    {
        syncFinalizedCount.text = String(self.allSessionArr().count)
    }
    func btnCocoTagetPopp(){
        
        buttoCocodaciVac.frame = CGRect(x: 0,y: 0,width: 1024,height: 768)
        buttoCocodaciVac.addTarget(self, action: #selector(FeedProgramViewController.buttonCocotarget), for: .touchUpInside)
        buttoCocodaciVac.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttoCocodaciVac)
        
        droperTableView.delegate = self
        droperTableView.dataSource = self
        
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttoCocodaciVac.addSubview(droperTableView)
    }
    
    @objc func buttonCocotarget(){
        btnTag = 0
        buttoCocodaciVac.removeFromSuperview()
    }
    func callSaveMethod (btnTagSave : Int) {
        var feed = Int ()
        var trimmedString = feedProgramTextField.text!.trimmingCharacters(in: .whitespaces)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
                                                            NSString.CompareOptions.literal, range: nil)
        feedProgramTextField.text = trimmedString
        if (trimmedString == "" ){
            if (btnTagSave == 2){
                let feeid  = UserDefaults.standard.integer(forKey:("feedId"))
                
                if (feeid == 0 ){
                    UserDefaults.standard.set("feed0", forKey: "feed0")
                    UserDefaults.standard.synchronize()
                    feed = 0
                }
                else{
                    if (strYesPop == NSLocalizedString("Yes", comment: "")){
                        
                        feed = feeid
                    }
                    else{
                        if (navigatePostingsession == "PostingFeedProgram"){
                            feed = feeid
                        }
                        else
                        {
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
                
                self.navigationController?.popViewController(animated:true)
                UserDefaults.standard.set(0, forKey: "isBackWithoutFedd")
                UserDefaults.standard.synchronize()
            }
            else{
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please enter feed program.", comment: ""))
            }
        }
        else{
            
            if (btnTagSave == 2){
                
                bckButtonCall()
                
            }
            if (isClickOnAnyField == true)
            {
                isClickOnAnyField = false
                
                if (navigatePostingsession == "PostingFeedProgram"){
                    self.saveFeedProgrameInDatabase(feedId: feedPostingId,postingId: Int(postingId as NSNumber) ,completion: { (status) -> Void in
                        
                        if status == true {
                            
                            self.saveCoccoiControlDatabase(feedId: self.feedPostingId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                
                                if status == true {
                                    
                                    self.saveAntibioticDatabase(feedId: self.feedPostingId,postingId: Int(self.postingId),  completion: { (status) -> Void in
                                        
                                        if status == true {
                                            
                                            self.saveAlternativeDatabase(feedId: self.feedPostingId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                
                                                if status == true {
                                                    
                                                    self.saveMyCoxtinDatabase(feedId: self.feedPostingId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                        
                                                        if status == true {
                                                            
                                                        }})
                                                }})
                                        }})
                                }})
                        }})
                }
                
                
                else if postingIdFromExistingNavigate == "Exting"{
                   
                    var feedexist = Int()
                    if feedProgadd == "ExtingFeeed" {
                        feedexist = feedId
                    }
                    else{
                        feedexist = self.FeedIdFromExisting
                    }
                    
                    self.saveFeedProgrameInDatabase(feedId: feedexist ,postingId: Int(self.postingId), completion: { (status) -> Void in
                        
                        if status == true {
                            
                            self.saveCoccoiControlDatabase(feedId: feedexist,postingId: Int(self.postingId), completion: { (status) -> Void in
                                
                                if status == true {
                                    
                                    
                                    self.saveAntibioticDatabase(feedId: feedexist ,postingId: Int(self.postingId), completion: { (status) -> Void in
                                        
                                        if status == true {
                                            
                                            self.saveAlternativeDatabase(feedId: feedexist ,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                
                                                if status == true {
                                                    
                                                    self.saveMyCoxtinDatabase(feedId:feedexist ,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                        
                                                        if status == true {
                                                            
                                                            
                                                            if self.postingIdFromExistingNavigate == "Exting"{
                                                                CoreDataHandler().updateisSyncTrueOnPostingSession(self.postingId)
                                                            }
                                                            
                                                        }})
                                                }})
                                        }})
                                }})
                        }})
                    
                }
                
                else{
                    
                    if UserDefaults.standard.bool(forKey:"Unlinked") == true
                    {
                        postingId = UserDefaults.standard.integer(forKey:"necUnLinked") as NSNumber
                        
                    }
                    else
                    {
                        postingId = UserDefaults.standard.integer(forKey: "postingId") as NSNumber
                    }
                    
                    self.saveFeedProgrameInDatabase(feedId: feedId,postingId: Int(self.postingId), completion: { (status) -> Void in
                        
                        if status == true {
                            
                            self.saveCoccoiControlDatabase(feedId: self.feedId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                
                                if status == true {
                                    
                                    self.saveAntibioticDatabase(feedId: self.feedId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                        
                                        if status == true {
                                            
                                            self.saveAlternativeDatabase(feedId: self.feedId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                
                                                if status == true {
                                                    
                                                    self.saveMyCoxtinDatabase(feedId: self.feedId,postingId: Int(self.postingId), completion: { (status) -> Void in
                                                        
                                                        if status == true {
                                                            
                                                            UserDefaults.standard.set(false, forKey: "isNewPostingId")
                                                            UserDefaults.standard.synchronize()
                                                            
                                                        }})
                                                }})
                                        }})
                                }})
                        }})
                }
                
            }
            
            
            if btnTagsave == 1 {
                
                if postingIdFromExistingNavigate == "Exting"{
                    self.clickHelpPopUp()
                    //self.navigationController?.popViewController(animated:true)
                }
                else{
                    
                    self.clickHelpPopUp()
                }
                
            }
            else{
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.isFeedProgramClick = true
                appDelegate.sendFeedVariable = "Feed"
                appDelegate.strImpFedd = feedImpandMetric
                appDelegate.newColor = datCount + 1
                if (exitPopUP != nil){
                    if self.exitPopUP.tag == 10{
                        if self.allSessionArr().count > 0
                        {
                            if ConnectionManager.shared.hasConnectivity() {
                                
                                
                                Helper.showGlobalProgressHUDWithTitle(self.view,title : NSLocalizedString("Data syncing...", comment: ""))
                                self.callSyncApi()
                            }
                            else {
                                
                                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
                            }
                        } else{
                            
                            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data not available for syncing.", comment: ""))
                        }
                        
                    }
                    else if self.exitPopUP.tag == 20{
                        self.clickHelp()
                    }
                    else{
                        self.navigationController?.popViewController(animated:true)}
                }
                else{
                    self.navigationController?.popViewController(animated:true)}
                
            }
            UserDefaults.standard.set("notback", forKey: "back")
            UserDefaults.standard.set(1, forKey: "isBackWithoutFedd")
            UserDefaults.standard.synchronize()
        }
        
        
    }
    
    func saveFeedProgrameInDatabase(feedId : Int,postingId :Int, completion: (_ status: Bool) -> Void) {
        
        var tempArr = CoreDataHandler().FetchFeedProgramAll()
        
        feedProgramArray = tempArr.mutableCopy() as! NSMutableArray
        
        if feedProgramArray.count == 0 {
            
            
            CoreDataHandler().SaveFeedProgram(postingId as NSNumber, sessionId: 1, feedProgrameName:  feedProgramTextField.text!, feedId: feedId as NSNumber, dbArray: feedProgramArray, index: 0,formName: addFarmSelectLbl.text! ,isSync: true,lngId:lngId as NSNumber)
            
            CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
        }
        else {
            
            if navigatePostingsession == "PostingFeedProgram"{
                
                CoreDataHandler().updateFeedProgram(feedId as NSNumber, isSync: true, feedProgrameName: feedProgramTextField.text!, formName: addFarmSelectLbl.text!)
                
                
                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
            }
            
            else if postingIdFromExistingNavigate == "Exting"{
                if   feedProgadd == "ExtingFeeed"{
                    
                    feedProgramArray.removeAllObjects()
                    
                    CoreDataHandler().SaveFeedProgram(postingId as NSNumber, sessionId: 1, feedProgrameName:  feedProgramTextField.text!, feedId: feedId as NSNumber, dbArray: feedProgramArray, index: feedId,formName: addFarmSelectLbl.text!,isSync :true,lngId:lngId as NSNumber)
                    
                    
                    CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
                }
                else{
                    CoreDataHandler().updateFeedProgram(feedId as NSNumber, isSync: true, feedProgrameName: feedProgramTextField.text!, formName: addFarmSelectLbl.text!)
                    CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
                    CoreDataHandler().updateFeddProgramInStep1(postingId as NSNumber, feedname: feedProgramTextField.text!, feedId: feedId as NSNumber)
                    CoreDataHandler().updateisSyncOnAllCocciControlviaFeedProgram(postingId as NSNumber , feedId : feedId as NSNumber,feedProgram:feedProgramTextField.text!)
                    CoreDataHandler().updateisSyncOnMyCotxinViaFeedProgram(postingId: postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                    CoreDataHandler().updateisSyncOnAlterNativeViaFeedProgram(postingId: postingId as NSNumber, feedId:  feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                    CoreDataHandler().updateisSyncOnAntiboticViaFeedProgram(postingId: postingId as NSNumber, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!)
                }
            }
            
            else{
                
                feedProgramArray.removeAllObjects()
                
                CoreDataHandler().SaveFeedProgram(postingId as NSNumber, sessionId: 1, feedProgrameName:  feedProgramTextField.text!, feedId: feedId as NSNumber, dbArray: feedProgramArray, index: feedId,formName: addFarmSelectLbl.text!,isSync :true,lngId:lngId as NSNumber)
                
                
                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
            }
            
        }
        
        
        completion (true)
    }
    
    func saveCoccoiControlDatabase (feedId : Int,postingId : Int, completion: (_ status: Bool) -> Void) {
        
        for i in 0..<7 {
            
            if i == 0 {
                
                if coccidsisStartrDrinking.text == NSLocalizedString("- Select -", comment: ""){
                    
                    coccidsisStartrDrinking.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidsisStartrDrinking.text ?? "", dosage:cocciDosFirstTextField.text ?? "", fromDays: FromstarterDurationTextField.text ?? "", toDays:toStarterTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text!,formName: addFarmSelectLbl.text!,isSync :true,feedType: "Feed type 1",cocoVacId: CocoiVacId,lngId:lngId as NSNumber, lbldate: lblDate.text ?? "", dosemoleculeId: firstMolID )
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidsisStartrDrinking.text ?? "", dosage:starterDosageTextField.text ?? "", fromDays: FromstarterDurationTextField.text ?? "", toDays:toStarterTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text!,formName: addFarmSelectLbl.text!,isSync :true,feedType: "Feed type 1",cocoVacId: CocoiVacId,lngId:lngId as NSNumber, lbldate: lblDate.text ?? "", dosemoleculeId: firstMolID )
                }
                
            }
            else if i == 1 {
                
                if coccidsisGrowerDrinking.text == NSLocalizedString("- Select -", comment: ""){
                    
                    coccidsisGrowerDrinking.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidsisGrowerDrinking.text ?? "", dosage:cocciDosSecTextField.text ?? "", fromDays: FromGrowerTextField.text ?? "", toDays:toGrowerTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 2",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: secoundMolID)
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidsisGrowerDrinking.text ?? "", dosage:growerDosageCoccidiosisTEXT.text ?? "", fromDays: FromGrowerTextField.text ?? "", toDays:toGrowerTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 2",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: secoundMolID)
                }
                
            }
            
            else if i == 2 {
                if cocciFinisherDrinkingWater.text == NSLocalizedString("- Select -", comment: ""){
                    
                    cocciFinisherDrinkingWater.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber , molecule  :cocciFinisherDrinkingWater.text ?? "", dosage:cocciDosThrdTextField.text ?? "", fromDays: fromFinisherTextField.text ?? "", toDays:toFinisherTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 3" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: thirdMolID)
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber , molecule  :cocciFinisherDrinkingWater.text ?? "", dosage:finisherDosageTxtField.text ?? "", fromDays: fromFinisherTextField.text ?? "", toDays:toFinisherTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 3" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: thirdMolID)
                }
                
            }
            
            else if i == 3{
                if coccidiosisWdDrinking.text == NSLocalizedString("- Select -", comment: ""){
                    
                    coccidiosisWdDrinking.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidiosisWdDrinking.text ?? "", dosage:cocciDosFourTextField.text ?? "", fromDays: fromWDtextField.text ?? "", toDays:toWdTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 4",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: fourthMolID)
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :coccidiosisWdDrinking.text ?? "", dosage:wdDosageTextField.text ?? "", fromDays: fromWDtextField.text ?? "", toDays:toWdTextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 4",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: fourthMolID)
                }
                
            }
            
            else if i == 4 {
                
                if fivthMoleculelBL.text == NSLocalizedString("- Select -", comment: ""){
                    
                    fivthMoleculelBL.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :fivthMoleculelBL.text ?? "", dosage:cocciDosFiveTextField.text ?? "", fromDays: from5TextField.text ?? "", toDays:toFeed5TextFeidl.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 5",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: fifthMolID)
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :fivthMoleculelBL.text ?? "", dosage:feed5textField.text ?? "", fromDays: from5TextField.text ?? "", toDays:toFeed5TextFeidl.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 5",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: fifthMolID)
                }
                
            }
            
            else if i == 5{
                
                if sixthMoleculeLbl.text == NSLocalizedString("- Select -", comment: ""){
                    
                    sixthMoleculeLbl.text = ""
                    
                }
                if lngId == 4{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :sixthMoleculeLbl.text ?? "", dosage:cocciDosSixTextField.text ?? "", fromDays: from6teXTfield.text ?? "", toDays:toFeed6TextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 6",cocoVacId: CocoiVacId ,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: sixthMolID)
                }else{
                    CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :sixthMoleculeLbl.text ?? "", dosage:feed6TextField.text ?? "", fromDays: from6teXTfield.text ?? "", toDays:toFeed6TextField.text ?? "", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "Feed type 6",cocoVacId: CocoiVacId ,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: sixthMolID )
                }
                
            }
            
            else if i == 6{
                
                CoreDataHandler().saveCoccoiControlDatabase(1, postingId:postingId as NSNumber, molecule  :"", dosage:"", fromDays: "", toDays:"", coccidiosisVaccine:coccidiosisVaccineDrinkin.text ?? "", targetWeight:"", index: i, dbArray: cocciControlArray, feedId: feedId as NSNumber,feedProgram:feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync :true,feedType: "",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lbldate: lblDate.text ?? "", dosemoleculeId: sixthMolID)
            }
            
        }
        
        
        completion (true)
    }
    
    func saveAntibioticDatabase ( feedId : Int, postingId :Int, completion: (_ status: Bool) -> Void) {
        
        for i in 0..<6{
            
            if i == 0 {
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType1.text ?? "", dosage:antiDosageFirstTextField.text ?? "", fromDays: antiFromDurationFirstTextField.text ?? "", toDays: antiToDurationFirstTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 1",cocoVacId: CocoiVacId, lngId: lngId as NSNumber, lblDate: lblDate.text ?? "" )
            }
            else if i == 1 {
                
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType2.text ?? "", dosage:antiDosageSecondTextField.text ?? "", fromDays: antiFromDurationSecondTextField.text ?? "", toDays: antiToDurationSecondTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 2",cocoVacId: CocoiVacId,lngId: lngId as NSNumber, lblDate: lblDate.text ?? "" )
                
            }
            
            else if i == 2 {
                
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType3.text ?? "", dosage:antiDosageThirdTextField.text ?? "", fromDays: antiFromDurationThirdTextField.text ?? "", toDays: antiToDurationThirdTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 3",cocoVacId: CocoiVacId,lngId: lngId as NSNumber, lblDate: lblDate.text ?? "" )
                
            }
            else if i == 3 {
                
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType4.text ?? "", dosage:antiDosageFourTextField.text ?? "", fromDays: antiFromDurationFourTextField.text ?? "", toDays: antiToDurationFourTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 4",cocoVacId: CocoiVacId,lngId: lngId as NSNumber, lblDate: lblDate.text ?? "")
            }
            
            else if i == 4 {
                
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType5.text ?? "", dosage:antiDosageFivthTextField
                    .text ?? "", fromDays: antiFromFivthTextField.text ?? "", toDays: antiToDurationfivthTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 5",cocoVacId: CocoiVacId ,lngId: lngId as NSNumber, lblDate: lblDate.text ?? "")
                
            }
            else if i == 5 {
                
                CoreDataHandler().saveAntiboticDatabase(1, postingId: postingId as NSNumber, molecule: antiMoleculeFeedType6.text ?? "", dosage:antiDosageSixTextField.text ?? "", fromDays: antiFromSixthTextField.text ?? "", toDays: antiToDurationSixTextField.text ?? "", index: i, dbArray: AntiboticArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 6" ,cocoVacId: CocoiVacId,lngId: lngId as NSNumber, lblDate: lblDate.text ?? "")
            }
            
        }
        completion (true)
    }
    
    func saveAlternativeDatabase ( feedId : Int,postingId: Int, completion: (_ status: Bool) -> Void) {
        
        for i in 0..<6{
            
            if i == 0 {
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType1Alternativ.text ?? "", dosage: alternativeDosageFirstText.text ?? "", fromDays: alternativeFromFirstTextField.text ?? "", toDays: alternativeToFirstTextField.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 1",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "" )
                
            }
            else if i == 1 {
                
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType2Alternativ.text ?? "", dosage: alternativeDosageSecoondText.text ?? "", fromDays: alternativeFromSecondTextField.text ?? "", toDays: alternativeToSecondTextField.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 2",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "" )
                
            }
            
            else if i == 2 {
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType3Alternativ.text ?? "", dosage: alternativeDosageThirdText.text ?? "", fromDays: alternativeFromthirdTextField.text ?? "", toDays: alternativeTothirdTextField.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 3",cocoVacId: CocoiVacId ,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
                
            }
            else if i == 3 {
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType4Alternativ.text ?? "", dosage: alternativeDosageFourText.text ?? "", fromDays: alternativeFromFourTextField.text ?? "", toDays: alternativeToFourTextField.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 4",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "" )
            }
            else if i == 4 {
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType5Alternativ.text ?? "", dosage: altrNativeDosage5Text.text ?? "", fromDays: from5TextAlternative.text ?? "", toDays: to5TextAlternative.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 5",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
                
            }
            else if i == 5 {
                
                CoreDataHandler().saveAlternativeDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType6Alternativ.text ?? "", dosage: altrNativeDosage6Text.text ?? "", fromDays: from6TextAlternative.text ?? "", toDays: to6TextAlternative.text ?? "", index: i, dbArray: AlternativeArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 6" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
            }
            
        }
        
        
        completion (true)
    }
    
    func saveMyCoxtinDatabase ( feedId : Int,postingId:Int, completion: (_ status: Bool) -> Void) {
        
        for i in 0..<6{
            
            if i == 0 {
                
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule:moleculeFeedType1MyCoxtin.text ?? ""  , dosage: myCoxtinStarterDosage.text ?? "", fromDays: myFromFirstTextField.text ?? "", toDays:myToFirstTextField.text ?? "", index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram:feedProgramTextField.text ?? "" ,formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 1",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "" )
                
            }
            else if i == 1 {
                
                
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType2MyCoxtin.text ?? "", dosage: myCoxtinGrowerDosage.text ?? "", fromDays: myFromSecondTextField.text ?? "", toDays: myToSecondTextField.text ?? "", index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 2" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
                
            }
            
            else if i == 2 {
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType3MyCoxtin.text ?? "", dosage: myCoxtinFinisherDosge.text ?? "", fromDays: myFromThirdTextField.text!, toDays: myToThirdTextField.text!, index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text!,formName: addFarmSelectLbl.text!,isSync : true,feedType: "Feed type 3",cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "" )
                
            }
            else if i == 3 {
                
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType4MyCoxtin.text ?? "", dosage: myCoxtinWDDosage.text ?? "", fromDays: myFromFourTextField.text ?? "", toDays: myToFourTextField.text ?? "", index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 4" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
            }
            else if i == 4 {
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType5MyCoxtin.text ?? "", dosage: myCoxtin5DosageTextField.text ?? "", fromDays: from5TextFieldMycoxtin.text ?? "", toDays: to5TextFieldMycoxtin.text ?? "", index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 5" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
                
                
            }
            else if i == 5 {
                
                CoreDataHandler().saveMyCoxtinDatabase(1, postingId: postingId as NSNumber, molecule: moleculeFeedType6MyCoxtin.text ?? "", dosage: myCoxtin6DosageTextField.text ?? "", fromDays: from6TextFieldMycoxtin.text ?? "", toDays: to6TextFieldMycoxtin.text ?? "", index: i, dbArray: MyCoxtinBindersArray, feedId: feedId as NSNumber, feedProgram: feedProgramTextField.text ?? "",formName: addFarmSelectLbl.text ?? "",isSync : true,feedType: "Feed type 6" ,cocoVacId: CocoiVacId,lngId:lngId as NSNumber,lblDate: lblDate.text ?? "")
            }
        }
        completion (true)
    }
    
    
    
    
    func buttonAction(sender: UIButton!) {
        buttonPopUP.alpha = 0
        ////print("Button tapped")
        
    }
    
    func clickHelpPopUp() {
        
        exitPopUP = popUP.loadFromNibNamed("popUP") as! popUP
        exitPopUP.tag = 0
        exitPopUP.delegatenEW = self
        if lngId == 4 {
            exitPopUP.lblFedPrgram.text = "Adicionar outro programa de feed?"
            exitPopUP.noButton.setTitle("Não", for: .normal)
            exitPopUP.yesButton.setTitle("Sim", for: .normal)
        }
        
        
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)
        
    }
    
    
    func bckButtonCall() {
        
        isClickOnAnyField = true
        
        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        
        feedId = UserDefaults.standard.integer(forKey:"feedId")
        
        UserDefaults.standard.set(feedId, forKey: "feedId")
        UserDefaults.standard.synchronize()
    }
    
    func YesPopUpPosting(){
        
        if exitPopUP.tag == 10 || exitPopUP.tag == 20{
            exitPopUP.tag = 200
            return
        }
        
        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        UserDefaults.standard.synchronize()
        if postingIdFromExistingNavigate == "Exting"{
            feedProgadd = "ExtingFeeed"
        }
        if lngId == 3 {
            
            lblDate.text =  "Sélectionner une date"
        }
        else{
            lblDate.text =  "Select date"
        }
        
        strYesPop = ""
        self.CocoiVacId = 0
        navigatePostingsession = ""
        feedId = UserDefaults.standard.integer(forKey:"feedId")
        feedId = feedId + 1
        
        UserDefaults.standard.set(feedId , forKey: "feedId")
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
        cocciDosFirstTextField.text = ""
        cocciDosSecTextField.text = ""
        cocciDosThrdTextField.text = ""
        cocciDosFourTextField.text = ""
        cocciDosFiveTextField.text = ""
        cocciDosSixTextField.text = ""
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
    
    
    func noPopUpPosting(){
        
        if exitPopUP.tag == 10 {
            btnTagsave = 2
            callSaveMethod(btnTagSave: btnTagsave)
        }
        else if exitPopUP.tag == 20{
            btnTagsave = 2
            callSaveMethod(btnTagSave: btnTagsave)
            
        }else {
            UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
            UserDefaults.standard.synchronize()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.isFeedProgramClick = true
            appDelegate.sendFeedVariable = "Feed"
            appDelegate.strImpFedd = feedImpandMetric
            appDelegate.newColor = datCount + 1
            self.navigationController?.popViewController(animated:true)
            
        }
    }
    
    
    // MARK: - TableView Delegate and dataSource Method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == farmTableView{
            return addFarmArray.count
            
        }
        else {
            
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
                }else {
                    if btnTag > 100 {
                        return fetchDosage.count
                    } else {
                        return arrTargetImp.count
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if  tableView == farmTableView {
            
            let cell:secTableViewCell = self.farmTableView.dequeueReusableCell(withIdentifier: "cell") as! secTableViewCell
            
            cell.farmsShowLbl?.text = addFarmArray.object(at: indexPath.row) as? String
            
            if addFarmArrayWithUnCheckForm.count>0 {
                let c = addFarmArrayWithUnCheckForm.object(at: indexPath.row) as! CaptureNecropsyData
                if c.isChecked == 1 {
                    cell.accessoryType = .checkmark
                }
                else {
                    cell.accessoryType = .none
                }
            } else {
                cell.accessoryType = .none
            }
            return cell
            
        } else {
            
            let cell = UITableViewCell ()
            
            if btnTag == 0 {
                let cocoiControll = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as! String
                cell.textLabel!.text = cocoiControll
            }
            else if btnTag == 1 {
                
                let cocoiControll = (AlternativeArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as! String
                cell.textLabel!.text = cocoiControll
            }
            else if btnTag == 2 {
                
                let cocoiControll = (AntiboticArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as! String
                cell.textLabel!.text = cocoiControll
                
            }
            else if btnTag == 3 {
                let cocoiControll = (MyCoxtinBindersArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as! String
                cell.textLabel!.text = cocoiControll
                
            }
            else if btnTag == 4{
                cell.textLabel!.text = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocoiiVacname") as? String
            }
            else if btnTag == 5{
                
                if feedImpandMetric == "Metric"{
                    cell.textLabel!.text = arrTagetMetric[indexPath.row] as? String
                }
                else{
                    cell.textLabel!.text = arrTargetImp[indexPath.row] as? String
                }
            }
            else if btnTag > 100 {
                let cocoiControll = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                cell.textLabel!.text = cocoiControll
                
                
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView == farmTableView {
            
            let newCell:secTableViewCell = self.farmTableView.cellForRow(at: indexPath as IndexPath) as! secTableViewCell
            
            UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
            UserDefaults.standard.synchronize()
            
            let formName = addFarmArray.object(at:indexPath.row) as! String
            
            if (newCell.accessoryType == .checkmark) {
                
                if UserDefaults.standard.bool(forKey:"Unlinked") == true{
                    let necId1 =  UserDefaults.standard.integer(forKey:"necUnLinked")
                    postingId = necId1 as NSNumber
                    
                }
                
                if navigatePostingsession == "PostingFeedProgram"{
                    
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: false,feedId : feedPostingId as NSNumber)
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccIdFeddprogramBlank(postingId as NSNumber,formName: formName,feedId : feedPostingId as NSNumber)
                }
                else
                {
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: false,feedId : feedId as NSNumber)
                    CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccIdFeddprogramBlank(postingId as NSNumber,formName: formName,feedId : feedPostingId as NSNumber)
                }
                
                newCell.accessoryType = .none
                
                isClickOnAnyField = true
                
            }
            
            else {
                
                if navigatePostingsession == "PostingFeedProgram"{
                    
                    if UserDefaults.standard.bool(forKey:"Unlinked") == true {
                        let necId =  UserDefaults.standard.integer(forKey:"necUnLinked")
                        
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: true,feedId : feedPostingId as NSNumber)
                    }
                    else
                    {
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: true,feedId : feedPostingId as NSNumber)
                    }
                    
                }
                else
                {
                    if UserDefaults.standard.bool(forKey:"Unlinked") == true{
                        let necId =  UserDefaults.standard.integer(forKey:"necUnLinked")
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: true,feedId : feedId as NSNumber)
                        
                    }
                    else
                    {
                        CoreDataHandler().updateFeedProgramNameoNNecropsystep1neccId(postingId as NSNumber, feedProgramName: feedProgramTextField.text!,formName: formName ,isCheckForm: true,feedId : feedId as NSNumber)
                    }
                    
                }
                
                newCell.accessoryType = .checkmark
                
                isClickOnAnyField = true
                
            }
            
        }
        
        
        else {
            
            let cell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
            if btnTag == 0 {
                
                if Allbuttonbg == 0 {
                    
                    coccidsisStartrDrinking.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    
                    firstMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
                else if Allbuttonbg == 1 {
                    coccidsisGrowerDrinking.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    secoundMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
                
                else if Allbuttonbg == 2 {
                    cocciFinisherDrinkingWater.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    thirdMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
                else if Allbuttonbg == 3 {
                    
                    coccidiosisWdDrinking.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    fourthMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
                else if Allbuttonbg == 40 {
                    fivthMoleculelBL.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    fifthMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
                else if Allbuttonbg == 50 {
                    
                    sixthMoleculeLbl.text = (cocciControlArrayfromServer.value(forKey:"desc") as AnyObject).object(at:indexPath.row) as? String
                    sixthMolID = (cocciControlArrayfromServer.value(forKey:"moleculeId") as AnyObject).object(at:indexPath.row) as? Int ?? 0
                    isClickOnAnyField = true
                }
            }
            else if btnTag == 1{
                
            }
            else if btnTag == 2{
                
            }
            
            else if btnTag == 3{
                
            }
            
            
            else if btnTag == 4 {
                // let cocoiControll = cocodiceVacine.object(at: indexPath.row) as! CocoiVaccine
                coccidiosisVaccineDrinkin.text = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocoiiVacname") as? String
                CocoiVacId = (cocodiceVacine.object(at: indexPath.row) as AnyObject).value(forKey: "cocvaccId") as! NSNumber
                
                //  cocoiControll.cocvaccId!
                
                buttonCocotarget()
                
                isClickOnAnyField = true
                
                
            }
            else if btnTag == 5 {
                if feedImpandMetric == "Metric"{
                }
                else{
                    
                }
                buttonCocotarget()
                
                isClickOnAnyField = true
            }
            else if btnTag == 101 {
                
                starterDosageTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 102 {
                
                growerDosageCoccidiosisTEXT.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 103 {
                
                finisherDosageTxtField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 104 {
                
                wdDosageTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 105 {
                
                feed5textField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            } else if btnTag == 106 {
                
                feed6TextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            } else if btnTag == 111 {
                
                alternativeDosageFirstText.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 112 {
                
                alternativeDosageSecoondText.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }else if btnTag == 113 {
                
                alternativeDosageThirdText.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            }else if btnTag == 114 {
                
                alternativeDosageFourText.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            }else if btnTag == 115 {
                
                altrNativeDosage5Text.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            }
            else if btnTag == 116 {
                
                altrNativeDosage6Text.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            }
            
            else if btnTag == 121 {
                
                myCoxtinStarterDosage.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            } else if btnTag == 122 {
                
                myCoxtinGrowerDosage.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 123 {
                
                myCoxtinFinisherDosge.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 124 {
                
                myCoxtinWDDosage.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 125 {
                
                myCoxtin5DosageTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 126 {
                
                myCoxtin6DosageTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }
            else if btnTag == 131 {
                
                antiDosageFirstTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 132 {
                
                antiDosageSecondTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 133 {
                
                antiDosageThirdTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 134 {
                
                antiDosageFourTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 135 {
                
                antiDosageFivthTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
                
            } else if btnTag == 136 {
                
                antiDosageSixTextField.text = (fetchDosage.object(at: indexPath.row) as AnyObject).value(forKey: "doseName") as? String
                isClickOnAnyField = true
                
            }
            
            
        }
        buttonPressed1()
    }
    
    func submittingMolecule(field: UILabel, index: Int){
        let alert = UIAlertController(title: "Molecule", message: "Please input molecule", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            field.text = textField.text
            let dict: [String:Any] = ["catId":(self.cocciControlArrayfromServer.value(forKey: "catId") as AnyObject).object(at:index) as? Int, "desc":field.text, "lngId":(self.cocciControlArrayfromServer.value(forKey: "lngId") as AnyObject).object(at:index) as? Int, "moleculeId":""]
            self.cocciControlArrayfromServer.add(dict)
            self.droperTableView.reloadData()
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Enter molecule name"
        }
        alert.addAction(action)
        self.present(alert, animated:true, completion: nil)
    }
    // MARK: - TEXTFIELD Delegate
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
            alternativeFromFourTextField.returnKeyType = UIReturnKeyType.done
            alternativeToFirstTextField.returnKeyType = UIReturnKeyType.done
            alternativeToSecondTextField.returnKeyType = UIReturnKeyType.done
            alternativeTothirdTextField.returnKeyType = UIReturnKeyType.done
            
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
            
            
            cocciDosFirstTextField.returnKeyType = UIReturnKeyType.done
            cocciDosSecTextField.returnKeyType = UIReturnKeyType.done
            cocciDosThrdTextField.returnKeyType = UIReturnKeyType.done
            cocciDosFourTextField.returnKeyType = UIReturnKeyType.done
            cocciDosFiveTextField.returnKeyType = UIReturnKeyType.done
            cocciDosSixTextField.returnKeyType = UIReturnKeyType.done
            farmTableView.alpha = 0
            
        }
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        feedProgramTextField.becomeFirstResponder()
        feedProgramTextField.resignFirstResponder()
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField.tag {
            
        case 11,12,13,14,19,20,21,26,27,28,29,30,31,32,33,38,39,40,41,42,43,44,45,46,51,52,53,54,55,56,57,58,100,101,102,103,104,105,106,107,108,109,110,111,114,115,116,117,120,121,122,123,126,127,128,129,132,133,134,135,136 :
            
            let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            return string == numberFiltered && newString.length <= maxLength
        case 15,16,17,18,23,22,24,25,34,35,36,37,47,48,49,50,112,113,118,119,124,125,130,131 :
            
            let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 7
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
            if countdots > 0 && string == "."
            {
                return false
            }
            return string == numberFiltered && newString.length <= maxLength
            
            
        case 333 :
            
            let ACCEPTED_CHARACTERS = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£"
            let set = CharacterSet(charactersIn: ACCEPTED_CHARACTERS)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            
            
            let maxLength = 50
            let currentString: NSString = feedProgramTextField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength && filtered == string
            
        default : break
            //print( "default case")
        }
        isClickOnAnyField = true
        return true
        
    }
    
    // MARK: - UI TOUCH  Method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func touchMoved() {
        ////print("touch moved")
    }
    
    func touchBegan() {
        ////print("touch began")
    }
    
    func animateView (movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
    
    
    
    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView ,indexValue : String){
        
        if indexValue == "Log Out"
        {
            
            UserDefaults.standard.removeObject(forKey: "login")
            if ConnectionManager.shared.hasConnectivity() {
                self.ssologoutMethod()
                CoreDataHandler().deleteAllData("Custmer")
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
            
            buttonbg.removeFromSuperview()
            logOutPopView1.removeView(view)
            
        }
    }
    
    // MARK:  /*********** Logout SSO Account **************/
    func ssologoutMethod()
    {
        gigya.logout() { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func logOUT(sender: AnyObject) {
        let feedProgramArray = CoreDataHandler().FetchFeedProgram(postingId as NSNumber)
        let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(postingId as NSNumber)
        if feedProgramArray.count<1 || feedProgramTextField.text == "" {
            // Create the alert controller
            if farms.count > 0 {
                self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 20)
                
                return
            }
        }
        else if farms.count > 0{
            self.showExitAlertWith(msg: "Please connect \(farms.count) farm(s) with feed program. Do you want not do it now?", tag: 20)
        }
        else{
            clickHelp()
        }
        
    }
    
    func clickHelp() {
        
        
        buttonbg1.frame = CGRect(x: 0,y: 0,width: 1024,height: 768)
        
        buttonbg1.addTarget(self, action: #selector(FeedProgramViewController.logOytButtn), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg1)
        
        
        logOutPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        logOutPopView1.logoutDelegate = self
        
        logOutPopView1.layer.cornerRadius = 8
        logOutPopView1.layer.borderWidth = 3
        logOutPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1 .addSubview(logOutPopView1)
        logOutPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200,y: 60,width: 150,height: 60))
    }
    
    @objc func logOytButtn () {
        buttonbg1.removeFromSuperview()
        logOutPopView1.removeFromSuperview()
        
    }
    
    func textFeildValidation() -> Bool{
        
        if(flag == 1){
            
            if(FromstarterDurationTextField.text! >= toStarterTextField.text!){
            }
            
            if (FromstarterDurationTextField.text! >= toStarterTextField.text! ) ||
                ( FromGrowerTextField.text! >= toGrowerTextField.text! ) ||
                ( fromFinisherTextField.text! >= toFinisherTextField.text! ) ||
                ( fromWDtextField.text! >= toWdTextField.text! ){
                return false
            }
            
            else{
                return true
            }
        }
        
        else if( flag == 2){
            
            if(( antiFromDurationFirstTextField.text! >= antiToDurationFirstTextField.text! ) ||
               ( antiFromDurationSecondTextField.text! >= antiToDurationSecondTextField.text!) ||
               ( antiFromDurationThirdTextField.text! >= antiToDurationThirdTextField.text!) ||
               ( antiFromDurationFourTextField.text! >= antiToDurationFourTextField.text!)){
                return false
            }
            else{
                return true
            }
        }
        
        else if(flag == 3){
            
            if(( alternativeFromFirstTextField.text! >= alternativeToFirstTextField.text! ) || ( alternativeFromSecondTextField.text! >=
                                                                                                 alternativeToSecondTextField.text! ) || ( alternativeFromthirdTextField.text! >= alternativeTothirdTextField.text! ) || ( alternativeFromFourTextField.text! >= alternativeToFourTextField.text! )){
                return false
            }
            else{
                return true
            }
        }
        
        if(flag == 4){
            
            if(( myFromFirstTextField.text! >= myToFirstTextField.text! ) || ( myFromSecondTextField.text! >= myToSecondTextField.text! ) || ( myFromThirdTextField.text! >= myToFirstTextField.text! ) || ( myFromFourTextField.text! >= myToFourTextField.text! )){
                return false
            }
            else{
                return true
            }
        }
        
        else {
            return false
        }
    }
    
    // MARK:  /*********** Add custome padding to Textfield's **************/
    func spacingInTxtField(){
        
        antiFromDurationFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromDurationFirstTextField.leftViewMode = .always
        
        antiFromDurationThirdTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromDurationThirdTextField.leftViewMode = .always
        
        to5TextAlternative.leftView = createPaddingView(width: 10, height: 20)
        to5TextAlternative.leftViewMode = .always
        
        antiMoleculeFeedType1.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType1.leftViewMode = .always
        
        antiMoleculeFeedType2.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType2.leftViewMode = .always
        
        antiMoleculeFeedType3.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType3.leftViewMode = .always
        
        antiMoleculeFeedType4.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType4.leftViewMode = .always
        
        antiMoleculeFeedType5.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType5.leftViewMode = .always
        
        antiMoleculeFeedType6.leftView = createPaddingView(width: 10, height: 20)
        antiMoleculeFeedType6.leftViewMode = .always
        
        feedProgramTextField.leftView = createPaddingView(width: 10, height: 20)
        feedProgramTextField.leftViewMode = .always
        
        antiToDurationFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationFirstTextField.leftViewMode = .always
        
        antiFromDurationSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromDurationSecondTextField.leftViewMode = .always
        
        antiToDurationSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationSecondTextField.leftViewMode = .always
        
        antiToDurationThirdTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationThirdTextField.leftViewMode = .always
        
        antiFromDurationFourTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromDurationFourTextField.leftViewMode = .always
        
        antiToDurationFourTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationFourTextField.leftViewMode = .always
        
        antiFromFivthTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromFivthTextField.leftViewMode = .always
        
        antiToDurationfivthTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationfivthTextField.leftViewMode = .always
        
        antiFromSixthTextField.leftView = createPaddingView(width: 10, height: 20)
        antiFromSixthTextField.leftViewMode = .always
        
        antiToDurationSixTextField.leftView = createPaddingView(width: 10, height: 20)
        antiToDurationSixTextField.leftViewMode = .always
        
        FromstarterDurationTextField.leftView = createPaddingView(width: 10, height: 20)
        FromstarterDurationTextField.leftViewMode = .always
        
        toStarterTextField.leftView = createPaddingView(width: 10, height: 20)
        toStarterTextField.leftViewMode = .always
        
        FromGrowerTextField.leftView = createPaddingView(width: 10, height: 20)
        FromGrowerTextField.leftViewMode = .always
        
        toGrowerTextField.leftView = createPaddingView(width: 10, height: 20)
        toGrowerTextField.leftViewMode = .always
        
        fromFinisherTextField.leftView = createPaddingView(width: 10, height: 20)
        fromFinisherTextField.leftViewMode = .always
        
        toFinisherTextField.leftView = createPaddingView(width: 10, height: 20)
        toFinisherTextField.leftViewMode = .always
        
        fromWDtextField.leftView = createPaddingView(width: 10, height: 20)
        fromWDtextField.leftViewMode = .always
        
        toWdTextField.leftView = createPaddingView(width: 10, height: 20)
        toWdTextField.leftViewMode = .always
        
        from5TextField.leftView = createPaddingView(width: 10, height: 20)
        from5TextField.leftViewMode = .always
        
        toFeed5TextFeidl.leftView = createPaddingView(width: 10, height: 20)
        toFeed5TextFeidl.leftViewMode = .always
        
        from6teXTfield.leftView = createPaddingView(width: 10, height: 20)
        from6teXTfield.leftViewMode = .always
        
        toFeed6TextField.leftView = createPaddingView(width: 10, height: 20)
        toFeed6TextField.leftViewMode = .always
        
        moleculeFeedType1Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType1Alternativ.leftViewMode = .always
        
        alternativeFromFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeFromFirstTextField.leftViewMode = .always
        
        alternativeToFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeToFirstTextField.leftViewMode = .always
        
        moleculeFeedType2Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType2Alternativ.leftViewMode = .always
        
        alternativeFromSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeFromSecondTextField.leftViewMode = .always
        
        alternativeToSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeToSecondTextField.leftViewMode = .always
        
        moleculeFeedType3Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType3Alternativ.leftViewMode = .always
        
        alternativeFromthirdTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeFromthirdTextField.leftViewMode = .always
        
        alternativeTothirdTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeTothirdTextField.leftViewMode = .always
        
        moleculeFeedType4Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType4Alternativ.leftViewMode = .always
        
        alternativeFromFourTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeFromFourTextField.leftViewMode = .always
        
        alternativeToFourTextField.leftView = createPaddingView(width: 10, height: 20)
        alternativeToFourTextField.leftViewMode = .always
        
        moleculeFeedType5Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType5Alternativ.leftViewMode = .always
        
        from5TextAlternative.leftView = createPaddingView(width: 10, height: 20)
        from5TextAlternative.leftViewMode = .always
        
        moleculeFeedType6Alternativ.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType6Alternativ.leftViewMode = .always
        
        from6TextAlternative.leftView = createPaddingView(width: 10, height: 20)
        from6TextAlternative.leftViewMode = .always
        
        to6TextAlternative.leftView = createPaddingView(width: 10, height: 20)
        to6TextAlternative.leftViewMode = .always
        
        moleculeFeedType1MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType1MyCoxtin.leftViewMode = .always
        
        myToFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        myToFirstTextField.leftViewMode = .always
        
        myFromFirstTextField.leftView = createPaddingView(width: 10, height: 20)
        myFromFirstTextField.leftViewMode = .always
        
        moleculeFeedType2MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType2MyCoxtin.leftViewMode = .always
        
        myFromSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        myFromSecondTextField.leftViewMode = .always
        
        myToSecondTextField.leftView = createPaddingView(width: 10, height: 20)
        myToSecondTextField.leftViewMode = .always
        
        moleculeFeedType3MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType3MyCoxtin.leftViewMode = .always
        
        myFromThirdTextField.leftView = createPaddingView(width: 10, height: 20)
        myFromThirdTextField.leftViewMode = .always
        
        myToThirdTextField.leftView = createPaddingView(width: 10, height: 20)
        myToThirdTextField.leftViewMode = .always
        
        moleculeFeedType4MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType4MyCoxtin.leftViewMode = .always
        
        myFromFourTextField.leftView = createPaddingView(width: 10, height: 20)
        myFromFourTextField.leftViewMode = .always
        
        myToFourTextField.leftView = createPaddingView(width: 10, height: 20)
        myToFourTextField.leftViewMode = .always
        
        moleculeFeedType5MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType5MyCoxtin.leftViewMode = .always
        
        from5TextFieldMycoxtin.leftView = createPaddingView(width: 10, height: 20)
        from5TextFieldMycoxtin.leftViewMode = .always
        
        to5TextFieldMycoxtin.leftView = createPaddingView(width: 10, height: 20)
        to5TextFieldMycoxtin.leftViewMode = .always
        
        moleculeFeedType6MyCoxtin.leftView = createPaddingView(width: 10, height: 20)
        moleculeFeedType6MyCoxtin.leftViewMode = .always
        
        from6TextFieldMycoxtin.leftView = createPaddingView(width: 10, height: 20)
        from6TextFieldMycoxtin.leftViewMode = .always
        
        to6TextFieldMycoxtin.leftView = createPaddingView(width: 10, height: 20)
        to6TextFieldMycoxtin.leftViewMode = .always
        
        myToThirdTextField.leftView = createPaddingView(width: 10, height: 20)
        myToThirdTextField.leftViewMode = .always
        
    }
    
    func createPaddingView(width: CGFloat, height: CGFloat) -> UIView {
        return UIView(frame: CGRect(x: 15, y: 0, width: width, height: height))
        
    }
    
    @IBAction func addFarmBtnAction(sender: AnyObject) {
        
        if  feedProgramTextField.text == ""  {
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please enter feed program.", comment: ""))
            
        }
        else{
            
            feedArr.removeAllObjects()
            addFarmArray.removeAllObjects()
            addFarmArrayWithUnCheckForm.removeAllObjects()
            let necId =  UserDefaults.standard.integer(forKey:"necUnLinked")
            
            let isUpadateFeedFromUnlinked = UserDefaults.standard.bool(forKey:"isUpadteFeedFromUnlinked")
            
            if isUpadateFeedFromUnlinked == true
            {
                
                if navigatePostingsession == "PostingFeedProgram"{
                    
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedPostingId as NSNumber).mutableCopy() as! NSMutableArray
                }
                else
                {
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedId as NSNumber).mutableCopy() as!  NSMutableArray
                }
                
                let feedArr1 = CoreDataHandler().FetchNecropsystep1neccIdWithCheckFarm(necId as NSNumber).mutableCopy() as! NSMutableArray
                
                feedArr.addObjects(from: feedArr1 as [AnyObject])
                
                for i in  0..<feedArr.count
                {
                    let  c = feedArr.object(at:i) as! CaptureNecropsyData
                    addFarmArray.add(c.farmName!)
                    addFarmArrayWithUnCheckForm.add(feedArr.object(at:i))
                }
            }
            else
            {
                if navigatePostingsession == "PostingFeedProgram"{
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedPostingId as NSNumber).mutableCopy() as! NSMutableArray
                }
                else
                {
                    feedArr = CoreDataHandler().FetchFarmNameOnNecropsystep1neccId(necId as NSNumber, feedProgramName: feedProgramTextField.text!,feedId : feedId as NSNumber).mutableCopy() as! NSMutableArray
                }
                
                let feedArr1 = CoreDataHandler().FetchNecropsystep1neccIdWithCheckFarm(necId as NSNumber).mutableCopy() as AnyObject
                feedArr.addObjects(from: feedArr1 as! [AnyObject])
                
                for i in  0..<feedArr.count
                {
                    let  c = feedArr.object(at:i) as! CaptureNecropsyData
                    addFarmArray.add(c.farmName!)
                    addFarmArrayWithUnCheckForm.add(feedArr.object(at:i))
                }
            }
            
            if addFarmArray.count == 0
            {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"You don't have any farm to add in feed.")
            }
            else
            {
                addFarmPopp()
                farmTableView.alpha = 1
                farmTableView.layer.borderWidth = 1
                farmTableView.layer.cornerRadius = 7
                farmTableView.layer.borderColor =  UIColor.clear.cgColor
                farmTableView.frame = CGRect(x: 335,y: 500,width: 375,height: 150)
                farmTableView.reloadData()
            }
        }
    }
    
    func removeDuplicates(array: NSMutableArray) -> NSMutableArray {
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
        return result
    }
    
    
    func addFarmPopp(){
        
        backBtnnFrame.frame = CGRect(x: 0,y: 0,width: 1024,height: 768)
        backBtnnFrame.addTarget(self, action: #selector(addFarmEnd), for: .touchUpInside)
        backBtnnFrame.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(backBtnnFrame)
        backBtnnFrame.addSubview(farmTableView)
    }
    
    @objc func addFarmEnd(){
        
        let necId =  UserDefaults.standard.integer(forKey:"necUnLinked")
        
        if UserDefaults.standard.bool(forKey:"Unlinked") == true{
            let necId1 =  UserDefaults.standard.integer(forKey:"necUnLinked")
            postingId = necId1 as NSNumber
        }
        
        if navigatePostingsession == "PostingFeedProgram"{
            farmArrayTrue = CoreDataHandler().FetchNecropsystep1neccIdTrueVal(postingId as NSNumber,formTrueValue: true,feedProgram: feedProgramTextField.text!,feedId :feedPostingId as NSNumber)
        }
        else
        {
            farmArrayTrue = CoreDataHandler().FetchNecropsystep1neccIdTrueVal(postingId as NSNumber,formTrueValue: true,feedProgram: feedProgramTextField.text!,feedId :feedId as NSNumber)
        }
        if farmArrayTrue.count > 0 {
            
            let ftitle = NSMutableString()
            for i in 0..<farmArrayTrue.count{
                
                var label = UILabel()
                let feepRGMR = (farmArrayTrue.object(at:i) as AnyObject).value(forKey:"farmName") as! String
                
                if i == 0
                {
                    label  = UILabel(frame: CGRect(x: 50,y: 519,width: 111,height: 21))
                    ftitle.append( feepRGMR + " " )
                }
                
                else{
                    label  = UILabel(frame: CGRect(x: 50,y: 519,width: 111*(CGFloat(i)+1)+10,height: 21))
                    ftitle.append(", " + feepRGMR + " " )
                }
                
                label.textAlignment = NSTextAlignment.center
                label.backgroundColor = UIColor.red
                addFarmSelectLbl.text = ftitle as String
            }
        }
        else
        {
            addFarmSelectLbl.text = NSLocalizedString("- Select -", comment: "")
        }
        
        btnTag = 0
        backBtnnFrame.removeFromSuperview()
    }
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at:j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at:w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId
                {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        
        let allPostingSessionArr = NSMutableArray()
        
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count
        {
            let pSession = postingArrWithAllData.object(at:i) as! PostingSession
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }
        
        for i in 0..<necArrWithoutPosting.count
        {
            let nIdSession = necArrWithoutPosting.object(at:i) as! CaptureNecropsyData
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }
        
        return allPostingSessionArr
    }
}



