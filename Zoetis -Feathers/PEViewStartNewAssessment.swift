//
//  PEStartNewAssessment.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 13/12/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit
import CoreData

class PEViewStartNewAssessment: BaseViewController {
    
    
    var deviceIDFORSERVER = ""
    var saveTypeString : [Int] = []
    var inovojectData : [InovojectData] = []
    var dayOfAgeData : [InovojectData] = []
    var dayOfAgeSData : [InovojectData] = []
    var certificateData : [PECertificateData] = []
    var callRequest4Int = 0
    var totalImageToSync : [Int] = []
    var peAssessmentSyncArray : [PENewAssessment] = []
    var peHeaderViewController:PEHeaderViewController!
    var peNewAssessment:PENewAssessment!
    let dropdownManager = ZoetisDropdownShared.sharedInstance
    var jsonRe : JSON = JSON()
    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
    var isFlockAgeGreaterTheAllProd : Bool = false
    var isFlockAgeGreaterThen50Weeks : Bool = false
    var constantToSave : String = "S"
    var  regionID = Int()
    var draftArray = [PENewAssessment]()
    var editExtendedMicro = String()
    
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var extendedPELbl: PEFormLabel!
    @IBOutlet weak var extendedPESwitch: UISwitch!
    @IBOutlet weak var btn_MoveToDraft: UIButton!
    @IBOutlet weak var chlorineStripsSwitch: UISwitch!
    @IBOutlet weak var heightFlockAge: NSLayoutConstraint!
    @IBOutlet weak var topIncubation: NSLayoutConstraint!
    @IBOutlet weak var heightIncubation: NSLayoutConstraint!
    @IBOutlet weak var topBreed: NSLayoutConstraint!
    @IBOutlet weak var heightBreed: NSLayoutConstraint!
    @IBOutlet weak var syncWebBtn: UIButton!
    @IBOutlet weak var manfacturerOtherBtn: customButton!
    @IBOutlet weak var manfacturerOtherTxt: PEFormTextfield!
    @IBOutlet weak var isAutomaticFailView: UIView!
    @IBOutlet weak var isAutomaticSwitch: UISwitch!
    @IBOutlet weak var isAutomaticHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var eggsOtherBtn: customButton!
    @IBOutlet weak var eggsOtherTxt: PEFormTextfield!
    @IBOutlet weak var notesTop: NSLayoutConstraint!
    @IBOutlet weak var heightManufacturerView: NSLayoutConstraint!
    @IBOutlet weak var heightNumberOfEggsView: NSLayoutConstraint!
    @IBOutlet weak var selectedEvaluationDateText: UITextField!
    @IBOutlet weak var selectedCustomerText: UITextField!
    @IBOutlet weak var selectedSiteText: UITextField!
    @IBOutlet weak var selectedEvaluatorText: UITextField!
    @IBOutlet weak var selectedTSR: UITextField!
    @IBOutlet weak var selectedEvaluationType: UITextField!
    @IBOutlet weak var selectedVisitText: UITextField!
    @IBOutlet weak var customerButton: customButton!
    @IBOutlet weak var siteButton: customButton!
    @IBOutlet weak var evaluatorButton: customButton!
    @IBOutlet weak var visitButton: customButton!
    @IBOutlet weak var evaluationTypeButton: customButton!
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
    @IBOutlet weak var manufacturerButton: customButton!
    @IBOutlet weak var txtManufacturer: PEFormTextfield!
    @IBOutlet weak var txtNumberOfEggs: PEFormTextfield!
    @IBOutlet weak var numberOfEggsButton: customButton!
    @IBOutlet weak var btnFlockAgeGreater: UIButton!
    @IBOutlet weak var btnFlockImageLower: UIButton!
    @IBOutlet weak var flockView: UIView!
    @IBOutlet weak var flockAgeLower: UILabel!
    @IBOutlet weak var btnBreed: customButton!
    @IBOutlet weak var btnBreedOthers: customButton!
    @IBOutlet weak var btnIncubation: customButton!
    @IBOutlet weak var btnIncubationOthers: customButton!
    @IBOutlet weak var txtBreedOfBird: PEFormTextfield!
    @IBOutlet weak var txtBreedOfBirdsOthers: PEFormTextfield!
    @IBOutlet weak var txtIncubation: PEFormTextfield!
    @IBOutlet weak var txtIncubationOthers: PEFormTextfield!
    @IBOutlet weak var handmixSwitch: UISwitch!
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        btn_MoveToDraft.isHidden = true
        let dateFormatter = DateFormatter()
        setupUI()
        dateFormatter.dateFormat="MM/dd/yyyy"
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let currentDate: NSDate = NSDate()
        let strdate1 = dateFormatter.string(from: currentDate as Date) as String
        self.cameraSwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        self.extendedPESwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        self.hatcherySwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        self.chlorineStripsSwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        self.isAutomaticSwitch.tintColor = UIColor.getTextViewBorderColorStartAssessment()
        peHeaderViewController = PEHeaderViewController()
        peHeaderViewController.titleOfHeader = "View Assessment"
        peHeaderViewController.assId = "C-\(peNewAssessment.dataToSubmitID!)"
        self.headerView.addSubview(peHeaderViewController.view)
        self.topviewConstraint(vwTop: peHeaderViewController.view)
        
        notesTextView.delegate = self
        notesTextView.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
        notesTextView.textContainer.lineFragmentPadding = 12
        notesTextView.text = ""
        notesTextView.text =  peNewAssessment.notes
        selectedCustomerText.text = peNewAssessment.customerName
        selectedSiteText.text =  peNewAssessment.siteName
        let defautUsername =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        
        if peNewAssessment.evaluationDate == "" {
            selectedEvaluationDateText.text = strdate1
            self.peNewAssessment.evaluationDate = strdate1
        } else {
            selectedEvaluationDateText.text = peNewAssessment.evaluationDate ?? strdate1
        }
        self.peNewAssessment.evaluationID = peNewAssessment.evaluationID
        selectedEvaluatorText.text =  peNewAssessment.evaluatorName ?? defautUsername
        selectedEvaluationType.text = peNewAssessment.evaluationName ?? ""
        
