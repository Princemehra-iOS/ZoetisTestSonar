//
//  EnviromentalSurveyController.swift
//  Zoetis -Feathers
//
//  Created by Abdul Shamim on 13/02/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import CoreData

class EnviromentalSurveyController: BaseViewController , UISearchBarDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var saveButtonAndDraftBurronView: UIView!
    @IBOutlet weak var saveAsDraftButton: GradientButton1!
    @IBOutlet weak var submitButton: customButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var notesView: UIView!
    var notesIndexPath = IndexPath()
    let sessionTypeStr = "isSessionType == %d"
    let requisitionAlreadyExist = "You have already added requisition with same date and site."
    let fillAllStr = "Please fill all mandatory fields"
    @IBOutlet weak var deleteBtn: UIButton!
    let userLogedIn = UserDefaults.standard.value(forKey: "FirstName") as? String ?? ""
    let userId =  UserDefaults.standard.value(forKey: "Id") as? String ?? ""
    var plateIdIndex = 0
    
    
    var currentRequisition = RequisitionModel()
    
    var isSubmitButtonPressed = false
    var currentRequisitionType = RequisitionType.enviromental
    var requisitionSavedSessionType = REQUISITION_SAVED_SESSION_TYPE.CREATE_NEW_SESSION
    
    var defaultBorderColor = UIColor(red: 204.0/255, green: 227.0/255, blue: 255.0/255, alpha: 1.0).cgColor
    
    var savedData = Microbial_EnviromentalSurveyFormSubmitted()
    var reviewerDetails : [MicrobialSelectedUnselectedReviewer] = []
    var dropButton = DropDown()
    var data: [String] = [String]()
    var dataFiltered: [String] = []
    var isSelectionStart = false
    
    enum STANDARD_TEMPLATE_TYPE: Int {
        case STD20 = 0
        case STD40 = 1
        case STD = 2

    }
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.saveButtonAndDraftBurronView.isHidden = (requisitionSavedSessionType == .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY)
        self.userNameLabel.text = userLogedIn
        self.configureTableView()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.currentRequisition.requisitionType = self.currentRequisitionType
        self.currentRequisition.generateLocationType()
        self.currentRequisition.generatebarCode()
        self.currentRequisition.generateHeader()
        
        self.configureRequisitionAsPerSavedSessionType()
        switch self.currentRequisition.requisitionType {
        case .bacterial:
            self.titleLabel.text = "Bacterial Survey Submission Form"
        case .enviromental:
            self.titleLabel.text = "Environmental Survey Submission Form"
        default:
            self.titleLabel.text = "Environmental Survey Submission Form"
        }
        if self.currentRequisition.isPlateIdGenerated{
            self.submitButton.setImage(nil, for: .normal)
            self.submitButton.backgroundColor = UIColor.blue
            self.submitButton.setTitle("DONE", for: .normal)
            self.submitButton.cornerRadius = 24.0
        }else{
            self.submitButton.setImage(UIImage(named: "BacterialSubmitImg"), for: .normal)

        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        switch requisitionSavedSessionType {
        case .CREATE_NEW_SESSION:
            self.removeIfUserDoesNotSaveAnythingInNewSession()
        default: break
        }
    }
    
    private func removeIfUserDoesNotSaveAnythingInNewSession(){
        let sessionDataArr = CoreDataHandlerMicro().fetchAllData("Microbial_EnviromentalSessionInProgress")
        if sessionDataArr.count == 0{
            let prediacateForSessionType = NSPredicate(format: sessionTypeStr, argumentArray: [true])
            MicrobialSelectedUnselectedReviewer.deleteReviewer(predicate: prediacateForSessionType)
        }
    }
    
        
    //MARK: - All Buttons action
    @IBAction func actionMenu(_ sender: Any) {
        
        switch requisitionSavedSessionType {
        case .RESTORE_OLD_SESSION, .CREATE_NEW_SESSION:
            self.startSavingInSession()
            
        default: break
        }
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
    }
    
    
    
    @IBAction func saveAsDraftPressed(_ sender: UIButton) {
        self.saveAsDraft()
    }

    @IBAction func notesDoneBtnClick(_ sender: UIButton) {
        self.currentRequisition.actualCreatedHeaders[notesIndexPath.section - 1].numberOfPlateIDCreated[notesIndexPath.row].notes = notesTextView.text
        self.currentRequisition.actualCreatedHeaders[notesIndexPath.section - 1].numberOfPlateIDCreated[notesIndexPath.row].isSelectedNote = true
        self.currentRequisition.actualCreatedHeaders[notesIndexPath.section - 1].numberOfPlateIDCreated[notesIndexPath.row].tag = notesIndexPath.row
            notesView.removeFromSuperview()
        
        let indexPath = IndexPath(row:notesIndexPath.row, section:notesIndexPath.section - 1)
       // tableView.reloadRows(at: [indexPath], with: .automatic)
       self.reloadTableView()
//        tableView.reloadData()
    }
    
    @IBAction func notesCancelBtnClick(_ sender: UIButton) {
        notesView.removeFromSuperview()
    }
    
    
    
    private func navigateToMocrobialViewController(){
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Microbial", bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MicrobialViewController") as! MicrobialViewController
//        navigationController?.pushViewController(vc, animated: true)
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MicrobialViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        self.isSubmitButtonPressed = true
        guard !self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .submitted) else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
            return
        }
        
        guard self.isAllSampleInfoMandatoryFiledsFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: fillAllStr)
            return
        }
        
        guard self.currentRequisition.barCode != "E-" else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Invalid Barcode")
            return
        }
        
        if self.currentRequisition.actualCreatedHeaders.count == 1 {
            guard self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0 else {
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please create plates before submit.")
                return
            }
        }
        
        if self.currentRequisition.actualCreatedHeaders.count > 1 {
            for plates in self.currentRequisition.actualCreatedHeaders{
                guard plates.numberOfPlateIDCreated.count > 0 else {
                    Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please create plates for all the locations added.")
                    return
                }
            }
        }
        
        guard self.isAllPlatesHaveLocationValue() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please select location value for all plates generated.")
            return
        }
        
        guard self.isSampleTextFieldFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please enter sample description.")
            return
        }

        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to submit?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.currentRequisition.isPlateIdGenerated = true
            self.finalSubmit()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    func generatePlateIdFirst() {

        self.currentRequisition.isPlateIdGenerated = !self.currentRequisition.isPlateIdGenerated
        for i in 0..<self.currentRequisition.actualCreatedHeaders.count{
            self.currentRequisition.actualCreatedHeaders[i].ischeckBoxSelected = true
        }
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.tableView.reloadData()
    }
    
    func finalSubmit(){
        self.currentRequisition.timeStamp = Date().getCurrentTimeStamp()
        self.currentRequisition.sessionStatus = SessionStatus.submitted
        if requisitionSavedSessionType != .SHOW_DRAFT_FOR_EDITING {
            self.currentRequisition.saveCaseInfoDataInToDB_Enviromental()
            self.currentRequisition.saveSampleInfoDataInToDB_Enviromental()
            self.currentRequisition.saveEnviromentalRequisitionalId()
            let predicate = NSPredicate(format: "isSessionType = %d", argumentArray: [true])
            MicrobialSelectedUnselectedReviewer.updateTimeStampFromSession(predicate: predicate, timeStamp: self.currentRequisition.timeStamp)
            CoreDataHandlerMicro().deleteAllData("Microbial_EnviromentalSessionInProgress")
            CoreDataHandlerMicro().deleteAllData("Microbial_LocationTypeHeaders")
            CoreDataHandlerMicro().deleteAllData("Microbial_LocationTypeHeaderPlates")
        }
        
        else {
            self.saveCurrentDataInLocalDB(isFinalSubmit: true)
        }
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: MicrobialViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
            }
        }

    }
    
    func saveCurrentSessionDataInToDB() {
        self.currentRequisition.saveCaseInfoCurrentSessionDataInToDB()
        self.currentRequisition.saveLocationTypeHeaderCurrentSessionInfoInDB()
        self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
        self.saveReviewersDataToDatabase(isSessionType: true)
        UserDefaults.standard.set(true, forKey: "sessionprogresss")
    }
    
    private func saveReviewersDataToDatabase(isSessionType: Bool){
        let prediacateForNonSessionType = NSPredicate(format: "timeStamp == %@", argumentArray: [self.currentRequisition.timeStamp])
        let prediacateForSessionType = NSPredicate(format: sessionTypeStr, argumentArray: [true])
        let doesReviewerExists = MicrobialSelectedUnselectedReviewer.doReviewersExisitsFortheTimeStamp(predicate: isSessionType ? prediacateForSessionType : prediacateForNonSessionType)
        if !doesReviewerExists{
            let reviewerDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_Reviewer") as! [Micro_Reviewer]
            for reviewer in reviewerDetailsArray  {
                let userId = UserDefaults.standard.value(forKey:"Id") ?? 0
                let isReviewerSelected = ((userId as! Int) == reviewer.reviewerId?.intValue ?? 0)
                MicrobialSelectedUnselectedReviewer.saveReviewersInDB( self.currentRequisition.timeStamp, reviewerId: reviewer.reviewerId?.intValue ?? 0, reviewerName: reviewer.reviewerName ?? "", isSelected: isReviewerSelected, isSessionType: isSessionType)
            }
        }
    }
    
    
    private func refreshReviewerData(){
        self.reviewerDetails.removeAll()
        switch requisitionSavedSessionType {
        case .CREATE_NEW_SESSION, .RESTORE_OLD_SESSION:
            let prediacateForSessionType = NSPredicate(format: sessionTypeStr, argumentArray: [true])
            self.reviewerDetails = MicrobialSelectedUnselectedReviewer.fetchDetailsForReviewer(predicate: prediacateForSessionType)
        case .SHOW_DRAFT_FOR_EDITING,.SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            let prediacateForNonSessionType = NSPredicate(format: "timeStamp == %@", argumentArray: [self.currentRequisition.timeStamp])
            self.reviewerDetails = MicrobialSelectedUnselectedReviewer.fetchDetailsForReviewer(predicate: prediacateForNonSessionType)
        }
    }
    
    fileprivate func isAllPlatesHaveLocationValue() -> Bool {
        for header in self.currentRequisition.actualCreatedHeaders {
            for plate in header.numberOfPlateIDCreated {
                if plate.selectedLocationValues.isEmpty {
                    return false
                }
            }
        }
        return true
    }
    //sampleDescriptionTextField
    
    fileprivate func isSampleTextFieldFilled() -> Bool {
        for header in self.currentRequisition.actualCreatedHeaders {
            for plate in header.numberOfPlateIDCreated {
                if (plate.selectedLocationValues == "Other") && plate.sampleDescription.isEmpty {
                    return false
                }
            }
        }
        return true
    }

    fileprivate func isAllSampleInfoMandatoryFiledsFilled() -> Bool {
        if  self.currentRequisition.company.isEmpty ||
            self.currentRequisition.site.isEmpty ||
            self.currentRequisition.barCode.isEmpty  
//                ||
//            self.currentRequisition.reviewer.isEmpty
        {
            
            return false
        }
        
        return true
    }
}


