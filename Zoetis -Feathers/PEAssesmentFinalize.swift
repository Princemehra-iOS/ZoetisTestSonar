//
//  PEAssesmentFinalize.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 13/12/19.
//  Copyright © 2019  . All rights reserved.
//


import UIKit
import SwiftyJSON
import RSSelectionMenu

struct Rational {
    let numerator : Int
    let denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    init(approximating x0: Double, withPrecision eps: Double = 1.0E-6) {
        var x = x0
        var a = x.rounded(.down)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)
        
        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = x.rounded(.down)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        
        self.init(numerator: h, denominator: k)
    }
}

protocol PECategorySelectionDelegate {
    func selectedAssessmentId(selectedId: Int, selectedArr:[[String : AnyObject]])
}



class PEAssesmentFinalize: BaseViewController , DatePickerPopupViewControllerProtocol {
    
    var textValue  : Int?
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var peHeaderViewController:PEHeaderViewController!
    var peNewAssessment:PENewAssessment!
    var peNewAssessmentBack:PENewAssessment!
    var dropdownManager = ZoetisDropdownShared.sharedInstance
    var delegate: PECategorySelectionDelegate? = nil
    var isNewMixer: Bool = false
    var currentArr : [AssessmentQuestions] = []
    var selectedCategory : PENewAssessment?
    var refriCategory : PENewAssessment?
    var collectionviewIndexPath = IndexPath(row: 0, section: 0)
    var mainNADict = [Int:Int]()
    var jsonRe : JSON = JSON()
    var currentTxt = ""
    var ml = 0.0
    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
    var tableviewIndexPath = IndexPath(row: 0, section: 0)
    var catArrayForCollectionIs : [PENewAssessment] = []
    var catArrayForTableIs = NSArray()
    var refrigtorProbeArray  : [PE_Refrigators] = []
    var dropButton = DropDown()
    var refriCamerAssesment =  [PE_AssessmentInProgress]()
    var chnagedIndexPathRow = 0
    var chnagedVaccineNameIndexPathRow = 0
    var certificateData : [PECertificateData] = []
    var inovojectData : [InovojectData] = []
    var dayOfAgeData : [InovojectData] = []
    var dayOfAgeSData : [InovojectData] = []
    var dataArray : [String] = []
    var sampleDateArray = ["20/10/22", "21/10/22", "22/10/22", "23/10/22", "24/10/22", "25/10/22", "26/10/22"]
    var inventoryArray = ["Handmix", "Inovotab"]
    var isExpiredArray = [true, false, false, true, true, true, false]
    var mixerIdArray = [Int]()
    var certDateArray = [String]()
    var isCertExpiredArray = [Bool]()
    var signatureImgArray = [String]()
    var scheduledAssessment:PENewAssessment?
    var showExtendedPE:Bool = false
    var sanitationQuesArr = [PE_ExtendedPEQuestion]()
    var nameblock:((_ error: String?) -> Void)?
    var updateNameblock:((_ error: String?) -> Void)?
    var dateBlock:((_ date : String?,_ certifiedExpire :Bool? , _ isReCert : Bool?, _ count : Int) -> Void)?
    var changedDate:((_ date: String?) -> Void)?
    var selected_NA_QuestionArray = [Int]()
    var refrigator_Selected_NA_QuestionArray = [Int:Int]()
    var selctedNACategoryArray = [Int]()
    var refriArray = ["Refrigerator used only for Vaccines and Lab Supplies","Content rotated and cleaned monthly?"]
    var fridgeArray = ["Freezer used only for Vaccines and Lab Supplies?","Freezer alarmed and temperatures recorded on a regular basis?"]
    var liquidArray = ["Liquid Nitrogen Container used for Vaccines?","Fluid Levels checked regularly and recorded?"]
    var regionID = Int()
    var finishingAssessment:Bool = false
    var forInovo:Bool = false
    
    @IBOutlet weak var buttonFinishAssessment: PESubmitButton!
    @IBOutlet weak var buttonSaveAsDraft: PESubmitButton!
    @IBOutlet weak var buttonSaveAsDraftInitial: PESubmitButton!
    @IBOutlet weak var assessmentDateText: PEFormTextfield!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultScoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet fileprivate weak var tableview: UITableView!
    @IBOutlet weak var selectedCustomer: PEFormLabel!
    @IBOutlet weak var selectedComplex: PEFormLabel!
    @IBOutlet weak var scoreGradientView: UIView!
    @IBOutlet weak var customerGradientView: UIView!
    @IBOutlet weak var scoreParentView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var coustomerView: UIView!
    @IBOutlet weak var bckButton: PESubmitButton!
    @IBOutlet weak var lbl_NA: UILabel!
    @IBOutlet weak var btnNA: UIButton!
    @IBOutlet weak var lblextenderMicro: UILabel!
    @IBOutlet weak var extendedMicroSwitch: UISwitch!
    
    var strings = [String]()
    let refridFreezerNitro = "Refrigerator\n/Freezer\n/Liquid Nitrogen"
    let extendedMicStr = "Extended Microbial"
    let peCommentImg = "PEcomment.png"
    let peCommentSelectedStr = "PECommentSelected.png"
    let ddmmyyStr = "dd/MM/yyyy"
    let incompleteDataStr = "Incomplete Data"
    let oneGallonStr = "1 gallon"
    let twoGallonStr = "2 gallon"
    let fiveGallonStr = "5 gallon"
    let twoLitre = "2 litre"
    let liter24 = "2.4 litre"
    let liter28 = "2.8 litre"
    let mil200 = "200 ml"
    let mil300 = "300 ml"
    let mil400 = "400 ml"
    let mil500 = "500 ml"
    let pleaseEnterMessage = "Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccination Application"
    let pleaseEnterMessageVac = "Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application"
    let peaseEnterVacDet = "Please enter vaccine details in the Vaccine Preparation & Sterility. "
    let pleaseEnterFrequencyDet = "Please enter frequency detail in Customer Quality Control Program."
    let pleaseEnterPersonName = "Please enter person name in Customer Quality Control Program."
    let pleaseEnterQCount = "Please enter QC count in Customer Quality Control Program."
    let pleaseEnterPPM = "Please enter PPM Value in Inovoject System Set Up/Shut Down and Operation."
    let pleaseEnterAMPM = "Please enter AM/PM Value in Miscellaneous."
    let pleaseEnterProgramName = "Please enter program name in the Vaccine Preparation & Sterility."
    let pleaseEnterAntibiotic = "Please enter Antibiotic in the Vaccine Preparation & Sterility."
    let pleaseEnterVaccineMixer = "Please enter Vaccine Mixer Observer in  Vaccine Preparation & Sterility."
    