        if self.peNewAssessment.manufacturer?.count ?? "".count > 0 {
            txtManufacturer.text = self.peNewAssessment.manufacturer
        }
        if self.peNewAssessment.noOfEggs ?? 0 > 0 {
            txtNumberOfEggs.text = String(self.peNewAssessment.noOfEggs ?? 0)
        }
        
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
        txtIncubationOthers.text =   self.peNewAssessment.incubationOthers
        
        
        if selectedEvaluationType.text == "" {
            hideFlockView()
        } else {
            if selectedEvaluationType.text?.contains("Non") ?? false  {
                self.flockAgeLower.isHidden = true
                self.btnFlockImageLower.isHidden = true
                self.heightFlockAge.constant = 51
            } else {
                self.flockAgeLower.isHidden = false
                self.btnFlockImageLower.isHidden = false
                self.heightFlockAge.constant = 78
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
        
        if peNewAssessment.isHandMix == true{
            
            handmixSwitch.setOn(true, animated: false)
        } else {
            handmixSwitch.setOn(false, animated: false)
        }
        
        labelEvaluationDate.addLabelWithAstric(placeHolder: "Evaluation Date")
        labelCustomer.addLabelWithAstric(placeHolder: "Customer")
        labelSite.addLabelWithAstric(placeHolder: "Site")
        labelEvaluationType.addLabelWithAstric(placeHolder: "Evaluation Type")
        labelReasonForVisit.addLabelWithAstric(placeHolder: "Reason for visit")
        labelEvaluator.addLabelWithAstric(placeHolder: "Evaluator")
        peNewAssessment.evaluatorName =  UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        peNewAssessment.evaluatorID = userID
        selectedTSR.text = peNewAssessment.selectedTSR
        if peNewAssessment.selectedTSR?.count ?? 0 > 1 {
            selectedTSR.text = peNewAssessment.selectedTSR
        }
        else {
            print("test message")
        }
        hideManufacturerOthers()
        hideEggsOthers()
        txtManufacturer.text = self.peNewAssessment.manufacturer ?? ""
        if  txtManufacturer.text != "" {
            if let character = peNewAssessment.manufacturer?.character(at:0) {
                if txtManufacturer.text == "Other"{
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
        manfacturerOtherTxt.isUserInteractionEnabled = false
        eggsOtherTxt.isUserInteractionEnabled = false
        txtManufacturer.isUserInteractionEnabled = false
        txtNumberOfEggs.isUserInteractionEnabled = false
        if peNewAssessment.isFlopSelected == 1 ||  peNewAssessment.isFlopSelected == 3 ||  peNewAssessment.isFlopSelected == 4 {
            isFlockAgeGreaterTheAllProd = true
            btnFlockAgeGreater.setImage(UIImage(named: "checkIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = false
            btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        } else  if peNewAssessment.isFlopSelected == 2 ||  peNewAssessment.isFlopSelected == 5  {
            isFlockAgeGreaterTheAllProd = false
            btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = true
            btnFlockImageLower.setImage(UIImage(named: "checkIconPE"), for: .normal)
        }
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
        if peNewAssessment?.isChlorineStrip ?? 0 == 1{
            chlorineStripsSwitch.isOn = true
        }else{
            chlorineStripsSwitch.isOn = false
        }
        if peNewAssessment?.isAutomaticFail ?? 0 == 1{
            isAutomaticSwitch.isOn = true
        }else{
            isAutomaticSwitch.isOn = false
        }
        if chlorineStripsSwitch.isOn{
            self.isAutomaticHeightConstraints.constant = 0
            self.isAutomaticFailView.isHidden = true
        }else{
            self.isAutomaticHeightConstraints.constant = 40
            self.isAutomaticFailView.isHidden = false
        }
        
        showExtendedPE()
        enableExtendedPE(flag:false)
        
        extendedPESwitch.isOn = peNewAssessment.sanitationValue ?? false
        
        if peNewAssessment.evaluationID != nil{
            if peNewAssessment.evaluationID == 1{
                self.inventoryView.isHidden = false
            }else{
                self.peNewAssessment.isHandMix = false
                self.inventoryView.isHidden = true
            }
        }
        else{
            self.peNewAssessment.isHandMix = false
            self.inventoryView.isHidden = true
        }
    }
    
    // MARK: - Assign Constraint
    func assignConstraint(otherEgg:Int = 0){
        let leftConst = leftConstraint()
        var rightConst = rightConstraint()
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
            case 2:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20 ))
                }
            default:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 40))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 60))
                }
            }
            
        case 1:
            
            switch rightConst {
                
            case 1:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20 ))
                }
            case 2:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 50))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 50))
                }
            default:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 50))
                }
            }
        case 2:
            
            switch rightConst {
                
            case 1:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 30))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 30))
                }
            case 2:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 75))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) - 75))
                }
            default:
                if heightNumberOfEggsView.constant == 94{
                    notesTop.constant = CGFloat(((leftConst * 55 ) ))
                }else{
                    notesTop.constant = CGFloat(((leftConst * 55 ) + 20))
                }
            }
            
        default:
            break;
        }
        
    }
    
    // MARK: - Setup Left Constraint
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
    // MARK: - Setup Right Constraint
    func rightConstraint()-> Int{
        var otherCount = 0
        
        if ((self.txtManufacturer.text?.lowercased().contains("other")) ?? false) {
            otherCount += 1
        } else if self.txtManufacturer.text?.contains("S") ?? false {
            otherCount += 1
        }
        
        let xx = String(self.peNewAssessment.noOfEggs ?? 000)
        if xx != "0" {
            let last3 = String(xx.suffix(3))
            if last3 ==  "000" {
                otherCount += 1
                
            }
        }
        return otherCount
    }
    
    
    // MARK: - Show Extended PE View
    func showExtendedPE(flag:Bool = false){
        extendedPELbl.isHidden = flag
        extendedPESwitch.isHidden = flag
    }
    // MARK: - Enable Extended Microbial
    func enableExtendedPE(flag:Bool = true){
        extendedPELbl.isUserInteractionEnabled = flag
        extendedPESwitch.isUserInteractionEnabled = flag
    }
    
    // MARK: - Hide Manufacturer Other View
    func hideManufacturerOthers(){
        assignConstraint()
        heightManufacturerView.constant = 45
        manfacturerOtherBtn.isHidden = true
        manfacturerOtherTxt.isHidden = true
        self.view.layoutIfNeeded()
    }
    // MARK: - Show Manufacturer Other View
    func showManufacturerOthers(){
        assignConstraint()
        heightManufacturerView.constant = 94
        manfacturerOtherBtn.isHidden = false
        manfacturerOtherTxt.isHidden = false
        self.view.layoutIfNeeded()
    }
    // MARK: - Hide Egg Other View
    func hideEggsOthers(){
        heightNumberOfEggsView.constant = 45
        assignConstraint()
        eggsOtherBtn.isHidden = true
        eggsOtherTxt.isHidden = true
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Show Egg Other View
    func showEggsOthers(){
        
        heightNumberOfEggsView.constant = 94
        assignConstraint()
        eggsOtherBtn.isHidden = false
        eggsOtherTxt.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    // MARK: - Hide Flock View
    func hideFlockView(){
        flockView.isHidden = true
        heightFlockAge.constant = 0
    }
    // MARK: - Show Flock View
    func showFlockView(){
        flockView.isHidden = false
    }
    // MARK: - Get VAccine Mixture API
    private func getVaccineMixerList(customerId: Int, siteId: Int, countryId: Int, _ completion: @escaping (_ status: Bool) -> Void){
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
        
    }
    // MARK: - Setup UI Method
    func setupUI(){
        btnNext.setNextButtonUI()
        syncWebBtn.setSyncWebButtonUI()
        viewForGradient.setGradientThreeColors(topGradientColor: UIColor.getGradientUpperColorStartAssessment(),midGradientColor:UIColor.getGradientUpperColorStartAssessmentMid(), bottomGradientColor: UIColor.getGradientUpperColorStartAssessmentLast())
        containerView.setCornerRadiusFloat(radius: 23)
        viewForGradient.setCornerRadiusFloat(radius: 23)
        let btns = [customerButton,siteButton,evaluatorButton,visitButton,evaluationTypeButton,tsrButton,evaluationDateButton,btnBreed,btnBreedOthers,btnIncubation,btnIncubationOthers,manufacturerButton,numberOfEggsButton]
        customerButton.isUserInteractionEnabled = false
        siteButton.isUserInteractionEnabled = false
        customerButton.isEnabled = false
        customerButton.alpha = 0.6
        siteButton.isEnabled = false
        siteButton.alpha = 0.6
        
        for btn in btns{
            let superviewCurrent =  btn?.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        if view == evaluationDateButton{
                            view.setDropdownStartAsessmentView(imageName:"calendarIconPE")
                        } else{
                            view.setDropdownStartAsessmentView(imageName:"dd")
                        }
                    }
                }}
        }
        notesTextView.layer.cornerRadius = 12
        notesTextView.layer.masksToBounds = true
        notesTextView.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
        notesTextView.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.btn_MoveToDraft.isHidden = true
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithAssIDFor(entityName: "PE_AssessmentInOffline", assId: peNewAssessment.serverAssessmentId ?? "")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
        
        
        var carColIdArrayDraft : [Int] = []
        
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArrayDraft.contains(obj as? Int ?? 0){
                carColIdArrayDraft.append(obj as? Int ?? 0)
            }
        }
        
        navigationController?.navigationBar.isHidden = true
        if self.peNewAssessment.hatcheryAntibiotics == 1{
            self.hatcherySwitch.isOn = true//hatcherySwitch.isOn
        } else{
            self.hatcherySwitch.isOn = false
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0].peNewAssessment = peNewAssessment
    }
    
    // MARK: - Get All Drafted Assessments Stored in DB
    private func getAllDateArrayStored() -> [String]{
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
    // MARK: - Get All Customer's Stored in DB
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
    // MARK: - Get All Sites Stored in DB
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
    
    @IBAction func btnAction(_ sender: Any) {
        print("Test Message",appDelegate.testFuntion())
    }
    // MARK: - Hide Breed Other
    func hideBreedOthers(){
        heightBreed.constant = 45
        btnBreedOthers.isHidden = true
        txtBreedOfBirdsOthers.isHidden = true
    }
    // MARK: - Show Breed Other
    func showBreedOthers(){
        heightBreed.constant = 104
        btnBreedOthers.isHidden = false
        txtBreedOfBirdsOthers.isHidden = false
    }
    // MARK: - Hide Incubation Other
    func hideIncubationOthers(){
        heightIncubation.constant = 45
        btnIncubationOthers.isHidden = true
        txtIncubationOthers.isHidden = true
    }
    // MARK: - Show Incubatio Other
    func showIncubationOthers(){
        heightIncubation.constant = 104
        btnIncubationOthers.isHidden = false
        txtIncubationOthers.isHidden = false
    }
    
    
    func hideTreeOthers(){
        heightManufacturerView.constant = 45
        btnIncubationOthers.isHidden = true
        txtIncubationOthers.isHidden = true
    }
    
    func showTreeOthers(){
        heightManufacturerView.constant = 94
        btnIncubationOthers.isHidden = false
        txtIncubationOthers.isHidden = false
    }
    // MARK: - Get Draft Count
    func getDraftCountFromDb() -> Int {
        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInDraft")
        _  = allAssesmentDraftArr.value(forKey: "draftNumber") as? NSArray ?? []
        _  = allAssesmentDraftArr.value(forKey: "serverAssessmentId") as? NSArray ?? []
        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "draftID") as? NSArray ?? []
        var carColIdArray : [String] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? String ?? ""){
                carColIdArray.append(obj as? String ?? "")
            }
        }
        return carColIdArray.count
    }
    // MARK: - Draft Button Action
    @IBAction func action_MoveToDraft(_ sender: Any) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    // MARK: - Next Button Action
    @IBAction func nextBtnAction(_ sender: Any) {
        Constants.isPPmValueChanged = false
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEViewAssesmentFinalize") as! PEViewAssesmentFinalize
        vc.peNewAssessment = self.peNewAssessment
        self.navigationController?.pushViewController(vc, animated: true)
        return
        
    }
    
    func saveAssessmentInProgressDataInDB()  {
        print("Test Message",appDelegate.testFuntion())
    }
    
    // MARK: - Mandatory Field Validation
    func changeMandatorySuperviewToRed(){
        let date = self.peNewAssessment.evaluationDate ?? ""
        let customer = self.peNewAssessment.customerName ?? ""
        let site = self.peNewAssessment.siteName ?? ""
        let evaluationName = self.peNewAssessment.evaluationName ?? ""
        let evaluator = self.peNewAssessment.evaluatorName ?? ""
        let reasonForVisit = self.peNewAssessment.visitName ?? ""
        if (date.count > 0 ?? 0){print("Test message")} else  {
            let superviewCurrent =  evaluationDateButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }}
        }
        if (customer.count > 0 ?? 0 ){print("Test message")} else  {
            let superviewCurrent =  customerButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }
            }
        }
        if (site.count > 0 ?? 0){print("Test message")} else  {
            let superviewCurrent =  siteButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }}
        }
        if (evaluationName.count ?? 0 > 0){print("Test message")} else  {
            let superviewCurrent =  evaluationTypeButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }}
        }
        if (evaluator.count ?? 0  > 0){print("Test message")} else  {
            let superviewCurrent =  evaluatorButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }}
        }
        if (reasonForVisit.count ?? 0 > 0){print("Test message")} else  {
            let superviewCurrent =  visitButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }
                }}
        }
        
        showAlert(title: "Alert", message: "Please fill the mandatory fields.", owner: self)
    }
    
    // MARK: - Evaluation Date Button Action
    @IBAction func evaluationDateClicked(_ sender: Any) {
        let superviewCurrent =  evaluationDateButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        datePickerPopupViewController.canSelectPreviousDate = true
        navigationController?.present(datePickerPopupViewController, animated: false, completion: nil)
        
        
    }
    
    // MARK: - Customer Button Action
    @IBAction func customerClicked(_ sender: Any) {
        let superviewCurrent =  customerButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
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
                let cusId = self.peNewAssessment.customerId ?? 0
                
            }
            self.dropHiddenAndShow()
        }
    }
    
    // MARK: - Complex Site Button Clicked
    @IBAction func siteClicked(_ sender: Any) {
        
        let superviewCurrent =  siteButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.lightGray.cgColor
                    view.layer.borderWidth = 2.0
                }}
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
                self.saveAssessmentInProgressDataInDB()
            }
            self.dropHiddenAndShow()
        } else{
            print("test message")
        }
    }
    // MARK: - Evaluator Button Clicked
    @IBAction func evaluatorClicked(_ sender: Any) {
        let superviewCurrent =  evaluatorButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        
        var customerNamesArray = NSArray()
        var evaluatorIDArray = NSArray()
        var evaluatorNameArray = NSArray()
        var evaluatorDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Evaluator")
        evaluatorNameArray = evaluatorDetailsArray.value(forKey: "evaluatorName") as? NSArray ?? NSArray()
        evaluatorIDArray = evaluatorDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  evaluatorNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: evaluatorNameArray as? [String] ?? [String](), kWidth: evaluatorButton.frame.width, kAnchor: evaluatorButton, yheight: evaluatorButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedEvaluatorText.text = selectedVal
                self.peNewAssessment.evaluatorName = selectedVal
                let indexOfItem = evaluatorNameArray.index(of: selectedVal)
                self.peNewAssessment.evaluatorID = evaluatorIDArray[indexOfItem] as? Int
                self.saveAssessmentInProgressDataInDB()
            }
            self.dropHiddenAndShow()
        }
    }
    // MARK: - Visit Button Clicked
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
        var visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VisitTypes")
        visitNameArray = visitDetailsArray.value(forKey: "visitName") as? NSArray ?? NSArray()
        visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  visitNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: visitNameArray as? [String] ?? [String](), kWidth: visitButton.frame.width, kAnchor: visitButton, yheight: visitButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedVisitText.text = selectedVal
                self.peNewAssessment.visitName = selectedVal
                let indexOfItem = visitNameArray.index(of: selectedVal)
                self.peNewAssessment.visitID = visitIDArray[indexOfItem] as? Int
                self.saveAssessmentInProgressDataInDB()
            }
            self.dropHiddenAndShow()
        }
    }
    // MARK: - Evaluation Type Button Action
    @IBAction func evaluationClicked(_ sender: Any) {
        
        let superviewCurrent =  evaluationTypeButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        
        var evaluationIDArray = NSArray()
        var evaluationNameArray = NSArray()
        var evaluationDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_EvaluationType")
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
                    self.heightFlockAge.constant = 51
                    self.flockAgeLower.isHidden = true
                    self.btnFlockImageLower.isHidden = true
                } else {
                    self.heightFlockAge.constant = 78
                    self.flockAgeLower.isHidden = false
                    self.btnFlockImageLower.isHidden = false
                }
                
                self.peNewAssessment.evaluationName = selectedVal
                let indexOfItem = evaluationNameArray.index(of: selectedVal)
                self.peNewAssessment.evaluationID = evaluationIDArray[indexOfItem] as? Int
                self.saveAssessmentInProgressDataInDB()
            }
            self.dropHiddenAndShow()
        }
    }
    // MARK: - Flock Image Greater Action
    @IBAction func flockImageGreaterSlected(_ sender: Any) {
        self.peNewAssessment.isFlopSelected = 2
        if isFlockAgeGreaterTheAllProd {
            isFlockAgeGreaterTheAllProd = false
            btnFlockAgeGreater.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = true
            btnFlockImageLower.setImage(UIImage(named: "checkIconPE"), for: .normal)
        } else {
            isFlockAgeGreaterTheAllProd = true
            btnFlockAgeGreater.setImage(UIImage(named: "checkIconPE"), for: .normal)
            isFlockAgeGreaterThen50Weeks = false
            btnFlockImageLower.setImage(UIImage(named: "uncheckIconPE"), for: .normal)
        }
        self.saveAssessmentInProgressDataInDB()
    }
    // MARK: - Flock Image Lower Action
    @IBAction func flockImageLowerSelected(_ sender: Any) {
        self.peNewAssessment.isFlopSelected = 3
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
        self.saveAssessmentInProgressDataInDB()
    }
    
    // MARK: - Button TSR Action
    @IBAction func tsrClicked(_ sender: Any) {
        let RoleId =  UserDefaults.standard.string(forKey: "RoleId")
        var arr : [String] = []
        if RoleId == "TSR"{
            arr = ["Self","TSR"]
        } else {
            arr =  ["TSR"]
        }
        let superviewCurrent =  tsrButton.superview
        if superviewCurrent != nil{
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    view.layer.borderColor = UIColor.getTextViewBorderColorStartAssessment().cgColor
                    view.layer.borderWidth = 2.0
                }}
        }
        var visitIDArray = NSArray()
        var visitNameArray = NSArray()
        var visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Approvers")
        visitNameArray = visitDetailsArray.value(forKey: "username") as? NSArray ?? NSArray()
        visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  visitNameArray.count > 0 {
            self.dropDownVIewNew(arrayData: visitNameArray as? [String] ?? [String](), kWidth: tsrButton.frame.width, kAnchor: tsrButton, yheight: tsrButton.bounds.height) { [unowned self] selectedVal, index  in
                self.selectedTSR.text = selectedVal
                self.peNewAssessment.selectedTSR = selectedVal
                let indexOfItem = visitNameArray.index(of: selectedVal)
                self.peNewAssessment.selectedTSRID = visitIDArray[indexOfItem] as? Int
                self.saveAssessmentInProgressDataInDB()
                
            }
            self.dropHiddenAndShow()
        }
    }
  
    // MARK: - Switch Action
    @IBAction func switchClicked(_ sender: Any) {
        if cameraSwitch.isOn {
            peNewAssessment.camera = 1
        } else {
            peNewAssessment.camera = 0
        }
        if hatcherySwitch.isOn {
            peNewAssessment.hatcheryAntibiotics = 1
        } else {
            peNewAssessment.hatcheryAntibiotics = 0
        }
        self.saveAssessmentInProgressDataInDB()
    }

    // MARK: - Button Breed Action
    @IBAction func btnBreedClicked(_ sender: Any) {
        self.dropDownVIewNew(arrayData: ["Breed1","Breed2","Breed3","Other"], kWidth: btnBreed.frame.width, kAnchor: btnBreed, yheight: btnBreed.bounds.height) { [unowned self] selectedVal, index  in
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
            self.saveAssessmentInProgressDataInDB()
        }
        self.dropHiddenAndShow()
        
    }
    
    // MARK: - Button Incubation Action
    @IBAction func btnIncubationClicked(_ sender: Any) {
        self.dropDownVIewNew(arrayData: ["Style1","Style2","Style3","Other"], kWidth: btnIncubation.frame.width, kAnchor: btnIncubation, yheight: btnIncubation.bounds.height) { [unowned self] selectedVal, index  in
            self.peNewAssessment.selectedTSR = selectedVal
            
            self.txtIncubation.text = selectedVal
            if selectedVal == "Other"{
                self.peNewAssessment.breedOfBird = "Other"
                self.showIncubationOthers()
            } else {
                self.peNewAssessment.breedOfBird = selectedVal
                self.hideIncubationOthers()
            }
            self.saveAssessmentInProgressDataInDB()
        }
        self.dropHiddenAndShow()
        
    }
        
    // MARK: - DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
}