//MARK: - Table View Delegates and Configuration
extension EnviromentalSurveyController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight =  610
        self.tableView.separatorStyle = .none
        
        self.tableView.register(EnviromentalFormCell.nib, forCellReuseIdentifier: EnviromentalFormCell.identifier)
        self.tableView.register(BacterialFormCell.nib, forCellReuseIdentifier: BacterialFormCell.identifier)
        self.tableView.register(EnviromentalSampleInfoCell.nib, forCellReuseIdentifier: EnviromentalSampleInfoCell.identifier)
        
        self.tableView.register(UINib(nibName: "EnviromentalLocationHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "EnviromentalLocationHeaderView")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 + self.currentRequisition.actualCreatedHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            if self.currentRequisition.actualCreatedHeaders[section - 1].isHeaderIsCollapsed {
                return 0
            } else {
                return self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count
            }
            //return self.enviromentalSessionInProgressModel.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count
        }
    }
    
    
    //MARK: - Configure data for Enviromental
    fileprivate func configureData_Enviromental(_ cell: EnviromentalFormCell) {
        cell.reasonForVisitTextField.text = self.currentRequisition.reasonForVisit
        cell.requestorTextField.text = self.currentRequisition.requestor
        cell.sampleCollectedByText.text = self.currentRequisition.sampleCollectedBy
        cell.companyTextField.text = self.currentRequisition.company
        cell.siteTextField.text = self.currentRequisition.site
//        cell.emailIdTextField.text = self.currentRequisition.email
        cell.surveyConductedTextField.text = self.currentRequisition.surveyConductedOn
        cell.sampleDateTextField.text = self.currentRequisition.sampleCollectionDate
        cell.purposeOfSurveyTextField.text = self.currentRequisition.purposeOfSurvey
//        cell.transferInTextField.text = self.currentRequisition.transferIn
//        if self.currentRequisition.barCodeManualEntered.isEmpty == false {
//            self.currentRequisition.barCode = self.currentRequisition.barCodeManualEntered
//        }
        cell.barcodeTextField.text = self.currentRequisition.barCode
        cell.noteTextView.text = self.currentRequisition.notes
    }
    
    //MARK: - Configure data for Bacterial
   fileprivate func configureData_Bacterial(_ cell: BacterialFormCell) {
       cell.reasonForVisitTextField.text = self.currentRequisition.reasonForVisit
       cell.requestorTextField.text = self.currentRequisition.requestor
       cell.companyTextField.text = self.currentRequisition.company
       cell.siteTextField.text = self.currentRequisition.site
       cell.sampleDateTextField.text = self.currentRequisition.sampleCollectionDate
//       if self.currentRequisition.barCodeManualEntered.isEmpty == false {
//           self.currentRequisition.barCode = self.currentRequisition.barCodeManualEntered
//       }
       cell.barcodeTextField.text = self.currentRequisition.barCode
       cell.noteTextView.text = self.currentRequisition.notes
   }

    
    
    fileprivate func cellForRowOfBacterialCaseInfo(_ tableView: UITableView, indexPath: IndexPath) -> BacterialFormCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "BacterialFormCell", for: indexPath) as! BacterialFormCell
        cell.requisitionSavedSessionType = self.requisitionSavedSessionType
        cell.delegate = self
        cell.barcodeTextField.delegate = cell
//        cell.barcodeTextField.isUserInteractionEnabled = false
        
        cell.noteTextView.delegate = cell
        self.configureData_Bacterial(cell)
        if self.currentRequisition.actualCreatedHeaders.count > 0  {
            cell.configureMandatoryFiledsValidation(self.currentRequisition.actualCreatedHeaders[0], isSubmitButtonPressed: self.isSubmitButtonPressed, currentSessionInProgressModel: self.currentRequisition)
        }
        cell.disableAllEvents()
        return cell
    }
    
    
    fileprivate func cellForRowOfEnvironmentalCaseInfo(_ tableView: UITableView, indexPath: IndexPath) -> EnviromentalFormCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnviromentalFormCell", for: indexPath) as! EnviromentalFormCell
        cell.requisitionSavedSessionType = self.requisitionSavedSessionType
        cell.enviromentalFormCellDelegates = self
//        cell.emailIdTextField.delegate = cell
        cell.barcodeTextField.delegate = cell
//        cell.barcodeTextField.isUserInteractionEnabled = false
        cell.noteTextView.delegate = cell
        
        self.configureData_Enviromental(cell)
        if self.currentRequisition.actualCreatedHeaders.count > 0  {
            cell.configureMandatoryFiledsValidation(self.currentRequisition.actualCreatedHeaders[0], isSubmitButtonPressed: self.isSubmitButtonPressed, currentSessionInProgressModel: self.currentRequisition)
        }
        cell.disableAllEvents()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch self.currentRequisition.requisitionType {
            case .bacterial:
                return self.cellForRowOfBacterialCaseInfo(tableView, indexPath: indexPath)
            case .enviromental:
                return self.cellForRowOfEnvironmentalCaseInfo(tableView, indexPath: indexPath)
            default:
                return UITableViewCell()
            }
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnviromentalSampleInfoCell") as! EnviromentalSampleInfoCell
            cell.requisitionSavedSessionType = self.requisitionSavedSessionType
            cell.delegate = self
            cell.tag = indexPath.row
            cell.sampleDescriptionTextField.delegate = cell
            var locationTypeId = ""
            cell.notesButton.tag = indexPath.row
            cell.searchBarLocation.delegate = self
            cell.searchBarLocation.tag = 100 + indexPath.row
            dropButton.anchorView = cell.searchBarLocation
            
            dropButton.bottomOffset = CGPoint(x: 40 , y:(dropButton.anchorView?.bounds.height)! + 10)
            dropButton.backgroundColor = .white
            dropButton.direction = .top
            dropButton.tag = 100 + indexPath.row
            cell.searchBarLocation.placeholder = "Location Value"
            dropButton.dataSource = data as [AnyObject]
            dropButton.selectionAction = { [unowned self] (index: Int, item: String) in
            self.setValueInTextFields(selectedValue: item, selectedIndex:index, clickedField: Constants.ClickedFieldMicrobialSurvey.locationValue, cell: Constants.cell, view: view)
            }
            
            if let id = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].selectedLocationTypeId {
                locationTypeId = "\(id)"
            }
            cell.plateIdLabel.text = ""
            let key = "\(String(describing: locationTypeId)) - \(indexPath.section) - \(indexPath.row + 1)"
          
            if let index = self.generatePlateIndex()[key] {
                self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].plateId = "\(self.currentRequisition.barCode)-\(index)"
                print("your plate id in cell :\(index)  : \(self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].plateId)")
                if requisitionSavedSessionType == .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY{
                    cell.plateIdLabel.text = "\(self.currentRequisition.barCode)-\(index)"
                    print("your plate id is here a: \(self.currentRequisition.barCode)-\(index)")
                    cell.infoDetailButton.isHidden = false
                    cell.plateIdLabel.isHidden = true
                    saveButtonAndDraftBurronView.isHidden = true
                    cell.infoIconImage.isHidden = true
                    
                    cell.addInfoPlate = { sender in
                        
                        let alert:UIAlertController = UIAlertController(title: "\(self.currentRequisition.barCode)-\(index)", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                        alert.addAction(cancelAction)
                        
                        var popover:UIPopoverController?=nil
                        popover = UIPopoverController(contentViewController: alert)
                        popover!.present(from: sender.frame, in: cell, permittedArrowDirections: UIPopoverArrowDirection.down, animated: true)
                        
                    }
                                                    
                }else{
                    cell.plateIdLabel.text = "\(index)"
                    cell.plateIdLabel.textAlignment = .center
                    cell.infoDetailButton.isHidden = true
                    cell.plateIdLabel.isHidden = false
                    cell.infoIconImage.isHidden = true
                }
            }
           
            cell.sampleDescriptionTextField.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].sampleDescription
            
            if requisitionSavedSessionType == .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY {
                cell.searchBarLocation.isHidden = true
                cell.locationValueTextField.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues
                cell.locationValueTextField.isHidden = false
                saveButtonAndDraftBurronView.isHidden = true
                cell.samplingTypeButton.isUserInteractionEnabled = false
                cell.noteButtonNew.isUserInteractionEnabled = false
              //  cell.isUserInteractionEnabled = false
                cell.selectionStyle = .none
            }
            else {
                cell.searchBarLocation.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues
            }
          