    override func viewWillAppear(_ animated: Bool) {
        lblextenderMicro.isHidden = true
        extendedMicroSwitch.isHidden = true
        extendedMicroSwitch.isUserInteractionEnabled = false
        
        if extendedMicroSwitch.isOn
        {
            UserDefaults.standard.set(true, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateIsEMRequestedInAssessmentInProgress(isEMRequested: true)
        }else
        {
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateIsEMRequestedInAssessmentInProgress(isEMRequested: false)
        }
        
        Constants.isMovedOn = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !Constants.isMovedOn{
            let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
            let pradicate = NSPredicate(format: "userID == %d AND serverAssessmentId == %@", userID, peNewAssessment.serverAssessmentId ?? "")
            CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentInProgress", predicate: pradicate)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        _ = keyboardSize.cgRectValue
        
        if self.view.bounds.origin.y == 0{
            self.view.bounds.origin.y += 200
        }
        tableview.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        Constants.isMovedOn = true
        cleanSessionAndMoveTOStart()
    }
    
    @IBAction func actioNA(_ sender: Any) {
        
        if checkCategoryisNA(){
            setAllQuestiontTo_Non_NA()
            if(selectedCategory?.sequenceNoo == 3 ){
                let indexPath = NSIndexPath(row: 10, section: 0)
                tableview.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                self.peNewAssessment.qcCount = ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            if(selectedCategory?.sequenceNoo == 6 ){
                self.peNewAssessment.ampmValue = ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            updateScore(isAllNA: false)
        }else{
            setAllQuestiontToNA()
            if(selectedCategory?.sequenceNoo == 3 ){
                let indexPath = NSIndexPath(row: 10, section: 0)
                tableview.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                self.peNewAssessment.qcCount = "NA"
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            if(selectedCategory?.sequenceNoo == 6 ){
                self.peNewAssessment.ampmValue = "NA"
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            updateScore(isAllNA: true)
        }
        btnNA.isSelected = !btnNA.isSelected
        
    }
    
    
    
    private func cleanSessionAndMoveTOStart(){
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        
        if regionID == 3
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEStartNewAssessment") as? PEStartNewAssessment
            Constants.isMovementDone = false
            vc?.isFromBack = true
            vc?.scheduledAssessment = peNewAssessment
            vc?.peNewAssessment = peNewAssessmentBack
            if vc != nil {
                navigationController?.pushViewController(vc!, animated: false)
            }
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEStartNewAssessmentINT") as? PEStartNewAssessmentINT
            Constants.isMovementDone = false
            vc?.isFromBack = true
            vc?.scheduledAssessment = peNewAssessment
            vc?.peNewAssessment = peNewAssessmentBack
            
            if vc != nil {
                navigationController?.pushViewController(vc!, animated: false)
            }
            
        }
    }
    
    @IBAction func btnAction(_ sender: Any) {
        print(appDelegate.testFuntion())
    }
    
    override func viewDidLoad() {
        print("<<<<",self)
        self.navigationController?.navigationBar.isHidden = true
        UserDefaults.standard.setValue(false, forKey: "extendedAvailable")
        UserDefaults.standard.setValue(false, forKey: "isFromDraft")
        UserDefaults.standard.synchronize()
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        peHeaderViewController = PEHeaderViewController()
        peHeaderViewController.titleOfHeader = "Assessment"
        self.headerView.addSubview(peHeaderViewController.view)
        self.topviewConstraint(vwTop: peHeaderViewController.view)
        peNewAssessment = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject(serverAssessmentId:scheduledAssessment?.serverAssessmentId ?? "")
        var peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        
        sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        
        certificateData.removeAll()
        
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        showExtendedPE = infoObj?.isExtendedPE ?? false
        
        UserDefaults.standard.set(scheduledAssessment?.serverAssessmentId , forKey: "currentServerAssessmentId")
        
        var carColIdArray : [Int] = []
        var row = 0
        for cat in peNewAssessmentArray {
            if !carColIdArray.contains(cat.sequenceNo ?? 0){
                carColIdArray.append(cat.sequenceNo ?? 0)
                if(cat.catName == "Refrigerator"){
                    cat.catName = refridFreezerNitro // "Sanitation and Embrex Evaluation"
                }
                catArrayForCollectionIs.append(cat)
                
            }
        }
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3
        {
            btnNA.isHidden = false
            lbl_NA.isHidden = false
            showHideNA(sequenceNoo: self.selectedCategory?.sequenceNoo ?? 0, catName: self.selectedCategory?.catName ?? "")
        }
        else{
            btnNA.isHidden = true
            lbl_NA.isHidden = true
        }
        
        for cat in catArrayForCollectionIs{
            if cat.doa.count > 0 {
                var idArr : [Int] = []
                for obj in  cat.doa {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
                    if data != nil {
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            dayOfAgeData.append(data!)
                        }
                    }
                }
            }
        }
        
        for cat in catArrayForCollectionIs{
            if cat.doaS.count > 0 {
                var idArr : [Int] = []
                for obj in  cat.doaS {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
                    if data != nil {
                        if idArr.contains(data!.id ?? 0){
                            
                        }else{
                            
                            idArr.append(data!.id ?? 0)
                            dayOfAgeSData.append(data!)
                        }
                    }
                }
            }
        }
        
        for cat in catArrayForCollectionIs{
            if cat.inovoject.count > 0 {
                var idArr : [Int] = []
                for obj in  cat.inovoject {
                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
                    if idArr.contains(data!.id ?? 0){
                        
                    }else{
                        
                        idArr.append(data!.id ?? 0)
                        inovojectData.append(data!)
                    }
                }
            }
        }
        
        for cat in catArrayForCollectionIs {
            if cat.catISSelected == 1 {
                row = cat.sequenceNo ?? 0 - 1
                selectedCategory = cat
            }
        }
        if  selectedCategory?.evaluationDate?.count == nil {
            selectedCategory = catArrayForCollectionIs.first
            let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
            if regionID != 3
            {
                refriCategory = catArrayForCollectionIs.last
            }
        }
        if(selectedCategory?.catName == refridFreezerNitro){
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
            
            let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
            refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
            
        }
        else{
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
        }
        super.viewDidLoad()
        
        tableview.register(PEQuestionTableViewCell.nib, forCellReuseIdentifier: PEQuestionTableViewCell.identifier)
        tableview.register(VaccineMixerCell.nib, forCellReuseIdentifier: VaccineMixerCell.identifier)
        tableview.register(InovojectCell.nib, forCellReuseIdentifier: InovojectCell.identifier)
        tableview.register(InovojectNewTableViewCell.nib, forCellReuseIdentifier: InovojectNewTableViewCell.identifier)
        tableview.register(RefrigatorQuesCell.nib, forCellReuseIdentifier: RefrigatorQuesCell.identifier)
        tableview.register(SetFrezzerPointCell.nib, forCellReuseIdentifier: SetFrezzerPointCell.identifier)
        let refrigatorTempProbeCell = UINib(nibName: "RefrigatorTempProbeCell", bundle: nil)
        tableview.register(refrigatorTempProbeCell, forHeaderFooterViewReuseIdentifier: "RefrigatorTempProbeCell")
        let frezerFooterViewCell = UINib(nibName: "FrezerFooterViewCell", bundle: nil)
        tableview.register(frezerFooterViewCell, forHeaderFooterViewReuseIdentifier: "FrezerFooterViewCell")
        let frezerHeaderViewCell = UINib(nibName: "SetFrezzerPointCell", bundle: nil)
        tableview.register(frezerHeaderViewCell, forHeaderFooterViewReuseIdentifier: "SetFrezzerPointCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        row = 0
        selectedCategory = catArrayForCollectionIs[0]
        if regionID != 3
        {
            refriCategory = catArrayForCollectionIs.last
        }
        //     }
        collectionView.reloadData()
        collectionviewIndexPath = IndexPath(row: row, section: 0)
        selectinitialCell()
        collectionView(collectionView, didSelectItemAt: collectionviewIndexPath)
        collectionView.reloadData()
        selectedComplex.text = catArrayForCollectionIs.first?.siteName
        selectedCustomer.text = catArrayForCollectionIs.first?.customerName
        assessmentDateText.text =  catArrayForCollectionIs.first?.evaluationDate
        chechForLastCategory()
        setupUI()
        if regionID == 3
        {
            if showExtendedPE {
                
                let catObjectPE = PENewAssessment()
                catObjectPE.catName = extendedMicStr // "Sanitation and Embrex Evaluation"
                catObjectPE.sequenceNo = 12
                catObjectPE.sequenceNoo = 12
                catArrayForCollectionIs.append(catObjectPE)
                btnNA.isHidden = true
                lbl_NA.isHidden = true
                
                tableview.register(UINib(nibName: "PlateInfoCell", bundle: nil), forCellReuseIdentifier: "PlateInfoCell")
                
                let nibPlateInfoHeader = UINib(nibName: "PlateInfoHeader", bundle: nil)
                tableview.register(nibPlateInfoHeader, forHeaderFooterViewReuseIdentifier: "PlateInfoHeader")
                
                //            if extendedPESwitch.isOn{
                let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
                
                if sanitationQuesArr.count == 0{
                    SanitationEmbrexQuestionMasterDAO.sharedInstance.saveAssessmentQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
                }
            }
            
            
            
        }
        
        
        
        collectionView.reloadData()
        tableview.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshScores(_:)), name: NSNotification.Name.init(rawValue: "RefreshExtendedPEScores") , object: nil)
        // DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
        certificateData.removeAll()
        for cat in catArrayForCollectionIs{
            if cat.vMixer.count > 0 {
                var idArr : [Int] = []
                for obj in  cat.vMixer {
                    let data = CoreDataHandlerPE().getCertificateData(doaId: obj)
                    if idArr.contains(data!.id ?? 0){
                        
                    }else{
                        
                        idArr.append(data!.id ?? 0)
                        
                        certificateData.append(data!)
                    }
                }
            }
        }
        //  }
        
        if  peNewAssessment.evaluationID != 2 {
            
        }
        for _ in certificateData {
            
        }
        if certificateData.count > 0 {
            self.certificateData =  self.certificateData.sorted(by: {
                let id1 = $0.id ?? 0
                let id2 = $1.id ?? 0
                return id1 < id2
            })
        }
        
        dataArray.removeAll()
        certDateArray.removeAll()
        mixerIdArray.removeAll()
        isCertExpiredArray.removeAll()
        signatureImgArray.removeAll()
        
        
        if let vaccineMixers = CoreDataHandlerMicro().fetchDetailsFor(entityName: "PE_VaccineMixerDetail") as? [PE_VaccineMixerDetail] {
            
            if vaccineMixers.count > 0{
                for mixer in vaccineMixers{
                    dataArray.append(mixer.name ?? "")
                    certDateArray.append(mixer.certificationDate ?? "")
                    mixerIdArray.append(Int(truncating: mixer.id ?? 0))
                    isCertExpiredArray.append(mixer.isCertExpired as? Bool ?? false)
                    signatureImgArray.append(mixer.signatureImage ?? "")
                }
            }
        }
    }
    
    // MARK: - Extended Micro Switch Action
    @IBAction func extendedMicroSwitch(_ sender: UISwitch) {
        
        if extendedMicroSwitch.isOn
        {
            UserDefaults.standard.set(true, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateIsEMRequestedInAssessmentInProgress(isEMRequested: true)
        }
        else
        {
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateIsEMRequestedInAssessmentInProgress(isEMRequested: false)
            
        }
    }
    
    // MARK: - Get Vaccine Mixture List
    private func getVaccineMixerList(customerId: Int, siteId: Int, countryId: Int, _ completion: @escaping (_ status: Bool) -> Void){
        let parameter = [
            "siteId": "\(siteId)",
            "customerId": "\(customerId)",
            "countryId": "\(countryId)"
        ] as JSONDictionary
        ZoetisWebServices.shared.getMixerList(controller: self, parameters: parameter) { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            //  self.handleVaccineMixer(json)
            self.deleteAllData("PE_VaccineMixerDetail")
            
            
            VaccineMixerResponse(json)
            completion(true)
        }
    }
    private func handleVaccineMixer(_ json: JSON) {
        print(appDelegate.testFuntion())
        
    }
    
    // MARK: - Refresh Score
    @objc func  refreshScores(_ notification: NSNotification){
        let sanitationIndex =  notification.userInfo?["index"]  as? Int
        refreshScore(sanitationIndex ?? -1)
    }
    
    func refreshScore(_ sanitationIndex:Int){
        self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
        
        
        let score = sanitationQuesArr.map({($0.currentScore ?? 0)}).reduce(0,+)
        
        resultScoreLabel.text = "\(score)"
        totalScoreLabel.text = "100"
    }
    
    // MARK: - Setup UI
    func setupUI() {
        let nibCatchers = UINib(nibName: "PETableviewHeaderFooterView", bundle: nil)
        tableview.register(nibCatchers, forHeaderFooterViewReuseIdentifier: "PETableviewHeaderFooterView")
        let nibCas = UINib(nibName: "PEInovojectHeaderFooterView", bundle: nil)
        tableview.register(nibCas, forHeaderFooterViewReuseIdentifier: "PEInovojectHeaderFooterView")
        let nibCasa = UINib(nibName: "PEHeaderDayOfAge", bundle: nil)
        tableview.register(nibCasa, forHeaderFooterViewReuseIdentifier: "PEHeaderDayOfAge")
        let peTableviewConsumerQualityHeader = UINib(nibName: "PETableviewConsumerQualityHeader", bundle: nil)
        tableview.register(peTableviewConsumerQualityHeader, forHeaderFooterViewReuseIdentifier: "PETableviewConsumerQualityHeader")
        coustomerView.setCornerRadiusFloat(radius: 24)
        customerGradientView.setCornerRadiusFloat(radius: 24)
        DispatchQueue.main.async {
            self.customerGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            self.scoreGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            
        }
        scoreParentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
        buttonFinishAssessment.setNextButtonUI()
        buttonSaveAsDraft.setNextButtonUI()
        buttonSaveAsDraftInitial.setNextButtonUI()
        self.btnNA.isSelected = true
        for i in catArrayForTableIs{
            let ass = i as! PE_AssessmentInProgress
            //            changeScore(changeValue: 0, operation: 2)
            if(ass.isNA == false){
                self.btnNA.isSelected = false
                updateScore(isAllNA: false)
                
            }
            
        }
    }
    
    // MARK: - Refresh Tableview
    func refreshTableView(){
        if(selectedCategory?.catName == refridFreezerNitro){
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
        }
        else{
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
        }
        //        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as NSNumber? ?? 0)
        tableview.reloadData()
        if(selectedCategory?.catName == refridFreezerNitro){
            //            scrollToBottom(section:0)
        }
        
    }
    // MARK: - Refresh Array
    func refreshArray(){
        if(selectedCategory?.catName == refridFreezerNitro){
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
        }
        else{
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
        }
        //        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as NSNumber? ?? 0)
        
    }
    
    
    func filterCategory(){
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray{
            if peNewAssessment.evaluationID == object.evaluationID{
                peCategoryFilteredArray.append(object)
            }
        }
        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
    }
    
    // MARK: - Generate random number */
    
    func getRandomNumber(maxNumber: Int, listSize: Int)-> Int {
        var randomNumbers = Set<Int>()
        var sum = 0
        while randomNumbers.count < listSize {
            let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
            sum = sum + randomNumber
            randomNumbers.insert(randomNumber)
        }
        return sum
    }
    
    
    // MARK: -Update Score
    private func updateScore(isAllNA:Bool?)  {
        if(isAllNA ?? false){
            let totalMark = selectedCategory?.catMaxMark ?? 0
            resultScoreLabel.text = "0"
            totalScoreLabel.text = "0"
            
        }else{
            let totalMark = selectedCategory?.catMaxMark ?? 0
            resultScoreLabel.text = String(selectedCategory?.catResultMark ?? 0)
            totalScoreLabel.text = String(selectedCategory?.catMaxMark ?? 0)
        }
        
    }
    
    
    private func selectinitialCell() {
        collectionView.selectItem(at: collectionviewIndexPath, animated: false, scrollPosition: .left)
        updateScore(isAllNA: false)
    }
    
    // MARK: - Finalize Button Action
    @IBAction func finalizeButtonClicked(_ sender: Any) {
        finishingAssessment = true
        forInovo = true
        self.strings.removeAll()
        if  checkNoteForEveryQuestion(){
            
            if validateForm(){
                
                if regionID == 3
                {
                    if strings.count > 0
                    {
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "customAlertView") as! customAlertView
                        vc.AllMessages = strings
                        vc.viewHeight = 200 * strings.count
                        self.navigationController?.present(vc, animated: false, completion: nil)
                        
                    }
                    
                    else
                    {
                        let errorMSg = "Are you sure you want to finish the assessment? After finishing the information can't be edited."
                        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                            _ in
                            NSLog("OK Pressed")
                            self.saveFinalizedData()
                        }
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                        alertController.addAction(okAction)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else
                {
                    let errorMSg = "Are you sure you want to finish the assessment? After finishing the information can't be edited."
                    let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                        _ in
                        self.saveFinalizedData()
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
                
            }
            
        }
    }
    // MARK: - Draft Button Action
    @IBAction func draftBtnClicked(_ sender: Any) {
        let errorMSg = "Are you sure you want to save assessment in Draft?"
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            self.saveDraftData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func draftButtonClickedInitial(_ sender: Any) {
        let errorMSg = "Are you sure you want to save assessment in Draft?"
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            self.saveDraftData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // MARK: - Save final assessment
    
    private func saveFinalizedData(){
        
        Constants.isMovedOn = true
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEFinishPopupViewController") as? PEFinishPopupViewController
        vc?.scheduledAssessment = peNewAssessment
        vc?.isFromSchedule = true
        if peNewAssessment.evaluationID == 1 {
            var z = 0
            for _ in certificateData {
                certificateData[z].fsrSign = ""
                certificateData[z].signatureImg = ""
                // certificateData[z].isCertExpired = true
                z = z + 1
            }
            UserDefaults.standard.set(nil, forKey: "FsrSign")
            UserDefaults.standard.set(false, forKey: "isSignedFSR")
        }
        
        vc?.certificateData = certificateData
        vc?.validationSuccessFull = {[unowned self] ( param) in
            
            /* Check the count before submitting #suraj*/
            
            DispatchQueue.main.async {
                let allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: self.scheduledAssessment?.serverAssessmentId ?? "")
                
                // var allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "")//[PENewAssessment]()
                
                
                
                let dataToSubmitNumber = self.getAssessmentInOfflineFromDb()
                
                self.jsonRe = (self.getJSON("QuestionAns") ?? JSON())
                
                self.pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(self.jsonRe)
                
                var peCategoryFilteredArray: [PECategory] =  []
                for object in self.pECategoriesAssesmentsResponse.peCategoryArray{
                    if self.peNewAssessment.evaluationID == object.evaluationID{
                        peCategoryFilteredArray.append(object)
                    }
                }
                
                let savedDataIs =  CoreDataHandlerPE().saveDataToSyncPEInDBArray(newAssessmentArray: allAssesmentArr as? [PENewAssessment] ?? [], dataToSubmitNumber: dataToSubmitNumber + 1,param:param)
                
                
                var refrigtorArray  : [PE_Refrigators] = []
                refrigtorArray =   CoreDataHandlerPE().getREfriData(id: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                if(refrigtorArray.count > 0){
                    for refrii in refrigtorArray{
                        if(CoreDataHandlerPE().checkOfflineSameAssesmentEntityExists(id: Int(refrii.id ?? 0),serverAssessmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)){
                            CoreDataHandlerPE().updateOfflineRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveOfflineRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                            
                        }
                    }
                }
                
                PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:" ",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                
                
                if savedDataIs {
                    //                    if self.getAssessmentCountInOfflineFromDb() == peCategoryFilteredArray.count {
                    
                    let appDelegate    = UIApplication.shared.delegate as? AppDelegate
                    appDelegate?.saveContext()
                    Constants.isDraftAssessment = false
                    
                    self.finishSession()
                    
                    //  } else  {
                    //    self.showtoast(message: "Signature not captured,try again")
                    //   }
                }
            }
            
            
        }
        if vc != nil {
            self.navigationController?.present(vc!, animated: false, completion: nil)
        }
        
    }
    
    private func getAllDateArrayStored() -> [PENewAssessment]{
        var peAssessmentArray : [PENewAssessment] = []
        let drafts  = CoreDataHandlerPE().getSessionAssessmentArrayPEObject(ofCurrentAssessment:true)
        
        let draftsNew  = CoreDataHandlerPE().getSessionAssessmentArrayPEObjectDraft(ofCurrentAssessment:true)
        
        var carColIdArray : [Int] = []
        for obj in drafts {
            if !carColIdArray.contains(obj.dataToSubmitNumber ?? 0){
                carColIdArray.append(obj.dataToSubmitNumber ?? 0)
                peAssessmentArray.append(obj)
            }
        }
        
        var carColIdArrayraft : [Int] = []
        for obj in draftsNew {
            if !carColIdArrayraft.contains(obj.draftNumber ?? 0){
                carColIdArrayraft.append(obj.draftNumber ?? 0)
                peAssessmentArray.append(obj)
            }
        }
        return peAssessmentArray
    }
    
    // MARK: - Get all offline session
    func getAssessmentInOfflineFromDb() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInOffline")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
        var carColIdArray : [Int] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count
    }
    
    // MARK: - Get Offline session count
    func getAssessmentCountInOfflineFromDb() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInOffline")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitID") as? NSArray ?? []
        let lastDataToSubmitNumber = carColIdArrayDraftNumbers.lastObject as? String ?? "xx"
        var carColIdArray : [String] = []
        for obj in carColIdArrayDraftNumbers {
            let objStr =  obj as? String ?? ""
            if objStr  == lastDataToSubmitNumber {
                carColIdArray.append(obj as? String ?? "")
            }
        }
        return carColIdArray.count
    }
    
    // MARK: - Get Draft session count
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
    
    // MARK: - Save draft session
    
    private func saveDraftData(){
        if extendedMicroSwitch.isOn {
            extendedMicroSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateIsEMRequestedInAssessmentInProgress(isEMRequested: false)
        }
        var refCatID = Int()
        let allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: self.scheduledAssessment?.serverAssessmentId ?? "")
        for assessment in allAssesmentArr{
            assessment.statusType = 0
            if assessment.catName == "Refrigerator"
            {
                refCatID = assessment.catID ?? 0
            }
        }
        PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:"draft",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        let draftNumber = getDraftCountFromDb()
        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr, draftNumber: draftNumber + 1)
        
        var refrigtorArray  : [PE_Refrigators] = []
        refrigtorArray =   CoreDataHandlerPE().getREfriData(id: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
        if(refrigtorArray.count > 0){
            for refrii in refrigtorArray{
                if(CoreDataHandlerPE().checkDraftSameAssesmentEntityExists(id: Int(refrii.id ?? 0),serverAssessmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)){
                    CoreDataHandlerPE().updateDraftRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveDraftRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                }
            }
        } else {
            
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(refCatID as NSNumber)
            for i in catArrayForTableIs{
                let refri =   i as! PE_AssessmentInProgress
                CoreDataHandlerPE().saveRefrigatorInDB(refri.assID as! NSNumber,  labelText:  "", rollOut: "Y", unit:  "Celsius" , value: 0.0,catID: refri.catID as! NSNumber,isCheck: false,isNA: false,schAssmentId: Int(refri.serverAssessmentId ?? "0") ?? 0)
            }
        }
        Constants.isDraftAssessment = true
        finishSession()
        
    }
    func finishSession()  {
        cleanSession()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
    }
    
    // MARK: - Session reset
    
    private func cleanSession(){
        
        let peNewAssessmentSurrentIs =  CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject(serverAssessmentId:scheduledAssessment?.serverAssessmentId ?? "")
        
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
        peNewAssessmentNew.clorineId = peNewAssessmentSurrentIs.clorineId
        peNewAssessmentNew.clorineName = peNewAssessmentSurrentIs.clorineName
        peNewAssessmentNew.isHandMix = peNewAssessmentSurrentIs.isHandMix
        peNewAssessmentNew.ppmValue = peNewAssessmentSurrentIs.ppmValue
        peNewAssessmentNew.countryName = peNewAssessmentSurrentIs.countryName
        peNewAssessmentNew.countryID = peNewAssessmentSurrentIs.countryID
        peNewAssessmentNew.fluid = peNewAssessmentSurrentIs.fluid
        peNewAssessmentNew.basicTransfer = peNewAssessmentSurrentIs.basicTransfer
        peNewAssessmentNew.refrigeratorNote = peNewAssessmentSurrentIs.refrigeratorNote
        peNewAssessmentNew.IsEMRequested = peNewAssessmentSurrentIs.IsEMRequested
        peNewAssessmentNew.extndMicro = peNewAssessmentSurrentIs.extndMicro
        peNewAssessmentNew.sanitationValue = peNewAssessmentSurrentIs.sanitationValue
        
        CoreDataHandler().deleteAllData("PE_AssessmentInProgress",predicate: NSPredicate(format: "userID == %d AND serverAssessmentId = %@", peNewAssessment?.userID ?? 0, peNewAssessment?.serverAssessmentId ?? ""))
        self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
    }
    
}

// MARK: - UITableViewDelegate

extension PEAssesmentFinalize: UITableViewDelegate, UITableViewDataSource{
    
    func checkForTraning()-> Bool{
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if catArrayForTableIs.count > 0 {
            var assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
            if assessment?.sequenceNoo == 1  {
                if checkForTraning(){
                    return 5
                } else {
                    return 4
                }
            } else if assessment?.sequenceNoo == 3 {
                if regionID != 3{
                    return 1
                }
                else
                {
                    if peNewAssessment.evaluationID == 1
                    {
                        return 1
                    }
                    else{
                        return 2
                    }
                }
            }
            else if assessment?.sequenceNoo == 1 {
                return 5
            }
            if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != refridFreezerNitro{
                return 1
            }
            if selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro{
                return 3
            }
            else {
                return 1
            }
        }
        if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != refridFreezerNitro{
            return 1
        }
        if selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro{
            return 3
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if checkForTraning(){
            
            if section == 0 && selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != refridFreezerNitro {
                return sanitationQuesArr.count
            }
            
            if (selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro){
                return 2
            }
            if section == 1 {
                return certificateData.count
            }
            if section == 2 {
                return inovojectData.count
            }
            if section == 3 {
                return dayOfAgeData.count
            }
            if section == 4 {
                return dayOfAgeSData.count
            }
            return catArrayForTableIs.count
        } else {
            var assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
            if assessment?.sequenceNoo == 3 {
                if section == 0 {
                    return catArrayForTableIs.count                }
                if section == 1 {
                    return 1
                }
            } else {
                if section == 1 {
                    return inovojectData.count
                }
                if section == 2 {
                    return dayOfAgeData.count
                }
                if section == 3 {
                    return dayOfAgeSData.count
                }
            }
            return catArrayForTableIs.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if checkForTraning(){
            if(selectedCategory?.catName != refridFreezerNitro){
                if indexPath.section == 1 {
                    var height:CGFloat = CGFloat()
                    height = 160
                    return height
                }
                
                if indexPath.section == 2 {
                    return 200
                }
                
                
            }
        }
        if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != refridFreezerNitro{
            var height:CGFloat = CGFloat()
            height = 70
            return height
        }
        
        var assessment : PE_AssessmentInProgress?
        
        if catArrayForTableIs.count > 0 {
            assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
            if selectedCategory?.sequenceNoo == 3 {
                if (indexPath.section == 0){
                    if selectedCategory?.sequenceNoo == 3 && assessment?.rollOut == "Y" && assessment?.qSeqNo == 1{
                        var height:CGFloat = CGFloat()
                        height = 120
                        return height
                    }
                    else {
                        var height:CGFloat = CGFloat()
                        height = 70
                        return height
                    }
                }
                else {
                    var height:CGFloat = CGFloat()
                    height = 0
                    return height
                }
            }
        }
        
        if selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == refridFreezerNitro{
            var height:CGFloat = CGFloat()
            height = 80
            return height
            
        }
        if(selectedCategory?.catName != refridFreezerNitro){
            if indexPath.section > 0 {
                var height:CGFloat = CGFloat()
                height = 130
                return height
            }
        }
        
        var height:CGFloat = CGFloat()
        height = self.estimatedHeightOfLabel(text: assessment?.assDetail1 ?? "") + 50
        return height
        
    }
    
    func estimatedHeightOfLabel(text: String) -> CGFloat {
        
        let size = CGSize(width: view.frame.width - 16, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)//font type and size
        
        let attributes = [NSAttributedString.Key.font: font]
        
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        
        return rectangleHeight
    }
    
    func getLableHeightRuntime(stringValue:String) -> CGFloat {
        let width:CGFloat = 0
        let _:CGFloat = 0
        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)//font type and size
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = stringValue.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func setupNewInovoCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath){
        print(appDelegate.testFuntion())
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if checkForTraning(){
            
            if indexPath.section == 0 && selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName == extendedMicStr{// "Sanitation and Embrex Evaluation"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlateInfoCell", for: indexPath) as! PlateInfoCell
                cell.currentIndex = indexPath.row
                if sanitationQuesArr.count > indexPath.row{
                    cell.setValues(quesObj: sanitationQuesArr[indexPath.row], index: indexPath.row)
                }
                cell.plateTypeCompletion = {
                    [unowned self] ( error) in
                    self.tableviewIndexPath = indexPath
                    let plateTypes = PlateTypesDAO.sharedInstance.fetchPlateTypes(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "")
                    let arr = plateTypes.map{ $0.value}
                    self.dropDownVIewNew(arrayData: arr as? [String] ?? [String](), kWidth: cell.plateTypeBtn.frame.width, kAnchor: cell.plateTypeBtn, yheight: cell.plateTypeBtn.bounds.height) {
                        [unowned self] selectedVal, index  in
                        if indexPath.row > -1 && self.sanitationQuesArr.count > indexPath.row{
                            let quesObj = self.sanitationQuesArr[indexPath.row]
                            if index > -1 && plateTypes.count > index{
                                self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "")
                                
                                quesObj.plateTypeDescription = plateTypes[index].value
                                quesObj.plateTypeId =  plateTypes[index].id
                                
                                self.sanitationQuesArr[indexPath.row] = quesObj
                                SanitationEmbrexQuestionMasterDAO.sharedInstance.updateAssessmentQuestion(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "", questionId: Int64(quesObj.questionId ?? "") ?? 0, questionVM: quesObj)
                                
                            }
                            self.tableview.beginUpdates()
                            self.tableview.reloadRows(at: [indexPath], with: .none)
                            self.tableview.endUpdates()
                        }
                    }
                    self.dropHiddenAndShow()
                }
                cell.commentsCompletion = {[unowned self] ( error) in
                    self.tableviewIndexPath = indexPath
                    
                    self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "")
                    var comments = self.sanitationQuesArr[indexPath.row].userComments ?? ""
                    var questionObj = self.sanitationQuesArr[indexPath.row]
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
                    vc.textOfTextView = comments
                    vc.editable = true
                    vc.commentCompleted = {[unowned self] ( note) in
                        if note == "" {
                            let image = UIImage(named: peCommentImg)
                            cell.noteBtn.setImage(image, for: .normal)
                            
                        } else {
                            let image = UIImage(named: peCommentSelectedStr)
                            cell.noteBtn.setImage(image, for: .normal)
                        }
                        
                        questionObj.userComments = note ?? ""
                        self.sanitationQuesArr[indexPath.row] = questionObj
                        
                        if questionObj != nil{
                            SanitationEmbrexQuestionMasterDAO.sharedInstance.updateAssessmentQuestion(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "", questionId: Int64(questionObj.questionId ?? "") ?? 0, questionVM: questionObj)
                            tableView.beginUpdates()
                            tableView.reloadRows(at: [IndexPath.init(row: indexPath.row, section: 0)], with: .automatic)
                            tableView.endUpdates()
                        }
                        
                    }
                    if vc.editable{
                        
                        self.navigationController?.present(vc, animated: false, completion: nil)
                        
                    }else{
                        if comments != nil && comments != ""{
                            self.navigationController?.present(vc, animated: false, completion: nil)
                        }
                    }
                }
                self.refreshScore(indexPath.row)
                cell.assessmentId = scheduledAssessment?.serverAssessmentId
                return cell
            }
            if(selectedCategory?.catName == refridFreezerNitro){
                
                return  setUpRerigatorQuesCell(tableView, cellForRowAt: indexPath)
            }
            else{
                if indexPath.section == 1 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: VaccineMixerCell.identifier) as? VaccineMixerCell{
                        cell.certDateSelectBtn.tag = indexPath.row
                        cell.vaccNameField.tag = indexPath.row
                        cell.calenderBtn.tag = indexPath.row
                        cell.vaccNameField.delegate = self
                        
                        
                        if certificateData.count > 0 {
                            cell.config(data:certificateData[indexPath.row])
                            if dataArray.contains(certificateData[indexPath.row].name!){
                                var count = dataArray.firstIndex(of: certificateData[indexPath.row].name!)
                                if isCertExpiredArray[count!] {
                                    cell.certDateSelectBtn.setTitle(certDateArray[count!], for: .normal)
                                    cell.certDateSelectBtn.layer.borderColor = UIColor.red.cgColor
                                }
                                else {
                                    cell.certDateSelectBtn.setTitle(certDateArray[count!], for: .normal)
                                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                }
                            }
                            else {
                                
                                if let title = cell.certDateSelectBtn.title(for: .normal), !title.isEmpty {
                                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                } else {
                                    if regionID == 3
                                    {
                                        cell.certDateSelectBtn.layer.borderColor = UIColor.red.cgColor
                                    }
                                    else
                                    {
                                        cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                    }
                                }
                                
                                if let title = cell.vaccNameField.text , !title.isEmpty
                                {
                                    cell.vaccNameField.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                }else {
                                    if regionID == 3
                                    {
                                        cell.vaccNameField.layer.borderColor = UIColor.red.cgColor
                                    }
                                    else
                                    {
                                        cell.vaccNameField.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                    }
                                }
                            }
                        }
                        cell.certDateCompletion = { [unowned self] (count) in
                            
                            if cell.vaccNameField.text != "" {
                                if !dataArray.contains(cell.vaccNameField.text!) {
                                    let date =   peNewAssessment.evaluationDate
                                    if(regionID != 3){
                                        let inputFormatter = DateFormatter()
                                        inputFormatter.dateFormat = ddmmyyStr
                                        let showDate = inputFormatter.date(from: date ?? "")
                                        inputFormatter.dateFormat = ddmmyyStr
                                        if(showDate != nil){
                                            let resultString = inputFormatter.string(from: showDate!)
                                            cell.certDateSelectBtn.setTitle(resultString, for: .normal)
                                        }
                                        else{
                                            cell.certDateSelectBtn.setTitle(date, for: .normal)
                                        }
                                        
                                    }else{
                                        cell.certDateSelectBtn.setTitle(date, for: .normal)
                                    }
                                    
                                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                                    dateBlock?(date , false ,true, count )
                                }
                            }
                            
                            cell.vaccNameField.endEditing(true)
                            cell.vaccNameField.resignFirstResponder()
                        }
                        
                        cell.changedDateCompletion  = {[unowned self] ( index) in
                            chnagedIndexPathRow = index ?? 0
                            if cell.vaccNameField.text != "" {
                                if(cell.certDateSelectBtn.titleLabel?.text != ""){
                                    self.view.endEditing(true)
                                    let superviewCurrent =  cell.certDateSelectBtn.superview
                                    if superviewCurrent != nil {
                                        for view in superviewCurrent!.subviews {
                                            if view.isKind(of:UIButton.self) {
                                            }
                                        }
                                    }
                                    
                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
                                    let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as? DatePickerPopupViewController
                                    datePickerPopupViewController?.delegate = self
                                    datePickerPopupViewController?.isCertificateDate = 1
                                    datePickerPopupViewController?.canSelectPreviousDate = true
                                    if datePickerPopupViewController != nil
                                    {
                                        navigationController?.present(datePickerPopupViewController!, animated: false, completion: nil)
                                    }
                                }
                            }
                        }
                        
                        changedDate = {  [unowned self] (date) in
                            
                            self.tableviewIndexPath = indexPath
                            certificateData[chnagedIndexPathRow].certificateDate = date
                            CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[chnagedIndexPathRow], id:  self.certificateData[chnagedIndexPathRow].id ?? 0)
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                            cell.vaccNameField.resignFirstResponder()
                            cell.vaccNameField.endEditing(true)
                        }
                        
                        dateBlock = { [unowned self] (date , certifiedExpery , isReCert  ,Count) in
                            
                            certificateData[Count].certificateDate = date
                            certificateData[Count].isCertExpired = certifiedExpery
                            self.certificateData[Count].name = cell.vaccNameField.text ?? ""
                            certificateData[Count].isReCert = isReCert
                            
                            if dataArray.contains(cell.vaccNameField.text!){
                                let index =  dataArray.firstIndex(of: cell.vaccNameField.text!)
                                certificateData[Count].vacOperatorId = mixerIdArray[index!]
                                CoreDataHandlerPE().updateVMixerNewInDB(peCertificateData:  self.certificateData[Count], id:  self.certificateData[Count].id ?? 0)
                            }
                            else {
                                certificateData[Count].vacOperatorId = 0
                                CoreDataHandlerPE().updateVMixerNewInDB(peCertificateData:  self.certificateData[Count], id:  self.certificateData[Count].id ?? 0)
                            }
                            cell.vaccNameField.resignFirstResponder()
                            cell.vaccNameField.endEditing(true)
                        }
                        
                        nameblock = {[unowned self] ( error) in
                            self.tableviewIndexPath = indexPath
                            self.certificateData[self.tableviewIndexPath.row].name = error
                            CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.tableviewIndexPath.row], id:  self.certificateData[self.tableviewIndexPath.row].id ?? 0)
                            
                            cell.vaccNameField.resignFirstResponder()
                            cell.vaccNameField.endEditing(true)
                        }
                        
                        updateNameblock = {[unowned self] ( error) in
                            if certificateData.count > 0 {
                                self.certificateData[self.chnagedVaccineNameIndexPathRow].name = error
                                CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.chnagedVaccineNameIndexPathRow], id:  self.certificateData[self.chnagedVaccineNameIndexPathRow].id ?? 0)
                                cell.vaccNameField.resignFirstResponder()
                            }
                        }
                        return cell
                    }
                }
                if indexPath.section == 2 {
                    
                    return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
                }
                if indexPath.section == 3
                {
                    return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
                }
                if indexPath.section == 4{
                    return self.setupDayOfAgeSCell(tableView, cellForRowAt: indexPath)
                }
                else {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
        }
        
        else {
            let assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
            if assessment?.sequenceNoo == 3 && assessment?.catName?.lowercased()
                != "miscellaneous" {
                if indexPath.section == 0 {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
            else if(assessment?.sequenceNoo == 12 && assessment?.catName?.lowercased()
                    != "Refrigator\n/Fridger\n/Liquid Nitriogen" ){
                if indexPath.section == 1 {
                    return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
                }
            }
            else {
                if indexPath.section == 1 {
                    return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
                }
                if indexPath.section == 2 {
                    return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
                }
                if indexPath.section == 3{
                    return self.setupDayOfAgeSCell(tableView, cellForRowAt: indexPath)
                }
                else {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
        }
        
        return UITableViewCell()
    }
    
    // MARK: - Inovoject set up
    
    func setupInovojectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectNewTableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: InovojectNewTableViewCell.identifier) as? InovojectNewTableViewCell{
            if indexPath.row % 2 == 0{
                cell.contentView.backgroundColor = UIColor.white
            } else{
                cell.contentView.backgroundColor = UIColor.getHeaderTopGradient()
            }
            
            cell.config(data:inovojectData[indexPath.row])
            if inovojectData[indexPath.row].invoHatchAntibiotic == 1 {
                cell.showHatcheryAnitibiotics()
            } else {
                cell.hideHatcheryAntibiotics()
            }
            if inovojectData[indexPath.row].vaccineMan?.lowercased().containsCaseInsensitive(string: "other") ?? false {
                cell.showOthersConstraint()
            } else {
                cell.hideOthersConstraint()
            }
            
            cell.diluentManuCompletion = {[unowned self] ( error) in
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgId") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfDiluentManu.frame.width, kAnchor: cell.tfDiluentManu, yheight: cell.tfDiluentManu.bounds.height) { [unowned self] selectedVal, index  in
                        cell.tfDiluentManu.text = selectedVal
                        self.inovojectData[indexPath.row].vaccineMan = selectedVal
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
            }
            cell.bagSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeIDArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BagSizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                bagSizeIDArray = bagSizeDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    self.dropDownVIewNew(arrayData: bagSizeArray as? [String] ?? [String](), kWidth:  cell.tfBagSize.frame.width, kAnchor: cell.tfBagSize, yheight: cell.tfBagSize.bounds.height) { [unowned self] selectedVal, index  in
                        cell.tfBagSize.text = selectedVal
                        self.inovojectData[indexPath.row].bagSizeType = selectedVal
                        
                        let c = Double(self.inovojectData[indexPath.row].bagSizeType ?? "0") ?? 0
                        if c == 0 {
                            self.showtoast(message: incompleteDataStr)
                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                            
                            return
                        }
                        let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
                        let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
                        if a != 0 && b != 0 {
                            let x = a * b
                            let y = c/0.05
                            let z = x/y
                            
                            let r  = Rational(approximating: z)
                            let n = String(r.numerator)
                            let d = String(r.denominator)
                            
                            if regionID == 3 {
                                self.inovojectData[indexPath.row].dosage = n + "/" + d
                            }
                            else
                            {
                                self.inovojectData[indexPath.row].dosage = "\(Double(round(1000 * z) / 1000))"
                            }
                        }
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
            }
            cell.programCompletion = {[unowned self] ( text) in
                self.inovojectData[indexPath.row].invoProgramName = text ?? ""
                
                if self.inovojectData.count > 0 && self.inovojectData[indexPath.row].invoProgramName != ""
                {
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                }
                self.tableview.reloadData()
                
            }
            cell.antibioticCompletion = {[unowned self] ( text) in
                self.inovojectData[indexPath.row].invoHatchAntibioticText = text ?? ""
                CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                }
            }
            cell.otherManCompletion  = {[unowned self] ( text) in
                self.inovojectData[indexPath.row].doaDilManOther = text ?? ""
                CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                }
            }
            cell.switchCompletion = {[unowned self] ( text) in
                if text == "on"{
                    self.inovojectData[indexPath.row].invoHatchAntibiotic = 1
                } else {
                    self.inovojectData[indexPath.row].invoHatchAntibiotic = 0
                    
                }
                CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
            }
            cell.ampleSizeCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    
                    let  selectedValIS = selectedVal.replacingOccurrences(of: " ", with: "")
                    let c = Double(self.inovojectData[indexPath.row].bagSizeType ?? "0") ?? 0
                    if c == 0 {
                        self.showtoast(message: incompleteDataStr)
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                        
                        return
                    }
                    self.inovojectData[indexPath.row].ampuleSize = selectedValIS
                    let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
                    let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
                    if a != 0 {
                        let x = a * b
                        let y = c/0.05
                        let z = x/y
                        
                        let r  = Rational(approximating: z)
                        let n = String(r.numerator)
                        let d = String(r.denominator)
                        if regionID == 3 {
                            self.inovojectData[indexPath.row].dosage = n + "/" + d
                        }
                        else
                        {
                            self.inovojectData[indexPath.row].dosage = "\(Double(round(1000 * z) / 1000))"
                        }
                    }
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.amplePerBagCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                        self.inovojectData[indexPath.row].ampulePerBag = selectedVal
                        let c = Double(self.inovojectData[indexPath.row].bagSizeType ?? "0") ?? 0
                        if c == 0 {
                        }
                        
                        let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
                        let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
                        if  b != 0 && a != 0 && b != 0{
                            let x = a * b
                            let y = c/0.05
                            let z = x/y
                            
                            let r  = Rational(approximating: z)
                            let n = String(r.numerator)
                            let d = String(r.denominator)
                            if regionID == 3 {
                                self.inovojectData[indexPath.row].dosage = n + "/" + d
                            }
                            else
                            {
                                self.inovojectData[indexPath.row].dosage = "\(Double(round(1000 * z) / 1000))"
                            }
                            
                        }
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
            }
            
