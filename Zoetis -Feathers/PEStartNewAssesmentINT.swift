//
//  PEStartNewAssessmentINT.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 09/01/23.
//  Copyright © 2023 . All rights reserved.
//
import Foundation
import SwiftyJSON
import UIKit
import CoreData

class PEStartNewAssessmentINT: BaseViewController {
    
    var extendedPESwitch = Bool()
    var inovoPESwitch = Bool()
    var basicPESwitch = Bool()
    var extendedPEInt : Int = 4
    var peHeaderViewController:PEHeaderViewController!
    var peNewAssessment:PENewAssessment!
    var scheduledAssessment:PENewAssessment?
    let dropdownManager = ZoetisDropdownShared.sharedInstance
    var jsonRe : JSON = JSON()
    var questionInfo : JSON = JSON()
    var isMovedForward = false
    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
    var infoImageDataResponse = InfoImageDataResponse(nil)
    var isFlockAgeGreaterTheAllProd : Bool = false
    var isFlockAgeGreaterThen50Weeks : Bool = false
    var constantToSave : String = "S"
    var selectedCountryId : Int = 0
    var selectedClorineId : Int = 0
    var isFromBack : Bool = false
    var firstLogin = false
    var isFromTextEditing = false
    
    @IBOutlet weak var clorineBtn: customButton!
    @IBOutlet weak var cameraiconimage: UIImageView!
    @IBOutlet weak var clorineTxtFld: PEFormTextfield!
    @IBOutlet weak var extendedPELbl: PEFormLabel!
    @IBOutlet weak var chlorineStripsSwitch: UISwitch!
    @IBOutlet weak var isAutomaticSwitch: UISwitch!
    @IBOutlet weak var extendedPEBtn: UIButton!
    @IBOutlet weak var notesTop: NSLayoutConstraint!
    @IBOutlet weak var flockAgeLbl: PEFormLabel!
    @IBOutlet weak var heightFlockAge: NSLayoutConstraint!
    @IBOutlet weak var topIncubation: NSLayoutConstraint!
    @IBOutlet weak var heightIncubation: NSLayoutConstraint!
    @IBOutlet weak var topBreed: NSLayoutConstraint!
    @IBOutlet weak var heightBreed: NSLayoutConstraint!
    @IBOutlet weak var selectedEvaluationDateText: UITextField!
    @IBOutlet weak var selectedCustomerText: UITextField!
    @IBOutlet weak var selectedSiteText: UITextField!
    @IBOutlet weak var selectedEvaluatorText: UITextField!
    @IBOutlet weak var selectedTSR: UITextField!
    @IBOutlet weak var selectedEvaluationType: UITextField!
    @IBOutlet weak var selectedVisitText: UITextField!
    @IBOutlet weak var siteButton: customButton!
    @IBOutlet weak var evaluatorButton: customButton!
    @IBOutlet weak var clorineViewHeightConstranit: NSLayoutConstraint!
    @IBOutlet weak var isAutomaticLocal: PEFormLabel!
    @IBOutlet weak var flockAgeLblConstraint: NSLayoutConstraint!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var visitButton: customButton!
    @IBOutlet weak var customerButton: customButton!
    @IBOutlet weak var evaluationTypeButton: customButton!
    @IBOutlet weak var manufacturerButton: customButton!
    @IBOutlet weak var txtManufacturer: PEFormTextfield!
    @IBOutlet weak var txtNumberOfEggs: PEFormTextfield!
    @IBOutlet weak var numberOfEggsButton: customButton!
    @IBOutlet weak var tsrButton: customButton!
    @IBOutlet weak var hatcherySwitch: UISwitch!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var cameraSwitch: UISwitch!
    @IBOutlet weak var evaluationDateButton: customButton!
    @IBOutlet weak var labelEvaluationDate: PEFormLabel!
    @IBOutlet weak var labelCustomer: PEFormLabel!
    @IBOutlet weak var labelSite: PEFormLabel!
    @IBOutlet weak var labelEvaluationType: PEFormLabel!
    @IBOutlet weak var labelReasonForVisit: PEFormLabel!
    @IBOutlet weak var labelApprover: PEFormLabel!
    @IBOutlet weak var labelEvaluator: PEFormLabel!
    @IBOutlet weak var btnNext: PESubmitButton!
    @IBOutlet weak var viewForGradient: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnFlockAgeGreater: UIButton!
    @IBOutlet weak var btnFlockImageLower: UIButton!
    @IBOutlet weak var flockView: UIView!
    @IBOutlet weak var flockAgeLower: UILabel!
    @IBOutlet weak var btnBreed: customButton!
    @IBOutlet weak var btnBreedOthers: customButton!
    @IBOutlet weak var btnIncubation: customButton!
    @IBOutlet weak var txtBreedOfBird: PEFormTextfield!
    @IBOutlet weak var txtBreedOfBirdsOthers: PEFormTextfield!
    @IBOutlet weak var txtIncubation: PEFormTextfield!
    @IBOutlet weak var manfacturerOtherBtn: customButton!
    @IBOutlet weak var manfacturerOtherTxt: PEFormTextfield!
    @IBOutlet weak var eggsOtherBtn: customButton!
    @IBOutlet weak var eggsOtherTxt: PEFormTextfield!
    @IBOutlet weak var heightManufacturerView: NSLayoutConstraint!
    @IBOutlet weak var heightNumberOfEggsView: NSLayoutConstraint!
    @IBOutlet weak var isAutomaticFailView: UIView!
    @IBOutlet weak var isAutomaticHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var isAutomaticWidth: NSLayoutConstraint!
    @IBOutlet weak var labelCountry: PEFormLabel!
    @IBOutlet weak var countryBtn: customButton!
    @IBOutlet weak var countryTxt: PEFormTextfield!
    @IBOutlet weak var otherManuHeightConst: NSLayoutConstraint!
    @IBOutlet weak var otherEggsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var breedOtherView: UIView!
    @IBOutlet weak var manufactureOtherView: UIView!
    @IBOutlet weak var btnIncubationOthers: customButton!
    @IBOutlet weak var txtIncubationOthers: PEFormTextfield!
    @IBOutlet weak var otherBreedLbl: PEFormLabel!
    @IBOutlet weak var otherManuLbl: PEFormLabel!
    @IBOutlet weak var allProductionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var allProductionLbl: PEFormLabel!
    @IBOutlet weak var inovoBtn: UIButton!
    @IBOutlet weak var basicNewBtn: UIButton!
    var regionID = Int()
    
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        
        setupUI()
        setUpDidLoad()
        setEvaluationType()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.isHidden = true
        if self.peNewAssessment.hatcheryAntibiotics == 1{
            self.hatcherySwitch.isOn = true//hatcherySwitch.isOn
        } else{
            self.hatcherySwitch.isOn = false
        }
        
