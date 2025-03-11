//
//
//
//
//
//
////
////  PEAssesmentFinalize.swift
////  Zoetis -Feathers
////
////  Created by "" ""on 13/12/19.
////  Copyright © 2019  . All rights reserved.
////
//
//
//import UIKit
//import SwiftyJSON
//
//struct Rational {
//    let numerator : Int
//    let denominator: Int
//
//    init(numerator: Int, denominator: Int) {
//        self.numerator = numerator
//        self.denominator = denominator
//    }
//
//    init(approximating x0: Double, withPrecision eps: Double = 1.0E-6) {
//        var x = x0
//        var a = x.rounded(.down)
//        var (h1, k1, h, k) = (1, 0, Int(a), 1)
//
//        while x - a > eps * Double(k) * Double(k) {
//            x = 1.0/(x - a)
//            a = x.rounded(.down)
//            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
//        }
//        self.init(numerator: h, denominator: k)
//    }
//}
//
//protocol PECategorySelectionDelegate {
//    func selectedAssessmentId(selectedId: Int, selectedArr:[[String : AnyObject]])
//}
//
//class PEAssesmentFinalize: BaseViewController , DatePickerPopupViewControllerProtocol {
//    let imagePicker: UIImagePickerController! = UIImagePickerController()
//    @IBOutlet weak var buttonFinishAssessment: PESubmitButton!
//    @IBOutlet weak var buttonSaveAsDraft: PESubmitButton!
//    @IBOutlet weak var buttonSaveAsDraftInitial: PESubmitButton!
//    @IBOutlet weak var assessmentDateText: PEFormTextfield!
//    @IBOutlet weak var headerView: UIView!
//    var peHeaderViewController:PEHeaderViewController!
//    var peNewAssessment:PENewAssessment!
//    var dropdownManager = ZoetisDropdownShared.sharedInstance
//    var delegate: PECategorySelectionDelegate? = nil
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var resultScoreLabel: UILabel!
//    @IBOutlet weak var totalScoreLabel: UILabel!
//    @IBOutlet fileprivate weak var tableview: UITableView!
//    @IBOutlet weak var selectedCustomer: PEFormLabel!
//    @IBOutlet weak var selectedComplex: PEFormLabel!
//    var currentArr : [AssessmentQuestions] = []
//    var selectedCategory : PENewAssessment?
//    var collectionviewIndexPath = IndexPath(row: 0, section: 0)
//    @IBOutlet weak var scoreGradientView: UIView!
//    @IBOutlet weak var customerGradientView: UIView!
//    @IBOutlet weak var scoreParentView: UIView!
//    @IBOutlet weak var scoreView: UIView!
//    @IBOutlet weak var coustomerView: UIView!
//    var jsonRe : JSON = JSON()
//
//    var ml = 0.0
//    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
//    var tableviewIndexPath = IndexPath(row: 0, section: 0)
//    var catArrayForCollectionIs : [PENewAssessment] = []
//    var catArrayForTableIs = NSArray()
//    @IBOutlet weak var bckButton: PESubmitButton!
//    var switchA = 0
//    var switchB = 0
//    var certificateData : [PECertificateData] = []
//    var inovojectData : [InovojectData] = []
//    var dayOfAgeData : [InovojectData] = []
//
//    override func viewWillAppear(_ animated: Bool) {
//
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        navigationController?.navigationBar.isHidden = false
//    }
//
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//        let keyboardFrame = keyboardSize.cgRectValue
//
//        if self.view.bounds.origin.y == 0{
//            self.view.bounds.origin.y += keyboardFrame.height
//        }
//        tableview.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
//
//    }
//
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.bounds.origin.y != 0 {
//            self.view.bounds.origin.y = 0
//        }
//        tableview.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
//
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//
//    @IBAction func backButton(_ sender: Any) {
//        cleanSessionAndMoveTOStart()
//    }
//
//    private func cleanSessionAndMoveTOStart(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PEStartNewAssessment") as! PEStartNewAssessment
//        vc.isFromBack = true
//        navigationController?.pushViewController(vc, animated: false)
//    }
//
//    @IBAction func btnAction(_ sender: Any) {
//
//    }
//
//    override func viewDidLoad() {
//
//        peHeaderViewController = PEHeaderViewController()
//        peHeaderViewController.titleOfHeader = "Assessment"
//        self.headerView.addSubview(peHeaderViewController.view)
//        self.topviewConstraint(vwTop: peHeaderViewController.view)
//        peNewAssessment = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
//        let seq_Number = allAssesmentArr.value(forKey: "sequenceNo")  as? NSArray ?? NSArray()
//        var catArray : NSArray = NSArray()
//        var  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject()
//        var carColIdArray : [Int] = []
//        var carTabIdArray : [Int] = []
//        var row = 0
//        for cat in peNewAssessmentArray {
//            if !carColIdArray.contains(cat.sequenceNo!){
//                carColIdArray.append(cat.sequenceNo!)
//                catArrayForCollectionIs.append(cat)
//            }
//        }
//        for cat in catArrayForCollectionIs{
//            if cat.doa.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.doa {
//                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
//                    if data != nil {
//                        if idArr.contains(data!.id!){
//                            //   print("already there",idArr)
//                        }else{
//                            //   print("new",idArr)
//                            idArr.append(data!.id!)
//                            dayOfAgeData.append(data!)
//                        }
//                    }
//                }
//            }
//        }
//
//        for cat in catArrayForCollectionIs{
//            if cat.inovoject.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.inovoject {
//                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
//                    if idArr.contains(data!.id!){
//                        //   print("already there",idArr)
//                    }else{
//                        //   print("new",idArr)
//                        idArr.append(data!.id!)
//                        inovojectData.append(data!)
//                    }
//                }
//            }
//        }
//
//
//        for cat in catArrayForCollectionIs{
//            if cat.vMixer.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.vMixer {
//                    let data = CoreDataHandlerPE().getCertificateData(doaId: obj)
//                    if idArr.contains(data!.id!){
//                        //   print("already there",idArr)
//                    }else{
//                        //   print("new",idArr)
//                        idArr.append(data!.id!)
//
//                        certificateData.append(data!)
//                    }
//                }
//            }
//        }
//
//        if certificateData.count > 0 {
//                  self.certificateData =  self.certificateData.sorted(by: {
//                      let id1 = $0.id as? Int ?? 0
//                      let id2 = $1.id as? Int ?? 0
//                      return id1 < id2
//                  })
//
//              }
//
//
//
//        for cat in catArrayForCollectionIs {
//            if cat.catISSelected == 1 {
//                row = cat.sequenceNo! - 1
//                selectedCategory = cat
//            }
//        }
//        if  selectedCategory?.evaluationDate?.count == nil {
//            selectedCategory = catArrayForCollectionIs.first
//        }
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as! NSNumber)
//        super.viewDidLoad()
//        tableview.register(PEQuestionTableViewCell.nib, forCellReuseIdentifier: PEQuestionTableViewCell.identifier)
//        tableview.register(CrewInformationCell.nib, forCellReuseIdentifier: CrewInformationCell.identifier)
//        tableview.register(InovojectCell.nib, forCellReuseIdentifier: InovojectCell.identifier)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        if selectedCategory?.evaluationName == "Non-Inject Process Evaluation" {
//            row = 0
//            selectedCategory = catArrayForCollectionIs[0]
//        }
//        collectionView.reloadData()
//        collectionviewIndexPath = IndexPath(row: row, section: 0)
//        selectinitialCell()
//        collectionView(collectionView, didSelectItemAt: collectionviewIndexPath)
//        selectedComplex.text = catArrayForCollectionIs.first?.siteName
//        selectedCustomer.text = catArrayForCollectionIs.first?.customerName
//        assessmentDateText.text =  catArrayForCollectionIs.first?.evaluationDate
//        chechForLastCategory()
//        setupUI()
//    }
//
//    func setupUI(){
//        let nibCatchers = UINib(nibName: "PETableviewHeaderFooterView", bundle: nil)
//        tableview.register(nibCatchers, forHeaderFooterViewReuseIdentifier: "PETableviewHeaderFooterView")
//        let nibCas = UINib(nibName: "PEInovojectHeaderFooterView", bundle: nil)
//        tableview.register(nibCas, forHeaderFooterViewReuseIdentifier: "PEInovojectHeaderFooterView")
//        let nibCasa = UINib(nibName: "PEHeaderDayOfAge", bundle: nil)
//        tableview.register(nibCasa, forHeaderFooterViewReuseIdentifier: "PEHeaderDayOfAge")
//        let peTableviewConsumerQualityHeader = UINib(nibName: "PETableviewConsumerQualityHeader", bundle: nil)
//        tableview.register(peTableviewConsumerQualityHeader, forHeaderFooterViewReuseIdentifier: "PETableviewConsumerQualityHeader")
//
//
//        coustomerView.setCornerRadiusFloat(radius: 24)
//        customerGradientView.setCornerRadiusFloat(radius: 24)
//        DispatchQueue.main.async {
//            self.customerGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            self.scoreGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//
//        }
//        scoreParentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
//        buttonFinishAssessment.setNextButtonUI()
//        buttonSaveAsDraft.setNextButtonUI()
//        buttonSaveAsDraftInitial.setNextButtonUI()
//    }
//
//
//    func refreshTableView(){
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as! NSNumber)
//        tableview.reloadData()
//    }
//
//    func refreshArray(){
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as! NSNumber)
//
//    }
//
//
//    func filterCategory()  {
//        var peCategoryFilteredArray: [PECategory] =  []
//        for object in pECategoriesAssesmentsResponse.peCategoryArray{
//            if peNewAssessment.evaluationID == object.evaluationID{
//                peCategoryFilteredArray.append(object)
//            }
//        }
//        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
//    }
//
//
//
//    func getRandomNumber(maxNumber: Int, listSize: Int)-> Int {
//        var randomNumbers = Set<Int>()
//        var sum = 0
//        while randomNumbers.count < listSize {
//            let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
//            sum = sum + randomNumber
//            randomNumbers.insert(randomNumber)
//        }
//        return sum
//    }
//
//
//    private func updateScore()  {
//        let totalMark = selectedCategory?.catMaxMark ?? 0
//        resultScoreLabel.text = String(selectedCategory?.catResultMark ?? 0)
//        totalScoreLabel.text = String(selectedCategory?.catMaxMark ?? 0)
//    }
//
//    private func selectinitialCell() {
//        collectionView.selectItem(at: collectionviewIndexPath, animated: false, scrollPosition: .left)
//        updateScore()
//    }
//
//
//    @IBAction func finalizeButtonClicked(_ sender: Any) {
//        if validateForm(){
//
//            let errorMSg = "Are you sure you want to finish assessment \nNote*- Edit will be disable after finishing assessment."
//            let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//                _ in
//                NSLog("OK Pressed")
//                self.saveFinalizedData()
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                _ in
//            }
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//
//    }
//
//    @IBAction func draftBtnClicked(_ sender: Any) {
//        let errorMSg = "Are you sure you want to save assessment in Draft?"
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//            _ in
//            NSLog("OK Pressed")
//            self.saveDraftData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//
//    }
//
//    @IBAction func draftButtonClickedInitial(_ sender: Any) {
//        let errorMSg = "Are you sure you want to save assessment in Draft?"
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//            _ in
//            NSLog("OK Pressed")
//            self.saveDraftData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//
//    }
//
//
//
//    private func saveFinalizedData(){
//
//        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PEFinishPopupViewController") as! PEFinishPopupViewController
//        vc.validationSuccessFull = {[unowned self] ( param) in
//            print(param)
//            var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
//            let dataToSubmitNumber = self.getAssessmentInOfflineFromDb()
//            for obj in allAssesmentArr {
//                CoreDataHandlerPE().saveDataToSyncPEInDB(newAssessment: obj as? PE_AssessmentInProgress ?? PE_AssessmentInProgress(), dataToSubmitNumber: dataToSubmitNumber + 1,param:param)
//            }
//            self.finishSession()
//        }
//        self.navigationController?.present(vc, animated: false, completion: nil)
//
//    }
//
//
//
//    func getAssessmentInOfflineFromDb() -> Int {
//        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInOffline")
//        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    func getDraftCountFromDb() -> Int {
//        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInDraft")
//        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "draftNumber") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count ?? 0
//    }
//
//    private func saveDraftData(){
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
//        let draftNumber = getDraftCountFromDb()
//        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr as? [PE_AssessmentInProgress] ?? [], draftNumber: draftNumber + 1)
//        finishSession()
//        print("PE_AssessmentInDraft---\(CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInDraft"))")
//    }
//
//    func finishSession()  {
//        cleanSession()
//        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
//    }
//
//    private func cleanSession(){
//
//        let peNewAssessmentSurrentIs =  CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        let peNewAssessmentNew = PENewAssessment()
//        peNewAssessmentNew.siteId = peNewAssessmentSurrentIs.siteId
//        peNewAssessmentNew.customerId = peNewAssessmentSurrentIs.customerId
//        peNewAssessmentNew.complexId = peNewAssessmentSurrentIs.complexId
//        peNewAssessmentNew.siteName = peNewAssessmentSurrentIs.siteName
//        peNewAssessmentNew.userID = peNewAssessmentSurrentIs.userID
//        peNewAssessmentNew.customerName = peNewAssessmentSurrentIs.customerName
//        peNewAssessmentNew.firstname = peNewAssessmentSurrentIs.firstname
//        peNewAssessmentNew.username = peNewAssessmentSurrentIs.username
//        peNewAssessmentNew.evaluatorName = peNewAssessmentSurrentIs.evaluatorName
//        CoreDataHandler().deleteAllData("PE_AssessmentInProgress")
//        CoreDataHandlerPE().updateAssessmentInProgressInDB(newAssessment:peNewAssessmentNew)
//        // //   print("AssessmentInProgress---\(CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress"))")
//        self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
//    }
//
//
//
//}
//
//extension PEAssesmentFinalize: UITableViewDelegate, UITableViewDataSource{
//
//    func checkForTraning()-> Bool{
//        var currentAssessmentIs = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        if currentAssessmentIs.visitName == "Training"{
//            return true
//        } else{
//            return false
//        }
//    }
//
//
//
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if catArrayForTableIs.count > 0 {
//            var assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 1 {
//                if checkForTraning(){
//                    return 4
//                } else {
//                    return 3
//                }
//            } else if assessment?.sequenceNo == 6 {
//                return 2
//            }
//            else {
//                return 1
//            }
//        }
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if checkForTraning(){
//            if section == 1 {
//                return certificateData.count
//            }
//            if section == 2 {
//                return inovojectData.count
//            }
//            if section == 3 {
//                return dayOfAgeData.count
//            }
//            return catArrayForTableIs.count
//        } else {
//            var assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 6 {
//                if section == 0 {
//                    return catArrayForTableIs.count                }
//                if section == 1 {
//                    return 1
//                }
//            } else {
//                if section == 1 {
//                    return inovojectData.count
//                }
//                if section == 2 {
//                    return dayOfAgeData.count
//                }
//            }
//            return catArrayForTableIs.count
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if checkForTraning(){
//            if indexPath.section == 1 {
//                var height:CGFloat = CGFloat()
//                height = 100
//
//                return height
//            }
//
//        }
//        if selectedCategory?.sequenceNo == 6 {
//            if indexPath.section == 0 {
//                var height:CGFloat = CGFloat()
//                height = 70
//                return height
//            }else {
//                var height:CGFloat = CGFloat()
//                height = 0
//                return height
//            }
//        }
//        if indexPath.section > 0 {
//            var height:CGFloat = CGFloat()
//            height = 130
//            return height
//        }
//
//        var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//
//
//        var height:CGFloat = CGFloat()
//        height = self.estimatedHeightOfLabel(text: assessment?.assDetail1 ?? "") + 50
//        return height
//
//    }
//
//    func estimatedHeightOfLabel(text: String) -> CGFloat {
//
//        let size = CGSize(width: view.frame.width - 16, height: 1000)
//
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)//font type and size
//
//        let attributes = [NSAttributedString.Key.font: font]
//
//        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
//
//        return rectangleHeight
//    }
//
//
//
//    func getLableHeightRuntime(stringValue:String) -> CGFloat {
//        let width:CGFloat = 0//storybord width of UILabel
//        let height:CGFloat = 0//storyboard height of UILabel
//        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)//font type and size
//
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = stringValue.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//        return ceil(boundingBox.height)
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if checkForTraning(){
//            if indexPath.section == 1 {
//                if let cell = tableView.dequeueReusableCell(withIdentifier: CrewInformationCell.identifier) as? CrewInformationCell{
//                    cell.config(data:certificateData[indexPath.row])
//                    cell.dateClickedCompletion = {[unowned self] ( error) in
//                        self.tableviewIndexPath = indexPath
//                        self.view.endEditing(true)
//                        self.showDatePicker()
//                    }
//                    cell.nameCompletion = {[unowned self] ( error) in
//                        self.tableviewIndexPath = indexPath
//                        self.certificateData[self.tableviewIndexPath.row].name = error
//                        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.tableviewIndexPath.row], id:  self.certificateData[self.tableviewIndexPath.row].id!)
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//
//                    }
//                    return cell
//                }
//            }
//            if indexPath.section == 2 {
//                return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
//            }
//            if indexPath.section == 3
//            {
//                return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
//            }else {
//                return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
//            }
//        } else {
//            var assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 6 {
//                if indexPath.section == 0 {
//                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)              }
//                if indexPath.section == 1 {
//                    UITableViewCell()
//                }
//            } else {
//                if indexPath.section == 1 {
//                    return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
//                }
//                if indexPath.section == 2 {
//                    return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
//                } else {
//                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
//                }
//            }
//        }
//        return UITableViewCell()
//    }
//
//
//    func setupInovojectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
//            cell.config(data:inovojectData[indexPath.row])
//
//            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as! NSArray
//                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
//                        self.inovojectData[indexPath.row].vaccineMan = selectedVal
//                        if selectedVal == "Other"{
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        } else {
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//
//                        self.inovojectData[indexPath.row].name = ""
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//
//            }
//
//            cell.ampleSizeCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//
//
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as! NSArray
//
//                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
//
//                   let  selectedValIS = selectedVal.replacingOccurrences(of: " ", with: "")
//                    let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                    if c == 0 {
//                        self.showtoast(message: "Incomplete Data")
//                        return
//                    }
//                    self.inovojectData[indexPath.row].ampuleSize = selectedValIS
//                    let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
//                    let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
//                    if a != 0 {
//                        let x = a * b
//                        let y = c/0.05
//                        let z = x/y
//                        print(Rational(approximating: z))
//                        let r  = Rational(approximating: z)
//                        let n = String(r.numerator)
//                        let d = String(r.denominator)
//                        self.inovojectData[indexPath.row].dosage = n + "/" + d
//                    }
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.amplePerBagCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
//                        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                        if c == 0 {
//                            self.showtoast(message: "Incomplete Data")
//                            return
//                        }
//                        self.inovojectData[indexPath.row].ampulePerBag = selectedVal
//                        let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
//                        let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
//                        if  b != 0 {
//                            let x = a * b
//                            let y = c/0.05
//                            let z = x/y
//                            print(Rational(approximating: z))
//                            let r  = Rational(approximating: z)
//                            let n = String(r.numerator)
//                            let d = String(r.denominator)
//                            self.inovojectData[indexPath.row].dosage = n + "/" + d
//                        }
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//
//
//            cell.doseCompletion  = {[unowned self] ( error) in
//
//
//
//            }
//
//            cell.nameCompletion  = {[unowned self] ( text) in
//                self.tableviewIndexPath = indexPath
//                if text != "" {
//                    self.inovojectData[indexPath.row].name = text
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }else {
//                var ManufacturerId = 0
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "MfgName") as! NSArray
//                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "Id") as! NSArray
//                let xxx =    self.inovojectData[indexPath.row].vaccineMan ?? ""
//                if xxx != "" {
//                    let indexOfd = vManufacutrerNameArray.index(of: xxx) // 3
//                    ManufacturerId = vManufacutrerIDArray[indexOfd] as! Int
//                } else {
//                    self.showtoast(message:"Select Vaccine Manufacturer")
//                    return
//
//                }
//                var indexArray : [Int] = []
//                var vNameFilterArray : [String] = []
//                var vNameArray = NSArray()
//                var vNameIDArray = NSArray()
//                var vNameDetailsArray = NSArray()
//                var vNameMfgIdArray = NSArray()
//                vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
//                vNameArray = vNameDetailsArray.value(forKey: "name") as! NSArray
//                vNameIDArray = vNameDetailsArray.value(forKey: "id") as! NSArray
//                vNameIDArray = vNameDetailsArray.value(forKey: "id") as! NSArray
//                vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as! NSArray
//                var x = -1
//                for obj in vNameMfgIdArray {
//                    x = x + 1
//                    if obj as! Int == ManufacturerId
//                    {
//                        let indexOfd = vNameMfgIdArray.index(of: obj) // 3
//                        indexArray.append(x)
//                    }
//                }
//                let indexOfA = vNameMfgIdArray.index(of: ManufacturerId)
//                for index in indexArray {
//
//                    let item = vNameArray[index] as? String ?? ""
//                    vNameFilterArray.append(item)
//
//                }
//
//
//
//
//
//
//
//
//                if  vNameFilterArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vNameFilterArray as! [String], kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
//                        self.inovojectData[indexPath.row].name = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//            }
//            DispatchQueue.main.async {
//                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            }
//            return cell
//        }
//        return UITableViewCell() as! InovojectCell
//    }
//
//
//    func setupDayOfAgeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
//
//        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
//            cell.config(data:dayOfAgeData[indexPath.row],isDayOfAge:true)
//
//            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as! NSArray
//                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].vaccineMan = selectedVal
//                        if selectedVal == "Other"{
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        } else {
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//                        self.dayOfAgeData[indexPath.row].name = ""
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//
//            }
//
//
//            cell.ampleSizeCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as! NSArray
//                let arr = ["1000","2000","3000","4000","5000","8000","20000"]
//                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String] , kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
//
//                    self.dayOfAgeData[indexPath.row].ampuleSize = selectedVal
//                                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.amplePerBagCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
//
//                        self.dayOfAgeData[indexPath.row].ampulePerBag = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.doseCompletion  = {[unowned self] ( error) in
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Dose")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "dose") as! NSArray
//
//                let vNameFilterArray = vManufacutrerNameArray
//                if  vNameFilterArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vNameFilterArray as! [String], kWidth: cell.tfDosage.frame.width, kAnchor: cell.tfDosage, yheight: cell.tfDosage.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].dosage = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//
//                    }
//                    self.dropHiddenAndShow()
//                }
//
//            }
//
//
//            cell.nameCompletion  = {[unowned self] ( text) in
//                self.tableviewIndexPath = indexPath
//                if text != "" {
//                    self.dayOfAgeData[indexPath.row].name = text
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }else {
//                    var ManufacturerId = 0
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "MfgName") as! NSArray
//                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "Id") as! NSArray
//                let xxx =    self.dayOfAgeData[indexPath.row].vaccineMan ?? ""
//                if xxx != "" {
//                    let indexOfd = vManufacutrerNameArray.index(of: xxx) // 3
//                    ManufacturerId = vManufacutrerIDArray[indexOfd] as! Int
//                } else {
//                    self.showtoast(message:"Select Vaccine Manufacturer")
//                    return
//
//                }
//                var indexArray : [Int] = []
//                var vNameFilterArray : [String] = []
//                var vNameArray = NSArray()
//                var vNameIDArray = NSArray()
//                var vNameDetailsArray = NSArray()
//                var vNameMfgIdArray = NSArray()
//                vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
//                vNameArray = vNameDetailsArray.value(forKey: "name") as! NSArray
//                vNameIDArray = vNameDetailsArray.value(forKey: "id") as! NSArray
//                vNameIDArray = vNameDetailsArray.value(forKey: "id") as! NSArray
//                vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as! NSArray
//                var x = -1
//                for obj in vNameMfgIdArray {
//                    x = x + 1
//                    if obj as! Int == ManufacturerId
//                    {
//                        let indexOfd = vNameMfgIdArray.index(of: obj) // 3
//                        indexArray.append(x)
//                    }
//                }
//                let indexOfA = vNameMfgIdArray.index(of: ManufacturerId)
//                for index in indexArray {
//
//                    let item = vNameArray[index] as? String ?? ""
//                    vNameFilterArray.append(item)
//                }
//
//                if  vNameFilterArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vNameFilterArray as! [String], kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].name = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//            }
//            DispatchQueue.main.async {
//                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            }
//            return cell
//        }
//        return UITableViewCell() as! InovojectCell
//    }
//
//
//
//    func setupPEQuestionTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PEQuestionTableViewCell {
//
//        if let cell = tableView.dequeueReusableCell(withIdentifier: PEQuestionTableViewCell.identifier) as? PEQuestionTableViewCell{
//            var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//            let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
//            let boldMark1 =  "("
//            let boldMark2 =  ") "
//            let mrk = String(maxMarksIs)
//            cell.assessmentLbl.text =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
//            cell.assessmentLbl.attributedText =   cell.assessmentLbl.text?.withBoldText(text: boldMark1 + mrk + boldMark2)
//            if(indexPath.row % 2 == 0) {
//                cell.contentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
//            } else {
//                cell.contentView.backgroundColor =   UIColor.white
//            }
//            if assessment?.camera == 1 {
//                cell.cameraBTn.isEnabled = true
//                cell.cameraBTn.alpha = 1
//            } else {
//                cell.cameraBTn.isEnabled = false
//                cell.cameraBTn.alpha = 0.3
//            }
//
//            if assessment?.assStatus == 1 {
//                cell.switchClicked(status: true)
//                cell.switchBtn.setOn(true, animated: false)
//            } else {
//                cell.switchClicked(status: false)
//                cell.switchBtn.setOn(false, animated: false)
//            }
//            let imageCount = assessment?.images as? [Int]
//            let cnt = imageCount?.count
//            let ttle = String(cnt ?? 0)
//            cell.btnImageCount.setTitle(ttle,for: .normal)
//            if ttle == "0"{
//                cell.btnImageCount.isHidden = true
//            } else {
//                cell.btnImageCount.isHidden = false
//            }
//            let image1 = UIImage(named: "PEcomment.png")
//            let image2 = UIImage(named: "PECommentSelected.png")
//            if assessment?.note == "" {
//                cell.noteBtn.setImage(image1, for: .normal)
//            } else {
//                cell.noteBtn.setImage(image2, for: .normal)
//            }
//            cell.completion = { [unowned self] (status, error) in
//                self.tableviewIndexPath = indexPath
//                if status ?? false {
//                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
//                    let maxMarks =  assessment?.assMaxScore ?? 0
//                    result = result + Int(maxMarks)
//                    self.selectedCategory?.catResultMark = result
//                    assessment?.catResultMark = result as NSNumber
//                    self.resultScoreLabel.text = String(result)
//                    assessment?.assStatus = 1
//                    self.updateAssessmentInDb(assessment : assessment!)
//                } else {
//
//                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
//                    let maxMarks = assessment?.assMaxScore ?? 0
//                    result = result - Int(maxMarks)
//                    self.selectedCategory?.catResultMark = result
//                    assessment?.catResultMark = result as NSNumber
//                    self.resultScoreLabel.text = String(result)
//                    assessment?.assStatus = 0
//                    self.updateAssessmentInDb(assessment : assessment!)
//
//                }
//                self.refreshTableView()
//                self.updateScore()
//                self.chechForLastCategory()
//            }
//            cell.imagesCompletion  = {[unowned self] ( error) in
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "GroupImagesPEViewController") as! GroupImagesPEViewController
//                self.refreshArray()
//                assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//                vc.imagesArray = assessment?.images as! [Int]
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            cell.commentCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                self.refreshArray()
//                assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
//                vc.textOfTextView = assessment?.note ?? ""
//                vc.infoText = assessment?.informationText ?? ""
//
//                vc.commentCompleted = {[unowned self] ( note) in
//                    if note == "" {
//                        let image = UIImage(named: "PEcomment.png")
//                        cell.noteBtn.setImage(image, for: .normal)
//
//                    } else {
//                        let image = UIImage(named: "PECommentSelected.png")
//                        cell.noteBtn.setImage(image, for: .normal)
//
//                    }
//                    assessment?.note = note
//                    self.updateNoteAssessmentInProgressPE(assessment : assessment!)
//                }
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            cell.cameraCompletion = {[unowned self] ( error) in
//               self.tableviewIndexPath = indexPath
//
//                var assessment = self.catArrayForTableIs[self.tableviewIndexPath.row] as? PE_AssessmentInProgress
//
//                let images = CoreDataHandlerPE().getImagecountOfQuestion(assessment:assessment ?? PE_AssessmentInProgress())
//                if images < 5 {
//                    self.takePhoto(cell.cameraBTn)
//                } else {
//                    self.showAlertForNoCamera()
//                }
//            }
//            cell.infoCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "InfoPEViewController") as! InfoPEViewController
//                let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
//                let boldMark1 =  "("
//                let boldMark2 =  ") "
//                let mrk = String(maxMarksIs)
//                let str  =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
//                vc.questionDescriptionIs = str
//                vc.imageDataBase64 = assessment?.informationImage ?? ""
//                vc.infotextIs = assessment?.informationText ?? ""
//
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            return cell
//        }
//        return UITableViewCell() as! PEQuestionTableViewCell
//    }
//    //MARKS: DROP DOWN HIDDEN AND SHOW
//    func dropHiddenAndShow(){
//        if dropDown.isHidden{
//            let _ = dropDown.show()
//        } else {
//            dropDown.hide()
//        }
//    }
//
//    func doneButtonTappedWithDate(string: String, objDate: Date) {
//        certificateData[tableviewIndexPath.row].certificateDate = string
//        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id!)
//        tableview.reloadData()
//    }
//
//    func doneButtonTapped(string:String){
//        certificateData[tableviewIndexPath.row].certificateDate = string
//        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id!)
//        tableview.reloadData()
//    }
//
//
//    func showDatePicker(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
//        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
//        datePickerPopupViewController.delegate = self
//        datePickerPopupViewController.canSelectPreviousDate = false
//        navigationController?.present(datePickerPopupViewController, animated: false, completion: nil)
//
//    }
//
//
//
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        if catArrayForTableIs.count > 0 {
//            if checkForTraning(){
//                if selectedCategory?.sequenceNo == 1 {
//                    if section == 1 {
//
//                        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewHeaderFooterView" ) as! PETableviewHeaderFooterView
//                        headerView.lblTitle.text = "Vaccine Mixer Observer"
//                        headerView.lblSubTitle.text = "Crew Information"
//                        headerView.addCompletion = {[unowned self] ( error) in
//                            let certificateData =  PECertificateData(id:0,name:"",date:"")
//                            let id = self.saveVMixerInPEModule(peCertificateData: certificateData)
//                            certificateData.id = id
//                            self.certificateData.append(certificateData)
//                            self.refreshTableviewAndScrolToBottom(section: section)
//
//                        }
//                        headerView.minusCompletion = {[unowned self] ( error) in
//
//                            if self.certificateData.count > 0 {
//                                let certificateData =  PECertificateData(id:0,name:"",date:"")
//                                let lastItem = self.certificateData.last
//                                self.delVMixerInPEModule(peCertificateData: lastItem ?? certificateData)
//
//                                self.certificateData.removeLast()
//
//
//                            }
//                            if self.certificateData.count > 1 {
//                                self.refreshTableviewAndScrolToBottom(section: section)
//                            } else {
//                                UIView.performWithoutAnimation {
//                                    self.tableview.reloadSections([section], with: .none)
//                                }
//                            }
//                        }
//
//                        return headerView
//                    }  else if section == 2 {
//                        return self.setPEInovojectHeaderFooterView(tableView, section: section)
//                    }
//                    else if section == 3 {
//                        return self.setPEHeaderDayOfAge(tableView, section: section)
//                    }
//                } else   if selectedCategory?.sequenceNo == 6 {
//                    if section == 1 {
//                        return self.setCustomerVaccineView(tableView,section: section)
//
//                    } else {
//                        return UIView()
//                    }
//                }
//
//            } else {
//                if selectedCategory?.sequenceNo == 6 {
//                    if section == 1 {
//                        return self.setCustomerVaccineView(tableView,section: section)
//                    } else {
//                        return UIView()
//                    }
//                }
//                if section == 1 {
//                    return self.setPEInovojectHeaderFooterView(tableView, section: section)
//                } else if section == 2 {
//                    return self.setPEHeaderDayOfAge(tableView, section: section)
//                }    else {
//                    return UIView()
//                }
//            }
//        }
//        return UIView()
//    }
//
//
//    func setCustomerVaccineView(_ tableView: UITableView , section:Int) -> PETableviewConsumerQualityHeader {
//        if selectedCategory?.sequenceNo == 6 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewConsumerQualityHeader" ) as! PETableviewConsumerQualityHeader
//
//            headerView.nameMicro.text =  self.peNewAssessment.micro
//            headerView.nameResidue.text =  self.peNewAssessment.residue
//
//
//            headerView.microComplete =
//                {[unowned self] ( error) in
//                    print("add",( error))
//                    self.peNewAssessment.micro  = error ?? ""
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.residueComplete =
//                {[unowned self] ( error) in
//                    print("add",( error))
//                    self.peNewAssessment.residue  = error ?? ""
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            return headerView as! PETableviewConsumerQualityHeader
//        }
//        return UIView() as! PETableviewConsumerQualityHeader
//    }
//
//
//
//    func setPEInovojectHeaderFooterView(_ tableView: UITableView , section:Int) -> PEInovojectHeaderFooterView {
//        if selectedCategory?.sequenceNo == 1 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEInovojectHeaderFooterView" ) as! PEInovojectHeaderFooterView
//            headerView.lblTitle.text = "In Ovo"
//            headerView.txtCSize.text = peNewAssessment.iCS
//            headerView.txtDType.text = peNewAssessment.iDT
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 3 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchA = 1
//            }
//
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchA = 1
//                } else {
//                    self.switchA = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//
//            //headerView.lblSubTitle.text = "vaccine"
//            headerView.addCompletion =
//                {[unowned self] ( error) in
//                    //   print("add")
//                    let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                    if c == 0 {
//                        self.showtoast(message: "Please enter bag size")
//                        return
//                    }
//                    let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
//                    let id = self.saveInovojectInPEModule(inovojectData: inVoData)
//                    inVoData.id = id
//                    self.inovojectData.append(inVoData)
//                    self.refreshTableviewAndScrolToBottom(section: section)
//            }
//            headerView.minusCompletion = {[unowned self] ( error) in
//                if self.inovojectData.count > 0 {
//                    let lastItem = self.inovojectData.last
//                    self.deleteInovojectInPEModule(id: lastItem!.id ?? 0)
//                    self.inovojectData.removeLast()
//
//                }
//                if self.inovojectData.count > 1 {
//                    self.refreshTableviewAndScrolToBottom(section: section)
//                }  else {
//                    self.tableview.reloadData()
//                }
//            }
//
//            headerView.dTypeCompletion = {[unowned self] ( error) in
//
//
//
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerIDArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgName") as! NSArray
//                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgId") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
//                        headerView.txtDType.text = selectedVal
//                        self.peNewAssessment.iDT = selectedVal
//                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                    }
//                    self.dropHiddenAndShow()
//                }
//
//
//            }
//            headerView.cSizeCompletion = {[unowned self] ( error) in
//                var bagSizeArray = NSArray()
//                var bagSizeIDArray = NSArray()
//                var bagSizeDetailsArray = NSArray()
//                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BagSizes")
//                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as! NSArray
//                bagSizeIDArray = bagSizeDetailsArray.value(forKey: "id") as! NSArray
//                if  bagSizeArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: bagSizeArray as! [String], kWidth: headerView.txtCSize.frame.width, kAnchor: headerView.txtCSize, yheight: headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
//                        headerView.txtCSize.text = selectedVal
//                        self.peNewAssessment.iCS = selectedVal
//                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                        self.updateDosageInvojectData(section: section)
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//            return headerView
//        } else {
//            return UIView() as! PEInovojectHeaderFooterView
//        }
//    }
//
//    func updateDosageInvojectData(section:Int)  {
//        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//        if c == 0 {
//            self.showtoast(message: "Incomplete Data")
//            return
//        }
//        for obj in self.inovojectData{
//            let a = Double(obj.ampulePerBag ?? "0") ?? 0
//            let b = Double(obj.ampuleSize ?? "0") ?? 0
//            if  b != 0 {
//                let x = a * b
//                let y = c/0.05
//                let z = x/y
//                print(Rational(approximating: z))
//                let r  = Rational(approximating: z)
//                let n = String(r.numerator)
//                let d = String(r.denominator)
//                obj.dosage = n + "/" + d
//            }
//            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
//            UIView.performWithoutAnimation {
//                self.tableview.reloadSections([section], with: .none)
//            }
//        }
//    }
//
//
//    func setPEHeaderDayOfAge(_ tableView: UITableView , section:Int) -> PEHeaderDayOfAge {
//        if selectedCategory?.sequenceNo == 1 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
//            headerView.lblTitle.text = "Day of Age"
//            headerView.txtCSize.text = peNewAssessment.dDT
//            headerView.txtDType.text = peNewAssessment.dCS
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//            headerView.switchHatchery.setOn(false, animated: false)
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 1 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchB = 1
//            }
//            //Switch B
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchB = 1
//                } else {
//                    self.switchB = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//            headerView.switchHatchery.setOn(false, animated: false)
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 1 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchB = 1
//            }
//            //Switch B
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchB = 1
//                } else {
//                    self.switchB = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.addCompletion = {[unowned self] ( error) in
//                //   print("add")
//                let c = self.peNewAssessment.dDT ?? ""
//                if c == "" {
//                    self.showtoast(message: "Please enter container size and type")
//                    return
//                }
//                let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
//                let id = self.saveDOAInPEModule(inovojectData: inVoData)
//                inVoData.id = id
//                self.dayOfAgeData.append(inVoData)
//                self.refreshTableviewAndScrolToBottom(section: section)
//            }
//            headerView.minusCompletion = {[unowned self] ( error) in
//                if self.dayOfAgeData.count > 0 {
//                    let lastItem = self.dayOfAgeData.last
//                    self.deleteDOAInPEModule(id: lastItem!.id ?? 0)
//                    self.dayOfAgeData.removeLast()
//                }
//                if self.dayOfAgeData.count > 1 {
//                    self.refreshTableviewAndScrolToBottom(section: section)
//                }  else {
//                    self.tableview.reloadData()
//                }
//            }
//
//            headerView.dTypeCompletion = {[unowned self] ( error) in
//
//                var arr = ["Distilled Water","Sterile Water"]
//                self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
//                    headerView.txtDType.text = selectedVal
//                    self.peNewAssessment.dCS = selectedVal
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//
//                }
//                self.dropHiddenAndShow()
//
//            }
//            headerView.cSizeCompletion = {[unowned self] ( error) in
//                var arr = ["Plastic jug 2 gallon","Plastic jug 5 gallon","IV bag 2 litre","IV bag 2.4 litre","IV bag 2.8 litre"]
//                self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
//                    headerView.txtCSize.text = selectedVal
//                    self.peNewAssessment.dDT = selectedVal
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                   // self.updateDosageDayOfAgeData(section: section)
//                }
//                self.dropHiddenAndShow()
//            }
//
//            return headerView
//        } else {
//            return UIView() as! PEHeaderDayOfAge
//        }
//    }
//
//    func updateDosageDayOfAgeData(section:Int)  {
//        if self.peNewAssessment.dDT == "Plastic jug 2 gallon" {
//            self.ml = 7570.82
//        } else if self.peNewAssessment.dDT == "Plastic jug 5 gallon" {
//            self.ml = 18927.05
//        } else if self.peNewAssessment.dDT == "IV bag 2 litre" {
//            self.ml = 2000.00
//        } else if self.peNewAssessment.dDT == "IV bag 2.4 litre" {
//            self.ml = 2400.00
//        } else if self.peNewAssessment.dDT == "IV bag 2.8 litre" {
//            self.ml = 2800.00
//        }
//        let c = self.ml
//        if c == 0.0 {
//            self.showtoast(message: "Incomplete Data")
//            return
//        }
//        for obj in self.dayOfAgeData{
//            let a = Double(obj.ampulePerBag ?? "0") ?? 0
//            let b = Double(obj.ampuleSize ?? "0") ?? 0
//            if a != 0 {
//                let x = a * b
//                let y = c*20
//                let z = x/y
//                print(Rational(approximating: z))
//                let r  = Rational(approximating: z)
//                let n = String(r.numerator)
//                let d = String(r.denominator)
//                obj.dosage = n + "/" + d
//            }
//            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
//            UIView.performWithoutAnimation {
//                self.tableview.reloadSections([section], with: .none)
//            }
//        }
//    }
//
//    func refreshTableviewAndScrolToBottom(section:Int){
//        UIView.performWithoutAnimation {
//           // [self.tableView beginUpdates];
//            self.tableview.reloadSections([section], with: .none)
//
//        }
//        scrollToBottom(section:section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section > 0 {
//            if selectedCategory?.sequenceNo == 1 {
//                return 95.0
//            }
//            if selectedCategory?.sequenceNo == 6 {
//                return 95.0
//            }
//        }
//        return 0.0
//    }
//
//    func scrollToBottom(section:Int){
//
//        var indexPathOfTab = IndexPath(row: 0, section: 0)
//        DispatchQueue.main.async {
//            if self.checkForTraning(){
//                if section == 1 {
//                    indexPathOfTab = IndexPath(
//                        row: self.certificateData.count - 1 ,
//                        section:1)
//                }
//                if section == 2 {
//                    indexPathOfTab = IndexPath(
//                        row: self.inovojectData.count - 1 ,
//                        section:2)
//                }
//                if section == 3 {
//                    indexPathOfTab = IndexPath(
//                        row: self.dayOfAgeData.count - 1 ,
//                        section:3)
//                }
//            } else {
//                if section == 1 {
//                    indexPathOfTab = IndexPath(
//                        row: self.inovojectData.count - 1 ,
//                        section:1)
//                }
//                if section == 2 {
//                    indexPathOfTab = IndexPath(
//                        row: self.dayOfAgeData.count - 1 ,
//                        section:2)
//                }
//            }
//            self.tableview.scrollToRow(at: indexPathOfTab, at: .none, animated: false)
//        }
//    }
//
//    func updateAssessmentInDb(assessment:PE_AssessmentInProgress) -> Bool {
//        var status = CoreDataHandlerPE().updateCatDetailsForStatus(assessment:assessment)
//        return status
//    }
//
//    func updateNoteAssessmentInProgressPE(assessment:PE_AssessmentInProgress) -> Bool {
//        var status = CoreDataHandlerPE().updateNoteAssessmentInProgress(assessment:assessment)
//        return status
//    }
//    func updateCategoryInDb(assessment:PENewAssessment) -> Bool {
//        var status = CoreDataHandlerPE().updateCategortIsSelcted(assessment:assessment)
//        return status
//    }
//}
//
//extension PEAssesmentFinalize : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
//
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return catArrayForCollectionIs.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewIDPE", for: indexPath as IndexPath) as! PECategoryCell
//        let category = catArrayForCollectionIs[indexPath.row]
//
//        cell.categoryLabel.text = category.catName ?? ""
//        return cell
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 250, height: 65)
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        selectedCategory?.catISSelected = 0
//        self.updateCategoryInDb(assessment:selectedCategory!)
//        let selectedCategoryIS = catArrayForCollectionIs[indexPath.row]
//        collectionviewIndexPath = indexPath
//        selectedCategory = catArrayForCollectionIs[indexPath.row]
//        selectedCategory?.catISSelected = 1
//        self.updateCategoryInDb(assessment:selectedCategory!)
//        chechForLastCategory()
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as! NSNumber)
//        let totalMark = selectedCategory?.catMaxMark ?? 0
//        totalScoreLabel.text = String(totalMark)
//        resultScoreLabel.text = String(0)
//        tableview.reloadData()
//        updateScore()
//        refreshTableView()
//
//    }
//
//    func updateCategoriesInShared(){
//        //         pECategoriesAssesmentsResponse.peCategoryArray[collectionviewIndexPath.row] = selectedCategory ?? PECategory(nil)
//        //         ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0] = pECategoriesAssesmentsResponse
//    }
//
//    func chechForLastCategory(){
//        var  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject()
//        var catArrayForCollectionIsAre : [PENewAssessment] = []
//        var carColIdArray : [Int] = []
//        for cat in peNewAssessmentArray {
//            if !carColIdArray.contains(cat.sequenceNo!){
//                carColIdArray.append(cat.sequenceNo!)
//                catArrayForCollectionIsAre.append(cat)
//            }
//        }
//
//
//        let count = catArrayForCollectionIs.count - 1
//        if count > 0 {
//            if let cat = catArrayForCollectionIs[count] as? PENewAssessment {
//                if cat.sequenceNo == selectedCategory?.sequenceNo{
//                    buttonSaveAsDraft.isHidden = false
//                    buttonFinishAssessment.isHidden = false
//                    buttonSaveAsDraftInitial.isHidden = true
//                    bckButton.isHidden = true
//
//                } else {
//                    buttonSaveAsDraftInitial.isHidden = false
//                    buttonSaveAsDraft.isHidden = true
//                    buttonFinishAssessment.isHidden = true
//                    bckButton.isHidden = false
//                }
//            }
//            else {
//                buttonSaveAsDraftInitial.isHidden = false
//                bckButton.isHidden = false
//                buttonSaveAsDraft.isHidden = true
//                buttonFinishAssessment.isHidden = true
//
//            }
//
//            if let cat = catArrayForCollectionIs[0] as? PENewAssessment{
//                if cat.sequenceNo == selectedCategory?.sequenceNo{
//                    bckButton.isHidden = false
//                }  else {
//                    bckButton.isHidden = true
//                }
//            } else {
//                bckButton.isHidden = true
//            }
//
//            //            for cat in catArrayForCollectionIsAre {
//            //                if cat.catResultMark == 0 {
//            //                    showAlertForNoValid()
//            //                    return
//            //                }
//            //                buttonFinishAssessment.isEnabled = true
//            //                buttonFinishAssessment.alpha = 1.0
//            //            }
//
//        }
//
//    }
//
//    func validateForm() -> Bool {
//        if !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
//
//            if self.inovojectData.count > 0 {
//                let countt = self.inovojectData[0].vaccineMan?.count ?? 0
//                if countt < 1 {
//                    showAlertForNoValid()
//                    return false
//                }
//
//            } else {
//                showAlertForNoValid()
//                return false
//            }
//        }
//        if self.checkForTraning() && !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
//            if self.certificateData.count > 0 {
//                let countt = self.certificateData[0].name?.count ?? 0
//                if countt < 1 {
//                    showAlertForNoValidTraining()
//                    return false
//                }
//            } else {
//                showAlertForNoValidTrainingName()
//                return false
//            }
//        }
//        return true
//    }
//    //Show ""
//
//    func showAlertForNoValid(){
//        let errorMSg = "Fill in ovo information to submit this assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoValidTraining(){
//        let errorMSg = "Please enter the certification details before submitting the assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//
//    func showAlertForNoValidTrainingName(){
//        let errorMSg = "Fill name in vaccine mixer data to submit this assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoCamera(){
//      let errorMSg = "You cannot exceed 5 images for 1 question."
//      let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//
//      let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
//          _ in
//      }
//      alertController.addAction(cancelAction)
//      self.present(alertController, animated: true, completion: nil)
//      }
//}
//
//
//extension PEAssesmentFinalize{
//
//    func anyCategoryContainValueOrNot() -> Bool{
//        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
//        for obj in peNewAssessmentSurrentIs.peCategoryArray{
//            if obj.resultMark ?? 0 > 0 {
//                return true
//            }
//            return false
//        }
//        return false
//    }
//
//    func getCategoryAlreadyDone() -> PECategory{
//        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
//        for obj in peNewAssessmentSurrentIs.peCategoryArray{
//            if obj.isSelected {
//                return obj
//            }
//        }
//        return PECategory(nil)
//    }
//
//
//}
//
///************** Camera Button Action ***************************************/
//extension PEAssesmentFinalize: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
//    @objc func takePhoto(_ sender: UIButton) {
//        //    let imageArrWithIsyncIsTrue = CoreDataHandlerTurkey().fecthPhotoWithiSynsTrueTurkey(true)
//        //    if imageArrWithIsyncIsTrue.count >= 15 {
//        //        postAlert("Alert", message: "Maximum limit of image has been exceeded. Limit will be reset after next sync.")
//        //    } else {
//        /*************** Intilzing Camera Delegate Methods **********************************/
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .camera
//                imagePicker.cameraCaptureMode = .photo
//                imagePicker.delegate = self
//                present(imagePicker, animated: true, completion: {})
//            } else {
//                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
//            }
//        } else {
//            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
//        }
//        /****************************************************************************************/
//        //  }
//
//    }
//
//    /************* Alert View Methods ***********************************/
//
//    func postAlert(_ title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message,
//                                      preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//    /**************************************************************************************************/
//
//    /******************************  Image Picker Delegate Methods ***************************************/
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        // Local variable inserted by Swift 4.2 migrator.
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//        //let data = convertFromUIImagePickerControllerInfoKey(info)
//        //////   print("Got an image")
//        if let pickedImage: UIImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]) as? UIImage {
//
//            let imageData: Data? = pickedImage.jpegData(compressionQuality: 0.02)
//            let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
//            let imageStrB64 = convertImageToBase64String(image: pickedImage)
//
//
//
//            saveImageInPEModule(imageData:imageData!)
//            self.refreshArray()
//            let assessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//            if let cell = tableview.cellForRow(at: tableviewIndexPath) as? PEQuestionTableViewCell {
//                let imageCount = assessment?.images as? [Int]
//                let cnt = imageCount?.count
//                let ttle = String(cnt ?? 0)
//                cell.btnImageCount.setTitle(ttle,for: .normal)
//                if ttle == "0"{
//                    cell.btnImageCount.isHidden = true
//                } else {
//                    cell.btnImageCount.isHidden = false
//                }
//            }
//        }
//        imagePicker.dismiss(animated: true, completion: {
//            // Anything you want to happen when the user saves an image
//        })
//    }
//    /******************************************************************************************************/
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//
//        dismiss(animated: true, completion: {
//
//        })
//    }
//
//    private func saveImageInPEModule(imageData:Data){
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_ImageEntity")
//        let imageCount = getImageCountInPEModule()
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveImageInPEModule(assessment: assessment!, imageId: imageCount+1, imageData: imageData)
//    }
//
//    func getImageCountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_ImageEntity")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "imageId") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    private func saveDOAInPEModule(inovojectData:InovojectData) -> Int{
//
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DayOfAge")
//        let imageCount = getDOACountInPEModule()
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveDOAPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData)
//        return imageCount+1
//
//    }
//
//    private func saveInovojectInPEModule(inovojectData:InovojectData) -> Int{
//
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DayOfAge")
//        let imageCount = getDOACountInPEModule()
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveInovojectPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData)
//        return imageCount+1
//
//    }
//
//    private func saveVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
//
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
//        let imageCount = getVMixerCountInPEModule()
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
//        return imageCount+1
//
//    }
//
//    private func delVMixerInPEModule(peCertificateData:PECertificateData) {
//
//        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
//        let imageCount = getVMixerCountInPEModule()
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().subtractVMixerMinusCategortIsSelcted(assessment: assessment!, doaId: peCertificateData.id ?? 0)
//
//
//    }
//
//
//    func getDOACountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DayOfAge")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "doaId") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    func getVMixerCountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "vmid") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    private func deleteDOAInPEModule(id:Int) {
//
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateDOAMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//
//    }
//    private func deleteInovojectInPEModule(id:Int) {
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//    }
//
//    private func deleteCrtificateInPEModule(id:Int) {
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//    }
//}
//
//
//// Helper function inserted by Swift 4.2 migrator.
//private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
//    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
//}
//
//// Helper function inserted by Swift 4.2 migrator.
//private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
//    return input.rawValue
//}
//
//public func  convertImageToBase64String(image : UIImage ) -> String
//{
//    let strBase64 =  image.pngData()?.base64EncodedString()
//    return strBase64!
//}