//            cell.doseCompletion  = {[unowned self] ( error) in
//                
//            }
            
            cell.nameCompletion  = {[unowned self] ( text) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                var _ : [Int] = []
                var vNameFilterArray : [String] = []
                var vNameArray = NSArray()
                _ = NSArray()
                var vNameDetailsArray = NSArray()
                _ = NSArray()
                vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
                vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                vNameFilterArray = vNameArray as? [String] ?? []
                
                if  vNameFilterArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vNameFilterArray as? [String] ?? [String](), kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
                        self.inovojectData[indexPath.row].name = selectedVal
                        
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                        
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            return cell
        }
        
        return UITableViewCell() as! InovojectNewTableViewCell
    }
    
    // MARK: - Setup day of age
    
    func setupDayOfAgeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
            cell.config(data:dayOfAgeData[indexPath.row],isDayOfAge:true)
            
            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
                        self.dayOfAgeData[indexPath.row].vaccineMan = selectedVal
                        if selectedVal == "Other"{
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        } else {
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                            
                        }
                        self.dayOfAgeData[indexPath.row].name = ""
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
                
            }
            
            cell.ampleSizeCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    
                    self.dayOfAgeData[indexPath.row].ampuleSize = selectedVal
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.amplePerBagCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                        
                        self.dayOfAgeData[indexPath.row].ampulePerBag = selectedVal
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.doseCompletion  = {[unowned self] ( error) in
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Dose")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "dose") as? NSArray ?? NSArray()
                
                let vNameFilterArray = vManufacutrerNameArray
                if  vNameFilterArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vNameFilterArray as? [String] ?? [String](), kWidth: cell.tfDosage.frame.width, kAnchor: cell.tfDosage, yheight: cell.tfDosage.bounds.height) { [unowned self] selectedVal, index  in
                        self.dayOfAgeData[indexPath.row].dosage = selectedVal
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            cell.nameCompletion  = {[unowned self] ( text) in
                self.tableviewIndexPath = indexPath
                if text != "" {
                    self.dayOfAgeData[indexPath.row].name = text
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                    
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }else {
                    var ManufacturerId = 0
                    var vManufacutrerNameArray = NSArray()
                    var vManufacutrerIDArray = NSArray()
                    var vManufacutrerDetailsArray = NSArray()
                    vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                    vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                    vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    let xxx = self.dayOfAgeData[indexPath.row].vaccineMan ?? ""
                    if xxx != "" {
                        let indexOfd = vManufacutrerNameArray.index(of: xxx)
                        ManufacturerId = vManufacutrerIDArray[indexOfd] as? Int ?? 0
                    } else {
                        
                    }
                    var indexArray : [Int] = []
                    var vNameFilterArray : [String] = []
                    var vNameArray = NSArray()
                    var vNameIDArray = NSArray()
                    var vNameDetailsArray = NSArray()
                    var vNameMfgIdArray = NSArray()
                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 1)
                    vNameArray = vNameDetailsArray.value(forKey: "name")  as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId")  as? NSArray ?? NSArray()
                    var x = -1
                    for obj in vNameMfgIdArray {
                        x = x + 1
                        if obj as? Int ?? 0 == ManufacturerId
                        {
                            _ = vNameMfgIdArray.index(of: obj) // 3
                            indexArray.append(x)
                        }
                    }
                    _ = vNameMfgIdArray.index(of: ManufacturerId)
                    for index in indexArray {
                        
                        _ = vNameArray[index] as? String ?? ""
                    }
                    vNameFilterArray = vNameArray as? [String] ?? [String]()
                    
                    
                    if  vNameFilterArray.count > 0 {
                        self.dropDownVIewNew(arrayData: vNameFilterArray as? [String] ?? [String](), kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
                            self.dayOfAgeData[indexPath.row].name = selectedVal
                            let manufId = vNameMfgIdArray[index] as? Int64 ?? 0
                            vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName")  as? NSArray ?? NSArray()
                            vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                            _ =  vManufacutrerIDArray.index(of: manufId as? Int64 ?? 0)
                            
                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                            
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        }
                        self.dropHiddenAndShow()
                    }
                }
                self.view.endEditing(true)
            }
            DispatchQueue.main.async {
                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            }
            return cell
        }
        return UITableViewCell() as! InovojectCell
    }
    
    
    // MARK: - Setup day of age subcatenous
    
    func setupDayOfAgeSCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
            cell.config(data:dayOfAgeSData[indexPath.row],isDayOfAge:false)
            
            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
                        self.dayOfAgeSData[indexPath.row].vaccineMan = selectedVal
                        if selectedVal == "Other"{
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        } else {
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        }
                        self.dayOfAgeSData[indexPath.row].name = ""
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                    self.dropHiddenAndShow()
                }
                
            }
            
            
            cell.ampleSizeCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
                        self.ml = 0.0
                    }
                    else if self.peNewAssessment.dDDT?.lowercased().contains(oneGallonStr) ?? false {
                        self.ml = 3785.41
                    }
                    else if self.peNewAssessment.dDDT?.lowercased().contains(twoGallonStr) ?? false {
                        self.ml = 7570.82
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(fiveGallonStr) ?? false {
                        self.ml = 18927.05
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(twoLitre) ?? false {
                        self.ml = 2000.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(liter24) ?? false {
                        self.ml = 2400.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(liter28) ?? false {
                        self.ml = 2800.00
                    }
                    else if self.peNewAssessment.dDDT?.lowercased().contains(mil200) ?? false {
                        self.ml = 200.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(mil300) ?? false {
                        self.ml = 300.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(mil400) ?? false {
                        self.ml = 400.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains(mil500) ?? false {
                        self.ml = 500.00
                    }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
                        self.ml = 800.00
                    }
                    let c = self.ml
                    if c == 0.0 {
                        self.dayOfAgeSData[indexPath.row].dosage = ""
                    }
                    self.dayOfAgeSData[indexPath.row].ampuleSize = selectedVal
                    let a = Double(self.dayOfAgeSData[indexPath.row].ampulePerBag ?? "0") ?? 0
                    let b = Double(self.dayOfAgeSData[indexPath.row].ampuleSize ?? "0") ?? 0
                    if a != 0 && b != 0 && c != 0{
                        let x = a * b
                        let y = c/0.2
                        let z = x/y
                        
                        let r  = Rational(approximating: z)
                        let n = String(r.numerator)
                        let d = String(r.denominator)
                        
                        if regionID == 3 {
                            self.dayOfAgeSData[indexPath.row].dosage = n + "/" + d
                        }else
                        {
                            self.dayOfAgeSData[indexPath.row].dosage = "\(Double(round(1000 * z) / 1000))"
                        }
                        
                    }
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.amplePerBagCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                _ = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                        
                        if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
                            self.ml = 0.0
                        }
                        else if self.peNewAssessment.dDDT?.lowercased().contains(oneGallonStr) ?? false {
                            self.ml = 3785.41
                        }else if self.peNewAssessment.dDDT?.lowercased().contains(twoGallonStr) ?? false {
                            self.ml = 7570.82
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(fiveGallonStr) ?? false {
                            self.ml = 18927.05
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(twoLitre) ?? false {
                            self.ml = 2000.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(liter24) ?? false {
                            self.ml = 2400.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(liter28) ?? false {  self.ml = 2800.00
                        }
                        
                        else if self.peNewAssessment.dDDT?.lowercased().contains(mil200) ?? false {
                            self.ml = 200.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil300) ?? false {
                            self.ml = 300.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil400) ?? false {
                            self.ml = 400.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil500) ?? false {
                            self.ml = 500.00
                        }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
                            self.ml = 800.00
                        }
                        let c = self.ml
                        if c == 0.0 {
                            self.dayOfAgeSData[indexPath.row].dosage = ""
                        }
                        self.dayOfAgeSData[indexPath.row].ampulePerBag = selectedVal
                        let a = Double(self.dayOfAgeSData[indexPath.row].ampulePerBag ?? "0") ?? 0
                        let b = Double(self.dayOfAgeSData[indexPath.row].ampuleSize ?? "0") ?? 0
                        if a != 0 && b != 0 && c != 0{
                            let x = a * b
                            let y = c/0.2
                            let z = x/y
                            
                            let r  = Rational(approximating: z)
                            let n = String(r.numerator)
                            let d = String(r.denominator)
                            
                            
                            if regionID == 3 {
                                self.dayOfAgeSData[indexPath.row].dosage = n + "/" + d
                            }
                            else
                            {
                                self.dayOfAgeSData[indexPath.row].dosage = "\(Double(round(1000 * z) / 1000))"
                            }
                        }
                        
                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                        UIView.performWithoutAnimation {
                            self.tableview.reloadData()
                        }
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.doseCompletion  = {[unowned self] ( error) in
                
            }
            
            
            cell.nameCompletion  = {[unowned self] ( text) in
                self.tableviewIndexPath = indexPath
                if text != "" {
                    self.dayOfAgeSData[indexPath.row].name = text
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                    
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }else {
                    var ManufacturerId = 0
                    var vManufacutrerNameArray = NSArray()
                    var vManufacutrerIDArray = NSArray()
                    var vManufacutrerDetailsArray = NSArray()
                    vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                    vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName")  as? NSArray ?? NSArray()
                    vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                    let xxx =    self.dayOfAgeSData[indexPath.row].vaccineMan ?? ""
                    if xxx != "" {
                        let indexOfd = vManufacutrerNameArray.index(of: xxx) // 3
                        ManufacturerId = vManufacutrerIDArray[indexOfd] as? Int ?? 0
                    } else {
                        
                    }
                    var indexArray : [Int] = []
                    var vNameFilterArray : [String] = []
                    var vNameArray = NSArray()
                    var vNameIDArray = NSArray()
                    var vNameDetailsArray = NSArray()
                    var vNameMfgIdArray = NSArray()
                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 2)
                    vNameArray = vNameDetailsArray.value(forKey: "name")  as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId")  as? NSArray ?? NSArray()
                    var x = -1
                    for obj in vNameMfgIdArray {
                        x = x + 1
                        if obj as? Int ?? 0 == ManufacturerId
                        {
                            _ = vNameMfgIdArray.index(of: obj) // 3
                            indexArray.append(x)
                        }
                    }
                    _ = vNameMfgIdArray.index(of: ManufacturerId)
                    for index in indexArray {
                        _ = vNameArray[index] as? String ?? ""
                    }
                    vNameFilterArray = vNameArray as? [String] ?? [String]()
                    
                    if  vNameFilterArray.count > 0 {
                        self.dropDownVIewNew(arrayData: vNameFilterArray as? [String] ?? [String](), kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
                            self.dayOfAgeSData[indexPath.row].name = selectedVal
                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                            
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        }
                        self.dropHiddenAndShow()
                    }
                }
                self.view.endEditing(true)
            }
            DispatchQueue.main.async {
                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            }
            cell.btnDosage.isEnabled = true
            return cell
        }
        return UITableViewCell() as! InovojectCell
    }
    
    // MARK: - Setup PE  Rerigator questions data
    func setUpRerigatorQuesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RefrigatorQuesCell {
        
        
        var assesmentArray = [PE_AssessmentInProgress]()
        var arrayRefri = [PE_AssessmentInProgress]()
        var arrayFreezer = [PE_AssessmentInProgress]()
        var arrayLiquid = [PE_AssessmentInProgress]()
        arrayRefri.append(catArrayForTableIs[0] as! PE_AssessmentInProgress)
        arrayRefri.append(catArrayForTableIs[1] as! PE_AssessmentInProgress)
        arrayFreezer.append(catArrayForTableIs[5] as! PE_AssessmentInProgress)
        arrayFreezer.append(catArrayForTableIs[6] as! PE_AssessmentInProgress)
        arrayLiquid.append(catArrayForTableIs[11] as! PE_AssessmentInProgress)
        arrayLiquid.append(catArrayForTableIs[12] as! PE_AssessmentInProgress)
        if(indexPath.section == 0){
            assesmentArray = arrayRefri
        }
        else if(indexPath.section == 1){
            assesmentArray = arrayFreezer
        }
        else if(indexPath.section == 2){
            assesmentArray = arrayLiquid
        }
        self.refriCamerAssesment = assesmentArray
        if let cell = tableView.dequeueReusableCell(withIdentifier: RefrigatorQuesCell.identifier) as? RefrigatorQuesCell{
            
            var assessment = assesmentArray[indexPath.row] as? PE_AssessmentInProgress
            if(refrigtorProbeArray.count > 0){
                
                for refri in refrigtorProbeArray{
                    if(refri.id == assesmentArray[indexPath.row].assID){
                        if(refri.isNA ?? false){
                            cell.btn_NA.isSelected = true
                            cell.contentView.alpha = 0.3
                            cell.btn_Switch.isUserInteractionEnabled = false
                            cell.btn_Info.isUserInteractionEnabled = false
                            cell.btn_Camera.isUserInteractionEnabled = false
                            cell.btn_Comment.isUserInteractionEnabled = false
                        }
                        else{
                            cell.btn_NA.isSelected = false
                            cell.contentView.alpha = 1
                            cell.btn_Switch.isUserInteractionEnabled = true
                            cell.btn_Info.isUserInteractionEnabled = true
                            cell.btn_Camera.isUserInteractionEnabled = true
                            cell.btn_Comment.isUserInteractionEnabled = true
                        }
                        
                    }
                }
                
            }
            cell.lblQuestion.text = assesmentArray[indexPath.row].assDetail1
            
            if(indexPath.section == 0 ){
                if(indexPath.row  == 0){
                    cell.contentView.backgroundColor = .clear
                }
                else{
                    cell.contentView.backgroundColor = .white
                }
            }
            else if( indexPath.section == 1){
                if(indexPath.row  == 0){
                    cell.contentView.backgroundColor = .clear
                }
                else{
                    cell.contentView.backgroundColor = .white
                }
            }
            else{
                if(indexPath.row  == 0){
                    cell.contentView.backgroundColor = .white
                }
                else{
                    cell.contentView.backgroundColor = .clear
                }
            }
            
            
            if assessment?.camera == 1 {
                cell.btn_Camera.isEnabled = true
                cell.btn_Camera.alpha = 1
            } else {
                cell.btn_Camera.isEnabled = false
                cell.btn_Camera.alpha = 0.3
            }
            
            if assessment?.assStatus == 1 {
                cell.switchClicked(status: true)
                cell.btn_Switch.setOn(true, animated: false)
            } else {
                cell.switchClicked(status: false)
                cell.btn_Switch.setOn(false, animated: false)
            }
            let imageCount = assessment?.images as? [Int]
            let cnt = imageCount?.count
            let ttle = String(cnt ?? 0)
            cell.btn_ImageCount.setTitle(ttle,for: .normal)
            if ttle == "0"{
                cell.btn_ImageCount.isHidden = true
            } else {
                cell.btn_ImageCount.isHidden = false
            }
            
            let image1 = UIImage(named: peCommentImg)
            let image2 = UIImage(named: peCommentSelectedStr)
            if assessment?.note == "" || assessment?.note == nil {
                cell.btn_Comment.setImage(image1, for: .normal)
            } else {
                cell.btn_Comment.setImage(image2, for: .normal)
            }
            
            
            cell.btnNA  = {[unowned self] () in
                var switchisCheck = false
                let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
                refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
                if(refrigtorProbeArray.count > 0){
                    
                    for refrii in refrigtorProbeArray{
                        if(refrii.id == assesmentArray[indexPath.row].assID){
                            if(refrii.isCheck ?? false){
                                switchisCheck = true
                            }
                            else{
                                switchisCheck = false
                            }
                        }
                    }
                }
                if(cell.btn_NA.isSelected){
                    if(self.refrigator_Selected_NA_QuestionArray[indexPath.section] == indexPath.row){
                        self.refrigator_Selected_NA_QuestionArray[indexPath.section] = nil
                    }
                    cell.contentView.alpha = 1
                    cell.btn_Switch.isUserInteractionEnabled = true
                    cell.btn_Info.isUserInteractionEnabled = true
                    cell.btn_Camera.isUserInteractionEnabled = true
                    cell.btn_Comment.isUserInteractionEnabled = true
                    assessment?.isNA = false
                    
                    if(switchisCheck){
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:  "" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,schAssmentId:  Int(scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                    }
                    else{
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:  "" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,schAssmentId:  Int(scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                    }
                    
                }
                else{
                    assessment?.isAllowNA = true
                    self.refrigator_Selected_NA_QuestionArray[indexPath.section] = indexPath.row
                    cell.contentView.alpha = 0.3
                    cell.btn_Switch.isUserInteractionEnabled = false
                    cell.btn_Info.isUserInteractionEnabled = false
                    cell.btn_Camera.isUserInteractionEnabled = false
                    cell.btn_Comment.isUserInteractionEnabled = false
                    assessment?.isNA = true
                    
                    if(switchisCheck){
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,schAssmentId: Int(scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                        }
                    }
                    else{
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,schAssmentId: Int(scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                        }
                    }
                    
                }
                cell.btn_NA.isSelected = !cell.btn_NA.isSelected
                
                refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
            }
            cell.cameraCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath.row = indexPath.row
                self.tableviewIndexPath.section = indexPath.section
                self.refriCamerAssesment = assesmentArray
                
                var assessment = assesmentArray[indexPath.row] as? PE_AssessmentInProgress
                let images = CoreDataHandlerPE().getImagecountOfQuestion(assessment:assessment ?? PE_AssessmentInProgress())
                if images < 5 {
                    self.takePhoto(cell.btn_Camera)
                } else {
                    self.showAlertForNoCamera()
                }
            }
            
            cell.imagesCompletion  = {[unowned self] ( error) in
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "GroupImagesPEViewController") as! GroupImagesPEViewController
                self.refreshArray()
                vc.imagesArray = assessment?.images as? [Int] ?? [0]
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            
            cell.infoCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "InfoPEViewController") as! InfoPEViewController
                let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
                let boldMark1 =  "("
                let boldMark2 =  ") "
                let mrk = String(maxMarksIs)
                let str  =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
                vc.questionDescriptionIs = str
                vc.imageDataBase64 = assessment?.informationImage ?? ""
                vc.infotextIs = assessment?.informationText ?? ""
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            cell.completion = { [unowned self] (status, error) in
                DispatchQueue.main.async {
                    self.tableviewIndexPath = indexPath
                    
                    self.tableview.isUserInteractionEnabled = false
                    if status ?? false {
                        var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                        let maxMarks =  assessment?.assMaxScore ?? 0
                        result = result + Int(truncating: maxMarks)
                        self.selectedCategory?.catResultMark = result
                        assessment?.catResultMark = result as NSNumber
                        self.resultScoreLabel.text = String(result)
                        assessment?.assStatus = 1
                        
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,schAssmentId: Int(scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                        }
                    } else {
                        var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                        let maxMarks = assessment?.assMaxScore ?? 0
                        result = result - Int(truncating: maxMarks)
                        self.selectedCategory?.catResultMark = result
                        assessment?.catResultMark = result as NSNumber
                        self.resultScoreLabel.text = String(result)
                        assessment?.assStatus = 0
                        
                        if(CoreDataHandlerPE().someEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,schAssmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                    }
                    
                    if(self.selectedCategory?.catName == refridFreezerNitro){
                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                    }
                    else{
                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                    }
                    self.refreshTableView()
                    self.chechForLastCategory()
                    self.tableview.isUserInteractionEnabled = true
                }
                
            }
            
            cell.commentCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                self.refreshArray()
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
                vc.textOfTextView = assessment?.note ?? ""
                vc.infoText = assessment?.informationText ?? ""
                
                vc.commentCompleted = {[unowned self] ( note) in
                    if note == "" {
                        let image = UIImage(named: peCommentImg)
                        cell.btn_Comment.setImage(image, for: .normal)
                        
                    } else {
                        let image = UIImage(named: peCommentSelectedStr)
                        cell.btn_Comment.setImage(image, for: .normal)
                        
                    }
                    assessment?.note = note
                    self.updateNoteAssessmentInProgressPE(assessment : assessment!)
                }
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            return cell
        }
        return UITableViewCell() as! RefrigatorQuesCell
    }
    
    // MARK: - Setup PE Question Tableview Cell
    func setupPEQuestionTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PEQuestionTableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PEQuestionTableViewCell.identifier) as? PEQuestionTableViewCell{
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
            
            if indexPath.row < catArrayForTableIs.count {
                if let assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress {
                    var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                    cell.assessmentProgress = assessment
                    let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
                    if regionID != 3
                    {
                        if((assessment?.isAllowNA) ?? false ){
                            cell.btn_NA.isHidden = false
                            cell.lbl_NA.isHidden = false
                            let assID =  assessment?.assID ?? 0
                            if((assessment?.isNA) ?? false){
                                cell.btn_NA.isSelected = true
                                
                                if  assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3 && assessment?.qSeqNo == 12 {
                                    cell.txtQCCount.text =  "NA"
                                    cell.txtQCCount.isUserInteractionEnabled = true
                                }
                                if  assessment?.rollOut == "Y" && assessment?.catName == "Miscellaneous" && assessment?.qSeqNo == 1{
                                    cell.txtQCCount.text =  "NA"
                                    cell.txtQCCount.isUserInteractionEnabled = true
                                }
                            }
                            else{
                                if  assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3 && assessment?.qSeqNo == 12{
                                    cell.txtQCCount.text =  ""
                                    cell.txtQCCount.isUserInteractionEnabled = true
                                }
                                if   assessment?.rollOut == "Y" && assessment?.catName == "Miscellaneous" && assessment?.qSeqNo == 1{
                                    cell.txtQCCount.text =  ""
                                    cell.txtQCCount.isUserInteractionEnabled = true
                                }
                                cell.btn_NA.isSelected = false
                            }
                        }
                        
                        else{
                            cell.btn_NA.isHidden = true
                            cell.lbl_NA.isHidden = true
                        }
                    }
                    else{
                        cell.btn_NA.isHidden = true
                        cell.lbl_NA.isHidden = true
                        
                    }
                    
                    if((assessment?.isNA) ?? false){
                        cell.btn_NA.isSelected = true
                        cell.contentView.alpha = 0.3
                        cell.btnImageCount.isUserInteractionEnabled = false
                        cell.noteBtn.isUserInteractionEnabled = false
                        cell.cameraBTn.isUserInteractionEnabled = false
                        cell.assessmentLbl.isUserInteractionEnabled = false
                        cell.switchBtn.isUserInteractionEnabled = false
                        cell.btnInfo.isUserInteractionEnabled = false
                        cell.txtQCCount.isUserInteractionEnabled = false
                    }
                    else{
                        cell.btn_NA.isSelected = false
                        cell.contentView.alpha = 1
                        cell.btnImageCount.isUserInteractionEnabled = true
                        cell.noteBtn.isUserInteractionEnabled = true
                        cell.cameraBTn.isUserInteractionEnabled = true
                        cell.assessmentLbl.isUserInteractionEnabled = true
                        cell.switchBtn.isUserInteractionEnabled = true
                        cell.btnInfo.isUserInteractionEnabled = true
                        cell.txtQCCount.isUserInteractionEnabled = true
                    }
                    
                    let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
                    let boldMark1 =  "("
                    let boldMark2 =  ")"
                    let mrk = String(maxMarksIs)
                    _ = assessment?.assDetail1 ?? ""
                    let assID =  assessment?.assID ?? 0
                    if assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3 && assessment?.qSeqNo == 12
                    {
                        cell.txtQCCount.text =  assessment?.qcCount ?? ""
                        cell.showQcCountextField()
                        if(assessment?.isNA ?? false){
                            cell.txtQCCount.text =  "NA"
                            cell.showQcCountextField()
                            self.peNewAssessment.qcCount  = "NA"
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        }else{
                            cell.txtQCCount.text =  assessment?.qcCount ?? ""
                            cell.showQcCountextField()
                            self.peNewAssessment.qcCount  = cell.txtQCCount.text
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        }
                    }
                    else if assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3 && assessment?.qSeqNo == 12
                    {
                        cell.txtQCCount.text =  assessment?.qcCount ?? ""
                        cell.showQcCountextField()
                        if(assessment?.isNA ?? false){
                            cell.txtQCCount.text =  "NA"
                            cell.showQcCountextField()
                            self.peNewAssessment.qcCount  = "NA"
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        }else{
                            cell.txtQCCount.text =  assessment?.qcCount ?? ""
                            cell.showQcCountextField()
                            self.peNewAssessment.qcCount  = cell.txtQCCount.text
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                            
                        }
                    }
                    else if assessment?.rollOut == "Y" && assessment?.catName == "Miscellaneous" && assessment?.qSeqNo == 1
                    {
                        cell.txtQCCount.text =  assessment?.ampmValue ?? ""
                        cell.showAMPMValuetextField()
                        if(assessment?.isNA ?? false){
                            cell.txtQCCount.text =  "NA"
                            cell.showAMPMValuetextField()
                            self.peNewAssessment.ampmValue  = "NA"
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        }else{
                            cell.txtQCCount.text =  assessment?.ampmValue ?? ""
                            cell.showAMPMValuetextField()
                            self.peNewAssessment.ampmValue  = cell.txtQCCount.text
                            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        }
                    } else if assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3 && assessment?.qSeqNo == 1
                    {
                        cell.txtPersonName.text =  assessment?.personName ?? ""
                        cell.txtFrequency.text =  assessment?.frequency ?? ""
                        cell.showFrequencytextField()
                    }
                    else if assessment?.rollOut == "Y" && assessment?.sequenceNoo == 5 && assessment?.qSeqNo == 5
                    {
                        cell.txtQCCount.text = assessment?.ppmValue ?? ""
                        cell.showPPMField()
                        self.peNewAssessment.ppmValue  =  cell.txtQCCount.text
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                    }
                    else
                    {
                        cell.hideAMPMValuetextField()
                        cell.hideQcCountextField()
                        cell.hidePPMfield()
                    }
                    
                    cell.setGraddientAndLayerQcCountextFieldView()
                    cell.assessmentLbl.text =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
                    
                    cell.assessmentLbl.attributedText =   cell.assessmentLbl.text?.withBoldText(text: boldMark1 + mrk + boldMark2)
                    if(indexPath.row % 2 == 0) {
                        cell.contentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
                    } else {
                        cell.contentView.backgroundColor =   UIColor.white
                    }
                    if assessment?.camera == 1 {
                        cell.cameraBTn.isEnabled = true
                        cell.cameraBTn.alpha = 1
                    } else {
                        cell.cameraBTn.isEnabled = false
                        cell.cameraBTn.alpha = 0.3
                    }
                    
                    if assessment?.assStatus == 1 {
//                        cell.switchClicked(status: true)
                        cell.switchBtn.setOn(true, animated: false)
                    } else {
//                        cell.switchClicked(status: false)
                        cell.switchBtn.setOn(false, animated: false)
                    }
                    let imageCount = assessment?.images as? [Int]
                    let cnt = imageCount?.count
                    let ttle = String(cnt ?? 0)
                    cell.btnImageCount.setTitle(ttle,for: .normal)
                    if ttle == "0"{
                        cell.btnImageCount.isHidden = true
                    } else {
                        cell.btnImageCount.isHidden = false
                    }
                    let image1 = UIImage(named: peCommentImg)
                    let image2 = UIImage(named: peCommentSelectedStr)
                    if assessment?.note == "" || assessment?.note == nil {
                        cell.noteBtn.setImage(image1, for: .normal)
                    } else {
                        cell.noteBtn.setImage(image2, for: .normal)
                    }
                    cell.completion = { [unowned self] (status, error) in
                        DispatchQueue.main.async {
                            self.tableviewIndexPath = indexPath
                            
                            self.tableview.isUserInteractionEnabled = false
                            if status ?? false {
                                
                                var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                let maxMarks =  assessment?.assMaxScore ?? 0
                                result = result + Int(truncating: maxMarks)
                                self.selectedCategory?.catResultMark = result
                                assessment?.catResultMark = result as NSNumber
                                self.resultScoreLabel.text = String(result)
                                assessment?.assStatus = 1
                                
                                self.updateAssessmentInDb(assessment : assessment!)
                                //  }
                                
                            }
                            
                            else {
                                
                                var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                let maxMarks = assessment?.assMaxScore ?? 0
                                result = result - Int(truncating: maxMarks)
                                self.selectedCategory?.catResultMark = result
                                assessment?.catResultMark = result as NSNumber
                                self.resultScoreLabel.text = String(result)
                                assessment?.assStatus = 0
                                self.updateAssessmentInDb(assessment : assessment!)
                            }
                            updateScore(isAllNA: false)
                            
                            //                    if(selectedCategory?.catName == refridFreezerNitro){
                            //                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(77)
                            //                    }
                            //                    else{
                            //                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                            //                    }
                            
                            self.chechForLastCategory()
                            self.tableview.isUserInteractionEnabled = true
                        }
                        
                    }
                    cell.imagesCompletion  = {[unowned self] ( error) in
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "GroupImagesPEViewController") as! GroupImagesPEViewController
                        self.refreshArray()
                        assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                        vc.imagesArray = assessment?.images as? [Int] ?? [0]
                        self.navigationController?.present(vc, animated: false, completion: nil)
                    }
                    
                    cell.btnNA  = {[unowned self] () in
                        
                        if(cell.btn_NA.isSelected){
                            
                            if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13){
                                for i in 0..<3{
                                    let newAssment = catArrayForTableIs[indexPath.row + i] as? PE_AssessmentInProgress
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  newAssment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    if(newAssment?.assStatus != 1){
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        if(newAssment?.isNA ?? false){
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        newAssment?.isNA = false
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    else{
                                        
                                        if(newAssment?.isNA ?? false){
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                            result = result + Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        self.resultScoreLabel.text = String(result)
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        newAssment?.isNA = false
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    
                                    
                                }
                                self.refreshTableView()
                            }
                            if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 1){
                                for i in 0..<2{
                                    let newAssment = catArrayForTableIs[indexPath.row + i] as? PE_AssessmentInProgress
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  newAssment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    if(newAssment?.assStatus != 1){
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        if(newAssment?.isNA ?? false){
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        newAssment?.isNA = false
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    else{
                                        
                                        if(newAssment?.isNA ?? false){
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                            result = result + Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        self.resultScoreLabel.text = String(result)
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        newAssment?.isNA = false
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    
                                    
                                }
                                self.refreshTableView()
                            }
                            else{
                                // new Code
                                
                                DispatchQueue.main.async {
                                    self.tableviewIndexPath = indexPath
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  assessment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    if(assessment?.assStatus != 1){
                                        
                                        
                                        if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13)  {
                                            self.totalScoreLabel.text = String(totalresult)
                                            
                                        } else {
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                            self.totalScoreLabel.text = String(totalresult)
                                            
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        assessment?.catMaxMark = totalresult as NSNumber
                                        assessment?.isNA = false
                                        self.selectedCategory?.catResultMark = result
                                        assessment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        // Cell View Changes
                                        cell.btn_NA.isSelected = false
                                        cell.contentView.alpha = 1
                                        cell.btnImageCount.isUserInteractionEnabled = true
                                        cell.noteBtn.isUserInteractionEnabled = true
                                        cell.cameraBTn.isUserInteractionEnabled = true
                                        cell.assessmentLbl.isUserInteractionEnabled = true
                                        cell.switchBtn.isUserInteractionEnabled = true
                                        cell.btnInfo.isUserInteractionEnabled = true
                                        cell.txtQCCount.isUserInteractionEnabled = true
                                        //
                                        self.update_isNA(assessment: assessment!)
                                        self.updateAssessmentInDb(assessment : assessment!)
                                        
                                    }
                                    else{
                                        
                                        if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13) {
                                            self.totalScoreLabel.text = String(totalresult)
                                            self.resultScoreLabel.text = String(result)
                                            
                                        } else {
                                            result = result + Int(truncating: maxMarks)
                                            totalresult = totalresult + Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        assessment?.catMaxMark = totalresult as NSNumber
                                        self.selectedCategory?.catResultMark = result
                                        assessment?.catResultMark = result as NSNumber
                                        assessment?.isNA = false
                                        // Cell View Changes
                                        cell.btn_NA.isSelected = false
                                        cell.contentView.alpha = 1
                                        cell.btnImageCount.isUserInteractionEnabled = true
                                        cell.noteBtn.isUserInteractionEnabled = true
                                        cell.cameraBTn.isUserInteractionEnabled = true
                                        cell.assessmentLbl.isUserInteractionEnabled = true
                                        cell.switchBtn.isUserInteractionEnabled = true
                                        cell.btnInfo.isUserInteractionEnabled = true
                                        cell.txtQCCount.isUserInteractionEnabled = true
                                        self.update_isNA(assessment: assessment!)
                                        self.updateAssessmentInDb(assessment : assessment!)
                                        DispatchQueue.main.async {
                                            self.totalScoreLabel.text = String(totalresult)
                                            self.resultScoreLabel.text = String(result)
                                        }
                                        
                                    }
                                    
                                    if assessment?.sequenceNoo == 3 && assessment?.rollOut == "Y"{
                                        cell.txtQCCount.text =  ""
                                        cell.txtQCCount.isUserInteractionEnabled = true
                                        self.peNewAssessment.qcCount  = ""
                                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                                    }
                                    if  assessment?.catName == "Miscellaneous" && assessment?.rollOut == "Y" {
                                        cell.txtQCCount.text =  ""
                                        cell.txtQCCount.isUserInteractionEnabled = true
                                        self.peNewAssessment.ampmValue  = ""
                                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                                    }
                                    
                                    
                                    if(selectedCategory?.catName == refridFreezerNitro){
                                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                                    }
                                    else{
                                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                                    }
                                    
                                    updateScore(isAllNA: false)
                                    self.chechForLastCategory()
                                }
                            }
                        }
                        else{
                            
                            if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13){
                                for i in 0..<3{
                                    let newAssment = catArrayForTableIs[indexPath.row + i] as? PE_AssessmentInProgress
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  newAssment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    if(newAssment?.assStatus != 1){
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        if(newAssment?.isNA == false){
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                        }
                                        
                                        //                          self.selectedCategory?.catResultMark = result
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        newAssment?.isNA = true
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    else{
                                        
                                        if(newAssment?.isNA == false){
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                            result = result - Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        self.resultScoreLabel.text = String(result)
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        newAssment?.isNA = true
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    
                                }
                                self.refreshTableView()
                            }
                            if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 1){
                                for i in 0..<2{
                                    let newAssment = catArrayForTableIs[indexPath.row + i] as? PE_AssessmentInProgress
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  newAssment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    if(newAssment?.assStatus != 1){
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        if(newAssment?.isNA == false){
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                        }
                                        
                                        //                          self.selectedCategory?.catResultMark = result
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        newAssment?.isNA = true
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    else{
                                        
                                        if(newAssment?.isNA == false){
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                            result = result - Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        newAssment?.catMaxMark = totalresult as NSNumber
                                        self.totalScoreLabel.text = String(totalresult)
                                        self.resultScoreLabel.text = String(result)
                                        self.selectedCategory?.catResultMark = result
                                        newAssment?.catResultMark = result as NSNumber
                                        newAssment?.isNA = true
                                        self.update_isNA(assessment: newAssment!)
                                        self.updateAssessmentInDb(assessment : newAssment!)
                                    }
                                    
                                }
                                self.refreshTableView()
                            }
                            else{
                                //                        newCode
                                DispatchQueue.main.async {
                                    self.tableviewIndexPath = indexPath
                                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                                    let maxMarks =  assessment?.assMaxScore ?? 0
                                    var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                                    
                                    if(assessment?.assStatus != 1){
                                        
                                        
                                        
                                        if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13) {
                                            self.totalScoreLabel.text = String(totalresult)
                                        } else {
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                            self.totalScoreLabel.text = String(totalresult)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        assessment?.catMaxMark = totalresult as NSNumber
                                        self.selectedCategory?.catResultMark = result
                                        assessment?.catResultMark = result as NSNumber
                                        self.resultScoreLabel.text = String(result)
                                        assessment?.isNA = true
                                        // Cell viewChanges
                                        cell.btn_NA.isSelected = true
                                        cell.contentView.alpha = 0.3
                                        cell.btnImageCount.isUserInteractionEnabled = false
                                        cell.noteBtn.isUserInteractionEnabled = false
                                        cell.cameraBTn.isUserInteractionEnabled = false
                                        cell.assessmentLbl.isUserInteractionEnabled = false
                                        cell.switchBtn.isUserInteractionEnabled = false
                                        cell.btnInfo.isUserInteractionEnabled = false
                                        cell.txtQCCount.isUserInteractionEnabled = false
                                        //
                                        self.update_isNA(assessment: assessment!)
                                        self.updateAssessmentInDb(assessment : assessment!)
                                        
                                    }
                                    else{
                                        
                                        
                                        if(assessment?.sequenceNoo == 2 && assessment?.qSeqNo == 13) {
                                            self.totalScoreLabel.text = String(totalresult)
                                            self.resultScoreLabel.text = String(result)
                                            
                                        } else {
                                            result = result - Int(truncating: maxMarks)
                                            totalresult = totalresult - Int(truncating: maxMarks)
                                        }
                                        self.selectedCategory?.catMaxMark = totalresult
                                        assessment?.catMaxMark = totalresult as NSNumber
                                        self.selectedCategory?.catResultMark = result
                                        assessment?.catResultMark = result as NSNumber
                                        assessment?.isNA = true
                                        // Cell viewChanges
                                        cell.btn_NA.isSelected = true
                                        cell.contentView.alpha = 0.3
                                        cell.btnImageCount.isUserInteractionEnabled = false
                                        cell.noteBtn.isUserInteractionEnabled = false
                                        cell.cameraBTn.isUserInteractionEnabled = false
                                        cell.assessmentLbl.isUserInteractionEnabled = false
                                        cell.switchBtn.isUserInteractionEnabled = false
                                        cell.btnInfo.isUserInteractionEnabled = false
                                        cell.txtQCCount.isUserInteractionEnabled = false
                                        //
                                        self.update_isNA(assessment: assessment!)
                                        self.updateAssessmentInDb(assessment : assessment!)
                                        DispatchQueue.main.async {
                                            self.totalScoreLabel.text = String(totalresult)
                                            self.resultScoreLabel.text = String(result)
                                        }
                                        
                                    }
                                    if assessment?.sequenceNoo == 3 && assessment?.rollOut == "Y"{
                                        cell.txtQCCount.text =  "NA"
                                        cell.txtQCCount.isUserInteractionEnabled = false
                                        self.peNewAssessment.qcCount  = "NA"
                                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                                    }
                                    if  assessment?.catName == "Miscellaneous" && assessment?.rollOut == "Y"{
                                        cell.txtQCCount.text =  "NA"
                                        cell.txtQCCount.isUserInteractionEnabled = false
                                        self.peNewAssessment.ampmValue  = "NA"
                                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                                    }
                                    
                                    if(selectedCategory?.catName == refridFreezerNitro){
                                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                                        var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                                        
                                    }
                                    else{
                                        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                                        var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                                        
                                    }
                                    updateScore(isAllNA: false)
                                    self.chechForLastCategory()
                                    
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    cell.commentCompletion = {[unowned self] ( error) in
                        self.tableviewIndexPath = indexPath
                        self.refreshArray()
                        assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
                        vc.textOfTextView = assessment?.note ?? ""
                        vc.infoText = assessment?.informationText ?? ""
                        
                        vc.commentCompleted = {[unowned self] ( note) in
                            if note == "" {
                                let image = UIImage(named: peCommentImg)
                                cell.noteBtn.setImage(image, for: .normal)
                                
                            } else {
                                let image = UIImage(named: peCommentSelectedStr)
                                cell.noteBtn.setImage(image, for: .normal)
                                
                            }
                            assessment?.note = note
                            self.updateNoteAssessmentInProgressPE(assessment : assessment!)
                        }
                        self.navigationController?.present(vc, animated: false, completion: nil)
                    }
                    cell.txtQCCountCompletion = {[unowned self] ( txt) in
                        
                        self.peNewAssessment.qcCount  = txt ?? ""
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        
                    }
                    
                    cell.txtPPMCompletion = {[unowned self] ( txt) in
                        
                        self.peNewAssessment.ppmValue  = txt ?? ""
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        /*
                         textValue  = Int(txt ?? "")
                         cell.ppmText = txt
                         
                         if self.peNewAssessment.isHandMix == true
                         {
                         if textValue ?? 0 <= 4499 || textValue ?? 0 >= 5500
                         {
                         if cell.ppmText == ""
                         {
                         
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         var maxresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                         
                         if result != maxresult
                         {
                         if assessment?.assStatus == 0
                         {
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         else
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         }
                         
                         return
                         }
                         
                         else
                         {
                         
                         if Constants.isPPmValueChanged ==  true
                         {
                         return
                         }
                         
                         if textValue ?? 0 > 4499 && textValue ?? 0 < 5501 {
                         Constants.isPPmValueChanged = false
                         return
                         }
                         
                         Constants.isPPmValueChanged = true
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result - Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         self.updateAssessmentInDb(assessment : assessment!)
                         
                         
                         
                         }
                         }
                         else
                         {
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         var maxresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                         
                         if assessment?.assStatus == 1 && Constants.switchCount == 0
                         {
                         
                         if result != maxresult
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         
                         return
                         
                         }
                         else
                         {
                         if textValue ?? 0 >= 4499 && textValue ?? 0  <= 5500 && Constants.isPPmValueChanged == true
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         return
                         }
                         else
                         {
                         
                         return
                         }
                         
                         
                         
                         
                         }
                         
                         }
                         
                         }
                         
                         else
                         {
                         
                         if textValue ?? 0 <= 2249 || textValue ?? 0 >= 2750
                         {
                         if cell.ppmText == ""
                         {
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         var maxresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                         
                         if result != maxresult
                         {
                         if assessment?.assStatus == 0
                         {
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         else
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         }
                         return
                         }
                         
                         else
                         {
                         if Constants.isPPmValueChanged ==  true
                         {
                         return
                         }
                         
                         if textValue ?? 0 > 2249 && textValue ?? 0 < 2751 {
                         Constants.isPPmValueChanged = false
                         return
                         }
                         
                         Constants.isPPmValueChanged = true
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result - Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         self.updateAssessmentInDb(assessment : assessment!)
                         
                         
                         }
                         }
                         else
                         {
                         var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                         var maxresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
                         
                         if assessment?.assStatus == 1 && Constants.switchCount == 0
                         {
                         if result != maxresult
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         }
                         return
                         }
                         else
                         {
                         if textValue ?? 0 >= 2249 && textValue ?? 0  <= 2750 && Constants.isPPmValueChanged == true
                         {
                         let maxMarks = assessment?.assMaxScore ?? 0
                         result = result + Int(truncating: maxMarks)
                         self.selectedCategory?.catResultMark = result
                         assessment?.catResultMark = result as NSNumber
                         self.resultScoreLabel.text = String(result)
                         Constants.isPPmValueChanged = false
                         self.updateAssessmentInDb(assessment : assessment!)
                         return
                         }
                         else
                         {
                         return
                         }
                         }
                         }
                         }
                         */
                    }
                    
                    cell.txtAMPMCompletion = {[unowned self] ( txt) in
                        
                        self.peNewAssessment.ampmValue  = txt ?? ""
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                    }
                    cell.txtNamePersonCompletion = {[unowned self] ( txt) in
                        
                        self.peNewAssessment.personName  = txt ?? ""
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                    }
                    cell.btnFrequencyClickedCompletion = {[unowned self] ( error) in
                        
                        var vManufacutrerNameArray = NSArray()
                        var vManufacutrerDetailsArray = NSArray()
                        vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Frequency")
                        vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "frequencyName")  as? NSArray ?? NSArray()
                        if  vManufacutrerNameArray.count > 0 {
                            self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.txtFrequency.frame.width, kAnchor: cell.txtFrequency, yheight: cell.txtFrequency.bounds.height) { [unowned self] selectedVal, index  in
                                cell.txtFrequency.text = selectedVal
                                self.peNewAssessment.frequency = selectedVal
                                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                            }
                            self.dropHiddenAndShow()
                        }
                        
                        
                    }
                    
                    cell.cameraCompletion = {[unowned self] ( error) in
                        self.tableviewIndexPath = indexPath
                        var assessment = self.catArrayForTableIs[self.tableviewIndexPath.row] as? PE_AssessmentInProgress
                        
                        let images = CoreDataHandlerPE().getImagecountOfQuestion(assessment:assessment ?? PE_AssessmentInProgress())
                        if images < 5 {
                            self.takePhoto(cell.cameraBTn)
                        } else {
                            self.showAlertForNoCamera()
                        }
                    }
                    cell.infoCompletion = {[unowned self] ( error) in
                        self.tableviewIndexPath = indexPath
                        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "InfoPEViewController") as! InfoPEViewController
                        let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
                        let boldMark1 =  "("
                        let boldMark2 =  ") "
                        let mrk = String(maxMarksIs)
                        let str  =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
                        vc.questionDescriptionIs = str
                        vc.imageDataBase64 = assessment?.informationImage ?? ""
                        vc.infotextIs = assessment?.informationText ?? ""
                        self.navigationController?.present(vc, animated: false, completion: nil)
                    }
                    return cell
                } else {
                    print("Error: Could not cast object at index \(indexPath.row) to PE_AssessmentInProgress")
                }
            } else {
                print("Error: indexPath.row (\(indexPath.row)) out of bounds for array with count \(catArrayForTableIs.count)")
            }
        }
        return UITableViewCell() as! PEQuestionTableViewCell
    }
    
    // MARK: - DROP DOWN HIDDEN AND SHOW
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    func doneButtonTappedWithDate(string: String, objDate: Date) {
        changedDate?(string)
        
    }
    
    func doneButtonTapped(string:String){
        certificateData[tableviewIndexPath.row].certificateDate = string
        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id ?? 0)
        tableview.reloadData()
    }
    
    // MARK: - Datepicker popup */
    
    func showDatePicker(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        datePickerPopupViewController.canSelectPreviousDate = false
        navigationController?.present(datePickerPopupViewController, animated: false, completion: nil)
        
    }
    
    // MARK: - Table View Delegates
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro){
            //   refrigtorProbeArray.removeAll()
            let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
            refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
            
            //            if refrigtorProbeArray.count > 13 {
            //                //Prince Mehra added this
            //                refrigtorProbeArray = Array(refrigtorProbeArray.prefix(13))
            //              }
            //
            let array =   CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
            if (section == 0)  {
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RefrigatorTempProbeCell.identifier)as! RefrigatorTempProbeCell
                footerView.topValueTxtFld.delegate = self
                footerView.middleValueTxtFld.delegate = self
                footerView.bottomValueTxtFld.delegate = self
                footerView.mainTempUnit.isHidden = false
                footerView.topValueTxtFld.text = ""
                footerView.middleValueTxtFld.text = ""
                footerView.bottomValueTxtFld.text = ""
                
                if(btnNA.isSelected && self.selctedNACategoryArray.contains(78)){
                    footerView.contentView.alpha = 0.3
                }
                else{
                    footerView.contentView.alpha = 1
                }
                
                var assessment = array[2] as? PE_AssessmentInProgress
                footerView.endEditing(true)
                var unitValue = ""
                var valueText = ""
                if(self.refrigtorProbeArray.count > 0){
                    for i in 2...4{
                        var ar = array[i] as? PE_AssessmentInProgress
                        for j in 0..<self.refrigtorProbeArray.count-1{
                            if(ar?.assID == self.refrigtorProbeArray[j].id){
                                if(i == 2){
                                    footerView.topTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.topValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                    
                                }
                                if(i == 3){
                                    footerView.middleTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.middleValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                }
                                if(i == 4) {
                                    footerView.bottomTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.bottomValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
                
                if(refrigtorProbeArray.count > 0){
                    for i in refrigtorProbeArray{
                        let refri = i as! PE_Refrigators
                        if(refri.unit != ""){
                            footerView.main_UnitTextFld.text = refri.unit ?? ""
                        }
                        
                    }
                    
                }
                footerView.mainTempUnitCompletion = { sender,txtfld ,textLabel in
                    var unitArray = ["Celsius","Fahrenheit"]
                    if  unitArray.count > 0 {
                        self.dropDownVIewNew(arrayData: unitArray ?? [], kWidth: (sender ?? UIButton()).frame.width, kAnchor: sender ?? UIButton(), yheight: (sender ?? UIButton()).bounds.height) {  selectedVal,index  in
                            txtfld.text = selectedVal
                            CoreDataHandlerPE().updateUnitRefrigatorInDB(Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0, unit: txtfld.text ?? "" )
                            self.refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
                            self.tableview.reloadData()
                        }
                        self.dropHiddenAndShow()
                    }
                }
                
                footerView.unitCompletion = { sender,txtfld ,textLabel in
                    var unitArray = ["Fahrenheit","Celsius"]
                    if  unitArray.count > 0 {
                        self.dropDownVIewNew(arrayData: unitArray ?? [], kWidth: (sender ?? UIButton()).frame.width, kAnchor: sender ?? UIButton(), yheight: (sender ?? UIButton()).bounds.height) {  selectedVal,index  in
                            txtfld.text = selectedVal
                            
                            if(textLabel == "Top"){
                                assessment = array[2] as? PE_AssessmentInProgress
                                valueText = footerView.topValueTxtFld.text ?? ""
                                
                                
                            }
                            else if (textLabel == "Middle"){
                                assessment = array[3] as? PE_AssessmentInProgress
                                valueText = footerView.middleValueTxtFld.text ?? ""
                                
                            }
                            else{
                                assessment = array[4] as? PE_AssessmentInProgress
                                valueText = footerView.bottomValueTxtFld.text ?? ""
                                
                            }
                            let assID = assessment?.assID
                            if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                                CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                                self.tableview.reloadData()
                                
                            }
                            else{
                                CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,schAssmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                                
                                self.tableview.reloadData()
                            }
                            
                        }
                        self.dropHiddenAndShow()
                    }
                }
                
                footerView.valueCompletion = { value , textLabel in
                    if(textLabel == "Top"){
                        unitValue =  footerView.topTxtFld.text ?? ""
                        assessment = array[2] as? PE_AssessmentInProgress
                        
                        
                    }
                    else if (textLabel == "Middle"){
                        unitValue =  footerView.middleTxtFld.text ?? ""
                        assessment = array[3] as? PE_AssessmentInProgress
                        
                    }
                    else{
                        unitValue =  footerView.bottomTxtFld.text ?? ""
                        assessment = array[4] as? PE_AssessmentInProgress
                        
                    }
                    let assID = assessment?.assID
                    if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                        CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "0.0") ?? 0.0 ,catID: self.selectedCategory?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        self.tableview.reloadData()
                        
                    }
                    else{
                        CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "0.0") ?? 0.0,catID: self.selectedCategory?.catID as! NSNumber,isCheck: true,isNA: false ,schAssmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                        self.tableview.reloadData()
                    }
                    
                }
                footerView.setGraddientAndLayerQcCountextFieldView()
                return footerView
            }
            else if ( section == 1){
                
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RefrigatorTempProbeCell.identifier)as! RefrigatorTempProbeCell
                footerView.mainTempUnit.isHidden = true
                footerView.topValueTxtFld.delegate = self
                footerView.middleValueTxtFld.delegate = self
                footerView.bottomValueTxtFld.delegate = self
                footerView.topValueTxtFld.text = ""
                footerView.middleValueTxtFld.text = ""
                footerView.bottomValueTxtFld.text = ""
                
                if(btnNA.isSelected && self.selctedNACategoryArray.contains(78)){
                    footerView.contentView.alpha = 0.3
                }
                else{
                    footerView.contentView.alpha = 1
                }
                
                var assessment = array[7] as? PE_AssessmentInProgress
                var unitValue = ""
                var valueText = ""
                
                
                if(self.refrigtorProbeArray.count > 0){
                    for i in 7...9{
                        var ar = array[i] as? PE_AssessmentInProgress
                        
                        for j in 0..<self.refrigtorProbeArray.count{
                            if(ar?.assID == self.refrigtorProbeArray[j].id){
                                if(i == 7){
                                    footerView.topTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.topValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                }
                                if(i == 8){
                                    footerView.middleTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.middleValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                }
                                if(i == 9){
                                    footerView.bottomTxtFld.text = self.refrigtorProbeArray[j].unit ?? ""
                                    if(self.refrigtorProbeArray[j].value != 0.0){
                                        footerView.bottomValueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                                    }
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
                footerView.unitCompletion = { sender,txtfld ,textLabel in
                    var unitArray = ["Fahrenheit","Celsius"]
                    if  unitArray.count > 0 {
                        self.dropDownVIewNew(arrayData: unitArray ?? [], kWidth: (sender ?? UIButton()).frame.width, kAnchor: sender ?? UIButton(), yheight: (sender ?? UIButton()).bounds.height) {  selectedVal,index  in
                            txtfld.text = selectedVal
                            
                            if(textLabel == "Top"){
                                assessment = array[7] as? PE_AssessmentInProgress
                                valueText = footerView.topValueTxtFld.text ?? ""
                            }
                            if (textLabel == "Middle"){
                                assessment = array[8] as? PE_AssessmentInProgress
                                valueText = footerView.middleValueTxtFld.text ?? ""
                            }
                            if(textLabel == "Bottom"){
                                assessment = array[9] as? PE_AssessmentInProgress
                                valueText = footerView.bottomValueTxtFld.text ?? ""
                            }
                            let assID = assessment?.assID
                            if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                                CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            }
                            else{
                                CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,schAssmentId: Int(self.scheduledAssessment?.serverAssessmentId ?? "0") ?? 0)
                                
                            }
                            
                        }
                        self.dropHiddenAndShow()
                    }
                }
                
                footerView.valueCompletion = { value , textLabel in
                    if(textLabel == "Top"){
                        unitValue =  footerView.topTxtFld.text ?? ""
                        assessment = array[7] as? PE_AssessmentInProgress
                    }
                    else if (textLabel == "Middle"){
                        unitValue =  footerView.middleTxtFld.text ?? ""
                        assessment = array[8] as? PE_AssessmentInProgress
                    }
                    else{
                        unitValue =  footerView.bottomTxtFld.text ?? ""
                        assessment = array[9] as? PE_AssessmentInProgress
                    }
                    let assID = assessment?.assID
                    if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                        CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "") ?? 0.0 ,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                    }
                    else{
                        CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "") ?? 0.0 ,catID: 1,isCheck: true,isNA: false,schAssmentId: self.scheduledAssessment?.assID ?? 0 )
                    }
                    
                }
                footerView.setGraddientAndLayerQcCountextFieldView()
                return footerView
            }
            else{
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FrezerFooterViewCell.identifier)as! FrezerFooterViewCell
                if(btnNA.isSelected && self.selctedNACategoryArray.contains(78)){
                    footerView.contentView.alpha = 0.3
                }
                else{
                    footerView.contentView.alpha = 1
                    
                }
                //                let re_note = UserDefaults.standard.value(forKey: "re_note") as? String ?? ""
                //                let asIDUD =  UserDefaults.standard.value(forKey: "assIID") as? String ?? ""
                //                if(re_note != "" && re_note != nil && self.scheduledAssessment?.serverAssessmentId == asIDUD ){
                //                    footerView.textFieldView.text = re_note
                //                }
                footerView.textFieldView.text  = self.peNewAssessment.refrigeratorNote ?? ""
                footerView.noteCompletion = { textLabel in
                    self.peNewAssessment.refrigeratorNote = textLabel ?? ""
                    UserDefaults.standard.set(textLabel ?? "", forKey:"re_note")
                    UserDefaults.standard.set(self.scheduledAssessment?.serverAssessmentId ,forKey:"assIID")
                    CoreDataHandlerPE().updateRefrigetorInProgressTable(text: textLabel ?? "")
                }
                footerView.setGraddientAndLayerQcCountextFieldView()
                return footerView
            }
        }
        
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro){
            if ((  section == 0) || ( section == 1)) {
                return 350
            }
            else{
                return 200
            }
        }
        return 0
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if selectedCategory?.sequenceNoo == 12 && section == 0 {
            
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PlateInfoHeader" ) as! PlateInfoHeader
            if(btnNA.isSelected ){
                headerView.contentView.alpha = 0.3
                
            }
            else{
                headerView.contentView.alpha = 1.0
            }
            
            
            
            return headerView
            
        }
        if selectedCategory?.sequenceNoo == 11 && section == 2 && selectedCategory?.catName == refridFreezerNitro{
            let array =   CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SetFrezzerPointCell" ) as! SetFrezzerPointCell
            if(btnNA.isSelected && self.selctedNACategoryArray.contains(78)){
                headerView.contentView.alpha = 0.3
            }
            else{
                headerView.contentView.alpha = 1.0
            }
            headerView.setGraddientAndLayerQcCountextFieldView()
            var assessment = array[2] as? PE_AssessmentInProgress
            var unitValue = ""
            var valueText = ""
            
            if(self.refrigtorProbeArray.count > 0){
                
                var ar = array[10] as? PE_AssessmentInProgress
                
                for j in 0..<self.refrigtorProbeArray.count{
                    if(ar?.assID == self.refrigtorProbeArray[j].id){
                        headerView.unitTxtFld.text  = self.refrigtorProbeArray[j].unit ?? ""
                        if(self.refrigtorProbeArray[j].value != 0.0){
                            headerView.valueTxtFld.text = "\(self.refrigtorProbeArray[j].value ?? 0.0)"
                        }
                        
                    }
                    
                }
                unitValue = headerView.unitTxtFld.text ?? ""
                valueText = headerView.valueTxtFld.text ?? ""
            }
            
            
            headerView.unitCompletion = { sender,txtfld ,textLabel in
                var unitArray = ["Fahrenheit","Celsius"]
                if  unitArray.count > 0 {
                    self.dropDownVIewNew(arrayData: unitArray ?? [], kWidth: (sender ?? UIButton()).frame.width, kAnchor: sender ?? UIButton(), yheight: (sender ?? UIButton()).bounds.height) {  selectedVal,index  in
                        txtfld.text = selectedVal
                        unitValue = txtfld.text ?? ""
                        if(textLabel == "Frezzer"){
                            assessment = array[10] as? PE_AssessmentInProgress
                            valueText = headerView.valueTxtFld.text ?? ""
                        }
                        
                        let assID = assessment?.assID
                        if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                            CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0 ,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true ,schAssmentId: self.scheduledAssessment?.assID ?? 0 )
                        }
                        
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            headerView.valueCompletion = { value , textLabel in
                if(textLabel == "Frezzer"){
                    unitValue =  headerView.unitTxtFld.text ?? ""
                    assessment = array[10] as? PE_AssessmentInProgress
                }
                valueText = value?.text ?? ""
                let assID = assessment?.assID
                if(CoreDataHandlerPE().someEntityExists(id: assID as! Int)){
                    CoreDataHandlerPE().updateRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value:  Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0 ,catID: 1,isCheck: true,isNA: false,schAssmentId: self.scheduledAssessment?.assID ?? 0)
                }
                
            }
            
            
            
            return headerView
            
        }
        if catArrayForTableIs.count > 0 {
            if checkForTraning(){
                
                if selectedCategory?.sequenceNoo == 1 {
                    if section == 1 {
                        
                        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewHeaderFooterView" ) as! PETableviewHeaderFooterView
                        headerView.lblTitle.text = "Vaccine Mixer Observer"
                        headerView.lblSubTitle.text = "Crew Information"
                        
                        headerView.addCompletion = {[unowned self] ( error) in
                            
                            let lastItem = self.certificateData.last
                            
                            if (lastItem == nil)
                            {
                                let certificateData =  PECertificateData(id:0,name:"",date:"",isCertExpired: false,isReCert: false,vacOperatorId: 0, signatureImg: "", fsrSign: "")
                                let id = self.saveVMixerInPEModule(peCertificateData: certificateData)
                                certificateData.id = id
                                
                                
                                self.certificateData.append(certificateData)
                            }
                            else  if (lastItem?.name != "")
                            {
                                let certificateData =  PECertificateData(id:0,name:"",date:"",isCertExpired: false,isReCert: false,vacOperatorId: 0, signatureImg: "", fsrSign: "")
                                let id = self.saveVMixerInPEModule(peCertificateData: certificateData)
                                certificateData.id = id
                                
                                
                                self.certificateData.append(certificateData)
                            }
                            
                            else
                            {
                                self.showtoast(message: "Please add Vaccine Mixer & Certification Date")
                            }
                            
                            
                            
                            DispatchQueue.main.async {
                                UIView.performWithoutAnimation {
                                    self.tableview.reloadData()
                                    //                                    self.tableview.beginUpdates()
                                    //                                    self.tableview.insertRows(at: [IndexPath(row: self.certificateData.count-1, section: 1)], with: .none)
                                    //                                    self.tableview.endUpdates()
                                    //self.tableview.reloadSections([1], with: .none)
                                    //                                    self.scrollToBottom(section:1)
                                }
                            }
                            //self.refreshTableviewAndScrolToBottom(section: section)
                            
                        }
                        headerView.minusCompletion = {[unowned self] ( error) in
                            
                            if self.certificateData.count > 0 {
                                let certificateData =  PECertificateData(id:0,name:"",date:"",isCertExpired: false,isReCert: false,vacOperatorId: 0, signatureImg: "", fsrSign: "")
                                let lastItem = self.certificateData.last
                                
                                self.delVMixerInPEModule(peCertificateData: lastItem ?? certificateData)
                                self.certificateData.removeLast()
                            }
                            if self.certificateData.count > 1 {
                                //                                DispatchQueue.main.async {
                                //                                    UIView.performWithoutAnimation {
                                //                                        self.tableview.reloadData()
                                //                                    }
                                //                                }
                                UIView.performWithoutAnimation {
                                    self.tableview.reloadData()
                                    self.scrollToBottom(section:1)
                                }
                                //self.refreshTableviewAndScrolToBottom(section: section)
                            } else {
                                UIView.performWithoutAnimation {
                                    self.tableview.reloadData()
                                }
                            }
                        }
                        
                        return headerView
                    }  else if section == 2 {
                        return self.setPEInovojectHeaderFooterView(tableView, section: section)
                    }
                    else if section == 3 {
                        return self.setPEHeaderDayOfAge(tableView, section: section)
                    }
                    else if section == 4 {
                        return self.setPEHeaderDayOfAgeS(tableView, section: section)
                    }
                } else if selectedCategory?.sequenceNoo == 3 {
                    if section == 1 {
                        return self.setCustomerVaccineView(tableView,section: section)
                        
                    } else {
                        return UIView()
                    }
                }
                
            } else {
                if selectedCategory?.sequenceNoo == 3 {
                    if section == 1 {
                        return self.setCustomerVaccineView(tableView,section: section)
                    } else {
                        return UIView()
                    }
                }
                if section == 1 {
                    return self.setPEInovojectHeaderFooterView(tableView, section: section)
                } else if section == 2 {
                    return self.setPEHeaderDayOfAge(tableView, section: section)
                } else if section == 3 {
                    return self.setPEHeaderDayOfAgeS(tableView, section: section)
                }
                
                else {
                    return UIView()
                }
            }
        }
        
        
        
        return UIView()
    }
    
    // MARK: - Vaccine dropdown */
    
    func setCustomerVaccineView(_ tableView: UITableView , section:Int) -> PETableviewConsumerQualityHeader {
        if selectedCategory?.sequenceNoo == 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewConsumerQualityHeader" ) as! PETableviewConsumerQualityHeader
            
            headerView.nameMicro.text =  self.peNewAssessment.micro
            headerView.nameResidue.text =  self.peNewAssessment.residue
            
            
            headerView.microComplete =
            {[unowned self] ( error) in
                
                self.peNewAssessment.micro  = error ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            headerView.residueComplete =
            {[unowned self] ( error) in
                
                self.peNewAssessment.residue  = error ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            return headerView as! PETableviewConsumerQualityHeader
        }
        return UIView() as! PETableviewConsumerQualityHeader
    }
    
    // MARK: - Inovoject dosage calculator */
    
    func updateDosageInvojectData(section:Int)  {
        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
        if c == 0 {
            self.showtoast(message: incompleteDataStr)
            return
        }
        for obj in self.inovojectData{
            let a = Double(obj.ampulePerBag ?? "0") ?? 0
            let b = Double(obj.ampuleSize ?? "0") ?? 0
            if  b != 0 {
                let x = a * b
                let y = c/0.05
                let z = x/y
                
                let r  = Rational(approximating: z)
                let n = String(r.numerator)
                let d = String(r.denominator)
                
                if regionID == 3 {
                    obj.dosage = n + "/" + d
                }
                else
                {
                    obj.dosage  = "\(Double(round(1000 * z) / 1000))"
                }
                
                
            }
            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
            UIView.performWithoutAnimation {
                self.tableview.reloadSections([section], with: .none)
            }
        }
    }
    // MARK: - Set Inovo Header
    func setPEInovojectHeaderFooterView(_ tableView: UITableView , section:Int) -> PEInovojectHeaderFooterView {
        if selectedCategory?.sequenceNoo == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEInovojectHeaderFooterView" ) as! PEInovojectHeaderFooterView
            headerView.lblTitle.text = "In Ovo"
            headerView.txtCSize.text = peNewAssessment.iCS
            headerView.txtDType.text = peNewAssessment.iDT
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsText
            headerView.switchCompletion = {[unowned self] ( status) in
                
            }
            
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                self.peNewAssessment.hatcheryAntibioticsText = txtAntiBioTic
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromInvo: true)
            }
            headerView.addCompletion =
            {[unowned self] ( error) in
                
                let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
                let id = self.saveInovojectInPEModule(inovojectData: inVoData)
                inVoData.id = id
                if self.inovojectData.count > 0{
                    let inovoObj = self.inovojectData[self.inovojectData.count - 1]
                    
                    inVoData.vaccineMan = inovoObj.vaccineMan
                    inVoData.invoProgramName = inovoObj.invoProgramName
                    inVoData.invoHatchAntibiotic = inovoObj.invoHatchAntibiotic
                    inVoData.invoHatchAntibioticText = inovoObj.invoHatchAntibioticText
                    inVoData.doaDilManOther = inovoObj.doaDilManOther
                    inVoData.bagSizeType = inovoObj.bagSizeType
                    
                }
                self.inovojectData.append(inVoData)
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                    self.scrollToBottom(section:2)
                }
            }
            headerView.minusCompletion = {[unowned self] (error) in
                if self.inovojectData.count > 0 {
                    let lastItem = self.inovojectData.last
                    self.deleteInovojectInPEModule(id: lastItem!.id ?? 0)
                    self.inovojectData.removeLast()
                }
                if self.inovojectData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                        self.scrollToBottom(section:2)
                    }
                }  else {
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgName")  as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgId")  as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.iDT = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                    }
                    self.dropHiddenAndShow()
                }
                
                
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeIDArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BagSizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size")  as? NSArray ?? NSArray()
                bagSizeIDArray = bagSizeDetailsArray.value(forKey: "id")  as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    self.dropDownVIewNew(arrayData: bagSizeArray as? [String] ?? [String](), kWidth: headerView.txtCSize.frame.width, kAnchor: headerView.txtCSize, yheight: headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.iCS = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        self.updateDosageInvojectData(section: section)
                    }
                    self.dropHiddenAndShow()
                }
            }