// MARK: - Other Delegates
extension PEViewStartNewAssessment: DatePickerPopupViewControllerProtocol{
    func doneButtonTappedWithDate(string: String, objDate: Date) {
        let datesStored =  getAllDateArrayStored()
        let customerStored = getAllCustomerArrayStored()
        let sitesStored = getAllSitesArrayStored()
        if datesStored.contains(string) && customerStored.contains(self.peNewAssessment.customerName ?? "") && sitesStored.contains(self.peNewAssessment.siteName ?? "") {
            let superviewCurrent =  evaluationDateButton.superview
            if superviewCurrent != nil{
                for view in superviewCurrent!.subviews {
                    if view.isKind(of:UIButton.self) {
                        view.layer.borderColor = UIColor.red.cgColor
                        view.layer.borderWidth = 2.0
                    }}
            }
            showAlert(title: "Alert", message: "Assessment Data already Exists for this Customer, Site & Date combination", owner: self)
            return
        }  else {
            selectedEvaluationDateText.text = string
            self.peNewAssessment.evaluationDate = string
            saveAssessmentInProgressDataInDB()
        }
    }
    
    func doneButtonTapped(string:String){
        print("Test Message",appDelegate.testFuntion())
    }
}

// MARK: - Other Delegates
extension PEViewStartNewAssessment{
    
    func getEvaluationFromBackend(){
        print("Test Message",appDelegate.testFuntion())
    }
    
    // MARK: - Ok Button tabbed
    func okButtonTapped() {
        
        getEvaluationFromBackend()
        saveAssessmentInProgressDataInDB()
        jsonRe = (getJSON("QuestionAns") ?? JSON())
        pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(jsonRe)
        let categoryCount = filterCategoryCount()
        if categoryCount > 0 {
            var peNewAssessmentWas = PENewAssessment()
            peNewAssessmentWas = self.peNewAssessment
            
            CoreDataHandler().deleteAllData("PE_AssessmentInProgress",predicate: NSPredicate(format: "userID == %d AND serverAssessmentId = %@", peNewAssessmentWas.userID ?? 0, peNewAssessmentWas.serverAssessmentId ?? ""))
            CoreDataHandler().deleteAllData("PE_Refrigator")
            
            for  cat in  pECategoriesAssesmentsResponse.peCategoryArray {
                for (index, ass) in cat.assessmentQuestions.enumerated(){
                    var peNewAssessmentNew = PENewAssessment()
                    peNewAssessmentNew = peNewAssessmentWas
                    peNewAssessmentNew.cID = index
                    peNewAssessmentNew.catID = cat.id
                    peNewAssessmentNew.catName = cat.categoryName
                    peNewAssessmentNew.catMaxMark = cat.maxMark
                    peNewAssessmentNew.sequenceNo = cat.sequenceNo
                    peNewAssessmentNew.sequenceNoo = cat.sequenceNo
                    peNewAssessmentNew.catResultMark = cat.maxMark
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
                    peNewAssessmentNew.assStatus = 1
                    peNewAssessmentNew.informationImage = ass.informationImage
                    peNewAssessmentNew.informationText = ass.informationText
                    peNewAssessmentNew.isNA = ass.isNA
                    peNewAssessmentNew.isAllowNA = ass.isAllowNA
                    peNewAssessmentNew.qSeqNo = ass.qSeqNo
                    peNewAssessmentNew.rollOut = ass.rollOut
                    CoreDataHandlerPE().saveNewAssessmentInProgressInDB(newAssessment:self.peNewAssessment)
                }
            }
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as! PEAssesmentFinalize
            vc.peNewAssessment = self.peNewAssessment
            self.navigationController?.pushViewController(vc, animated: true)
            return
        } else {
            print("test message")
        }
    }
    // MARK: - Filter Category Count
    func filterCategoryCount() -> Int {
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray{
            if peNewAssessment.evaluationID == object.evaluationID{
                peCategoryFilteredArray.append(object)
            }
        }
        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
        return pECategoriesAssesmentsResponse.peCategoryArray.count ?? 0
    }
    // MARK: - Clean Session
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

// MARK: - Extension & Textview Delegates
extension PEViewStartNewAssessment:UITextViewDelegate{
    //MARK...
    
    func textViewShouldBeginEditing(_ _textView: UITextView) -> Bool {
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView == notesTextView ) {
            saveAssessmentInProgressDataInDB()
        }
    }
}

// MARK: - WebServices
extension PEViewStartNewAssessment {
    
    internal func fetchtAssessmentCategoriesResponse(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as! PEAssesmentFinalize
        vc.peNewAssessment = self.peNewAssessment
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func handleAssessmentCategoriesResponse(_ json: JSON) {
        print("Test Message",appDelegate.testFuntion())
    }
    
}
// MARK: - Extension Textfield Deletgates
extension PEViewStartNewAssessment : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.txtBreedOfBird.text = constantToSave + (textField.text ?? "")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
}