//            if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues.contains(stringOne) {
                if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaTypeValue == "" {
                    cell.mediaTypeTextField.text =   self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaDefault
                    self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaTypeValue = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaDefault ?? ""
                    self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedMediaTypeId = 1
                   
                    }
                    else {
                        cell.mediaTypeTextField.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaTypeValue
                    }

            if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeValue == "" {
                cell.samplingTextField.text =   self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingDefault
                
                self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeValue = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingDefault ?? ""
                self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeId = 1
                }
                else {
                    cell.samplingTextField.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeValue
                }

            print("your section no. : \(indexPath.section - 1) and index no: \(indexPath.row) and note string : \(self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].notes)")
 
            if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues != "Other" {
                //                cell.sampleDescriptionTextField.isEnabled = false
                cell.sampleDescriptionButton.backgroundColor =  UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 0.2)
            } else {
                //                cell.sampleDescriptionTextField.isEnabled = true
                cell.sampleDescriptionButton.backgroundColor = .white
            }
            
            if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isBacterialChecked {
                cell.bacterialCheckBoxButton.setImage(UIImage(named: "checkIcon"), for: .normal)
            } else {
                cell.bacterialCheckBoxButton.setImage(UIImage(named: "uncheckIcon"), for: .normal)
            }
       //  cell.notesButton.setImage(UIImage(named: "PEComment"), for: .normal)
            print("note button is selected : \(self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isSelectedNote)")
           // cell.notesButton.setImage(UIImage(named: "pe_comments"), for: .normal)
          //  DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if  self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].notes.count > 0 {
                    cell.noteButtonNew.setImage(UIImage(named: "PECommentSelected"), for: .normal)
                    //checkIcon  PECommentSelected
                 //   isSelectionStart = true
                }
                else{
                  //  if isSelectionStart {
                    cell.noteButtonNew.contentMode = .scaleToFill
                    cell.noteButtonNew.setTitle("", for: .normal)
                   
                    cell.noteButtonNew.setImage(UIImage(named: "NewImgeComment"), for: .normal)
                      //  cell.noteButtonNew.setImage(UIImage(named: "PEComment"), for: .normal)
                   // }
                }
         //  }
             
           
//
            