//            headerView.hideDropdown(hide: true)
            return headerView
        } else {
            return UIView() as! PEInovojectHeaderFooterView
        }
    }
    
    
    // MARK: - Setup Day of Age Header
    func setPEHeaderDayOfAge(_ tableView: UITableView , section:Int) -> PEHeaderDayOfAge {
        if selectedCategory?.sequenceNoo == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
            //headerView.hideDropdown(hide: false)
            headerView.lblTitle.text = "Day of Age Spray Application"
            headerView.txtCSize.text = peNewAssessment.dDT
            headerView.txtDType.text = peNewAssessment.dCS
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsDoaText
            let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
            
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            headerView.setGraddientAndLayerAntibioticTextView()
            if peNewAssessment.hatcheryAntibioticsDoa == 1 {
                headerView.switchHatchery.setOn(true, animated: false)
                headerView.showAntiBioticTextView()
            } else {
                headerView.switchHatchery.setOn(false, animated: false)
                
                headerView.hideAntiBioticTextView()
            }
            headerView.switchCompletion = {[unowned self] ( status) in
                if status ?? false {
                    self.peNewAssessment.hatcheryAntibioticsDoa = 1
                } else {
                    self.peNewAssessment.hatcheryAntibioticsDoa = 0
                }
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoa: true)
            }
            
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                self.peNewAssessment.hatcheryAntibioticsDoaText = txtAntiBioTic
                PEInfoDAO.sharedInstance.saveData(userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "" , isExtendedPE: infoObj?.isExtendedPE ?? false, assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "", date: nil, subcutaneousTxt: infoObj?.subcutaneousAntibioticTxt, dayOfAgeTxt: txtAntiBioTic)
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoa: true)
            }
            
            
            headerView.addCompletion = {[unowned self] ( error) in
                let c = self.peNewAssessment.dDT ?? ""
                
                if c == "" {
                    self.showtoast(message: "Please enter container size and type")
                    return
                }
                
                if headerView.switchHatchery.isOn && headerView.txtAntiBiotic.text == ""{
                    self.showtoast(message: "Please enter antibiotic")
                    return
                }
                
                let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
                let id = self.saveDOAInPEModule(inovojectData: inVoData)
                inVoData.id = id
                self.dayOfAgeData.append(inVoData)
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                    self.scrollToBottom(section:3)
                }
            }
            headerView.minusCompletion = {[unowned self] ( error) in
                
                if self.dayOfAgeData.count > 0 {
                    let lastItem = self.dayOfAgeData.last
                    self.deleteDOAInPEModule(id: lastItem!.id ?? 0)
                    self.dayOfAgeData.removeLast()
                }
                if self.dayOfAgeData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                        self.scrollToBottom(section:3)
                    }
                }  else {
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOADiluentType")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "diluentName")  as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.dCS = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                        
                    }
                    self.dropHiddenAndShow()
                }
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOASizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size")  as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.dDT = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            return headerView
        } else {
            return UIView() as! PEHeaderDayOfAge
        }
    }
    
    
    func setPEHeaderDayOfAgeS(_ tableView: UITableView , section:Int) -> PEHeaderDayOfAge {
        if selectedCategory?.sequenceNoo == 1  {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
            headerView.lblTitle.text = "Day of Age Subcutaneous"
            headerView.txtCSize.text = peNewAssessment.dDDT
            headerView.txtDType.text = peNewAssessment.dDCS
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsDoaSText
            let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: scheduledAssessment?.serverAssessmentId ?? "")
            
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            headerView.setGraddientAndLayerAntibioticTextView()
            if peNewAssessment.hatcheryAntibioticsDoaS == 1 {
                headerView.switchHatchery.setOn(true, animated: false)
                headerView.showAntiBioticTextView()
            } else {
                headerView.switchHatchery.setOn(false, animated: false)
                headerView.hideAntiBioticTextView()
            }
            headerView.switchCompletion = {[unowned self] ( status) in
                if status ?? false {
                    self.peNewAssessment.hatcheryAntibioticsDoaS = 1
                } else {
                    self.peNewAssessment.hatcheryAntibioticsDoaS = 0
                }
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true)
            }
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                PEInfoDAO.sharedInstance.saveData(userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "" , isExtendedPE: infoObj?.isExtendedPE ?? false, assessmentId: self.scheduledAssessment?.serverAssessmentId ?? "", date: nil, subcutaneousTxt: txtAntiBioTic, dayOfAgeTxt: infoObj?.dayOfAgeTxtAntibiotic)
                self.peNewAssessment.hatcheryAntibioticsDoaSText = txtAntiBioTic
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true)
            }
            headerView.addCompletion = {[unowned self] ( error) in
                let c = self.peNewAssessment.dDDT ?? ""
                if c == "" {
                    self.showtoast(message: "Please enter container size and type")
                    return
                }
                if headerView.switchHatchery.isOn && headerView.txtAntiBiotic.text == ""{
                    self.showtoast(message: "Please enter antibiotic")
                    return
                }
                let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
                let id = self.saveDOAInPEModule(inovojectData: inVoData,fromDoaS:true)
                inVoData.id = id
                self.dayOfAgeSData.append(inVoData)
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                    self.scrollToBottom(section:4)
                }
            }
            headerView.minusCompletion = {[unowned self] ( error) in
                if self.dayOfAgeSData.count > 0 {
                    let lastItem = self.dayOfAgeSData.last
                    self.deleteDOAInPEModule(id: lastItem!.id ?? 0,fromDoaS : true)
                    self.dayOfAgeSData.removeLast()
                }
                if self.dayOfAgeSData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                        self.scrollToBottom(section:4)
                    }
                }  else {
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOADiluentType")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "diluentName")  as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.dDCS = selectedVal
                        self.updateDosageDayOfAgeDataS(section: section)
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true)
                    }
                    self.dropHiddenAndShow()
                }
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOASizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size")  as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.dDDT = selectedVal
                        self.updateDosageDayOfAgeDataS(section: section)
                        
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true)
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            return headerView
        } else {
            return UIView() as! PEHeaderDayOfAge
        }
    }
    
    // MARK: - Day of age subcutaneous dosage calculator */
    
    func updateDosageDayOfAgeDataS(section:Int)  {
        
        if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
            self.ml = 0.0
        }  else if self.peNewAssessment.dDDT?.lowercased().contains(oneGallonStr) ?? false {
            self.ml = 3785.41
        }else if self.peNewAssessment.dDDT?.lowercased().contains(twoGallonStr) ?? false {
            self.ml = 7570.82
        } else if self.peNewAssessment.dDDT?.lowercased().contains(fiveGallonStr) ?? false {
            self.ml = 18927.05
        } else if self.peNewAssessment.dDDT?.lowercased().contains(twoLitre) ?? false {
            self.ml = 2000.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains(liter24) ?? false {
            self.ml = 2400.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains(liter28) ?? false {  self.ml = 2800.00
        }
        else if self.peNewAssessment.dDDT?.lowercased().contains(mil200) ?? false {
            self.ml = 200.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil300) ?? false {
            self.ml = 300.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil400) ?? false {
            self.ml = 400.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains(mil500) ?? false {
            self.ml = 500.00
        }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
            self.ml = 800.00
        }
        
        
        let c = self.ml
        if c == 0.0 {
            // obj.dosage = ""
        }
        var count = 0
        for obj in self.dayOfAgeSData{
            let a = Double(obj.ampulePerBag ?? "0") ?? 0
            let b = Double(obj.ampuleSize ?? "0") ?? 0
            if a != 0 && b != 0 && c != 0{
                let x = a * b
                let y = c/0.2
                let z = x/y
                
                let r  = Rational(approximating: z)
                let n = String(r.numerator)
                let d = String(r.denominator)
                if regionID == 3 {
                    obj.dosage = n + "/" + d
                    self.dayOfAgeSData[count].dosage = n + "/" + d
                }
                else
                {
                    obj.dosage = "\(Double(round(1000 * z) / 1000))"
                    self.dayOfAgeSData[count].dosage = "\(Double(round(1000 * z) / 1000))"
                }
                CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
            }else{
                obj.dosage = ""
                self.dayOfAgeSData[count].dosage = ""
                CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
            }
            
            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true)
            UIView.performWithoutAnimation {
                self.tableview.reloadData()
            }
            count += 1
        }
    }
    
    func refreshTableviewAndScrolToBottom(section:Int){
        
        UIView.performWithoutAnimation {
            self.tableview.reloadSections([section], with: .none)
            scrollToBottom(section:section)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == refridFreezerNitro){
            if(section == 2) {
                return 100
            }
        }
        else{
            if section > 0 {
                
                if selectedCategory?.sequenceNoo == 1 {
                    return 95.0
                }
                if selectedCategory?.sequenceNoo == 3 {
                    return 95.0
                }
            }else {
                if   selectedCategory?.sequenceNoo == 12{
                    if section == 0 {
                        return 70.0
                    }else{
                        return 0.0
                    }
                }
            }
            return 0.0
        }
        return 0.0
    }
    
    func scrollToBottom(section:Int){
        
        var indexPathOfTab = IndexPath(row: 0, section: 0)
        DispatchQueue.main.async {
            if self.checkForTraning(){
                if section == 1 {
                    indexPathOfTab = IndexPath(
                        row: self.certificateData.count - 1 ,
                        section:1)
                }
                if section == 2 {
                    indexPathOfTab = IndexPath(
                        row: self.inovojectData.count - 1 ,
                        section:2)
                }
                if section == 3 {
                    indexPathOfTab = IndexPath(
                        row: self.dayOfAgeData.count - 1 ,
                        section:3)
                }
                if section == 4 {
                    indexPathOfTab = IndexPath(
                        row: self.dayOfAgeSData.count - 1 ,
                        section:4)
                }
            } else {
                if section == 1 {
                    indexPathOfTab = IndexPath(
                        row: self.inovojectData.count - 1 ,
                        section:1)
                }
                if section == 2 {
                    indexPathOfTab = IndexPath(
                        row: self.dayOfAgeData.count - 1 ,
                        section:2)
                }
                if section == 3 {
                    indexPathOfTab = IndexPath(
                        row: self.dayOfAgeSData.count - 1 ,
                        section:3)
                }
            }
            self.tableview.scrollToRow(at: indexPathOfTab, at: .none, animated: false)
        }
    }
    // MARK: - Update Assessment
    func updateAssessmentInDb(assessment:PE_AssessmentInProgress) {
        CoreDataHandlerPE().updateCatDetailsForStatus(assessment:assessment)
    }
    // MARK: - Update Assessment Note
    func updateNoteAssessmentInProgressPE(assessment:PE_AssessmentInProgress){
        CoreDataHandlerPE().updateNoteAssessmentInProgress(assessment:assessment)
    }
    // MARK: - Update Assessment is N/A
    func update_isNA(assessment:PE_AssessmentInProgress){
        CoreDataHandlerPE().update_ISNA_AssessmentInProgress(assessment:assessment)
    }
    // MARK: - Update Assessment Marks
    func updateCatMaxMarksAssessmentInProgressPE(assessment:PE_AssessmentInProgress){
        CoreDataHandlerPE().updateCatMaxMarks(assessment: assessment)
    }
    // MARK: - Update Assessment Category
    func updateCategoryInDb(assessment:PENewAssessment) {
        CoreDataHandlerPE().updateCategortIsSelcted(assessment:assessment)
    }
}

