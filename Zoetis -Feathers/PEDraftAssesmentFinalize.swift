//
//  PEAssesmentFinalize.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 13/12/19.
//  Copyright © 2019  . All rights reserved.
//

import UIKit
import SwiftyJSON


class PEDraftAssesmentFinalize: BaseViewController , DatePickerPopupViewControllerProtocol {
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var peHeaderViewController:PEHeaderViewController!
    var peNewAssessment:PENewAssessment!
    var dropdownManager = ZoetisDropdownShared.sharedInstance
    var delegate: PECategorySelectionDelegate? = nil
    var deviceIDFORSERVER = ""
    var chnagedIndexPathRow = 0
    var chnagedVaccineNameIndexPathRow = 0
    var changedDate:((_ date: String?) -> Void)?
    var updateNameblock:((_ error: String?) -> Void)?
    var currentArr : [AssessmentQuestions] = []
    var selectedCategory : PENewAssessment?
    var refriCategory : PENewAssessment?
    var ml = 0.0
    var refrigtorProbeArray  : [PE_Refrigators] = []
    var collectionviewIndexPath = IndexPath(row: 0, section: 0)
    var switchA = 0
    var switchB = 0
    var certificateData : [PECertificateData] = []
    var inovojectData : [InovojectData] = []
    var dayOfAgeData : [InovojectData] = []
    var dayOfAgeSData : [InovojectData] = []
    var dataArray = [String]()
    var mixerIdArray = [Int]()
    var certDateArray = [String]()
    var isCertExpiredArray = [Bool]()
    var signatureImgArray = [String]()
    var vacOperatorIdArray = [Int]()
    var isExpiredArray = [true, false, false, true, true, true, false]
    var showExtendedPE:Bool = false
    var refriCamerAssesment =  [PE_AssessmentInProgress]()
    var sanitationQuesArr = [PE_ExtendedPEQuestion]()
    var nameblock:((_ error: String?) -> Void)?
    var dateBlock:((_ date : String?,_ certifiedExpire :Bool? , _ isReCert : Bool?, _ count : Int) -> Void)?
    var selected_NA_QuestionArray = [Int]()
    var refrigator_Selected_NA_QuestionArray = [Int:Int]()
    var selctedNACategoryArray = [Int]()
    var refriArray = ["Refrigator used only for Vaccines and Lab Supplies?","Content Roated and cleaned montly?"]
    var fridgeArray = ["Frezzer used only for Vaccines and Lab Supplies?","Frezer alarmed and temperatures recorded on regular basis?"]
    var liquidArray = ["Liquid Nitrogen Container used for Vaccine?","Fluid Levels checked regularly and recorded?"]
    var regionID = Int()
    var textValue  : Int?
    var finishingAssessment:Bool = false
    var forInovo:Bool = false
    var strings = [String]()
    var tempArr : [JSONDictionary]  = []
    var jsonRe : JSON = JSON()
    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
    var tableviewIndexPath = IndexPath(row: 0, section: 0)
    var catArrayForCollectionIs : [PENewAssessment] = []
    var catArrayForTableIs = NSArray()
    
    
    @IBOutlet weak var buttonFinishAssessment: PESubmitButton!
    @IBOutlet weak var buttonSaveAsDraft: PESubmitButton!
    @IBOutlet weak var buttonSaveAsDraftInitial: PESubmitButton!
    @IBOutlet weak var syncWebBtn: UIButton!
    @IBOutlet weak var assessmentDateText: PEFormTextfield!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var sig_Name: UILabel!
    @IBOutlet weak var sig_EmployeeID: UITextField!
    @IBOutlet weak var scoreParentView: UIView!
    @IBOutlet weak var sig_Date: UITextField!
    @IBOutlet weak var sig_Phone: UITextView!
    @IBOutlet weak var lblRepresentative2: UILabel!
    @IBOutlet weak var imgSignature2: UIImageView!
    @IBOutlet weak var lblTitle2: UITextField!
    @IBOutlet weak var lbl_NA: UILabel!
    @IBOutlet weak var btn_NA: UIButton!
    @IBOutlet weak var sig_imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultScoreLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet fileprivate weak var tableview: UITableView!
    @IBOutlet weak var selectedCustomer: PEFormLabel!
    @IBOutlet weak var selectedComplex: PEFormLabel!
    @IBOutlet weak var scoreGradientView: UIView!
    @IBOutlet weak var customerGradientView: UIView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var coustomerView: UIView!
    @IBOutlet weak var extendedMicroSwitch: UISwitch!
    @IBOutlet weak var lblextenderMicro: UILabel!
    @IBOutlet weak var bckButton: PESubmitButton!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        lblextenderMicro.isHidden = true
        extendedMicroSwitch.isHidden = true
        extendedMicroSwitch.isUserInteractionEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Keyboard Will Show
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.bounds.origin.y == 0{
            self.view.bounds.origin.y += 200
        }
        tableview.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    }
    // MARK: - Keyboard will Hide
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
        tableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - back Button Action
    @IBAction func backButton(_ sender: Any) {
        cleanSessionAndMoveTOStart()
    }
    
    // MARK: - NA Button Action
    @IBAction func actioNA(_ sender: Any) {
        
        if checkCategoryisNA(){
            setAllQuestiontTo_Non_NA()
            if(selectedCategory?.sequenceNoo == 3 )
            {
                let indexPath = NSIndexPath(row: 10, section: 0)
                tableview.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                self.peNewAssessment.qcCount = ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            if(selectedCategory?.sequenceNoo == 6)
            {
                self.peNewAssessment.ampmValue = ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            updateScore(isAllNA: false)
        }
        else{
            setAllQuestiontToNA()
            if(selectedCategory?.sequenceNoo == 3 )
            {
                let indexPath = NSIndexPath(row: 10, section: 0)
                tableview.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
                self.peNewAssessment.qcCount = "NA"
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            if(selectedCategory?.sequenceNoo == 6 )
            {
                self.peNewAssessment.ampmValue = "NA"
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            updateScore(isAllNA: true)
        }
        btn_NA.isSelected = !btn_NA.isSelected
        
    }
    // MARK: - Clean Session
    private func cleanSessionAndMoveTOStart(){
        
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID == 3
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEDraftStartNewAssessment") as? PEDraftStartNewAssessment
            vc?.isFromBack = true
            vc?.peNewAssessment = peNewAssessment
            
            if vc != nil{
                navigationController?.pushViewController(vc!, animated: false)
            }
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PEDraftStartNewAssesmentINT") as? PEDraftStartNewAssesmentINT
            vc?.isFromBack = true
            
            if vc != nil{
                navigationController?.pushViewController(vc!, animated: false)
            }
        }
    }
    
    @IBAction func btnAction(_ sender: Any) {
        appDelegate.testFuntion()
    }
    
    override func viewDidLoad() {
        print("<<<<",self)
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        peNewAssessment = CoreDataHandlerPE().getSavedDraftOnGoingAssessmentPEObject()
        
        if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
        {
            self.buttonFinishAssessment.setTitle("Finish Extended PE", for: .normal)
        }
        
        sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
        peHeaderViewController = PEHeaderViewController()
        peHeaderViewController.titleOfHeader = "Draft Assessment"
        peHeaderViewController.assId = "C-\(peNewAssessment.draftID!)"
        self.headerView.addSubview(peHeaderViewController.view)
        self.topviewConstraint(vwTop: peHeaderViewController.view)
        let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
        showExtendedPE = peNewAssessment.sanitationValue ?? false
        let peNewAssessmentArray = CoreDataHandlerPE().getOnGoingDraftAssessmentArrayPEObject()
        var carColIdArray : [Int] = []
        var row = 0
        
        
        for cat in peNewAssessmentArray {
            if !carColIdArray.contains(cat.sequenceNo ?? 0){
                carColIdArray.append(cat.sequenceNo ?? 0)
                if(cat.catName == "Refrigerator"){
                    cat.catName = "Refrigerator\n/Freezer\n/Liquid Nitrogen"
                    
                }
                catArrayForCollectionIs.append(cat)
                
            }
        }
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3
        {
            btn_NA.isHidden = false
            lbl_NA.isHidden = false
        }
        else
        {
            btn_NA.isHidden = true
            lbl_NA.isHidden = true
        }
        UserDefaults.standard.set(peNewAssessment.serverAssessmentId , forKey: "currentServerAssessmentId")
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
                    if data != nil{
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            inovojectData.append(data!)
                        }
                    }
                }
            }
        }
        
        for cat in catArrayForCollectionIs{
            if cat.vMixer.count > 0 {
                var idArr : [Int] = []
                for obj in  cat.vMixer {
                    let data = CoreDataHandlerPE().getCertificateData(doaId: obj)
                    if data != nil{
                        if idArr.contains(data!.id ?? 0){
                        }else{
                            idArr.append(data!.id ?? 0)
                            
                            certificateData.append(data!)
                        }
                    }
                }
            }
        }
        
        if certificateData.count > 0 {
            self.certificateData =  self.certificateData.sorted(by: {
                let id1 = $0.id ?? 0
                let id2 = $1.id ?? 0
                return id1 < id2
            })
            
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
        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
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
        
        let NewcountryId1 = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3
        {
            refriCategory = catArrayForCollectionIs.last
        }
        collectionView.reloadData()
        collectionviewIndexPath = IndexPath(row: row, section: 0)
        
        selectinitialCell()
        collectionView(collectionView, didSelectItemAt: collectionviewIndexPath)
        selectedComplex.text = (catArrayForTableIs[0] as! PE_AssessmentInProgress).siteName
        selectedCustomer.text = (catArrayForTableIs[0] as! PE_AssessmentInProgress).customerName
        assessmentDateText.text = (catArrayForTableIs[0] as! PE_AssessmentInProgress).evaluationDate
        chechForLastCategory()
        
        self.getVaccineMixerList(customerId: self.peNewAssessment.customerId ?? 0, siteId: self.peNewAssessment.siteId ?? 0, countryId: 40) { status in
            
        }
        self.collectionView.selectItem(at: self.collectionviewIndexPath, animated: false, scrollPosition: .left)
        if regionID == 3
        {
            if showExtendedPE {
                let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
                if(catArrayForCollectionIs.last?.catName == "Sanitation and Embrex Evaluation"){
                    catArrayForCollectionIs.remove(at: catArrayForCollectionIs.count-1)
                }
                
                let catObjectPE = PENewAssessment()
                catObjectPE.catName = "Extended Microbial"
                catObjectPE.sequenceNo = 12
                catObjectPE.sequenceNoo = 12
                catArrayForCollectionIs.append(catObjectPE)
                btn_NA.isHidden = true
                lbl_NA.isHidden = true
                let plateInfoCell = UINib(nibName: "PlateInfoCell", bundle: nil)
                tableview.register(UINib(nibName: "PlateInfoCell", bundle: nil), forCellReuseIdentifier: "PlateInfoCell")
                
                let nibPlateInfoHeader = UINib(nibName: "PlateInfoHeader", bundle: nil)
                tableview.register(nibPlateInfoHeader, forHeaderFooterViewReuseIdentifier: "PlateInfoHeader")
                
                let sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment?.serverAssessmentId ?? "")
                
                if sanitationQuesArr.count == 0{
                    SanitationEmbrexQuestionMasterDAO.sharedInstance.saveAssessmentQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
                }
                
            }
            else{
                if(catArrayForCollectionIs.last?.catName == "Sanitation and Embrex Evaluation"){
                    catArrayForCollectionIs.remove(at: catArrayForCollectionIs.count-1)
                }
            }
        }
        
        collectionView.reloadData()
        tableview.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshScores(_:)), name: NSNotification.Name.init(rawValue: "RefreshExtendedPEScores") , object: nil)
        
        
        dataArray.removeAll()
        certDateArray.removeAll()
        mixerIdArray.removeAll()
        isCertExpiredArray.removeAll()
        signatureImgArray.removeAll()
        vacOperatorIdArray.removeAll()
        if let vaccineMixers = CoreDataHandlerMicro().fetchDetailsFor(entityName: "PE_VaccineMixerDetail") as? [PE_VaccineMixerDetail] {
            if vaccineMixers.count > 0{
                for mixer in vaccineMixers{
                    dataArray.append(mixer.name ?? "")
                    certDateArray.append(mixer.certificationDate ?? "")
                    mixerIdArray.append(Int(mixer.id ?? 0))
                    isCertExpiredArray.append(mixer.isCertExpired as? Bool ?? false)
                    signatureImgArray.append(mixer.signatureImage ?? "")
                }
            }
        }
        
    }
    // MARK: - Extended Micro Switch
    @IBAction func extendedMicroSwitch(_ sender: UISwitch) {
        if extendedMicroSwitch.isOn
        {
            UserDefaults.standard.set(true, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: true)
        }
        else
        {
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: false)
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
            self.deleteAllData("PE_VaccineMixerDetail")
            VaccineMixerResponse(json)
            completion(true)
        }
    }
    
    
    // MARK: - Refesh Score
    @objc func  refreshScores(_ notification: NSNotification){
        let sanitationIndex =  notification.userInfo?["index"]  as? Int
        refreshScore(sanitationIndex ?? -1)
    }
    
    
    func refreshScore(_ sanitationIndex:Int){
        self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
        let score = sanitationQuesArr.map({($0.currentScore ?? 0)}).reduce(0,+)
        
        resultScoreLabel.text = "\(score)"
        totalScoreLabel.text = "100"
        
        
        if sanitationIndex > -1{
            
        }
    }
    // MARK: - Setup UI
    func setupUI(){
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
    }
    
    // MARK: - Refresh Table View
    func refreshTableView(){
        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
        tableview.reloadData()
        scrollToBottom(section:0)
    }
    
    // MARK: - Refresh Array
    func refreshArray(){
        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
    }
    
    // MARK: - Filter Category
    func filterCategory()  {
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray{
            if peNewAssessment.evaluationID == object.evaluationID{
                peCategoryFilteredArray.append(object)
            }
        }
        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
    }
    // MARK: - Get Random Number
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
    
    // MARK: - Update Score
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
    
    // MARK: - Check All Validation
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
                if !hasEmptyPlateType{
                    showAlertForAddingPlateType()
                    return false
                }
            }
        }
        if !(self.peNewAssessment.evaluationName?.contains("Non") ?? false) {
            if self.inovojectData.count > 0 {
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
                        if strings.contains("Please enter vaccine details in the Vaccine Preparation & Sterility.")
                        {
                            strings = strings.filter { $0 != "Please enter vaccine details in the Vaccine Preparation & Sterility." }
                        }
                    }
                }
                
                for inovo in self.inovojectData{
                    let switchAnti = inovo.invoHatchAntibiotic
                    let txtAnti = inovo.invoHatchAntibioticText
                    if (switchAnti == 1) && (txtAnti == ""){
                        showAlertForAntibiotic()
                        return false
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
        
        if self.checkForTraning() && !(self.peNewAssessment.evaluationName?.contains("Non") ?? false) {
            if self.certificateData.count > 0 {
                let countt = self.certificateData[0].name?.count ?? 0
                
                if self.certificateData.last?.name == "" && self.certificateData.last?.certificateDate == ""
                {
                    showAlertForNoValidTraining()
                    return false
                }
                
                if countt < 1 {
                    showAlertForNoValidTraining()
                    return false
                }
            } else {
                if regionID == 3
                {
                    showAlertForNoValidTrainingName()
                }
                else
                {
                    showAlertForNoValidTrainingName()
                    return false
                }
                
            }
        }
        if self.checkForTraning()  {
            let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
            if regionID == 3
            {
                if(self.peNewAssessment.frequency?.count ?? 0 < 1){
                    if(self.peNewAssessment.evaluationID == 1){
                        if regionID == 3
                        {
                            showAlertForNoFrequency()
                        }
                        else{
                            showAlertForNoFrequency()
                            return false
                        }
                        
                    }
                }
                if(self.peNewAssessment.personName?.count ?? 0 < 1){
                    if(self.peNewAssessment.evaluationID == 1){
                        if regionID == 3
                        {
                            showAlertForNoPersonName()
                        }else
                        {
                            showAlertForNoPersonName()
                            return false
                        }
                    }
                    
                }
            }
            
            if self.peNewAssessment.qcCount?.count ?? 0 < 1 {
                if(self.peNewAssessment.evaluationID == 1){
                    if regionID == 3
                    {
                        showAlertForNoQCCount()
                    }else
                    {
                        showAlertForNoQCCount()
                        return false
                    }
                }
            }
            
            if regionID == 3
            {
                if self.peNewAssessment.ppmValue?.count ?? 0 < 1 {
                    
                    if(self.peNewAssessment.evaluationID == 1){
                        
                        if regionID == 3
                        {
                            showAlertForPPMValue()
                        }
                        else
                        {
                            showAlertForPPMValue()
                            return false
                        }
                    }
                }
            }
            
            if self.peNewAssessment.ampmValue?.count ?? 0 < 1 {
                
                if regionID == 3
                {
                    showAlertForNoAMPMValue()
                }
                else{
                    showAlertForNoAMPMValue()
                    return false
                }
                
            }
        }
        
        
        let formatter = CodeHelper.sharedInstance.getDateFormatterObj("")
        if(regionID == 3){
            formatter.dateFormat = "MM/dd/yyyy"
//            formatter.calendar = Calendar(identifier: .gregorian)
//            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        }else{
            formatter.dateFormat = "dd/MM/yyyy"
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
    
    // MARK: - Alert for Program Name
    func showAlertForProgramName(){
        if regionID == 3
        {
            if strings.contains("Please enter program name in the Vaccine Preparation & Sterility.")
            {
                strings = strings.filter { $0 != "Please enter program name in the Vaccine Preparation & Sterility." }
            }
            
            strings.append("Please enter program name in the Vaccine Preparation & Sterility.")
        }
        else
        {
            let errorMSg = "Please enter program name in the Vaccine Preparation Tab."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Alert for Restricted Operations
    func displayAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: "Restricted Operation.", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    // MARK: - Alert for Vaccine Details
    func showAlertForNoValid(){
        
        if regionID == 3{
            
            if strings.contains("Please enter vaccine details in the Vaccine Preparation & Sterility.")
            {
                strings = strings.filter { $0 != "Please enter vaccine details in the Vaccine Preparation & Sterility." }
            }
            strings.append("Please enter vaccine details in the Vaccine Preparation & Sterility.")
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
    // MARK: - Show Alert for Antibiotic
    func showAlertForAntibiotic(){
        if regionID == 3
        {
            if strings.contains("Please enter Antibiotic in the Vaccine Preparation & Sterility.")
            {
                strings = strings.filter { $0 != "Please enter Antibiotic in the Vaccine Preparation & Sterility." }
            }
            
            strings.append("Please enter Antibiotic in the Vaccine Preparation & Sterility.")
            let errorMSg = "Please enter Antibiotic in the Vaccine Preparation & Sterility."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
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
    // MARK: - Alert for Mandatory Comment
    func showAlertForCommentMandatory(){
        let errorMSg = "Please enter the Comment before submitting the assessment in Extended Microbial."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Alert for Plates Type
    func showAlertForAddingPlateType(){
        let errorMSg = "Please select all plate types in Sanitation And Embrex Evaluation Tab"
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Alert for Vaccine Mixture
    func showAlertForNoValidTraining(){
        let errorMSg = "Please enter vaccine mixture Data in Vaccine Preparation & Sterility to submit this assessment."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Alert for Images Capture Maximum Limit
    func showAlertForNoCamera(){
        let errorMSg = "Reached maximum limit of images for this question."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) 
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Finalized Button Clicked
    @IBAction func finalizeButtonClicked(_ sender: Any) {
        
        if regionID == 3
        {
            if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
            {
                if extendedMicroSwitch.isOn {
                    var extendedMicroArr : [JSONDictionary]  = []
                    let allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(isFromDraft: true,serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                    
                    let dataToSubmitNumber = self.getAssessmentInOfflineFromDb()
                    PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:"completed",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                    
                    var param = [String:String]()
                    
                    param = ["sig":String(peNewAssessment.sig!),"sig2":String(peNewAssessment.sig2!),"sig_EmpID": String(peNewAssessment.sig_EmpID!),"sig_EmpID2":String(peNewAssessment.sig_EmpID2!),"sig_Name":String(peNewAssessment.sig_Name!),"sig_Name2":String(peNewAssessment.sig_Name2!),"sig_Phone":String(peNewAssessment.sig_Phone!),"sig_Date":Date().stringFormat(format: "MMM d, yyyy") ]
                    
                    let savedDataIs =  CoreDataHandlerPE().saveDataToSyncPEInDBArray(newAssessmentArray: allAssesmentArr as? [PENewAssessment] ?? [], dataToSubmitNumber: dataToSubmitNumber + 1,param:param,fromDraft: true)
                    
                    let jsonExtendedMicro = self.createSyncRequestForExtendedMicro(dict: peNewAssessment , certificationData : self.certificateData )
                    extendedMicroArr.append(jsonExtendedMicro)
                    
                    var ExtendedMicroparam = ["ExtendedMicrobialData":extendedMicroArr] as JSONDictionary
                    self.convertDictToJson(dict: ExtendedMicroparam,apiName: "AddEMAssessment")
                    let errorMSg = "Are you sure you want to finish the Extended PE."
                    let alertController = UIAlertController(title: "Alert!", message: errorMSg as? String, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                        _ in
                        self.showGlobalProgressHUDWithTitle(self.view, title: "Data sync is in progress, please do not close the app." + "\n" + "*Note - Please don't minimize App while syncing.")
                        self.callExtendedMicro(param: ExtendedMicroparam)
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
                    alertController.addAction(okAction)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    let errorMSg = "Please switch on the Extended Microbial."
                    let alertController = UIAlertController(title: "Alert!", message: errorMSg, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) 
                    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            
            else
            {
                finishingAssessment = true
                forInovo = true
                self.strings.removeAll()
                if  checkNoteForEveryQuestion(){
                    
                    if validateForm() {
                        
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
                                    self.saveFinalizedData()
                                }
                                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                                    _ in
                                }
                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            let errorMSg = "Are you sure you want to finish the assessment? After finishing the information can't be edited."
                            let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
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
        }
        else
        {
            finishingAssessment = true
            forInovo = true
            self.strings.removeAll()
            if  checkNoteForEveryQuestion(){
                if validateForm() {
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
                        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            _ in
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
                    let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
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
    // MARK: - Alert for AM/PM Value
    func showAlertForNoAMPMValue(){
        if regionID == 3
        {
            if strings.contains("Please enter AM/PM Value in Miscellaneous.")
            {
                strings = strings.filter { $0 != "Please enter AM/PM Value in Miscellaneous." }
            }
            strings.append("Please enter AM/PM Value in Miscellaneous.")
        }
        else
        {
            let errorMSg = "Please enter AM/PM Value in Miscellaneous."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Alert for QC Count
    func showAlertForNoAMPMValueNoQCCount(){
        let errorMSg = "Please enter am/pm  or the qc counts."
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Alert for Frequency Control
    func showAlertForNoFrequency (){
        if regionID == 3
        {
            if strings.contains("Please enter frequency detail in Customer Quality Control Program.")
            {
                strings = strings.filter { $0 != "Please enter frequency detail in Customer Quality Control Program." }
            }
            strings.append("Please enter frequency detail in Customer Quality Control Program.")
        }
        else
        {
            
            let errorMSg = "Please enter frequency detail in Customer Quality Control Program."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Alert for Person Name
    func showAlertForNoPersonName(){
        if regionID == 3
        {
            if strings.contains("Please enter person name in Customer Quality Control Program.")
            {
                strings = strings.filter { $0 != "Please enter person name in Customer Quality Control Program." }
            }
            strings.append("Please enter person name in Customer Quality Control Program.")
        }
        else{
            let errorMSg = "Please enter person name in Customer Quality Control Program."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Alert for QC Count
    func showAlertForNoQCCount(){
        if regionID == 3
        {
            if strings.contains("Please enter QC count in Customer Quality Control Program.")
            {
                strings = strings.filter { $0 != "Please enter QC count in Customer Quality Control Program." }
            }
            
            strings.append("Please enter QC count in Customer Quality Control Program.")
        }
        else
        {
            let errorMSg = "Please enter QC count in Customer Quality Control Program."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Alert for PPM Value
    func  showAlertForPPMValue(){
        if regionID == 3
        {
            if strings.contains("Please enter PPM Value in Inovoject System Set Up/Shut Down and Operation.")
            {
                strings = strings.filter { $0 != "Please enter PPM Value in Inovoject System Set Up/Shut Down and Operation." }
            }
            
            strings.append("Please enter PPM Value in Inovoject System Set Up/Shut Down and Operation.")
        }
        else
        {
            let errorMSg = "Please enter PPM Value in Inovoject System Set Up/Shut Down and Operation."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
    }
    // MARK: - Alert for Vaccine Mixture
    func showAlertForNoValidTrainingName(){
        if regionID == 3
        {
            if strings.contains("Please enter Vaccine Mixer Observer in  Vaccine Preparation & Sterility.")
            {
                strings = strings.filter { $0 != "Please enter Vaccine Mixer Observer in  Vaccine Preparation & Sterility."}
            }
            strings.append("Please enter Vaccine Mixer Observer in  Vaccine Preparation & Sterility.")
        }
        else
        {
            let errorMSg = "Please enter Vaccine Mixer Observer in  Vaccine Preparation & Sterility."
            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) 
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) 
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Alert for Add comments to all question which have been scored Zero
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
    // MARK: - Save Finalized Data
    private func saveFinalizedData(){
        
        if extendedMicroSwitch.isHidden {
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: false)
        }
        else
        {
            if extendedMicroSwitch.isOn
            {
                UserDefaults.standard.set(true, forKey:"extendedAvailable")
                CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: true)
            }
            else
            {
                UserDefaults.standard.set(false, forKey:"extendedAvailable")
                CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: false)
                
            }
        }
        
        var refrigtorArray  : [PE_Refrigators] = []
        refrigtorArray =   CoreDataHandlerPE().getDraftREfriData(id: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
        if(refrigtorArray.count > 0){
            for refrii in refrigtorArray{
                if(CoreDataHandlerPE().someEntityExists(id: Int(refrii.id ?? 0))){
                    CoreDataHandlerPE().updateRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                }
            }
        }
        
        refrigtorArray =   CoreDataHandlerPE().getDraftREfriData(id: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
        if(refrigtorArray.count > 0){
            for refrii in refrigtorArray{
                if(CoreDataHandlerPE().checkOfflineSameAssesmentEntityExists(id: Int(refrii.id ?? 0),serverAssessmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)){
                    CoreDataHandlerPE().updateOfflineRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveOfflineRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                }
            }
        }
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEFinishPopupViewController") as? PEFinishPopupViewController
        
        vc?.scheduledAssessment = peNewAssessment
        vc?.isFromDraft = true
        if peNewAssessment.rejectionComment == "" || peNewAssessment.rejectionComment == nil {
            vc?.prevController = "Draft"
        }else{
            vc?.prevController = "Rejected"
        }
        
        if peNewAssessment.evaluationID == 1 {
            var z = 0
            for item in certificateData {
                z = z + 1
            }
        }
        UserDefaults.standard.set(nil, forKey: "FsrSign")
        UserDefaults.standard.set(false, forKey: "isSignedFSR")
        vc?.certificateData = certificateData
        vc?.validationSuccessFull = {[unowned self] ( param) in
            let allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(isFromDraft: true,serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
            
            let dataToSubmitNumber = self.getAssessmentInOfflineFromDb()
            PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:"completed",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
            
            let savedDataIs =  CoreDataHandlerPE().saveDataToSyncPEInDBArray(newAssessmentArray: allAssesmentArr as? [PENewAssessment] ?? [], dataToSubmitNumber: dataToSubmitNumber + 1,param:param,fromDraft: true)
            
            if savedDataIs {
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.saveContext()
                
                if extendedMicroSwitch.isOn
                {
                    Constants.isDraftAssessment = false
                }
                else
                {
                    Constants.isDraftAssessment = true
                }
                self.finishSession()
            }
            
        }
        if vc != nil{
            self.navigationController?.present(vc!, animated: false, completion: nil)
        }
        
    }
    // MARK: - Get Assessment Detail in Online from DB
    func getAssessmentInOfflineFromDb() -> Int {
        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInOffline")
        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
        var carColIdArray : [Int] = []
        
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count
    }
    
    
    // MARK: - Save Draft Data
    private func saveDraftData(){
        if extendedMicroSwitch.isOn {
            extendedMicroSwitch.setOn(false, animated: true)
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: false)
        }
        
        if extendedMicroSwitch.isOn
        {
            UserDefaults.standard.set(true, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: true)
        }
        else
        {
            UserDefaults.standard.set(false, forKey:"ExtendedMicro")
            CoreDataHandlerPE().updateDraftIsEMRequested(isEMRequested: false)
            
        }
        
        let allAssesmentArr = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject(isFromDraft: true,serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
        
        let draft = peNewAssessment.draftNumber ?? 0
        
        if draft > -1 {
            
            CoreDataHandlerPE().saveDraftPEInDBDraft(newAssessmentArray: allAssesmentArr, draftId:peNewAssessment.draftID ?? "")
            
        }
        PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:"draft",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
        
        var refrigtorArray  : [PE_Refrigators] = []
        refrigtorArray =   CoreDataHandlerPE().getDraftREfriData(id: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
        if(refrigtorArray.count > 0){
            for refrii in refrigtorArray{
                if(CoreDataHandlerPE().someEntityExists(id: Int(refrii.id ?? 0))){
                    CoreDataHandlerPE().updateRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                }
            }
        }
        
        if extendedMicroSwitch.isOn
        {
            Constants.isDraftAssessment = false
        }
        else
        {
            Constants.isDraftAssessment = true
        }
        
        finishSession()
        
    }
    
    // MARK: - Get Drafted Assessment's Count
    func getDraftCountFromDb() -> Int {
        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInDraft")
        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "draftNumber") as? NSArray ?? []
        var carColIdArray : [Int] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? Int ?? 0){
                carColIdArray.append(obj as? Int ?? 0)
            }
        }
        return carColIdArray.count ?? 0
    }
    
    // MARK: - Finish Session
    func finishSession()  {
        cleanSession()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
    }
    // MARK: - Clean Session
    private func cleanSession(){
        CoreDataHandler().deleteAllData("PE_AssessmentIDraftInProgress")
        self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
    }
    
    // MARK:
    // MARK: ------------ Date Formetter --------------
    // MARK:
    
    func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "MMM d, yyyy"
        let oldDate = olDateFormatter.date(from: inputDate)
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID == 3
        {convertDateFormatter.dateFormat = "yyyy-MM-dd"
        }
        else{
            convertDateFormatter.dateFormat = "yyyy-MM-dd"
        }
        
        
        if oldDate != nil{
            return convertDateFormatter.string(from: oldDate!)
        }
        return ""
    }
    
    
    
    // MARK:
    // MARK: ------------ Extended Micro Create Sync Request --------------
    // MARK:
    func createSyncRequestForExtendedMicro(dict: PENewAssessment ,certificationData : [PECertificateData]) -> JSONDictionary{
        
        CoreDataHandlerPE().updateOfflineIsEMRejected(isEMRejected: false)
        
        if extendedMicroSwitch.isOn
        {
            dict.IsEMRequested = true
            CoreDataHandlerPE().updateOfflineIsEMRequested(isEMRequested: true)
        }
        else
        {
            dict.IsEMRequested = false
            CoreDataHandlerPE().updateOfflineIsEMRequested(isEMRequested: false)
        }
        
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
        var Complete = 1
        var Draft = 0
        var SaveType = 1
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
        
        let countryID = UserDefaults.standard.integer(forKey: "nonUScountryId")
        
        let FlockAgeId = dict.isFlopSelected
        let Status_Type = ""
        let UserId = dict
            .userID
        let RepresentativeName = ""
        let Notes = dict.notes
        let dateFormatter = DateFormatter()
        
        let regionId = UserDefaults.standard.integer(forKey: "Regionid")
        if regionId != 3 {
            dateFormatter.dateFormat = "dd/MM/YYYY HH:mm:ss Z"
            let date = dict.evaluationDate?.toDate(withFormat: "dd/MM/YYYY")
            let datastr = date?.toString(withFormat: "dd/MM/YYYY HH:mm:ss Z")
        }
        else{
            dateFormatter.dateFormat="MM/dd/YYYY"
            
            let date = dict.evaluationDate?.toDate(withFormat: "MM/dd/YYYY")
            let datastr = date?.toString(withFormat: "MM/dd/YYYY HH:mm:ss Z")
        }
        
        let  sig_Datetext = dict.sig_Date
        var dateSig = ""
        let ddd = dict.sig_Date ?? ""
        if ddd != "" {
            dateSig = self.convertDateFormat(inputDate: ddd)
        }
        
        let statusType = dict.statusType ?? 0
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
            let indexOfe = iStleNameArray.index(of: IncubationStyle ?? "")
            iStle = iStleIDArray[indexOfe] as? Int ?? 0
        }
        
        dict.evaluationDate = dateSig
        
        var json : JSONDictionary = JSONDictionary()
        if dateSig != ""{
            dict.evaluationDate = dateSig
        }else{
            let convertDateFormatter = DateFormatter()
            convertDateFormatter.dateFormat = "yyyy-MM-dd"
            
            convertDateFormatter.timeZone = Calendar.current.timeZone
            convertDateFormatter.locale = Calendar.current.locale
        }
        let userInfo = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: dict.serverAssessmentId ?? "")
        let dateFormatterObj = CodeHelper.sharedInstance.getDateFormatterObj("")
        if regionId == 3 {
            dateFormatterObj.dateFormat = "MM/dd/yyyy"
        }
        else
        {
            dateFormatterObj.dateFormat = "dd/MM/yyyy"
        }
        
        let evalDateObj = dateFormatterObj.date(from: evaluationDate ?? "")
        dateFormatterObj.dateFormat = "yyyy-MM-dd"
        let evalDateStr = dateFormatterObj.string(from: evalDateObj ?? Date())
        dict.evaluationDate = evalDateStr
        var isEMRequested = dict.IsEMRequested ?? false
        
        let RegionalId = UserDefaults.standard.integer(forKey: "Regionid")
        let extndMicro = dict.extndMicro ?? false
        
        let appVersion = "\(Bundle.main.versionNumber)"
        
        tempArr.removeAll()
        
        
        if SaveType == 0 {
            if statusType == 2 {
                
                json = [
                    
                    "AssessmentId":serverAssessmentId,
                    "DeviceId": deviceIDFORSERVER,
                    "UserId": UserId,
                    "EvaluationId": EvaluationId ?? 0,
                    "SaveType":1,
                    "Status_Type":0,
                    "IsEMRequested" : isEMRequested,
                    "IsSendEmail": true,
                    "appVersion": appVersion,
                    "SanitationEmbrexScoresDataModel":extendedData
                ] as JSONDictionary
            }else{
                json = [
                    "AssessmentId":serverAssessmentId,
                    "DeviceId": deviceIDFORSERVER,
                    "UserId": UserId,
                    "EvaluationId": EvaluationId ?? 0,
                    "SaveType":1,
                    "Status_Type":0,
                    "IsEMRequested" : isEMRequested,
                    "IsSendEmail": true,
                    "appVersion": appVersion,
                    "SanitationEmbrexScoresDataModel":extendedData
                ] as JSONDictionary
            }
        } else {
            json = [
                
                "AssessmentId":serverAssessmentId,
                "DeviceId": deviceIDFORSERVER,
                "UserId": UserId,
                "EvaluationId": EvaluationId ?? 0,
                "SaveType":1,
                "Status_Type":0,
                "IsEMRequested" : isEMRequested,
                "IsSendEmail": true,
                "appVersion": appVersion,
                "SanitationEmbrexScoresDataModel":extendedData
            ] as JSONDictionary
        }
        return json
        
    }
    
    // MARK:
    // MARK: ------------ Call Extended Micro Sync Request --------------
    // MARK:
    
    func callExtendedMicro(param:JSONDictionary){
        
        ZoetisWebServices.shared.sendExtendedMicroToServer(controller: self, parameters: param, completion: { [weak self] (json, error) in
            if error != nil {
                self?.dismissGlobalHUD(self?.view ?? UIView())
            }
            guard let `self` = self, error == nil else { return }
            if json["StatusCode"]  == 200{
                cleanSession()
                self.showtoast(message: "Data synced successfully.")
                self.dismissGlobalHUD(self.view)
                
            } else {
                self.dismissGlobalHUD(self.view)
                self.showAlert(title: "Error", message: "Error in Extended Microbial data sync", owner: self)
            }
        })
    }
    
}
// MARK: - PE Draft Assessment Finalize & table View Delegates
extension PEDraftAssesmentFinalize: UITableViewDelegate, UITableViewDataSource{
    
    func checkForTraning()-> Bool{
        var currentAssessmentIs = CoreDataHandlerPE().getSavedDraftOnGoingAssessmentPEObject()
        if currentAssessmentIs.visitName == "Training"{
            return true
        } else{
            return true
        }
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
                else{
                    if peNewAssessment.evaluationID == 1{
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
            if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
                return 1
            }
            if selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
                return 3
            }
            else {
                return 1
            }
        }
        if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
            return 1
        }
        if selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
            return 3
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if checkForTraning(){
            
            if section == 0 && selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen" {
                return sanitationQuesArr.count
            }
            
            if (selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
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
            if(selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
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
        if selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
            var height:CGFloat = CGFloat()
            height = 70
            return height
        }
        let assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
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
        
        
        if selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
            var height:CGFloat = CGFloat()
            height = 80
            return height
            
        }
        if(selectedCategory?.catName != "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
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
        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        let attributes = [NSAttributedString.Key.font: font]
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
        return rectangleHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if checkForTraning(){
            if indexPath.section == 0 && selectedCategory?.sequenceNoo == 12 && selectedCategory?.catName == "Extended Microbial"{// "Sanitation and Embrex Evaluation"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlateInfoCell", for: indexPath) as! PlateInfoCell
                cell.currentIndex = indexPath.row
                if sanitationQuesArr.count > indexPath.row{
                    cell.setValues(quesObj: sanitationQuesArr[indexPath.row], index: indexPath.row)
                }
                cell.plateTypeCompletion = {
                    [unowned self] ( error) in
                    let plateTypes = PlateTypesDAO.sharedInstance.fetchPlateTypes(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "")
                    let arr = plateTypes.map{ $0.value}
                    self.dropDownVIewNew(arrayData: arr as? [String] ?? [String](), kWidth: cell.plateTypeBtn.frame.width, kAnchor: cell.plateTypeBtn, yheight: cell.plateTypeBtn.bounds.height) {
                        [unowned self] selectedVal, index  in
                        if indexPath.row > -1 && self.sanitationQuesArr.count > indexPath.row{
                            let quesObj = self.sanitationQuesArr[indexPath.row]
                            if index > -1 && plateTypes.count > index{
                                self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                                
                                quesObj.plateTypeDescription = plateTypes[index].value
                                quesObj.plateTypeId =  plateTypes[index].id
                                
                                self.sanitationQuesArr[indexPath.row] = quesObj
                                SanitationEmbrexQuestionMasterDAO.sharedInstance.updateAssessmentQuestion(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "", questionId: Int64(quesObj.questionId ?? "") ?? 0, questionVM: quesObj)
                                
                            }
                            self.tableview.beginUpdates()
                            self.tableview.reloadRows(at: [indexPath], with: .automatic)
                            self.tableview.endUpdates()
                        }
                    }
                    
                    
                    self.dropHiddenAndShow()
                }
                cell.commentsCompletion = {[unowned self] ( error) in
                    
                    self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "")
                    var comments = self.sanitationQuesArr[indexPath.row].userComments ?? ""
                    var questionObj = self.sanitationQuesArr[indexPath.row]
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
                    vc.textOfTextView = comments
                    vc.editable = true
                    vc.commentCompleted = {[unowned self] ( note) in
                        if note == "" {
                            let image = UIImage(named: "PEcomment.png")
                            cell.noteBtn.setImage(image, for: .normal)
                            
                        } else {
                            let image = UIImage(named: "PECommentSelected.png")
                            cell.noteBtn.setImage(image, for: .normal)
                        }
                        
                        questionObj.userComments = note ?? ""
                        self.sanitationQuesArr[indexPath.row] = questionObj
                        if questionObj != nil{
                            SanitationEmbrexQuestionMasterDAO.sharedInstance.updateAssessmentQuestion(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: self.peNewAssessment?.serverAssessmentId ?? "", questionId: Int64(questionObj.questionId ?? "") ?? 0, questionVM: questionObj)
                            tableView.beginUpdates()
                            tableView.reloadRows(at: [indexPath], with: .automatic)
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
                cell.assessmentId = peNewAssessment?.serverAssessmentId
                return cell
            }
            if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                
                return  setUpRerigatorQuesCell(tableView, cellForRowAt: indexPath)
            }
            
            else {
                
                if indexPath.section == 1 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: VaccineMixerCell.identifier) as? VaccineMixerCell{
                        cell.certDateSelectBtn.tag = indexPath.row
                        
                        cell.vaccNameField.tag = indexPath.row
                        cell.calenderBtn.tag =   indexPath.row
                        
                        cell.config(data:certificateData[indexPath.row])
                        cell.vaccNameField.delegate = self
                        
                        if regionID == 3
                        {
                            if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                            {
                                cell.toggleBtn.isUserInteractionEnabled = false
                                cell.vaccNameField.isUserInteractionEnabled = false
                                cell.vaccSelectBtn.isUserInteractionEnabled = false
                                cell.certDateSelectBtn.isUserInteractionEnabled = false
                                cell.calenderBtn.isUserInteractionEnabled = false
                            }
                            else
                            {
                                cell.toggleBtn.isUserInteractionEnabled = true
                                cell.vaccNameField.isUserInteractionEnabled = true
                                cell.vaccSelectBtn.isUserInteractionEnabled = true
                                cell.certDateSelectBtn.isUserInteractionEnabled = true
                                cell.calenderBtn.isUserInteractionEnabled = true
                            }
                        }
                        
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
                                    if regionID == 3{
                                        cell.vaccNameField.layer.borderColor = UIColor.red.cgColor
                                    }
                                    else{
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
                                        inputFormatter.dateFormat = "dd/MM/yyyy"
                                        let showDate = inputFormatter.date(from: date ?? "")
                                        inputFormatter.dateFormat = "dd/MM/yyyy"
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
                        
                        changedDate =  {  [unowned self] (date) in
                            
                            self.tableviewIndexPath = indexPath
                            if(regionID != 3){
                                let inputFormatter = DateFormatter()
                                inputFormatter.dateFormat = "dd/MM/yyyy"
                                let showDate = inputFormatter.date(from: date ?? "")
                                inputFormatter.dateFormat = "dd/MM/yyyy"
                                if(showDate != nil){
                                    let resultString = inputFormatter.string(from: showDate!)
                                    
                                    certificateData[chnagedIndexPathRow].certificateDate = resultString
                                }
                                else{
                                    certificateData[chnagedIndexPathRow].certificateDate = date
                                }
                            }
                            else{
                                certificateData[chnagedIndexPathRow].certificateDate = date
                            }
                            CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[chnagedIndexPathRow], id:  self.certificateData[chnagedIndexPathRow].id ?? 0)
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                            cell.vaccNameField.resignFirstResponder()
                            cell.vaccNameField.endEditing(true)
                            
                        }
                        
                        dateBlock = { [unowned self] (date , certifiedExpery , isReCert ,Count) in
                            
                            if(regionID != 3){
                                let inputFormatter = DateFormatter()
                                inputFormatter.dateFormat = "dd/MM/yyyy"
                                let showDate = inputFormatter.date(from: date ?? "")
                                inputFormatter.dateFormat = "dd-MM-yyyy"
                                if(showDate != nil){
                                    let resultString = inputFormatter.string(from: showDate!)
                                    certificateData[Count].certificateDate = resultString
                                }
                                else{
                                    certificateData[Count].certificateDate = date
                                }
                            }
                            else{
                                certificateData[Count].certificateDate = date
                            }
                            certificateData[Count].isCertExpired = certifiedExpery
                            self.certificateData[Count].name = cell.vaccNameField.text ?? ""
                            certificateData[Count].isReCert = isReCert
                            
                            if dataArray.contains(cell.vaccNameField.text!){
                                var index =  dataArray.firstIndex(of: cell.vaccNameField.text!)
                                
                                certificateData[Count].vacOperatorId = mixerIdArray[index!]
                                CoreDataHandlerPE().updateVMixerNewInDB(peCertificateData:  self.certificateData[Count], id:  self.certificateData[Count].id ?? 0)
                            }
                            else {
                                certificateData[Count].vacOperatorId = 0
                                CoreDataHandlerPE().updateVMixerNewInDB(peCertificateData:  self.certificateData[Count], id:  self.certificateData[Count].id ?? 0)
                                
                            }
                        }
                        
                        nameblock = {[unowned self] ( error) in
                            self.tableviewIndexPath = indexPath
                            self.certificateData[self.tableviewIndexPath.row].name = error
                            CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.tableviewIndexPath.row], id:  self.certificateData[self.tableviewIndexPath.row].id ?? 0)
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                            self.view.endEditing(true)
                        }
                        
                        updateNameblock = {[unowned self] ( error) in
                            self.certificateData[self.chnagedVaccineNameIndexPathRow].name = error
                            CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.chnagedVaccineNameIndexPathRow], id:  self.certificateData[self.chnagedVaccineNameIndexPathRow].id ?? 0)
                            UIView.performWithoutAnimation {
                                print("Test Message")
                            }
                            cell.vaccNameField.resignFirstResponder()
                            cell.vaccNameField.endEditing(true)
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
                } else {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
            
        } else {
            let assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
            if assessment?.sequenceNoo == 3 && assessment?.catName?.lowercased()
                != "miscellaneous" {
                if indexPath.section == 0 {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)              }
                if indexPath.section == 1 {
                    return UITableViewCell()
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
                if indexPath.section == 3 {
                    return self.setupDayOfAgeSCell(tableView, cellForRowAt: indexPath)
                } else {
                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
                }
            }
        }
        return UITableViewCell()
    }
    
    
    // MARK: - Setup Inovoject Cell in Table View
    func setupInovojectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectNewTableViewCell {
        if let cell =  tableView.dequeueReusableCell(withIdentifier: InovojectNewTableViewCell.identifier) as? InovojectNewTableViewCell{
            if indexPath.row % 2 == 0{
                cell.contentView.backgroundColor = UIColor.white
            } else{
                cell.contentView.backgroundColor = UIColor.getHeaderTopGradient()
            }
            
            cell.config(data:inovojectData[indexPath.row])
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    
                    cell.hatcheryAntibioticsSwitch.isUserInteractionEnabled = false
                    cell.diluentManufacturerVw.isUserInteractionEnabled = false
                    cell.bagSizeVw.isUserInteractionEnabled = false
                    cell.ampuleSizeVw.isUserInteractionEnabled = false
                    cell.ampulePerBagVw.isUserInteractionEnabled = false
                    cell.vaccineNameBtn.isUserInteractionEnabled = false
                    cell.bagsizeBtn.isUserInteractionEnabled = false
                    cell.vaccineNameVw.isUserInteractionEnabled = false
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfProgramName.isUserInteractionEnabled = false
                    cell.tfAntibioticText.isUserInteractionEnabled = false
                    cell.tfOtherManText.isUserInteractionEnabled = false
                    
                }
                else
                {
                    cell.hatcheryAntibioticsSwitch.isUserInteractionEnabled = true
                    cell.vaccineNameBtn.isUserInteractionEnabled = true
                    cell.bagsizeBtn.isUserInteractionEnabled = true
                    cell.diluentManufacturerVw.isUserInteractionEnabled = true
                    cell.bagSizeVw.isUserInteractionEnabled = true
                    cell.ampuleSizeVw.isUserInteractionEnabled = true
                    cell.ampulePerBagVw.isUserInteractionEnabled = true
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfProgramName.isUserInteractionEnabled = true
                    cell.tfAntibioticText.isUserInteractionEnabled = true
                    cell.tfOtherManText.isUserInteractionEnabled = true
                    
                }
            }
            
            
            
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
                            self.showtoast(message: "Incomplete Data")
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
                CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
                UIView.performWithoutAnimation {
                    self.tableview.reloadData()
                }
                
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
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    
                    let  selectedValIS = selectedVal.replacingOccurrences(of: " ", with: "")
                    let c = Double(self.inovojectData[indexPath.row].bagSizeType ?? "0") ?? 0
                    if c == 0 {
                        self.showtoast(message: "Incomplete Data")
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
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                        self.inovojectData[indexPath.row].ampulePerBag = selectedVal
                        let c = Double(self.inovojectData[indexPath.row].bagSizeType ?? "0") ?? 0
                        if c == 0 {
                            return
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
            
            cell.doseCompletion  = {[unowned self] ( error) in
                
            }
            
            cell.nameCompletion  = {[unowned self] ( text) in
                self.tableviewIndexPath = indexPath
                if text != "" {
                    self.inovojectData[indexPath.row].name = text
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
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
                    let xxx =    self.inovojectData[indexPath.row].vaccineMan ?? ""
                    if xxx != "" {
                        let indexOfd = vManufacutrerNameArray.index(of: xxx)
                    } else {
                    }
                    var indexArray : [Int] = []
                    var vNameFilterArray : [String] = []
                    var vNameArray = NSArray()
                    var vNameIDArray = NSArray()
                    var vNameDetailsArray = NSArray()
                    var vNameMfgIdArray = NSArray()
                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
                    vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as? NSArray ?? NSArray()
                    var x = -1
                    for obj in vNameMfgIdArray {
                        x = x + 1
                        if ((obj as? Int ?? 0) == ManufacturerId)
                        {
                            indexArray.append(x)
                        }
                    }
                    
                    vNameFilterArray = vNameArray as? [String] ?? [String]()
                    
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
                self.view.endEditing(true)
            }
            
            return cell
        }
        
        return UITableViewCell() as! InovojectNewTableViewCell
    }
    
    // MARK: - Set Up Day of Age Cell in Table View
    func setupDayOfAgeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
            cell.config(data:dayOfAgeData[indexPath.row],isDayOfAge:true)
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    cell.viewVaccineMan.isUserInteractionEnabled = false
                    cell.viewAmpleSize.isUserInteractionEnabled = false
                    cell.viewAmpleBag.isUserInteractionEnabled = false
                    cell.viewBagSize.isUserInteractionEnabled = false
                    cell.viewName.isUserInteractionEnabled = false
                    cell.viewDiluentManufacturer.isUserInteractionEnabled = false
                    cell.btnDosage.isUserInteractionEnabled = false
                    cell.btnVaccineName.isUserInteractionEnabled = false
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.ampuleSizeBtn.isUserInteractionEnabled = false
                    cell.dosageBtn.isUserInteractionEnabled = false
                }
                else{
                    cell.viewVaccineMan.isUserInteractionEnabled = true
                    cell.viewAmpleSize.isUserInteractionEnabled = true
                    cell.viewAmpleBag.isUserInteractionEnabled = true
                    cell.viewBagSize.isUserInteractionEnabled = true
                    cell.viewName.isUserInteractionEnabled = true
                    cell.viewDiluentManufacturer.isUserInteractionEnabled = true
                    cell.btnDosage.isUserInteractionEnabled = true
                    cell.btnVaccineName.isUserInteractionEnabled = true
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.ampuleSizeBtn.isUserInteractionEnabled = true
                    cell.dosageBtn.isUserInteractionEnabled = true
                }
            }
            
            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
                
                self.tableviewIndexPath = indexPath
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ??  NSArray()
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
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String]() , kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    
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
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                    
                    self.dayOfAgeData[indexPath.row].ampulePerBag = selectedVal
                    
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                }
                self.dropHiddenAndShow()
            }
            
            cell.doseCompletion  = {[unowned self] ( error) in
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
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
                    let xxx =    self.dayOfAgeData[indexPath.row].vaccineMan ?? ""
                    if xxx != "" {
                        let indexOfd = vManufacutrerNameArray.index(of: xxx)
                        ManufacturerId = vManufacutrerIDArray[indexOfd] as? Int  ?? 0
                    } else {
                        
                    }
                    var indexArray : [Int] = []
                    var vNameFilterArray : [String] = []
                    var vNameArray = NSArray()
                    var vNameIDArray = NSArray()
                    var vNameDetailsArray = NSArray()
                    var vNameMfgIdArray = NSArray()
                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 1)//CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
                    vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as? NSArray ?? NSArray()
                    var x = -1
                    for obj in vNameMfgIdArray {
                        x = x + 1
                        if( obj as! Int ?? 0) == ManufacturerId
                        {
                            let indexOfd = vNameMfgIdArray.index(of: obj)
                            indexArray.append(x)
                        }
                    }
                    let indexOfA = vNameMfgIdArray.index(of: ManufacturerId)
                    for index in indexArray {
                        
                        let item = vNameArray[index] as? String ?? ""
                    }
                    vNameFilterArray = vNameArray as? [String] ?? [String]()
                    
                    if  vNameFilterArray.count > 0 {
                        self.dropDownVIewNew(arrayData: vNameFilterArray as? [String] ?? [String](), kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
                            self.dayOfAgeData[indexPath.row].name = selectedVal
                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
                            
                            UIView.performWithoutAnimation {
                                self.tableview.reloadData()
                            }
                        }
                        self.dropHiddenAndShow()
                    }
                    
                }
            }
            
            cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            
            return cell
        }
        return UITableViewCell() as! InovojectCell
    }
    
    // MARK: - Setup PE  Rerigator questions data Cell
    
    func setUpRerigatorQuesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RefrigatorQuesCell {
        
        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
        
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
                        
                        if(refri.isCheck ?? false){
                            cell.switchClicked(status: true)
                            cell.btn_Switch.setOn(true, animated: false)
                        }
                        else{
                            cell.switchClicked(status: false)
                            cell.btn_Switch.setOn(false, animated: false)
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
            
            let imageCount = assessment?.images as? [Int]
            let cnt = imageCount?.count
            let ttle = String(cnt ?? 0)
            cell.btn_ImageCount.setTitle(ttle,for: .normal)
            if ttle == "0"{
                cell.btn_ImageCount.isHidden = true
            } else {
                cell.btn_ImageCount.isHidden = false
            }
            
            let image1 = UIImage(named: "PEcomment.png")
            let image2 = UIImage(named: "PECommentSelected.png")
            if assessment?.note == "" || assessment?.note == nil {
                cell.btn_Comment.setImage(image1, for: .normal)
            } else {
                cell.btn_Comment.setImage(image2, for: .normal)
            }
            
            
            cell.btnNA  = {[unowned self] () in
                var switchisCheck = false
                let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
                refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
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
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:  "" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,schAssmentId:  Int(selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                    }
                    else{
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:  "" , value: 0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,schAssmentId:  Int(selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            
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
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,schAssmentId: Int(selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                    }
                    else{
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ??  "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,schAssmentId: Int(selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                    }
                    
                }
                cell.btn_NA.isSelected = !cell.btn_NA.isSelected
                
                refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
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
                assessment = assesmentArray[indexPath.row] as? PE_AssessmentInProgress
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
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: true,schAssmentId: Int(selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                    }
                    else {
                        var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                        let maxMarks = assessment?.assMaxScore ?? 0
                        result = result - Int(truncating: maxMarks)
                        self.selectedCategory?.catResultMark = result
                        assessment?.catResultMark = result as NSNumber
                        self.resultScoreLabel.text = String(result)
                        assessment?.assStatus = 0
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assessment?.assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assessment?.assID as! Int,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assessment?.assID as! NSNumber,  labelText: assessment?.assDetail1 ?? "", rollOut: "Y", unit:"" , value: 0.0,catID: assessment?.catID as! NSNumber,isCheck: false,isNA: true,schAssmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            
                        }
                    }
                    
                    if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                    }
                    else{
                        catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                    }
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
                        let image = UIImage(named: "PEcomment.png")
                        cell.btn_Comment.setImage(image, for: .normal)
                        
                    } else {
                        let image = UIImage(named: "PECommentSelected.png")
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
    // MARK: - Set Up Day Of Age Sub Cell
    func setupDayOfAgeSCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
            cell.config(data:dayOfAgeSData[indexPath.row],isDayOfAge:true)
            cell.imgDD.isHidden = true
            cell.btnDosage.isEnabled = true
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    cell.viewVaccineMan.isUserInteractionEnabled = false
                    cell.viewAmpleSize.isUserInteractionEnabled = false
                    cell.viewAmpleBag.isUserInteractionEnabled = false
                    cell.viewBagSize.isUserInteractionEnabled = false
                    cell.viewName.isUserInteractionEnabled = false
                    cell.viewDiluentManufacturer.isUserInteractionEnabled = false
                    cell.btnDosage.isUserInteractionEnabled = false
                    cell.btnVaccineName.isUserInteractionEnabled = false
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.ampuleSizeBtn.isUserInteractionEnabled = false
                    cell.dosageBtn.isUserInteractionEnabled = false
                }
                else{
                    cell.viewVaccineMan.isUserInteractionEnabled = true
                    cell.viewAmpleSize.isUserInteractionEnabled = true
                    cell.viewAmpleBag.isUserInteractionEnabled = true
                    cell.viewBagSize.isUserInteractionEnabled = true
                    cell.viewName.isUserInteractionEnabled = true
                    cell.viewDiluentManufacturer.isUserInteractionEnabled = true
                    cell.btnDosage.isUserInteractionEnabled = true
                    cell.btnVaccineName.isUserInteractionEnabled = true
                    cell.tfVaccineMan.isUserInteractionEnabled = false
                    cell.tfAmpleSize.isUserInteractionEnabled = false
                    cell.tfAmpleBag.isUserInteractionEnabled = false
                    cell.tfBagSize.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.tfDosage.isUserInteractionEnabled = false
                    cell.tfDiluentManu.isUserInteractionEnabled = false
                    cell.ampuleSizeBtn.isUserInteractionEnabled = true
                    cell.dosageBtn.isUserInteractionEnabled = true
                }
            }
            
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
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String]() , kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
                    
                    self.dayOfAgeSData[indexPath.row].ampuleSize = selectedVal
                    if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
                        self.ml = 0.0
                    }
                    else if self.peNewAssessment.dDDT?.lowercased().contains("1 gallon") ?? false {
                        self.ml = 3785.41
                    }else if self.peNewAssessment.dDDT?.lowercased().contains("2 gallon") ?? false {
                        self.ml = 7570.82
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("5 gallon") ?? false {
                        self.ml = 18927.05
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("2 litre") ?? false {
                        self.ml = 2000.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("2.4 litre") ?? false {
                        self.ml = 2400.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("2.8 litre") ?? false {  self.ml = 2800.00
                    }
                    
                    else if self.peNewAssessment.dDDT?.lowercased().contains("200 ml") ?? false {
                        self.ml = 200.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("300 ml") ?? false {
                        self.ml = 300.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("400 ml") ?? false {
                        self.ml = 400.00
                    } else if self.peNewAssessment.dDDT?.lowercased().contains("500 ml") ?? false {
                        self.ml = 500.00
                    }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
                        self.ml = 800.00
                    }
                    
                    let c = self.ml
                    if c == 0.0 {
                        self.dayOfAgeSData[indexPath.row].dosage = ""
                    }
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
                self.dropHiddenAndShow()
            }
            
            cell.amplePerBagCompletion  = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
                        
                        self.dayOfAgeSData[indexPath.row].ampulePerBag = selectedVal
                        if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
                            self.ml = 0.0
                        }
                        else if self.peNewAssessment.dDDT?.lowercased().contains("1 gallon") ?? false {
                            self.ml = 3785.41
                        }else if self.peNewAssessment.dDDT?.lowercased().contains("2 gallon") ?? false {
                            self.ml = 7570.82
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("5 gallon") ?? false {
                            self.ml = 18927.05
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("2 litre") ?? false {
                            self.ml = 2000.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("2.4 litre") ?? false {
                            self.ml = 2400.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("2.8 litre") ?? false {
                            self.ml = 2800.00
                        }else if self.peNewAssessment.dDDT?.lowercased().contains("200 ml") ?? false {
                            self.ml = 200.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("300 ml") ?? false {
                            self.ml = 300.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("400 ml") ?? false {
                            self.ml = 400.00
                        } else if self.peNewAssessment.dDDT?.lowercased().contains("500 ml") ?? false {
                            self.ml = 500.00
                        }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
                            self.ml = 800.00
                        }
                        let c = self.ml
                        if c == 0.0 {
                            self.dayOfAgeSData[indexPath.row].dosage = ""
                        }
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
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Dose")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "dose") as? NSArray ?? NSArray()
                let vNameFilterArray = vManufacutrerNameArray
            }
            
            cell.nameCompletion  = {[unowned self] ( text) in
                self.tableviewIndexPath = indexPath
                if text != "" {
                    self.dayOfAgeSData[indexPath.row].name = text
                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeSData[indexPath.row])
                    
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                } else {
                    var ManufacturerId = 0
                    var vManufacutrerNameArray = NSArray()
                    var vManufacutrerIDArray = NSArray()
                    var vManufacutrerDetailsArray = NSArray()
                    vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                    vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                    vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                    let xxx =    self.dayOfAgeSData[indexPath.row].vaccineMan ?? ""
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
                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 2)
                    vNameArray = vNameDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as?  NSArray ?? NSArray()
                    vNameIDArray = vNameDetailsArray.value(forKey: "id") as?  NSArray ?? NSArray()
                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as? NSArray ?? NSArray()
                    var x = -1
                    for obj in vNameMfgIdArray {
                        x = x + 1
                        if obj as? Int ??  0 == ManufacturerId
                        {
                            let indexOfd = vNameMfgIdArray.index(of: obj)
                            indexArray.append(x)
                        }
                    }
                    let indexOfA = vNameMfgIdArray.index(of: ManufacturerId)
                    for index in indexArray {
                        
                        let item = vNameArray[index] as? String ?? ""
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
            }
            DispatchQueue.main.async {
                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
            }
            return cell
        }
        return UITableViewCell() as! InovojectCell
    }
    // MARK: - Setup Customer Vaccine View
    func setCustomerVaccineView(_ tableView: UITableView , section:Int) -> PETableviewConsumerQualityHeader {
        if selectedCategory?.sequenceNoo == 3 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewConsumerQualityHeader" ) as! PETableviewConsumerQualityHeader
            
            headerView.nameMicro.text =  self.peNewAssessment.micro
            headerView.nameResidue.text =  self.peNewAssessment.residue
            
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    headerView.nameMicro.isUserInteractionEnabled = false
                    headerView.nameResidue.isUserInteractionEnabled = false
                }
                else
                {
                    headerView.nameMicro.isUserInteractionEnabled = true
                    headerView.nameResidue.isUserInteractionEnabled = true
                }
            }
            
            headerView.microComplete =
            {[unowned self] ( error) in
                self.peNewAssessment.micro  = error ?? ""
                CoreDataHandlerPE().updateDraftInDoGInProgressInDB(newAssessment: self.peNewAssessment)
                
            }
            headerView.residueComplete =
            {[unowned self] ( error) in
                self.peNewAssessment.residue  = error ?? ""
                
                CoreDataHandlerPE().updateDraftInDoGInProgressInDB(newAssessment: self.peNewAssessment)
            }
            return headerView as! PETableviewConsumerQualityHeader
        }
        return UIView() as! PETableviewConsumerQualityHeader
    }
    // MARK: - Setup PE Question In Tbale View Cell
    func setupPEQuestionTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PEQuestionTableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PEQuestionTableViewCell.identifier) as? PEQuestionTableViewCell{
            catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((self.selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
            var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
            cell.assessmentProgress = assessment
            
            if regionID != 3
            {
                if((assessment?.isAllowNA) ?? false ){
                    cell.btn_NA.isHidden = false
                    cell.lbl_NA.isHidden = false
                    let assID =  assessment?.assID ?? 0
                    if((assessment?.isNA) ?? false){
                        cell.btn_NA.isSelected = true
                        
                        if  assessment?.rollOut == "Y" && assessment?.sequenceNoo == 3  && assessment?.qSeqNo == 12{
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
            
            
            if(btn_NA.isSelected){
                cell.btn_NA.isUserInteractionEnabled = false
            }else{
                cell.btn_NA.isUserInteractionEnabled = true
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
            else {
                
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
                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                }else{
                    cell.txtQCCount.text =  assessment?.qcCount ?? ""
                    cell.showQcCountextField()
                    self.peNewAssessment.qcCount  = cell.txtQCCount.text
                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                    
                }
            } else if assessment?.rollOut == "Y" && assessment?.catName == "Miscellaneous" && assessment?.qSeqNo == 1
            {
                cell.txtQCCount.text =  assessment?.ampmValue ?? ""
                cell.showAMPMValuetextField()
                if(assessment?.isNA ?? false){
                    cell.txtQCCount.text =  "NA"
                    cell.showAMPMValuetextField()
                    self.peNewAssessment.ampmValue  = "NA"
                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                }else{
                    cell.txtQCCount.text =  assessment?.ampmValue ?? ""
                    cell.showAMPMValuetextField()
                    self.peNewAssessment.ampmValue  = cell.txtQCCount.text
                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
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
                self.peNewAssessment.ppmValue  = cell.txtQCCount.text
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            
            else {
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
//                cell.switchClicked(status: true)
                cell.switchBtn.setOn(true, animated: false)
            } else {
//                cell.switchClicked(status: false)
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
            let image1 = UIImage(named: "PEcomment.png")
            let image2 = UIImage(named: "PECommentSelected.png")
            if assessment?.note == "" || assessment?.note == nil {
                cell.noteBtn.setImage(image1, for: .normal)
            } else {
                cell.noteBtn.setImage(image2, for: .normal)
            }
            
            if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
            {
                cell.txtQCCount.isUserInteractionEnabled = false
                cell.txtPersonName.isUserInteractionEnabled = false
                cell.switchBtn.isUserInteractionEnabled = false
                cell.txtFrequency.isUserInteractionEnabled = false
                cell.cameraBTn.isUserInteractionEnabled = false
                cell.noteBtn.isUserInteractionEnabled = true
                cell.viewFrequency.isUserInteractionEnabled = false
                cell.btnImageCount.isUserInteractionEnabled = true
                cell.btnInfo.isUserInteractionEnabled = true
            }
            else
            {
                cell.txtQCCount.isUserInteractionEnabled = true
                cell.txtPersonName.isUserInteractionEnabled = true
                cell.switchBtn.isUserInteractionEnabled = true
                cell.txtFrequency.isUserInteractionEnabled = true
                cell.cameraBTn.isUserInteractionEnabled = true
                cell.noteBtn.isUserInteractionEnabled = true
                cell.viewFrequency.isUserInteractionEnabled = true
                cell.btnImageCount.isUserInteractionEnabled = true
                cell.btnInfo.isUserInteractionEnabled = true
            }
            
            cell.txtQCCountCompletion = {[unowned self] ( txt) in
                self.peNewAssessment.qcCount  = txt ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            
            cell.txtAMPMCompletion = {[unowned self] ( txt) in
                self.peNewAssessment.ampmValue  = txt ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            
            cell.txtNamePersonCompletion = {[unowned self] ( txt) in
                self.peNewAssessment.personName  = txt ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            
            cell.txtPPMCompletion = {[unowned self] ( txt) in
                self.peNewAssessment.ppmValue  = txt ?? ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
            }
            
            
            cell.btnFrequencyClickedCompletion = {[unowned self] ( error) in
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Frequency")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "frequencyName") as? NSArray ?? NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: cell.txtFrequency.frame.width, kAnchor: cell.txtFrequency, yheight: cell.txtFrequency.bounds.height) { [unowned self] selectedVal, index  in
                        cell.txtFrequency.text = selectedVal
                        self.peNewAssessment.frequency = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            cell.completion = { [unowned self] (status, error) in
                self.tableviewIndexPath = indexPath
                self.tableview.isUserInteractionEnabled = true
                textValue = Int(assessment?.ppmValue ?? "")
                if status ?? false {
                    
                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
                    let maxMarks =  assessment?.assMaxScore ?? 0
                    result = result + Int(truncating: maxMarks)
                    self.selectedCategory?.catResultMark = result
                    assessment?.catResultMark = result as NSNumber
                    self.resultScoreLabel.text = String(result)
                    assessment?.assStatus = 1
                    self.updateAssessmentInDb(assessment : assessment!)
                    
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
                
                self.updateScore(isAllNA: false)
                self.catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((self.selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                self.chechForLastCategory()
                self.tableview.isUserInteractionEnabled = true
            }
            cell.imagesCompletion  = {[unowned self] ( error) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "GroupImagesPEViewController") as? GroupImagesPEViewController
                self.refreshArray()
                assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                vc?.imagesArray = assessment?.images as? [Int] ?? [Int]()
                if vc != nil{
                    self.navigationController?.present(vc!, animated: false, completion: nil)
                }
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
                                self.resultScoreLabel.text = String(result)
                                self.totalScoreLabel.text = String(totalresult)
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
                                self.selectedCategory?.catResultMark = result
                                assessment?.catResultMark = result as NSNumber
                                self.resultScoreLabel.text = String(result)
                                assessment?.isNA = false
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
                                    self.resultScoreLabel.text = String(result)
                                    self.totalScoreLabel.text = String(totalresult)
                                }
                                
                            }
                            
                            if assessment?.sequenceNoo == 3 && assessment?.rollOut == "Y"{
                                cell.txtQCCount.text =  ""
                                cell.txtQCCount.isUserInteractionEnabled = true//false
                                self.peNewAssessment.qcCount  = ""
                                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                            }
                            if  assessment?.catName == "Miscellaneous" && assessment?.rollOut == "Y" {
                                cell.txtQCCount.text =  ""
                                cell.txtQCCount.isUserInteractionEnabled = true//false
                                self.peNewAssessment.ampmValue  = ""
                                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft: true)
                            }
                            
                            
                            if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                                catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((self.selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                            }
                            else{
                                catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((self.selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
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
                                self.selectedCategory?.catResultMark = result
                                newAssment?.catResultMark = result as NSNumber
                                self.resultScoreLabel.text = String(result)
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
                                self.resultScoreLabel.text = String(result)
                                assessment?.catResultMark = result as NSNumber
                                assessment?.isNA = true
                                cell.btn_NA.isSelected = true
                                cell.contentView.alpha = 0.3
                                cell.btnImageCount.isUserInteractionEnabled = false
                                cell.noteBtn.isUserInteractionEnabled = false
                                cell.cameraBTn.isUserInteractionEnabled = false
                                cell.assessmentLbl.isUserInteractionEnabled = false
                                cell.switchBtn.isUserInteractionEnabled = false
                                cell.btnInfo.isUserInteractionEnabled = false
                                cell.txtQCCount.isUserInteractionEnabled = false
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
                                cell.btn_NA.isSelected = true
                                cell.contentView.alpha = 0.3
                                cell.btnImageCount.isUserInteractionEnabled = false
                                cell.noteBtn.isUserInteractionEnabled = false
                                cell.cameraBTn.isUserInteractionEnabled = false
                                cell.assessmentLbl.isUserInteractionEnabled = false
                                cell.switchBtn.isUserInteractionEnabled = false
                                cell.btnInfo.isUserInteractionEnabled = false
                                cell.txtQCCount.isUserInteractionEnabled = false
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
                                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                            }
                            if  assessment?.catName == "Miscellaneous" && assessment?.rollOut == "Y"{
                                cell.txtQCCount.text =  "NA"
                                cell.txtQCCount.isUserInteractionEnabled = false
                                self.peNewAssessment.ampmValue  = "NA"
                                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                            }
                            
                            if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                                catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                                var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                            }
                            else{
                                catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                                var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
                            }
                            self.refreshTableView()
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
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    vc.editable = false
                    vc.commentCompleted = {[unowned self] ( note) in
                        
                    }
                    if vc.editable{
                        self.navigationController?.present(vc, animated: false, completion: nil)
                    }else{
                        if assessment?.note != nil && assessment?.note != ""{
                            self.navigationController?.present(vc, animated: false, completion: nil)
                        }
                    }
                } else {
                    vc.commentCompleted = {[unowned self] ( note) in
                        if note == "" {
                            let image = UIImage(named: "PEcomment.png")
                            cell.noteBtn.setImage(image, for: .normal)
                            
                        } else {
                            let image = UIImage(named: "PECommentSelected.png")
                            cell.noteBtn.setImage(image, for: .normal)
                            
                        }
                        assessment?.note = note
                        if assessment != nil{
                            self.updateNoteAssessmentInProgressPE(assessment : assessment!)
                        }
                    }
                    self.navigationController?.present(vc, animated: false, completion: nil)
                }
                
            }
            cell.cameraCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                
                var assessment = self.catArrayForTableIs[self.tableviewIndexPath.row] as? PE_AssessmentInProgress
                
                let images = CoreDataHandlerPE().getImagecountOfQuestion(assessment:assessment ?? PE_AssessmentInProgress(),fromDraft: true)
                if images < 5 {
                    self.takePhoto(cell.cameraBTn)
                } else {
                    self.showAlertForNoCamera()
                }
            }
            cell.infoCompletion = {[unowned self] ( error) in
                self.tableviewIndexPath = indexPath
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "InfoPEViewController") as? InfoPEViewController
                let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
                let boldMark1 =  "("
                let boldMark2 =  ") "
                let mrk = String(maxMarksIs)
                let str  =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
                vc?.questionDescriptionIs = str
                vc?.imageDataBase64 = assessment?.informationImage ?? ""
                vc?.infotextIs = assessment?.informationText ?? ""
                if vc != nil{
                    self.navigationController?.present(vc!, animated: false, completion: nil)
                }
            }
            return cell
        }
        return UITableViewCell() as! PEQuestionTableViewCell
    }
    
    // MARK: -  DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    // MARK: - Done Button With Date
    func doneButtonTappedWithDate(string: String, objDate: Date) {
        
        changedDate?(string)
    }
    // MARK: - Done Button TAbbed Function
    func doneButtonTapped(string:String){
        certificateData[tableviewIndexPath.row].certificateDate = string
        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id ?? 0)
        tableview.reloadData()
    }
    
    // MARK: - Show Date Picker
    func showDatePicker(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as? DatePickerPopupViewController
        datePickerPopupViewController?.delegate = self
        datePickerPopupViewController?.canSelectPreviousDate = false
        if datePickerPopupViewController != nil{
            navigationController?.present(datePickerPopupViewController!, animated: false, completion:
                                            nil)}
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
            let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
            
            refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
            let array =   CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
            if (section == 0)  {
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: RefrigatorTempProbeCell.identifier)as! RefrigatorTempProbeCell
                
                footerView.topValueTxtFld.delegate = self
                footerView.middleValueTxtFld.delegate = self
                footerView.bottomValueTxtFld.delegate = self
                footerView.mainTempUnit.isHidden = false
                footerView.topValueTxtFld.text = ""
                footerView.middleValueTxtFld.text = ""
                footerView.bottomValueTxtFld.text = ""
                
                if(btn_NA.isSelected && self.selctedNACategoryArray.contains(78)){
                    footerView.contentView.alpha = 0.3
                }
                else{
                    footerView.contentView.alpha = 1
                }
                var assessment = array[2] as? PE_AssessmentInProgress
                
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
                        let unit = i as! PE_Refrigators
                        if(unit.unit != ""){
                            footerView.main_UnitTextFld.text = unit.unit ?? ""
                        }
                        
                    }
                }
                footerView.mainTempUnitCompletion = { sender,txtfld ,textLabel in
                    var unitArray =  ["Celsius","Fahrenheit"]
                    if  unitArray.count > 0 {
                        self.dropDownVIewNew(arrayData: unitArray ?? [], kWidth: (sender ?? UIButton()).frame.width, kAnchor: sender ?? UIButton(), yheight: (sender ?? UIButton()).bounds.height) {  selectedVal,index  in
                            txtfld.text = selectedVal
                            CoreDataHandlerPE().updateUnitDraftRefrigatorInDB(Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0, unit: txtfld.text ?? "" )
                            self.refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
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
                            if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                                CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                                self.tableview.reloadData()
                                
                            }
                            else{
                                CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,schAssmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                                
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
                    if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                        CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "0.0") ?? 0.0 ,catID: self.selectedCategory?.catID as! NSNumber,isCheck: true,isNA: false,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        self.tableview.reloadData()
                        
                    }
                    else{
                        CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "0.0") ?? 0.0,catID: self.selectedCategory?.catID as! NSNumber,isCheck: true,isNA: false ,schAssmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
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
                if(btn_NA.isSelected && self.selctedNACategoryArray.contains(78)){
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
                            if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                                CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                            }
                            else{
                                CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: txtfld.text ?? "" , value: Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false,schAssmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
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
                    if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                        CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "") ?? 0.0 ,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                    }
                    else{
                        CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(value?.text ?? "") ?? 0.0 ,catID: 1,isCheck: true,isNA: false,schAssmentId: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                    }
                    
                }
                footerView.setGraddientAndLayerQcCountextFieldView()
                return footerView
            }
            else{
                let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FrezerFooterViewCell.identifier)as! FrezerFooterViewCell
                if(btn_NA.isSelected && self.selctedNACategoryArray.contains(78)){
                    footerView.contentView.alpha = 0.3
                }
                else{
                    footerView.contentView.alpha = 1
                    
                }
                
                footerView.textFieldView.text  = self.peNewAssessment.refrigeratorNote ?? ""
                footerView.noteCompletion = { textLabel in
                    
                    self.peNewAssessment.refrigeratorNote = textLabel ?? ""
                    UserDefaults.standard.set(textLabel ?? "", forKey:"re_note")
                    UserDefaults.standard.set(self.selectedCategory?.serverAssessmentId ,forKey:"assIID")
                    CoreDataHandlerPE().updateDraftRefriNoteAssessmentInProgress(text: textLabel ?? "")
                }
                footerView.setGraddientAndLayerQcCountextFieldView()
                return footerView
            }
        }
        
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
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
            if(btn_NA.isSelected ){
                headerView.contentView.alpha = 0.3
                
            }
            else{
                headerView.contentView.alpha = 1.0
            }
            
            return headerView
            
        }
        if selectedCategory?.sequenceNoo == 11 && section == 2 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"{
            let array =   CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SetFrezzerPointCell" ) as! SetFrezzerPointCell
            if(btn_NA.isSelected && self.selctedNACategoryArray.contains(78)){
                headerView.contentView.alpha = 0.3
            }
            else{
                headerView.contentView.alpha = 1.0
            }
            headerView.setGraddientAndLayerQcCountextFieldView()
            var assessment = array[2] as? PE_AssessmentInProgress
            var unitValue = ""
            var valueText = ""
            refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
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
                        if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                            CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0 ,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                        }
                        else{
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0,catID: assessment?.catID as! NSNumber,isCheck: true,isNA: false ,schAssmentId: self.selectedCategory?.assID ?? 0 )
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
                if(CoreDataHandlerPE().someDraftRefriEntityExists(id: assID as! Int)){
                    CoreDataHandlerPE().updateDraftRefrigatorInDB(assID as! Int,  labelText: textLabel, rollOut: "Y", unit: unitValue , value:  Double(valueText) ?? 0.0,catID: 1,isCheck: true,isNA: false ,serverAssessmentId: Int( self.selectedCategory?.serverAssessmentId ?? "0") ?? 0)
                }
                else{
                    CoreDataHandlerPE().saveDraftRefrigatorInDB(assID as! NSNumber,  labelText: textLabel, rollOut: "Y", unit: unitValue , value: Double(valueText) ?? 0.0 ,catID: 1,isCheck: true,isNA: false,schAssmentId: self.selectedCategory?.assID ?? 0)
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
                        
                        if regionID == 3
                        {
                            if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                            {
                                print("Test Message")
                            }
                            else
                            {
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
                                        }
                                    }
                                    
                                }
                                headerView.minusCompletion = {[unowned self] ( error) in
                                    
                                    if self.certificateData.count > 0 {
                                        let certificateData =  PECertificateData(id:0,name:"",date:"",isCertExpired: false,isReCert: false,vacOperatorId: 0, signatureImg: "", fsrSign: "")
                                        let lastItem = self.certificateData.last
                                        
                                        self.delVMixerInPEModule(peCertificateData: lastItem ?? certificateData)
                                        self.certificateData.removeLast()
                                    }
                                    if self.certificateData.count > 1 {
                                        
                                        UIView.performWithoutAnimation {
                                            self.tableview.reloadData()
                                            self.scrollToBottom(section:1)
                                        }
                                    } else {
                                        UIView.performWithoutAnimation {
                                            self.tableview.reloadData()
                                        }
                                    }
                                }
                                
                            }
                        }
                        else
                        {
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
                                    }
                                }
                                
                            }
                            headerView.minusCompletion = {[unowned self] ( error) in
                                
                                if self.certificateData.count > 0 {
                                    let certificateData =  PECertificateData(id:0,name:"",date:"",isCertExpired: false,isReCert: false,vacOperatorId: 0, signatureImg: "", fsrSign: "")
                                    let lastItem = self.certificateData.last
                                    
                                    self.delVMixerInPEModule(peCertificateData: lastItem ?? certificateData)
                                    self.certificateData.removeLast()
                                }
                                if self.certificateData.count > 1 {
                                    
                                    UIView.performWithoutAnimation {
                                        self.tableview.reloadData()
                                        self.scrollToBottom(section:1)
                                    }
                                } else {
                                    UIView.performWithoutAnimation {
                                        self.tableview.reloadData()
                                    }
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
    
    
    private func delVMixerInPEModule(peCertificateData:PECertificateData) {
        
        let imageCount = getVMixerCountInPEModule()
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if assessment != nil{
            CoreDataHandlerPE().subtractVMixerMinusCategortIsSelctedDraft(assessment: assessment!, doaId: peCertificateData.id ?? 0)
        }
        
        
    }
    
    
    
    func setPEInovojectHeaderFooterView(_ tableView: UITableView , section:Int) -> PEInovojectHeaderFooterView {
        if selectedCategory?.sequenceNoo == 1{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEInovojectHeaderFooterView" ) as! PEInovojectHeaderFooterView
            headerView.lblTitle.text = "In Ovo"
            headerView.txtCSize.text = peNewAssessment.iCS
            headerView.txtDType.text = peNewAssessment.iDT
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsText
            
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            headerView.setGraddientAndLayerAntibioticTextView()
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    headerView.btn1.isUserInteractionEnabled = false
                    headerView.switchHatchery.isUserInteractionEnabled = false
                    headerView.btn2.isUserInteractionEnabled = false
                    headerView.actionMinus.isUserInteractionEnabled = false
                    headerView.actionAdd.isUserInteractionEnabled = false
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = false
                }
                else{
                    headerView.btn1.isUserInteractionEnabled = true
                    headerView.switchHatchery.isUserInteractionEnabled = true
                    headerView.btn2.isUserInteractionEnabled = true
                    headerView.actionMinus.isUserInteractionEnabled = true
                    headerView.actionAdd.isUserInteractionEnabled  = true
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = true
                }
            }
            
            headerView.switchCompletion = {[unowned self] ( status) in
                
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromInvo: true)
            }
            
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                self.peNewAssessment.hatcheryAntibioticsText = txtAntiBioTic
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromInvo: true,fromDraft: true)
            }
            headerView.addCompletion =
            {[unowned self] ( error) in
                let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
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
                }
                self.scrollToBottom(section:2)
            }
            headerView.minusCompletion = {[unowned self] ( error) in
                if self.inovojectData.count > 0 {
                    let lastItem = self.inovojectData.last
                    if lastItem != nil{
                        self.deleteInovojectInPEModule(id: lastItem!.id ?? 0)
                    }
                    self.inovojectData.removeLast()
                    
                }
                if self.inovojectData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                    self.scrollToBottom(section:2)
                }  else {
                    
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgName") as? NSArray ??  NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgId") as? NSArray ??  NSArray()
                if  vManufacutrerNameArray.count > 0 {
                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as? [String] ?? [String](), kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.iDT = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                    }
                    self.dropHiddenAndShow()
                }
                
                
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeIDArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BagSizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as? NSArray ??  NSArray()
                bagSizeIDArray = bagSizeDetailsArray.value(forKey: "id") as? NSArray ??  NSArray()
                if  bagSizeArray.count > 0 {
                    self.dropDownVIewNew(arrayData: bagSizeArray as? [String] ??  [String](), kWidth: headerView.txtCSize.frame.width, kAnchor: headerView.txtCSize, yheight: headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.iCS = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                        self.updateDosageInvojectData(section: section)
                    }
                    self.dropHiddenAndShow()
                }
            }
            return headerView
        } else {
            return UIView() as! PEInovojectHeaderFooterView
        }
    }
    
    
    
    func setPEHeaderDayOfAge(_ tableView: UITableView , section:Int) -> PEHeaderDayOfAge {
        if selectedCategory?.sequenceNoo == 1{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
            headerView.lblTitle.text = "Day of Age Spray Application"
            headerView.txtCSize.text = peNewAssessment.dDT
            headerView.txtDType.text = peNewAssessment.dCS
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsDoaText
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    headerView.btn1.isUserInteractionEnabled = false
                    headerView.switchHatchery.isUserInteractionEnabled = false
                    headerView.btn2.isUserInteractionEnabled = false
                    headerView.actionMinus.isUserInteractionEnabled = false
                    headerView.actionAdd.isUserInteractionEnabled = false
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = false
                }
                else{
                    headerView.btn1.isUserInteractionEnabled = true
                    headerView.switchHatchery.isUserInteractionEnabled = true
                    headerView.btn2.isUserInteractionEnabled = true
                    headerView.actionMinus.isUserInteractionEnabled = true
                    headerView.actionAdd.isUserInteractionEnabled  = true
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = true
                }
            }
            
            
            let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
            if infoObj?.dayOfAgeTxtAntibiotic != ""{
            }
            
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
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoa: true,fromDraft:true)
            }
            
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                self.peNewAssessment.hatcheryAntibioticsDoaText = txtAntiBioTic
                PEInfoDAO.sharedInstance.saveData(userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "" , isExtendedPE: infoObj?.isExtendedPE ?? false, assessmentId: self.peNewAssessment?.serverAssessmentId ?? "", date: nil, subcutaneousTxt: infoObj?.subcutaneousAntibioticTxt, dayOfAgeTxt: txtAntiBioTic)
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoa: true,fromDraft:true)
                
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
                }
                self.scrollToBottom(section:3)
            }
            headerView.minusCompletion = {[unowned self] ( error) in
                if self.dayOfAgeData.count > 0 {
                    let lastItem = self.dayOfAgeData.last
                    if lastItem != nil{
                        self.deleteDOAInPEModule(id: lastItem!.id ?? 0)
                    }
                    self.dayOfAgeData.removeLast()
                }
                if self.dayOfAgeData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                    self.scrollToBottom(section:3)
                }  else {
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOADiluentType")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "diluentName") as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.dCS = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
                        
                    }
                    self.dropHiddenAndShow()
                }
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOASizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.dDT = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDraft:true)
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
        if selectedCategory?.sequenceNoo == 1 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
            headerView.lblTitle.text = "Day of Age Subcutaneous"
            headerView.txtCSize.text = peNewAssessment.dDDT
            headerView.txtDType.text = peNewAssessment.dDCS
            headerView.txtAntiBiotic.text = peNewAssessment.hatcheryAntibioticsDoaSText
            
            if regionID == 3
            {
                if peNewAssessment.isPERejected == false && peNewAssessment.isEMRejected == true
                {
                    headerView.btn1.isUserInteractionEnabled = false
                    headerView.switchHatchery.isUserInteractionEnabled = false
                    headerView.btn2.isUserInteractionEnabled = false
                    headerView.actionMinus.isUserInteractionEnabled = false
                    headerView.actionAdd.isUserInteractionEnabled = false
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = false
                }
                else{
                    headerView.btn1.isUserInteractionEnabled = true
                    headerView.switchHatchery.isUserInteractionEnabled = true
                    headerView.btn2.isUserInteractionEnabled = true
                    headerView.actionMinus.isUserInteractionEnabled = true
                    headerView.actionAdd.isUserInteractionEnabled  = true
                    headerView.txtDType.isUserInteractionEnabled = false
                    headerView.txtCSize.isUserInteractionEnabled = false
                    headerView.txtAntiBiotic.isUserInteractionEnabled = true
                }
                
            }
            
            
            let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: peNewAssessment.serverAssessmentId ?? "")
            if infoObj?.subcutaneousAntibioticTxt != ""{
            }
            
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
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true,fromDraft:true)
            }
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
            headerView.txtAntiBioticCompletion = {[unowned self] ( txtAntiBioTic) in
                self.peNewAssessment.hatcheryAntibioticsDoaSText = txtAntiBioTic
                PEInfoDAO.sharedInstance.saveData(userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "" , isExtendedPE: infoObj?.isExtendedPE ?? false, assessmentId: self.peNewAssessment?.serverAssessmentId ?? "", date: nil, subcutaneousTxt: txtAntiBioTic, dayOfAgeTxt: infoObj?.dayOfAgeTxtAntibiotic)
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true,fromDraft:true)
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
                }
                self.scrollToBottom(section:4)
            }
            headerView.minusCompletion = {[unowned self] (error) in
                if self.dayOfAgeSData.count > 0 {
                    let lastItem = self.dayOfAgeSData.last
                    if lastItem != nil{
                        self.deleteDOAInPEModule(id: lastItem!.id ?? 0,fromDoaS : true)
                        
                        self.dayOfAgeSData.removeLast()
                    }
                }
                if self.dayOfAgeSData.count > 1 {
                    UIView.performWithoutAnimation {
                        self.tableview.reloadData()
                    }
                    self.scrollToBottom(section:4)
                }  else {
                    self.tableview.reloadData()
                }
            }
            
            headerView.dTypeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOADiluentType")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "diluentName") as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtDType.text = selectedVal
                        self.peNewAssessment.dDCS = selectedVal
                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true,fromDraft:true)
                        
                    }
                    self.dropHiddenAndShow()
                }
            }
            headerView.cSizeCompletion = {[unowned self] ( error) in
                var bagSizeArray = NSArray()
                var bagSizeDetailsArray = NSArray()
                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DOASizes")
                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as? NSArray ?? NSArray()
                if  bagSizeArray.count > 0 {
                    let arr = bagSizeArray as? [String] ?? []
                    self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
                        headerView.txtCSize.text = selectedVal
                        self.peNewAssessment.dDDT = selectedVal
                        self.updateDosageDayOfAgeDataS(section: section)
                        
                    }
                    self.dropHiddenAndShow()
                }
            }
            
            return headerView
        } else {
            return UIView() as! PEHeaderDayOfAge
        }
    }
    
    
    
    func updateDosageDayOfAgeDataS(section:Int)  {
        if self.peNewAssessment.dDDT?.lowercased().contains("unknown") ?? false {
            self.ml = 0.0
        }
        else if self.peNewAssessment.dDDT?.lowercased().contains("1 gallon") ?? false {
            self.ml = 3785.41
        }else if self.peNewAssessment.dDDT?.lowercased().contains("2 gallon") ?? false {
            self.ml = 7570.82
        } else if self.peNewAssessment.dDDT?.lowercased().contains("5 gallon") ?? false {
            self.ml = 18927.05
        } else if self.peNewAssessment.dDDT?.lowercased().contains("2 litre") ?? false {
            self.ml = 2000.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains("2.4 litre") ?? false {
            self.ml = 2400.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains("2.8 litre") ?? false {
            self.ml = 2800.00
        }
        else if self.peNewAssessment.dDDT?.lowercased().contains("200 ml") ?? false {
            self.ml = 200.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains("300 ml") ?? false {
            self.ml = 300.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains("400 ml") ?? false {
            self.ml = 400.00
        } else if self.peNewAssessment.dDDT?.lowercased().contains("500 ml") ?? false {
            self.ml = 500.00
        }else if self.peNewAssessment.dDDT?.lowercased().contains("800 ml") ?? false {
            self.ml = 800.00
        }
        let c = self.ml
        if c == 0.0 {
            
        }
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
                }
                else
                {
                    obj.dosage = "\(Double(round(1000 * z) / 1000))"
                }
                
            }else{
                obj.dosage = ""
            }
            
            
            CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment,fromDoaS: true,fromDraft: true)
            UIView.performWithoutAnimation {
                self.tableview.reloadData()
            }
        }
    }
    // MARK: - Update Doasge Inovoject Data
    func updateDosageInvojectData(section:Int)  {
        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
        if c == 0 {
            self.showtoast(message: "Incomplete Data")
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
                    obj.dosage = "\(Double(round(1000 * z) / 1000))"
                }
            }
            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
            UIView.performWithoutAnimation {
                self.tableview.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(selectedCategory?.sequenceNoo == 11 && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
            if(section == 2) {
                return 100
            }
        }
        else{
            if section > 0 {
                if selectedCategory?.sequenceNoo == 1{
                    return 95.0
                }
                if selectedCategory?.sequenceNoo == 3{
                    return 95.0
                }
            }else{
                if  selectedCategory?.sequenceNoo == 12{
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
                        row: self.dayOfAgeSData
                            .count - 1 ,
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
                        row: self.dayOfAgeSData
                            .count - 1 ,
                        section:3)
                }
            }
            self.tableview.scrollToRow(at: indexPathOfTab, at: .none, animated: false)
        }
    }
    // MARK: - Update Assessment In DB
    func updateAssessmentInDb(assessment:PE_AssessmentInProgress) {
        CoreDataHandlerPE().updateDraftCatDetailsForStatus(assessment:assessment)
    }
    // MARK: - Update Assessment Note In DB
    func updateNoteAssessmentInProgressPE(assessment:PE_AssessmentInProgress) -> Bool {
        var status = CoreDataHandlerPE().updateDraftNoteAssessmentInProgress(assessment:assessment)
        return status
    }
    // MARK: - Update Category in DB
    func updateCategoryInDb(assessment:PENewAssessment) -> Bool {
        var status = CoreDataHandlerPE().updateDraftCategortIsSelcted(assessment:assessment)
        return status
    }
}
// MARK: - PE Draft Assessment Finalize & Collection View Delegates
extension PEDraftAssesmentFinalize : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catArrayForCollectionIs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewIDPE", for: indexPath as IndexPath) as! PECategoryCell
        cell.imageview.image = UIImage(named: "tabUnselect")!
        let category = catArrayForCollectionIs[indexPath.row]
        if let isSelected = selectedCategory?.catISSelected {
            if selectedCategory?.sequenceNo == category.sequenceNo{
                
                if isSelected == 1{
                    cell.imageview.image =  UIImage(named: "tabSelect")!
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
        if catArrayForCollectionIs.count == 6{
            if indexPath.row == 3{
                return CGSize(width: 146, height: 68)
            } else if indexPath.row == 4{
                return CGSize(width: 126, height: 68)
            }else{
                return CGSize(width: 136, height: 68)
            }
        }else{
            if indexPath.row == 3{
                return CGSize(width: 171, height: 68)
            } else if indexPath.row == 4{
                return CGSize(width: 151, height: 68)
            }else{
                return CGSize(width: 161, height: 68)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        peNewAssessment = CoreDataHandlerPE().getSavedDraftOnGoingAssessmentPEObject()
        
        finishingAssessment = false
        forInovo = false
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
                if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                    lblextenderMicro.isHidden = true
                    extendedMicroSwitch.isHidden = true
                    extendedMicroSwitch.isUserInteractionEnabled = false
                    catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                    for i in catArrayForTableIs{
                        let refri =   i as! PE_AssessmentInProgress
                        if(!CoreDataHandlerPE().checkDraftSameAssesmentEntityExists(id: refri.assID as! Int,serverAssessmentId: Int(refri.serverAssessmentId ?? "0") ?? 0)){
                            CoreDataHandlerPE().saveDraftRefrigatorInDB(refri.assID as! NSNumber,  labelText:  "", rollOut: "Y", unit:  "Celsius" , value: 0.0,catID: refri.catID as! NSNumber,isCheck: false,isNA: false,schAssmentId: Int(refri.serverAssessmentId ?? "0") ?? 0)
                        }
                        
                    }
                    if(catArrayForTableIs.count > 0){
                        let refri = catArrayForTableIs[0] as! PE_AssessmentInProgress
                        refrigtorProbeArray = CoreDataHandlerPE().getDraftREfriData(id: Int(refri.serverAssessmentId ?? "0") ?? 0)
                    }
                    
                    
                }
                if(selectedCategory?.catName == "Extended Microbial"){
                    selectedCategory?.sequenceNoo = 12
                    lblextenderMicro.isHidden = false
                    extendedMicroSwitch.isHidden = false
                    extendedMicroSwitch.isUserInteractionEnabled = true
                    if self.peNewAssessment.IsEMRequested == false {
                        self.extendedMicroSwitch.isOn = false
                        UserDefaults.standard.set(false, forKey:"ExtendedMicro")
                        
                    } else {
                        self.extendedMicroSwitch.isOn = true
                        UserDefaults.standard.set(true, forKey:"ExtendedMicro")
                        
                    }
                }
                else{
                    lblextenderMicro.isHidden = true
                    extendedMicroSwitch.isHidden = true
                    extendedMicroSwitch.isUserInteractionEnabled = false
                    catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((selectedCategory?.sequenceNo ?? 0) as NSNumber,peNewAssessment: self.peNewAssessment)
                    if(checkCategoryisNA()){
                        self.btn_NA.isSelected = true
                        updateScore(isAllNA: true )
                    }
                    else{
                        self.btn_NA.isSelected = false
                        updateScore(isAllNA: false)
                    }
                }
                
                tableview.reloadData()
                
                let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
                if regionID != 3
                {
                    if(selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen"){
                        showHideNA(sequenceNoo: selectedCategory?.sequenceNoo ?? 0,catName: selectedCategory?.catName ?? "")
                    }
                    else{
                        showHideNA(sequenceNoo: selectedCategory?.sequenceNoo ?? 0, catName: selectedCategory?.catName ?? "")
                    }
                }
                refreshTableView()
            }
        }
        
    }
    
    func checkNoteForEveryQuestion() -> Bool{
        self.refreshArray()
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            if assessment?.assStatus == 0 && assessment?.isNA == false{
                if assessment?.note?.count ?? 0 < 1 {
                    if regionID == 3
                    {
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
            catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((2) as NSNumber,peNewAssessment: self.peNewAssessment)
            
            for  obj in catArrayForTableIs {
                let assessment = obj as? PE_AssessmentInProgress
                
                if assessment?.assStatus == 1 && assessment?.assID == 5  {
                    if assessment?.note?.count ?? 0 < 1 {
                        
                        if strings.contains("Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccine Application")
                        {
                            strings = strings.filter { $0 != "Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccine Application" }
                        }
                        if regionID == 3 {
                            strings.append("Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccine Application")
                        }
                        else
                        {
                            return true
                        }
                    }
                    else
                    {
                        if regionID == 3 {
                            
                            if strings.contains("Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccine Application")
                            {
                                strings = strings.filter { $0 != "Please enter comment for (Thaw bath temp) in Aseptic Technique & Vaccine Application" }
                            }
                        }
                        
                    }
                }
                
                else if assessment?.assStatus == 1 && assessment?.assID == 9 {
                    if assessment?.note?.count ?? 0 < 1 {
                        
                        if strings.contains("Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application")
                        {
                            strings = strings.filter { $0 != "Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application" }
                        }
                        if regionID == 3 {
                            
                            strings.append("Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application")
                            
                        }
                        else
                        {
                            return true
                        }
                        
                    }
                    else
                    {
                        if regionID == 3 {
                            if strings.contains("Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application")
                            {
                                strings = strings.filter { $0 != "Please enter comment for (Vaccine thawing time) in Aseptic Technique & Vaccine Application" }
                            }
                        }
                    }
                }
                
            }
            
        }
        
        if forInovo == true
        {
            catArrayForTableIs = CoreDataHandlerPE().fetchDraftCustomerWithCatID((5) as NSNumber,peNewAssessment: self.peNewAssessment)
            
            for  obj in catArrayForTableIs {
                let assessment = obj as? PE_AssessmentInProgress
                
            }
            
            
        }
        
        return true
    }
    
    // MARK: - Show Alert for Asseptic Note
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
    
    // MARK: - Check Category
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
    // MARK: - Check NA Updated Score
    func checkNAAndUpdateScore(){
        self.refreshArray()
        var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
        var totalresult = Int(self.totalScoreLabel.text ?? "0") ?? 0
        for  obj in catArrayForTableIs {
            let assessment = obj as? PE_AssessmentInProgress
            let maxMarks =  assessment?.assMaxScore ?? 0
            if assessment?.isNA == true{
                
                if(assessment?.assStatus != 1){
                    self.selectedCategory?.catResultMark = result
                    assessment?.catResultMark = result as NSNumber
                    self.resultScoreLabel.text = String(result)
                    totalresult = totalresult - Int(truncating: maxMarks)
                    self.selectedCategory?.catMaxMark = totalresult
                    assessment?.catMaxMark = totalresult as NSNumber
                    self.totalScoreLabel.text = String(totalresult)
                    self.updateAssessmentInDb(assessment : assessment!)
                    
                }
                else{
                    result = result - Int(truncating: maxMarks)
                    self.selectedCategory?.catResultMark = result
                    assessment?.catResultMark = result as NSNumber
                    self.resultScoreLabel.text = String(result)
                    totalresult = totalresult - Int(truncating: maxMarks)
                    self.selectedCategory?.catMaxMark = totalresult
                    assessment?.catMaxMark = totalresult as NSNumber
                    self.totalScoreLabel.text = String(totalresult)
                    self.updateAssessmentInDb(assessment : assessment!)
                    
                }
            }
            else{
                if(assessment?.assStatus != 1){
                    self.selectedCategory?.catResultMark = result
                    assessment?.catResultMark = result as NSNumber
                    self.resultScoreLabel.text = String(result)
                    totalresult = totalresult + Int(truncating: maxMarks)
                    self.selectedCategory?.catMaxMark = totalresult
                    assessment?.catMaxMark = totalresult as NSNumber
                    self.totalScoreLabel.text = String(totalresult)
                    self.updateAssessmentInDb(assessment : assessment!)
                }
                else{
                    result = result + Int(truncating: maxMarks)
                    self.selectedCategory?.catResultMark = result
                    assessment?.catResultMark = result as NSNumber
                    self.resultScoreLabel.text = String(result)
                    totalresult = totalresult + Int(truncating: maxMarks)
                    self.selectedCategory?.catMaxMark = totalresult
                    assessment?.catMaxMark = totalresult as NSNumber
                    self.totalScoreLabel.text = String(totalresult)
                    self.updateAssessmentInDb(assessment : assessment!)
                }
            }
            
        }
        
    }
    
    // MARK: - Set All Question to NA
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
    
    
    // MARK: - Set All Question to Non NA
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
    
    // MARK: - Show Hide NA
    func showHideNA(sequenceNoo:Int,catName:String){
        
        if( sequenceNoo == 11 && catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen" ){
            lbl_NA.isHidden = true
            btn_NA.isHidden = true
            scoreParentView.isHidden = true
        }
        else if(sequenceNoo == 1 || sequenceNoo == 2){
            lbl_NA.isHidden = true
            btn_NA.isHidden = true
            scoreParentView.isHidden = false
        }
        else{
            lbl_NA.isHidden = false
            btn_NA.isHidden = false
            scoreParentView.isHidden = false
        }
    }
    
    // MARK: - Check For Last Category
    func chechForLastCategory(){
        var  peNewAssessmentArray = CoreDataHandlerPE().getDraftOnGoingAssessmentArrayPEObject()
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
                if cat.sequenceNo == selectedCategory?.sequenceNo {
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
}

// MARK: - Extension PE Draft Assesment Finalize
extension PEDraftAssesmentFinalize{
    
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

// MARK: - ************ Camera Button Action ***************************************/
extension PEDraftAssesmentFinalize: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    @objc func takePhoto(_ sender: UIButton) {
        
        /*************** Intilzing Camera Delegate Methods **********************************/
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: {print("Test message")})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
        /****************************************************************************************/
        //  }
        
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
        //                    present(imagePicker, animated: true, completion: {})
        //
        //
        //                }
        
    }
    
    /************* Alert View Methods ***********************************/
    
    func postAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /**************************************************************************************************/
    
    // MARK: - ****************************  Image Picker Delegate Methods ***************************************/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let pickedImage: UIImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]) as? UIImage {
            let imageData = pickedImage.jpegData(compressionQuality: 0.02)
            saveImageInPEModule(imageData:imageData!)
            self.refreshArray()
            var Newassessment = PE_AssessmentInProgress()
            if(selectedCategory?.sequenceNoo == 11){
                Newassessment = self.refriCamerAssesment[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
            }else{
                Newassessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
            }
            if let cell = tableview.cellForRow(at: tableviewIndexPath) as? PEQuestionTableViewCell {
                let imageCount = Newassessment.images as? [Int]
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
                let imageCount = Newassessment.images as? [Int]
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
        imagePicker.dismiss(animated: true, completion: {
            print("test message")
        })
    }
    /******************************************************************************************************/
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: {
            
        })
    }
    
    // MARK: - Save Image In PE Module
    private func saveImageInPEModule(imageData:Data){
        let imageCount = getImageCountInPEModule()
        var assessment = PE_AssessmentInProgress()
        if(selectedCategory?.sequenceNoo == 11){
            assessment = self.refriCamerAssesment[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
        }else{
            assessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
        }
        CoreDataHandlerPE().saveImageInPEModule(assessment: assessment, imageId: imageCount+1, imageData: imageData,fromDraft: true)
    }
    // MARK: - Update Is NA
    func update_isNA(assessment:PE_AssessmentInProgress){
        CoreDataHandlerPE().updateDraft_ISNA_AssessmentInProgress(assessment: assessment)
    }
    // MARK: -  get Images Count In PE Assessment
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
    
    // MARK: - Save DOA in PE Module
    private func saveDOAInPEModule(inovojectData:InovojectData,fromDoaS:Bool?=false) -> Int{
        let imageCount = getDOACountInPEModule()
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if assessment != nil{
            CoreDataHandlerPE().saveDOAPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData,fromDoaS:fromDoaS,fromDraft: true)
        }
        return imageCount+1
        
    }
    // MARK: - SAve Inovoject PE Module
    private func saveInovojectInPEModule(inovojectData:InovojectData) -> Int{
        
        let imageCount = getDOACountInPEModule()
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if  assessment != nil{
            CoreDataHandlerPE().saveInovojectPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData,fromDraft:true)
        }
        return imageCount+1
        
    }
    
    // MARK: - Save Vaccine Mixture In PE Module
    private func saveVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
        
        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        let imageCount = getVMixerCountInPEModule()
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if  assessment != nil{
            CoreDataHandlerPE().saveDraftVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
        }
        return imageCount+1
        
    }
    
    private func saveMinusVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
        
        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        let imageCount = getVMixerCountInPEModule()
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if  assessment != nil{
            CoreDataHandlerPE().saveMinusDraftVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
        }
        return imageCount+1
        
    }
    
    // MARK: - Save Draft Vaccine Mixture in PE Module
    private func savedraftVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
        
        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
        let imageCount = getVMixerCountInPEModule()
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if assessment != nil{
            CoreDataHandlerPE().saveDraftVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
        }
        return imageCount+1
        
    }
    
    // MARK: - Get DOA Count In PE Module
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
    
    // MARK: - Get Vaccine Mixture Count
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
    
    
    // MARK: - Delete DOA in PE Module
    private func deleteDOAInPEModule(id:Int,fromDoaS:Bool? = false) {
        
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if assessment != nil{
            CoreDataHandlerPE().updateDOAMinusCategortIsSelcted(assessment: assessment!, doaId: id,fromDraft:true, fromDoaS : fromDoaS)
        }
    }
    
    // MARK: - Delete Inovoject in PE Module
    private func deleteInovojectInPEModule(id:Int) {
        
        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        if assessment != nil{
            CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId:
                                                                        id,fromDraft: true)
        }
        
    }
    // MARK: - Delete Vaccine Mixture in PE Module
    private func deleteDraftVMixerInPEModule(id:Int) {
        
        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
        CoreDataHandlerPE().updateDraftVMixerMinusCategortIsSelcted(assessment: assessment ?? PE_AssessmentInProgress(), doaId: id)
        
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

// MARK: - Extension PE Draft Assesment Finalize , Delegates of Image Picker & Text field
extension PEDraftAssesmentFinalize: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    // MARK: - Save Value In Text Fields
    func setValueInTextFields(selectedValue: String, certDateBtn: UIButton, clickedField: UITextField, cell: VaccineMixerCell, view: UIView? = nil){
        let indices = dataArray.firstIndex(of: selectedValue)
        if let indices = indices {
            
            if selectedValue != "" {
                clickedField.text = selectedValue
            }
            cell.certDateSelectBtn.setTitleColor(UIColor.black, for: .normal)
            if selectedValue != "" {
                cell.certDateSelectBtn.setTitle(certDateArray[indices], for: .normal)
                
            }
            else {
                let date =   Date.getCurrentDateNow()
                cell.certDateSelectBtn.setTitle(date, for: .normal)
            }
            if selectedValue != "" {
                if isCertExpiredArray[indices]{
                    cell.certDateSelectBtn.layer.borderColor = UIColor.red.cgColor
                    dateBlock?(certDateArray[indices],true , true , clickedField.tag )
                }else{
                    cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                    dateBlock?(certDateArray[indices], false , false , clickedField.tag)
                }
            }
            else {
                cell.certDateSelectBtn.layer.borderColor = UIColor(red: 0.0, green: 200.0, blue: 226.0, alpha: 1.0).cgColor
                dateBlock?(certDateArray[indices] , false ,false , clickedField.tag)
            }
        }
        else {
            print("test message")
        }
    }
    // MARK: - Set Drop Down
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
        return self.dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = tableview.viewWithTag(pickerView.tag) as? VaccineMixerCell
        cell?.vaccNameField.text = self.dataArray[row]
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen") {
            self.tableview.isScrollEnabled = false
        }
        else{
            let cell = textField.superview?.superview?.superview?.superview as! VaccineMixerCell
            self.setDropdrown(cell.vaccSelectBtn, certBtn: cell.certDateSelectBtn, clickedField: cell.vaccNameField, dropDownArr: dataArray, cell: cell)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen") {
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
                }
            }
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if( selectedCategory?.sequenceNoo == 11   && selectedCategory?.catName == "Refrigerator\n/Freezer\n/Liquid Nitrogen") {
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