extension PEViewStartNewAssessment{
    
    
    
    
    
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
//        olDateFormatter.calendar = Calendar(identifier: .gregorian)
//        olDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        olDateFormatter.dateFormat = "MMM d, yyyy"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
//        convertDateFormatter.calendar = Calendar(identifier: .gregorian)
//        convertDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        convertDateFormatter.dateFormat = "yyyy-MM-dd"
        if oldDate != nil{
            return convertDateFormatter.string(from: oldDate!)
        }
        return ""
    }
    
    
    // MARK: - Date Formatter
    func convertSign_DateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "MMM d, yyyy"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyyy-MM-dd"
        
        if oldDate != nil{
            return convertDateFormatter.string(from: oldDate!)
        }
        return ""
    }
    
    // MARK: - Create Sync request
    func createSyncRequest(dict: PENewAssessment ,certificationData : [PECertificateData]) -> JSONDictionary{
        print("dict---\(dict)")
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dict.dataToSubmitID ?? ""
        
        let evaluationDate = dict.evaluationDate
        if UniID == "" {
            UniID = dict.draftID ?? ""
        }
        var Complete = 1
        var Draft = 0
        var SaveType = 1
        saveTypeString.append(11)
        var AssessmentId = dict.dataToSubmitNumber ?? 0
        
        let deviceIdForServer = "\(UniID)_1_iOS_\(udid)"
        deviceIDFORSERVER = deviceIdForServer
        
        if AssessmentId == 0 {
            if dict.assDetail2?.lowercased().contains("_1_ios") ?? false{
                deviceIDFORSERVER = dict.assDetail2 ?? ""
            }
            AssessmentId = dict.draftNumber ?? 0
            Draft = 1
            Complete = 0
            SaveType = 0
            saveTypeString.append(00)
        }
        if dict.assDetail2?.lowercased().contains("_1_ios") ?? false{
            deviceIDFORSERVER = dict.assDetail2 ?? ""
        }
        var serverAssessmentId:Int64 = 0
        if dict.serverAssessmentId != nil{
            serverAssessmentId = Int64( dict.serverAssessmentId ?? "") ?? 0
        }
        let DocId = ""
        let VisitId = dict.visitID
        let CustomerId = dict.customerId
        let SiteId = dict.siteId
        let IncubationStyle = dict.incubation
        let EvaluationId = dict.evaluationID
        let BreedBirds = dict.breedOfBird
        var EvaluationDate = ""
        let EvaulaterId = dict.evaluatorID
        var hacheryAntibiotics:Bool = false
        if dict.hatcheryAntibiotics == 1{
            hacheryAntibiotics = true
        }
        
        var TSRIdUser = dict.selectedTSR
        var  TSRId  = dict.selectedTSRID
        
        var FSRsign = ""
        if certificationData.count > 0 {
            FSRsign = certificateData[0].fsrSign
        }
        
        let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Approvers")
        let visitNameArray = visitDetailsArray.value(forKey: "username") as? NSArray ?? NSArray ()
        let visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray ()
        if dict.selectedTSR?.count ?? 0 > 0 {
            if visitNameArray.contains(dict.selectedTSR ?? ""){
                let indexOfe =  visitNameArray.index(of: dict.selectedTSR ?? "") //
                TSRId = visitIDArray[indexOfe] as? Int ?? 0
            }
        }
        
        let HatchAnti = false
        var Camera = false
        if  dict.camera == 1 {
            Camera = true
        }
        
        var man = dict.manufacturer  ?? ""
        var manOther =  ""
        if  man != "" {
            if let character = dict.manufacturer?.character(at:0) {
                if character == "S"{
                    let str =  man.replacingOccurrences(of: "S", with: "")
                    manOther = str
                    man = "Other"
                }
            }
        }
        var eggg = ""
        var egggOther =  ""
        let xx = String(dict.noOfEggs ?? 000)
        if xx != "0" {
            let last3 = String(xx.suffix(3))
            if last3 ==  "000" {
                let str =  xx.replacingOccurrences(of: "000", with: "")
                egggOther = str
                eggg = "Other"
            } else {
                eggg = xx
            }
        }
        
        var breeedd = dict.breedOfBird  ?? ""
        var breeeddOther =  ""
        if breeedd != "" {
            if let character = breeedd.character(at:0) {
                if character == "S".character(at: 0){
                    let str =  breeedd.replacingOccurrences(of: "S", with: "")
                    breeeddOther = str
                    breeedd = "Other"
                    
                }
            }
        }
        breeeddOther = dict.breedOfBirdOther ?? ""
        
        var ManufacturerId = 0
        var EggID = 0
        var breeddId = 0
        var manufacutrerNameArray = NSArray()
        var manufacutrerIDArray = NSArray()
        var manufacutrerDetailsArray = NSArray()
        manufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Manufacturer")
        manufacutrerNameArray = manufacutrerDetailsArray.value(forKey: "mFG_Name") as? NSArray ?? NSArray()
        manufacutrerIDArray = manufacutrerDetailsArray.value(forKey: "mFG_Id") as? NSArray ?? NSArray()
        if man != "" {
            let indexOfd = manufacutrerNameArray.index(of: man) // 3
            ManufacturerId = manufacutrerIDArray[indexOfd] as? Int ?? 0
        }
        
        var BirdBreedIDArray = NSArray()
        var BirdBreedNameArray = NSArray()
        var BirdBreedDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BirdBreed")
        BirdBreedNameArray = BirdBreedDetailsArray.value(forKey: "birdBreedName") as? NSArray ?? NSArray()
        BirdBreedIDArray = BirdBreedDetailsArray.value(forKey: "birdId") as? NSArray ?? NSArray()
        if breeedd != "" {
            let indexOfe = BirdBreedNameArray.index(of: breeedd) // 3
            breeddId = BirdBreedIDArray[indexOfe] as? Int ?? 0
        }
        var EggsIDArray = NSArray()
        var EggsNameArray = NSArray()
        let EggsDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Eggs")
        EggsNameArray = EggsDetailsArray.value(forKey: "eggCount") as? NSArray ?? NSArray()
        EggsIDArray = EggsDetailsArray.value(forKey: "eggId") as? NSArray ?? NSArray()
        if eggg != "" {
            let indexOfp = EggsNameArray.index(of: eggg) // 3
            EggID = EggsIDArray[indexOfp] as? Int ?? 0
        }
        
        let FlockAgeId = dict.isFlopSelected
        let Status_Type = ""
        let UserId = dict
            .userID
        let RepresentativeName = ""
        let Notes = dict.notes
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY HH:mm:ss Z"
        let date = dict.evaluationDate?.toDate(withFormat: "MM/dd/YYYY")
        let datastr = date?.toString(withFormat: "MM/dd/YYYY HH:mm:ss Z")
        let  sig_Datetext = dict.sig_Date
        var dateSig = ""
        let ddd = dict.sig_Date ?? ""
        if ddd != "" {
            dateSig = self.convertDateFormat(inputDate: ddd)
        }
        
        let sig_Nametext2 = dict.sig_Name2
        let sig_Nametext = dict.sig_Name
        let sig_Phonetext = dict.sig_Phone
        let sig_EmployeeIDtext = dict.sig_EmpID
        let sig_EmployeeIDtext2 = dict.sig_EmpID2
        let sigNumber = dict.sig ?? 0
        let sigNumber2 = dict.sig2 ?? 0
        let statusType = dict.statusType ?? 0
        
        let isHandMix = dict.isHandMix ?? false
        let ppmValue = dict.ppmValue ?? ""
        
        var base64Str = ""
        var base64Str2 = ""
        if sigNumber == 0 {
            print("test message")
        } else {
            base64Str = CoreDataHandlerPE().getImageBase64ByImageID(idArray:(dict.sig) ?? 0)
        }
        if sigNumber2 == 0 {
            print("test message")
        } else {
            base64Str2 = CoreDataHandlerPE().getImageBase64ByImageID(idArray:(dict.sig2) ?? 0)
        }
        
        var DisplayId = dict.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        
        DisplayId = "C-" + UniID
        var iStle = 0
        var iStleIDArray = NSArray()
        var iStleNameArray = NSArray()
        let iStleDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_IncubationStyle")
        iStleNameArray = iStleDetailsArray.value(forKey: "incubationStylesName") as? NSArray ?? NSArray()
        iStleIDArray = iStleDetailsArray.value(forKey: "incubationId") as? NSArray ?? NSArray()
        if IncubationStyle?.count ?? 0 > 1 {
            let indexOfe = iStleNameArray.index(of: IncubationStyle ?? "") // 3
            iStle = iStleIDArray[indexOfe] as? Int ?? 0
        }
        var rollID = 0
        var rollIDArray = NSArray()
        var rollNameArray = NSArray()
        let rollDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Roles")
        rollNameArray = rollDetailsArray.value(forKey: "roleName") as? NSArray ?? NSArray()
        rollIDArray = rollDetailsArray.value(forKey: "roleId") as? NSArray ?? NSArray()
        if sig_EmployeeIDtext?.count ?? 0 > 1 {
            let indexOfe = rollNameArray.index(of: sig_EmployeeIDtext ?? "") // 3
            rollID = rollIDArray[indexOfe] as? Int ?? 0
        }
        
        var rollID2 = 0
        if sig_EmployeeIDtext2?.count ?? 0 > 1 {
            let indexOfe = rollNameArray.index(of: sig_EmployeeIDtext2 ?? "") // 3
            rollID2 = rollIDArray[indexOfe] as? Int ?? 0
        }
        
        var json : JSONDictionary = JSONDictionary()
        if dateSig != ""{
            print("test message")
        }else{
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "yyyy-MM-dd"
            convertDateFormatter.timeZone = Calendar.current.timeZone
            convertDateFormatter.locale = Calendar.current.locale
        }
        let userInfo = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: dict.serverAssessmentId ?? "")
        let dateFormatterObj = CodeHelper.sharedInstance.getDateFormatterObj("")