// MARK: - UICollectionViewDelegate

extension PEAssesmentFinalize : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return catArrayForCollectionIs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewIDPE", for: indexPath as IndexPath) as! PECategoryCell
        //cell.isSelected = false..
        
        //        let NewcountryId1 = UserDefaults.standard.integer(forKey: "nonUScountryId")
        //        if NewcountryId1 != 40
        //        {
        //            let catArrayForIsss = CoreDataHandlerPE().fetchCustomerWithCatID(refriCategory?.sequenceNo as? NSNumber ?? 0)
        //            for i in catArrayForIsss{
        //                  let refri =   i as! PE_AssessmentInProgress
        //                    if(!CoreDataHandlerPE().someEntityExists(id: refri.assID as! Int)){
        //                        CoreDataHandlerPE().saveRefrigatorInDB(refri.assID as! NSNumber,  labelText:  "", rollOut: "Y", unit:  "" , value: 0.0,catID: refri.catID as! NSNumber,isCheck: true,isNA: false,schAssmentId: Int(refri.serverAssessmentId ?? "0") ?? 0)
        //                    }
        //
        //                }
        //        }
        
        let category = catArrayForCollectionIs[indexPath.row]
        cell.imageview.image = UIImage(named: "tabUnselect.pdf") ?? UIImage()
        if  let isSelected = selectedCategory?.catISSelected {
            if selectedCategory?.sequenceNo == category.sequenceNo{
                if isSelected == 1{
                    cell.imageview.image =  UIImage(named: "tabSelect.pdf") ?? UIImage()
                }
            }
        }
        cell.categoryLabel.text = category.catName ?? ""
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 3{
            return CGSize(width: 171, height: 68)
        } else if indexPath.row == 4{
            return CGSize(width: 151, height: 68)
        }else{
            return CGSize(width: 161, height: 68)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        finishingAssessment = false
        forInovo = false
        //tableview.reloadData()
        if indexPath.row != 0{
            let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! PECategoryCell
            cell.imageview.image = UIImage(named: "tabUnselect.pdf") ?? UIImage()
        }
        self.tableviewIndexPath = IndexPath(row: 0, section: 0)
        
        if checkNoteForEveryQuestion(){
            selectedCategory?.catISSelected = 0
            self.updateCategoryInDb(assessment:selectedCategory!)
            
            if catArrayForCollectionIs.count > indexPath.row{
                _ = catArrayForCollectionIs[indexPath.row]
                collectionviewIndexPath = indexPath
                selectedCategory = catArrayForCollectionIs[indexPath.row]
                selectedCategory?.catISSelected = 1
                self.updateCategoryInDb(assessment:selectedCategory!)
                chechForLastCategory()
                let totalMark = selectedCategory?.catMaxMark ?? 0
                totalScoreLabel.text = String(totalMark)
                resultScoreLabel.text = String(0)
                catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                if(selectedCategory?.catName == refridFreezerNitro){
                    lblextenderMicro.isHidden = true
                    extendedMicroSwitch.isHidden = true
                    extendedMicroSwitch.isUserInteractionEnabled = false
                    for i in catArrayForTableIs{
                        
                        let refri =   i as! PE_AssessmentInProgress
                        let array = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
                        
                        
                        if array.count < 13
                        {
                            CoreDataHandlerPE().saveRefrigatorInDB(refri.assID as! NSNumber,  labelText:  "", rollOut: "Y", unit:  "Celsius" , value: 0.0,catID: refri.catID as! NSNumber,isCheck: false,isNA: false,schAssmentId: Int(refri.serverAssessmentId ?? "0") ?? 0)
                        }
                        
                        
                    }
                    if(catArrayForTableIs.count > 0){
                        let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
                        refrigtorProbeArray = CoreDataHandlerPE().getREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
                    }
                    
                    
                    
                }
                if(selectedCategory?.catName == extendedMicStr){
                    selectedCategory?.sequenceNoo = 12
                    lblextenderMicro.isHidden = false
                    extendedMicroSwitch.isHidden = false
                    extendedMicroSwitch.isUserInteractionEnabled = true
                }
                
                else{
                    lblextenderMicro.isHidden = true
                    extendedMicroSwitch.isHidden = true
                    extendedMicroSwitch.isUserInteractionEnabled = false
                    catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as? NSNumber ?? 0)
                    if(checkCategoryisNA()){
                        self.btnNA.isSelected = true
                        updateScore(isAllNA: true )
                    }
                    else{
                        self.btnNA.isSelected = false
                        updateScore(isAllNA: false)
                    }
                    
                    
                }
                tableview.reloadData()
                
                
                let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
                if regionID != 3
                {
                    if(selectedCategory?.catName == refridFreezerNitro){
                        showHideNA(sequenceNoo: selectedCategory?.sequenceNoo ?? 0,catName: selectedCategory?.catName ?? "")
                    }
                    else{
                        //                        showHideNA(sequenceNo:selectedCategory?.sequenceNo ?? 0,catName: selectedCategory?.catName ?? "")
                        showHideNA(sequenceNoo: selectedCategory?.sequenceNoo ?? 0, catName: selectedCategory?.catName ?? "")
                    }
                }
                
                
                refreshTableView()
            }
        }
        
    }
    // MARK: - Show Hide NA option in Question
    func showHideNA(sequenceNoo:Int,catName:String){
        
        if( sequenceNoo == 11 && catName == refridFreezerNitro ){
            lbl_NA.isHidden = true
            btnNA.isHidden = true
            scoreParentView.isHidden = true
        }
        else if(sequenceNoo == 1 || sequenceNoo == 2){
            lbl_NA.isHidden = true
            btnNA.isHidden = true
            scoreParentView.isHidden = false
        }
        else{
            lbl_NA.isHidden = false
            btnNA.isHidden = false
            scoreParentView.isHidden = false
        }
    }
    
    func updateCategoriesInShared(){
        print(appDelegate.testFuntion())
    }
    
    // MARK: - Update Assessment Binding notes for every questions */
    
    func checkNoteForEveryQuestion() -> Bool{
        self.refreshArray()
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            
            if assessment?.assStatus == 0 && assessment?.isNA == false {
                if assessment?.note?.count ?? 0 < 1 {
                    
                    if regionID == 3 {
                        self.showAlertForNoNote()
                        return false
                    }
                    else
                    {
                        return true
                    }
                }
            }
        }
        
        if finishingAssessment == true
        {
            catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(2)
            
            for  obj in catArrayForTableIs {
                let assessment = obj as? PE_AssessmentInProgress
                
                if assessment?.assStatus == 1 && assessment?.assID == 5  {
                    if assessment?.note?.count ?? 0 < 1 {
                        
                        if strings.contains(pleaseEnterMessage)
                        {
                            strings = strings.filter { $0 != pleaseEnterMessage }
                        }
                        if regionID == 3 {
                            strings.append(pleaseEnterMessage)
                        }
                        else{
                            return true
                        }
                    }
                    else
                    {
                        if regionID == 3 {
                            
                            if strings.contains(pleaseEnterMessage)
                            {
                                strings = strings.filter { $0 != pleaseEnterMessage }
                            }
                        }
                    }
                }
                else if assessment?.assStatus == 1 && assessment?.assID == 9 {
                    if assessment?.note?.count ?? 0 < 1 {
                        
                        if strings.contains(pleaseEnterMessageVac)
                        {
                            strings = strings.filter { $0 != pleaseEnterMessageVac }
                        }
                        if regionID == 3 {
                            strings.append(pleaseEnterMessageVac)
                        }else
                        {
                            return true
                        }
                    }
                    else
                    {
                        if regionID == 3 {
                            if strings.contains(pleaseEnterMessageVac)
                            {
                                strings = strings.filter { $0 != pleaseEnterMessageVac }
                            }
                        }
                    }
                }
            }
        }
        
        return true
    }
    // MARK: - Check Category is NA
    func checkCategoryisNA() -> Bool{
        self.refreshArray()
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            if assessment?.isNA == false{
                return false
            }
        }
        return true
    }
    // MARK: - Set All question to NA
    func setAllQuestiontToNA() {
        self.refreshArray()
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            assessment?.isNA = true
            self.selectedCategory?.catResultMark = 0
            assessment?.catResultMark = 0
            self.selectedCategory?.catMaxMark = 0
            assessment?.catMaxMark = 0
            self.updateAssessmentInDb(assessment : assessment!)
            update_isNA(assessment: assessment!)
        }
        self.refreshTableView()
    }
    // MARK: - Set All question to Non NA
    func setAllQuestiontTo_Non_NA() {
        self.refreshArray()
        
        var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
        var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            let maxMarks =  assessment?.assMaxScore ?? 0
            
            if(assessment?.assStatus == 1){
                result = result + Int(truncating: maxMarks)
                self.selectedCategory?.catResultMark = result
                assessment?.catResultMark = result as NSNumber
                self.resultScoreLabel.text = String(result)
            }
            
            totalresult = totalresult + Int(truncating: maxMarks)
            self.selectedCategory?.catMaxMark = totalresult
            assessment?.catMaxMark = totalresult as NSNumber
            self.totalScoreLabel.text = String(totalresult)
            assessment?.isNA = false
            update_isNA(assessment: assessment!)
            self.updateAssessmentInDb(assessment : assessment!)
        }
        
        self.refreshTableView()
    }
    
    // MARK: - Validate last category
    
    func chechForLastCategory(){
        var  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(serverAssessmentId: scheduledAssessment?.serverAssessmentId ?? "")
        
        var catArrayForCollectionIsAre : [PENewAssessment] = []
        var carColIdArray : [Int] = []
        for cat in peNewAssessmentArray {
            if !carColIdArray.contains(cat.sequenceNo ?? 0){
                carColIdArray.append(cat.sequenceNo ?? 0)
                catArrayForCollectionIsAre.append(cat)
            }
        }
        
        let count = catArrayForCollectionIs.count - 1
        if count > 0 {
            if let cat = catArrayForCollectionIs[count] as? PENewAssessment {
                if cat.sequenceNo == selectedCategory?.sequenceNo{
                    buttonSaveAsDraft.isHidden = false
                    buttonFinishAssessment.isHidden = false
                    buttonSaveAsDraftInitial.isHidden = true
                    bckButton.isHidden = true
                    
                } else {
                    buttonSaveAsDraftInitial.isHidden = false
                    buttonSaveAsDraft.isHidden = true
                    buttonFinishAssessment.isHidden = true
                    bckButton.isHidden = false
                }
            }
            else {
                buttonSaveAsDraftInitial.isHidden = false
                bckButton.isHidden = false
                buttonSaveAsDraft.isHidden = true
                buttonFinishAssessment.isHidden = true
                
            }
            
            if let cat = catArrayForCollectionIs[0] as? PENewAssessment{
                if cat.sequenceNo == selectedCategory?.sequenceNo{
                    bckButton.isHidden = false
                }  else {
                    bckButton.isHidden = true
                }
            } else {
                bckButton.isHidden = true
            }
        }
    }
    
    // MARK: - Field validation check
    
    func validateForm() -> Bool {
        
        if showExtendedPE{
            var hasEmptyPlateType = true
            for question in sanitationQuesArr{
                if question.plateTypeId == nil || question.plateTypeId == "" || question.plateTypeId == "0"{
                    hasEmptyPlateType =  hasEmptyPlateType && false
                }
                if question.questionDescription == "Control (Non Exposed) Plate"{
                    if question.bacteriaCount ?? 0 >= Int32(5){
                        if question.userComments == "" || question.userComments == nil{
                            showAlertForCommentMandatory()
                        }
                    }else if question.blueGreenMoldCount ?? 0 >= Int32(1){
                        if question.userComments == "" || question.userComments == nil{
                            showAlertForCommentMandatory()
                        }
                    }
                }
            }
            if !hasEmptyPlateType{
                showAlertForAddingPlateType()
                return false
            }
        }
        if !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
            if self.inovojectData.count > 0 {
                //self.inovojectData[indexPath.row].name
                let countt = self.inovojectData[0].name?.count ?? 0
                let programName = self.inovojectData[0].invoProgramName
                if countt < 1 {
                    if regionID == 3
                    {
                        showAlertForNoValid()
                    }
                    else
                    {
                        showAlertForNoValid()
                        return false
                    }
                    
                }
                else
                {
                    if regionID == 3
                    {
                        if strings.contains(peaseEnterVacDet)
                        {
                            strings = strings.filter { $0 != peaseEnterVacDet }
                        }
                    }
                }
                
                for inovo in self.inovojectData{
                    let switchAnti = inovo.invoHatchAntibiotic
                    let txtAnti = inovo.invoHatchAntibioticText
                    if (switchAnti == 1) && (txtAnti == ""){
                        if regionID == 3
                        {
                            showAlertForAntibiotic()
                        }
                        else
                        {
                            showAlertForAntibiotic()
                            return false
                        }
                        
                    }
                }
                if (self.peNewAssessment.hatcheryAntibioticsDoa == 1) && (self.peNewAssessment.hatcheryAntibioticsDoaText == ""){
                    if regionID == 3
                    {
                        showAlertForAntibiotic()
                    }
                    else
                    {
                        showAlertForAntibiotic()
                        return false
                    }
                    
                }
                if (self.peNewAssessment.hatcheryAntibioticsDoaS == 1) && (self.peNewAssessment.hatcheryAntibioticsDoaSText == ""){
                    if regionID == 3
                    {
                        showAlertForAntibiotic()
                    }
                    else
                    {
                        showAlertForAntibiotic()
                        return false
                    }
                }
                
            } else {
                
                if regionID == 3
                {
                    showAlertForNoValid()
                }
                else
                {
                    showAlertForNoValid()
                    return false
                }
                
            }
        }
        if self.checkForTraning() && !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
            if self.certificateData.count > 0 {
                let countt = self.certificateData[0].name?.count ?? 0
                // Condition added so that user cannot submit the session with blank vacine mixture certificate detail ....
                
                if self.certificateData.last?.name == "" && self.certificateData.last?.certificateDate == ""
                {
                    showAlertForVaccineMixture()
                    return false
                }
                
                if countt < 1{
                    showAlertForNoValidTraining()
                    return false
                }
            } else {
                showAlertForNoValidTrainingName()
            }
        }
        if self.checkForTraning()  {
            let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
            if regionID == 3
            {
                if(self.peNewAssessment.frequency?.count ?? 0 < 1){
                    
                    if regionID == 3
                    {
                        if(self.peNewAssessment.evaluationID == 1){
                            showAlertForNoFrequency()
                        }
                    }
                    else
                    {
                        if(self.peNewAssessment.evaluationID == 1){
                            showAlertForNoFrequency()
                            return false
                        }
                    }
                    
                }
                else
                {
                    if strings.contains(pleaseEnterFrequencyDet)
                    {
                        strings = strings.filter { $0 != pleaseEnterFrequencyDet }
                    }
                }
                if(self.peNewAssessment.personName?.count ?? 0 < 1){
                    if regionID == 3
                    {
                        if(self.peNewAssessment.evaluationID == 1){
                            showAlertForNoPersonName()
                        }
                    }
                    else
                    {
                        if(self.peNewAssessment.evaluationID == 1){
                            showAlertForNoPersonName()
                            return false
                        }
                    }
                }
                else
                {
                    if strings.contains(pleaseEnterPersonName)
                    {
                        strings = strings.filter { $0 != pleaseEnterPersonName }
                    }
                }
            }
            if self.peNewAssessment.qcCount?.count ?? 0 < 1 {
                
                if regionID == 3
                {
                    if(self.peNewAssessment.evaluationID == 1){
                        showAlertForNoQCCount()
                    }
                }
                else
                {
                    if(self.peNewAssessment.evaluationID == 1){
                        showAlertForNoQCCount()
                        return false
                    }
                }
                
            }
            else if self.peNewAssessment.qcCount?.count ?? 0 > 1 {
                
                if regionID == 3
                {
                    if strings.contains(pleaseEnterQCount)
                    {
                        strings = strings.filter { $0 != pleaseEnterQCount }
                    }
                }
            }
            if regionID == 3
            {
                if self.peNewAssessment.ppmValue?.count ?? 0 < 1 {
                    if(self.peNewAssessment.evaluationID == 1){
                        showAlertForPPMValue()
                    }
                }
                else{
                    if(self.peNewAssessment.evaluationID == 1){
                        if strings.contains(pleaseEnterPPM)
                        {
                            strings = strings.filter { $0 != pleaseEnterPPM }
                        }
                    }
                }
            }
            
            if self.peNewAssessment.ampmValue?.count ?? 0 < 1 {
                
                if regionID == 3
                {
                    showAlertForNoAMPMValue()
                }
                else {
                    showAlertForNoAMPMValue()
                    return false
                }
                
            }else
            {
                if strings.contains(pleaseEnterAMPM)
                {
                    strings = strings.filter { $0 != pleaseEnterAMPM }
                }
            }
        }
        
        let formatter = CodeHelper.sharedInstance.getDateFormatterObj("")
        if(regionID == 3){
            formatter.dateFormat = "MM/dd/yyyy"
            //            formatter.calendar = Calendar(identifier: .gregorian)
            //            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }else{
            formatter.dateFormat = ddmmyyStr
            //            formatter.calendar = Calendar(identifier: .gregorian)
            //            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }
        
        let firstDate = formatter.date(from:peNewAssessment.evaluationDate ?? "")
        let secondDate = Date()
        if firstDate?.compare(secondDate) == .orderedDescending{
            
            displayAlertMessage(userMessage: "Submission of  future assessments is restricted")
            SanitationEmbrexQuestionMasterDAO.sharedInstance.deleteExisitingData(entityName: "PE_ExtendedPEAssessmentQuestions", predicate: NSPredicate(format: "userId = %@ AND assessmentId = %@", UserContext.sharedInstance.userDetailsObj?.userId ?? "", peNewAssessment.serverAssessmentId ?? ""))
            return false
            
        }
        
        return true
    }
}