//            cell.bacterialCheckBoxButton.isEnabled = !(self.currentRequisitionType == .bacterial)
            
            if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isMicoscoreChecked {
               // cell.micoscoreCheckBoxButton.setImage(UIImage(named: "checkIcon"), for: .normal)
            } 
            
            if self.isSubmitButtonPressed && self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues.isEmpty {
                cell.locationValueButton.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.locationValueButton.layer.borderColor = defaultBorderColor
            }
            
            if self.isSubmitButtonPressed && (self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].sampleDescription == "") && (self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues == "Other") {
                cell.sampleDescriptionButton.layer.borderColor = UIColor.red.cgColor
            } else {
                cell.sampleDescriptionButton.layer.borderColor = defaultBorderColor
            }
            
            cell.lineBetweenCellsView.isHidden = false
            cell.lineBetweenCellsViewHeight.constant = 1
            if (self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated.count - 1) == indexPath.row {
                cell.lineBetweenCellsView.isHidden = true
                cell.lineBetweenCellsViewHeight.constant = 0
            }
            cell.isPlateIdGenerated = self.currentRequisition.isPlateIdGenerated
            cell.disableAllEventsAccordingToSavedSession()
            cell.disableAllEventsAccordingToPlateIdsGenerated()
            return cell
        }
    }
    @objc func addInfoPopup(PlateID : String){

        showtoast(message: PlateID)
         //  loadPopupVw(index: sender.tag)

       }
    private func loadPopupVw(index: Int){
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
        vc.headerValue = "Rejection Comment"
        //        vc.titleValue = "Comment"
        vc.textOfTextView = "SS"
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    //MARK: - Mandatory Fields Validation for Header
    func mandatoryFieldValidationForHeader(_ view: EnviromentalLocationHeaderView, section: Int) {
        if self.currentRequisition.actualCreatedHeaders[view.tag].isPlusButtonPressed &&
            self.currentRequisition.actualCreatedHeaders[view.tag].selectedLocationType == "Select location type" {
            view.locationTypeButton.layer.borderColor = UIColor.red.cgColor
        } else {
            view.locationTypeButton.layer.borderColor = defaultBorderColor
        }
        
        if self.currentRequisition.actualCreatedHeaders[view.tag].isPlusButtonPressed &&
            self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates == 0 {
            view.noOfPlatesButton.layer.borderColor = UIColor.red.cgColor
        } else {
            view.noOfPlatesButton.layer.borderColor = defaultBorderColor
        }
    }
    
    //MARK: - Set Up Header View
    fileprivate func setUpHeaderView(_ headerView: EnviromentalLocationHeaderView, _ section: Int) {
        headerView.addLocationButton.isHidden = section == 1 ? false : true
        headerView.generatePlateIdButton.isHidden = true //section == 1 ? false : true
//        headerView.generatePlateIdButton.isEnabled = self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0
            //(self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.count > 0) ? true : false
        headerView.deleteLocationButton.isHidden = section == 1 ? false : true
        headerView.btnsStackView.isHidden = section == 1 ? false : true
        headerView.btnStd40.isHidden = section == 1 ? false : true
        headerView.btnStd20.isHidden = section == 1 ? false : true
        headerView.sampleInfoTitleContainerView.isHidden = section == 1 ? false : true
        headerView.sampleInfoTitleLabel.isHidden = section == 1 ? false : true
        
        headerView.sampleInfoTitleContainerViewHeight.constant = section == 1 ? 60 : 0
        headerView.sampleInfoTitleContainerViewTop.constant = section == 1 ? 34 : 15
        
        if self.currentRequisition.actualCreatedHeaders[section - 1].noOfPlates > 0 {
            headerView.noOfPlatesTextField.text = "\(self.currentRequisition.actualCreatedHeaders[section - 1].noOfPlates)"
        } else {
            headerView.noOfPlatesTextField.text = ""
        }
        
        headerView.locationTypeTextField.text = self.currentRequisition.actualCreatedHeaders[section - 1].selectedLocationType
      
        
        headerView.noOfPlatesTextField.isUserInteractionEnabled = !(self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0)
        headerView.locationTypeButton.isUserInteractionEnabled = !(self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0)
        

        if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count == 200 {
            headerView.plusButton.isEnabled = false
        } else {
            headerView.plusButton.isEnabled = true
        }
        
        if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count == 0 {
            headerView.minusButton.isEnabled = false
        } else {
            headerView.minusButton.isEnabled = true
        }

        if self.currentRequisition.actualCreatedHeaders[section - 1].ischeckBoxSelected {
            headerView.checkBoxButton.setImage(UIImage(named: "checkedIcon_new"), for: .normal)
        } else {
            headerView.checkBoxButton.setImage(UIImage(named: "uncheckIcon_new"), for: .normal)
        }
        
        if self.currentRequisition.actualCreatedHeaders[section - 1].isHeaderIsCollapsed {
            headerView.collapsableButton.setImage(UIImage(named: "expand_view_icon"), for: .normal)
            headerView.platesTitleView.isHidden = true
            headerView.backgrounfView.isHidden = true
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0 {
                headerView.locationTypeContainerViewHeight.constant = 68
            } else {
                headerView.locationTypeContainerViewHeight.constant = 68
            }
        } else {
            headerView.collapsableButton.setImage(UIImage(named: "collapse_view_icon"), for: .normal)
            headerView.platesTitleView.isHidden = false
            headerView.backgrounfView.isHidden = false
            
            headerView.platesTitleView.isHidden = !(self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0)
//            headerView.platesTitleView.roundCorners(corners: [.topLeft, .topRight], radius: 21.0)
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0 {
                headerView.locationTypeContainerViewHeight.constant = 68
                headerView.backgrounfView.isHidden = false
            } else {
                headerView.locationTypeContainerViewHeight.constant = 68
                headerView.backgrounfView.isHidden = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        default:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "EnviromentalLocationHeaderView" ) as! EnviromentalLocationHeaderView
            headerView.delegate = self
            headerView.noOfPlatesTextField.keyboardType = .numberPad
            headerView.noOfPlatesTextField.delegate = headerView
            headerView.locationTypeButton.tag = section - 1
            headerView.tag = section - 1
            headerView.noOfPlatesTextField.placeholder = "0"
            headerView.btnStd40.isEnabled = !(self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0)
            headerView.btnStd40.alpha = (self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0) ? 0.5 : 1.0
            headerView.btnStd20.isEnabled = !(self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0)
            headerView.btnStd20.alpha = (self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0) ? 0.5 : 1.0
            headerView.btnStd.isEnabled = !(self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0)
            headerView.btnStd.alpha = (self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0) ? 0.5 : 1.0
           
            if self.currentRequisition.actualCreatedHeaders.count == 1 {
                headerView.deleteLocationButton.isEnabled = false
                self.deleteBtn.isEnabled = false
                headerView.checkBoxButton.isEnabled = false
            } else {
                headerView.deleteLocationButton.isEnabled = true
                self.deleteBtn.isEnabled = true
                headerView.checkBoxButton.isEnabled = true
            }
            
            if self.currentRequisitionType == .enviromental {
                headerView.btnStd.isHidden = false
            }else{
                headerView.btnStd.isHidden = true
            }
            
            self.setUpHeaderView(headerView, section)
            
            self.mandatoryFieldValidationForHeader(headerView, section: section - 1)
            self.enableDisableButtonsOnGeneratingPlateId(headerView: headerView)
            self.disableAllEventsOnHeader(headerView: headerView)
            headerView.btnStd40.isHidden = (self.currentRequisitionType == .enviromental)
            headerView.btnStd20.isHidden = (self.currentRequisitionType == .enviromental)

            return headerView
        }
    }
    
    
    func enableDisableButtonsOnGeneratingPlateId(headerView: EnviromentalLocationHeaderView){
        headerView.generatePlateIdButton.isEnabled = (self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0) && !self.currentRequisition.isPlateIdGenerated
        if self.currentRequisition.isPlateIdGenerated{
            headerView.addLocationButton.isEnabled = false
            headerView.deleteLocationButton.isEnabled = true
            self.deleteBtn.isEnabled = true
            headerView.plusButton.isEnabled = false
            headerView.minusButton.isEnabled = false
            headerView.locationTypeButton.isEnabled = false
        }else{
            headerView.addLocationButton.isEnabled = true
            headerView.deleteLocationButton.isEnabled = self.isCheckBoxSelectedInOfPlatesHeaders()
            self.deleteBtn.isEnabled = self.isCheckBoxSelectedInOfPlatesHeaders()
            headerView.plusButton.isEnabled = true
            headerView.minusButton.isEnabled = true
            headerView.locationTypeButton.isEnabled = true
        }
    }
    
    
    func isCheckBoxSelectedInOfPlatesHeaders() -> Bool{
        for plateHeader in self.currentRequisition.actualCreatedHeaders{
            if plateHeader.ischeckBoxSelected{
                return true
            }
        }
        return false
    }
    
    func disableAllEventsOnHeader(headerView: EnviromentalLocationHeaderView){
        switch requisitionSavedSessionType {
        case .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            headerView.noOfPlatesTextField.isUserInteractionEnabled = false
            headerView.locationTypeButton.isEnabled = false
            headerView.locationTypeButton.isEnabled = false
            headerView.noOfPlatesButton.isEnabled = false
            headerView.checkBoxButton.isEnabled = false
            headerView.addLocationButton.isEnabled = false
            headerView.plusButton.isEnabled = false
            headerView.minusButton.isEnabled = false
            headerView.deleteLocationButton.isEnabled = false
            self.deleteBtn.isEnabled = false
            headerView.generatePlateIdButton.isEnabled = false
            headerView.btnStd20.isEnabled = false
            headerView.btnStd40.isEnabled = false
            headerView.btnStd.isEnabled = false

        default: break
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch self.currentRequisition.requisitionType {
            case .bacterial:
                return 480
            case .enviromental:
                return 560
            default:
                return 610
            }
        default:
            return 60
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0.001
            
        case 1:
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].isHeaderIsCollapsed {
                 return 149
            }
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0 {
                return 195
            } else {
                return 180
            }
            
        default:
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].isHeaderIsCollapsed {
                if (self.currentRequisition.actualCreatedHeaders.count - 1) == (section - 1) {
                    return 80
                }
                return 70
            }
            
            if self.currentRequisition.actualCreatedHeaders[section - 1].numberOfPlateIDCreated.count > 0 {
                return 115
            } else {
                return 70
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}


//MARK: - Enviromental Form Cell Delegates
extension EnviromentalSurveyController: EnviromentalFormCellDelegates {
    
    func emailEntered(cell: EnviromentalFormCell, activeTextField: UITextField) {
        print(activeTextField.text ?? "Not working")
        if activeTextField == cell.emailIdTextField {
            let email = activeTextField.text ?? ""
            let arrayOfEmail = email.components(separatedBy: ",")
            self.currentRequisition.email = email
            for item in arrayOfEmail {
                guard item.isValidEmail() else {
                    if email.isEmpty {
                        cell.emailButton.layer.borderColor = defaultBorderColor
                    } else {
                        cell.emailButton.layer.borderColor = UIColor.red.cgColor
                    }
                    return
                }
            }
            
            cell.emailButton.layer.borderColor = defaultBorderColor
        }
        
        if activeTextField == cell.barcodeTextField {
            self.currentRequisition.barCodeManualEntered = activeTextField.text ?? ""
            self.currentRequisition.barCode = activeTextField.text ?? ""
        }
        if requisitionSavedSessionType != .SHOW_DRAFT_FOR_EDITING{
            self.currentRequisition.saveCaseInfoCurrentSessionDataInToDB()
        }
        self.currentRequisition.updateNewBarcodeEditted()
        self.reloadTableView()
    }
    
    func noteEntered(cell: EnviromentalFormCell, activeTextView: UITextView) {
        if let text = activeTextView.text {
            self.currentRequisition.notes = text
        }
        self.currentRequisition.saveCaseInfoCurrentSessionDataInToDB()
    }
    
    func reasonForVisitButtonPressed(_ cell: EnviromentalFormCell) {
        let reasonForVisitObjectArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_AllMicrobialVisitTypes")
        let reasonsForVisit = reasonForVisitObjectArray.value(forKey: "text")  as? [String] ?? []
        setDropdrown(cell.reasonForVisitButton, clickedField: Constants.ClickedFieldMicrobialSurvey.reasonForVisit, dropDownArr: reasonsForVisit, cell: cell)
    }
    
    func sampleCollectedPressed(_ cell: EnviromentalFormCell) {
        self.setDropdrown(cell.sampleCollectedByButton, clickedField: Constants.ClickedFieldMicrobialSurvey.SampleCollectedBy, dropDownArr: [userLogedIn], cell: cell)
    }
    
    func companyButtonPressed(_ cell: EnviromentalFormCell) {
        let customerDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_Customer")
        let customerNamesArray  = customerDetailsArray.value(forKey: "customerName") as? [String] ?? []
        self.setDropdrown(cell.companyButton, clickedField: Constants.ClickedFieldMicrobialSurvey.company, dropDownArr: customerNamesArray, cell: cell)
    }
    
    func siteButtonPressed(_ cell: EnviromentalFormCell) {
        guard !self.currentRequisition.company.isEmpty else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please select company first.")
            return
        }
        let sitesObjectArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_siteByCustomer", customerId: self.currentRequisition.companyId)
        let sitesArray = sitesObjectArray.value(forKey: "siteName") as? [String] ?? []
        
        if sitesArray.count == 0 {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "There are no sites for selected company")
            return
        }
        
        self.currentRequisition.barCodeManualEntered = ""
        self.setDropdrown(cell.siteButton, clickedField: Constants.ClickedFieldMicrobialSurvey.siteId, dropDownArr: sitesArray, cell: cell)
    }
    
    func reviewerButtonPressed(_ cell: EnviromentalFormCell) {
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.presentReviewerController()
    }
    
    func surveyConductedButtonPressed(_ cell: EnviromentalFormCell) {
        let surveyConductOnDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_AllConductType")
        let surveyConductOnArray = surveyConductOnDetailsArray.value(forKey: "text") as? [String] ?? []
        self.setDropdrown(cell.surveyConductedButton, clickedField: Constants.ClickedFieldMicrobialSurvey.surveyCondustedOn, dropDownArr: surveyConductOnArray, cell: cell)
    }
    
    func sampleDateButtonPressed(_ cell: EnviromentalFormCell) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.selection, bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier:  Constants.ControllerIdentifier.datePickerPopupViewController) as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        datePickerPopupViewController.canSelectPreviousDate = true
        present(datePickerPopupViewController, animated: false, completion: nil)
    }
    
    func purposeOfSurveyButtonPressed(_ cell: EnviromentalFormCell) {
        let allSurveyPurposDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_AllSurveyPurpose")
        let allSurveyPurposeArray = allSurveyPurposDetailsArray.value(forKey: "text") as? [String] ?? []
        self.setDropdrown(cell.purposeOfSurveyButton, clickedField: Constants.ClickedFieldMicrobialSurvey.purposeOfSurvey, dropDownArr: allSurveyPurposeArray, cell: cell)
    }
    
    func transferInButtonPressed(_ cell: EnviromentalFormCell) {
        let microbialTransferTypesDetailArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_AllMicrobialTransferTypes")
        let microbialTransferTypesArray = microbialTransferTypesDetailArray.value(forKey: "text") as? [String] ?? []
        self.setDropdrown(cell.transferInButton, clickedField: Constants.ClickedFieldMicrobialSurvey.transferIn, dropDownArr: microbialTransferTypesArray, cell: cell)
    }
    
    //MARK: - Drop down View load
    
    func getLocationValuesOnType(locationTypeId: Int){
        
        let locationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: locationTypeId).locationValues
        dataFiltered = locationValues
        data = locationValues
        