//        dateFormatterObj.dateFormat = "MM/dd/yyyy"
//        
//        let evalDateObj = dateFormatterObj.date(from: evaluationDate ?? "")
//        dateFormatterObj.dateFormat = "yyyy-MM-dd"
//        let evalDateStr = dateFormatterObj.string(from: evalDateObj ?? Date())
        let RegionalId = UserDefaults.standard.integer(forKey: "Regionid")
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        var evalDateStr = ""  //dateFormatterObj.string(from: evalDateObj ?? Date())
        if RegionalId == 3 {
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MM/dd/yyyy"

            // Convert the string to a Date object
            if let date = inputFormatter.date(from: evaluationDate ?? "") {
                
                // Create another DateFormatter for the desired output format
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd"
                
                // Convert the Date object back to a string
                let formattedDateString = outputFormatter.string(from: date)
                evalDateStr = formattedDateString
            } else {
                print("Invalid date format")
            }
        }
        else
        {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/MM/yyyy"

            if let date = inputFormatter.date(from: evaluationDate ?? "") {
            
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd"
                
                let formattedDateString = outputFormatter.string(from: date)
                evalDateStr = formattedDateString
            } else {
                print("Invalid date format")
            }
        }
        
        json = [
            "AppAssessmentId":String(AssessmentId),
            "DisplayId":DisplayId?.prefix(22),
            "VisitId": VisitId,
            "CustomerId": CustomerId,
            "SiteId": SiteId,
            "IncubationStyle": iStle,
            "EvaluationId": EvaluationId,
            "BreedBirds": breeddId == 0 ? "" : breeddId,
            "EvaluationDate": evalDateStr,
            "EvaulaterId": EvaulaterId ?? 0,
            "TSRId": TSRId,
            "Camera": Camera,
            "ManufacturerId": ManufacturerId == 0 ? "" : ManufacturerId,
            "EggsPerFlat": EggID == 0 ? "" : EggID,
            "Notes": Notes,
            "FlockAgeId": FlockAgeId == 0 ? "" : FlockAgeId,
            "SaveType":SaveType,
            "UserId": UserId,
            "DeviceId": deviceIDFORSERVER,
            "RepresentativeName":sig_Nametext,
            "RepresentativeName2":sig_Nametext2,
            "RepresentativeNotes":sig_Phonetext,
            "FSTSignatureImage": FSRsign,
            "SignatureImage": base64Str,
            "SignatureImage2": base64Str2,
            "ManufacturerOther": manOther,
            "BreedOfBirdsOther": breeeddOther,
            "EggsPerFlatOther": egggOther,
            "RoleId":rollID,
            "RoleId2":rollID2 == 0 ? "" : rollID2,
            "EvaluationTypeText": dict.evaluationName,
            "AppCreationTime": UniID.prefix(22),
            "SignatureDate":dateSig,
            "AssessmentId":serverAssessmentId,
            "DoubleSanitation":hacheryAntibiotics,
            "SanitationEmbrex": dict.sanitationValue ?? false,//userInfo?.isExtendedPE ?? false,
            "HasChlorineStrips" :  dict.isChlorineStrip ?? false,
            "IsAutomaticFail" :  dict.isAutomaticFail ?? false,
            "RefrigeratorNote": dict.refrigeratorNote ?? "",
            "RegionId" : RegionalId,
            "IsInterMicrobial": userInfo?.isExtendedPE ?? false,
            "CountryId":NewcountryId,
            "IsInovoFluids": false,
            "IsBasicTrfAssessment" :  false,
            "Handmix" : isHandMix ?? false,
            "Chlorine_Value" : ppmValue
        ] as JSONDictionary
        return json
    }
    
    // MARK: - Create Sync request for Inovoject
    func createSyncRequestForInvoject(dictArray: PENewAssessment,inovojectData :InovojectData) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        var score = 0
        var serverAssessmentId:Int64 = 0
        
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 270101
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        
        let  HatcheryAntibioticsInt = inovojectData.invoHatchAntibiotic
        var HatcheryAntibiotics = false
        if HatcheryAntibioticsInt == 1 {
            HatcheryAntibiotics = true
        }
        
        var x = 0
        var vvv = inovojectData.ampuleSize
        var ampleSizeesNameArray = NSArray()
        var ampleSizeIDArray = NSArray()
        var ampleSizeDetailArray = NSArray()
        ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
        ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
        ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
        if inovojectData.ampuleSize != "" {
            let xx = inovojectData.ampuleSize?.replacingOccurrences(of: " ", with: "")
            let indexOfe =  ampleSizeesNameArray.index(of: xx)
            x = ampleSizeIDArray[indexOfe] as? Int  ?? 0
        }
        
        var otherVaccine = ""
        var ManufacturerId = 0
        var vNameArray = NSArray()
        var vNameIDArray = NSArray()
        var vNameDetailsArray = NSArray()
        var VaccineId = 0
        vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
        vNameArray = vNameDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
        vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if vNameArray.contains(inovojectData.vaccineMan){
            let indexOfe = vNameArray.index(of: inovojectData.vaccineMan) // 3
            VaccineId = vNameIDArray[indexOfe] as? Int ?? 0
        } else {
            VaccineId = 0
        }
        
        var vNameDetailsArrayIS = NSArray()
        var vNameArrayIS = NSArray()
        var vNameIDArrayIS = NSArray()
        var vNameMfgIdArrayIS = NSArray()
        vNameDetailsArrayIS = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
        vNameArrayIS = vNameDetailsArrayIS.value(forKey: "name") as? NSArray ?? NSArray()
        vNameIDArrayIS = vNameDetailsArrayIS.value(forKey: "id") as? NSArray ?? NSArray()
        vNameMfgIdArrayIS = vNameDetailsArrayIS.value(forKey: "mfgId") as? NSArray ?? NSArray()
        
        if vNameArrayIS.contains(inovojectData.name){
            let indexOfe = vNameArrayIS.index(of: inovojectData.name) // 3
            VaccineId = vNameIDArrayIS[indexOfe] as? Int ?? 0
            ManufacturerId = vNameMfgIdArrayIS[indexOfe] as? Int ?? 0
        } else if (inovojectData.name != ""){
            otherVaccine = inovojectData.name ?? ""
        }
        var y = 2
        
        let DManufacturerId = 0
        var DNameArray = NSArray()
        var DNameIDArray = NSArray()
        var DNameDetailsArray = NSArray()
        DNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
        let indexOfg = DNameArray.index(of: inovojectData.vaccineMan)
        var dManufacture = 0
        
        let timestamp = Date().currentTimeMillis()
        let uni = ManufacturerId + Int(timestamp) + x
        
        let unique = "\(deviceIDFORSERVER)_\(inovojectData.id)_iOS_"
        
        let ampulePerBag = Int(inovojectData.ampulePerBag ?? "0")
        var AntibioticInformation  =  ""
        if HatcheryAntibiotics {
            AntibioticInformation =  inovojectData.invoHatchAntibioticText ?? ""
        }
        var json = [
            "VaccineId":  VaccineId == 0 ? "" : VaccineId,
            "AmpulePerbag":ampulePerBag == 0 ? "" : ampulePerBag,
            "AmpuleSize":  x == 0 ? "" : x,
            "AppAssessmentId": String(AssessmentId),
            "BagSizeType":inovojectData.bagSizeType,
            "Device_Id": deviceIDFORSERVER,
            "DiluentMfg": inovojectData.vaccineMan,
            "DisplayId": DisplayId?.prefix(22),
            "HatcheryAntibiotics": HatcheryAntibiotics,
            "ManufacturerId":  ManufacturerId == 0 ? "" : ManufacturerId,
            "ModuleAssessmentCatId": dictArray.catID,
            "Dosage": inovojectData.dosage,
            "StrUniqueId":unique,
            "OtherText":otherVaccine,
            "SecquenceId":0,
            "AntibioticInformation": AntibioticInformation,
            "DiluentsMfgOtherName":inovojectData.doaDilManOther ?? "",
            "ProgramName": inovojectData.invoProgramName,
            "AssessmentId":serverAssessmentId
            
        ] as JSONDictionary
        let doaDilManOther =  inovojectData.doaDilManOther ?? ""
        
        if doaDilManOther == "" {
            json.removeValue(forKey: "DiluentsMfgOtherName")
        }
        if ManufacturerId == 0  {
            json["ManufacturerId"] =  ManufacturerId == 0 ? "" : ManufacturerId
            json.removeValue(forKey: "ManufacturerId")
        }
        return json
        
    }
    // MARK: - Create Sync request for DOA Data
    func createSyncRequestForDOA(dictArray: PENewAssessment,dayOfAgeData :InovojectData) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        DisplayId = "C-" + UniID
        
        let  HatcheryAntibioticsInt = dictArray.hatcheryAntibioticsDoa
        var HatcheryAntibiotics = false
        if HatcheryAntibioticsInt == 1  {
            HatcheryAntibiotics = true
        }
        
        var x = 0
        var vvv = dayOfAgeData.ampuleSize
        var ampleSizeesNameArray = NSArray()
        var ampleSizeIDArray = NSArray()
        var ampleSizeDetailArray = NSArray()
        ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
        ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
        ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
        
        if dayOfAgeData.ampuleSize != "" {
            let xx = dayOfAgeData.ampuleSize?.replacingOccurrences(of: " ", with: "")
            let indexOfe =  ampleSizeesNameArray.index(of: xx)
            x = ampleSizeIDArray[indexOfe] as? Int  ?? 0
        }
        
        var VaccineId = 0
        var otherVaccine = ""
        var ManufacturerId = 0
        var vNameArray = NSArray()
        var vNameIDArray = NSArray()
        var vNameDetailsArray = NSArray()
        vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 1)
        vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
        vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        var vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as? NSArray ?? NSArray()
        
        if vNameArray.contains(dayOfAgeData.name){
            let indexOfe =  vNameArray.index(of: dayOfAgeData.name)
            VaccineId = vNameIDArray[indexOfe] as? Int ?? 0
            ManufacturerId = vNameMfgIdArray[indexOfe] as? Int ?? 0
        }
        else if (dayOfAgeData.name != ""){
            otherVaccine = dayOfAgeData.name ?? ""
        }
        
        var vManufacutrerNameArray = NSArray()
        var vManufacutrerIDArray = NSArray()
        var vManufacutrerDetailsArray = NSArray()
        vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
        vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
        vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        
        if vManufacutrerNameArray.contains(dayOfAgeData.vaccineMan){
            let indexOfe =  vManufacutrerNameArray.index(of: dayOfAgeData.vaccineMan) //
            ManufacturerId = vManufacutrerIDArray[indexOfe] as? Int ?? 0
        }
        
        let timestamp = Date().currentTimeMillis()
        let uni = ManufacturerId + Int(timestamp) + x
        let unique = "\(deviceIDFORSERVER)_\(dayOfAgeData.id)_iOS_"
        let ampulePerBag = Int(dayOfAgeData.ampulePerBag ?? "0")
        var AntibioticInformation  =  ""
        
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: dictArray.serverAssessmentId ?? "")
        if HatcheryAntibiotics {
            AntibioticInformation =  dictArray.hatcheryAntibioticsDoaText ?? ""
        }
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        let json = [
            "AppAssessmentId": String(AssessmentId),
            "DayOfAgeAmpulePerbag": ampulePerBag == 0 ? "" : ampulePerBag,
            "DayOfAgeAmpuleSize":  x == 0 ? "" : x,
            "DayOfAgeBagSizeType": dictArray.dDT,
            "DayOfAgeMfgId":  ManufacturerId == 0 ? "" : ManufacturerId,
            "DayOfAgeMfgNameId":  VaccineId == 0 ? "" : VaccineId,
            "DayOfBagHatcheryAntibiotics": HatcheryAntibiotics,
            "Device_Id": deviceIDFORSERVER,
            "DiluentMfg": dictArray.dCS,
            "DisplayId": DisplayId?.prefix(22),
            "ModuleAssessmentCatId": dictArray.catID,
            "DayOfAgeDosage": dayOfAgeData.dosage,
            "StrUniqueId":unique,
            "OtherText":otherVaccine,
            "SecquenceId":0,
            "AntibioticInformation":AntibioticInformation,
            "AssessmentId":serverAssessmentId
            
        ] as JSONDictionary
        return json
    }
    
    // MARK: - Create Sync request for DOAS
    func createSyncRequestForDOAS(dictArray: PENewAssessment,dayOfAgeData :InovojectData) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        DisplayId = "C-" + UniID
        
        let  HatcheryAntibioticsInt = dictArray.hatcheryAntibioticsDoaS
        
        var HatcheryAntibiotics = false
        if HatcheryAntibioticsInt == 1  {
            HatcheryAntibiotics = true
        }
        
        var x = 0
        var vvv = dayOfAgeData.ampuleSize
        var ampleSizeesNameArray = NSArray()
        var ampleSizeIDArray = NSArray()
        var ampleSizeDetailArray = NSArray()
        ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
        ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
        ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
        if dayOfAgeData.ampuleSize != "" {
            let xx = dayOfAgeData.ampuleSize?.replacingOccurrences(of: " ", with: "")
            let indexOfe =  ampleSizeesNameArray.index(of: xx)
            x = ampleSizeIDArray[indexOfe] as? Int  ?? 0
        }
        var VaccineId = 0
        var otherVaccine = ""
        var ManufacturerId = 0
        var vNameArray = NSArray()
        var vNameIDArray = NSArray()
        var vNameDetailsArray = NSArray()
        vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 2)
        vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
        vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        var vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as? NSArray ?? NSArray()
        if vNameArray.contains(dayOfAgeData.name){
            let indexOfe =  vNameArray.index(of: dayOfAgeData.name) //
            VaccineId = vNameIDArray[indexOfe] as? Int ?? 0
            ManufacturerId = vNameMfgIdArray[indexOfe] as? Int ?? 0
        } else if (dayOfAgeData.name != ""){
            otherVaccine = dayOfAgeData.name ?? ""
        }
        
        var vManufacutrerNameArray = NSArray()
        var vManufacutrerIDArray = NSArray()
        var vManufacutrerDetailsArray = NSArray()
        vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
        vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
        vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        
        if vManufacutrerNameArray.contains(dayOfAgeData.vaccineMan){
            let indexOfe =  vManufacutrerNameArray.index(of: dayOfAgeData.vaccineMan) //
            ManufacturerId = vManufacutrerIDArray[indexOfe] as? Int ?? 0
        }
        let timestamp = Date().currentTimeMillis()
        let unique = "\(deviceIDFORSERVER)_\(dayOfAgeData.id)_iOS_"
        var AntibioticInformation  =  ""
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: dictArray.serverAssessmentId ?? "")
        
        if HatcheryAntibiotics {
            AntibioticInformation =  dictArray.hatcheryAntibioticsDoaSText ?? ""
        }
        let ampulePerBag = Int(dayOfAgeData.ampulePerBag ?? "0")
        var json = [
            
            "DayAgeSubcutaneousBagSizeType": dictArray.dDDT,
            "Device_Id": deviceIDFORSERVER,
            "DisplayId": DisplayId?.prefix(22) ?? "",
            "ModuleAssessmentCatId":  dictArray.catID ?? "",
            "StrUniqueId":unique,
            "SecquenceId": 0,
            "AppAssessmentId":  String(AssessmentId)] as JSONDictionary
        
        json["DayAgeSubcutaneousHatcheryAntibiotics"] = HatcheryAntibiotics
        json["DayAgeSubcutaneousMfgId"] =  ManufacturerId == 0 ? "" : ManufacturerId
        json["DayAgeSubcutaneousDosage"] = dayOfAgeData.dosage ?? ""
        json["DayAgeSubcutaneousMfgNameId"] =  VaccineId == 0 ? "" : VaccineId;
        json["OtherText"] =  otherVaccine
        json["DayAgeSubcutaneousDiluentMfg"] =   dictArray.dDCS
        json["DayAgeSubcutaneousAmpuleSize"] =   x == 0 ? "" : x
        json["DayAgeSubcutaneousAmpulePerbag"] =  ampulePerBag == 0 ? "" : (ampulePerBag ?? 0)
        json["AntibioticInformation"] =  AntibioticInformation
        json["AssessmentId"] = serverAssessmentId
        return json
        
    }
    // MARK: - Create Sync request for Certificate Data.
    func createSyncRequestForCertificateData(dictArray: PENewAssessment,peCertificateData :PECertificateData) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 2701
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        
        let timestamp = Date().currentTimeMillis()
        let uni = dictArray.userID ?? 433 + Int(timestamp)
        let unique = "\(deviceIDFORSERVER)_\(peCertificateData.id)_iOS_"
        var resultString = String()
        if(regionID != 3){
            let dateFormatter = DateFormatter()
//            dateFormatter.calendar = Calendar(identifier: .gregorian)
//            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: peCertificateData.certificateDate ?? "")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            resultString = dateFormatter.string(from: date ?? Date())
        }
        else{
            resultString = peCertificateData.certificateDate ?? ""
        }
        
        let json = [
            "Id": AssessmentId,
            "AssessmentId": serverAssessmentId,//AssessmentId,
            "AssessmentDetailId": AssessmentId,
            "ModuleAssessmentId": 0,
            "Name": peCertificateData.name,
            "CertificationDate": resultString,
            "AlternateName": "string",
            "CertificationDate2": "2020-05-23T06:36:50.915Z",
            "ModuleAssessmentCatId":  dictArray.catID,
            "userId": dictArray.userID,
            "DeviceId": deviceIDFORSERVER,
            "ResidueName": dictArray.residue,
            "MicroSamplesName": dictArray.micro,
            "EvaluationTypeId": 1,
            "AppAssessmentId": String(AssessmentId),
            "DisplayId": DisplayId?.prefix(22),
            "StrUniqueId":unique,
            "VacOperatorId": peCertificateData.vacOperatorId ?? 0,
            "IsCertiExpired": peCertificateData.isCertExpired,
            "IsRecert": peCertificateData.isReCert,
            "SignatureImg": peCertificateData.signatureImg ?? ""
        ] as JSONDictionary
        return json
        
    }
    // MARK: - Create Sync request for Residue Data
    func createSyncRequestForResidueData(dictArray: PENewAssessment) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        var serverAssessmentId: Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 2701
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        
        let timestamp = Date().currentTimeMillis()
        let uni = dictArray.userID ?? 32 + Int(timestamp)
        let unique = "\(deviceIDFORSERVER)_\(dictArray.residue)_iOS_"
        
        let json = [
            "AssessmentId": serverAssessmentId,
            "AssessmentDetailId": dictArray.assID ?? 0,
            "StrUniqueId": unique,
            "ModuleAssessmentId": dictArray.catID,
            "ResidueName":dictArray.residue,
            "MicroSamplesName": dictArray.micro,
            "EvaluationTypeId": 1,
            "AppAssessmentId": String(AssessmentId),
            "DisplayId": DisplayId?.prefix(22),
            "UserId": dictArray.userID,
            "CreatedAt": "2020-06-11T12:53:38.930Z",
            "DeviceId": deviceIDFORSERVER,
            "ModuleAssessmentCatId": dictArray.catID
        ] as JSONDictionary
        return json
        
    }
    
    // MARK: - Create Sync request for Micro Data
    func createSyncRequestForMicroData(dictArray: PENewAssessment) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 2701
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        
        let timestamp = Date().currentTimeMillis()
        let uni = dictArray.userID ?? 32 + Int(timestamp)
        let unique = "\(deviceIDFORSERVER)_\(dictArray.micro)_iOS_"
        
        let json = [
            "Id": AssessmentId,
            "AssessmentId": serverAssessmentId,
            "AssessmentDetailId": dictArray.assID ?? 0,
            "ModuleAssessmentId": 0,
            "Name": "",
            "CertificationDate": "",
            "AlternateName": "string",
            "CertificationDate2": "2020-05-23T06:36:50.915Z",
            "ModuleAssessmentCatId":  dictArray.catID,
            "userId": dictArray.userID,
            "DeviceId": deviceIDFORSERVER,
            "ResidueName": dictArray.residue,
            "MicroSamplesName": dictArray.micro,
            "EvaluationTypeId": 1,
            "AppAssessmentId": String(AssessmentId),
            "DisplayId": DisplayId?.prefix(22),
            "StrUniqueId":unique
        ] as JSONDictionary
        return json
    }
    // MARK: - Check Assessment Stauts
    func getAssessmentStatusCheck(assessmentId: String){
        
        ZoetisWebServices.shared.checkAssessment(controller: self, assessmentId: assessmentId, parameters: [:], completion: { [weak self] (json, error) in
            let data = json["Data"].arrayValue.map {  PEStatus($0) }
            let status = data[0].IsStatus
            if status ?? false{
                self?.showAlert(title: "Already approved", message: "Assessment can not be updated as its already approved", owner: self!)
            }else{
                self?.syncBtnTapped(showHud: true)
            }
        })
    }
    // MARK: - Sync Button Action
    func syncBtnTapped(showHud: Bool){
        if ConnectionManager.shared.hasConnectivity() {
            var tempArr : [JSONDictionary]  = []
            var inovojectDataArr : [JSONDictionary]  = []
            var dayOfAgeDataArr : [JSONDictionary]  = []
            var dayOfAgeSDataArr : [JSONDictionary]  = []
            var certificateDataArr : [JSONDictionary]  = []
            var vaccineMicroSamplesDataArr : [JSONDictionary]  = []
            var vaccineResidueMoldsDataArr : [JSONDictionary]  = []
            self.showGlobalProgressHUDWithTitle(self.view, title: "Data syncing...")
            
            certificateData.removeAll()
            if peNewAssessment.vMixer.count > 0 {
                var idArr : [Int] = []
                for objn in  peNewAssessment.vMixer {
                    let data = CoreDataHandlerPE().getCertificateData(doaId: objn)
                    if idArr.contains(data!.id ?? 0){
                    }else{
                        idArr.append(data!.id ?? 0)
                        if data != nil{
                            certificateData.append(data!)
                            
                        }
                    }
                }
            }
            
            let json = createSyncRequest(dict: peNewAssessment, certificationData: certificateData)
            tempArr.append(json)
            dayOfAgeSData.removeAll()
            if peNewAssessment.doaS.count > 0 {
                var idArr : [Int] = []
                for objn in  peNewAssessment.doaS {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: objn)
                    if data != nil {
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            if data != nil{
                                dayOfAgeSData.append(data!)
                            }
                        }
                    }
                }
            }
            
            dayOfAgeData.removeAll()
            if peNewAssessment.doa.count > 0 {
                var idArr : [Int] = []
                for objn in  peNewAssessment.doa {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: objn)
                    if data != nil {
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            if data != nil{
                                dayOfAgeData.append(data!)
                            }
                        }
                    }
                }
            }
            inovojectData.removeAll()
            if peNewAssessment.inovoject.count > 0 {
                var idArr : [Int] = []
                for objn in  peNewAssessment.inovoject {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: objn)
                    if data != nil {
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            if data != nil{
                                inovojectData.append(data!)
                            }
                        }
                    }
                }
            }
            
            if inovojectData.count > 0 {
                for item in inovojectData {
                    let json = createSyncRequestForInvoject(dictArray: peNewAssessment, inovojectData: item)
                    inovojectDataArr.append(json)
                }
            }
            if dayOfAgeData.count > 0 {
                for item in dayOfAgeData {
                    let json = createSyncRequestForDOA(dictArray: peNewAssessment, dayOfAgeData: item)
                    dayOfAgeDataArr.append(json)
                }
            }
            if dayOfAgeSData.count > 0 {
                for item in dayOfAgeSData {
                    let json = createSyncRequestForDOAS(dictArray: peNewAssessment, dayOfAgeData: item)
                    dayOfAgeSDataArr.append(json)
                }
            }
            if certificateData.count > 0 {
                for item in certificateData {
                    let json = createSyncRequestForCertificateData(dictArray: peNewAssessment, peCertificateData: item)
                    certificateDataArr.append(json)
                }
            }
            if peNewAssessment.evaluationID == 2 {
                let json = createSyncRequestForResidueData(dictArray: peNewAssessment)
                vaccineResidueMoldsDataArr.append(json)
            }
            if peNewAssessment.evaluationID == 2 {
                let json = createSyncRequestForMicroData(dictArray: peNewAssessment)
                vaccineMicroSamplesDataArr.append(json)
            }
            
            let paramForDoaInnovoject = ["InovojectData":inovojectDataArr,"DayOfAgeData":dayOfAgeDataArr,"DayAgeSubcutaneousDetailsData":dayOfAgeSDataArr,"VaccineMixerObservedData":certificateDataArr,"VaccineResidueMoldsData":vaccineResidueMoldsDataArr,"VaccineMicroSamplesData":vaccineMicroSamplesDataArr,
                                         "DeviceId": deviceIDFORSERVER] as JSONDictionary
            var idArr = [String]()
            for val in tempArr{
                let id = val["AssessmentId"] as? Int64 ?? 0
                if id != 0{
                    idArr.append("\(id)")
                }
            }
            var arr = [PESanitationDTO]()
            for id in idArr{
                let tempPEArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.sendExtendedPEFilledDTO(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: id)
                arr.append(contentsOf: tempPEArr)
            }
            
            var param = ["AssessmentData":tempArr,"appVersion":Bundle.main.versionNumber,"IsSendEmail":"false"] as JSONDictionary
            
            self.convertDictToJson(dict: param,apiName: "add assessment")
            ZoetisWebServices.shared.sendPostDataToServer(controller: self, parameters: param, completion: { [weak self] (json, error) in
                if error != nil {
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                }
                guard let `self` = self, error == nil else { return }
                
                if json["StatusCode"]  == 200{
                    self.callRequest2(paramForDoaInnovoject: paramForDoaInnovoject, json: json)
                } else {
                    self.dismissGlobalHUD(self.view)
                    self.showAlert(title: "Error", message: "Error in first api sync", owner: self)
                }
            })
        }
    }
    // MARK: - Sync Button Action
    @IBAction func syncBtnAction(_ sender: Any) {
        if ConnectionManager.shared.hasConnectivity(){
            let errorMSg = "Are you sure, you want to sync the data?"
            let alertController = UIAlertController(title: "Data available", message: errorMSg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                _ in
                self.syncBtnTapped(showHud: true)
                // As per discussion with Imran and binu we have commented this code so that client can submit their assessment
               // self.getAssessmentStatusCheck(assessmentId: self.peNewAssessment.serverAssessmentId ?? "")
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
        }
    }
    // MARK: - Create Sync request for Score
    func createSyncRequestForScore(dictArray: PENewAssessment) -> JSONDictionary{
        var UniID = dictArray.dataToSubmitID ?? ""
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        var score = 0
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        DisplayId = "C-" + UniID
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var TextAmPm = ""
        var PersonName = ""
        var FrequencyValue = 32
        var QCCount = ""
        var PPMValue = ""
        let assID =  dictArray.assID ?? 0
        if dictArray.rollOut == "Y" && dictArray.sequenceNoo == 3 && dictArray.qSeqNo == 12
        {
            QCCount =  dictArray.qcCount ?? ""
        } else if  dictArray.rollOut == "Y" && dictArray.sequenceNoo == 6
        {
            TextAmPm =  dictArray.ampmValue ?? ""
        }
        else if  dictArray.rollOut == "Y" && dictArray.sequenceNoo == 5  && dictArray.qSeqNo == 5
                    
        {
            PPMValue =  dictArray.ppmValue ?? ""
        }
        else if  dictArray.rollOut == "Y" && dictArray.sequenceNoo == 3 && dictArray.qSeqNo == 1
        {
            PersonName =  dictArray.personName ?? ""
            let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Frequency")
            let visitNameArray = visitDetailsArray.value(forKey: "frequencyName") as? NSArray ?? NSArray()
            let visitIDArray = visitDetailsArray.value(forKey: "frequencyId") as? NSArray ?? NSArray()
            if dictArray.frequency?.count ?? 0 > 0 {
                if visitNameArray.contains(dictArray.frequency ?? ""){
                    let indexOfe =  visitNameArray.index(of: dictArray.frequency ?? "")
                    FrequencyValue = visitIDArray[indexOfe] as? Int ?? 0
                }
            }
        }
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        let regionId = UserDefaults.standard.integer(forKey: "Regionid")
        if regionId == 3 {
            let json = [
                "DisplayId":DisplayId?.prefix(22) ?? "",
                "AppAssessmentId": String(AssessmentId),
                "ModuleAssessmentId": dictArray.assID ??  0,
                "AssessmentScore": score,
                "UserId": dictArray.userID ?? 0,
                "Device_Id": deviceIDFORSERVER,
                "QCCount":QCCount,
                "PersonName":PersonName,
                "FrequencyValue": FrequencyValue == 32 ? "" : FrequencyValue,
                "TextAmPm":TextAmPm,
                "AssessmentId": serverAssessmentId,
                "SequenceNo":dictArray.sequenceNoo ?? 0,
                "MaxScore":dictArray.assMaxScore ?? 0,
                "Chlorine_Value": PPMValue,
                "isNA":dictArray.isNA ?? false
            ] as JSONDictionary
            return json
        }
        else
        {
            let json = [
                "DisplayId":DisplayId?.prefix(22) ?? "",
                "AppAssessmentId": String(AssessmentId),
                "ModuleAssessmentId": dictArray.assID ??  0,
                "AssessmentScore": score,
                "UserId": dictArray.userID ?? 0,
                "Device_Id": deviceIDFORSERVER,
                "QCCount":QCCount,
                "PersonName":PersonName,
                "FrequencyValue": FrequencyValue == 32 ? "" : FrequencyValue,
                "TextAmPm":TextAmPm,
                "AssessmentId": serverAssessmentId,
                "SequenceNo":dictArray.sequenceNoo ?? 0,
                "MaxScore":dictArray.assMaxScore ?? 0,
                "isNA":dictArray.isNA ?? false
            ] as JSONDictionary
            return json
        }
    }
    
    // MARK: - Create Sync request for Comment
    func createSyncRequestForComment(dictArray: PENewAssessment) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 2701
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        
        let json = [
            "DisplayId":DisplayId?.prefix(22) ?? "",
            "AppAssessmentId":  String(AssessmentId),
            "ModuleAssessmentId": dictArray.assID ?? 0,
            "Comment": dictArray.note ?? "",
            "UserId": dictArray.userID ?? 0,
            "ModuleId": 1,
            "DeviceId":deviceIDFORSERVER,
            "AssessmentId":serverAssessmentId
        ] as JSONDictionary
        return json
        
    }
    
    // MARK: -  Handle Sync Responce
    private func handleSyncResponse(_ json: JSON) {
        let sNumber = peNewAssessment.dataToSubmitNumber ?? 0
        let dNumber = peNewAssessment.draftNumber ?? 0
        var  getOfflineArray : [PENewAssessment] = []
        var  getDraftArray : [PENewAssessment] = []
        if sNumber != 0 {
            getOfflineArray = CoreDataHandlerPE().getOfflineAssessmentArray(id:peNewAssessment.dataToSubmitID ?? "" )
        }
        if dNumber != 0 {
            getDraftArray = CoreDataHandlerPE().getDraftAssessmentArray(id:peNewAssessment.draftNumber ?? 0)
        }
        callRequest4Int = 0
        
        totalImageToSync = []
        
        if getOfflineArray.count > 0 {
            var carColIdArray : [Int] = []
            var catArray : [PENewAssessment] = []
            var catAllRowArray : [PENewAssessment] = []
            for cat in getOfflineArray {
                if !carColIdArray.contains(cat.sequenceNo ?? 0){
                    carColIdArray.append(cat.sequenceNo ?? 0)
                    catArray.append(cat)
                }
            }
            for objCt in catArray{
                let catArrayForTableIs = CoreDataHandlerPE().fetchCustomerForSyncWithCatID(objCt.sequenceNo as NSNumber? ?? 0,dataToSubmitNumber:peNewAssessment.dataToSubmitNumber as NSNumber? ?? 0) as? [PENewAssessment] ?? []
                
                catAllRowArray.append(contentsOf: catArrayForTableIs)
            }
            var tempArr : [JSONDictionary]  = []
            var comntArray : [JSONDictionary]  = []
            var imgArray : [JSONDictionary]  = []
            imgArray.removeAll()
            for objCtIs in catAllRowArray {
                let json = createSyncRequestForScore(dictArray: objCtIs)
                let jsonComment = createSyncRequestForComment(dictArray: objCtIs)
                tempArr.append(json)
                comntArray.append(jsonComment)
            }
            let param = ["AssessmentCommentsData":comntArray,"AssessmentScoreData":tempArr] as JSONDictionary
            self.callRequest3(param:param)
            
        }
        
        if getDraftArray.count > 0 {
            var carColIdArray : [Int] = []
            var catArray : [PENewAssessment] = []
            var catAllRowArray : [PENewAssessment] = []
            for cat in getDraftArray {
                if !carColIdArray.contains(cat.sequenceNo ?? 0){
                    carColIdArray.append(cat.sequenceNo ?? 0)
                    catArray.append(cat)
                }
            }
            for objCt in catArray{
                var catArrayForTableIs = CoreDataHandlerPE().fetchCustomerForSyncWithCatIDDraft(objCt.sequenceNo as NSNumber? ?? 0,draftNumber:peNewAssessment  .draftNumber as? NSNumber ?? 0) as? [PENewAssessment] ?? []
                
                catAllRowArray.append(contentsOf: catArrayForTableIs)
            }
            var tempArr : [JSONDictionary]  = []
            var comntArray : [JSONDictionary]  = []
            for objCtIs in catAllRowArray {
                let json = createSyncRequestForScore(dictArray: objCtIs)
                let jsonComment = createSyncRequestForComment(dictArray: objCtIs)
                tempArr.append(json)
                comntArray.append(jsonComment)
            }
            let param = ["AssessmentCommentsData":comntArray,"AssessmentScoreData":tempArr] as JSONDictionary
            self.callRequest3(param:param)
        }
        
    }
    // MARK: - Call Request 2
    func callRequest2(paramForDoaInnovoject:JSONDictionary,json:JSON){
        let mjson = json
        self.convertDictToJson(dict: paramForDoaInnovoject,apiName: "add inovoject and day of age")
        ZoetisWebServices.shared.sendAddDayOfAgeAndInvoject(controller: self, parameters: paramForDoaInnovoject, completion: { [weak self] (json, error) in
            if error != nil {
                self?.dismissGlobalHUD(self?.view ?? UIView())
            }
            guard let `self` = self, error == nil else { return }
            
            if json["StatusCode"]  == 200{
                self.handleSyncResponse(mjson)
                
            } else {
            }
        })
    }
    // MARK: - Call Request 3
    func callRequest3(param:JSONDictionary){
        self.convertDictToJson(dict: param,apiName: "add score")
        ZoetisWebServices.shared.sendScoresDataToServer(controller: self, parameters: param, completion: { [weak self] (json, error) in
            if error != nil {
                self?.dismissGlobalHUD(self?.view ?? UIView())
            }
            guard let `self` = self, error == nil else { return }
            if json["StatusCode"]  == 200{
                self.CalculateImageCount()
            } else {
                self.dismissGlobalHUD(self.view)
                self.showAlert(title: "Error", message: "Error in sync score", owner: self)
            }
        })
    }
    // MARK: - Create Sync Request for Images
    func createSyncRequestForImage(dictArray: PENewAssessment,img:Int) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dictArray.dataToSubmitID ?? ""
        
        if UniID == "" {
            UniID = dictArray.draftID ?? ""
        }
        
        var AssessmentId = dictArray.dataToSubmitNumber ?? 0
        if AssessmentId == 0 {
            AssessmentId = dictArray.draftNumber ?? 0
        }
        
        let deviceIdForServer = "\(UniID)_\(AssessmentId)_iOS_\(udid)"
        
        var score = 0
        
        if  dictArray.assStatus == 1 {
            score = dictArray.assMaxScore ?? 0
        } else {
            score = dictArray.assMinScore ?? 0
        }
        var DisplayId = dictArray.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        var siteId = String(dictArray.siteId ?? 0)
        var sID = dictArray.siteId ?? 0
        sID = sID + 2701
        var dID = AssessmentId ?? 0
        dID = dID + 2903
        DisplayId = "C-" + UniID
        let base64Str = CoreDataHandlerPE().getImageBase64ByImageID(idArray:img)
        totalImageToSync.append(img)
        let imageName = "ImgName-" + siteId + String(img ?? 0)
        let unique = "\(deviceIDFORSERVER)_\(String(img ?? 0))_iOS_"
        
        var serverAssessmentId:Int64 = 0
        if let id = dictArray.serverAssessmentId{
            serverAssessmentId = Int64(id ?? "") ?? 0
        }
        let json = [
            "DisplayId":DisplayId,
            "Id": AssessmentId,
            "AssessmentDetailId": AssessmentId,
            "ModuleAssessmentId": dictArray.assID ?? 0,
            "Comment": dictArray.note,
            "UserId": dictArray.userID ?? 0,
            "CreatedAt": "2020-05-08T13:51:26.02701Z",
            "ModuleId": 1,
            "CommentTypeId": 1,
            "DeviceId":deviceIDFORSERVER,
            "ImageBase64String":base64Str,
            "FolderPath": "",
            "ImageName": imageName,
            "StrUniqueId":unique,
            "AssessmentId":deviceIdForServer
        ] as JSONDictionary
        return json
        
    }
    // MARK: - Calculate Images Count
    func CalculateImageCount(){
        
        let sNumber = peNewAssessment.dataToSubmitNumber ?? 0
        let dNumber = peNewAssessment.draftNumber ?? 0
        var  getOfflineArray : [PENewAssessment] = []
        var  getDraftArray : [PENewAssessment] = []
        if sNumber != 0 {
            getOfflineArray = CoreDataHandlerPE().getOfflineAssessmentArray(id:peNewAssessment.dataToSubmitID ?? "" )
            CoreDataHandlerPE().updateOfflineStatus(assessment: peNewAssessment)
        }
        if dNumber != 0 {
            getDraftArray = CoreDataHandlerPE().getDraftAssessmentArray(id:peNewAssessment.draftNumber ?? 0)
        }
        callRequest4Int = 0
        
        totalImageToSync = []
        
        if getOfflineArray.count > 0 {
            var carColIdArray : [Int] = []
            var catArray : [PENewAssessment] = []
            var catAllRowArray : [PENewAssessment] = []
            for cat in getOfflineArray {
                if !carColIdArray.contains(cat.sequenceNo ?? 0){
                    carColIdArray.append(cat.sequenceNo ?? 0)
                    catArray.append(cat)
                }
            }
            for objCt in catArray{
                let catArrayForTableIs = CoreDataHandlerPE().fetchCustomerForSyncWithCatID(objCt.sequenceNo as NSNumber? ?? 0,dataToSubmitNumber:peNewAssessment.dataToSubmitNumber as NSNumber? ?? 0) as? [PENewAssessment] ?? []
                
                catAllRowArray.append(contentsOf: catArrayForTableIs)
            }
            var tempArr : [JSONDictionary]  = []
            var comntArray : [JSONDictionary]  = []
            var imgArray : [JSONDictionary]  = []
            
            for objCtIs in catAllRowArray {
                let json = createSyncRequestForScore(dictArray: objCtIs)
                let jsonComment = createSyncRequestForComment(dictArray: objCtIs)
                for i in objCtIs.images{
                    let status = CoreDataHandlerPE().imageAlreadySyncStatus(imageId: i) as? Bool ?? false
                    if status {
                        
                    } else {
                        let jsonIMages = createSyncRequestForImage(dictArray: objCtIs,img:i)
                        imgArray.append(jsonIMages)
                    }
                }
                tempArr.append(json)
                comntArray.append(jsonComment)
            }
            let param = ["AssessmentCommentsData":comntArray,"AssessmentScoreData":tempArr] as JSONDictionary
            var arrayCount  = 0
            var imgDic :  [JSONDictionary] = []
            
            if imgArray.count > 3 {
                for objimgr in imgArray{
                    arrayCount  = arrayCount + 1
                    imgDic.append(objimgr)
                    if arrayCount == 3  {
                        let ss  = imgDic as?  [JSONDictionary]  ?? []
                        var  paramForImages  = ["AssessmentImages":ss] as JSONDictionary
                        //                            ,"appVersion":Bundle.main.versionNumber
                        arrayCount  = 0
                        imgDic.removeAll()
                        self.callRequest4(paramForImages:paramForImages)
                    }
                }
                if  arrayCount > 0 {
                    let ss  = imgDic as?  [JSONDictionary]  ?? []
                    var  paramForImages  = ["AssessmentImages":ss] as JSONDictionary
                    //                        ,"appVersion":Bundle.main.versionNumber
                    arrayCount  = 0
                    imgDic.removeAll()
                    self.callRequest4(paramForImages:paramForImages)
                }
            } else {
                var  paramForImages  = ["AssessmentImages":imgArray] as JSONDictionary
                self.callRequest4(paramForImages:paramForImages)
            }
            
        }
        
        if getDraftArray.count > 0 {
            var carColIdArray : [Int] = []
            var catArray : [PENewAssessment] = []
            var catAllRowArray : [PENewAssessment] = []
            for cat in getDraftArray {
                if !carColIdArray.contains(cat.sequenceNo ?? 0){
                    carColIdArray.append(cat.sequenceNo ?? 0)
                    catArray.append(cat)
                }
            }
            for objCt in catArray{
                var catArrayForTableIs = CoreDataHandlerPE().fetchCustomerForSyncWithCatIDDraft(objCt.sequenceNo as NSNumber? ?? 0,draftNumber:peNewAssessment.draftNumber as? NSNumber ?? 0) as? [PENewAssessment] ?? []
                
                catAllRowArray.append(contentsOf: catArrayForTableIs)
            }
            var tempArr : [JSONDictionary]  = []
            var comntArray : [JSONDictionary]  = []
            var imgArray : [JSONDictionary]  = []
            
            for objCtIs in catAllRowArray {
                let json = createSyncRequestForScore(dictArray: objCtIs)
                let jsonComment = createSyncRequestForComment(dictArray: objCtIs)
                for i in objCtIs.images{
                    let status = CoreDataHandlerPE().imageAlreadySyncStatus(imageId: i) as? Bool ?? false
                    if status {
                        
                    } else {
                        let jsonIMages = createSyncRequestForImage(dictArray: objCtIs,img:i)
                        imgArray.append(jsonIMages)
                    }
                }
                tempArr.append(json)
                comntArray.append(jsonComment)
                
            }
            let param = ["AssessmentScoreData":tempArr,"AssessmentCommentsData":comntArray] as JSONDictionary
            var arrayCount  = 0
            var imgDic :  [JSONDictionary] = []
            
            if imgArray.count > 3 {
                for objimgr in imgArray{
                    arrayCount  = arrayCount + 1
                    imgDic.append(objimgr)
                    if arrayCount == 3  {
                        let ss  = imgDic as?  [JSONDictionary]  ?? []
                        var  paramForImages  = ["AssessmentImages":ss] as JSONDictionary
                        arrayCount  = 0
                        imgDic.removeAll()
                        self.callRequest4(paramForImages:paramForImages)
                    }
                }
                if  arrayCount > 0 {
                    let ss  = imgDic as?  [JSONDictionary]  ?? []
                    var  paramForImages  = ["AssessmentImages":ss] as JSONDictionary
                    arrayCount  = 0
                    imgDic.removeAll()
                    self.callRequest4(paramForImages:paramForImages)
                }
            } else {
                var  paramForImages  = ["AssessmentImages":imgArray] as JSONDictionary
                self.callRequest4(paramForImages:paramForImages)
            }
        }
    }
    
    // MARK: -  Get Offline Assessments
    func getAssessmentInOfflineFromDb() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDFor(entityName: "PE_AssessmentInOffline")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
        
        var carColIdArrayDraft : [Int] = []
        
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArrayDraft.contains(obj as? Int ?? 0){
                carColIdArrayDraft.append(obj as? Int ?? 0)
            }
        }
        let allAssesmentOffArr = CoreDataHandlerPE().fetchDetailsWithUserIDFor(entityName: "PE_AssessmentInDraft")
        let carColIdArrayOffNumbers  = allAssesmentOffArr.value(forKey: "draftNumber") as? NSArray ?? []
        var carColIdArrayOff : [Int] = []
        for obj in carColIdArrayOffNumbers {
            if !carColIdArrayOff.contains(obj as? Int ?? 0){
                carColIdArrayOff.append(obj as? Int ?? 0)
            }
        }
        let syncCount = carColIdArrayOff.count
        let syncCount2 = carColIdArrayDraft.count
        return syncCount + syncCount2
    }
    // MARK: - Call sync request for Images (4)
    func callRequest4(paramForImages:JSONDictionary){
        callRequest4Int = callRequest4Int + 1
        ZoetisWebServices.shared.sendMultipleImagesBase64ToServer(controller: self, parameters: paramForImages, completion: { [weak self] (json, error) in
            self?.callRequest4Int = self!.callRequest4Int - 1
            
            if error != nil {
                let syncArr = self?.getAssessmentInOfflineFromDb()
                if syncArr ?? 0 > 0{
                    self?.syncBtnTapped(showHud: false)
                } else {
                    self?.showtoast(message: "Data synced successfully.")
                    NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
                }
            }
            guard let `self` = self, error == nil else { return }
            if json["StatusCode"]  == 200{
                if self.saveTypeString.contains(11)
                {
                    if self.saveTypeString.contains(00) {
                        CoreDataHandlerPE().updateDraftStatus(assessment: self.peNewAssessment)
                    }
                    CoreDataHandlerPE().updateOfflineStatus(assessment: self.peNewAssessment)
                } else {
                    CoreDataHandlerPE().updateDraftStatus(assessment: self.peNewAssessment)
                }
                if ConnectionManager.shared.hasConnectivity() {
                    if self.callRequest4Int == 0 {
                        
                        if peNewAssessment.IsEMRequested == true
                        {
                            if regionID == 3
                            {
                                if peNewAssessment.IsEMRequested == true {
                                    self.syncExtendedMicrobial()
                                }
                            }
                        }
                        else
                        {
                            let syncArr = self.getAssessmentInOfflineFromDb()
                            if syncArr > 0{
                                self.syncBtnTapped(showHud: false)
                            } else {
                                for i in self.totalImageToSync{
                                    CoreDataHandlerPE().setImageStatusTrue(idArray: i)
                                }
                                self.showtoast(message: "Data synced successfully.")
                                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
                                self.dismissGlobalHUD(self.view)
                            }
                        }
                    }
                   
                }
                
            } else {
                self.dismissGlobalHUD(self.view)
            }
        })
    }
    

    // MARK:
    // MARK: ------------ Extended Micro Create Sync Request --------------
    // MARK:
    func createSyncRequestForExtendedMicro(dict: PENewAssessment ,certificationData : [PECertificateData]) -> JSONDictionary{
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        var UniID = dict.dataToSubmitID ?? ""
        var arr = [PESanitationDTO]()
        let ExtendedPEArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.sendExtendedPEFilledDTO(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
        arr.append(contentsOf: ExtendedPEArr)
        
        var extendedData : [[String: Any]]?
        let jsonEncoder = JSONEncoder()
        let jsonDataArr = try? jsonEncoder.encode(arr)
        if jsonDataArr != nil{
            extendedData = try! JSONSerialization.jsonObject(with: jsonDataArr!, options: []) as? [[String: Any]]
        }
        
        let evaluationDate = dict.evaluationDate
        if UniID == "" {
            UniID = dict.draftID ?? ""
        }
        
        saveTypeString.append(11)
        var AssessmentId = dict.dataToSubmitNumber ?? 0
        
        let deviceIdForServer = "\(UniID)_1_iOS_\(udid)"
        deviceIDFORSERVER = deviceIdForServer
        
        if dict.assDetail2?.lowercased().contains("_1_ios") ?? false{
            deviceIDFORSERVER = dict.assDetail2 ?? ""
        }
        var serverAssessmentId:Int64 = 0
        if dict.serverAssessmentId != nil{
            serverAssessmentId = Int64( dict.serverAssessmentId ?? "") ?? 0
        }
        
        let IncubationStyle = dict.incubation
        let EvaluationId = dict.evaluationID
        let countryID = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let FlockAgeId = dict.isFlopSelected
        let UserId = dict.userID
        let Notes = dict.notes
        let dateFormatter = DateFormatter()
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let regionId = UserDefaults.standard.integer(forKey: "Regionid")
        
        dateFormatter.dateFormat="MM/dd/YYYY"
        
        let date = dict.evaluationDate?.toDate(withFormat: "MM/dd/YYYY")
        
        var dateSig = ""
        let ddd = dict.sig_Date ?? ""
        if ddd != "" {
            dateSig = self.convertDateFormat(inputDate: ddd)
        }
        
        var DisplayId = dict.evaluationDate
        DisplayId = DisplayId?.replacingOccurrences(of: "/", with: "")
        DisplayId = "C-" + UniID
        
     //   dict.evaluationDate = dateSig
        
        var json : JSONDictionary = JSONDictionary()
        if dateSig != ""{
            dict.evaluationDate = dateSig
        }else{
            let convertDateFormatter = DateFormatter()
//            convertDateFormatter.calendar = Calendar(identifier: .gregorian)
//            convertDateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            convertDateFormatter.dateFormat = "yyyy-MM-dd"
            convertDateFormatter.locale = Calendar.current.locale
        }
        let userInfo = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: dict.serverAssessmentId ?? "")
        let dateFormatterObj = CodeHelper.sharedInstance.getDateFormatterObj("")
        if regionId == 3 {
            
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "MM/dd/yyyy"

            // Convert the string to a Date object
            if let date = inputFormatter.date(from: evaluationDate ?? "") {
                
                // Create another DateFormatter for the desired output format
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd"
                
                // Convert the Date object back to a string
                let formattedDateString = outputFormatter.string(from: date)
                dict.evaluationDate = evaluationDate
            } else {
                print("Invalid date format")
            }
        }
        else
        {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd/MM/yyyy"

            if let date = inputFormatter.date(from: evaluationDate ?? "") {
            
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "yyyy-MM-dd"
                
                let formattedDateString = outputFormatter.string(from: date)
                dict.evaluationDate = evaluationDate
            } else {
                print("Invalid date format")
            }
        }
       

        
        let isEMRequested = dict.IsEMRequested ?? false
        let extndMicro = dict.extndMicro ?? false
        let appVersion = "\(Bundle.main.versionNumber)"
        
        var saveType = 0
        if dict.IsEMRequested == true
        {
            saveType = 1
        }
        else
        {
            saveType = 0
        }
        
        json = [
            "AssessmentId":serverAssessmentId,
            "DeviceId": deviceIDFORSERVER,
            "UserId": UserId,
            "EvaluationId": EvaluationId ?? 0,
            "SaveType":saveType,
            "Status_Type": 0,
            "IsEMRequested" : isEMRequested,
            "IsSendEmail": true,
            "appVersion": appVersion,
            "SanitationEmbrexScoresDataModel":extendedData
        ] as JSONDictionary
        
        return json
        
    }

    // MARK: ------------ Call Extended Micro Sync API --------------
    // MARK:
    
    func callExtendedMicro(param:JSONDictionary){
        
        ZoetisWebServices.shared.sendExtendedMicroToServer(controller: self, parameters: param, completion: { [weak self] (json, error) in
            if error != nil {
                self?.dismissGlobalHUD(self?.view ?? UIView())
            }
            
            guard let `self` = self, error == nil else { return }
            if json["StatusCode"]  == 200{
                
                self.dismissGlobalHUD(self.view)
                
            }
            else {
                self.dismissGlobalHUD(self.view)
                self.showAlert(title: "Error", message: "Error in Extended Micro data sync", owner: self)
            }
        })
    }
    
    // MARK: - Sync Extended Microbial
    func syncExtendedMicrobial ()
    {
        var extendedMicroArr : [JSONDictionary]  = []
        
        certificateData.removeAll()
        if peNewAssessment.vMixer.count > 0 {
            var idArr : [Int] = []
            for objn in  peNewAssessment.vMixer {
                let data = CoreDataHandlerPE().getCertificateData(doaId: objn)
                if idArr.contains(data!.id ?? 0){
                }else{
                    idArr.append(data!.id ?? 0)
                    if data != nil{
                        certificateData.append(data!)
                        
                    }
                }
            }
        }
        
        let jsonExtendedMicro = self.createSyncRequestForExtendedMicro(dict: peNewAssessment, certificationData: self.certificateData)
        extendedMicroArr.append(jsonExtendedMicro)
        let ExtendedMicroparam = ["ExtendedMicrobialData":extendedMicroArr] as JSONDictionary
        self.convertDictToJson(dict: ExtendedMicroparam,apiName: "Assessment_AddEMAssessment")
        self.callExtendedMicro(param: ExtendedMicroparam)
    }
    
}

public struct PEStatus {
    
    let StatusType: String?
    let IsStatus: Bool?
    
    init(_ json: JSON) {
        StatusType = json["StatusType"].stringValue
        IsStatus = json["IsStatus"].boolValue
    }
}

