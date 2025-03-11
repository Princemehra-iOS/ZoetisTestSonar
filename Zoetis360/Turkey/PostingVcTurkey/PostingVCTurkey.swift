//
//  PostingVCTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 12/03/18.
//  Copyright © 2018 . All rights reserved.
//
import UIKit
import CoreData
import Alamofire
import Reachability
import Gigya
import GigyaTfa
import GigyaAuth

class PostingVCTurkey: UIViewController,DropperDelegateTurkey,UITextViewDelegate,UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate{
    
    
    // MARK: - VARIABLES
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    var isClickOnAnyField = Bool()
    var lngId = NSInteger()
    var navigateFromUnlinked  = String ()
    var necId  = Int ()
    var postingIdnavigate  = Int ()
    var unComplexId  = Int ()
    var unCustId  = Int ()
    var lblTimeStamp = String()
    var actualTimeStamp = String()
    let buttonbg1 = UIButton ()
    let buttonDroper = UIButton ()
    var lblTimestampUnlinked = String()
    var impFeed = String ()
    var customPopView1 :UserListView!
    var exitPopUP :popUP!
    
    var custmetIdDb = NSNumber()
    var cusmerRepIdDb = NSNumber()
    var birdSizeIdDb = NSNumber()
    var breedIdDb = NSNumber()
    var salesRepIdDb = NSNumber()
    var sessionTypeIdDb = NSNumber()
    var veterinartionIdDb = NSNumber()
    var postingIdDb = NSNumber()
    var loginSessionIdDb = NSNumber()
    var complexIdDb = NSNumber()
    var cocciProgramIdDb = NSNumber()
    
    var custRep = NSMutableArray ()
    var fetchcustRep = NSArray ()
    var autocompleteUrls = NSMutableArray ()
    var autoSerchTable = UITableView ()
    var feedProgramArray = NSArray ()
    var datePicker : UIDatePicker!
    var buttonBg1 = UIButton();
    var navStr = String ()
    var postingArray = NSArray()
    var custmerArray  = NSArray()
    var SalesRepArr  = NSArray()
    var sessionTypeArr  = NSArray()
    
    var complexArr  = NSArray()
    var VetrationArr  = NSArray()
    var CocoiiProgramArr  = NSArray()
    var birdArray: [BirdSizePostingTurkey]  = []
    var strComplexFromUnlinked = String ()
    var strdateFromUnlinked = String ()
    var droperTableView  =  UITableView ()
    let buttonbg = UIButton ()
    var btnTag = Int()
    var metricArray: [BirdSizePostingTurkey]  = []
    
    var newColor = Int()
    var postingId = Int()
    var managedObjectContext = (UIApplication.shared.delegate   as! AppDelegate).managedObjectContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var butttnTag = Int()
    var indexOfSelectedPerson = Int()
    let cellReuseIdentifier = "cell"
    
    // MARK: - OUTLETS
    
    
    @IBOutlet weak var imperialBtnOutlet: UIButton!
    @IBOutlet weak var metricBtnOutlet: UIButton!
    @IBOutlet weak var doneButtonP: UIButton!
    @IBOutlet weak var feedProgrmLbl2: UILabel!
    @IBOutlet weak var feedProgramLbl: UILabel!
    @IBOutlet weak var feed3PrgrmLbl: UILabel!
    @IBOutlet weak var feed4prgrmlBL: UILabel!
    @IBOutlet weak var feed5PrgrmLbl: UILabel!
    @IBOutlet weak var birdTypeOutlet: UIButton!
    @IBOutlet weak var firstComma: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var secondComma: UILabel!
    @IBOutlet weak var thirdComma: UILabel!
    @IBOutlet weak var fourComma: UILabel!
    @IBOutlet weak var lblFeed: UILabel!
    @IBOutlet weak var lblAddVacci: UILabel!
    @IBOutlet weak var sliderBtnOutlet: UIButton!
    @IBOutlet weak var feedProgramLabel: UILabel!
    @IBOutlet var maineView: UIView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var backButtonFronNec: UIButton!
    @IBOutlet weak var accountantContactView: UIView!
    @IBOutlet weak var addFeedProgramOutle: UIButton!
    @IBOutlet weak var addVaccinationOutlet: UIButton!
    @IBOutlet weak var feedProgramOutlet: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var CustRepTextField: UITextField!
    @IBOutlet weak var birdSize: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var lblSessionType: UILabel!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnCustmer: UIButton!
    @IBOutlet weak var lblComplex: UILabel!
    @IBOutlet weak var lblCocieeProgram: UILabel!
    @IBOutlet weak var lblVeteration: UILabel!
    @IBOutlet weak var btnSessionType: UIButton!
    @IBOutlet weak var btnComplex: UIButton!
    @IBOutlet weak var btnCocciProgram: UIButton!
    @IBOutlet weak var btnVetration: UIButton!
    @IBOutlet weak var btnFarmMil: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var btnFarm: UIButton!
    @IBOutlet weak var btnSales: UIButton!
    @IBOutlet weak var btnCustRep: UIButton!
    @IBOutlet weak var lblCustmer: UILabel!
    
    @IBOutlet weak var lblSelesRep: UILabel!
    @IBOutlet weak var txtNotes: UITextField!
    @IBOutlet weak var lblFarm: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblFormValue: UILabel!
    @IBOutlet weak var lblFieldMil: UILabel!
    @IBOutlet weak var lblAgeValue: UILabel!
    @IBOutlet weak var btnOpt1: UIButton!
    @IBOutlet weak var btnOpt2: UIButton!
    @IBOutlet weak var btnSickButton: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var imperialLabel: UILabel!
    @IBOutlet weak var metricLabel: UILabel!
    @IBOutlet weak var lblChemicalIonophore: UILabel!
    @IBOutlet weak var antiboticFree: UILabel!
    @IBOutlet weak var conventionalLabel: UILabel!
    @IBOutlet weak var feedImagrIcon: UIImageView!
    @IBOutlet weak var addVacIcon: UIImageView!
    
    
    
    @IBOutlet weak var outTimeBtn: UIButton!
    @IBOutlet weak var outTimLbl: UILabel!
    @IBOutlet weak var outTimeTxtFld: UITextField!
    
    @IBOutlet weak var avgweightBtn: UIButton!
    @IBOutlet weak var lblAvgWeight: UILabel!
    @IBOutlet weak var avgWeightTxtFld: UITextField!
    
    @IBOutlet weak var avgAgeBtn: UIButton!
    @IBOutlet weak var avgAgeTxtFld: UITextField!
    @IBOutlet weak var lblAvgAge: UILabel!
    
    @IBOutlet weak var lblFCR: UILabel!
    @IBOutlet weak var fcrTxtFld: UITextField!
    @IBOutlet weak var fcrBtn: UIButton!
    
    
    @IBOutlet weak var lblMortality: UILabel!
    @IBOutlet weak var txtFldMortality: UITextField!
    @IBOutlet weak var btnMortalty: UIButton!
    