        let peDetails = PEInfoDAO.sharedInstance.fetchInfoMoObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment.serverAssessmentId ?? "")
        if scheduledAssessment?.sanitationEmbrex == nil{
            self.peNewAssessment.sanitationEmbrex = peDetails[0].isExtendedPE as? Int
        }
        if peNewAssessment.sanitationEmbrex == 1{
            showExtendedPE(flag: false)
            extendedPESwitch = true
            enableExtendedPE(flag: false)
            extendedPEBtn.setImage(UIImage(named: "checkIconPE"), for: .normal)
            Constants.isExtendedPopup = false
            PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: true, assessmentId: peNewAssessment?.serverAssessmentId ?? "", date: nil)
        }else{
            showExtendedPE(flag: false)
            extendedPESwitch = false
            extendedPEBtn.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            enableExtendedPE(flag: true)
            Constants.isExtendedPopup = true
            PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: false, assessmentId: peNewAssessment?.serverAssessmentId ?? "", date: nil)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isMovedForward{
            isMovedForward = false
            ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0].peNewAssessment = peNewAssessment
        }else{
            let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
            let pradicate = NSPredicate(format: "userID == %d AND serverAssessmentId == %@", userID, peNewAssessment.serverAssessmentId ?? "")
            CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentInProgress", predicate: pradicate)
        }
    }
    
    private func setupUI(){
        
        let btns = [customerButton,siteButton,evaluatorButton,visitButton,evaluationTypeButton,tsrButton,evaluationDateButton,btnBreed,btnBreedOthers,btnIncubation,manufacturerButton,numberOfEggsButton,countryBtn ,manfacturerOtherBtn,eggsOtherBtn , clorineBtn]
        
        DispatchQueue.main.async {
            self.btnNext.setNextButtonUI()
            self.viewForGradient.setGradientThreeColors(topGradientColor: UIColor.getGradientUpperColorStartAssessment(),midGradientColor:UIColor.getGradientUpperColorStartAssessmentMid(), bottomGradientColor: UIColor.getGradientUpperColorStartAssessmentLast())
            self.viewForGradient.setCornerRadiusFloat(radius: 23)
            
            self.customerButton.isUserInteractionEnabled = false
            self.siteButton.isUserInteractionEnabled = false
            self.evaluatorButton.isUserInteractionEnabled = false
            self.countryBtn.isUserInteractionEnabled = false
            self.customerButton.isEnabled = false
            self.siteButton.isEnabled = false
            self.evaluatorButton.isEnabled = false
            self.visitButton.isUserInteractionEnabled = false
            self.selectedCustomerText.alpha = 0.6
            self.selectedSiteText.alpha = 0.6
            self.selectedEvaluatorText.alpha = 0.6
            self.countryTxt.alpha = 0.6
            self.selectedVisitText.alpha = 0.6
            
            if self.isFromBack {
                self.evaluationTypeButton.isUserInteractionEnabled = false
                self.evaluationTypeButton.isEnabled = false
                self.selectedEvaluationType.alpha = 0.6
                self.evaluationDateButton.isUserInteractionEnabled = false
                self.evaluationDateButton.isEnabled = false
                self.selectedEvaluationDateText.alpha = 0.6
                
            }
            
            for btn in btns{
                btn?.setTitle("", for: .normal)
                let superviewCurrent =  btn?.superview
                if superviewCurrent != nil {
                    for view in superviewCurrent!.subviews {
                        if  view.isKind(of:UIButton.self) {
                            if view == self.evaluationDateButton{
                                view.setDropdownStartAsessmentView(imageName:"calendarIconPE")
                            } else{
                                view.setDropdownStartAsessmentView(imageName:"dd")
                            }
                        }
                    }
                }
            }
            self.notesTextView.layer.cornerRadius = 12
            self.notesTextView.layer.masksToBounds = true
            self.notesTextView.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
            self.notesTextView.layer.borderWidth = 2.0
            
            
        }
        
    }
    
    /* Manually assign constraints */
    // MARK: - Manually assign constraints
    func assignConstraint(otherEgg:Int = 0){
        let leftConst = leftConstraint()
        var rightConst = rightConstraint() //+ otherEgg
        if rightConst == 3 {
            rightConst = 2
        }
        
        switch leftConst {
        case 0:
            
            switch rightConst {
            case 1:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40 ))
                }
            default:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 100))
                }
            }
        case 1:
            switch rightConst {
            case 1:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 10))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40 ))
                }
            case 2:
                notesTop.constant = CGFloat(((leftConst * 55 ) - 50))
            default:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 30))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 85))
                }
            }
        case 2:
            switch rightConst {
            case 1:
                if heightNumberOfEggsView.constant == 94{
                    if heightManufacturerView.constant == 94{
                        notesTop.constant = CGFloat(((leftConst * 55 ) - 55))
                    }else{
                        notesTop.constant = CGFloat(((leftConst * 55 ) - 25))
                    }
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 10))
                }
            case 2:
                notesTop.constant = CGFloat(((leftConst * 55 ) - 35))
            default:
                if heightNumberOfEggsView.constant == 94{
                    
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 10))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40))
                }
            }
        default:
            break;
        }
    }
    
    /* Manually left assign constraints */
    // MARK: - Manually left assign constraints
    func leftConstraint() -> Int{
        var otherCount = 0
        if peNewAssessment.breedOfBird == "Other"{
            otherCount += 1
        }
        if peNewAssessment.evaluationID != nil && peNewAssessment.evaluationID == 1{
            otherCount += 1
        }
        return otherCount
    }
    
    /* Manually right assign constraints */
    // MARK: - Manually right assign constraints
    func rightConstraint() -> Int{
        var otherCount = 0
        
        if (( self.txtManufacturer.text?.lowercased().contains("other")) ?? false) {
            otherCount += 1
        }
        let xx = String(self.peNewAssessment.noOfEggs ?? 000)
        if xx != "0" {
            let last3 = String(xx.suffix(3))
            if last3 ==  "000" {
                let str =  xx.replacingOccurrences(of: "000", with: "")
                eggsOtherTxt.text = str
                txtNumberOfEggs.text = "Other"
            }
        }
        return otherCount
    }
    
    // MARK: - Set Evaluation type
    private func setEvaluationType()
    {
        var evaluationIDArray = NSArray()
        var evaluationNameArray = NSArray()
        let evaluationDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_EvaluationType")
        evaluationNameArray = evaluationDetailsArray.value(forKey: "evaluationName") as? NSArray ?? NSArray()
        evaluationIDArray = evaluationDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  evaluationNameArray.count > 0 {
            
            self.selectedEvaluationType.text =  evaluationNameArray[0] as? String
            self.isFlockAgeGreaterTheAllProd = false
            self.isFlockAgeGreaterThen50Weeks  = false
            self.btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            self.btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            self.showFlockView()
            
            self.allProductionViewHeightConstraint.constant = 60
            self.flockAgeLower.isHidden = false
            self.btnFlockImageLower.isHidden = false
            self.flockAgeLbl.text = "Breeder Flock Age of Eggs Injected*"
            
            self.peNewAssessment.evaluationName = evaluationNameArray[0] as? String //selectedVal
            self.peNewAssessment.evaluationID = evaluationIDArray[0] as! Int
            self.evaluationTypeButton.isUserInteractionEnabled = false
            self.selectedEvaluationType.alpha = 0.6
            
            if self.peNewAssessment.evaluationID != nil && self.peNewAssessment.evaluationID == 1{
                
            }else{
                let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                
                let hasSelectedExtendedPE = infoObj?.isExtendedPE ?? false
                if hasSelectedExtendedPE{
                    
                }
            }
            
            self.checkBackAndSave()
            
        }
    }
    
    // MARK: - Setup UI
    private func setUpDidLoad(){
        self.manfacturerOtherTxt.delegate = self
        self.eggsOtherTxt.delegate = self
        self.eggsOtherTxt.keyboardType = .numberPad
        self.txtBreedOfBirdsOthers.delegate = self
        
        let dateFormatter = DateFormatter()
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
       // let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3 {
            dateFormatter.dateFormat = "dd/MM/yyyy"
//            dateFormatter.calendar = Calendar(identifier: .gregorian)
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        else{
            dateFormatter.dateFormat="MM/dd/yyyy"
//            dateFormatter.calendar = Calendar(identifier: .gregorian)
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        let currentDate: NSDate = NSDate()
        let strdate1 = dateFormatter.string(from: scheduledAssessment?.scheduledDate ?? Date()) as String
        self.cameraSwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        self.hatcherySwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        peHeaderViewController = PEHeaderViewController()
        peHeaderViewController.titleOfHeader = "Assessment"
        
        isAutomaticFailView.isHidden = true
        isAutomaticSwitch.isHidden = true
        self.headerView.addSubview(peHeaderViewController.view)
        self.topviewConstraint(vwTop: peHeaderViewController.view)
        notesTextView.delegate = self
        notesTextView.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
        notesTextView.textContainer.lineFragmentPadding = 12
        notesTextView.text = ""
        peNewAssessment = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject(serverAssessmentId:scheduledAssessment?.serverAssessmentId ?? "",createNewObject:true)
        peNewAssessment.evaluatorID = scheduledAssessment?.evaluatorID
        peNewAssessment.evaluatorName = scheduledAssessment?.evaluatorName
        if peNewAssessment.serverAssessmentId == nil{
            peNewAssessment.visitName = scheduledAssessment?.visitName
            peNewAssessment.visitID = scheduledAssessment?.visitID
            peNewAssessment.notes = scheduledAssessment?.notes
            peNewAssessment.customerName = scheduledAssessment?.customerName
            peNewAssessment.customerId = scheduledAssessment?.customerId
            peNewAssessment.siteId = scheduledAssessment?.siteId
            peNewAssessment.sanitationEmbrex = scheduledAssessment?.sanitationEmbrex
            peNewAssessment.statusType = 3
            peNewAssessment.siteName = scheduledAssessment?.siteName
            peNewAssessment.serverAssessmentId = scheduledAssessment?.serverAssessmentId
            peNewAssessment.evaluationDate = strdate1
            peNewAssessment.countryName = scheduledAssessment?.countryName
            peNewAssessment.countryID = scheduledAssessment?.countryID
            peNewAssessment.fluid = scheduledAssessment?.fluid ?? false
            peNewAssessment.basicTransfer = scheduledAssessment?.basicTransfer ?? false
            peNewAssessment.extndMicro = scheduledAssessment?.extndMicro ?? false
            peNewAssessment.refrigeratorNote = scheduledAssessment?.refrigeratorNote ?? ""
            peNewAssessment.clorineName = scheduledAssessment?.clorineName
            peNewAssessment.clorineId = scheduledAssessment?.clorineId
        }
        
        if let selectedTSRID = scheduledAssessment?.selectedTSRID{
            peNewAssessment.selectedTSRID = selectedTSRID
        }
        if let selectedTSR = scheduledAssessment?.selectedTSR{
            if selectedTSR != ""{
                peNewAssessment.selectedTSR = selectedTSR
            }
        }
        
        peNewAssessment.serverAssessmentId = scheduledAssessment?.serverAssessmentId
        notesTextView.text =  peNewAssessment.notes
        selectedCustomerText.text = peNewAssessment.customerName
        selectedSiteText.text =  peNewAssessment.siteName
        countryTxt.text = peNewAssessment.countryName
        selectedCountryId = peNewAssessment.countryID ?? 0
        clorineTxtFld.text = peNewAssessment.clorineName
        selectedClorineId = peNewAssessment.clorineId ?? 0
        peNewAssessment.fluid =  scheduledAssessment?.fluid
        peNewAssessment.basicTransfer = scheduledAssessment?.basicTransfer
        peNewAssessment.countryName = scheduledAssessment?.countryName
        peNewAssessment.countryID = scheduledAssessment?.countryID
        peNewAssessment.refrigeratorNote = scheduledAssessment?.refrigeratorNote
        inovoPESwitch = peNewAssessment.fluid ?? false
        basicPESwitch = peNewAssessment.basicTransfer ?? false
        extendedPESwitch = peNewAssessment.extndMicro ?? false
        peNewAssessment.clorineName = scheduledAssessment?.clorineName
        peNewAssessment.clorineId = scheduledAssessment?.clorineId
        
        if inovoPESwitch == false {
            inovoBtn.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }
        else{
            inovoBtn.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        
        if basicPESwitch == false {
            basicNewBtn.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }else{
            basicNewBtn.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        
        var defautUsername =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        let LastName =  UserDefaults.standard.value(forKey: "LastName") as? String ?? ""
        defautUsername = defautUsername + LastName
        if peNewAssessment.evaluationDate == "" {
            selectedEvaluationDateText.text = strdate1
            self.peNewAssessment.evaluationDate = strdate1
        } else {
            selectedEvaluationDateText.text = peNewAssessment.evaluationDate ?? strdate1
        }
        self.peNewAssessment.evaluationID = peNewAssessment.evaluationID
        selectedEvaluatorText.text =  peNewAssessment.evaluatorName ?? defautUsername
        selectedEvaluationType.text = peNewAssessment.evaluationName ?? ""
        if let character = peNewAssessment.breedOfBird?.character(at: 1) {
            if character == constantToSave.character(at: 0){
                showBreedOthers()
                let str =  peNewAssessment.breedOfBird?.replacingOccurrences(of: constantToSave, with: "")
                txtBreedOfBirdsOthers.text = str
                txtBreedOfBird.text = "Other"
            }
        }
        if peNewAssessment.breedOfBird == "Other"{
            showBreedOthers()
        } else {
            hideBreedOthers()
        }
        txtBreedOfBird.text = self.peNewAssessment.breedOfBird
        if let character = peNewAssessment.breedOfBird?.character(at: 1) {
            
            if character == constantToSave.character(at: 0){
                showBreedOthers()
                let str =  peNewAssessment.breedOfBird?.replacingOccurrences(of: constantToSave, with: "")
                txtBreedOfBirdsOthers.text = str
                txtBreedOfBird.text = "Other"
            }
        }
        txtBreedOfBirdsOthers.text =    self.peNewAssessment.breedOfBirdOther
        txtIncubation.text =  self.peNewAssessment.incubation
        if self.peNewAssessment.manufacturer?.count ?? "".count > 0 {
            txtManufacturer.text = self.peNewAssessment.manufacturer
        }
        if self.peNewAssessment.noOfEggs ?? 0 > 0 {
            txtNumberOfEggs.text = String(self.peNewAssessment.noOfEggs ?? 0)
        }
        if selectedEvaluationType.text == "" {
            hideFlockView()
        } else {
            if selectedEvaluationType.text?.contains("Non") ?? false  {
                self.flockAgeLower.isHidden = true
                self.btnFlockImageLower.isHidden = true
                self.flockAgeLbl.text = "Breeder Flock Age of Eggs Injected"
            } else {
                self.flockAgeLower.isHidden = false
                self.btnFlockImageLower.isHidden = false
                self.flockAgeLbl.text = "Breeder Flock Age of Eggs Injected*"
            }
            showFlockView()
        }
        
        selectedVisitText.text =  peNewAssessment.visitName ?? ""
        if peNewAssessment.camera == 1{
            cameraSwitch.setOn(true, animated: false)
        } else {
            cameraSwitch.setOn(false, animated: false)
        }
        
        if peNewAssessment.hatcheryAntibiotics == 1{
            hatcherySwitch.setOn(true, animated: false)
        } else {
            hatcherySwitch.setOn(false, animated: false)
        }
        
        labelEvaluationDate.addLabelWithAstric(placeHolder: "Evaluation Date")
        labelCustomer.addLabelWithAstric(placeHolder: "Customer")
        labelSite.addLabelWithAstric(placeHolder: "Site")
        labelEvaluationType.addLabelWithAstric(placeHolder: "Evaluation Type")
        labelReasonForVisit.addLabelWithAstric(placeHolder: "Reason for visit")
        labelEvaluator.addLabelWithAstric(placeHolder: "Evaluator")
        
        var FirstName =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        FirstName = FirstName + " " + LastName
        peNewAssessment.evaluatorName =  FirstName
        
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        peNewAssessment.evaluatorID = userID
        if peNewAssessment.selectedTSR?.count ?? 0 > 1 {
            selectedTSR.text = peNewAssessment.selectedTSR
        }
        
        hideManufacturerOthers()
        hideEggsOthers()
        if peNewAssessment.manufacturer == "Other"{
            showManufacturerOthers()
        } else {
            hideManufacturerOthers()
        }
        
        txtManufacturer.text = self.peNewAssessment.manufacturer ?? ""
        if  txtManufacturer.text != "" {
            if let character = peNewAssessment.manufacturer?.character(at:0) {
                if txtManufacturer.text?.contains("Other") ?? false{
                    showManufacturerOthers()
                }
                if character == constantToSave.character(at: 0){
                    showManufacturerOthers()
                    let str =  peNewAssessment.manufacturer?.replacingOccurrences(of: constantToSave, with: "")
                    manfacturerOtherTxt.text = str
                    txtManufacturer.text = "Other"
                }
            }
        }
        let xx = String(self.peNewAssessment.noOfEggs ?? 000)
        if xx != "0" {
            let last3 = String(xx.suffix(3))
            if last3 ==  "000" {
                showEggsOthers()
                let str =  xx.replacingOccurrences(of: "000", with: "")
                eggsOtherTxt.text = str
                txtNumberOfEggs.text = "Other"
            }
        }
        
        txtBreedOfBird.text = self.peNewAssessment.breedOfBird
        if let character = peNewAssessment.breedOfBird?.character(at: 1) {
            if character == constantToSave.character(at: 0){
                showBreedOthers()
                let str =  peNewAssessment.breedOfBird?.replacingOccurrences(of: constantToSave, with: "")
                txtBreedOfBirdsOthers.text = str
                txtBreedOfBird.text = "Other"
            }
        }
        txtBreedOfBirdsOthers.text =    self.peNewAssessment.breedOfBirdOther
        getSubmittedAssessmentorEggsAndIncubation()
        
        if peNewAssessment.isFlopSelected == 1 ||  peNewAssessment.isFlopSelected == 3 ||  peNewAssessment.isFlopSelected == 4 {
            
            DispatchQueue.main.async {
                self.isFlockAgeGreaterTheAllProd = true
                self.btnFlockAgeGreater.setImage(UIImage(named: "checkIconPE"), for: .normal)
                self.btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
                self.isFlockAgeGreaterThen50Weeks = false
            }
            
        } else  if peNewAssessment.isFlopSelected == 2 ||  peNewAssessment.isFlopSelected == 5  {
            DispatchQueue.main.async {
                self.isFlockAgeGreaterTheAllProd = false
                self.btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
                self.isFlockAgeGreaterThen50Weeks = true
                self.btnFlockImageLower.setImage(UIImage(named: "checkIconPE"), for: .normal)
            }
            
        }
        
        let  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        for obj in peNewAssessmentArray {
            let assessment = obj
            let imageCount = assessment.images
            if imageCount.count > 0 {
                cameraSwitch.isUserInteractionEnabled = false
                cameraSwitch.alpha = 0.6
            }
        }
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        
        if !Constants.isFirstTime{
            if peNewAssessment.clorineName == "" || peNewAssessment.clorineName == nil  {
                
                self.isAutomaticSwitch.setOn(false, animated: false)
                isAutomaticFailView.isHidden = true
                clorineViewHeightConstranit.constant = 60
                isAutomaticSwitch.isHidden = true
                
            }else{
                
                if peNewAssessment.isAutomaticFail == 1{
                    self.isAutomaticSwitch.setOn(true, animated: false)
                    isAutomaticFailView.isHidden = false
                    isAutomaticSwitch.isHidden = false
                    clorineViewHeightConstranit.constant = 120
                    
                }else{
                    self.isAutomaticSwitch.setOn(false, animated: false)
                    isAutomaticFailView.isHidden = false
                    isAutomaticSwitch.isHidden = false
                    clorineViewHeightConstranit.constant = 120
                }
            }
        }else{
            
            peNewAssessment.isChlorineStrip = 1
            
            if clorineTxtFld.text == ""  {
                clorineViewHeightConstranit.constant = 60
                isAutomaticFailView.isHidden = true
                isAutomaticSwitch.isHidden = true
            }
            else{
                clorineViewHeightConstranit.constant = 120
                isAutomaticFailView.isHidden = false
                isAutomaticSwitch.isHidden = false
                
                if peNewAssessment.isAutomaticFail == 1{
                    self.isAutomaticSwitch.setOn(true, animated: false)
                    peNewAssessment.isAutomaticFail = 1
                }
                
                else
                {
                    self.isAutomaticSwitch.setOn(false, animated: false)
                    peNewAssessment.isAutomaticFail = 0
                }
            }
            
        }
        
        if peNewAssessment.evaluationID != nil{
            if peNewAssessment.evaluationID == 1{
                if infoObj != nil{
                    extendedPESwitch =  infoObj?.isExtendedPE ?? false
                }else{
                    
                }
                
            }else{
            }
        }else{
            print("test message")
        }
        checkBackAndSave()
        
        if peNewAssessment.selectedTSRID == nil || peNewAssessment.selectedTSRID == 0{
            tsrButton.isUserInteractionEnabled = true
            selectedTSR.alpha = 1
        } else {
            selectedTSR.text = peNewAssessment.selectedTSR
            tsrButton.isUserInteractionEnabled = false
            selectedTSR.isUserInteractionEnabled = false
            selectedTSR.alpha = 0.6
        }
        
    }
    
    /* Extended PE scope */
    // MARK: - Extended PE scope
    func showExtendedPE(flag:Bool = false){
        extendedPELbl.isHidden = flag
        extendedPEBtn.isHidden = flag
    }
    
    func enableExtendedPE(flag:Bool = true){
        print("Test Message",appDelegate.testFuntion())
    }
    
    /* Get offline stored session(Eggs and Incubation) */
    // MARK: - Get offline stored session(Eggs and Incubation)
    private func getSubmittedAssessmentorEggsAndIncubation() {
        var submitedAssess : PENewAssessment = PENewAssessment()
        let offlineSubmitedArray  = CoreDataHandlerPE().getSessionForViewAssessmentArrayPEObject(ofCurrentAssessment:true)
        if offlineSubmitedArray.count > 0 {
            for obj in offlineSubmitedArray {
                submitedAssess = obj
            }
            if  txtManufacturer.text  == "" {
                txtManufacturer.text = submitedAssess.manufacturer ?? ""
                if  txtManufacturer.text != "" {
                    if let character = submitedAssess.manufacturer?.character(at:0) {
                        if character == constantToSave.character(at: 0){
                            showManufacturerOthers()
                            let str =  submitedAssess.manufacturer?.replacingOccurrences(of: constantToSave, with: "")
                            manfacturerOtherTxt.text = str
                            txtManufacturer.text = "Other"
                        }
                    }
                }
            }
            if txtManufacturer.text  == "Other"{
                showManufacturerOthers()
            }else{
                hideManufacturerOthers()
            }
            if  txtNumberOfEggs.text == "" {
                if submitedAssess.noOfEggs ?? 0 > 0 {
                    txtNumberOfEggs.text = String(submitedAssess.noOfEggs ?? 0)
                }
                let xx = String(submitedAssess.noOfEggs ?? 000)
                if xx != "0" {
                    let last3 = String(xx.suffix(3))
                    if last3 ==  "000" {
                        showEggsOthers()
                        let str =  xx.replacingOccurrences(of: "000", with: "")
                        eggsOtherTxt.text = str
                        txtNumberOfEggs.text = "Other"
                    }
                }
            }
            if txtNumberOfEggs.text  == "Other"{
                showEggsOthers()
            }else{
                hideEggsOthers()
            }
            if  txtIncubation.text == "" {
                txtIncubation.text =  submitedAssess.incubation
            }
            self.peNewAssessment.incubation = txtIncubation.text
            if txtNumberOfEggs.text  == "Other"{
                self.peNewAssessment.noOfEggs = Int64((eggsOtherTxt.text ?? "") + "000")
            }else{
                self.peNewAssessment.noOfEggs = Int64(txtNumberOfEggs.text ?? "")
            }
            if txtManufacturer.text  == "Other"{
                self.peNewAssessment.manufacturer = "S" + (manfacturerOtherTxt.text ?? "")
            }else{
                self.peNewAssessment.manufacturer = txtManufacturer.text
            }
        }
    }
    
    /* Get offline stored session */
    // MARK: - Get offline stored session
    private func getAllOfflineSubmitedArrayStored() -> PENewAssessment{
        var peAssessmentAlreadySubmitted : PENewAssessment = PENewAssessment()
        let offlineSubmitedArray  = CoreDataHandlerPE().getSessionForViewAssessmentArrayPEObject(ofCurrentAssessment:true)
        if offlineSubmitedArray.count > 0 {
            for obj in offlineSubmitedArray {
                peAssessmentAlreadySubmitted = obj
            }
        }
        return peAssessmentAlreadySubmitted
    }
    
    // MARK: - Hide Flock View
    func hideFlockView(){
        self.allProductionViewHeightConstraint.constant = 0
        self.allProductionLbl.isHidden = true
        self.btnFlockAgeGreater.isHidden = true
        self.lowerView.isHidden = true
    }
    // MARK: - Show Flock View
    func showFlockView(){
        self.allProductionViewHeightConstraint.constant = 60
        self.allProductionLbl.isHidden = false
        self.btnFlockAgeGreater.isHidden = false
        self.lowerView.isHidden = false
        
        //  flockView.isHidden = false
    }
    
    /* Get offline and draft stored session */
    // MARK: - Get offline and draft stored session
    private func getAllDateArrayStored() -> [String]{
        //let draft =  ZoetisDropdownShared.sharedInstance.sharedPEDraft ?? []
        let drafts  = CoreDataHandlerPE().getDraftAssessmentArrayPEObject()
        var dates : [String] = []
        var coustomers : [String] = []
        var sites : [String] = []
        for obj in drafts {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        let syncData =  CoreDataHandlerPE().getOfflineAssessmentArrayPEObject()
        for obj in syncData {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        return dates
    }
    // MARK: - Get Saved Customer List
    private func getAllCustomerArrayStored() -> [String]{
        let drafts  = CoreDataHandlerPE().getDraftAssessmentArrayPEObject()
        var dates : [String] = []
        var coustomers : [String] = []
        var sites : [String] = []
        for obj in drafts {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        let syncData =  CoreDataHandlerPE().getOfflineAssessmentArrayPEObject()
        for obj in syncData {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        return coustomers
    }
    // MARK: - Get Saved Site's List
    private func getAllSitesArrayStored() -> [String]{
        let drafts  = CoreDataHandlerPE().getDraftAssessmentArrayPEObject()
        var dates : [String] = []
        var coustomers : [String] = []
        var sites : [String] = []
        for obj in drafts {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        let syncData =  CoreDataHandlerPE().getOfflineAssessmentArrayPEObject()
        for obj in syncData {
            dates.append(obj.evaluationDate ?? "")
            coustomers.append(obj.customerName ?? "")
            sites.append(obj.siteName ?? "")
        }
        return sites
    }
    // MARK: - Get Saved Evaluation type List
    private func getAllevaluationIDStored() -> [String]{
        let drafts  = CoreDataHandlerPE().getDraftAssessmentArrayPEObject(ofCurrentDate:true)
        var evaluationIDs : [String] = []
        for obj in drafts {
            evaluationIDs.append(obj.evaluationName ?? "")
        }
        let syncData =  CoreDataHandlerPE().getOfflineAssessmentArrayPEObject(ofCurrentDate:true)
        for obj in syncData {
            evaluationIDs.append(obj.evaluationName ?? "")
        }
        return evaluationIDs
    }
    
    @IBAction func btnAction(_ sender: Any) {
        print("Test Message",appDelegate.testFuntion())
    }
    // MARK: - Hide Other Breed Button
    func hideBreedOthers(){
        if manfacturerOtherBtn.isHidden{
            manufactureOtherView.isHidden = true
            breedOtherView.isHidden = true
            otherManuHeightConst.constant = 0
        }
        btnBreedOthers.isHidden = true
        txtBreedOfBirdsOthers.isHidden = true
    }
    // MARK: - Show Other Breed Button
    func showBreedOthers(){
        otherManuHeightConst.constant = 60
        breedOtherView.isHidden = false
        manufactureOtherView.isHidden = false
        btnBreedOthers.isHidden = false
        txtBreedOfBirdsOthers.isHidden = false
    }
    // MARK: - Hide Incubation Other Button
    func hideIncubationOthers(){
        btnIncubationOthers.isHidden = true
        txtIncubationOthers.isHidden = true
    }
    // MARK: - Show Incubation Other Button
    func showIncubationOthers(){
        btnIncubationOthers.isHidden = false
        txtIncubationOthers.isHidden = false
    }
    // MARK: - Hide Other Manufacturer Button
    func hideManufacturerOthers(){
        if btnBreedOthers.isHidden{
            manufactureOtherView.isHidden = true
            breedOtherView.isHidden = true
            otherManuHeightConst.constant = 0
        }
        manfacturerOtherBtn.isHidden = true
        manfacturerOtherTxt.isHidden = true
        self.view.layoutIfNeeded()
    }
    // MARK: - Show Other Manufacturer Button
    func showManufacturerOthers(){
        otherManuHeightConst.constant = 60
        manufactureOtherView.isHidden = false
        manfacturerOtherBtn.isHidden = false
        manfacturerOtherTxt.isHidden = false
        breedOtherView.isHidden = false
        self.view.layoutIfNeeded()
    }
    // MARK: - Hide Eggs Breed Button
    func hideEggsOthers(){
        eggsOtherBtn.isHidden = true
        eggsOtherTxt.isHidden = true
        otherEggsHeightConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    // MARK: - Show Eggs Breed Button
    func showEggsOthers(){
        eggsOtherBtn.isHidden = false
        eggsOtherTxt.isHidden = false
        otherEggsHeightConstraint.constant = 60
        btnIncubationOthers.isHidden = true
        txtIncubationOthers.isHidden = true
        self.view.layoutIfNeeded()
    }
    // MARK: - From BAck Button to Next Button
    func fromBackNextBtnAction(){
        self.checkBackAndSave()
        isMovedForward = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as? PEAssesmentFinalize
        vc?.peNewAssessment = self.peNewAssessment
        vc?.peNewAssessmentBack = self.peNewAssessment
        vc?.scheduledAssessment = scheduledAssessment
        UserDefaults.standard.setValue(self.peNewAssessment.isChlorineStrip, forKey: "isChlorineStrip")
        UserDefaults.standard.setValue(self.peNewAssessment.isAutomaticFail, forKey: "isAutomaticFail")
        UserDefaults.standard.synchronize()
        
        if extendedPESwitch{
            let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
            
            if sanitationQuesArr.count == 0{
                SanitationEmbrexQuestionMasterDAO.sharedInstance.saveAssessmentQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
            }
        }
        if vc != nil{
            Constants.isMovementDone = true
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        return
    }
    
    // MARK: - Show Extendended Microbial Alert msg
    func showOnlyExtendedMicrobial(){
        
        // MARK:  for PE International we dont want this popup that's why it is removed.
        self.fromBackNextBtnAction()
        
        
    }
    // MARK: - Check Data Duplicacy
    private func dataDuplicacyCheck(assId: String, customerId: Int, siteId: Int, evalDate: String, evaulaterId: Int, _ completion: @escaping (_ status: Bool) -> Void){
        let parameter = [
            "AssessmentId":assId,
            "SiteId": siteId,
            "CustomerId": customerId,
            "EvaulaterId": evaulaterId,
            "EvaluationDate": evalDate
        ] as JSONDictionary
        ZoetisWebServices.shared.getDuplicacyCheck(controller: self, parameters: parameter, completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            if json["Data"].boolValue == true{
                completion(false)
            }else{
                completion(true)
            }
        })
    }
    // MARK: - Get Vaccine Mixture List
    private func getVaccineMixerList(customerId: Int, siteId: Int, countryId: Int, _ completion: @escaping (_ status: Bool) -> Void){
        self.showGlobalProgressHUDWithTitle(self.view, title: "Loading Mixer...")
        let parameter = [
            "siteId": "\(siteId)",
            "customerId": "\(customerId)",
            "countryId": "\(countryId)"
        ] as JSONDictionary
        ZoetisWebServices.shared.getMixerList(controller: self, parameters: parameter) { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleVaccineMixer(json)
        }
    }
    // MARK: - Handle Vaccine Mixture API Responce
    private func handleVaccineMixer(_ json: JSON) {
        self.deleteAllData("PE_VaccineMixerDetail")
        
        VaccineMixerResponse(json)
        self.dismissGlobalHUD(self.view ?? UIView())
    }
    // MARK: - Next Button Action
    @IBAction func nextBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        Constants.isFirstTime = false
        self.getVaccineMixerList(customerId: self.peNewAssessment.customerId ?? 0, siteId: self.peNewAssessment.siteId ?? 0, countryId: 40) { [self] status in
            
        }
        guard let date = self.peNewAssessment.evaluationDate, date.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        
        guard let customer = self.peNewAssessment.customerName, customer.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        
        guard let selectedTSR = self.selectedTSR.text, selectedTSR.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        
        guard let site = self.peNewAssessment.siteName, site.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        guard let evaluationName = self.peNewAssessment.evaluationName, evaluationName.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        guard let evaluator = self.peNewAssessment.evaluatorName, evaluator.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        guard let reasonForVisit = self.peNewAssessment.visitName, reasonForVisit.count > 0 else {
            changeMandatorySuperviewToRed()
            return
        }
        
        if peNewAssessment.breedOfBird != nil && peNewAssessment.breedOfBird != ""{
            if ((peNewAssessment.breedOfBird?.lowercased().contains("other")) ?? false) {
                if peNewAssessment.breedOfBirdOther != nil && peNewAssessment.breedOfBirdOther != "" {
                    
                }else{
                    changeMandatorySuperviewToRed()
                    return
                }
            }
        }else{
            changeMandatorySuperviewToRed()
            return
        }
        
        if self.txtManufacturer.text != nil && self.txtManufacturer.text != ""{
            if ((self.txtManufacturer.text?.lowercased().contains("other")) ?? false) {
                if manfacturerOtherTxt.text != nil && manfacturerOtherTxt.text != "" {
                    
                }else{
                    changeMandatorySuperviewToRed()
                    return
                }
            }
        }else{
            changeMandatorySuperviewToRed()
            return
        }
        
        if self.countryTxt.text != nil && self.countryTxt.text != ""{
            
        }else{
            changeMandatorySuperviewToRed()
            return
        }
        
        
        if peNewAssessment.incubation != nil && peNewAssessment.incubation != ""{
            
        }else{
            changeMandatorySuperviewToRed()
            return
        }
        
        if txtNumberOfEggs.text != nil && txtNumberOfEggs.text != ""{
            if ((txtNumberOfEggs.text?.lowercased().contains("other")) ?? false) {
                if eggsOtherTxt.text != nil && eggsOtherTxt.text != "" {
                    
                }else{
                    changeMandatorySuperviewToRed()
                    return
                }
            }
        }else{
            changeMandatorySuperviewToRed()
            return
        }
        
        let datesStored =  getAllDateArrayStored()
        let customerStored = getAllCustomerArrayStored()
        let sitesStored = getAllSitesArrayStored()
        let evaluationIDs = getAllevaluationIDStored()
        var dateContain = false
        
        for  obj  in datesStored {
            if obj.lowercased() == self.peNewAssessment.evaluationDate?.lowercased(){
                dateContain = true
            }
        }
        
        var customerContain = false
        
        for  obj  in customerStored {
            if obj.lowercased() == self.peNewAssessment.customerName?.lowercased(){
                customerContain = true
            }
        }
        
        var siteContain = false
        
        for  obj  in sitesStored {
            if obj.lowercased() == self.peNewAssessment.siteName?.lowercased(){
                siteContain = true
            }
        }
        
        var evaluationContain = false
        
        for  obj  in evaluationIDs {
            if obj.lowercased() == self.peNewAssessment.evaluationName?.lowercased(){
                evaluationContain = true
            }
        }
        
        if self.allProductionViewHeightConstraint.constant == 60 {
            if isFlockAgeGreaterTheAllProd || isFlockAgeGreaterThen50Weeks {
                
                if isFromBack {
                    let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
                    if sanitationQuesArr.count == 0 && Constants.isExtendedPopup{
                        
                        showOnlyExtendedMicrobial()
                    } else{
                        if !Constants.isMovementDone{
                            self.fromBackNextBtnAction()
                        }
                    }
                    
                } else {
                    
                    self.okButtonTapped()
                }
            } else {
                showAlert(title: "Alert", message: "Please enter the flock details.", owner: self)
            }
        }else {
            if isFromBack {
                let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
                if sanitationQuesArr.count == 0 && Constants.isExtendedPopup{
                    showOnlyExtendedMicrobial()
                }else{
                    if !Constants.isMovementDone{
                        self.fromBackNextBtnAction()
                    }
                }
            } else {
                
                self.okButtonTapped()
                
            }
        }
    }
    
    
    // MARK: - Save Assessment In Draft
    func saveAssessmentInProgressDataInDB()  {
        if cameraSwitch.isOn{
            peNewAssessment.camera = 1
        } else {
            peNewAssessment.camera = 0
        }
        if let notesTxt = notesTextView.text , notesTxt.count > 0 {
            peNewAssessment.notes =   notesTxt
        }
        
        var FirstName =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        let LastName =  UserDefaults.standard.value(forKey: "LastName") as? String ?? ""
        FirstName = FirstName +  LastName
        self.peNewAssessment.username = FirstName
        self.peNewAssessment.firstname = FirstName
        self.peNewAssessment.breedOfBird = txtBreedOfBird.text
        self.peNewAssessment.breedOfBirdOther = txtBreedOfBirdsOthers.text
        
        if hatcherySwitch.isOn{
            peNewAssessment.hatcheryAntibiotics = 1//hatcherySwitch.isOn
        } else{
            peNewAssessment.hatcheryAntibiotics = 0
        }
        
        self.peNewAssessment.countryName = countryTxt.text
        self.peNewAssessment.fluid = inovoPESwitch
        self.peNewAssessment.basicTransfer = basicPESwitch
        self.peNewAssessment.countryID = selectedCountryId
        self.peNewAssessment.incubation = txtIncubation.text
        self.peNewAssessment.extndMicro = extendedPESwitch
        self.peNewAssessment.clorineId = selectedClorineId
        self.peNewAssessment.clorineName = clorineTxtFld.text
        
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        self.peNewAssessment.userID = userID
        CoreDataHandlerPE().updateAssessmentInProgressInDB(newAssessment: self.peNewAssessment, serverAssessmentId: peNewAssessment.serverAssessmentId ?? "")
    }
    
    func saveBackAssessmentInProgressDataInDB()  {
        if cameraSwitch.isOn{
            peNewAssessment.camera = 1
        } else {
            peNewAssessment.camera = 0
        }
        if let notesTxt = notesTextView.text , notesTxt.count > 0 {
            peNewAssessment.notes =   notesTxt
        }
        if hatcherySwitch.isOn{
            peNewAssessment.hatcheryAntibiotics = 1//hatcherySwitch.isOn
        } else{
            peNewAssessment.hatcheryAntibiotics = 0
        }
        var FirstName =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        let LastName =  UserDefaults.standard.value(forKey: "LastName") as? String ?? ""
        FirstName = FirstName +  LastName
        self.peNewAssessment.username = FirstName
        self.peNewAssessment.firstname = FirstName
        self.peNewAssessment.breedOfBird = txtBreedOfBird.text
        self.peNewAssessment.breedOfBirdOther = txtBreedOfBirdsOthers.text
        self.peNewAssessment.incubation = txtIncubation.text
        
        self.peNewAssessment.countryName = countryTxt.text
        self.peNewAssessment.fluid = inovoPESwitch
        self.peNewAssessment.basicTransfer = basicPESwitch
        self.peNewAssessment.countryID = selectedCountryId
        self.peNewAssessment.sanitationEmbrex = extendedPEInt
        
        self.peNewAssessment.clorineId = selectedClorineId
        self.peNewAssessment.clorineName = clorineTxtFld.text
        
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        self.peNewAssessment.userID = userID
        CoreDataHandlerPE().updateAlreadyInProgressInDB(newAssessment: self.peNewAssessment)
    }
    // MARK: - Add Red Background for blank field
    func changeMandatorySuperviewToRed(){
        let date = self.peNewAssessment.evaluationDate ?? ""
        let customer = self.peNewAssessment.customerName ?? ""
        let site = self.peNewAssessment.siteName ?? ""
        let evaluationName = self.peNewAssessment.evaluationName ?? ""
        let evaluator = self.peNewAssessment.evaluatorName ?? ""
        let reasonForVisit = self.peNewAssessment.visitName ?? ""
        let selectedTSR = self.selectedTSR.text ?? ""
        let clorineName = self.peNewAssessment.clorineName ?? ""
        
        if peNewAssessment.breedOfBird != nil && peNewAssessment.breedOfBird != ""{
            if peNewAssessment.breedOfBird?.lowercased().contains("other") ?? false {
                if peNewAssessment.breedOfBirdOther != nil && peNewAssessment.breedOfBirdOther != "" {
                    
                }else{
                    let superviewCurrent =  btnBreedOthers.superview
                    if superviewCurrent != nil {
                        for view in superviewCurrent!.subviews {
                            if view.isKind(of:UIButton.self) {
                                view.layer.borderColor = UIColor.red.cgColor
                                view.layer.borderWidth = 2.0
                            }
                        }
                    }
                }
            }
        }else{
            let superviewCurrent =  btnBreed.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        if  self.txtManufacturer.text != nil &&  self.txtManufacturer.text != ""{
            if (( self.txtManufacturer.text?.lowercased().contains("other")) ?? false) {
                if manfacturerOtherTxt.text != nil && manfacturerOtherTxt.text != "" {
                    
                }else{
                    let superviewCurrent =  manfacturerOtherBtn.superview
                    if superviewCurrent != nil {
                        for view in superviewCurrent!.subviews {
                            if view.isKind(of:UIButton.self) {
                                view.layer.borderColor = UIColor.red.cgColor
                                view.layer.borderWidth = 2.0
                            }
                        }
                    }
                }
            }
        }else{
            let superviewCurrent =  manufacturerButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        if peNewAssessment.incubation != nil && peNewAssessment.incubation != ""{
            
        }else{
            let superviewCurrent =  btnIncubation.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        if txtNumberOfEggs.text != nil && txtNumberOfEggs.text != ""{
            if ((txtNumberOfEggs.text?.lowercased().contains("other")) ?? false) {
                if eggsOtherTxt.text != nil && eggsOtherTxt.text != "" {
                    
                }else{
                    let superviewCurrent =  eggsOtherBtn.superview
                    if superviewCurrent != nil {
                        for view in superviewCurrent!.subviews {
                            if view.isKind(of:UIButton.self) {
                                view.layer.borderColor = UIColor.red.cgColor
                                view.layer.borderWidth = 2.0
                            }
                        }
                    }
                }
            }
        }else{
            let superviewCurrent =  numberOfEggsButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        if (date.count > 0 ){print("Test message")} else  {
            let superviewCurrent =  evaluationDateButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if (customer.count > 0 ){print("Test message")} else  {
            let superviewCurrent =  customerButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if (selectedTSR.count > 0 ){print("Test message")} else  {
            let superviewCurrent = tsrButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        
        if (site.count > 0 ){print("Test message")} else  {
            let superviewCurrent =  siteButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if (evaluationName.count > 0){print("Test message")} else  {
            let superviewCurrent =  evaluationTypeButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
                
            }
            
        }
        if (evaluator.count  > 0){print("Test message")} else  {
            let superviewCurrent =  evaluatorButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                        
                    }
                }
            }
        }
        if (reasonForVisit.count > 0){print("Test message")} else  {
            let superviewCurrent =  visitButton.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
        showAlert(title: "Alert", message: "Please enter details in all the fields marked as mandatory.", owner: self)
        
    }
    
    /* evaluation date selected */
    // MARK: - Evalutation Date Button Action
    @IBAction func evaluationDateClicked(_ sender: Any) {
        
        self.view.endEditing(true)
        let superviewCurrent =  evaluationDateButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as? DatePickerPopupViewController
        datePickerPopupViewController?.delegate = self
        datePickerPopupViewController?.canSelectPreviousDate = true
        datePickerPopupViewController?.evaluationDate = peNewAssessment.evaluationDate
        if datePickerPopupViewController != nil
        {
            navigationController?.present(datePickerPopupViewController!, animated: false, completion: nil)
        }
        
    }
    
    //Customer Company is same
    /* Customer selected */
    // MARK: - Customer  Button Action
    @IBAction func customerClicked(_ sender: Any) {
        let superviewCurrent =  customerButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var customerNamesArray = NSArray()
        var customerIDArray = NSArray()
        var customerDetailsArray = NSArray()
        customerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Customer")
        customerNamesArray = customerDetailsArray.value(forKey: "customerName") as? NSArray ?? NSArray()
        customerIDArray = customerDetailsArray.value(forKey: "customerID") as? NSArray ?? NSArray()
        if  customerNamesArray.count > 0 {
            self.dropDownVIewNew(arrayData: customerNamesArray as? [String] ?? [String](), kWidth: customerButton.frame.width, kAnchor: customerButton, yheight: customerButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedCustomerText.text = selectedVal
                self.selectedSiteText.text = ""
                let indexOfItem = customerNamesArray.index(of: selectedVal)
                self.peNewAssessment.customerName = selectedVal
                self.peNewAssessment.siteName = ""
                self.peNewAssessment.customerId = customerIDArray[indexOfItem] as? Int
                
            }
            self.dropHiddenAndShow()
        }
    }
    
    /* Manufacturer selected */
    // MARK: - Manufacture Date Button Action
    @IBAction func manufacutrerClicked(_ sender: Any) {
        
        let superviewCurrent =  manufacturerButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var manufacutrerNameArray = NSArray()
        var manufacutrerDetailsArray = NSArray()
        manufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Manufacturer")
        manufacutrerNameArray = manufacutrerDetailsArray.value(forKey: "mFG_Name") as? NSArray ?? NSArray()
        if  manufacutrerNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: manufacutrerNameArray as? [String] ?? [String](), kWidth: btnIncubation.frame.width, kAnchor: btnIncubation, yheight: btnIncubation.bounds.height){ [unowned self] selectedVal, index  in
                self.txtManufacturer.text = selectedVal
                self.peNewAssessment.manufacturer = self.txtManufacturer.text ?? ""
                //                self.checkBackAndSave()
                if self.peNewAssessment.manufacturer == "Other"{
                    self.showManufacturerOthers()
                } else {
                    self.hideManufacturerOthers()
                }
                if selectedVal == "Other"{
                    self.txtManufacturer.text = selectedVal
                    self.manfacturerOtherTxt.text = ""
                }
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
        
    }
    
    /* Number of eggs selected */
    // MARK: - Number Of Eggs Button Action
    @IBAction func numberOfEggsClicked(_ sender: Any) {
        
        let superviewCurrent =  numberOfEggsButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        var EggsNameArray = NSArray()
        let EggsDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Eggs")
        EggsNameArray = EggsDetailsArray.value(forKey: "eggCount") as? NSArray ?? NSArray()
        if  EggsNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: EggsNameArray as? [String] ?? [String](), kWidth: txtNumberOfEggs.frame.width, kAnchor: txtNumberOfEggs, yheight: txtNumberOfEggs.bounds.height) { [unowned self] selectedVal, index  in
                if selectedVal == "Other"{
                    self.txtNumberOfEggs.text = selectedVal
                    self.peNewAssessment.noOfEggs = 0//Double(0)
                    self.eggsOtherTxt.text = ""
                    self.showEggsOthers()
                } else {
                    self.hideEggsOthers()
                    self.txtNumberOfEggs.text = selectedVal
                    self.peNewAssessment.noOfEggs = Int64(self.txtNumberOfEggs.text ?? "")
                }
                
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
    
    //Complex Site is same
    /* Site selected */
    // MARK: - Site Button Action
    @IBAction func siteClicked(_ sender: Any) {
        let superviewCurrent =  siteButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.lightGray.cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        guard let customer = self.peNewAssessment.customerName, customer.count > 0 else {
            return
        }
        var complexNamesArray = NSArray()
        var complexDetailsArray = NSArray()
        var complexIDArray = NSArray()
        complexDetailsArray = CoreDataHandlerPE().fetchSitesWithCustId( self.peNewAssessment.customerId as NSNumber? ?? 0)
        complexNamesArray = complexDetailsArray.value(forKey: "siteName") as? NSArray ?? NSArray()
        complexIDArray = complexDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        
        if  complexNamesArray.count > 0 {
            self.dropDownVIewNew(arrayData: complexNamesArray as? [String] ?? [String](), kWidth: siteButton.frame.width, kAnchor: siteButton, yheight: siteButton.bounds.height) { [unowned self] selectedVal, index in
                self.selectedSiteText.text = selectedVal
                self.peNewAssessment.siteName = selectedVal
                let indexOfItem = complexNamesArray.index(of: selectedVal)
                self.peNewAssessment.siteId = complexIDArray[indexOfItem] as? Int
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        } else{
            
        }
    }
    
    /* Evaluator selected */
    // MARK: - Evaluator Button Action
    @IBAction func evaluatorClicked(_ sender: Any) {
        let superviewCurrent =  evaluatorButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var evaluatorIDArray = NSArray()
        var evaluatorNameArray = NSArray()
        let evaluatorDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Evaluator")
        evaluatorNameArray = evaluatorDetailsArray.value(forKey: "evaluatorName") as? NSArray ?? NSArray()
        evaluatorIDArray = evaluatorDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  evaluatorNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: evaluatorNameArray as? [String] ?? [String](), kWidth: evaluatorButton.frame.width, kAnchor: evaluatorButton, yheight: evaluatorButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedEvaluatorText.text = selectedVal
                self.peNewAssessment.evaluatorName = selectedVal
                let indexOfItem = evaluatorNameArray.index(of: selectedVal)
                self.peNewAssessment.evaluatorID = evaluatorIDArray[indexOfItem] as? Int
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
    
    /* Type of visit selected */
    // MARK: - Visit Type Button Action
    @IBAction func visitClicked(_ sender: Any) {
        let superviewCurrent =  visitButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        var visitIDArray = NSArray()
        var visitNameArray = NSArray()
        let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VisitTypes")
        visitNameArray = visitDetailsArray.value(forKey: "visitName") as? NSArray ?? NSArray()
        visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  visitNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: visitNameArray as? [String] ?? [String](), kWidth: visitButton.frame.width, kAnchor: visitButton, yheight: visitButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedVisitText.text = selectedVal
                self.peNewAssessment.visitName = selectedVal
                let indexOfItem = visitNameArray.index(of: selectedVal)
                self.peNewAssessment.visitID = visitIDArray[indexOfItem] as? Int
                self.checkBackAndSave()
                PEAssessmentsDAO.sharedInstance.updateAssessmentStatus( userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: self.peNewAssessment.serverAssessmentId ?? "", assessmentobj: self.peNewAssessment)
            }
            self.dropHiddenAndShow()
        }
    }
    
    /* Types of evaluation selected */
    // MARK: - Evalutation Type Button Action
    @IBAction func evaluationClicked(_ sender: Any) {
        
        let superviewCurrent =  evaluationTypeButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var evaluationIDArray = NSArray()
        var evaluationNameArray = NSArray()
        let evaluationDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_EvaluationType")
        evaluationNameArray = evaluationDetailsArray.value(forKey: "evaluationName") as? NSArray ?? NSArray()
        evaluationIDArray = evaluationDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  evaluationNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: evaluationNameArray as? [String] ?? [String](), kWidth: evaluationTypeButton.frame.width, kAnchor: evaluationTypeButton, yheight: evaluationTypeButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedEvaluationType.text = selectedVal
                self.isFlockAgeGreaterTheAllProd = false
                self.isFlockAgeGreaterThen50Weeks  = false
                self.btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
                self.btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
                self.showFlockView()
                
                if selectedVal.contains("Non")  {
                    let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                    if infoObj != nil{
                        PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: false, assessmentId: self.peNewAssessment.serverAssessmentId ?? "", date: nil,hasChlorineStrips: self.chlorineStripsSwitch.isOn, isAutomaticFail: self.isAutomaticSwitch.isOn)
                    }
                    self.allProductionViewHeightConstraint.constant = 60
                    self.flockAgeLower.isHidden = true
                    self.btnFlockImageLower.isHidden = true
                    self.flockAgeLbl.text = "Breeder Flock Age of Eggs Injected"
                } else {
                    self.allProductionViewHeightConstraint.constant = 60
                    self.flockAgeLower.isHidden = false
                    self.btnFlockImageLower.isHidden = false
                    self.flockAgeLbl.text = "Breeder Flock Age of Eggs Injected*"
                }
                
                
                self.peNewAssessment.evaluationName = selectedVal
                let indexOfItem = evaluationNameArray.index(of: selectedVal)
                self.peNewAssessment.evaluationID = evaluationIDArray[indexOfItem] as? Int
                
                if self.peNewAssessment.evaluationID != nil && self.peNewAssessment.evaluationID == 1{
                    
                }else{
                    let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                    
                    let hasSelectedExtendedPE = infoObj?.isExtendedPE ?? false
                    if hasSelectedExtendedPE{
                        
                    }
                    
                }
                
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
    
    func checkBackAndSave(){
        if isFromBack{
            self.saveBackAssessmentInProgressDataInDB()
        }else {
            self.saveAssessmentInProgressDataInDB()
        }
    }
    
    /* TSR selected */
    // MARK: - TSR Button Action
    @IBAction func tsrClicked(_ sender: Any) {
        let superviewCurrent =  tsrButton.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        var visitIDArray = NSArray()
        var visitNameArray = NSArray()
        let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Approvers")
        visitNameArray = visitDetailsArray.value(forKey: "username") as? NSArray ?? NSArray()
        visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  visitNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: visitNameArray as? [String] ?? [String](), kWidth: tsrButton.frame.width, kAnchor: tsrButton, yheight: tsrButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedTSR.text = selectedVal
                self.peNewAssessment.selectedTSR = selectedVal
                let indexOfItem = visitNameArray.index(of: selectedVal)
                self.peNewAssessment.selectedTSRID = visitIDArray[indexOfItem] as? Int
                self.checkBackAndSave()
                self.scheduledAssessment?.selectedTSR = selectedVal
                self.scheduledAssessment?.selectedTSRID = visitIDArray[indexOfItem] as? Int
                
                PEAssessmentsDAO.sharedInstance.updateAssessmentStatus( userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId:  self.scheduledAssessment?.serverAssessmentId ?? "", assessmentobj: self.scheduledAssessment ?? self.peNewAssessment)
            }
            self.dropHiddenAndShow()
        }
    }
    
    /* Switch action */
    // MARK: - Switch Button Action
    @IBAction func switchClicked(_ sender: Any) {
        if cameraSwitch.isOn {
            peNewAssessment.camera = 1
        } else {
            peNewAssessment.camera = 0
        }
        if hatcherySwitch.isOn{
            peNewAssessment.hatcheryAntibiotics = 1//hatcherySwitch.isOn
        } else{
            peNewAssessment.hatcheryAntibiotics = 0
        }
        
        if isAutomaticSwitch.isOn{
            peNewAssessment.isAutomaticFail = 1//hatcherySwitch.isOn
        } else{
            peNewAssessment.isAutomaticFail = 0
        }
        
        if Constants.isExtendedPopup{
            if extendedPESwitch{
                peNewAssessment.sanitationEmbrex = 1
            }else{
                peNewAssessment.sanitationEmbrex = 0
            }
        }
        
        PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: extendedPESwitch, assessmentId: peNewAssessment.serverAssessmentId ?? "", date: nil,hasChlorineStrips: false, isAutomaticFail: self.isAutomaticSwitch.isOn)
        
        self.checkBackAndSave()
    }
    
    /* Breed selected */
    // MARK: - Breed  Button Action
    @IBAction func btnBreedClicked(_ sender: Any) {
        
        let superviewCurrent =  btnBreed.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var BirdBreedNameArray = NSArray()
        let BirdBreedDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BirdBreed")
        BirdBreedNameArray = BirdBreedDetailsArray.value(forKey: "birdBreedName") as? NSArray ?? NSArray()
        
        if  BirdBreedNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: BirdBreedNameArray as? [String] ?? [String](), kWidth: btnBreed.frame.width, kAnchor: btnBreed, yheight: btnBreed.bounds.height) { [unowned self] selectedVal, index  in
                self.txtBreedOfBird.text = selectedVal
                if selectedVal == "Other"{
                    self.showBreedOthers()
                } else {
                    self.hideBreedOthers()
                }
                if selectedVal == "Other"{
                    self.txtBreedOfBird.text = selectedVal
                    self.txtBreedOfBirdsOthers.text = ""
                }
                self.checkBackAndSave()
                
                
            }
            self.dropHiddenAndShow()
        }
    }
    
    /* Incubation style selected */
    // MARK: - Incubation  Button Action
    @IBAction func btnIncubationClicked(_ sender: Any) {
        
        let superviewCurrent =  btnIncubation.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var BirdBreedNameArray = NSArray()
        let BirdBreedDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_IncubationStyle")
        BirdBreedNameArray = BirdBreedDetailsArray.value(forKey: "incubationStylesName") as? NSArray ?? NSArray()
        
        if  BirdBreedNameArray.count > 0 {
            
            self.dropDownVIewNew(arrayData: BirdBreedNameArray as? [String] ?? [String](), kWidth: btnIncubation.frame.width, kAnchor: btnIncubation, yheight: btnIncubation.bounds.height) { [unowned self] selectedVal, index  in
                self.txtIncubation.text = selectedVal
                if selectedVal == "Other"{
                    self.peNewAssessment.breedOfBird = "Other"
                    self.showIncubationOthers()
                } else {
                    self.peNewAssessment.breedOfBird = selectedVal
                    self.hideIncubationOthers()
                }
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
    
    //MARKS: DROP DOWN HIDDEN AND SHOW
    // MARK: - DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    // MARK: - Flock Lower Option button Action
    @IBAction func flockImageLowerSelected(_ sender: Any) {
        if isFlockAgeGreaterThen50Weeks {
            isFlockAgeGreaterTheAllProd = true
            btnFlockAgeGreater.setImage(UIImage(named: "checkIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = false
            btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        } else {
            isFlockAgeGreaterTheAllProd = false
            btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = true
            btnFlockImageLower.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        
        if  self.peNewAssessment.evaluationID == 1 {
            if isFlockAgeGreaterThen50Weeks {
                self.peNewAssessment.isFlopSelected = 2
            } else {
                self.peNewAssessment.isFlopSelected = 1
            }
        }
        if  self.peNewAssessment.evaluationID == 2 {
            if isFlockAgeGreaterThen50Weeks {
                self.peNewAssessment.isFlopSelected = 3
            } else {
                self.peNewAssessment.isFlopSelected = 0
            }
        }
        
        if  self.peNewAssessment.evaluationID == 3 {
            if isFlockAgeGreaterThen50Weeks {
                self.peNewAssessment.isFlopSelected = 5
            } else {
                self.peNewAssessment.isFlopSelected = 4
            }
        }
        self.checkBackAndSave()
    }
    
    
    // MARK: - Flock Image Greater ButtonAction
    @IBAction func flockImageGreaterSlected(_ sender: Any) {
        
        if isFlockAgeGreaterTheAllProd {
            isFlockAgeGreaterTheAllProd = false
            btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = true
            btnFlockImageLower.setImage(UIImage(named: "checkIconPE"), for: .normal)
            self.peNewAssessment.isFlopSelected = 0
        } else {
            isFlockAgeGreaterTheAllProd = true
            btnFlockAgeGreater.setImage(UIImage(named: "checkIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = false
            btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }
        
        
        if  self.peNewAssessment.evaluationID == 1 {
            if isFlockAgeGreaterTheAllProd {
                self.peNewAssessment.isFlopSelected = 1
            } else {
                self.peNewAssessment.isFlopSelected = 2
            }
        }
        if  self.peNewAssessment.evaluationID == 2 {
            if isFlockAgeGreaterTheAllProd {
                self.peNewAssessment.isFlopSelected = 3
            } else {
                self.peNewAssessment.isFlopSelected = 0
            }
        }
        
        if  self.peNewAssessment.evaluationID == 3 {
            if isFlockAgeGreaterTheAllProd {
                self.peNewAssessment.isFlopSelected = 4
            } else {
                self.peNewAssessment.isFlopSelected = 5
            }
        }
        
        self.checkBackAndSave()
    }
    
    // MARK: - Extended PE Button Action
    @IBAction func extendedPESelected(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            if self.extendedPESwitch == false {
                self.extendedPESwitch = true
                self.extendedPEBtn.setImage(UIImage(named: "checkIconPE"), for: .normal)
                self.peNewAssessment.sanitationEmbrex = 1
                self.extendedPEInt = 1
            }
            else{
                self.extendedPESwitch = false
                self.extendedPEBtn.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
                self.peNewAssessment.sanitationEmbrex = 0
                self.extendedPEInt = 0
            }
            self.peNewAssessment.extndMicro = self.extendedPESwitch
            self.checkBackAndSave()
        }
        
    }
    
    // MARK: - Inovo Button Action
    @IBAction func inovoBtn(_ sender: UIButton) {
        if inovoPESwitch == false {
            inovoPESwitch = true
            sender.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        else{
            inovoPESwitch = false
            sender.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }
        peNewAssessment.fluid = inovoPESwitch
        self.checkBackAndSave()
    }
    
    // MARK: - Basic Transfer Button Action
    @IBAction func basicTransferBtn(_ sender: UIButton) {
        if basicPESwitch == false {
            basicPESwitch = true
            sender.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        else{
            basicPESwitch = false
            sender.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }
        peNewAssessment.basicTransfer = basicPESwitch
        self.checkBackAndSave()
        
    }
    
    // MARK:   ********* Country Button Clicked    *********
    @IBAction func countryBtnClicked(_ sender: Any) {
        let superviewCurrent =  countryBtn.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var countryIDArray = NSArray()
        var countryNameArray = NSArray()
        let countryDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "AllCountriesPE")
        countryNameArray = countryDetailsArray.value(forKey: "countryName") as? NSArray ?? NSArray()
        countryIDArray = countryDetailsArray.value(forKey: "countryId") as? NSArray ?? NSArray()
        if  countryNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: countryNameArray as? [String] ?? [String](), kWidth: countryBtn.frame.width, kAnchor: countryBtn, yheight: countryBtn.bounds.height) { [unowned self] selectedVal, index  in
                self.countryTxt.text = selectedVal
                self.peNewAssessment.countryName = selectedVal
                let indexOfItem = countryNameArray.index(of: selectedVal)
                selectedCountryId = countryIDArray[indexOfItem] as? Int ?? 0
                self.peNewAssessment.countryID = countryIDArray[indexOfItem] as? Int
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
    
    // MARK:   ********* Clorine Button Clicked    *********
    @IBAction func clorineBtnAction(_ sender: Any) {
        
        let superviewCurrent =  clorineBtn.superview
        if superviewCurrent != nil {
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }
            }
        }
        
        var countryIDArray = NSArray()
        var countryNameArray = NSArray()
        let countryDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "AllClorinePE")
        countryNameArray = countryDetailsArray.value(forKey: "clorineName") as? NSArray ?? NSArray()
        countryIDArray = countryDetailsArray.value(forKey: "clorineId") as? NSArray ?? NSArray()
        if  countryNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: countryNameArray as? [String] ?? [String](), kWidth: clorineBtn.frame.width, kAnchor: clorineBtn, yheight: clorineBtn.bounds.height) { [unowned self] selectedVal, index  in
                self.clorineTxtFld.text = selectedVal
                self.peNewAssessment.clorineName = selectedVal
                let indexOfItem = countryNameArray.index(of: selectedVal)
                selectedClorineId = countryIDArray[indexOfItem] as? Int ?? 0
                self.peNewAssessment.clorineId = countryIDArray[indexOfItem] as? Int
                isAutomaticFailView.isHidden = false
                isAutomaticSwitch.isHidden = false
                clorineViewHeightConstranit.constant = 120
                
                self.checkBackAndSave()
            }
            self.dropHiddenAndShow()
        }
    }
}

// MARK: - DatePicker Delegates

extension PEStartNewAssessmentINT : DatePickerPopupViewControllerProtocol{
    
    func doneButtonTappedWithDate(string: String, objDate: Date) {
        let datesStored =  getAllDateArrayStored()
        let customerStored = getAllCustomerArrayStored()
        let sitesStored = getAllSitesArrayStored()
        let evaluationIDs = getAllevaluationIDStored()
        
        var dateContain = false
        
        for  obj  in datesStored {
            if obj.lowercased() == string.lowercased(){
                dateContain = true
            }
        }
        
        var customerContain = false
        
        for  obj  in customerStored {
            if obj.lowercased() == self.peNewAssessment.customerName?.lowercased(){
                customerContain = true
            }
        }
        
        var siteContain = false
        
        for  obj  in sitesStored {
            if obj.lowercased() == self.peNewAssessment.siteName?.lowercased(){
                siteContain = true
            }
        }
        
        var evaluationContain = false
        
        for  obj  in evaluationIDs {
            if obj.lowercased() == self.peNewAssessment.evaluationName?.lowercased(){
                evaluationContain = true
            }
        }
        
        selectedEvaluationDateText.text = string
        self.peNewAssessment.evaluationDate = string
        
        scheduledAssessment?.scheduledDate = objDate
        PEAssessmentsDAO.sharedInstance.updateAssessmentStatus( userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "", assessmentobj: scheduledAssessment ?? peNewAssessment)
        checkBackAndSave()
    }
    
    func doneButtonTapped(string:String){
        print("Test Message",appDelegate.testFuntion())
    }
}

// MARK: - Action Methods
extension PEStartNewAssessmentINT{
    
    
    func okButtonTapped() {
        let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        if Constants.isExtendedPopup && extendedPESwitch{
            if sanitationQuesArr.count == 0{
                if self.peNewAssessment.evaluationID != nil && self.peNewAssessment.evaluationID == 1{
                    showScheduledAndMicrobialPopup(VaccinationConstants.PEConstants.WARNING_MSG_NEXTBTN_CLICK_SCHEDULED_DATE)
                }else{
                    showScheduledAndMicrobialPopup(VaccinationConstants.PEConstants.WARNING_MSG_NEXTBTN_CLICK_SCHEDULED_DATE)
                }
                
            }else{
                showScheduledAndMicrobialPopup(VaccinationConstants.PEConstants.WARNING_MSG_NEXTBTN_CLICK_SCHEDULED_DATE)
            }
        }else if Constants.isExtendedPopup{
            showScheduledAndMicrobialPopup(VaccinationConstants.PEConstants.WARNING_MSG_NEXTBTN_CLICK_SCHEDULED_DATE)
            
        }else if !Constants.isExtendedPopup{
            okAction()
        }
    }
    
    func showScheduledAndMicrobialPopup(_ msg:String){
        
        let errorMSg = msg
        
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            self.okAction()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func okAction(){
        checkBackAndSave()
        jsonRe = (getJSON("QuestionAns") ?? JSON())
        questionInfo = (getJSON("QuestionAnsInfo") ?? JSON())
        infoImageDataResponse = InfoImageDataResponse(questionInfo)
        pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(jsonRe)
        if extendedPESwitch {
            let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
            
            if sanitationQuesArr.count == 0{
                SanitationEmbrexQuestionMasterDAO.sharedInstance.saveAssessmentQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
            }
            
        }
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray {
            
            let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
            if(regionID == 3){
                if peNewAssessment.evaluationID == object.evaluationID {
                    if object.id != 36{
                        peCategoryFilteredArray.append(object)
                    }
                    
                }
            }
            else{
                if object.id != 36{
                    peCategoryFilteredArray.append(object)
                }
                
            }
            
        }
        
        if peCategoryFilteredArray.count > 0 {
            var peNewAssessmentWas = PENewAssessment()
            peNewAssessmentWas = self.peNewAssessment
            CoreDataHandler().deleteAllData("PE_AssessmentInProgress",predicate: NSPredicate(format: "userID == %d AND serverAssessmentId = %@", peNewAssessmentWas.userID ?? 0, peNewAssessmentWas.serverAssessmentId ?? ""))
            
            for  cat in  peCategoryFilteredArray {
                for (index, ass) in cat.assessmentQuestions.enumerated(){
                    var peNewAssessmentNew = PENewAssessment()
                    peNewAssessmentNew = peNewAssessmentWas
                    peNewAssessmentNew.cID = index
                    peNewAssessmentNew.catID = cat.id
                    peNewAssessmentNew.catName = cat.categoryName
                    peNewAssessmentNew.catMaxMark = cat.maxMark
                    peNewAssessmentNew.sequenceNo = cat.id
                    peNewAssessmentNew.sequenceNoo = cat.sequenceNo
                    
                    peNewAssessmentNew.catEvaluationID = cat.evaluationID
                    peNewAssessmentNew.catISSelected = cat.isSelected ? 1:0
                    peNewAssessmentNew.assID = ass.id
                    peNewAssessmentNew.assDetail1 = ass.assessment
                    peNewAssessmentNew.evaluationID = cat.evaluationID
                    peNewAssessmentNew.assDetail2 = ass.assessment2
                    peNewAssessmentNew.assMinScore = ass.minScore
                    peNewAssessmentNew.assMaxScore = ass.maxScore
                    peNewAssessmentNew.assCatType = ass.cateType
                    peNewAssessmentNew.assModuleCatID = ass.moduleCatId
                    peNewAssessmentNew.assModuleCatName = ass.moduleCatName
                    if regionID == 3{
                        peNewAssessmentNew.assStatus = 1
                        peNewAssessmentNew.catResultMark = cat.maxMark
                    }
                    else
                    {
                        peNewAssessmentNew.assStatus = 0
                        peNewAssessmentNew.catResultMark = 0
                    }
                    
                    
                    peNewAssessmentNew.isChlorineStrip = self.peNewAssessment.isChlorineStrip
                    peNewAssessmentNew.isAutomaticFail = self.peNewAssessment.isAutomaticFail
                    peNewAssessmentNew.informationImage = ass.informationImage
                    peNewAssessmentNew.serverAssessmentId = peNewAssessmentWas.serverAssessmentId
                    peNewAssessmentNew.sanitationEmbrex = peNewAssessmentWas.sanitationEmbrex
                    peNewAssessmentNew.informationText = infoImageDataResponse.getInfoTextByQuestionId(questionID: ass.id ?? 151)
                    peNewAssessmentNew.isNA = ass.isNA
                    peNewAssessmentNew.isAllowNA = ass.isAllowNA
                    peNewAssessmentNew.rollOut = ass.rollOut
                    peNewAssessmentNew.qSeqNo = ass.qSeqNo
                    CoreDataHandlerPE().saveNewAssessmentInProgressInDB(newAssessment:self.peNewAssessment)
                    PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: extendedPESwitch, assessmentId: self.peNewAssessment.serverAssessmentId ?? "", date: nil,hasChlorineStrips: false, isAutomaticFail: self.isAutomaticSwitch.isOn)
                    
                    let myInt3 = (peNewAssessmentWas.serverAssessmentId! as NSString).integerValue
                    
                }
            }
            if peNewAssessment.evaluationID != nil && peNewAssessment.evaluationID == 1{
                if extendedPESwitch{
                    
                }
            }
            isMovedForward = true
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as? PEAssesmentFinalize
            vc?.peNewAssessment = self.peNewAssessment
            vc?.peNewAssessmentBack = self.peNewAssessment
            vc?.scheduledAssessment = scheduledAssessment
            
            UserDefaults.standard.setValue(self.peNewAssessment.isChlorineStrip, forKey: "isChlorineStrip")
            UserDefaults.standard.setValue(self.peNewAssessment.isAutomaticFail, forKey: "isAutomaticFail")
            UserDefaults.standard.synchronize()
            if vc != nil {
                self.navigationController?.pushViewController(vc!, animated: true)
                return
            }
        } else {
            print("test message")
        }
        
    }
    
    func filterCategoryCount() -> Int {
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray{
            if peNewAssessment.evaluationID == object.evaluationID{
                if object.id != 36{
                    peCategoryFilteredArray.append(object)
                }
            }
        }
        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
        return pECategoriesAssesmentsResponse.peCategoryArray.count
    }
    
    private func cleanSession(){
        
        let peNewAssessmentSurrentIs =   PENewAssessment()
        let peNewAssessmentNew = PENewAssessment()
        peNewAssessmentNew.siteId = peNewAssessmentSurrentIs.siteId
        peNewAssessmentNew.customerId = peNewAssessmentSurrentIs.customerId
        peNewAssessmentNew.complexId = peNewAssessmentSurrentIs.complexId
        peNewAssessmentNew.siteName = peNewAssessmentSurrentIs.siteName
        peNewAssessmentNew.userID = peNewAssessmentSurrentIs.userID
        peNewAssessmentNew.customerName = peNewAssessmentSurrentIs.customerName
        peNewAssessmentNew.firstname = peNewAssessmentSurrentIs.firstname
        peNewAssessmentNew.username = peNewAssessmentSurrentIs.username
        peNewAssessmentNew.evaluatorName = peNewAssessmentSurrentIs.evaluatorName
        
    }
    
}

// MARK: - UITextViewDelegate

extension PEStartNewAssessmentINT:UITextViewDelegate{
    
    func textViewShouldBeginEditing(_ _textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView == notesTextView ) {
            checkBackAndSave()
        }
    }
}

// MARK: - WebServices
extension PEStartNewAssessmentINT {
    
    internal func fetchtAssessmentCategoriesResponse(){
        isMovedForward = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as? PEAssesmentFinalize
        vc?.peNewAssessment = self.peNewAssessment
        vc?.peNewAssessmentBack = self.peNewAssessment
        vc?.scheduledAssessment = scheduledAssessment
        UserDefaults.standard.setValue(self.peNewAssessment.isChlorineStrip, forKey: "isChlorineStrip")
        UserDefaults.standard.setValue(self.peNewAssessment.isAutomaticFail, forKey: "isAutomaticFail")
        UserDefaults.standard.synchronize()
        
        if vc != nil {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    private func handleAssessmentCategoriesResponse(_ json: JSON) {
        print("Test Message",appDelegate.testFuntion())
    }
}

// MARK: - UITextFieldDelegate

extension PEStartNewAssessmentINT : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtBreedOfBirdsOthers{
            let superviewCurrent = btnBreedOthers.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if textField == manfacturerOtherTxt{
            let superviewCurrent =  manfacturerOtherBtn.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if textField == eggsOtherTxt{
            let superviewCurrent =  eggsOtherBtn.superview
            if superviewCurrent != nil {
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.txtBreedOfBirdsOthers {
            self.peNewAssessment.breedOfBird = constantToSave + (textField.text ?? "")
            self.peNewAssessment.breedOfBirdOther = txtBreedOfBirdsOthers.text
            self.txtBreedOfBirdsOthers.text = textField.text ?? ""
            checkBackAndSave()
        }
        if textField == self.manfacturerOtherTxt {
            self.peNewAssessment.manufacturer = constantToSave + (textField.text ?? "")
            self.manfacturerOtherTxt.text = textField.text ?? ""
            checkBackAndSave()
        }
        if textField == self.eggsOtherTxt {
            self.eggsOtherTxt.text = textField.text ?? ""
            let txt =  textField.text  ?? "0"
            let str =   txt  + "000"
            let iii = Int64(str)
            if iii != nil{
                self.peNewAssessment.noOfEggs =  iii//Int(iii)
            }
            checkBackAndSave()
        }
        
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.eggsOtherTxt {
            // return true if the string only contains numeric characters
            if string == "" {
                return true
            }
            let isValid = string.stringWithoutWhitespaces.isNumber
            let aSet = CharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            let maxLength = 4
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            
            return string == numberFiltered && newString.length <= maxLength
            
            return isValid
        }
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder();
        return true;
    }
}