// MARK: - Alert messages display

extension PEAssesmentFinalize{
    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Restricted Operation.", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func showAlertForAddingPlateType(){
        let errorMSg = "Please select all plate types in Sanitation And Embrex Evaluation Tab"
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        _ = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForNoValid(){
        
        if regionID == 3
        {
            if strings.contains(peaseEnterVacDet)
            {
                strings = strings.filter { $0 != peaseEnterVacDet }
            }
            strings.append(peaseEnterVacDet)
        }
        
        else
        {
            let errorMSg = "Please enter vaccine details in the Vaccine Preparation Tab."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func showAlertForProgramName(){
        // Change
        if regionID == 3
        {
            if strings.contains(pleaseEnterProgramName)
            {
                strings = strings.filter { $0 != pleaseEnterProgramName }
            }
            strings.append(pleaseEnterProgramName)
        }
        else{
            let errorMSg = "Please enter program name in the Vaccine Preparation Tab."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertForCommentMandatory(){
        let errorMSg = "Please enter the Comment before submitting the assessment in Extended Microbial."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForAntibiotic(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterAntibiotic)
            {
                strings = strings.filter { $0 != pleaseEnterAntibiotic }
            }
            strings.append(pleaseEnterAntibiotic)
        }
        else
        {
            let errorMSg = "Please enter Antibiotic in the Vaccine Preparation Tab."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertForNoValidTraining(){
        
        let errorMSg = "Please enter the certification details before submitting the assessment in Extended Microbial."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForVaccineMixture(){
        
        let errorMSg = "Please enter the certification details before submitting the assessment."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForNoAMPMValue(){
        if regionID == 3
        {
            if strings.contains(pleaseEnterAMPM)
            {
                strings = strings.filter { $0 != pleaseEnterAMPM }
            }
            strings.append(pleaseEnterAMPM)
        }
        else{
            let errorMSg = pleaseEnterAMPM
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func showAlertForPPMValue(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterPPM)
            {
                strings = strings.filter { $0 != pleaseEnterPPM }
            }
            strings.append(pleaseEnterPPM)
        }
        else{
            let errorMSg = pleaseEnterPPM
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertForNoPersonName(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterPersonName)
            {
                strings = strings.filter { $0 != pleaseEnterPersonName }
            }
            strings.append(pleaseEnterPersonName)
        }
        else{
            let errorMSg = pleaseEnterPersonName
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func showAlertForNoFrequency(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterFrequencyDet)
            {
                strings = strings.filter { $0 != pleaseEnterFrequencyDet }
            }
            strings.append(pleaseEnterFrequencyDet)
        }
        else{
            
            let errorMSg = pleaseEnterFrequencyDet
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    func showAlertForNoQCCount(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterQCount)
            {
                strings = strings.filter { $0 != pleaseEnterQCount }
            }
            
            strings.append(pleaseEnterQCount)
        }
        else{
            let errorMSg = pleaseEnterQCount
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertForNoValidTrainingName(){
        
        if regionID == 3
        {
            if strings.contains(pleaseEnterVaccineMixer)
            {
                strings = strings.filter { $0 != pleaseEnterVaccineMixer}
            }
            strings.append(pleaseEnterVaccineMixer)
        }
        else{
            let errorMSg = pleaseEnterVaccineMixer
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showAlertForNoCamera(){
        let errorMSg = "Reached maximum limit of images for this question."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) 
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForNoNote(){
        let errorMSg = "Please enter comments for all the questions which have been scored 0"
        let alertController = UIAlertController(title: "Alert", message: errorMSg , preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            _ in
            self.collectionView.reloadData()
            self.collectionView.selectItem(at: self.collectionviewIndexPath, animated: false, scrollPosition: .left)
        }
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertForAssepticNote(errorMsg: String, title: String){
        let alertController = UIAlertController(title: title, message: errorMsg , preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            _ in
            self.collectionView.reloadData()
            self.collectionView.selectItem(at: self.collectionviewIndexPath, animated: false, scrollPosition: .left)
        }
        
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension PEAssesmentFinalize{
    
    func anyCategoryContainValueOrNot() -> Bool{
        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
        for obj in peNewAssessmentSurrentIs.peCategoryArray{
            if obj.resultMark ?? 0 > 0 {
                return true
            }
            return false
        }
        return false
    }
    
    func getCategoryAlreadyDone() -> PECategory{
        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
        for obj in peNewAssessmentSurrentIs.peCategoryArray{
            if obj.isSelected {
                return obj
            }
        }
        return PECategory(nil)
    }
    
    
}

/************** Camera Button Action ***************************************/
extension PEAssesmentFinalize: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    @objc func takePhoto(_ sender: UIButton) {
        //    let imageArrWithIsyncIsTrue = CoreDataHandlerTurkey().fecthPhotoWithiSynsTrueTurkey(true)
        //    if imageArrWithIsyncIsTrue.count >= 15 {
        //        postAlert("Alert", message: "Maximum limit of image has been exceeded. Limit will be reset after next sync.")
        //    } else {
        /*************** Intilzing Camera Delegate Methods **********************************/
        
        
        
        // Gallery
        //                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
        //                    //                        imagePicker.allowsEditing = false
        //                    //                        imagePicker.sourceType = .savedPhotosAlbum
        //                    //                        imagePicker.cameraCaptureMode = .photo
        //                    //                        imagePicker.delegate = self
        //
        //
        //                    imagePicker.delegate = self
        //                    imagePicker.sourceType = .savedPhotosAlbum
        //                    imagePicker.allowsEditing = false
        //                    imagePicker.delegate = self
        //                    present(imagePicker, animated: true, completion: {print("Test message")})
        //
        //
        //                }
        
        //Camera
        Constants.isMovedOn = true
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.delegate = self
                present(imagePicker, animated: true)
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
        /****************************************************************************************/
        //  }
        
    }
    
    /************* Alert View Methods ***********************************/
    
    func postAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /**************************************************************************************************/
    
    /******************************  Image Picker Delegate Methods ***************************************/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage: UIImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]) as? UIImage {
            let imageData = pickedImage.jpegData(compressionQuality: 0.02)
            saveImageInPEModule(imageData:imageData!)
            self.refreshArray()
            var assessment = PE_AssessmentInProgress()
            if(selectedCategory?.sequenceNoo == 11){
                assessment = self.refriCamerAssesment[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
            }else{
                assessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
            }
            
            if let cell = tableview.cellForRow(at: tableviewIndexPath) as? PEQuestionTableViewCell {
                let imageCount = assessment.images as? [Int]
                let cnt = imageCount?.count
                let ttle = String(cnt ?? 0)
                cell.btnImageCount.setTitle(ttle,for: .normal)
                if ttle == "0"{
                    cell.btnImageCount.isHidden = true
                } else {
                    cell.btnImageCount.isHidden = false
                }
            }
            if let cell = tableview.cellForRow(at: tableviewIndexPath) as? RefrigatorQuesCell {
                let imageCount = assessment.images as? [Int]
                let cnt = imageCount?.count
                let ttle = String(cnt ?? 0)
                cell.btn_ImageCount.setTitle(ttle,for: .normal)
                if ttle == "0"{
                    cell.btn_ImageCount.isHidden = true
                } else {
                    cell.btn_ImageCount.isHidden = false
                }
            }
        }
        imagePicker.dismiss(animated: true)
    }
    /******************************************************************************************************/
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true)
    }
    
    private func saveImageInPEModule(imageData:Data){
        let imageCount = getImageCountInPEModule()
        var assessment = PE_AssessmentInProgress()
        if(selectedCategory?.sequenceNoo == 11){
            assessment = self.refriCamerAssesment[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
        }else{
            assessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
        }
        CoreDataHandlerPE().saveImageInPEModule(assessment: assessment, imageId: imageCount+1, imageData: imageData)
    }
    
    func getImageCountInPEModule() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_ImageEntity")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "imageId") as? NSArray ?? []
        var carColIdArray : [Int] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count
    }
    
    private func saveDOAInPEModule(inovojectData:InovojectData,fromDoaS:Bool?=false) -> Int{
        let imageCount = getDOACountInPEModule()
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().saveDOAPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData,fromDoaS:fromDoaS)
        return imageCount+1
    }
    
    private func saveInovojectInPEModule(inovojectData:InovojectData) -> Int{
        
        let imageCount = getDOACountInPEModule()
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().saveInovojectPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData)
        return imageCount+1
        
    }
    
    private func saveVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
        
        _ = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        let imageCount = getVMixerCountInPEModule()
        
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().saveVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
        return imageCount+1
        
    }
    
    private func delVMixerInPEModule(peCertificateData:PECertificateData) {
        
        _ = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        _ = getVMixerCountInPEModule()
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().subtractVMixerMinusCategortIsSelcted(assessment: assessment!, doaId: peCertificateData.id ?? 0)
    }
    
    func getDOACountInPEModule() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DayOfAge")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "doaId") as? NSArray ?? []
        var carColIdArray : [Int] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count
    }
    
    func getVMixerCountInPEModule() -> Int {
        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "vmid") as? NSArray ?? []
        var carColIdArray : [Int] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count
    }
    
    private func deleteDOAInPEModule(id:Int,fromDoaS:Bool? = false) {
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().updateDOAMinusCategortIsSelcted(assessment: assessment!, doaId: id,fromDoaS : fromDoaS)
    }
    
    private func deleteInovojectInPEModule(id:Int) {
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
    }
    
    private func deleteCrtificateInPEModule(id:Int) {
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
    }
}


// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

public func  convertImageToBase64String(image : UIImage ) -> String
{
    let strBase64 =  image.pngData()?.base64EncodedString()
    return strBase64!
}

extension PEAssesmentFinalize: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    func setValueInTextFields(selectedValue: String, certDateBtn: UIButton, clickedField: UITextField, cell: VaccineMixerCell, view: UIView? = nil){
        let indices = dataArray.firstIndex(of: selectedValue)
        if let indix = indices {
            
            if selectedValue != "" {
                clickedField.text = selectedValue
            }
            cell.certDateSelectBtn.setTitleColor(UIColor.black, for: .normal)
            if selectedValue != "" {
                cell.certDateSelectBtn.setTitle(certDateArray[indix], for: .normal)
                
            }
            else {
                let date =   Date.getCurrentDateNow()
                cell.certDateSelectBtn.setTitle(date, for: .normal)
            }
            if selectedValue != "" {
                if isCertExpiredArray[indix]{
                    cell.certDateSelectBtn.layer.borderColor = UIColor.red.cgColor
                    dateBlock?(certDateArray[indix],true , true , clickedField.tag )
                }else{
                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                    dateBlock?(certDateArray[indix], false , false , clickedField.tag)
                }
            }
            else {
                cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                dateBlock?(certDateArray[indix], false , false , clickedField.tag)
            }
        }
        else {
            print("Api containg site has not access, provide from website")
        }
    }
    
    func setDropdrown(_ sender: UIButton, certBtn: UIButton, clickedField:UITextField, dropDownArr:[String]?, cell: VaccineMixerCell, view: UIView? = nil){
        if  dropDownArr!.count > 0 {
            self.dropDownVIewNew(arrayData: dropDownArr!, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) {  selectedVal, index  in
                self.dropDown.hide()
                self.setValueInTextFields(selectedValue: selectedVal, certDateBtn: certBtn, clickedField: clickedField, cell: cell, view: view)
            }
            self.dropDown.show()
        }else{
            self.setValueInTextFields(selectedValue: "", certDateBtn: certBtn, clickedField: clickedField, cell: cell, view: view)
            self.dropDown.hide()
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableview.viewWithTag(pickerView.tag) as? VaccineMixerCell
        cell?.vaccNameField.text = self.dataArray[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == refridFreezerNitro) {
            self.tableview.isScrollEnabled = false
        }
        else{
            let cell = textField.superview?.superview?.superview?.superview as! VaccineMixerCell
            self.setDropdrown(cell.vaccSelectBtn, certBtn: cell.certDateSelectBtn, clickedField: cell.vaccNameField, dropDownArr: dataArray, cell: cell)
        }
        
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == refridFreezerNitro) {
            let   cell = textField.superview?.superview?.superview?.superview?.superview as! RefrigatorTempProbeCell
            if(textField == cell.topValueTxtFld){
                cell.valueCompletion?(textField, "Top")
            }
            else if (textField == cell.middleValueTxtFld){
                cell.valueCompletion?(textField, "Middle")
            }
            else{
                cell.valueCompletion?(textField, "Bottom")
            }
            self.tableview.isScrollEnabled = true
        }
        else{
            let cell = textField.superview?.superview?.superview?.superview as! VaccineMixerCell
            if(cell.vaccNameField == textField){
                chnagedVaccineNameIndexPathRow = textField.tag
                self.updateNameblock?(textField.text!)
                if regionID == 3
                {
                    if let title = cell.vaccNameField.text , !title.isEmpty
                    {
                        cell.vaccNameField.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                    }
                    else {
                        cell.vaccNameField.layer.borderColor = UIColor.red.cgColor
                    }
                }
                else
                {
                    cell.vaccNameField.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                }
                
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == refridFreezerNitro) {
            self.tableview.isScrollEnabled = false
        }
        else{
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            let newDataArray = dataArray.filter({ (dat) -> Bool in
                dat.range(of: newString as String , options: .caseInsensitive) != nil
            })
            let cell = textField.superview?.superview?.superview?.superview as! VaccineMixerCell
            self.setDropdrown(cell.vaccSelectBtn, certBtn: cell.certDateSelectBtn, clickedField: cell.vaccNameField, dropDownArr: newDataArray, cell: cell)
        }
        
        return true
    }
}