    @IBOutlet weak var lblLivability: UILabel!
    @IBOutlet weak var txtFldLivability: UITextField!
    @IBOutlet weak var btnLivability: UIButton!
    
    
    
    
    @objc func methodOfReceivedNotification(notification: Notification){
        //Take Action on Notification
        UserDefaults.standard.set(0, forKey: "postingId")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "PostingVCTurkey") as! PostingVCTurkey
        self.navigationController?.pushViewController(navigateTo, animated: false)
    }
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(PostingVCTurkey.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifierTurkey"), object: nil)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        UserDefaults.standard.set(0, forKey: "birdIndex")  //Integer
        
        accountantContactView.layer.cornerRadius = 3.5
        accountantContactView.layer.borderColor = UIColor.black.cgColor
        self.accountantContactView.layer.borderWidth = 1
        
        notesTextView.layer.cornerRadius = 3.5
        notesTextView.layer.borderColor = UIColor.black.cgColor
        self.notesTextView.layer.borderWidth = 1
        
        notesTextView.delegate = self
        isClickOnAnyField = false
        backButtonFronNec.alpha = 0
        UserDefaults.standard.set(false, forKey: "isNewPostingId")
        UserDefaults.standard.set(true, forKey: "SessionData")
        UserDefaults.standard.synchronize()
        
        doneButtonP.isUserInteractionEnabled = false
        doneButtonP.layer.borderWidth = 1
        doneButtonP.layer.cornerRadius = 4
        doneButtonP.layer.borderColor = UIColor.clear.cgColor
        impFeed = "Imperial"
        feedProgrmLbl2.isHidden = true
        feedProgramLbl.isHidden = true
        feed3PrgrmLbl.isHidden = true
        feed4prgrmlBL.isHidden = true
        feed5PrgrmLbl.isHidden = true
        
        nextButtonOutlet.isUserInteractionEnabled = false
        feedProgramLabel.isHidden = true
        firstComma.isHidden = true
        secondComma.isHidden = true
        thirdComma.isHidden = true
        fourComma.isHidden = true
        
        //        notesTextView.layer.borderColor = UIColor.black.cgColor
        feedProgramOutlet.layer.borderWidth = 1
        feedProgramOutlet.layer.cornerRadius = 3.5
        feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
        
        btnDate.layer.borderWidth = 1
        btnDate.layer.cornerRadius = 6
        btnDate.layer.borderColor = UIColor.black.cgColor
        
        btnCustmer.layer.borderWidth = 1
        btnCustmer.layer.cornerRadius = 3.5
        btnCustmer.layer.borderColor = UIColor.black.cgColor
        
        btnComplex.layer.borderWidth = 1
        btnComplex.layer.cornerRadius = 3.5
        btnComplex.layer.borderColor = UIColor.black.cgColor
        
        btnCocciProgram.layer.borderWidth = 1
        btnCocciProgram.layer.cornerRadius = 3.5
        btnCocciProgram.layer.borderColor = UIColor.black.cgColor
        
        btnVetration.layer.borderWidth = 1
        btnVetration.layer.cornerRadius = 3.5
        btnVetration.layer.borderColor = UIColor.black.cgColor
        
        btnSales.layer.borderWidth = 1
        btnSales.layer.cornerRadius = 3.5
        btnSales.layer.borderColor = UIColor.black.cgColor
        
        btnSessionType.layer.borderWidth = 1
        btnSessionType.layer.cornerRadius = 3.5
        btnSessionType.layer.borderColor = UIColor.black.cgColor
        
        avgweightBtn.layer.borderWidth = 1
        avgweightBtn.layer.cornerRadius = 3.5
        avgweightBtn.layer.borderColor = UIColor.black.cgColor
        
        avgAgeBtn.layer.borderWidth = 1
        avgAgeBtn.layer.cornerRadius = 3.5
        avgAgeBtn.layer.borderColor = UIColor.black.cgColor
        
        fcrBtn.layer.borderWidth = 1
        fcrBtn.layer.cornerRadius = 3.5
        fcrBtn.layer.borderColor = UIColor.black.cgColor
        
        btnMortalty.layer.borderWidth = 1
        btnMortalty.layer.cornerRadius = 3.5
        btnMortalty.layer.borderColor = UIColor.black.cgColor
        
        btnLivability.layer.borderWidth = 1
        btnLivability.layer.cornerRadius = 3.5
        btnLivability.layer.borderColor = UIColor.black.cgColor
        
        outTimeBtn.layer.borderWidth = 1
        outTimeBtn.layer.cornerRadius = 3.5
        outTimeBtn.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        notesTextView.textContainer.lineFragmentPadding = 12
        
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        isClickOnAnyField = false
        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        viewUpdate()
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
            if appDelegate.sendFeedVariable == "Feed"{
                let value  = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
                if value.count>0{
                    doneButtonP.isUserInteractionEnabled = true
                }
            } else if appDelegate.sendFeedVariable == "vaccination"{
                
            } else {
            }
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
        }
        
        feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        
        if  feedProgramArray.count == 1 {
            
            feedProgramLbl.text = (feedProgramArray.object(at: 0) as AnyObject).value(forKey: "feddProgramNam") as? String
        }
        if feedProgramArray.count > 1 {
            
            let ftitle = NSMutableString()
            for i in 0..<feedProgramArray.count{
                
                var label = UILabel()
                let feepRGMR = (feedProgramArray.object(at: i) as AnyObject).value(forKey: "feddProgramNam") as! String
                
                if i == 0 {
                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111, height: 21))
                    ftitle.append( feepRGMR + " " )
                    
                } else {
                    
                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111*(CGFloat(i)+1)+10, height: 21))
                    ftitle.append(", " + feepRGMR + " " )
                }
                
                label.textAlignment = NSTextAlignment.center
                label.backgroundColor = UIColor.red
                feedProgramLbl.text = ftitle as String
            }
        }
        
        CustRepTextField.delegate = self
        if  let data = CoreDataHandlerTurkey().fectCustomerRepWithCustomernameTurkey( 1) as? NSArray{
            fetchcustRep = data
        }
        
        buttonDroper.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonDroper.addTarget(self, action: #selector(PostingVCTurkey.buttonPressedDroper), for: .touchUpInside)
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
        autoSerchTable.alpha = 0
        feedProgramOutlet.isHidden = true
        
        if (newColor > 0){
            
            feedProgramOutlet.layer.borderWidth = 1
            feedProgramOutlet.layer.cornerRadius = 3.5
            feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
        }
        
        if appDelegate.isDoneClick == true {
            
            if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                
                postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
                lblComplex.text =  UserDefaults.standard.value(forKey: "complexUnlinked") as? String
                lblDate.text =  UserDefaults.standard.value(forKey: "complexDateUnlinked") as? String
                
                if appDelegate.sendFeedVariable == "Feed"{
                    
                } else if appDelegate.sendFeedVariable == "vaccination" {
                    
                } else {
                }
            } else {
                postingId = UserDefaults.standard.integer(forKey: "postingId")
            }
            
            if(CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId as NSNumber).count == 0){
                
                if lngId == 5{
                    lblAddVacci.text = "Agregar vacunación"
                } else {
                    lblAddVacci.text = "Add vaccination"
                }
            } else {
                
                addVaccinationOutlet.backgroundColor = UIColor.gray
                if lngId == 5{
                    lblAddVacci.text = "Agregar vacunación"
                } else {
                    lblAddVacci.text = "Edit vaccination"
                }
            }
        }
        
        
        if appDelegate.sendFeedVariable == "Feed" {
            feedProgramLbl.isHidden = false
            feedProgramOutlet.isHidden = false
            dropImageView.isHidden = false
            feedProgrmLbl2.isHidden = false
            feed3PrgrmLbl.isHidden = false
            feed4prgrmlBL.isHidden = false
            feed5PrgrmLbl.isHidden = false
            
            if UserDefaults.standard.integer(forKey: "isBackWithoutFedd") == 0 {
                
                feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
                
                if feedProgramArray.count > 0 {
                    addFeedProgramOutle.backgroundColor = UIColor.gray
                    feedProgramOutlet.isHidden = false
                    feedProgramOutlet.layer.borderWidth = 1
                    feedProgramOutlet.layer.cornerRadius = 3.5
                    feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
                    dropImageView.isHidden = false
                    feedProgramLabel.isHidden = false
                    
                }  else {
                    addFeedProgramOutle.backgroundColor = UIColor.init(red: 1/255, green: 193/255, blue: 202/255, alpha: 1.0)
                    
                    
                    feedProgramOutlet.isHidden = true
                    dropImageView.isHidden = true
                    feedProgramLabel.isHidden = true
                }
            } else {
                addFeedProgramOutle.backgroundColor = UIColor.gray
                feedProgramOutlet.isHidden = false
                feedProgramOutlet.layer.borderWidth = 1
                feedProgramOutlet.layer.cornerRadius = 3.5
                feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
                dropImageView.isHidden = false
                feedProgramLabel.isHidden = false
            }
        }
        else if appDelegate.sendFeedVariable == "vaccination"  {
            
            feedProgramLbl.isHidden = false
            feedProgramOutlet.isHidden = false
            dropImageView.isHidden = false
            feedProgrmLbl2.isHidden = false
            
            feed3PrgrmLbl.isHidden = false
            feed4prgrmlBL.isHidden = false
            feed5PrgrmLbl.isHidden = false
            
            feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
            
            if feedProgramArray.count > 0 {
                addFeedProgramOutle.backgroundColor = UIColor.gray
                feedProgramOutlet.isHidden = false
                feedProgramOutlet.layer.borderWidth = 1
                feedProgramOutlet.layer.cornerRadius = 3.5
                feedProgramOutlet.layer.borderColor = UIColor.black.cgColor
                dropImageView.isHidden = false
                feedProgramLabel.isHidden = false
                
            } else {
                addFeedProgramOutle.backgroundColor = UIColor.init(red: 1/255, green: 193/255, blue: 202/255, alpha: 1.0)
                feedProgramOutlet.isHidden = true
                dropImageView.isHidden = true
                feedProgramLabel.isHidden = true
                
            }
        }
        
        feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
            if appDelegate.sendFeedVariable == "Feed"{
            } else if appDelegate.sendFeedVariable == "vaccination"{
                
            } else {
            }
        } else {
            postingId = UserDefaults.standard.integer(forKey: "postingId")
        }
        
        if feedProgramArray.count > 0{
            nextButtonOutlet.backgroundColor = UIColor(red: 11/255, green:88/255, blue:160/255, alpha:1)
            nextButtonOutlet.isUserInteractionEnabled = true
        } else {
            nextButtonOutlet.backgroundColor = UIColor.gray
            nextButtonOutlet.isUserInteractionEnabled = false
        }
        
        /**********Ffeth data of posting session from Db **********/
        self.postingArray = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId as NSNumber)
        var vetNam = String()
        if self.postingArray.count > 0 {
            let vetName :  PostingSessionTurkey =  self.postingArray.object(at: 0) as! PostingSessionTurkey
            vetNam =   vetName.vetanatrionName!
        }
        if self.postingArray.count == 0 || vetNam == "" {
            
            lblVeteration.text = NSLocalizedString("- Select -", comment: "")
            if lngId == 5{
                lblDate.text = "- Seleccione fecha -"
            }
            lblCustmer.text = NSLocalizedString("- Select -", comment: "")
            CustRepTextField.text = ""
            lblSelesRep.text = NSLocalizedString("- Select -", comment: "")
            lblSessionType.text = "Farm Visit"
            lblComplex.text = NSLocalizedString("- Select -", comment: "")
            lblCocieeProgram.text = NSLocalizedString("- Select -", comment: "")
            notesTextView.text = ""
            breedIdDb = 0
            birdSizeIdDb = 0
            cocciProgramIdDb = 0
            complexIdDb = 0
            cusmerRepIdDb = 0
            salesRepIdDb = 0
            sessionTypeIdDb = 0
            custmetIdDb = 0
            
        } else {
            
            for  i in 0..<postingArray.count {
                
                lblVeteration.text = (postingArray.value(forKey: "vetanatrionName") as AnyObject).object(at: i) as? String
                lblDate.text = (postingArray.value(forKey: "sessiondate") as AnyObject).object(at: i) as? String
                lblCustmer.text = (postingArray.value(forKey: "customerName") as AnyObject).object(at: i) as? String
                CustRepTextField.text = (postingArray.value(forKey: "customerRepName") as AnyObject).object(at: i) as? String
                lblSelesRep.text = (postingArray.value(forKey: "salesRepName") as AnyObject).object(at: i) as? String
                lblSessionType.text = (postingArray.value(forKey: "sessionTypeName") as AnyObject).object(at: i) as? String
                lblComplex.text = (postingArray.value(forKey: "complexName") as AnyObject).object(at: i) as? String
                lblCocieeProgram.text = (postingArray.value(forKey: "cociiProgramName") as AnyObject).object(at: i) as? String
                notesTextView.text = (postingArray.value(forKey: "notes") as AnyObject).object(at: i) as? String
                
                let vetIdVal = (postingArray.value(forKey: "veterinarianId") as AnyObject).object(at: i) as? NSNumber
                let custmetIdDbVal = (postingArray.value(forKey: "customerId") as AnyObject).object(at: i) as? NSNumber
                let birdSizeIdDbVal = (postingArray.value(forKey: "birdSizeId") as AnyObject).object(at: i) as? NSNumber
                let breedIdDbVal = (postingArray.value(forKey: "birdBreedId") as AnyObject).object(at: i) as? NSNumber
                let salesRepIdDbVal = (postingArray.value(forKey: "salesRepId") as AnyObject).object(at: i) as? NSNumber
                let sessionTypeIdDbVal = (postingArray.value(forKey: "sessionTypeId") as AnyObject).object(at: i) as? NSNumber
                let postingIdDbVal = (postingArray.value(forKey: "postingId") as AnyObject).object(at: i) as? NSNumber
                let loginSessionIdDbVal = (postingArray.value(forKey: "loginSessionId") as AnyObject).object(at: i) as? NSNumber
                let complexIdDbVal = (postingArray.value(forKey: "complexId") as AnyObject).object(at: i) as? NSNumber
                let cocciProgramIdDbVal = (postingArray.value(forKey: "cocciProgramId") as AnyObject).object(at: i) as? NSNumber
                
                custmetIdDb = custmetIdDbVal!
                cusmerRepIdDb = 1
                birdSizeIdDb = birdSizeIdDbVal!
                breedIdDb = breedIdDbVal!
                salesRepIdDb = salesRepIdDbVal!
                sessionTypeIdDb = sessionTypeIdDbVal!
                veterinartionIdDb = vetIdVal!
                postingIdDb = postingIdDbVal!
                loginSessionIdDb = loginSessionIdDbVal!
                complexIdDb = complexIdDbVal!
                cocciProgramIdDb = cocciProgramIdDbVal!
            }
        }
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
            lblComplex.text =  UserDefaults.standard.value(forKey: "complexUnlinked") as? String
            lblDate.text =  UserDefaults.standard.value(forKey: "complexDateUnlinked") as? String
            
            if (UserDefaults.standard.value(forKey: "timeStamp") as? String) != nil{
                lblTimeStamp = lblTimestampUnlinked
            } else {
                let postingArr = CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(postingId as NSNumber)
                lblTimeStamp = (postingArr.object(at: 0) as AnyObject).value(forKey: "timeStamp") as! String
            }
            complexIdDb = unComplexId as NSNumber
            custmetIdDb = unCustId as NSNumber
            btnComplex.isUserInteractionEnabled = false
            btnDate.isUserInteractionEnabled = false
            sliderBtnOutlet.alpha = 0
            btnComplex.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.1)
            btnDate.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.1)
            doneButtonP.alpha = 1
            backButtonFronNec.alpha = 1
            nextButtonOutlet.alpha = 0
        } else {
            btnComplex.isUserInteractionEnabled = true
            btnDate.isUserInteractionEnabled = true
            doneButtonP.alpha = 0
            nextButtonOutlet.alpha = 1
            sliderBtnOutlet.alpha = 1
            backButtonFronNec.alpha = 0
        }
        if lngId == 5{
            
            addVacIcon.frame = CGRect(x: 130, y: 722, width: 20, height: 20)
            feedImagrIcon.frame = CGRect(x: 385, y: 723, width: 20, height: 20)
            if(CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId as NSNumber).count == 0){
                lblAddVacci.text = "Agregar vacunación"
            } else {
                lblAddVacci.text = "Editar vacunación"
            }
            lblFeed.text = "Programa de alimentación"
        } else {
            if(CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId as NSNumber).count == 0){
                lblAddVacci.text = "Add Vaccination"
                addVacIcon.frame = CGRect(x: 140, y: 722, width: 20, height: 20)
                feedImagrIcon.frame = CGRect(x: 430, y: 723, width: 20, height: 20)
            } else {
                lblAddVacci.text = "Edit Vaccination"
            }
            lblFeed.text = "Feed Program"
        }
        
        
    }
    /****************** Crteating Custom tableView ********************************/
    // MARK: - METHODS AND FUNCTIONS
    func tableViewpop()  {
        
        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonbg.addTarget(self, action: #selector(PostingVCTurkey.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.black.cgColor
        buttonbg.addSubview(droperTableView)
    }
    
    @objc func buttonPressed1() {
        buttonbg.removeFromSuperview()
    }
    
    func viewUpdate () {
        
        butttnTag  = 1
        dropImageView.isHidden = true
        
        let arrayAllBreed = CoreDataHandlerTurkey().fetchBreedTypeTurkey()
        
        let allBireType = CoreDataHandlerTurkey().fetchBirdSizeTurkey()
        if(birdArray.count == 0){
            
            for dict in allBireType {
                if (dict as AnyObject).value(forKey: "scaleType") as! String == "Imperial"{
                    birdArray.append(dict as! BirdSizePostingTurkey)
                    
                }
                else{
                    metricArray.append(dict as! BirdSizePostingTurkey)
                    
                }
            }
        }
        droperTableView.reloadData()
        feedProgramLbl.isHidden = true
        self.CustRepTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()
        self.CustRepTextField.delegate = self
        self.notesTextView.delegate = self
    }
    
    @objc func buttonPressedDroper() {
        buttonDroper.alpha = 0
    }
    
    
    
    func showAlert(){
        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Data will not be saved until you enter feed program. Click Yes to complete the session.", comment: ""), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        let okAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(self.postingId as NSNumber)
            CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(self.postingId as NSNumber)
            CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(self.postingId as NSNumber)
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "DashViewControllerTurkey") as? DashViewControllerTurkey
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
            
        }
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK:- Button Done and Cancel
    @objc func doneClick() {
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat="MM/dd/yyyy"
        //        dateFormatter2.calendar = Calendar(identifier: .gregorian)
        //        dateFormatter2.timeZone = TimeZone(secondsFromGMT: 0)
        let strdate = dateFormatter2.string(from: datePicker.date) as String
        
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat="MM/dd/yyyy/HH:mm:ss"
        //        dateFormatter3.calendar = Calendar(identifier: .gregorian)
        //        dateFormatter3.timeZone = TimeZone(secondsFromGMT: 0)
        let strdate1 = dateFormatter3.string(from: datePicker.date) as String
        
        lblDate.text = strdate
        lblTimeStamp = strdate1
        
        if  lblComplex.text! == NSLocalizedString("- Select -", comment: ""){
            
        }
        else {
            if checkComplexNameandDate(lblDate.text!, complexName: lblComplex.text!) == true {
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "Session for this date & complex already exists. Please select another date or complex.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.lblComplex.text = NSLocalizedString("- Select -", comment: "")
                    self.lblVeteration.text = NSLocalizedString("- Select -", comment: "")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                isClickOnAnyField = true
            }
        }
        
        UserDefaults.standard.set( lblDate.text, forKey: "date")
        UserDefaults.standard.set( lblTimeStamp, forKey: "timeStamp")
        UserDefaults.standard.synchronize()
        
        buttonBg1.removeFromSuperview()
    }
    @objc func cancelClick() {
        
        buttonBg1.removeFromSuperview()
    }
    
    @objc func buttonPressed() {
        
        buttonBg1.removeFromSuperview()
    }
    
    
    @IBOutlet weak var dropImageView: UIImageView!
    
    func checkComplexNameandDate(_ date : String, complexName: String) -> Bool {
        var isComplexandDateExist : Bool = false
        
        let postingSessionArray =  CoreDataHandlerTurkey().fetchAllPostingExistingSessionTurkey() as NSArray
        for i in 0..<postingSessionArray.count
        {
            let pSession = postingSessionArray.object(at: i) as! PostingSessionTurkey
            let sessionDate = pSession.sessiondate! as String
            let postingId = pSession.postingId! as! Int
            let sessioncomplexName = pSession.complexName! as String
            if postingId == UserDefaults.standard.integer(forKey: "postingId"){
                break
            }
            else {
                
                if (sessionDate == date) && (sessioncomplexName == complexName) {
                    
                    isComplexandDateExist = true
                    break
                }
            }
        }
        let necArray =  CoreDataHandlerTurkey().FetchNecropsystep1neccIdAllTurkey() as NSArray
        
        for i in 0..<necArray.count {
            
            let necSession = necArray.object(at: i) as! CaptureNecropsyDataTurkey
            let sessionDate = necSession.complexDate! as String
            let sessioncomplexName = necSession.complexName! as String
            if (sessionDate == date) && (sessioncomplexName == complexName) {
                
                isComplexandDateExist = true
                break
            }
        }
        
        return isComplexandDateExist
    }
    /******************************* Save Posting Data *************************************************************/
    
    func savePostingData () {
        
        if (lblVeteration.text == nil){
            lblVeteration.text = ""
            
        } else if (lblCocieeProgram.text == nil){
            lblCocieeProgram.text = ""
            
        } else if (lblComplex.text == nil){
            lblComplex.text = ""
            
        } else if (lblCustmer.text == nil){
            lblCustmer.text = ""
            
        } else if (CustRepTextField.text == nil){
            CustRepTextField.text = ""
            
        } else if (notesTextView.text == nil){
            notesTextView.text = ""
            
        } else if (lblSelesRep.text == nil){
            lblSelesRep.text = ""
            
        } else if (lblDate.text == nil){
            lblDate.text = ""
            
        } else if (lblSessionType.text == nil){
            lblSessionType.text = ""
        } else if (breedIdDb == 0){
            breedIdDb = 0
            
        } else if (birdSizeIdDb == 0){
            birdSizeIdDb = 0
            
        } else if (cocciProgramIdDb == 0){
            cocciProgramIdDb = 0
        } else if (complexIdDb == 0) {
            complexIdDb = 0
            
        } else if (cusmerRepIdDb == 0) {
            cusmerRepIdDb = 0
            
        } else if (salesRepIdDb == 0) {
            salesRepIdDb = 0
            
        } else if (sessionTypeIdDb == 0) {
            sessionTypeIdDb = 0
            
        }
        else if (veterinartionIdDb == 0) {
            veterinartionIdDb = 0
            
        }
        custRep.add( CustRepTextField.text!)
        
        UserDefaults.standard.set(custRep, forKey: "cust")
        
        CoreDataHandlerTurkey().postCustomerRepsTurkey(CustRepTextField.text!, userid: 1)
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            self.postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
        } else {
            self.postingId = UserDefaults.standard.integer(forKey: "postingId")
        }
        lblTimeStamp = self.timeStamp()
        ////check if posting id exist on posting session
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        
        CoreDataHandlerTurkey().PostingSessionDbTurkey("", birdBreesId:breedIdDb, birdbreedName: "", birdBreedType: "", birdSize:"", birdSizeId: birdSizeIdDb, cocciProgramId: cocciProgramIdDb, cociiProgramName: lblCocieeProgram.text!, complexId: complexIdDb, complexName: lblComplex.text!, convential:"", customerId: custmetIdDb, customerName:lblCustmer.text!, customerRepId: cusmerRepIdDb, customerRepName: CustRepTextField.text!, imperial: "", metric: "", notes: notesTextView.text, salesRepId: salesRepIdDb, salesRepName: lblSelesRep.text!, sessiondate:  lblDate.text!, sessionTypeId: sessionTypeIdDb, sessionTypeName: lblSessionType.text!, vetanatrionName: lblVeteration.text!, veterinarianId:veterinartionIdDb , loginSessionId: 1, postingId:  self.postingId as NSNumber,mail: "",female: "",finilize:0,isSync : true,timeStamp:lblTimeStamp,lngId:lngId as NSNumber,birdType:"Aync",birdTypeId:2,birdbreedId:0,capNec:0 , avgAge: avgAgeTxtFld.text! , avgWeight: avgWeightTxtFld.text! , outTime: outTimeTxtFld.text! , FCR: fcrTxtFld.text! , Livability: txtFldLivability.text! , mortality: txtFldMortality.text!)
        
        let postinSeesion =  CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(self.postingId  as NSNumber)
        
        let totalExustingArr = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        
        
        if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey(self.postingId as NSNumber, finalizeNec: 1)
            UserDefaults.standard.set(self.postingId, forKey: "postingId")
            UserDefaults.standard.synchronize()
            
        } else{
          //  UserDefaults.standard.set(lblTimeStamp, forKey: "deviceTokenStamp")
        }
    }
    
    func timeStamp()-> String{
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: "/", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String?
        let character: Character = "i"
        if ((string)?.contains(character))! {
            
        } else {
            let  udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
            
            let sessionGUID1 =   lblTimeStamp + "_" + String(describing: postingId as NSNumber)
            lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        }
        return lblTimeStamp
    }
    
    func callBreed(){
        print("Test Message",appDelegate.testFuntion())
    }
    
    /************** Delegate Method Of DropDown ***************************/
    
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        lblCustmer.text = contents
    }
    
    
    func GoToFeedprogramPage() {
        
        let isPostingId = UserDefaults.standard.bool(forKey: "ispostingIdIncrease")
        if isPostingId == false {
            
            let nec =  UserDefaults.standard.bool(forKey: "nec")
            
            if nec == true {
                let neciIdStep = UserDefaults.standard.integer(forKey: "necId")
                if neciIdStep == 0 {
                    
                    let postingIdwithNec = UserDefaults.standard.integer(forKey: "necIdIsZero")
                    
                    if postingIdwithNec>0 {
                        
                        postingId = postingIdwithNec+1
                    } else {
                        postingId = 1
                    }
                } else {
                    
                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
                    } else {
                        let postingArr = CoreDataHandlerTurkey().fetchAllPostingSessionWithNumberTurkey()
                        if neciIdStep == 0{
                            postingId = postingArr.count  + 1
                        } else {
                            
                            let necArr = CoreDataHandlerTurkey().FetchNecropsystep1AllNecIdWithPostingIDZeroTurkey()
                            postingId = necArr.count + postingArr.count + 1
                        }
                    }
                }
            }
            UserDefaults.standard.set(postingId, forKey: "necIdIsZero")
            UserDefaults.standard.set(postingId, forKey: "postingId")
            UserDefaults.standard.set(true, forKey: "ispostingIdIncrease")
            UserDefaults.standard.synchronize()
        }
        
        savePostingData()
        
        feedId = UserDefaults.standard.integer(forKey: "feedId")
        
        if appDelegate.sendFeedVariable == "Feed"{
            navStr = UserDefaults.standard.object(forKey: "back") as! String
            if navStr == "back" {
                let strVal = UserDefaults.standard.object(forKey: "feed0") as! String
                
                if feedId == 0 && strVal == "feed0" {
                    feedId = 0
                } else {
                    feedId = feedId+1
                }
            } else {
                if feedId == 0 {
                    feedId = feedId+1
                }
                else{
                    feedId = feedId+1
                }
            }
        } else {
            
            if feedId == -1 {
                feedId = 0
                UserDefaults.standard.set(1, forKey: "isFeed")
                UserDefaults.standard.synchronize()
            } else {
                feedId = feedId+1
            }
        }
        UserDefaults.standard.set(feedId, forKey: "feedId")
        UserDefaults.standard.synchronize()
        
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "FeedProgramVcTurkey") as? FeedProgramVcTurkey
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        
    }
    ////////////////////  Txt fields delegate /////////
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        self.touchesBegan(touches, with: event)
    }
    
    func animateView (_ movement : CGFloat){
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement);
        })
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    
    
    
    // MARK: - TABLE VIEW DATA SOURCE AND DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == autoSerchTable {
            
            return autocompleteUrls.count
        }
        else{
            switch btnTag {
            case 0:
                return custmerArray.count
            case 1:
                return SalesRepArr.count
            case 2:
                return sessionTypeArr.count
            case 3:
                return complexArr.count
            case 4:
                return CocoiiProgramArr.count
            case 5:
                if butttnTag == 0 {
                    return metricArray.count
                }
                else{
                    return birdArray.count
                }
            case 6:
                return 0
                // return breedArray.count
            case 7:
                //return breedArray.count
                return 0
                
                // return femaleArr.count
            case 8:
                return VetrationArr.count
            case 9:
                return feedProgramArray.count
                
                
            default:
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == autoSerchTable {
            let cell:UITableViewCell = (tableView.dequeueReusableCell(withIdentifier: "cell") as? UITableViewCell)!
            let cuatomerep : CustomerReprestativeTurkey = autocompleteUrls.object(at: indexPath.row) as! CustomerReprestativeTurkey
            
            cell.textLabel?.text = cuatomerep.customername
            cell.textLabel?.font = CustRepTextField.font
            return cell
            
        } else {
            let cell = UITableViewCell ()
            
            if btnTag == 0 {
                let customer : CustmerTurkey = custmerArray.object(at: indexPath.row) as! CustmerTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = customer.custName
                
            } else if btnTag == 1 {
                let salesRep : SalesrepTurkey = SalesRepArr.object(at: indexPath.row) as! SalesrepTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = salesRep.salesRepName
                
            } else if btnTag == 2 {
                let sessionArr : SessiontypeTurkey = sessionTypeArr.object(at: indexPath.row) as! SessiontypeTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = sessionArr.sesionType
                
            } else if btnTag == 3 {
                let cocoii : ComplexPostingTurkey = complexArr.object(at: indexPath.row) as! ComplexPostingTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = cocoii.complexName
                
                CoreDataHandlerTurkey().updatePostingSessionForNextButtonTurkey(postingId as NSNumber,antobotic: "", birdBreesId:breedIdDb, birdbreedName: "", birdBreedType: "", birdSize:"", birdSizeId: birdSizeIdDb, cocciProgramId: cocciProgramIdDb, cociiProgramName: lblCocieeProgram.text!, complexId: cocoii.complexId!, complexName: cocoii.complexName!, convential:"", customerId: custmetIdDb, customerName:lblCustmer.text!, customerRepId: cusmerRepIdDb, customerRepName: CustRepTextField.text!, imperial: "", metric: "", notes: notesTextView.text, salesRepId: salesRepIdDb, salesRepName: lblSelesRep.text!, sessiondate:  lblDate.text!, sessionTypeId: sessionTypeIdDb, sessionTypeName: lblSessionType.text!, vetanatrionName: lblVeteration.text!, veterinarianId:veterinartionIdDb , loginSessionId: 1,mail: "",female: "",finilize:0,isSync : true,timeStamp:lblTimeStamp,lngId:lngId as NSNumber,birdType:"",birdTypeId:2 , avgAge: avgAgeTxtFld.text! , avgWeight: avgWeightTxtFld.text! , outTime: outTimeTxtFld.text! , FCR: fcrTxtFld.text! , Livability: txtFldLivability.text! , mortality: txtFldMortality.text!)
                
            } else if btnTag == 4{
                
                let cocoii : CocciProgramPostingTurkey = CocoiiProgramArr.object(at: indexPath.row) as! CocciProgramPostingTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = cocoii.cocciProgramName
                
            } else if btnTag == 5 {
                
                if butttnTag == 0 {
                    
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = metricArray[indexPath.row].birdSize
                } else {
                    cell.selectionStyle = UITableViewCell.SelectionStyle.none
                    cell.textLabel!.text = birdArray[indexPath.row].birdSize
                }
                
            } else if btnTag == 6 {
                
            } else if btnTag == 7 {
                
                
            } else if btnTag == 8 {
                let vet : VeterationTurkey = VetrationArr.object(at: indexPath.row) as! VeterationTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet.vtName
                
            } else if btnTag == 9 {
                let vet : FeedProgramTurkey = feedProgramArray.object(at: indexPath.row) as! FeedProgramTurkey
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.textLabel!.text = vet.feddProgramNam
                
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == autoSerchTable {
            
        }
        else {
            if btnTag == 0 {
                let str = custmerArray[indexPath.row] as! CustmerTurkey
                lblCustmer.text = str.custName
                
                UserDefaults.standard.set( lblCustmer.text, forKey: "custmer")
                UserDefaults.standard.synchronize()
                custmetIdDb = str.custId!
                complexArr = CoreDataHandlerTurkey().fetchCompexTypePrdicateTurkey(str.custId!)
                isClickOnAnyField = true
            }
            else if btnTag == 1{
                let str = SalesRepArr[indexPath.row] as! SalesrepTurkey
                lblSelesRep.text = str.salesRepName
                salesRepIdDb = str.salesReptId!
                isClickOnAnyField = true
                
            } else if btnTag == 2 {
                let str = sessionTypeArr[indexPath.row] as! SessiontypeTurkey
                lblSessionType.text = str.sesionType
                
                sessionTypeIdDb = str.sesionId!
                isClickOnAnyField = true
                
            } else if btnTag == 4 {
                let str = CocoiiProgramArr[indexPath.row] as! CocciProgramPostingTurkey
                lblCocieeProgram.text = str.cocciProgramName
                cocciProgramIdDb = str.cocciProgramId!
                isClickOnAnyField = true
            } else if btnTag == 5 {
                
            }
            else if btnTag == 6{
                
            }
            else if btnTag == 7{
                
                isClickOnAnyField = true
            }
            else if btnTag == 8{
                let str = VetrationArr[indexPath.row] as! VeterationTurkey
                lblVeteration.text = str.vtName
                veterinartionIdDb = str.vetarId!
                isClickOnAnyField = true
                btnVetration.layer.borderColor = UIColor.black.cgColor
                
            }   else if btnTag == 3{
                let str = complexArr[indexPath.row] as! ComplexPostingTurkey
                lblComplex.text = str.complexName
                
                if checkComplexNameandDate(lblDate.text!, complexName: lblComplex.text!) == true {
                    
                    let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "Session for this date & complex already exists. Please select another date or complex.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        UIAlertAction in
                        self.lblComplex.text = NSLocalizedString("- Select -", comment: "")
                        self.lblVeteration.text = NSLocalizedString("- Select -", comment: "")
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }  else  {
                    UserDefaults.standard.set( lblComplex.text, forKey: "complex")
                    UserDefaults.standard.synchronize()
                    complexIdDb =  str.complexId!
                    UserDefaults.standard.set( Int(complexIdDb), forKey: "UnlinkComplex")
                    UserDefaults.standard.synchronize()
                    
                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        VetrationArr = CoreDataHandlerTurkey().fetchVetDataPrdicateTurkey(unComplexId as NSNumber)
                    }
                    else{
                        VetrationArr = CoreDataHandlerTurkey().fetchVetDataPrdicateTurkey(str.complexId!)
                    }
                    isClickOnAnyField = true
                }
            }  else if btnTag == 9 {
                let str = feedProgramArray[indexPath.row] as! FeedProgramTurkey
                feedProgramLbl.text = str.feddProgramNam
                
                if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                    UserDefaults.standard.set(true, forKey: "isUpadteFeedFromUnlinked")
                    UserDefaults.standard.synchronize()
                }
                else  {
                    UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
                    UserDefaults.standard.synchronize()
                }
                
                let feedProgramId = str.feedId!
                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "FeedProgramVcTurkey") as? FeedProgramVcTurkey
                
                mapViewControllerObj?.navigatePostingsession = "PostingFeedProgram"
                mapViewControllerObj?.feedPostingId = feedProgramId as! Int
                
                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                
            }
            buttonPressed1()
        }
    }
    
    
    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView ,indexValue : String){
        
        if indexValue == "Log Out" {
            
            UserDefaults.standard.removeObject(forKey: "login")
            if ConnectionManager.shared.hasConnectivity() {
                self.ssologoutMethod()
                CoreDataHandlerTurkey().deleteAllDataTurkey("CustmerTurkey")
            } else {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
            
            buttonbg.removeFromSuperview()
            customPopView1.removeView(view)
            
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
    
    
    func clickHelpPopUp() {
        
        buttonbg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg1.addTarget(self, action: #selector(PostingVCTurkey.buttonPressed1), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg1)
        
        customPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        customPopView1.logoutDelegate = self as! userLogOut
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1 .addSubview(customPopView1)
        customPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200, y: 60, width: 150, height: 60))
        
    }
    func buttonPressed11() {
        customPopView1.removeView(view)
        buttonbg1.removeFromSuperview()
    }
    
    // MARK: - TEXT FIELD DELEGATES
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if (textField == notesTextView ) {
            isClickOnAnyField = true
            
        } else {
            isClickOnAnyField = true
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == notesTextView ) {
            print("test message")
        } else {
            CustRepTextField.returnKeyType = UIReturnKeyType.done
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField.tag == 1101 {
            
            let ACCEPTED_CHARACTERS = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£"
            let set = CharacterSet(charactersIn: ACCEPTED_CHARACTERS)
            let inverted = set.inverted
            let filtered = string.components(separatedBy: inverted).joined(separator: "")
            let maxLength = 50
            let currentString: NSString = CustRepTextField.text as! NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength && filtered == string
            
            
        }else {
            
        }
        return true
    }
    
    func touchMoved() {
        appDelegate.testFuntion()
    }
    
    func touchBegan() {
        appDelegate.testFuntion()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        buttonDroper.alpha = 0
        autoSerchTable.alpha = 0
        view.endEditing(true)
        return true
    }
    
    // MARK: - IBACTION
    @IBAction func didselectonDonebutton(_ sender: AnyObject) {
        let farms = CoreDataHandlerTurkey().fetchNecropsystep1neccIdFeedProgramTurkey(postingId as NSNumber)
        if farms.count > 0 {
            let str : String
            if lngId == 5 {
                str =  "la (s) granja (s) no están conectadas. Navegue al programa de alimentación y conecte las granjas con el programa de alimentación."
            } else {
                str =  "farm(s) are not connected. Please navigate to Feed Program and connect the farms with the Feed Program."
            }
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("\(farms.count) \(str)", comment: ""))
            
            return
        }
        
        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        UserDefaults.standard.synchronize()
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "DashViewControllerTurkey") as? DashViewControllerTurkey
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        
    }
    @IBAction func bckButtonNec(_ sender: AnyObject) {
        let isPostingId = UserDefaults.standard.bool(forKey: "ispostingIdIncrease")
        feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        if feedProgramArray.count == 0{
            
            if lblVeteration.text != ""{
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Data will not be saved until you enter feed program. Click Yes to complete the session.", comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.cancel)
                let okAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.navigationController?.popViewController(animated: true)
                    return
                    
                }
                // Add the actions
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                // Present the controller
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                
                if (lblCustmer.text == NSLocalizedString("- Select -", comment: "") || lblComplex.text == NSLocalizedString("- Select -", comment: "") || lblVeteration.text == NSLocalizedString("- Select -", comment: "") ||  lblDate.text == NSLocalizedString("- Select Date -", comment: "") ) || isPostingId == false{
                    
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
        }
        let farms = CoreDataHandlerTurkey().fetchNecropsystep1neccIdFeedProgramTurkey(postingId as NSNumber)
        if farms.count > 0 {
            if feedProgramArray.count == 0 && isPostingId == false {
                self.navigationController?.popViewController(animated: true)
                return
            }
            else{
                if feedProgramArray.count == 0{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    let str : String
                    if lngId == 5 {
                        str =  "la (s) granja (s) no están conectadas. Navegue al programa de alimentación y conecte las granjas con el programa de alimentación."
                    }
                    else{
                        str =  "farm(s) are not connected. Please navigate to Feed Program and connect the farms with the Feed Program."
                    }
                    Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("\(farms.count) \(str)", comment: ""))
                    return
                }
            }
        }
        
        if (lblCustmer.text == NSLocalizedString("- Select -", comment: "") || lblComplex.text == NSLocalizedString("- Select -", comment: "") || lblVeteration.text == NSLocalizedString("- Select -", comment: "") || lblDate.text == NSLocalizedString("- Select Date -", comment: "") ) || isPostingId == false{
            
            self.navigationController?.popViewController(animated: true)
            
        }  else {
            let value  = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
            if value.count>0{
                self.navigationController?.popViewController(animated: true)
            }
            else {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please enter feed program.", comment: ""))
            }
        }
    }
    
    @IBAction func nextBtnAction(_ sender: AnyObject) {
        
        if (lblCustmer.text! == NSLocalizedString("- Select -", comment: "") ||
            lblComplex.text! == NSLocalizedString("- Select -", comment: "")
            || lblVeteration.text! == NSLocalizedString("- Select -", comment: "") || lblDate.text! == NSLocalizedString("- Select Date -", comment: "")){
            
            btnDate.layer.borderColor = UIColor.red.cgColor
            btnCustmer.layer.borderColor = UIColor.red.cgColor
            btnVetration.layer.borderColor = UIColor.red.cgColor
            btnComplex.layer.borderColor = UIColor.red.cgColor
            
            if lblCustmer.text != NSLocalizedString("- Select -", comment: "") {
                btnCustmer.layer.borderColor = UIColor.black.cgColor
            }
            if lblComplex.text != NSLocalizedString("- Select -", comment: "") {
                btnComplex.layer.borderColor = UIColor.black.cgColor
            }
            if birdSize.text != NSLocalizedString("- Select -", comment: "") {
            }
            if lblVeteration.text != NSLocalizedString("- Select -", comment: "") {
                btnVetration.layer.borderColor = UIColor.black.cgColor
            }
            if lblDate.text != NSLocalizedString("- Select Date -", comment: "") {
                btnDate.layer.borderColor = UIColor.black.cgColor
            }
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
            
        }  else  {
            CoreDataHandlerTurkey().updatePostingSessionForNextButtonTurkey(postingId as NSNumber,antobotic: "", birdBreesId:breedIdDb, birdbreedName: "", birdBreedType: "", birdSize:"", birdSizeId: birdSizeIdDb, cocciProgramId: cocciProgramIdDb, cociiProgramName: lblCocieeProgram.text!, complexId: complexIdDb, complexName: lblComplex.text!, convential:"", customerId: custmetIdDb, customerName:lblCustmer.text!, customerRepId: cusmerRepIdDb, customerRepName: CustRepTextField.text!, imperial: "", metric: "", notes: notesTextView.text, salesRepId: salesRepIdDb, salesRepName: lblSelesRep.text!, sessiondate:  lblDate.text!, sessionTypeId: sessionTypeIdDb, sessionTypeName: lblSessionType.text!, vetanatrionName: lblVeteration.text!, veterinarianId:veterinartionIdDb , loginSessionId: 1,mail: "",female: "",finilize:0,isSync : true,timeStamp:lblTimeStamp,lngId:lngId as NSNumber,birdType:"",birdTypeId:2 , avgAge: avgAgeTxtFld.text! , avgWeight: avgWeightTxtFld.text! , outTime: outTimeTxtFld.text! , FCR: fcrTxtFld.text! , Livability: txtFldLivability.text! , mortality: txtFldMortality.text!)
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "Step1Turkey") as? CaptureNecropsyStep1Turkey
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        }
    }
    
    @IBAction func sideMenuButtonPress(_ sender: AnyObject) {
        
        let isPostingId = UserDefaults.standard.bool(forKey: "ispostingIdIncrease")
        let value  = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        
        if value.count>0{
            NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
        }
        else {
            if lblCustmer.text != NSLocalizedString("- Select -", comment: "") || lblComplex.text != NSLocalizedString("- Select -", comment: "") || lblVeteration.text != NSLocalizedString("- Select -", comment: "") {
                self.showAlert()
            } else{
                NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
            }
        }
    }
    
    @IBAction func didSelectOnDateButton(_ sender: AnyObject) {
        
        view.endEditing(true)
        btnDate.layer.borderColor = UIColor.black.cgColor
        let buttons  = CommonClass.sharedInstance.pickUpDate()
        buttonBg1  = buttons.0
        buttonBg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonBg1.addTarget(self, action: #selector(PostingVCTurkey.buttonPressed), for: .touchUpInside)
        let donebutton : UIBarButtonItem = buttons.1
        donebutton.action =  #selector(PostingVCTurkey.doneClick)
        
        let cancelbutton : UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(PostingVCTurkey.cancelClick)
        datePicker = buttons.4
        self.view.addSubview(buttonBg1)
        
    }
    
    @IBAction func didSelectOnCustmerButton(_ sender: AnyObject) {
        
        btnCustmer.layer.borderColor = UIColor.black.cgColor
        view.endEditing(true)
        btnTag = 0
        if custmerArray.count == 0 {
            if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                custmerArray = CoreDataHandlerTurkey().fetchCustomerWithCustIdTurkey(unCustId as NSNumber)
            } else {
                custmerArray = CoreDataHandlerTurkey().fetchCustomerTurkey()
                lblComplex.text = NSLocalizedString("- Select -", comment: "")
                lblVeteration.text = NSLocalizedString("- Select -", comment: "")
            }
        } else {
            if UserDefaults.standard.bool(forKey: "Unlinked") == true{
            } else {
                lblVeteration.text = NSLocalizedString("- Select -", comment: "")
                lblComplex.text = NSLocalizedString("- Select -", comment: "")
            }
        }
        tableViewpop()
        if custmerArray.count < 3 {
            droperTableView.frame = CGRect( x: 236, y: 222  , width: 280, height: 120)
        } else {
            droperTableView.frame = CGRect( x: 236, y: 222, width: 280, height: 220)
        }
        droperTableView.reloadData()
    }
    
    @IBAction func didSelectSalesRepButton(_ sender: AnyObject) {
        view.endEditing(true)
        btnTag = 1
        
        if SalesRepArr.count == 0 {
            SalesRepArr = CoreDataHandlerTurkey().fetchSalesrepTurkey()
        }
        
        tableViewpop()
        
        if SalesRepArr.count < 3 {
            droperTableView.frame = CGRect( x: 237, y: 352, width: 280, height: 120)
        } else {
            droperTableView.frame = CGRect( x: 237, y: 352, width: 280, height: 220)
        }
        droperTableView.reloadData()
    }
    
    
    @IBAction func didSelectOnVaccinationProgram(_ sender: AnyObject) {
        
        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        UserDefaults.standard.synchronize()
        
        autoSerchTable.alpha = 0
        
        view.endEditing(true)
        
        if (lblCustmer.text! == NSLocalizedString("- Select -", comment: "") ||
            lblComplex.text! == NSLocalizedString("- Select -", comment: "")
            || lblVeteration.text! == NSLocalizedString("- Select -", comment: "") || lblVeteration.text! == "" || lblDate.text! == NSLocalizedString("- Select Date -", comment: "") || lblCustmer.text! == "" ||
            lblComplex.text! == ""
            || lblVeteration.text! == "" || lblVeteration.text! == "" || lblDate.text! == "" || lblDate.text == "- Seleccione fecha -"){
            
            btnDate.layer.borderColor = UIColor.red.cgColor
            
            btnCustmer.layer.borderColor = UIColor.red.cgColor
            
            btnVetration.layer.borderColor = UIColor.red.cgColor
            btnComplex.layer.borderColor = UIColor.red.cgColor
            
            if lblCustmer.text != NSLocalizedString("- Select -", comment: "") {
                
                btnCustmer.layer.borderColor = UIColor.black.cgColor
            }
            if lblComplex.text != NSLocalizedString("- Select -", comment: "") {
                
                btnComplex.layer.borderColor = UIColor.black.cgColor
            }
            
            
            
            if lblVeteration.text != NSLocalizedString("- Select -", comment: "") {
                btnVetration.layer.borderColor = UIColor.black.cgColor
            }
            let lngId = UserDefaults.standard.integer(forKey: "lngId")
            if lngId == 5{
                if  lblDate.text != "- Seleccione fecha -"{
                    btnDate.layer.borderColor = UIColor.black.cgColor
                }
            } else {
                if lblDate.text != NSLocalizedString("- Select Date -", comment: "") {
                    btnDate.layer.borderColor = UIColor.black.cgColor
                }
            }
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
            
        } else {
            let isPostingId = UserDefaults.standard.bool(forKey: "ispostingIdIncrease")
            if isPostingId == false {
                let nec =  UserDefaults.standard.bool(forKey: "nec")
                if nec == true {
                    
                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
                    } else {
                        
                        CoreDataHandlerTurkey().autoIncrementidtableTurkey()
                        let autoD  = CoreDataHandlerTurkey().fetchFromAutoIncrementTurkey()
                        postingId = autoD
                    }
                }
                UserDefaults.standard.set(postingId, forKey: "necIdIsZero")
                UserDefaults.standard.set(postingId, forKey: "postingId")
                UserDefaults.standard.set(true, forKey: "ispostingIdIncrease")
                UserDefaults.standard.synchronize()
                savePostingData()
            }  else {
                UserDefaults.standard.set(postingId, forKey: "postingId")
                UserDefaults.standard.synchronize()
            }
            
            if isClickOnAnyField == true && isPostingId == true {
                savePostingData()
                isClickOnAnyField = false
            }
            
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "AddVaccinationTurkey") as? AddVaccinationTurkey
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        }
        
    }
    
    @IBAction func didSelectonCociiProgramm(_ sender: UIButton) {
        autoSerchTable.alpha = 0
        
        view.endEditing(true)
        btnTag = 4
        
        if CocoiiProgramArr.count == 0 {
            CocoiiProgramArr = CoreDataHandlerTurkey().fetchCocoiiProgramTurkeyLngId(lngId:1)
        }
        
        tableViewpop()
        if CocoiiProgramArr.count < 3 {
            droperTableView.frame = CGRect( x: 713, y: 350, width: 270, height: 120)
        } else {
            droperTableView.frame = CGRect( x: 713, y: 350, width: 270, height: 220)
        }
        
        droperTableView.reloadData()
    }
    
    @IBAction func didSelectOnComplex(_ sender: AnyObject) {
        
        btnComplex.layer.borderColor = UIColor.black.cgColor
        view.endEditing(true)
        if lblCustmer.text == NSLocalizedString("- Select -", comment: "")  {
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select a customer first.", comment: ""))
        } else {
            
            btnTag = 3
            tableViewpop()
            
            if complexArr.count < 4 {
                
                droperTableView.frame = CGRect( x: 715, y: 220, width: 270, height: 130)
            } else {
                droperTableView.frame = CGRect( x: 715, y: 220, width: 270, height: 190)
            }
            droperTableView.reloadData()
        }
    }
    
    @IBAction func imperialBtnAction(_ sender: UIButton) {
        
        view.endEditing(true)
        if sender.isSelected == false {
            
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            imperialBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            metricBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
        }
        UserDefaults.standard.set(0, forKey: "birdIndex")  //Integer
        
    }
    
    @IBAction func metricBtnAction(_ sender: UIButton) {
        
        
        view.endEditing(true)
        if sender.isSelected == false {
            
            sender.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
            imperialBtnOutlet.setImage(UIImage(named: "Radio_Btn01")!, for: UIControl.State())
            metricBtnOutlet.setImage(UIImage(named: "Radio_Btn")!, for: UIControl.State())
        }
        UserDefaults.standard.set(1, forKey: "birdIndex")  //Integer
        
    }
    
    @IBAction func didSelectOnVeteration(_ sender: AnyObject) {
        
        if checkComplexNameandDate(lblDate.text!, complexName: lblComplex.text!) == true {
            
            if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                btnTag = 8
                tableViewpop()
                if VetrationArr.count < 4 {
                    
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 100)
                } else {
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 190)
                    
                }
                if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 190)
                    VetrationArr = CoreDataHandlerTurkey().fetchVetDataTurkey()
                }
                
                droperTableView.reloadData()
                
            } else {
                let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: "Session for this date & complex already exists. Please select another date or complex.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.lblComplex.text = ""
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            VetrationArr = CoreDataHandlerTurkey().fetchVetDataTurkey()
            btnVetration.layer.borderColor = UIColor.black.cgColor
            view.endEditing(true)
            if lblComplex.text == NSLocalizedString("- Select -", comment: "")  {
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please select a complex first.", comment: ""))
                
            } else {
                
                btnTag = 8
                tableViewpop()
                if VetrationArr.count < 4 {
                    
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 100)
                }  else {
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 190)
                    
                }
                if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                    droperTableView.frame = CGRect( x: 715, y: 285, width: 270, height: 190)
                    VetrationArr = CoreDataHandlerTurkey().fetchVetDataTurkey()
                }
                droperTableView.reloadData()
            }
        }
    }
    
    
    @IBAction func didSelectbtnSessionType(_ sender: AnyObject) {
        autoSerchTable.alpha = 0
        
        view.endEditing(true)
        btnTag = 2
        if sessionTypeArr.count == 0 {
            sessionTypeArr = CoreDataHandlerTurkey().fetchSessiontypeTurkeyLngId(lngId:1)
        }
        
        tableViewpop()
        if sessionTypeArr.count < 3 {
            
            droperTableView.frame = CGRect( x: 715, y: 155  , width: 270, height: 120)
        } else {
            droperTableView.frame = CGRect( x: 715, y: 152, width: 270, height: 200)
        }
        
        droperTableView.reloadData()
        
    }
    
    
    @IBAction func didSelectOnAddFeedProgram(_ sender: AnyObject) {
        
        UserDefaults.standard.set(false, forKey: "isUpadteFeedFromUnlinked")
        UserDefaults.standard.synchronize()
        autoSerchTable.alpha = 0
        view.endEditing(true)
        
        if (lblCustmer.text! == NSLocalizedString("- Select -", comment: "") ||
            lblComplex.text! == NSLocalizedString("- Select -", comment: "")
            || lblVeteration.text! == NSLocalizedString("- Select -", comment: "") || lblVeteration.text! == "" || lblDate.text! == NSLocalizedString("- Select Date -", comment: "") || lblCustmer.text! == "" ||
            lblComplex.text! == ""
            || lblVeteration.text! == "" || lblVeteration.text! == "" || lblDate.text! == "" || lblDate.text == "- Seleccione fecha -") {
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
            btnDate.layer.borderColor = UIColor.red.cgColor
            btnCustmer.layer.borderColor = UIColor.red.cgColor
            btnVetration.layer.borderColor = UIColor.red.cgColor
            btnComplex.layer.borderColor = UIColor.red.cgColor
            
            if lblCustmer.text != NSLocalizedString("- Select -", comment: "") {
                btnCustmer.layer.borderColor = UIColor.black.cgColor
            }
            if lblComplex.text != NSLocalizedString("- Select -", comment: "") {
                btnComplex.layer.borderColor = UIColor.black.cgColor
            }
            
            if lblVeteration.text != NSLocalizedString("- Select -", comment: "") {
                btnVetration.layer.borderColor = UIColor.black.cgColor
            }
            let lngId = UserDefaults.standard.integer(forKey: "lngId")
            if lngId == 5{
                if  lblDate.text != "- Seleccione fecha -"{
                    btnDate.layer.borderColor = UIColor.black.cgColor
                }
                if lblVeteration.text != NSLocalizedString("- Seleccione -", comment: "") {
                    btnVetration.layer.borderColor = UIColor.black.cgColor
                }
            }
            else{
                if lblDate.text != NSLocalizedString("- Select Date -", comment: "") {
                    btnDate.layer.borderColor = UIColor.black.cgColor
                }
            }
        } else {
            let isPostingId = UserDefaults.standard.bool(forKey: "ispostingIdIncrease")
            if isPostingId == false {
                let nec =  UserDefaults.standard.bool(forKey: "nec")
                
                if nec == true {
                    
                    if UserDefaults.standard.bool(forKey: "Unlinked") == true {
                        postingId = UserDefaults.standard.integer(forKey: "necUnLinked")
                    } else {
                        CoreDataHandlerTurkey().autoIncrementidtableTurkey()
                        let autoD  = CoreDataHandlerTurkey().fetchFromAutoIncrementTurkey()
                        
                        postingId = autoD
                    }
                }
                UserDefaults.standard.set(postingId, forKey: "necIdIsZero")
                UserDefaults.standard.set(postingId, forKey: "postingId")
                UserDefaults.standard.set(true, forKey: "ispostingIdIncrease")
                UserDefaults.standard.synchronize()
                savePostingData()
            }
            else if isClickOnAnyField == true && isPostingId == true {
                savePostingData()
                
                isClickOnAnyField = false
            }
            
            feedId = UserDefaults.standard.integer(forKey: "feedId")
            
            if appDelegate.sendFeedVariable == "Feed"{
                navStr = UserDefaults.standard.object(forKey: "back") as! String
                if navStr == "back" {
                    let strVal = UserDefaults.standard.object(forKey: "feed0") as! String
                    
                    if feedId == 0 && strVal == "feed0" {
                        feedId = 0
                    }
                    else{
                        feedId = feedId+1
                    }
                }  else {
                    if feedId == 0 {
                        feedId = feedId+1
                    }
                    else{
                        feedId = feedId+1
                    }
                }
            }  else {
                
                if feedId == -1 {
                    feedId = 0
                    UserDefaults.standard.set(1, forKey: "isFeed")
                    UserDefaults.standard.synchronize()
                }  else {
                    feedId = feedId+1
                }
            }
            UserDefaults.standard.set(feedId, forKey: "feedId")
            UserDefaults.standard.synchronize()
            
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "FeedProgramVcTurkey") as? FeedProgramVcTurkey
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        }
    }
    
    @IBAction func birdSizeAction(_ sender: AnyObject) {
        
        view.endEditing(true)
        btnTag = 5
        
        if butttnTag == 0 {
            
            tableViewpop()
            droperTableView.frame = CGRect( x: 715, y: 413, width: 276, height: 200)
            droperTableView.reloadData()
        } else {
            tableViewpop()
            
            droperTableView.frame = CGRect( x: 715, y: 413, width: 276, height: 200)
            droperTableView.reloadData()
        }
    }
    
    
    @IBAction func tapOnView(_ sender: AnyObject) {
        
        bgView.endEditing(true)
        hideDropDown()
    }
    
    @IBAction func back_bttn(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func feedProgramAction(_ sender: AnyObject) {
        view.endEditing(true)
        btnTag = 9
        feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
        
        if feedProgramArray.count<3 {
            tableViewpop()
            droperTableView.frame = CGRect( x: 400, y: 555, width: 280, height: 100)
            droperTableView.reloadData()
        } else {
            tableViewpop()
            droperTableView.frame = CGRect( x: 400, y: 555, width: 280, height: 160)
            droperTableView.reloadData()
        }
    }
    
    @IBAction func tapOnMainView(_ sender: AnyObject) {
        
        maineView.endEditing(true)
    }
    
    // MARK: - METHODS AND FUNCTIONS
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        
        let allPostingSessionArr = NSMutableArray()
        
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }
        
        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyDataTurkey
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }
        return allPostingSessionArr
    }
    
    
    func showExitAlertWith(msg: String,tag: Int) {
        
        exitPopUP = popUP.loadFromNibNamed("popUP") as! popUP
        exitPopUP.lblFedPrgram.text = msg
        exitPopUP.tag = tag
        exitPopUP.lblFedPrgram.textAlignment = .center
        exitPopUP.delegatenEW = self as! popUPnavigation
        exitPopUP.center = self.view.center
        self.view.addSubview(exitPopUP)
        
    }
    func noPopUpPosting() {
        if exitPopUP.tag == 40{
            
        }
        else if exitPopUP.tag == 50{
            
        }  else {
            if UserDefaults.standard.bool(forKey: "Unlinked") == true{
                // Update posting session
                feedProgramArray = CoreDataHandlerTurkey().FetchFeedProgramTurkey(postingId as NSNumber)
                if feedProgramArray.count<0{
                    CoreDataHandlerTurkey().updatePostingSessionOndashBoardTurkey(self.postingId as NSNumber, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
                    CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(self.postingId as NSNumber)
                    CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(self.postingId as NSNumber)
                }
            }
            else{
                CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(self.postingId as NSNumber)
                CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(self.postingId as NSNumber)
                CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(self.postingId as NSNumber)
            }
        }
        
        for dashboard in (self.navigationController?.viewControllers)! {
            if dashboard.isKind(of: DashViewController.self){
                self.navigationController?.popToViewController(dashboard, animated: true)
            }
        }
    }
    
    func YesPopUpPosting() {
        appDelegate.testFuntion()
    }
    
    //MARK -- Delegate SyNC Api
    
    func failWithError(statusCode:Int) {
        Helper.dismissGlobalHUD(self.view)
        
        if statusCode == 0 {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        } else {
            
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
                
            } else if lngId == 3 {
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
                
            }
        }
    }
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }
    
    func didFinishApi(){
        
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data sync has been completed.", comment: ""))
    }
    func failWithInternetConnection() {
        
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }
    
    // MARK: - TEXTVIEW DELEGATES
    func textViewShouldBeginEditing(_ _textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView == notesTextView ) {
            isClickOnAnyField = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (textView == notesTextView ) {
            let ACCEPTED_CHARACTERS = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789:;,/-_!@#$%*()-_=+[]\'<>.?/\\~`€£"
            let set = CharacterSet(charactersIn: ACCEPTED_CHARACTERS)
            let inverted = set.inverted
            let filtered = text.components(separatedBy: inverted).joined(separator: "")
            return filtered == text
        }
        return true
    }
}