//        var HatchLocationValues: [String] = []
//        var SetterslocationValues: [String] = []
//        var HallVentilatiolocationValues: [String] = []
//        var HatcherVentilationlocationValues: [String] = []
//        var GenerallocationValues: [String] = []
//        var MislocationValues: [String] = []
//      
//        
//        if self.currentRequisitionType.rawValue == 1 {
//            // Bacterial
//            HatchLocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 9).locationValues
//            SetterslocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 10).locationValues
//            HallVentilatiolocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 12).locationValues
//            HatcherVentilationlocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 15).locationValues
//            GenerallocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 16).locationValues
//            MislocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 17).locationValues
//        }
//        else
//        {
//            //environmental
//             HatchLocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 1).locationValues
//             SetterslocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 2).locationValues
//             HallVentilatiolocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 3).locationValues
//             HatcherVentilationlocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 4).locationValues
//             GenerallocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 18).locationValues
//             MislocationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: 19).locationValues
//        }
//        
//        
//        dataFiltered =  HatchLocationValues + SetterslocationValues + HallVentilatiolocationValues + HatcherVentilationlocationValues + GenerallocationValues + MislocationValues //locationValues
//        data = HatchLocationValues + SetterslocationValues + HallVentilatiolocationValues + HatcherVentilationlocationValues + GenerallocationValues + MislocationValues //locationValues
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        dropButton.dataSource.removeAll()
            dataFiltered = searchText.isEmpty ? data : data.filter({ (dat) -> Bool in
                dat.range(of: searchText, options: .caseInsensitive) != nil
            })
      
        dropButton.dataSource = dataFiltered as [AnyObject]
       
     //   }
        print("your data is here : \(dataFiltered)")
        let cell = searchBar.superview?.superview?.superview?.superview as! EnviromentalSampleInfoCell
       self.setDropdrown(cell.locationValueButton, clickedField: Constants.ClickedFieldMicrobialSurvey.locationValue, dropDownArr: dataFiltered, cell: cell)
     //   d
        
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        
        // previous code   self.getLocationValuesOnType(locationTypeId: self.currentRequisition.getAllLocationTypes().locationTypeIds[Constants.locationValueType])
        
        var selectedIndex = 0
        var superview = searchBar.superview
        while let view = superview, !(view is UITableViewCell) {
            superview = view.superview
        }
        
        if let cell = superview as? UITableViewCell {
            if let indexPath = tableView.indexPath(for: cell) {
                selectedIndex = indexPath.section-1
            }
        }
        
        if requisitionSavedSessionType == .SHOW_DRAFT_FOR_EDITING {
            let idOfSelectedLocationTypeIs = self.currentRequisition.actualCreatedHeaders[selectedIndex].selectedLocationTypeId ?? 0
            self.getLocationValuesOnType(locationTypeId: idOfSelectedLocationTypeIs)
        }
        else
        {
            let idOfSelectedLocationTypeIs = currentRequisition.selectedLocationTypes[selectedIndex]
            self.getLocationValuesOnType(locationTypeId: idOfSelectedLocationTypeIs)
        }

        Constants.cell = searchBar.superview?.superview?.superview?.superview as! EnviromentalSampleInfoCell
        
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
       // searchBar.text = ""
        dataFiltered = data
        dropButton.hide()
    }
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    
    
    
    
    
    func setDropdrown(_ sender: UIButton, clickedField:String, dropDownArr:[String]?, cell: UITableViewCell? = nil, view: UIView? = nil){
        if  dropDownArr!.count > 0 {
            self.dropDownVIewNew(arrayData: dropDownArr!, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) {  selectedVal, index  in
                self.dropHiddenAndShow()
                self.setValueInTextFields(selectedValue: selectedVal, selectedIndex: index, clickedField: clickedField, cell: cell, view: view)
            }
            self.dropHiddenAndShow()
        }
    }
    
    func setValueInTextFields(selectedValue: String, selectedIndex: Int, clickedField:String, cell: UITableViewCell?, view: UIView? = nil) {
        switch clickedField {
        case Constants.ClickedFieldMicrobialSurvey.reasonForVisit:
            if let cell = cell as? EnviromentalFormCell {
                cell.reasonForVisitTextField.text = selectedValue
                self.currentRequisition.reasonForVisit = selectedValue
                self.currentRequisition.reasonForVisitId = self.currentRequisition.getReasonForVisitId()
            } else if let cell = cell as? BacterialFormCell  {
                cell.reasonForVisitTextField.text = selectedValue
                self.currentRequisition.reasonForVisit = selectedValue
                self.currentRequisition.reasonForVisitId = self.currentRequisition.getReasonForVisitId()
            }
         
        case Constants.ClickedFieldMicrobialSurvey.SampleCollectedBy:
            guard let cell = cell as? EnviromentalFormCell  else {
                return
            }
            cell.sampleCollectedByText.text = selectedValue
            self.currentRequisition.sampleCollectedBy = selectedValue
            
        case Constants.ClickedFieldMicrobialSurvey.company:
            if let cell = cell as? EnviromentalFormCell  {
                cell.companyTextField.text = selectedValue
            } else if let cell = cell as? BacterialFormCell  {
                cell.companyTextField.text = selectedValue
            }
            
            if self.currentRequisition.company != selectedValue {
                self.currentRequisition.resetSiteAndBarCode()
            }
            self.isSubmitButtonPressed = false
            self.currentRequisition.company = selectedValue
            self.currentRequisition.companyId = self.currentRequisition.getCompanyIdforSelectedCompany()
            
        case Constants.ClickedFieldMicrobialSurvey.siteId:
            if let cell = cell as? EnviromentalFormCell  {
                cell.siteTextField.text = selectedValue
                
            } else if let cell = cell as? BacterialFormCell  {
                cell.siteTextField.text = selectedValue
                
            }
            self.currentRequisition.site = selectedValue
            self.currentRequisition.siteId = self.currentRequisition.getSiteIdforSelectedSite()
            self.currentRequisition.generatebarCode()
            
        case Constants.ClickedFieldMicrobialSurvey.reviewer:
            if let cell = cell as? EnviromentalFormCell  {
                self.currentRequisition.reviewer = selectedValue
                self.currentRequisition.reviewerId = self.currentRequisition.getReviewerId()
            } else if let cell = cell as? BacterialFormCell  {
                self.currentRequisition.reviewer = selectedValue
                self.currentRequisition.reviewerId = self.currentRequisition.getReviewerId()
            }
           
        case Constants.ClickedFieldMicrobialSurvey.surveyCondustedOn:
            guard let cell = cell as? EnviromentalFormCell  else {
                return
            }
            cell.surveyConductedTextField.text = selectedValue
            self.currentRequisition.surveyConductedOn = selectedValue
            self.currentRequisition.surveyConductedOnId = self.currentRequisition.getSurveyConductedOnId()
            
        case Constants.ClickedFieldMicrobialSurvey.purposeOfSurvey:
            guard let cell = cell as? EnviromentalFormCell  else {
                return
            }
            cell.purposeOfSurveyTextField.text = selectedValue
            self.currentRequisition.purposeOfSurvey = selectedValue
            self.currentRequisition.purposeOfSurveyId = self.currentRequisition.getPurposeOfSurveyId()
            
        case Constants.ClickedFieldMicrobialSurvey.transferIn:
            guard let cell = cell as? EnviromentalFormCell  else {
                return
            }
            cell.transferInTextField.text = selectedValue
            self.currentRequisition.transferIn = selectedValue
            
        case Constants.ClickedFieldMicrobialSurvey.locationType:
            guard let headerView = view as? EnviromentalLocationHeaderView  else {
                return
            }
            headerView.locationTypeTextField.text = selectedValue
            
            self.currentRequisition.actualCreatedHeaders[headerView.tag].selectedLocationType = selectedValue
            self.currentRequisition.actualCreatedHeaders[headerView.tag].selectedLocationTypeId = self.currentRequisition.getAllLocationTypes().locationTypeIds[selectedIndex]
            
        case Constants.ClickedFieldMicrobialSurvey.locationValue:
            guard let cell = cell as? EnviromentalSampleInfoCell  else {
                return
            }
            cell.searchBarLocation.text = selectedValue
            
            guard let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValues = selectedValue
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedLocationValueId = self.currentRequisition.getLocationValues(selectedValue: selectedValue)
            
        case Constants.ClickedFieldMicrobialSurvey.mediaType:
            guard let cell = cell as? EnviromentalSampleInfoCell  else {
                return
            }
            cell.mediaTypeTextField.text = selectedValue

            guard let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaTypeValue = selectedValue
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].selectedMediaTypeId = self.currentRequisition.getMediaTypeValues(selectedValue: selectedValue)
           
            
        case Constants.ClickedFieldMicrobialSurvey.sampling:
            guard let cell = cell as? EnviromentalSampleInfoCell  else {
                return
            }
            cell.samplingTextField.text = selectedValue

            guard let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeValue = selectedValue
            self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].samplingMethodTypeId = self.currentRequisition.getSamplingMethodTypeValues(selectedValue: selectedValue)
        default:
            break
        }
        
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.reloadTableView()
    }
    
}


//MARK: - Enviromental Location HeaderView Delegates
extension EnviromentalSurveyController: EnviromentalLocationHeaderViewDelegates {
    func setTemplateFor(templateType: STANDARD_TEMPLATE_TYPE){
        self.currentRequisition.actualCreatedHeaders.removeAll()

        let locationTypeIds = self.currentRequisition.getAllLocationTypes().locationTypeIds
        let locationTypeNames = self.currentRequisition.getAllLocationTypes().locationTypes
        var fullIndex = 0
        for (id, name) in zip(locationTypeIds, locationTypeNames){
            let locationHeader = LocationTypeHeaderModel()
            locationHeader.section = self.currentRequisition.actualCreatedHeaders.count + 1
            locationHeader.requisition_Id = self.currentRequisition.barCode
            locationHeader.selectedLocationTypeId = id
            locationHeader.selectedLocationType = name
            var locationValues = [Microbial_LocationValues]()
            
            var tempValue = 0
            
            if self.currentRequisition.requisitionType == .enviromental {
                locationValues = (templateType == .STD) ? self.currentRequisition.getAllLocationValuesWhichAreTrueForStd(locationTypeId: id) : self.currentRequisition.getAllLocationValuesWhichAreTrueForStd40(locationTypeId: id)
                tempValue = 1
            }
            else{
                locationValues = (templateType == .STD20) ? self.currentRequisition.getAllLocationValuesWhichAreTrueForStd20(locationTypeId: id) : self.currentRequisition.getAllLocationValuesWhichAreTrueForStd40(locationTypeId: id)
                tempValue = 0
            }
            var i = 0
            if locationValues.count > 0 {
                print("you enter how many times : \(i)")
                i = i + 1
                self.currentRequisition.actualCreatedHeaders.append(locationHeader)
                let index = self.currentRequisition.actualCreatedHeaders.count - 1
               
                for lValue in locationValues{
                    let limit = (templateType == (tempValue == 0 ? .STD20 : .STD)) ? (tempValue == 0 ? lValue.rep20!.intValue : lValue.stnRep!.intValue) : lValue.rep40!.intValue
                    for j in 0..<limit{
                        let plateCell = LocationTypeCellModel()
                        let i = self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.count
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.append(plateCell)
                      
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].isBacterialChecked = false
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].isMicoscoreChecked = true
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].selectedLocationTypeId = id
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].selectedLocationValues = lValue.text ?? ""
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].selectedLocationValueId = lValue.id?.intValue
                        print("your location id is :\(lValue.id?.intValue)")
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].mediaDefault = lValue.media ?? ""
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].mediaTypeValue = lValue.media ?? ""
                       // self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaTypeValue = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].mediaDefault ?? ""
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].selectedMediaTypeId = 1
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].samplingDefault = lValue.sampling ?? ""
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].samplingMethodTypeValue = lValue.sampling ?? ""
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].samplingMethodTypeId = 1
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].row = self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.count - 1
                        print("your plate id is here : \(self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.count - 1)")
                        self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].section = self.currentRequisition.actualCreatedHeaders.count
                        print("your number of plate id created during: \(self.currentRequisition.actualCreatedHeaders.count)")
                        self.currentRequisition.actualCreatedHeaders[index].noOfPlates = self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.count
                        print("your total count of plate is here : \(self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated.count)")
                        var locationTypeId = ""
                        if let id = self.currentRequisition.actualCreatedHeaders[self.currentRequisition.actualCreatedHeaders.count - 1].selectedLocationTypeId {
                            locationTypeId = "\(id)"
                        }
                        
                        let key = "\(String(describing: locationTypeId)) - \(self.currentRequisition.actualCreatedHeaders.count - 1) - \(index + 1)"
                      
                       