//
//
////
////  PEAssesmentFinalize.swift
////  Zoetis -Feathers
////
////  Created by "" ""on 13/12/19.
////  Copyright © 2019  . All rights reserved.
////
//import UIKit
//import SwiftyJSON
//struct Rational {
//    let numerator : Int
//    let denominator: Int
//    init(numerator: Int, denominator: Int) {
//        self.numerator = numerator
//        self.denominator = denominator
//    }
//    init(approximating x0: Double, withPrecision eps: Double = 1.0E-6) {
//        var x = x0
//        var a = x.rounded(.down)
//        var (h1, k1, h, k) = (1, 0, Int(a), 1)
//        while x - a > eps * Double(k) * Double(k) {
//            x = 1.0/(x - a)
//            a = x.rounded(.down)
//            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
//        }
//        self.init(numerator: h, denominator: k)
//    }
//}
//protocol PECategorySelectionDelegate {
//    func selectedAssessmentId(selectedId: Int, selectedArr:[[String : AnyObject]])
//}
//class PEAssesmentFinalize: BaseViewController , DatePickerPopupViewControllerProtocol {
//    let imagePicker: UIImagePickerController! = UIImagePickerController()
//    @IBOutlet weak var buttonFinishAssessment: PESubmitButton!
//    @IBOutlet weak var buttonSaveAsDraft: PESubmitButton!
//    @IBOutlet weak var buttonSaveAsDraftInitial: PESubmitButton!
//    @IBOutlet weak var assessmentDateText: PEFormTextfield!
//    @IBOutlet weak var headerView: UIView!
//    var peHeaderViewController:PEHeaderViewController!
//    var peNewAssessment:PENewAssessment!
//    var dropdownManager = ZoetisDropdownShared.sharedInstance
//    var delegate: PECategorySelectionDelegate? = nil
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var resultScoreLabel: UILabel!
//    @IBOutlet weak var totalScoreLabel: UILabel!
//    @IBOutlet fileprivate weak var tableview: UITableView!
//    @IBOutlet weak var selectedCustomer: PEFormLabel!
//    @IBOutlet weak var selectedComplex: PEFormLabel!
//    var currentArr : [AssessmentQuestions] = []
//    var selectedCategory : PENewAssessment?
//    var collectionviewIndexPath = IndexPath(row: 0, section: 0)
//    @IBOutlet weak var scoreGradientView: UIView!
//    @IBOutlet weak var customerGradientView: UIView!
//    @IBOutlet weak var scoreParentView: UIView!
//    @IBOutlet weak var scoreView: UIView!
//    @IBOutlet weak var coustomerView: UIView!
//    var jsonRe : JSON = JSON()
//    var ml = 0.0
//    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
//    var tableviewIndexPath = IndexPath(row: 0, section: 0)
//    var catArrayForCollectionIs : [PENewAssessment] = []
//    var catArrayForTableIs = NSArray()
//    @IBOutlet weak var bckButton: PESubmitButton!
//    var switchA = 0
//    var switchB = 0
//    var certificateData : [PECertificateData] = []
//    var inovojectData : [InovojectData] = []
//    var dayOfAgeData : [InovojectData] = []
//    var row = 0
//
//    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        navigationController?.navigationBar.isHidden = false
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//        let keyboardFrame = keyboardSize.cgRectValue
//        if self.view.bounds.origin.y == 0{
//            self.view.bounds.origin.y += keyboardFrame.height
//        }
//        tableview.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.bounds.origin.y != 0 {
//            self.view.bounds.origin.y = 0
//        }
//        tableview.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @IBAction func backButton(_ sender: Any) {
//        cleanSessionAndMoveTOStart()
//    }
//
//    private func cleanSessionAndMoveTOStart(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PEStartNewAssessment") as! PEStartNewAssessment
//        vc.isFromBack = true
//        navigationController?.pushViewController(vc, animated: false)
//    }
//
//    override func viewDidLoad() {
//        peHeaderViewController = PEHeaderViewController()
//        peHeaderViewController.titleOfHeader = "Assessment"
//        self.headerView.addSubview(peHeaderViewController.view)
//        self.topviewConstraint(vwTop: peHeaderViewController.view)
//        peNewAssessment = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        let  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject()
//        var carColIdArray : [Int] = []
//        for cat in peNewAssessmentArray {
//            if !carColIdArray.contains(cat.sequenceNo!){
//                carColIdArray.append(cat.sequenceNo!)
//                catArrayForCollectionIs.append(cat)
//            }
//        }
//        for cat in catArrayForCollectionIs{
//            if cat.doa.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.doa {
//                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
//                    if data != nil {
//                        if idArr.contains(data!.id!){
//                        }else{
//                            idArr.append(data!.id!)
//                            dayOfAgeData.append(data!)
//                        }
//                    }
//                }
//            }
//        }
//        for cat in catArrayForCollectionIs{
//            if cat.inovoject.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.inovoject {
//                    let data = CoreDataHandlerPE().getPEDOAData(doaId: obj)
//                    if idArr.contains(data!.id!){
//                    }else{
//                        idArr.append(data!.id!)
//                        inovojectData.append(data!)
//                    }
//                }
//            }
//        }
//        for cat in catArrayForCollectionIs{
//            if cat.vMixer.count > 0 {
//                var idArr : [Int] = []
//                for obj in  cat.vMixer {
//                    let data = CoreDataHandlerPE().getCertificateData(doaId: obj)
//                    if idArr.contains(data!.id!){
//                    }else{
//                        idArr.append(data!.id!)
//                        certificateData.append(data!)
//                    }
//                }
//            }
//        }
//        if certificateData.count > 0 {
//            self.certificateData =  self.certificateData.sorted(by: {
//                let id1 = $0.id ?? 0
//                let id2 = $1.id ?? 0
//                return id1 < id2
//            })
//        }
//        for cat in catArrayForCollectionIs {
//            if cat.catISSelected == 1 {
//                row = cat.sequenceNo! - 1
//                selectedCategory = cat
//            }
//        }
//        if  selectedCategory?.evaluationDate?.count == nil {
//            selectedCategory = catArrayForCollectionIs.first
//        }
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID((selectedCategory?.sequenceNo! ?? 0) as NSNumber)
//        super.viewDidLoad()
//        tableview.register(PEQuestionTableViewCell.nib, forCellReuseIdentifier: PEQuestionTableViewCell.identifier)
//        tableview.register(CrewInformationCell.nib, forCellReuseIdentifier: CrewInformationCell.identifier)
//        tableview.register(InovojectCell.nib, forCellReuseIdentifier: InovojectCell.identifier)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        if selectedCategory?.evaluationName == "Non-Inject Process Evaluation" {
//            row = 0
//            selectedCategory = catArrayForCollectionIs[0]
//        }
//
//        collectionView.reloadData()
//        collectionviewIndexPath = IndexPath(row: row, section: 0)
//        selectinitialCell()
//        collectionView(collectionView, didSelectItemAt: collectionviewIndexPath)
//        selectedComplex.text = catArrayForCollectionIs.first?.siteName
//        selectedCustomer.text = catArrayForCollectionIs.first?.customerName
//        assessmentDateText.text =  catArrayForCollectionIs.first?.evaluationDate
//        chechForLastCategory()
//        setupUI()
//    }
//    func setupUI(){
//        let nibCatchers = UINib(nibName: "PETableviewHeaderFooterView", bundle: nil)
//        tableview.register(nibCatchers, forHeaderFooterViewReuseIdentifier: "PETableviewHeaderFooterView")
//        let nibCas = UINib(nibName: "PEInovojectHeaderFooterView", bundle: nil)
//        tableview.register(nibCas, forHeaderFooterViewReuseIdentifier: "PEInovojectHeaderFooterView")
//        let nibCasa = UINib(nibName: "PEHeaderDayOfAge", bundle: nil)
//        tableview.register(nibCasa, forHeaderFooterViewReuseIdentifier: "PEHeaderDayOfAge")
//        let peTableviewConsumerQualityHeader = UINib(nibName: "PETableviewConsumerQualityHeader", bundle: nil)
//        tableview.register(peTableviewConsumerQualityHeader, forHeaderFooterViewReuseIdentifier: "PETableviewConsumerQualityHeader")
//        coustomerView.setCornerRadiusFloat(radius: 24)
//        customerGradientView.setCornerRadiusFloat(radius: 24)
//        DispatchQueue.main.async {
//            self.customerGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            self.scoreGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//        }
//        scoreParentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
//        buttonFinishAssessment.setNextButtonUI()
//        buttonSaveAsDraft.setNextButtonUI()
//        buttonSaveAsDraftInitial.setNextButtonUI()
//    }
//    func refreshTableView(){
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID((selectedCategory?.sequenceNo!)! as NSNumber)
//        tableview.reloadData()
//    }
//    func refreshArray(){
//        catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID((selectedCategory?.sequenceNo!)! as NSNumber)
//    }
//    func filterCategory()  {
//        var peCategoryFilteredArray: [PECategory] =  []
//        for object in pECategoriesAssesmentsResponse.peCategoryArray{
//            if peNewAssessment.evaluationID == object.evaluationID{
//                peCategoryFilteredArray.append(object)
//            }
//        }
//        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
//    }
//    func getRandomNumber(maxNumber: Int, listSize: Int)-> Int {
//        var randomNumbers = Set<Int>()
//        var sum = 0
//        while randomNumbers.count < listSize {
//            let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
//            sum = sum + randomNumber
//            randomNumbers.insert(randomNumber)
//        }
//        return sum
//    }
//    private func updateScore()  {
//        _ = selectedCategory?.catMaxMark ?? 0
//        resultScoreLabel.text = String(selectedCategory?.catResultMark ?? 0)
//        totalScoreLabel.text = String(selectedCategory?.catMaxMark ?? 0)
//    }
//    private func selectinitialCell() {
//        collectionView.selectItem(at: collectionviewIndexPath, animated: false, scrollPosition: .left)
//        updateScore()
//    }
//    @IBAction func finalizeButtonClicked(_ sender: Any) {
//        if validateForm(){
//            let errorMSg = "Are you sure you want to finish assessment \nNote*- Edit will be disable after finishing assessment."
//            let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//                _ in
//                NSLog("OK Pressed")
//                self.saveFinalizedData()
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//                _ in
//            }
//            alertController.addAction(okAction)
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//    @IBAction func draftBtnClicked(_ sender: Any) {
//        let errorMSg = "Are you sure you want to save assessment in Draft?"
//        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//            _ in
//            NSLog("OK Pressed")
//            self.saveDraftData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//    @IBAction func draftButtonClickedInitial(_ sender: Any) {
//        let errorMSg = "Are you sure you want to save assessment in Draft?"
//        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
//            _ in
//            NSLog("OK Pressed")
//            self.saveDraftData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//    private func saveFinalizedData(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PEFinishPopupViewController") as! PEFinishPopupViewController
//        vc.validationSuccessFull = {[unowned self] ( param) in
//            print(param as Any)
//            let allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
//            let dataToSubmitNumber = self.getAssessmentInOfflineFromDb()
//            for obj in allAssesmentArr {
//                CoreDataHandlerPE().saveDataToSyncPEInDB(newAssessment: obj as? PE_AssessmentInProgress ?? PE_AssessmentInProgress(), dataToSubmitNumber: dataToSubmitNumber + 1,param:param)
//            }
//            self.finishSession()
//        }
//        self.navigationController?.present(vc, animated: false, completion: nil)
//    }
//    func getAssessmentInOfflineFromDb() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInOffline")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "dataToSubmitNumber") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//    func getDraftCountFromDb() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInDraft")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "draftNumber") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//    private func saveDraftData(){
//        let allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
//        let draftNumber = getDraftCountFromDb()
//        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr as? [PE_AssessmentInProgress] ?? [], draftNumber: draftNumber + 1)
//        finishSession()
//        print("PE_AssessmentInDraft---\(CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInDraft"))")
//    }
//    func finishSession()  {
//        cleanSession()
//        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
//    }
//    private func cleanSession(){
//        let peNewAssessmentSurrentIs =  CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        let peNewAssessmentNew = PENewAssessment()
//        peNewAssessmentNew.siteId = peNewAssessmentSurrentIs.siteId
//        peNewAssessmentNew.customerId = peNewAssessmentSurrentIs.customerId
//        peNewAssessmentNew.complexId = peNewAssessmentSurrentIs.complexId
//        peNewAssessmentNew.siteName = peNewAssessmentSurrentIs.siteName
//        peNewAssessmentNew.userID = peNewAssessmentSurrentIs.userID
//        peNewAssessmentNew.customerName = peNewAssessmentSurrentIs.customerName
//        peNewAssessmentNew.firstname = peNewAssessmentSurrentIs.firstname
//        peNewAssessmentNew.username = peNewAssessmentSurrentIs.username
//        peNewAssessmentNew.evaluatorName = peNewAssessmentSurrentIs.evaluatorName
//        CoreDataHandler().deleteAllData("PE_AssessmentInProgress")
//        CoreDataHandlerPE().updateAssessmentInProgressInDB(newAssessment:peNewAssessmentNew)
//        self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
//    }
//}
//extension PEAssesmentFinalize: UITableViewDelegate, UITableViewDataSource{
//
//    func checkForTraning()-> Bool{
//        let currentAssessmentIs = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
//        if currentAssessmentIs.visitName == "Training"{
//            return true
//        } else{
//            return false
//        }
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        if catArrayForTableIs.count > 0 {
//            let assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 1 {
//                if checkForTraning(){
//                    return 4
//                } else {
//                    return 3
//                }
//            } else if assessment?.sequenceNo == 6 {
//                return 2
//            }
//            else {
//                return 1
//            }
//        }
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if checkForTraning(){
//            if section == 1 {
//                return certificateData.count
//            }
//            if section == 2 {
//                return inovojectData.count
//            }
//            if section == 3 {
//                return dayOfAgeData.count
//            }
//            return catArrayForTableIs.count
//        } else {
//            let assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 6 {
//                if section == 0 {
//                    return catArrayForTableIs.count                }
//                if section == 1 {
//                    return 1
//                }
//            } else {
//                if section == 1 {
//                    return inovojectData.count
//                }
//                if section == 2 {
//                    return dayOfAgeData.count
//                }
//            }
//            return catArrayForTableIs.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if checkForTraning(){
//            if indexPath.section == 1 {
//                var height:CGFloat = CGFloat()
//                height = 100
//                return height
//            }
//        }
//        if selectedCategory?.sequenceNo == 6 {
//            if indexPath.section == 0 {
//                var height:CGFloat = CGFloat()
//                height = 70
//                return height
//            }else {
//                var height:CGFloat = CGFloat()
//                height = 0
//                return height
//            }
//        }
//        if indexPath.section > 0 {
//            var height:CGFloat = CGFloat()
//            height = 130
//            return height
//        }
//        let assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//        var height:CGFloat = CGFloat()
//        height = self.estimatedHeightOfLabel(text: assessment?.assDetail1 ?? "") + 50
//        return height
//    }
//
//    func estimatedHeightOfLabel(text: String) -> CGFloat {
//        let size = CGSize(width: view.frame.width - 16, height: 1000)
//        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)
//        let attributes = [NSAttributedString.Key.font: font]
//        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil).height
//        return rectangleHeight
//    }
//
//    func getLableHeightRuntime(stringValue:String) -> CGFloat {
//        let width:CGFloat = 0//storybord width of UILabel
//        let _:CGFloat = 0//storyboard height of UILabel
//        let font = UIFont(name: "HelveticaNeue-Bold", size: 20)//font type and size
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = stringValue.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font as Any], context: nil)
//        return ceil(boundingBox.height)
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if checkForTraning(){
//            if indexPath.section == 1 {
//                if let cell = tableView.dequeueReusableCell(withIdentifier: CrewInformationCell.identifier) as? CrewInformationCell{
//                    cell.config(data:certificateData[indexPath.row])
//                    cell.dateClickedCompletion = {[unowned self] ( error) in
//                        self.tableviewIndexPath = indexPath
//                        self.view.endEditing(true)
//                        self.showDatePicker()
//                    }
//                    cell.nameCompletion = {[unowned self] ( error) in
//                        self.tableviewIndexPath = indexPath
//                        self.certificateData[self.tableviewIndexPath.row].name = error
//                        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[self.tableviewIndexPath.row], id:  self.certificateData[self.tableviewIndexPath.row].id!)
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    return cell
//                }
//            }
//            if indexPath.section == 2 {
//                return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
//            }
//            if indexPath.section == 3
//            {
//                return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
//            }else {
//                return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
//            }
//        } else {
//            let assessment = catArrayForTableIs[0] as? PE_AssessmentInProgress
//            if assessment?.sequenceNo == 6 {
//                if indexPath.section == 0 {
//                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)              }
//                if indexPath.section == 1 {
//                }
//            } else {
//                if indexPath.section == 1 {
//                    return self.setupInovojectCell(tableView, cellForRowAt: indexPath)
//                }
//                if indexPath.section == 2 {
//                    return self.setupDayOfAgeCell(tableView, cellForRowAt: indexPath)
//                } else {
//                    return  self.setupPEQuestionTableViewCell(tableView, cellForRowAt: indexPath)
//                }
//            }
//        }
//        return UITableViewCell()
//    }
//    func setupInovojectCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
//            cell.config(data:inovojectData[indexPath.row])
//            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
//                        self.inovojectData[indexPath.row].vaccineMan = selectedVal
//                        if selectedVal == "Other"{
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        } else {
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//
//                        self.inovojectData[indexPath.row].name = ""
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//
//            }
//
//            cell.ampleSizeCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as! NSArray
//
//                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
//
//                    let  selectedValIS = selectedVal.replacingOccurrences(of: " ", with: "")
//                    let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                    if c == 0 {
//                        self.showtoast(message: "Incomplete Data")
//                        return
//                    }
//                    self.inovojectData[indexPath.row].ampuleSize = selectedValIS
//                    let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
//                    let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
//                    if a != 0 {
//                        let x = a * b
//                        let y = c/0.05
//                        let z = x/y
//                        print(Rational(approximating: z))
//                        let r  = Rational(approximating: z)
//                        let n = String(r.numerator)
//                        let d = String(r.denominator)
//                        self.inovojectData[indexPath.row].dosage = n + "/" + d
//                    }
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.amplePerBagCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
//                        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                        if c == 0 {
//                            self.showtoast(message: "Incomplete Data")
//                            return
//                        }
//                        self.inovojectData[indexPath.row].ampulePerBag = selectedVal
//                        let a = Double(self.inovojectData[indexPath.row].ampulePerBag ?? "0") ?? 0
//                        let b = Double(self.inovojectData[indexPath.row].ampuleSize ?? "0") ?? 0
//                        if  b != 0 {
//                            let x = a * b
//                            let y = c/0.05
//                            let z = x/y
//                            print(Rational(approximating: z))
//                            let r  = Rational(approximating: z)
//                            let n = String(r.numerator)
//                            let d = String(r.denominator)
//                            self.inovojectData[indexPath.row].dosage = n + "/" + d
//                        }
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//
//            cell.nameCompletion  = {[unowned self] ( text) in
//                self.tableviewIndexPath = indexPath
//                if text != "" {
//                    self.inovojectData[indexPath.row].name = text
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }else {
//                    var ManufacturerId = 0
//                    var vManufacutrerNameArray = NSArray()
//                    var vManufacutrerIDArray = NSArray()
//                    var vManufacutrerDetailsArray = NSArray()
//                    vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                    vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "MfgName") as! NSArray
//                    vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "Id") as! NSArray
//                    let xxx =    self.inovojectData[indexPath.row].vaccineMan ?? ""
//                    if xxx != "" {
//                        let indexOfd = vManufacutrerNameArray.index(of: xxx)
//                        ManufacturerId = vManufacutrerIDArray[indexOfd] as! Int
//                    } else {
//                        self.showtoast(message:"Select Vaccine Manufacturer")
//                        return
//
//                    }
//                    var indexArray : [Int] = []
//                    var vNameFilterArray : [String] = []
//                    var vNameArray = NSArray()
//                    var vNameDetailsArray = NSArray()
//                    var vNameMfgIdArray = NSArray()
//                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
//                    vNameArray = vNameDetailsArray.value(forKey: "name") as! NSArray
//                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as! NSArray
//                    var x = -1
//                    for obj in vNameMfgIdArray {
//                        x = x + 1
//                        if obj as! Int == ManufacturerId
//                        {
//                            _ = vNameMfgIdArray.index(of: obj) // 3
//                            indexArray.append(x)
//                        }
//                    }
//                    _ = vNameMfgIdArray.index(of: ManufacturerId)
//                    for index in indexArray {
//
//                        let item = vNameArray[index] as? String ?? ""
//                        vNameFilterArray.append(item)
//
//                    }
//                    if  vNameFilterArray.count > 0 {
//                        self.dropDownVIewNew(arrayData: vNameFilterArray , kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
//                            self.inovojectData[indexPath.row].name = selectedVal
//                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.inovojectData[indexPath.row])
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//                        self.dropHiddenAndShow()
//                    }
//                }
//            }
//            DispatchQueue.main.async {
//                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            }
//            return cell
//        }
//        return UITableViewCell() as! InovojectCell
//    }
//
//    func setupDayOfAgeCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> InovojectCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: InovojectCell.identifier) as? InovojectCell{
//            cell.config(data:dayOfAgeData[indexPath.row],isDayOfAge:true)
//            cell.vaccineManufacturerCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfVaccineMan.frame.width, kAnchor: cell.tfVaccineMan, yheight: cell.tfVaccineMan.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].vaccineMan = selectedVal
//                        if selectedVal == "Other"{
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        } else {
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//                        self.dayOfAgeData[indexPath.row].name = ""
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//
//            cell.ampleSizeCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                _ = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "size") as! NSArray
//                _ = ["1000","2000","3000","4000","5000","8000","20000"]
//                self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String] , kWidth: cell.tfAmpleSize.frame.width, kAnchor: cell.tfAmpleSize, yheight: cell.tfAmpleSize.bounds.height) { [unowned self] selectedVal, index  in
//                    self.dayOfAgeData[indexPath.row].ampuleSize = selectedVal
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.amplePerBagCompletion  = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                var vManufacutrerNameArray = NSArray()
//                _ = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmplePerBag")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "bagNo") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: cell.tfAmpleBag.frame.width, kAnchor: cell.tfAmpleBag, yheight: cell.tfAmpleBag.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].ampulePerBag = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                }
//                self.dropHiddenAndShow()
//            }
//
//            cell.doseCompletion  = {[unowned self] ( error) in
//                var vManufacutrerNameArray = NSArray()
//                _ = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Dose")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "dose") as! NSArray
//
//                let vNameFilterArray = vManufacutrerNameArray
//                if  vNameFilterArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vNameFilterArray as! [String], kWidth: cell.tfDosage.frame.width, kAnchor: cell.tfDosage, yheight: cell.tfDosage.bounds.height) { [unowned self] selectedVal, index  in
//                        self.dayOfAgeData[indexPath.row].dosage = selectedVal
//                        CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//                        UIView.performWithoutAnimation {
//                            self.tableview.reloadSections([indexPath.section], with: .none)
//                        }
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//
//            cell.nameCompletion  = {[unowned self] ( text) in
//                self.tableviewIndexPath = indexPath
//                if text != "" {
//                    self.dayOfAgeData[indexPath.row].name = text
//                    CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//
//                    UIView.performWithoutAnimation {
//                        self.tableview.reloadSections([indexPath.section], with: .none)
//                    }
//                }else {
//                    var ManufacturerId = 0
//                    var vManufacutrerNameArray = NSArray()
//                    var vManufacutrerIDArray = NSArray()
//                    var vManufacutrerDetailsArray = NSArray()
//                    vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
//                    vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "MfgName") as! NSArray
//                    vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "Id") as! NSArray
//                    let xxx =    self.dayOfAgeData[indexPath.row].vaccineMan ?? ""
//                    if xxx != "" {
//                        let indexOfd = vManufacutrerNameArray.index(of: xxx)
//                        ManufacturerId = vManufacutrerIDArray[indexOfd] as! Int
//                    } else {
//                        self.showtoast(message:"Select Vaccine Manufacturer")
//                        return
//                    }
//                    var indexArray : [Int] = []
//                    var vNameFilterArray : [String] = []
//                    var vNameArray = NSArray()
//                    var vNameDetailsArray = NSArray()
//                    var vNameMfgIdArray = NSArray()
//                    vNameDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
//                    vNameArray = vNameDetailsArray.value(forKey: "name") as! NSArray
//                    vNameMfgIdArray = vNameDetailsArray.value(forKey: "mfgId") as! NSArray
//                    var x = -1
//                    for obj in vNameMfgIdArray {
//                        x = x + 1
//                        if obj as! Int == ManufacturerId
//                        {
//                            _ = vNameMfgIdArray.index(of: obj)
//                            indexArray.append(x)
//                        }
//                    }
//                    _ = vNameMfgIdArray.index(of: ManufacturerId)
//                    for index in indexArray {
//                        let item = vNameArray[index] as? String ?? ""
//                        vNameFilterArray.append(item)
//                    }
//                    if  vNameFilterArray.count > 0 {
//                        self.dropDownVIewNew(arrayData: vNameFilterArray , kWidth: cell.tfName.frame.width, kAnchor: cell.tfName, yheight: cell.tfName.bounds.height) { [unowned self] selectedVal, index  in
//                            self.dayOfAgeData[indexPath.row].name = selectedVal
//                            CoreDataHandlerPE().updateDOAInDB(inovojectData:  self.dayOfAgeData[indexPath.row])
//
//                            UIView.performWithoutAnimation {
//                                self.tableview.reloadSections([indexPath.section], with: .none)
//                            }
//                        }
//                        self.dropHiddenAndShow()
//                    }
//                }
//            }
//            DispatchQueue.main.async {
//                cell.gradientVIew.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
//            }
//            return cell
//        }
//        return UITableViewCell() as! InovojectCell
//    }
//
//    func setupPEQuestionTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> PEQuestionTableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: PEQuestionTableViewCell.identifier) as? PEQuestionTableViewCell{
//            var assessment = catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//            let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
//            let boldMark1 =  "("
//            let boldMark2 =  ") "
//            let mrk = String(maxMarksIs)
//            cell.assessmentLbl.text =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
//            cell.assessmentLbl.attributedText =   cell.assessmentLbl.text?.withBoldText(text: boldMark1 + mrk + boldMark2)
//            if(indexPath.row % 2 == 0) {
//                cell.contentView.backgroundColor =  UIColor.cellAlternateBlueCOlor()
//            } else {
//                cell.contentView.backgroundColor =   UIColor.white
//            }
//            if assessment?.camera == 1 {
//                cell.cameraBTn.isEnabled = true
//                cell.cameraBTn.alpha = 1
//            } else {
//                cell.cameraBTn.isEnabled = false
//                cell.cameraBTn.alpha = 0.3
//            }
//            if assessment?.assStatus == 1 {
//                cell.switchClicked(status: true)
//                cell.switchBtn.setOn(true, animated: false)
//            } else {
//                cell.switchClicked(status: false)
//                cell.switchBtn.setOn(false, animated: false)
//            }
//            let imageCount = assessment?.images as? [Int]
//            let cnt = imageCount?.count
//            let ttle = String(cnt ?? 0)
//            cell.btnImageCount.setTitle(ttle,for: .normal)
//            if ttle == "0"{
//                cell.btnImageCount.isHidden = true
//            } else {
//                cell.btnImageCount.isHidden = false
//            }
//            let image1 = UIImage(named: "PEcomment.png")
//            let image2 = UIImage(named: "PECommentSelected.png")
//            if assessment?.note == "" {
//                cell.noteBtn.setImage(image1, for: .normal)
//            } else {
//                cell.noteBtn.setImage(image2, for: .normal)
//            }
//            cell.completion = { [unowned self] (status, error) in
//                self.tableviewIndexPath = indexPath
//                if status ?? false {
//                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
//                    let maxMarks =  assessment?.assMaxScore ?? 0
//                    result = result + Int(truncating: maxMarks)
//                    self.selectedCategory?.catResultMark = result
//                    assessment?.catResultMark = result as NSNumber
//                    self.resultScoreLabel.text = String(result)
//                    assessment?.assStatus = 1
//                } else {
//                    var result = Int(self.resultScoreLabel.text ?? "0") ?? 0
//                    let maxMarks = assessment?.assMaxScore ?? 0
//                    result = result - Int(truncating: maxMarks)
//                    self.selectedCategory?.catResultMark = result
//                    assessment?.catResultMark = result as NSNumber
//                    self.resultScoreLabel.text = String(result)
//                    assessment?.assStatus = 0
//                }
//                self.refreshTableView()
//               // self.refreshTableviewAndScrolToBottom(section: indexPath
//                //    .section)
//                self.updateScore()
//                self.chechForLastCategory()
//            }
//            cell.imagesCompletion  = {[unowned self] ( error) in
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "GroupImagesPEViewController") as! GroupImagesPEViewController
//                self.refreshArray()
//                assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//                vc.imagesArray = assessment?.images as! [Int]
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            cell.commentCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                self.refreshArray()
//                assessment = self.catArrayForTableIs[indexPath.row] as? PE_AssessmentInProgress
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
//                vc.textOfTextView = assessment?.note ?? ""
//                vc.infoText = assessment?.informationText ?? ""
//                vc.commentCompleted = { note in
//                    if note == "" {
//                        let image = UIImage(named: "PEcomment.png")
//                        cell.noteBtn.setImage(image, for: .normal)
//                    } else {
//                        let image = UIImage(named: "PECommentSelected.png")
//                        cell.noteBtn.setImage(image, for: .normal)
//                    }
//                    assessment?.note = note
//                }
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            cell.cameraCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                let assessment = self.catArrayForTableIs[self.tableviewIndexPath.row] as? PE_AssessmentInProgress
//                let images = CoreDataHandlerPE().getImagecountOfQuestion(assessment:assessment ?? PE_AssessmentInProgress())
//                if images < 5 {
//                    self.takePhoto(cell.cameraBTn)
//                } else {
//                    self.showAlertForNoCamera()
//                }
//            }
//            cell.infoCompletion = {[unowned self] ( error) in
//                self.tableviewIndexPath = indexPath
//                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
//                let vc = storyBoard.instantiateViewController(withIdentifier: "InfoPEViewController") as! InfoPEViewController
//                let maxMarksIs =  assessment?.assMaxScore as? Int ?? 0
//                let boldMark1 =  "("
//                let boldMark2 =  ") "
//                let mrk = String(maxMarksIs)
//                let str  =  boldMark1 + mrk + boldMark2 + (assessment?.assDetail1 ?? "")
//                vc.questionDescriptionIs = str
//                vc.imageDataBase64 = assessment?.informationImage ?? ""
//                vc.infotextIs = assessment?.informationText ?? ""
//                self.navigationController?.present(vc, animated: false, completion: nil)
//            }
//            return cell
//        }
//        return UITableViewCell() as! PEQuestionTableViewCell
//    }
//
//    func dropHiddenAndShow(){
//        if dropDown.isHidden{
//            let _ = dropDown.show()
//        } else {
//            dropDown.hide()
//        }
//    }
//
//    func doneButtonTappedWithDate(string: String, objDate: Date) {
//        certificateData[tableviewIndexPath.row].certificateDate = string
//        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id!)
//        tableview.reloadData()
//    }
//
//    func doneButtonTapped(string:String){
//        certificateData[tableviewIndexPath.row].certificateDate = string
//        CoreDataHandlerPE().updateVMixerInDB(peCertificateData:  self.certificateData[tableviewIndexPath.row], id:  self.certificateData[tableviewIndexPath.row].id!)
//        tableview.reloadData()
//    }
//
//    func showDatePicker(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
//        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
//        datePickerPopupViewController.delegate = self
//        datePickerPopupViewController.canSelectPreviousDate = false
//        navigationController?.present(datePickerPopupViewController, animated: false, completion: nil)
//
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if catArrayForTableIs.count > 0 {
//            if checkForTraning(){
//                if selectedCategory?.sequenceNo == 1 {
//                    if section == 1 {
//                        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewHeaderFooterView" ) as! PETableviewHeaderFooterView
//                        headerView.lblTitle.text = "Vaccine Mixer Observer"
//                        headerView.lblSubTitle.text = "Crew Information"
//                        headerView.addCompletion = {[unowned self] ( error) in
//                            let certificateData =  PECertificateData(id:0,name:"",date:"")
//                            let id = self.saveVMixerInPEModule(peCertificateData: certificateData)
//                            certificateData.id = id
//                            self.certificateData.append(certificateData)
//                            self.refreshTableviewAndScrolToBottom(section: section)
//                        }
//                        headerView.minusCompletion = {[unowned self] ( error) in
//                            if self.certificateData.count > 0 {
//                                let certificateData =  PECertificateData(id:0,name:"",date:"")
//                                let lastItem = self.certificateData.last
//                                self.delVMixerInPEModule(peCertificateData: lastItem ?? certificateData)
//                                self.certificateData.removeLast()
//                            }
//                            if self.certificateData.count > 1 {
//                                self.refreshTableviewAndScrolToBottom(section: section)
//                            } else {
//                                UIView.performWithoutAnimation {
//                                    self.tableview.reloadSections([section], with: .none)
//                                }
//                            }
//                        }
//                        return headerView
//                    }  else if section == 2 {
//                        return self.setPEInovojectHeaderFooterView(tableView, section: section)
//                    }
//                    else if section == 3 {
//                        return self.setPEHeaderDayOfAge(tableView, section: section)
//                    }
//                } else   if selectedCategory?.sequenceNo == 6 {
//                    if section == 1 {
//                        return self.setCustomerVaccineView(tableView,section: section)
//                    } else {
//                        return UIView()
//                    }
//                }
//            } else {
//                if selectedCategory?.sequenceNo == 6 {
//                    if section == 1 {
//                        return self.setCustomerVaccineView(tableView,section: section)
//                    } else {
//                        return UIView()
//                    }
//                }
//                if section == 1 {
//                    return self.setPEInovojectHeaderFooterView(tableView, section: section)
//                } else if section == 2 {
//                    return self.setPEHeaderDayOfAge(tableView, section: section)
//                }    else {
//                    return UIView()
//                }
//            }
//        }
//        return UIView()
//    }
//
//    func setCustomerVaccineView(_ tableView: UITableView , section:Int) -> PETableviewConsumerQualityHeader {
//        if selectedCategory?.sequenceNo == 6 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PETableviewConsumerQualityHeader" ) as! PETableviewConsumerQualityHeader
//            headerView.nameMicro.text =  self.peNewAssessment.micro
//            headerView.nameResidue.text =  self.peNewAssessment.residue
//            headerView.microComplete =
//                {[unowned self] ( error) in
//                    self.peNewAssessment.micro  = error ?? ""
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.residueComplete =
//                {[unowned self] ( error) in
//                    self.peNewAssessment.residue  = error ?? ""
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            return headerView
//        }
//        return UIView() as! PETableviewConsumerQualityHeader
//    }
//
//    func setPEInovojectHeaderFooterView(_ tableView: UITableView , section:Int) -> PEInovojectHeaderFooterView {
//        if selectedCategory?.sequenceNo == 1 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEInovojectHeaderFooterView" ) as! PEInovojectHeaderFooterView
//            headerView.lblTitle.text = "In Ovo"
//            headerView.txtCSize.text = peNewAssessment.iCS
//            headerView.txtDType.text = peNewAssessment.iDT
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 3 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchA = 1
//            }
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchA = 1
//                } else {
//                    self.switchA = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.addCompletion =
//                {[unowned self] ( error) in
//                    let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//                    if c == 0 {
//                        self.showtoast(message: "Please enter bag size")
//                        return
//                    }
//                    let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
//                    let id = self.saveInovojectInPEModule(inovojectData: inVoData)
//                    inVoData.id = id
//                    self.inovojectData.append(inVoData)
//                    self.refreshTableviewAndScrolToBottom(section: section)
//            }
//            headerView.minusCompletion = {[unowned self] ( error) in
//                if self.inovojectData.count > 0 {
//                    let lastItem = self.inovojectData.last
//                    self.deleteInovojectInPEModule(id: lastItem!.id ?? 0)
//                    self.inovojectData.removeLast()
//                }
//                if self.inovojectData.count > 1 {
//                    self.refreshTableviewAndScrolToBottom(section: section)
//                }  else {
//                    self.tableview.reloadData()
//                }
//            }
//            headerView.dTypeCompletion = {[unowned self] ( error) in
//                var vManufacutrerNameArray = NSArray()
//                var vManufacutrerDetailsArray = NSArray()
//                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DManufacturer")
//                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "diluentMfgName") as! NSArray
//                if  vManufacutrerNameArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: vManufacutrerNameArray as! [String], kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
//                        headerView.txtDType.text = selectedVal
//                        self.peNewAssessment.iDT = selectedVal
//                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//            headerView.cSizeCompletion = {[unowned self] ( error) in
//                var bagSizeArray = NSArray()
//                var bagSizeDetailsArray = NSArray()
//                bagSizeDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_BagSizes")
//                bagSizeArray = bagSizeDetailsArray.value(forKey: "size") as! NSArray
//               if  bagSizeArray.count > 0 {
//                    self.dropDownVIewNew(arrayData: bagSizeArray as! [String], kWidth: headerView.txtCSize.frame.width, kAnchor: headerView.txtCSize, yheight: headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
//                        headerView.txtCSize.text = selectedVal
//                        self.peNewAssessment.iCS = selectedVal
//                        CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                        self.updateDosageInvojectData(section: section)
//                    }
//                    self.dropHiddenAndShow()
//                }
//            }
//            return headerView
//        } else {
//            return UIView() as! PEInovojectHeaderFooterView
//        }
//    }
//
//    func updateDosageInvojectData(section:Int)  {
//        let c = Double(self.peNewAssessment.iCS ?? "0") ?? 0
//        if c == 0 {
//            self.showtoast(message: "Incomplete Data")
//            return
//        }
//        for obj in self.inovojectData{
//            let a = Double(obj.ampulePerBag ?? "0") ?? 0
//            let b = Double(obj.ampuleSize ?? "0") ?? 0
//            if  b != 0 {
//                let x = a * b
//                let y = c/0.05
//                let z = x/y
//                print(Rational(approximating: z))
//                let r  = Rational(approximating: z)
//                let n = String(r.numerator)
//                let d = String(r.denominator)
//                obj.dosage = n + "/" + d
//            }
//            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
//            UIView.performWithoutAnimation {
//                self.tableview.reloadSections([section], with: .none)
//            }
//        }
//    }
//
//    func setPEHeaderDayOfAge(_ tableView: UITableView , section:Int) -> PEHeaderDayOfAge {
//        if selectedCategory?.sequenceNo == 1 {
//            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PEHeaderDayOfAge" ) as! PEHeaderDayOfAge
//            headerView.lblTitle.text = "Day of Age"
//            headerView.txtCSize.text = peNewAssessment.dDT
//            headerView.txtDType.text = peNewAssessment.dCS
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//            headerView.switchHatchery.setOn(false, animated: false)
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 1 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchB = 1
//            }
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchB = 1
//                } else {
//                    self.switchB = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn1)
//            headerView.setDropdownStartAsessmentBtn(imageName: "dd",btn:headerView.btn2)
//            headerView.switchHatchery.setOn(false, animated: false)
//            if peNewAssessment.hatcheryAntibiotics == 4 || peNewAssessment.hatcheryAntibiotics == 1 {
//                headerView.switchHatchery.setOn(true, animated: false)
//                self.switchB = 1
//            }
//            headerView.switchCompletion = {[unowned self] ( status) in
//                if status ?? false {
//                    self.switchB = 1
//                } else {
//                    self.switchB = 0
//                }
//                if self.switchA == 1 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 4
//                } else if  self.switchA == 1 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 3
//                }  else if  self.switchA == 0 && self.switchB == 0 {
//                    self.peNewAssessment.hatcheryAntibiotics = 2
//                }  else if  self.switchA == 0 && self.switchB == 1 {
//                    self.peNewAssessment.hatcheryAntibiotics = 1
//                }
//                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//            }
//            headerView.addCompletion = {[unowned self] ( error) in
//                let c = self.peNewAssessment.dDT ?? ""
//                if c == "" {
//                    self.showtoast(message: "Please enter container size and type")
//                    return
//                }
//                let inVoData = InovojectData(id: 0,vaccineMan:"",name:"",ampuleSize:"",ampulePerBag:"",bagSizeType:"",dosage:"", dilute: "")
//                let id = self.saveDOAInPEModule(inovojectData: inVoData)
//                inVoData.id = id
//                self.dayOfAgeData.append(inVoData)
//                self.refreshTableviewAndScrolToBottom(section: section)
//            }
//            headerView.minusCompletion = {[unowned self] ( error) in
//                if self.dayOfAgeData.count > 0 {
//                    let lastItem = self.dayOfAgeData.last
//                    self.deleteDOAInPEModule(id: lastItem!.id ?? 0)
//                    self.dayOfAgeData.removeLast()
//                }
//                if self.dayOfAgeData.count > 1 {
//                    self.refreshTableviewAndScrolToBottom(section: section)
//                }  else {
//                    self.tableview.reloadData()
//                }
//            }
//
//            headerView.dTypeCompletion = {[unowned self] ( error) in
//
//                let arr = ["Distilled Water","Sterile Water"]
//                self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtDType.frame.width, kAnchor: headerView.txtDType, yheight: headerView.txtDType.bounds.height) { [unowned self] selectedVal, index  in
//                    headerView.txtDType.text = selectedVal
//                    self.peNewAssessment.dCS = selectedVal
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//
//                }
//                self.dropHiddenAndShow()
//            }
//            headerView.cSizeCompletion = {[unowned self] ( error) in
//                var arr = ["Plastic jug 2 gallon","Plastic jug 5 gallon","IV bag 2 litre","IV bag 2.4 litre","IV bag 2.8 litre"]
//                self.dropDownVIewNew(arrayData: arr, kWidth: headerView.txtCSize.frame.width, kAnchor:  headerView.txtCSize, yheight:  headerView.txtCSize.bounds.height) { [unowned self] selectedVal, index  in
//                    headerView.txtCSize.text = selectedVal
//                    self.peNewAssessment.dDT = selectedVal
//                    CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment: self.peNewAssessment)
//                }
//                self.dropHiddenAndShow()
//            }
//            return headerView
//        } else {
//            return UIView() as! PEHeaderDayOfAge
//        }
//    }
//
//    func updateDosageDayOfAgeData(section:Int)  {
//        if self.peNewAssessment.dDT == "Plastic jug 2 gallon" {
//            self.ml = 7570.82
//        } else if self.peNewAssessment.dDT == "Plastic jug 5 gallon" {
//            self.ml = 18927.05
//        } else if self.peNewAssessment.dDT == "IV bag 2 litre" {
//            self.ml = 2000.00
//        } else if self.peNewAssessment.dDT == "IV bag 2.4 litre" {
//            self.ml = 2400.00
//        } else if self.peNewAssessment.dDT == "IV bag 2.8 litre" {
//            self.ml = 2800.00
//        }
//        let c = self.ml
//        if c == 0.0 {
//            self.showtoast(message: "Incomplete Data")
//            return
//        }
//        for obj in self.dayOfAgeData{
//            let a = Double(obj.ampulePerBag ?? "0") ?? 0
//            let b = Double(obj.ampuleSize ?? "0") ?? 0
//            if a != 0 {
//                let x = a * b
//                let y = c*20
//                let z = x/y
//                print(Rational(approximating: z))
//                let r  = Rational(approximating: z)
//                let n = String(r.numerator)
//                let d = String(r.denominator)
//                obj.dosage = n + "/" + d
//            }
//            CoreDataHandlerPE().updateDOAInDB(inovojectData: obj)
//            UIView.performWithoutAnimation {
//                self.tableview.reloadSections([section], with: .none)
//            }
//        }
//    }
//
//    func refreshTableviewAndScrolToBottom(section:Int){
//        UIView.performWithoutAnimation {
//            self.tableview.reloadSections([section], with: .none)
//        }
//        scrollToBottom(section:section)
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section > 0 {
//            if selectedCategory?.sequenceNo == 1 {
//                return 95.0
//            }
//            if selectedCategory?.sequenceNo == 6 {
//                return 95.0
//            }
//        }
//        return 0.0
//    }
//
//    func scrollToBottom(section:Int){
//        var indexPathOfTab = IndexPath(row: 0, section: 0)
//        DispatchQueue.main.async {
//            if self.checkForTraning(){
//                if section == 1 {
//                    indexPathOfTab = IndexPath(
//                        row: self.certificateData.count - 1 ,
//                        section:1)
//                }
//                if section == 2 {
//                    indexPathOfTab = IndexPath(
//                        row: self.inovojectData.count - 1 ,
//                        section:2)
//                }
//                if section == 3 {
//                    indexPathOfTab = IndexPath(
//                        row: self.dayOfAgeData.count - 1 ,
//                        section:3)
//                }
//            } else {
//                if section == 1 {
//                    indexPathOfTab = IndexPath(
//                        row: self.inovojectData.count - 1 ,
//                        section:1)
//                }
//                if section == 2 {
//                    indexPathOfTab = IndexPath(
//                        row: self.dayOfAgeData.count - 1 ,
//                        section:2)
//                }
//            }
//            self.tableview.scrollToRow(at: indexPathOfTab, at: .none, animated: false)
//        }
//    }
//
//    func updateAssessmentInDb(assessment:PE_AssessmentInProgress) -> Bool {
//        var status = CoreDataHandlerPE().updateCatDetailsForStatus(assessment:assessment)
//        return status
//    }
//
//    func updateNoteAssessmentInProgressPE(assessment:PE_AssessmentInProgress) -> Bool {
//        var status = CoreDataHandlerPE().updateNoteAssessmentInProgress(assessment:assessment)
//        return status
//    }
//    func updateCategoryInDb(assessment:PENewAssessment) -> Bool {
//        var status = CoreDataHandlerPE().updateCategortIsSelcted(assessment:assessment)
//        return status
//    }
//}
//
//extension PEAssesmentFinalize : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return catArrayForCollectionIs.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewIDPE", for: indexPath as IndexPath) as! PECategoryCell
//        let category = catArrayForCollectionIs[indexPath.row]
//        cell.categoryLabel.text = category.catName ?? ""
//        return cell
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 250, height: 65)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt  indexPath: IndexPath) {
//
//        if checkNoteForEveryQuestion(){
//
//           selectedCategory?.catISSelected = 0
//           self.updateCategoryInDb(assessment:selectedCategory!)
//           let selectedCategoryIS = catArrayForCollectionIs[indexPath.row]
//           collectionviewIndexPath = indexPath
//           self.row = indexPath.row
//           selectedCategory = catArrayForCollectionIs[indexPath.row]
//           selectedCategory?.catISSelected = 1
//           self.updateCategoryInDb(assessment:selectedCategory!)
//           chechForLastCategory()
//           catArrayForTableIs = CoreDataHandlerPE().fetchCustomerWithCatID(selectedCategory?.sequenceNo as! NSNumber)
//           let totalMark = selectedCategory?.catMaxMark ?? 0
//           totalScoreLabel.text = String(totalMark)
//           resultScoreLabel.text = String(0)
//           tableview.reloadData()
//           updateScore()
//           refreshTableView()
//           }
//    }
//
//    func checkNoteForEveryQuestion() -> Bool{
//        self.refreshArray()
//        for  obj in catArrayForTableIs {
//            let assessment = obj as? PE_AssessmentInProgress
//            if assessment?.assStatus == 0 {
//                if assessment?.note == "" {
//                    self.showAlertForNoNote()
//                    return false
//                }
//            }
//        }
//        return true
//    }
//
//    func chechForLastCategory(){
//        var  peNewAssessmentArray = CoreDataHandlerPE().getOnGoingAssessmentArrayPEObject()
//        var catArrayForCollectionIsAre : [PENewAssessment] = []
//        var carColIdArray : [Int] = []
//        for cat in peNewAssessmentArray {
//            if !carColIdArray.contains(cat.sequenceNo!){
//                carColIdArray.append(cat.sequenceNo!)
//                catArrayForCollectionIsAre.append(cat)
//            }
//        }
//        let count = catArrayForCollectionIs.count - 1
//        if count > 0 {
//            if let cat = catArrayForCollectionIs[count] as? PENewAssessment {
//                if cat.sequenceNo == selectedCategory?.sequenceNo{
//                    buttonSaveAsDraft.isHidden = false
//                    buttonFinishAssessment.isHidden = false
//                    buttonSaveAsDraftInitial.isHidden = true
//                    bckButton.isHidden = true
//                } else {
//                    buttonSaveAsDraftInitial.isHidden = false
//                    buttonSaveAsDraft.isHidden = true
//                    buttonFinishAssessment.isHidden = true
//                    bckButton.isHidden = false
//                }
//            }
//            else {
//                buttonSaveAsDraftInitial.isHidden = false
//                bckButton.isHidden = false
//                buttonSaveAsDraft.isHidden = true
//                buttonFinishAssessment.isHidden = true
//            }
//            if let cat = catArrayForCollectionIs[0] as? PENewAssessment{
//                if cat.sequenceNo == selectedCategory?.sequenceNo{
//                    bckButton.isHidden = false
//                }  else {
//                    bckButton.isHidden = true
//                }
//            } else {
//                bckButton.isHidden = true
//            }
//        }
//    }
//
//    func validateForm() -> Bool {
//        if !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
//            if self.inovojectData.count > 0 {
//                let countt = self.inovojectData[0].vaccineMan?.count ?? 0
//                if countt < 1 {
//                    showAlertForNoValid()
//                    return false
//                }
//            } else {
//                showAlertForNoValid()
//                return false
//            }
//        }
//        if self.checkForTraning() && !(self.peNewAssessment.evaluationName?.contains("Non"))! ?? false  {
//            if self.certificateData.count > 0 {
//                let countt = self.certificateData[0].name?.count ?? 0
//                if countt < 1 {
//                    showAlertForNoValidTraining()
//                    return false
//                }
//            } else {
//                showAlertForNoValidTrainingName()
//                return false
//            }
//        }
//        return true
//    }
//
//    func showAlertForNoValid(){
//        let errorMSg = "Fill in ovo information to submit this assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoValidTraining(){
//        let errorMSg = "Please enter the certification details before submitting the assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoValidTrainingName(){
//        let errorMSg = "Fill name in vaccine mixer data to submit this assessment."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg , preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
//            _ in
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoCamera(){
//        let errorMSg = "You cannot exceed 5 images for 1 question."
//        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
//            _ in
//        }
//
//        alertController.addAction(cancelAction)
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func showAlertForNoNote(){
//           let errorMSg = "Please enter note for questions marked false that is mandatory."
//           let alertController = UIAlertController(title: "Alert", message: errorMSg , preferredStyle: .alert)
//
//           let cancelAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
//               _ in
//            self.collectionView.reloadData()
//            self.collectionView.selectItem(at: self.collectionviewIndexPath, animated: false, scrollPosition: .left)
//           }
//
//           alertController.addAction(cancelAction)
//           self.present(alertController, animated: true, completion: nil)
//       }
//}
//
//extension PEAssesmentFinalize{
//    func anyCategoryContainValueOrNot() -> Bool{
//        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
//        for obj in peNewAssessmentSurrentIs.peCategoryArray{
//            if obj.resultMark ?? 0 > 0 {
//                return true
//            }
//            return false
//        }
//        return false
//    }
//    func getCategoryAlreadyDone() -> PECategory{
//        let peNewAssessmentSurrentIs = ZoetisDropdownShared.sharedInstance.sharedPEOnGoingSession[0]
//        for obj in peNewAssessmentSurrentIs.peCategoryArray{
//            if obj.isSelected {
//                return obj
//            }
//        }
//        return PECategory(nil)
//    }
//}
//
//extension PEAssesmentFinalize: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
//    @objc func takePhoto(_ sender: UIButton) {
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            if UIImagePickerController.availableCaptureModes(for: .rear) != nil {
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .camera
//                imagePicker.cameraCaptureMode = .photo
//                imagePicker.delegate = self
//                present(imagePicker, animated: true, completion: {})
//            } else {
//                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
//            }
//        } else {
//            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
//        }
//
//    }
//
//    func postAlert(_ title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message,
//                                      preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
//        if let pickedImage: UIImage = (info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)]) as? UIImage {
//            let imageData: Data? = pickedImage.jpegData(compressionQuality: 0.02)
//            saveImageInPEModule(imageData:imageData!)
//            self.refreshArray()
//            let assessment = self.catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//            if let cell = tableview.cellForRow(at: tableviewIndexPath) as? PEQuestionTableViewCell {
//                let imageCount = assessment?.images as? [Int]
//                let cnt = imageCount?.count
//                let ttle = String(cnt ?? 0)
//                cell.btnImageCount.setTitle(ttle,for: .normal)
//                if ttle == "0"{
//                    cell.btnImageCount.isHidden = true
//                } else {
//                    cell.btnImageCount.isHidden = false
//                }
//            }
//        }
//        imagePicker.dismiss(animated: true, completion: {
//        })
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: {
//        })
//    }
//
//    private func saveImageInPEModule(imageData:Data){
//        let imageCount = getImageCountInPEModule()
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveImageInPEModule(assessment: assessment!, imageId: imageCount+1, imageData: imageData)
//    }
//
//    func getImageCountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_ImageEntity")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "imageId") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    private func saveDOAInPEModule(inovojectData:InovojectData) -> Int{
//        let imageCount = getDOACountInPEModule()
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveDOAPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData)
//        return imageCount+1
//
//    }
//
//    private func saveInovojectInPEModule(inovojectData:InovojectData) -> Int{
//        let imageCount = getDOACountInPEModule()
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveInovojectPEModule(assessment: assessment!, doaId: imageCount+1,inovojectData: inovojectData)
//        return imageCount+1
//    }
//
//    private func saveVMixerInPEModule(peCertificateData:PECertificateData) -> Int{
//        let imageCount = getVMixerCountInPEModule()
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().saveVMixerPEModule(assessment: assessment!, id: imageCount+1, peCertificateData: peCertificateData)
//        return imageCount+1
//    }
//
//    private func delVMixerInPEModule(peCertificateData:PECertificateData) {
//        let imageCount = getVMixerCountInPEModule()
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().subtractVMixerMinusCategortIsSelcted(assessment: assessment!, doaId: peCertificateData.id ?? 0)
//    }
//
//    func getDOACountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_DayOfAge")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "doaId") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    func getVMixerCountInPEModule() -> Int {
//        let allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VMixer")
//        let carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "vmid") as? NSArray ?? []
//        var carColIdArray : [Int] = []
//        for obj in carColIdArrayDraftNumbers {
//            if !carColIdArray.contains(obj as? Int ?? 0){
//                carColIdArray.append(obj as? Int ?? 0)
//            }
//        }
//        return carColIdArray.count
//    }
//
//    private func deleteDOAInPEModule(id:Int) {
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateDOAMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//
//    }
//    private func deleteInovojectInPEModule(id:Int) {
//        var assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//    }
//
//    private func deleteCrtificateInPEModule(id:Int) {
//        let assessment = catArrayForTableIs[tableviewIndexPath.row] as? PE_AssessmentInProgress
//        CoreDataHandlerPE().updateInovojectMinusCategortIsSelcted(assessment: assessment!, doaId: id)
//    }
//}
//
//private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
//    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
//}
//
//private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
//    return input.rawValue
//}
//
//public func  convertImageToBase64String(image : UIImage ) -> String
//{
//    let strBase64 =  image.pngData()?.base64EncodedString()
//    return strBase64!
//}
//
//
//