//                        var fullIndex = ""
//                        let indexDict = self.generatePlateIndex()
            print("your section here : \(self.currentRequisition.actualCreatedHeaders.count - 1)")
                        print("your row index at : \(fullIndex)")
                        print("your for loop inner cell index :\(index)")
                        
                            self.currentRequisition.actualCreatedHeaders[self.currentRequisition.actualCreatedHeaders.count - 1].numberOfPlateIDCreated[i].plateId = "\(self.currentRequisition.barCode)-\(fullIndex + 1)"
                          //  fullIndex = "\(indexDict[key])"
                        
                        
                        print("your genrated id is here :\(fullIndex) :\(self.currentRequisition.actualCreatedHeaders[index].numberOfPlateIDCreated[i].plateId)")
                        fullIndex = fullIndex + 1
                    }
                }
            }
        }
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.reloadTableView()
    }
    
    func stdButtonPressed(_ view: EnviromentalLocationHeaderView) {
        guard self.isAllSampleInfoMandatoryFiledsFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: fillAllStr)
            return
        }
        
        guard !self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .submitted) else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
            return
        }
        self.setTemplateFor(templateType: .STD)
    }
    
    func std20ButtonPressed(_ view: EnviromentalLocationHeaderView) {
        guard self.isAllSampleInfoMandatoryFiledsFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: fillAllStr)
            return
        }
        
        guard !self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .submitted) else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
            return
        }
        self.setTemplateFor(templateType: .STD20)
    }
    
    func std40ButtonPressed(_ view: EnviromentalLocationHeaderView) {
        guard self.isAllSampleInfoMandatoryFiledsFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: fillAllStr)
            return
        }
        guard !self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .submitted) else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
            return
        }
        self.setTemplateFor(templateType: .STD40)
    }
    
    func generatePlateIdButtonPressed(_ view: EnviromentalLocationHeaderView) {
        guard self.isAllPlatesHaveLocationValue() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please select location value for all plates generated.")
            return
        }
        self.currentRequisition.isPlateIdGenerated = !self.currentRequisition.isPlateIdGenerated
        for i in 0..<self.currentRequisition.actualCreatedHeaders.count{
            self.currentRequisition.actualCreatedHeaders[i].ischeckBoxSelected = true
        }
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.tableView.reloadData()
    }
    
    func generatePlateIndex() -> [String: Int]{
        let sections = tableView.numberOfSections
        var indexing = 0
        var dict : [String: Int] = [:]
        for sectionIndex in 0..<sections - 1{
            for rowIndex in 0..<self.currentRequisition.actualCreatedHeaders[sectionIndex].numberOfPlateIDCreated.count{
                if let id = self.currentRequisition.actualCreatedHeaders[sectionIndex].selectedLocationTypeId {
                    indexing = indexing + 1
                    dict["\(id) - \(sectionIndex + 1) - \(rowIndex + 1)"] = indexing
                }
            }
        }
        return dict
    }
    
    
    func textFieldDidEndEditingForHeader(_ view: EnviromentalLocationHeaderView, _ textField: UITextField) {
        if let text = textField.text, let intValue = Int(text) {
            self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates = intValue
//            self.currentRequisition.saveLocationTypeHeaderCurrentSessionInfoInDB()
            self.saveCurrentDataInLocalDB(isFinalSubmit: false)
            self.reloadTableView()
        }
    }
    
    //MARK: - Add new header
    func addLocationButtonPressed(_ view: EnviromentalLocationHeaderView) {
        self.addLocation()
    }
    
    @IBAction func addLocationBtnAction(_ sender: UIButton) {
        self.addLocation()
    }
    
    
    func addLocation(){
        var isAllHeadersHasPlates = true
        for header in self.currentRequisition.actualCreatedHeaders {
            if header.numberOfPlateIDCreated.count == 0 {
                isAllHeadersHasPlates = false
            }
        }
        
        if isAllHeadersHasPlates {
            let locationHeader = LocationTypeHeaderModel()
            locationHeader.section = self.currentRequisition.actualCreatedHeaders.count + 1
            locationHeader.requisition_Id = self.currentRequisition.barCode
            self.currentRequisition.actualCreatedHeaders.append(locationHeader)
        } else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please click to Plus icon to add plates.")
            return
        }
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.reloadTableView()
    }
    
    //MARK: - Delete selected header
    func deleteLocationButtonPressed(_ view: EnviromentalLocationHeaderView) {
        self.deleteLocationButton()
    }
    
    @IBAction func deletebtnAction(_ sender: UIButton) {
        self.deleteLocationButton()
    }
    
    func deleteLocationButton(){
        if !currentRequisition.isPlateIdGenerated{
            guard self.currentRequisition.actualCreatedHeaders.count > 1 else {
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "You can't delete all the locations.")
                return
            }
        }
        var isAllHeaderChecked = true
        for header in self.currentRequisition.actualCreatedHeaders {
            if header.ischeckBoxSelected == false {
                isAllHeaderChecked = false
                break
            }
        }
        
//        if !currentRequisition.isPlateIdGenerated{
//            guard isAllHeaderChecked == false else {
//                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "You can't delete all the locations.")
//                return
//            }
//        }
        
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (_) in
            var checkedHeadersIndex = [Int]()
            for (index, header) in self.currentRequisition.actualCreatedHeaders.enumerated() {
                if header.ischeckBoxSelected {
                    checkedHeadersIndex.append(index)
                }
            }
            
            if self.requisitionSavedSessionType == .SHOW_DRAFT_FOR_EDITING{
                for index in checkedHeadersIndex {
                    self.currentRequisition.deletePlateHeader(locationHeader: self.currentRequisition.actualCreatedHeaders[index])
                }
                self.currentRequisition.actualCreatedHeaders.remove(at: checkedHeadersIndex)
                
                self.currentRequisition.reArrangeSectionOfHeaders()
            }else{
                self.currentRequisition.actualCreatedHeaders.remove(at: checkedHeadersIndex)
                self.saveCurrentDataInLocalDB(isFinalSubmit: false)
            }
            
            if self.currentRequisition.actualCreatedHeaders.count == 0{
                self.submitButton.setImage(UIImage(named: "BacterialSubmitImg"), for: .normal)
                self.submitButton.backgroundColor = UIColor.clear
                self.currentRequisition.generateHeader()
                self.currentRequisition.isPlateIdGenerated = false
                self.saveCurrentDataInLocalDB(isFinalSubmit: false)
            }
            self.configureRequisitionAsPerSavedSessionType()
            self.reloadTableView()
        }))
        self.present(alert, animated: true)
    }
    
    //MARK: - Select header
    func checkBoxButtonPressed(_ view: EnviromentalLocationHeaderView) {
        self.currentRequisition.actualCreatedHeaders[view.tag].ischeckBoxSelected = !self.currentRequisition.actualCreatedHeaders[view.tag].ischeckBoxSelected
        if self.currentRequisition.actualCreatedHeaders[view.tag].ischeckBoxSelected {
            view.checkBoxButton.setImage(UIImage(named: "checkedIcon_new"), for: .normal)
        } else {
            view.checkBoxButton.setImage(UIImage(named: "uncheckIcon_new"), for: .normal)
        }
        //self.currentRequisition.saveLocationTypeHeaderCurrentSessionInfoInDB()
        self.reloadTableView()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
    }
    
    func locationTypeButtonPressed(_ view: EnviromentalLocationHeaderView) {
        let microbialTransferTypesArray = self.currentRequisition.getAllLocationTypes().locationTypes
        self.setDropdrown(view.locationTypeButton, clickedField: Constants.ClickedFieldMicrobialSurvey.locationType, dropDownArr: microbialTransferTypesArray, cell: nil, view: view)
    }
    
    //MARK: - Plus button action
    func plusButtonPressed(_ view: EnviromentalLocationHeaderView) {
        self.view.endEditing(true)
        if ((requisitionSavedSessionType == .CREATE_NEW_SESSION) || (requisitionSavedSessionType == .RESTORE_OLD_SESSION)){
            guard !self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .submitted) else {
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
                return
            }
        }
        
        self.currentRequisition.actualCreatedHeaders[view.tag].isPlusButtonPressed = true
        
        guard self.isAllSampleInfoMandatoryFiledsFilled() else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: fillAllStr)
            return
        }
        
        guard self.currentRequisition.barCode != "E-" else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Invalid Barcode")
            return
        }
        
        guard let selectedLocationType = view.locationTypeTextField.text,
            selectedLocationType != "Select location type" else {
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please select location type.")
                self.reloadTableView()
                return
        }
        self.isSubmitButtonPressed = false
        let noOfPlates = self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates
        guard noOfPlates > 0 else {
             Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please enter number of plates.")
            self.reloadTableView()
            return
        }
        
        guard noOfPlates <= 200  else {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Number of plates exceeding 200.")
            return
        }
        
        let totalPlatesInHeader = self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.count
        if totalPlatesInHeader > 0 {
            let plateCell = LocationTypeCellModel()
            self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates += 1
            plateCell.row = totalPlatesInHeader //(plateCell.row ?? 0) + 1
            plateCell.section = view.tag
            //   print("row\(plateCell.row)  section\(plateCell.section)")
//            plateCell.isBacterialChecked = self.currentRequisition.requisitionType == RequisitionType.bacterial
            plateCell.selectedLocationTypeId = self.currentRequisition.actualCreatedHeaders[view.tag].selectedLocationTypeId
            self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.append(plateCell)
        } else {
            for i in 0..<noOfPlates {
                let plateCell = LocationTypeCellModel()
                plateCell.row = i
                plateCell.section = view.tag
//                plateCell.isBacterialChecked = self.currentRequisition.requisitionType == RequisitionType.bacterial
                plateCell.selectedLocationTypeId = self.currentRequisition.actualCreatedHeaders[view.tag].selectedLocationTypeId
                self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.append(plateCell)
            }
        }
//        self.currentRequisition.isPlateIdGenerated = self.currentRequisition.actualCreatedHeaders[0].numberOfPlateIDCreated.count > 0
//        self.currentRequisition.addNewRowToPlatesSubmitted()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
//        self.currentRequisition.saveLocationTypeHeaderCurrentSessionInfoInDB()
//        self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
        self.reloadTableView()
    }
    
    //MARK: - Minus button action
    func minusButtonPressed(_ view: EnviromentalLocationHeaderView) {
        if  self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.count > 0 {
            //self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
            self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates -= 1
            if let dataToDelete = self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.last{
                if requisitionSavedSessionType == .SHOW_DRAFT_FOR_EDITING{
                    self.currentRequisition.deletePlates(data: dataToDelete, locationId: self.currentRequisition.actualCreatedHeaders[view.tag].selectedLocationTypeId ?? 0, numberOfPlates: self.currentRequisition.actualCreatedHeaders[view.tag].noOfPlates)
                    //   print("draft")
                }else{
                    self.saveCurrentDataInLocalDB(isFinalSubmit: false)
//                            self.currentRequisition.updateSampleInfoDataInToDB_Enviromental(isFinalSubmit: false)

                }
            self.currentRequisition.actualCreatedHeaders[view.tag].numberOfPlateIDCreated.removeLast()

            }
//            self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        }
        
        self.reloadTableView()
    }
    
    func collapsableButtonPressed(_ view: EnviromentalLocationHeaderView) {
        self.currentRequisition.actualCreatedHeaders[view.tag].isHeaderIsCollapsed = !self.currentRequisition.actualCreatedHeaders[view.tag].isHeaderIsCollapsed
        self.reloadTableView()
        self.tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: view.tag + 1), at: .top, animated: true)
    }
    
    func reloadTableView() {
        UIView.performWithoutAnimation {
            tableView.reloadData()
        }
    }
}

//MARK: - Enviromental Sample Info Cell Delegate
extension EnviromentalSurveyController: EnviromentalSampleInfoCellDelegate {
    
    func notesButtonPressed(_ cell: EnviromentalSampleInfoCell, _ sender: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        notesIndexPath = indexPath
        notesView.frame = self.view.bounds
        notesTextView.text = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].notes
        self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isSelectedNote = true
        if requisitionSavedSessionType == .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY{
            notesTextView.isEditable = false
        }
        else{
            notesTextView.isEditable = true
        }
        view.addSubview(notesView)
    }
    
    func mediaTypeButtonPressed(_ cell: EnviromentalSampleInfoCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].selectedLocationTypeId != nil {
            let locationValues =  self.currentRequisition.getMediaTypes()
        
            self.setDropdrown(cell.mediaTypeButton, clickedField: Constants.ClickedFieldMicrobialSurvey.mediaType, dropDownArr: locationValues, cell: cell)
        }
    }
    func samplingTypeButtonPressed(_ cell: EnviromentalSampleInfoCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].selectedLocationTypeId != nil {
            let locationValues =  self.currentRequisition.getSamplingTypes()
        
            self.setDropdrown(cell.samplingTypeButton, clickedField: Constants.ClickedFieldMicrobialSurvey.sampling, dropDownArr: locationValues, cell: cell)
        }
    }
    
    func locationValueButtonPressed(_ cell: EnviromentalSampleInfoCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        if let locationTypeId = self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].selectedLocationTypeId {
            var locationValues =  self.currentRequisition.getAllLocationValuesFor(locationTypeId: locationTypeId).locationValues
            if !locationValues.contains("Other") {
                locationValues.append("Other")
            }
            self.setDropdrown(cell.locationValueButton, clickedField: Constants.ClickedFieldMicrobialSurvey.locationValue, dropDownArr: locationValues, cell: cell)
        }
    }
        
    func textFieldDidEndEditing(_ cell: EnviromentalSampleInfoCell, _ activeTextField: UITextField) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        
        guard let sampleDescription = activeTextField.text else {
            return
        }
        self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].sampleDescription = sampleDescription
        //self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
    }
    
    func bacterialCheckBoxButtonPressed(_ cell: EnviromentalSampleInfoCell, _ sender: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isBacterialChecked {
            sender.setImage(UIImage(named: "uncheckIcon"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "checkIcon"), for: .normal)
        }
        
        self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isBacterialChecked = !self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isBacterialChecked
        //self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
    }
    
    func micoscoreCheckBoxButtonPressed(_ cell: EnviromentalSampleInfoCell, _ sender: UIButton) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        if self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isMicoscoreChecked {
            sender.setImage(UIImage(named: "uncheckIcon"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "checkIcon"), for: .normal)
        }
        
        self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isMicoscoreChecked = !self.currentRequisition.actualCreatedHeaders[indexPath.section - 1].numberOfPlateIDCreated[indexPath.row].isMicoscoreChecked
        //self.currentRequisition.saveLocationTypePlatesCurrentSessionInfoInToDB()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
    }
}

//MARK: - Date picker Delegate
extension EnviromentalSurveyController: DatePickerPopupViewControllerProtocol {
    func doneButtonTappedWithDate(string: String, objDate: Date) {
        self.currentRequisition.sampleCollectionDate = string
        self.currentRequisition.generatebarCode()
//        self.currentRequisition.updateNewBarcodeEditted()
//        self.currentRequisition.saveCaseInfoCurrentSessionDataInToDB()
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
        self.reloadTableView()
    }
    
    func doneButtonTapped(string: String) {
        self.currentRequisition.sampleCollectionDate = string
        self.reloadTableView()
    }
}

//MARK: - For bacterial Form cell Delegate
extension EnviromentalSurveyController: BacterialFormCellDelegates {
    
    func reasonForVisitButtonPressed_Bacterial(_ cell: BacterialFormCell) {
        let reasonForVisitObjectArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_AllMicrobialVisitTypes")
        let reasonsForVisit = reasonForVisitObjectArray.value(forKey: "text")  as? [String] ?? []
        setDropdrown(cell.reasonForVisitButton, clickedField: Constants.ClickedFieldMicrobialSurvey.reasonForVisit, dropDownArr: reasonsForVisit, cell: cell)
    }
    
    func companyButtonPressed_Bacterial(_ cell: BacterialFormCell) {
        let customerDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_Customer")
        let customerNamesArray  = customerDetailsArray.value(forKey: "customerName") as? [String] ?? []
        self.setDropdrown(cell.companyButton, clickedField: Constants.ClickedFieldMicrobialSurvey.company, dropDownArr: customerNamesArray, cell: cell)
    }
    
    func siteButtonPressed_Bacterial(_ cell: BacterialFormCell) {
        guard !self.currentRequisition.company.isEmpty else {
            self.reloadTableView()
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "Please select company first.")
            return
        }
        let sitesObjectArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_siteByCustomer", customerId: self.currentRequisition.companyId)
        let sitesArray = sitesObjectArray.value(forKey: "siteName") as? [String] ?? []
       
        if sitesArray.count == 0 {
            Helper.showAlertMessage(self, titleStr: "Alert", messageStr: "There are no sites for selected company")
            return
        }
        
        self.currentRequisition.barCodeManualEntered = ""
        self.setDropdrown(cell.siteButton, clickedField: Constants.ClickedFieldMicrobialSurvey.siteId, dropDownArr: sitesArray, cell: cell)
    }
    
    func reviewerButtonPressed_Bacterial(_ cell: BacterialFormCell) {
        self.saveCurrentDataInLocalDB(isFinalSubmit: false)
//        let reviewerDetailsArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "Micro_Reviewer")
//        let reviewerNamesArray  = reviewerDetailsArray.value(forKey: "reviewerName") as? [String] ?? []
//        self.setDropdrown(cell.reviewerButton, clickedField: Constants.ClickedFieldMicrobialSurvey.reviewer, dropDownArr: reviewerNamesArray, cell: cell)
//0128001500001961
        self.presentReviewerController()
    }
    
    private func presentReviewerController(){
        let obj = ReviewerViewController(nibName: "ReviewerViewController", bundle: nil)
        obj.definesPresentationContext = true
        obj.providesPresentationContextTransitionStyle = true
        obj.view.backgroundColor = UIColor.clear
        obj.modalPresentationStyle = .overCurrentContext
        obj.cancelAction = { sender in
            let selectedReviewer = self.reviewerDetails.filter{ $0.isSelected?.boolValue == true }
            if selectedReviewer.count > 0{
                self.currentRequisition.reviewer = selectedReviewer[0].reviewerName ?? ""
            }else{
                self.currentRequisition.reviewer =  ""
            }
            if selectedReviewer.count > 1{
                for i in 1..<selectedReviewer.count{
                    self.currentRequisition.reviewer = "\(self.currentRequisition.reviewer), \(selectedReviewer[i].reviewerName ?? "")"
                }
            }
            self.dismiss(animated: false, completion: {
                self.saveCurrentDataInLocalDB(isFinalSubmit: false)
                self.reloadTableView()

            })
        }
        
        obj.doneAction = { sender in
            let selectedReviewer = self.reviewerDetails.filter{ $0.isSelected?.boolValue == true }
            if selectedReviewer.count > 0{
                self.currentRequisition.reviewer = selectedReviewer[0].reviewerName ?? ""
            }else{
                self.currentRequisition.reviewer =  ""
            }
            if selectedReviewer.count > 1{
                for i in 1..<selectedReviewer.count{
                    self.currentRequisition.reviewer = "\(self.currentRequisition.reviewer), \(selectedReviewer[i].reviewerName ?? "")"
                }
            }
            self.dismiss(animated: false, completion: {
                self.saveCurrentDataInLocalDB(isFinalSubmit: false)
                self.reloadTableView()

            })
        }
        
        obj.reviewerIdSelected = { reviewer in
            //update bool value
            self.updateBoolValueOfReviewer(reviewerData: reviewer)
            self.refreshReviewerData()
            obj.reviewerDetails = self.reviewerDetails
        }
        self.refreshReviewerData()
        obj.reviewerDetails = self.reviewerDetails
        self.present(obj, animated: false) {
            print("presented")
        }
    }
    
    
    private func updateBoolValueOfReviewer(reviewerData: MicrobialSelectedUnselectedReviewer){
        switch requisitionSavedSessionType {
        case .CREATE_NEW_SESSION, .RESTORE_OLD_SESSION:
            let predicate = NSPredicate(format: "isSessionType = %d AND reviewerId == %d", argumentArray: [true, reviewerData.reviewerId ?? 0])
            MicrobialSelectedUnselectedReviewer.updateBoolValueOfReviewer(predicate: predicate)

        case .SHOW_DRAFT_FOR_EDITING, .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            let predicate = NSPredicate(format: "timeStamp = %@ AND reviewerId == %d", argumentArray: [self.currentRequisition.timeStamp, reviewerData.reviewerId ?? 0])
            MicrobialSelectedUnselectedReviewer.updateBoolValueOfReviewer(predicate: predicate)

        }
        self.refreshReviewerData()
    }
    
    func sampleDateButtonPressed_Bacterial(_ cell: BacterialFormCell) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.selection, bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier:  Constants.ControllerIdentifier.datePickerPopupViewController) as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        datePickerPopupViewController.canSelectPreviousDate = true
        present(datePickerPopupViewController, animated: false, completion: nil)
    }
    
    func barcode_bacterial(cell: BacterialFormCell, activeTextField: UITextField) {
        if activeTextField == cell.barcodeTextField {
            self.currentRequisition.barCodeManualEntered = activeTextField.text ?? ""
            self.currentRequisition.barCode = activeTextField.text ?? ""
        }
        if requisitionSavedSessionType != .SHOW_DRAFT_FOR_EDITING{
            self.currentRequisition.saveCaseInfoCurrentSessionDataInToDB()
        }
        self.currentRequisition.updateNewBarcodeEditted()
        self.reloadTableView()
    }
    
    func noteEntered_Bacterial(cell: BacterialFormCell, activeTextView: UITextView) {
        if let text = activeTextView.text {
            self.currentRequisition.notes = text
        }
    }
}


//MARK:- Update AND SAVE
extension EnviromentalSurveyController{
    
    // MARK: Start saving data - incase of only session
    func startSavingInSession(){
        switch self.currentRequisition.requisitionType {
        case .bacterial:
            if  !self.currentRequisition.company.isEmpty ||
                !self.currentRequisition.site.isEmpty ||
                self.currentRequisition.barCode != "B-" {
                self.saveCurrentSessionDataInToDB()
            }
            
        case .enviromental:
            if  !self.currentRequisition.company.isEmpty ||
                !self.currentRequisition.site.isEmpty ||
                self.currentRequisition.barCode != "E-" {
                self.saveCurrentSessionDataInToDB()
            }
            
        default:
            break
        }
    }
    
    //MARK: Configure data from view did load
    func configureRequisitionAsPerSavedSessionType(){
        switch requisitionSavedSessionType {
        case .RESTORE_OLD_SESSION:
            let sessionprogresss = UserDefaults.standard.bool(forKey: "sessionprogresss")
            if sessionprogresss == true {
                self.currentRequisition.configureDataIfSessionInProgress()
                print(self.currentRequisition.isPlateIdGenerated)
            }
        case .CREATE_NEW_SESSION:
            self.currentRequisition.isPlateIdGenerated = false
            self.setReviewerByDefaultSelected()
            
        case .SHOW_DRAFT_FOR_EDITING, .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            self.currentRequisition.timeStamp = savedData.timeStamp ?? ""
            self.currentRequisition.configureDataFromDrafts(draftData: savedData)
            print(self.currentRequisition.isPlateIdGenerated)
        }
        self.checkMarkAllIfPlateIdIsGenerated()
    }
    
    
    private func setReviewerByDefaultSelected(){
        self.reviewerDetails.removeAll()
        self.saveReviewersDataToDatabase(isSessionType: true)
        self.refreshReviewerData()
        if self.reviewerDetails.count > 0{
            let selectedReviewer = self.reviewerDetails.filter{ ($0.isSelected?.boolValue ?? true) }
            self.currentRequisition.reviewer = (selectedReviewer.count > 0) ? UserContext.sharedInstance.userDetailsObj?.userId ?? "" : ""
        }
    }
    
    
    //MARK: Check and chech mark all if plat ids are generated
    func checkMarkAllIfPlateIdIsGenerated(){
        if self.currentRequisition.isPlateIdGenerated{
            for header in self.currentRequisition.actualCreatedHeaders{
                header.ischeckBoxSelected = true
            }
        }
    }
    
    //MARK: Save on clicking save as draft
    func saveAsDraft(){
        switch requisitionSavedSessionType {
        case .RESTORE_OLD_SESSION, .CREATE_NEW_SESSION:
            if self.currentRequisition.isrequisitionIsAlreadyCreatedForSameDateWithSameSite(sessionStatus: .saveAsDraft){
                Helper.showAlertMessage(self, titleStr: "Alert", messageStr: requisitionAlreadyExist)
                return
            }

            let alert = UIAlertController(title: "Alert", message: "Are you sure you want to Save To draft?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (_) in
                self.currentRequisition.timeStamp = Date().getCurrentTimeStamp()
                self.currentRequisition.sessionStatus = SessionStatus.saveAsDraft
                self.currentRequisition.saveCaseInfoDataInToDB_Enviromental()
                self.currentRequisition.saveSampleInfoDataInToDB_Enviromental()
                self.currentRequisition.saveEnviromentalRequisitionalId()
                
                let predicate = NSPredicate(format: "isSessionType = %d", argumentArray: [true])
                MicrobialSelectedUnselectedReviewer.updateTimeStampFromSession(predicate: predicate, timeStamp: self.currentRequisition.timeStamp)
//                NSPredicate(format: "isSessionType = %d", argumentArray: [true])
                self.currentRequisition = RequisitionModel()
                CoreDataHandlerMicro().deleteAllData("Microbial_EnviromentalSessionInProgress")
                CoreDataHandlerMicro().deleteAllData("Microbial_LocationTypeHeaders")
                CoreDataHandlerMicro().deleteAllData("Microbial_LocationTypeHeaderPlates")
                UserDefaults.standard.removeObject(forKey: "sessionprogresss")
                self.navigateToMocrobialViewController()
            }))
            self.present(alert, animated: true, completion: nil)
                        
        case .SHOW_DRAFT_FOR_EDITING: // this case will never execute as the draft button is hidden
            self.currentRequisition.timeStamp = savedData.timeStamp ?? ""
            self.currentRequisition.sessionStatus = SessionStatus(rawValue: Int(truncating: savedData.sessionStatus ?? 0)) ?? SessionStatus.saveAsDraft
            self.currentRequisition.updateNewBarcodeEditted()
            self.currentRequisition.updateDataForDraft(isFinalSubmit: false)
            
            //update plates
            self.currentRequisition.updateSampleInfoDataInToDB_Enviromental(isFinalSubmit: false)
            self.navigateToMocrobialViewController()

            
        case .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            break
        }
    }
    
    
    // MARK: Save at every action
    func saveCurrentDataInLocalDB(isFinalSubmit: Bool){
        switch requisitionSavedSessionType {
        case .RESTORE_OLD_SESSION, .CREATE_NEW_SESSION:
            self.saveCurrentSessionDataInToDB()
            
        case .SHOW_DRAFT_FOR_EDITING:
            self.currentRequisition.timeStamp = self.savedData.timeStamp ?? ""
            self.currentRequisition.sessionStatus = SessionStatus(rawValue: Int(truncating: savedData.sessionStatus ?? 0)) ?? SessionStatus.saveAsDraft
            self.currentRequisition.updateNewBarcodeEditted()
            self.currentRequisition.updateDataForDraft(isFinalSubmit: isFinalSubmit)
            self.currentRequisition.updateSampleInfoDataInToDB_Enviromental(isFinalSubmit: isFinalSubmit)
                        
            
        case .SHOW_SUBMITTED_REQUISITION_FOR_READ_ONLY:
            break
        }
    }
    
}
