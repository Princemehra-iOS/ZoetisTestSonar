//
//  PEDraftViewController.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 28/02/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit
import SwiftyJSON
import Reachability

class PESessionViewController: BaseViewController {
    
    var peHeaderViewController:PEHeaderViewController!
    var peAssessmentDraftArray : [PENewAssessment] = []
    var peAssessmentRejectedArray : [PENewAssessment] = []
    var pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(nil)
    var jsonRe : JSON = JSON()
    var popFlagArray: [Bool] = [Bool]()
    var isInfoVisible = false
    var regionID = Int()
    var sanitationQuesArr = [PE_ExtendedPEQuestion]()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var customerGradientView: UIView!
    @IBOutlet weak var coustomerView: UIView!
    @IBOutlet weak var lblCustomer: PEFormLabel!
    @IBOutlet weak var lblSite: PEFormLabel!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var popupBackView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var closePopupBtn: UIButton!
    @IBOutlet weak var txtViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var idPopupView: UIView!
    @IBOutlet weak var assIdLabel: UILabel!
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        DispatchQueue.main.async {
            self.closePopupBtn.addTarget(self, action: #selector(self.closePopupBtnAction), for: .touchUpInside)
            self.coustomerView.setCornerRadiusFloat(radius: 24)
            self.customerGradientView.setCornerRadiusFloat(radius: 24)
            self.customerGradientView.setGradient(topGradientColor: UIColor.getGradientUpperColor(), bottomGradientColor: UIColor.getGradientLowerColor())
        }
        
        tableview.register(PE_SessionCell.nib, forCellReuseIdentifier: PE_SessionCell.identifier)
        
        let nibCatchers = UINib(nibName: "PESessionHeader", bundle: nil)
        tableview.register(nibCatchers, forHeaderFooterViewReuseIdentifier: "PESessionHeader")
        
        tableview.register(PE_SessionIntCell.nib, forCellReuseIdentifier: PE_SessionIntCell.identifier)
        
        let nibCatchers1 = UINib(nibName: "PESessionIntHeader", bundle: nil)
        tableview.register(nibCatchers1, forHeaderFooterViewReuseIdentifier: "PESessionIntHeader")
        
        if ConnectionManager.shared.hasConnectivity() {
            self.deleteDeletedAssessments()
        }else{
            if !Constants.isFromRejected{
                peHeaderViewController = PEHeaderViewController()
                peHeaderViewController.titleOfHeader = "View Assessments"
                headerView.addSubview(peHeaderViewController.view)
                topviewConstraint(vwTop: peHeaderViewController.view)
                peAssessmentDraftArray = getAllDateArrayStored()
                peAssessmentDraftArray = peAssessmentDraftArray.sorted { ($0.evaluationDate ?? "") > ($1.evaluationDate ?? "") }
            }else{
                peHeaderViewController = PEHeaderViewController()
                peHeaderViewController.titleOfHeader = "Rejected Assessments"
                headerView.addSubview(peHeaderViewController.view)
                topviewConstraint(vwTop: peHeaderViewController.view)
                peAssessmentRejectedArray = getAllRejectedDateArrayStored()
                peAssessmentRejectedArray = peAssessmentRejectedArray.sorted { ($0.evaluationDate ?? "") > ($1.evaluationDate ?? "") }
            }
            tableview.tableFooterView = UIView()
            tableview.reloadData()
            if peAssessmentDraftArray.count < 1 && peAssessmentRejectedArray.count < 1{
                tableview.isHidden = true
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let sortedArray = peAssessmentDraftArray.sorted {
            let evalDate1 = $0.evaluationDate ?? ""
            let evalDate2 = $1.evaluationDate ?? ""
            let evalDateObj1 = dateFormatter.date(from: evalDate1)
            let evalDateObj2 = dateFormatter.date(from: evalDate2)
            if evalDateObj1 != nil && evalDateObj2 != nil{
                return evalDateObj1! > evalDateObj2!
            }
            return false
        }
        peAssessmentDraftArray = sortedArray
        
        let PE_Selected_Customer_Name = UserDefaults.standard.string(forKey: "PE_Selected_Customer_Name") ?? ""
        let PE_Selected_Site_Name = UserDefaults.standard.string(forKey: "PE_Selected_Site_Name") ?? ""
        lblCustomer.text = PE_Selected_Customer_Name
        lblSite.text =  PE_Selected_Site_Name
    }
    // MARK: - Get Rejected Assessments
    private func getAllRejectedDateArrayStored() -> [PENewAssessment]{
        var peAssessmentArray : [PENewAssessment] = []
        let drafts  = CoreDataHandlerPE().getRejectedAssessmentArrayPEObject(ofCurrentAssessment:false)
        var carColIdArray : [String] = []
        for obj in drafts {
            if !carColIdArray.contains(obj.serverAssessmentId ?? ""){
                carColIdArray.append(obj.serverAssessmentId ?? "")
                peAssessmentArray.append(obj)
            }
        }
        return peAssessmentArray
    }
    // MARK: - Get All Data Array
    private func getAllDateArrayStored() -> [PENewAssessment]{
        var peAssessmentArray : [PENewAssessment] = []
        let drafts  = CoreDataHandlerPE().getSessionForViewAssessmentArrayPEObject(ofCurrentAssessment:true)
        var carColIdArray : [String] = []
        for obj in drafts {
            if !carColIdArray.contains(obj.dataToSubmitID ?? ""){
                carColIdArray.append(obj.dataToSubmitID ?? "")
                peAssessmentArray.append(obj)
            }
        }
        return peAssessmentArray
    }
    // MARK: - Delete Deleated Assessments
    private func deleteDeletedAssessments(){
        if ConnectionManager.shared.hasConnectivity() {
            self.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
            PEDataService.sharedInstance.deleteDeletedAssessments(loginuserId: UserContext.sharedInstance.userDetailsObj?.userId ?? "No id found", viewController: self, completion: { [weak self] (status, error) in
                guard let _ = self, error == nil else {
                    self?.dismissGlobalHUD(self?.view ?? UIView());
                    return
                }
                
                if !Constants.isFromRejected{
                    self?.peHeaderViewController = PEHeaderViewController()
                    self?.peHeaderViewController.titleOfHeader = "View Assessments"
                    self?.headerView.addSubview(self!.peHeaderViewController.view)
                    self?.topviewConstraint(vwTop: self?.peHeaderViewController.view ?? UIView())
                    self?.peAssessmentDraftArray = self?.getAllDateArrayStored() ?? []
                    self?.peAssessmentDraftArray = self?.peAssessmentDraftArray.sorted { ($0.evaluationDate ?? "") > ($1.evaluationDate ?? "") } ?? []
                }else{
                    self?.peHeaderViewController = PEHeaderViewController()
                    self?.peHeaderViewController.titleOfHeader = "Rejected Assessments"
                    self?.headerView.addSubview(self?.peHeaderViewController.view ?? UIView())
                    self?.topviewConstraint(vwTop: self?.peHeaderViewController.view ?? UIView())
                    self?.peAssessmentRejectedArray = self?.getAllRejectedDateArrayStored() ?? []
                    self?.peAssessmentRejectedArray = self?.peAssessmentRejectedArray.sorted { ($0.evaluationDate ?? "") > ($1.evaluationDate ?? "") } ?? []
                }
                self?.tableview.tableFooterView = UIView()
                self?.tableview.reloadData()
                if self?.peAssessmentDraftArray.count ?? 0 < 1 && self?.peAssessmentRejectedArray.count ?? 0 < 1{
                    self?.tableview.isHidden = true
                }
                self?.dismissGlobalHUD(self?.view ?? UIView())
            })
        }else{
            print("test message")
        }
    }
}
// MARK: - Extension & TableView Delegates
extension PESessionViewController: UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !Constants.isFromRejected{
            return peAssessmentDraftArray.count
        }else{
            return peAssessmentRejectedArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height:CGFloat = CGFloat()
        height = 70
        return height
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID == 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PE_SessionCell.identifier) as? PE_SessionCell{
                popFlagArray.append(false)
                if !Constants.isFromRejected {
                    cell.infoButton.isHidden = true
                    cell.editBtn.tag = indexPath.row
                    cell.editBtn.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
                    cell.config(peNewAssessment:peAssessmentDraftArray[indexPath.row], index: indexPath)
                }else{
                    cell.infoButton.isHidden = false
                    cell.infoButton.tag = indexPath.row
                    cell.emRejectedComentBtn.tag = indexPath.row
                    cell.infoButton.addTarget(self, action: #selector(addInfoPopup(sender:)), for: .touchUpInside)
                    cell.emRejectedComentBtn.addTarget(self, action: #selector(addExtendedInfoPopup(sender:)), for: .touchUpInside)
                    cell.config(peNewAssessment:peAssessmentRejectedArray[indexPath.row], index: indexPath)
                }
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: PE_SessionIntCell.identifier) as? PE_SessionIntCell{
                popFlagArray.append(false)
                if !Constants.isFromRejected{
                    cell.infoButton.isHidden = true
                    cell.config(peNewAssessment:peAssessmentDraftArray[indexPath.row], index: indexPath)
                }else{
                    cell.infoButton.isHidden = false
                    cell.infoButton.tag = indexPath.row
                    cell.infoButton.addTarget(self, action: #selector(addInfoPopup(sender:)), for: .touchUpInside)
                    cell.config(peNewAssessment:peAssessmentRejectedArray[indexPath.row], index: indexPath)
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    // MARK: - Edit Button Action
    @objc func editPressed(_ sender: UIButton){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEViewAssesmentFinalize") as? PEViewAssesmentFinalize
        vc?.peNewAssessment = peAssessmentDraftArray[sender.tag]
        if peAssessmentDraftArray[sender.tag].evaluationID == 1{
            vc?.collectionviewIndexPath = IndexPath(row: 5, section: 0)
            
        } else {
            vc?.collectionviewIndexPath = IndexPath(row: 3, section: 0)
            
        }
        vc?.isFromEditMicro = true
        UserDefaults.standard.set(vc?.peNewAssessment.serverAssessmentId ?? "" , forKey: "currentServerAssessmentId")
        let userDefault = UserDefaults.standard
        
        userDefault.set(peAssessmentDraftArray[sender.tag].customerId, forKey: "PE_Selected_Customer_Id")
        userDefault.set(peAssessmentDraftArray[sender.tag].customerName, forKey: "PE_Selected_Customer_Name")
        userDefault.set(peAssessmentDraftArray[sender.tag].siteId, forKey: "PE_Selected_Site_Id")
        userDefault.set(peAssessmentDraftArray[sender.tag].siteName, forKey: "PE_Selected_Site_Name")
        
        if vc != nil{
            navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !Constants.isFromRejected{
            
            let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
            if regionID == 3
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                
                let vc = storyBoard.instantiateViewController(withIdentifier: "PEViewStartNewAssessment") as? PEViewStartNewAssessment
                vc?.peNewAssessment = peAssessmentDraftArray[indexPath.row]
                vc?.editExtendedMicro = "no"
                UserDefaults.standard.set(vc?.peNewAssessment.serverAssessmentId ?? "" , forKey: "currentServerAssessmentId")
                let userDefault = UserDefaults.standard
                
                userDefault.set(peAssessmentDraftArray[indexPath.row].customerId, forKey: "PE_Selected_Customer_Id")
                userDefault.set(peAssessmentDraftArray[indexPath.row].customerName, forKey: "PE_Selected_Customer_Name")
                userDefault.set(peAssessmentDraftArray[indexPath.row].siteId, forKey: "PE_Selected_Site_Id")
                userDefault.set(peAssessmentDraftArray[indexPath.row].siteName, forKey: "PE_Selected_Site_Name")
                
                if vc != nil{
                    navigationController?.pushViewController(vc!, animated: true)
                }
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PEViewStartNewAssesmentINT") as? PEViewStartNewAssesmentINT
                vc?.peNewAssessment = peAssessmentDraftArray[indexPath.row]
                UserDefaults.standard.set(vc?.peNewAssessment.serverAssessmentId ?? "" , forKey: "currentServerAssessmentId")
                UserDefaults.standard.set(peAssessmentDraftArray[indexPath.row].refrigeratorNote ?? "", forKey:"re_note")
                UserDefaults.standard.set(peAssessmentDraftArray[indexPath.row].serverAssessmentId ,forKey:"assIID")
                let userDefault = UserDefaults.standard
                userDefault.set(peAssessmentDraftArray[indexPath.row].customerId, forKey: "PE_Selected_Customer_Id")
                userDefault.set(peAssessmentDraftArray[indexPath.row].customerName, forKey: "PE_Selected_Customer_Name")
                userDefault.set(peAssessmentDraftArray[indexPath.row].siteId, forKey: "PE_Selected_Site_Id")
                userDefault.set(peAssessmentDraftArray[indexPath.row].siteName, forKey: "PE_Selected_Site_Name")
                
                if vc != nil{
                    navigationController?.pushViewController(vc!, animated: true)
                }
            }
            
        }else{
            let allAssesmentArr = CoreDataHandlerPE().getRejectedAssessmentArrayPEObject(ofCurrentAssessment:true)
            let errorMSg = "Are you sure you want to move assessment to draft?"
            let alertController = UIAlertController(title: "Move Assessment to Draft", message: errorMSg, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
                _ in
                let rejectedCountIS = UserDefaults.standard.value(forKey: "rejectedCountIS") as? Int ?? 0
                if rejectedCountIS - 1  < 0
                {
                    UserDefaults.standard.setValue(0, forKey: "rejectedCountIS")
                } else {
                    UserDefaults.standard.setValue(rejectedCountIS - 1, forKey: "rejectedCountIS")
                }
                
                UserDefaults.standard.set(self.peAssessmentRejectedArray[indexPath.row].serverAssessmentId , forKey: "currentServerAssessmentId")
                self.sanitationQuesArr = SanitationEmbrexQuestionMasterDAO.sharedInstance.fetchAssessmentSanitationQuestions(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId:  self.peAssessmentRejectedArray[indexPath.row].serverAssessmentId ?? "")
                if self.regionID == 3
                {
                    if self.peAssessmentRejectedArray[indexPath.row].isEMRejected == true && self.peAssessmentRejectedArray[indexPath.row].isPERejected == true
                    {
                        Constants.isAssessmentRejected = true
                        self.moveAssessmentTodraft(index: indexPath.row)
                    }
                    else if self.peAssessmentRejectedArray[indexPath.row].isEMRejected == true && self.peAssessmentRejectedArray[indexPath.row].isPERejected == false
                    {
                        Constants.isAssessmentRejected = true
                        self.movePEToDraft(index: indexPath.row)
                    }
                    else
                    {
                        self.moveAssessmentTodraft(index: indexPath.row)
                    }
                }
                else
                {
                    self.moveAssessmentTodraft(index: indexPath.row)
                }
                
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) 
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    // MARK: - Mve PE to Draft
    func movePEToDraft (index :Int)
    {
        let allAssesmentArr = CoreDataHandlerPE().getRejectedAssessmentArrayPEObject(ofCurrentAssessment:true)
        let draftNumber = getDraftCountFromDb()
        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr , draftNumber: draftNumber + 1, isfromRejected: true)
        
        if ConnectionManager.shared.hasConnectivity() {
            self.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
            self.getRejectedAssessmentImagesListByUser(assId: self.peAssessmentRejectedArray[index].serverAssessmentId ?? "")
            self.peAssessmentRejectedArray.remove(at: index)
        }else{
            let predicate = NSPredicate(format:"serverAssessmentId = %@", self.peAssessmentRejectedArray[index].serverAssessmentId ?? "")
            CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentRejected", predicate: predicate)
            self.peAssessmentRejectedArray.remove(at: index)
            self.tableview.reloadData()
            self.showtoast(message: "Assessment moved to draft")
            self.navigationController?.popToViewController(ofClass: PEDraftViewController.self)
        }
        
    }
    
    func moveAssessmentTodraft(index: Int) {
        let allAssesmentArr = CoreDataHandlerPE().getRejectedAssessmentArrayPEObject(ofCurrentAssessment:true)
        
        let draftNumber = getDraftCountFromDb()
        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr , draftNumber: draftNumber + 1, isfromRejected: true)
        
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3
        {
            var refrigtorArray  : [PE_Refrigators] = []
            refrigtorArray =   CoreDataHandlerPE().getRejectREfriData(id: Int(self.peAssessmentRejectedArray[index].serverAssessmentId ??  "0") ?? 0)
            if(refrigtorArray.count > 0){
                for refrii in refrigtorArray{
                    if(CoreDataHandlerPE().checkDraftSameAssesmentEntityExists(id: Int(refrii.id ?? 0),serverAssessmentId: Int(self.peAssessmentRejectedArray[index].serverAssessmentId ??  "0") ?? 0)){
                        CoreDataHandlerPE().updateDraftRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.peAssessmentRejectedArray[index].serverAssessmentId  ?? "0") ?? 0)
                    }
                    else{
                        CoreDataHandlerPE().saveDraftRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                    }
                }
            }
            
            refrigtorArray =   CoreDataHandlerPE().getRejectREfriData(id: Int(peAssessmentRejectedArray[index].serverAssessmentId ?? "0") ?? 0)
            if(refrigtorArray.count > 0){
                for refrii in refrigtorArray{
                    if(CoreDataHandlerPE().checkSameAssesmentEntityExists(id: Int(refrii.id ?? 0),serverAssessmentId: Int(peAssessmentRejectedArray[index].serverAssessmentId ?? "0") ?? 0)){
                        CoreDataHandlerPE().updateRefrigatorInDB(Int(refrii.id ?? 0),  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,serverAssessmentId: Int( self.peAssessmentRejectedArray[index].serverAssessmentId  ?? "0") ?? 0)
                    }
                    else{
                        CoreDataHandlerPE().saveRefrigatorInDB(refrii.id ?? 0,  labelText:  refrii.labelText ?? "", rollOut: refrii.rollOut ?? "", unit:  refrii.unit ?? "", value: refrii.value ?? 0.0,catID: refrii.catID ?? 0,isCheck: refrii.isCheck ?? false,isNA: refrii.isNA ?? false,schAssmentId: refrii.schAssmentId ?? 0)
                    }
                }
            }
            let predicate = NSPredicate(format:"schAssmentId = %@", self.peAssessmentRejectedArray[index].serverAssessmentId ?? "")
            CoreDataHandlerPE().deleteExisitingData(entityName: "PE_Refrigator_Rejected", predicate: predicate)
        }
        if ConnectionManager.shared.hasConnectivity() {
            self.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
            self.getRejectedAssessmentImagesListByUser(assId: self.peAssessmentRejectedArray[index].serverAssessmentId ?? "")
            self.peAssessmentRejectedArray.remove(at: index)
        }else{
            let predicate = NSPredicate(format:"serverAssessmentId = %@", self.peAssessmentRejectedArray[index].serverAssessmentId ?? "")
            CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentRejected", predicate: predicate)
            self.peAssessmentRejectedArray.remove(at: index)
            self.tableview.reloadData()
            self.showtoast(message: "Assessment moved to draft")
            self.navigationController?.popToViewController(ofClass: PEDraftViewController.self)
        }
    }
    
    // MARK: - Convert JSON String to Dict
    func convertToDictionary(text: String) -> JSON!{
        if let data = text.data(using: .utf8) {
            return self.getJSONFrom(Data: data)
        }
        return nil
    }
    
    func getJSONFrom(Data data: Data) -> JSON? {
        do {
            return try JSON(data: data, options: .mutableContainers)
        } catch _ {
            return nil
        }
        
    }
    // MARK: - Update Posted Assessment's Status
    private func postAssessmentStatusUpdate(index: Int){
        let param = ["assessmentId":peAssessmentRejectedArray[index].serverAssessmentId!,"saveType":0,"appVersion":Bundle.main.versionNumber,"userId":UserContext.sharedInstance.userDetailsObj?.userId ?? ""] as JSONDictionary
        
        ZoetisWebServices.shared.postStatusUpdate(controller: self, parameters: param, url: "", completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            let mainQueue = OperationQueue.main
            mainQueue.addOperation{
                
                self.peAssessmentRejectedArray.remove(at: index)
            }
        })
    }
    
    // MARK: - Handle Rejected Assessments List
    private func handlGetRejectedAssessmentListByUser(data: [String:Any]) {
        
        var objDic : [String:Any] = [:]
        objDic =  data
        
        let SaveType = objDic["SaveType"] as? Int ?? 0
        let peNewAssessmentWas = PENewAssessment()
        let assessmentCommentsPostingData = objDic["AssessmentCommentsPostingData"] as? [[String:Any]] ?? []
        let assessmentScoresPostingData = objDic["AssessmentScoresPostingData"] as? [[String:Any]] ?? []
        let EvaluationId = objDic["EvaluationId"] as? Int ?? 0
        let serverAssessmentId = objDic["AssessmentId"] as? Int ?? 0
        let hasChlorineStrips = objDic["HasChlorineStrips"] as? Bool ?? false
        let isAutomaticFail = objDic["IsAutomaticFail"] as? Bool ?? false
        
        if hasChlorineStrips{
            PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: false, assessmentId: "\(serverAssessmentId)", date: nil, override: false, hasChlorineStrips: hasChlorineStrips, isAutomaticFail: isAutomaticFail)
        }
        
        let sanitationEmbrexValue = objDic["SanitationEmbrex"] as? Bool ?? false
        if sanitationEmbrexValue{
            PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: sanitationEmbrexValue, assessmentId: "\(serverAssessmentId)", date: nil, override: false, hasChlorineStrips: hasChlorineStrips, isAutomaticFail: isAutomaticFail)
        }
        
        let sanitationEmbrex = objDic["SanitationEmbrexScoresPostinData"] as? [[String:Any]] ?? []
        let jsonData = try? JSONSerialization.data(withJSONObject: sanitationEmbrex, options: .prettyPrinted)
        let jsonDecoder = JSONDecoder()
        if jsonData != nil{
            let dtoArr = try? jsonDecoder.decode([PESanitationDTO].self, from: jsonData!)
            if dtoArr != nil{
                SanitationEmbrexQuestionMasterDAO.sharedInstance.saveServiceResponse(assessmentId: "\(serverAssessmentId)", userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", dtoArr: dtoArr!)
            }
            
        }
        UserDefaults.standard.set(String(serverAssessmentId), forKey: "currentServerAssessmentId")
        peNewAssessmentWas.serverAssessmentId = String(serverAssessmentId)
        let AppCreationTime = objDic["AppCreationTime"] as? String ?? ""
        let DeviceId = objDic["DeviceId"] as? String ?? ""
        peNewAssessmentWas.siteId = objDic["SiteId"] as? Int ?? 0
        peNewAssessmentWas.siteName = objDic["SiteName"] as? String ?? ""
        peNewAssessmentWas.customerId = objDic["CustomerId"] as? Int ?? 0
        peNewAssessmentWas.customerName = objDic["CustomerName"] as? String ?? ""
        peNewAssessmentWas.userID = objDic["UserId"] as? Int ?? 0
        peNewAssessmentWas.evaluationDate = convertDateFormatter(date: objDic["EvaluationDate"] as? String ?? "")
        peNewAssessmentWas.visitID = objDic["VisitId"] as? Int ?? 0
        peNewAssessmentWas.visitName =  objDic["VisitName"] as? String ?? ""
        peNewAssessmentWas.selectedTSRID = objDic["TSRId"] as? Int ?? 0
        peNewAssessmentWas.hatcheryAntibiotics = 0
        peNewAssessmentWas.evaluationID  = EvaluationId
        
        if let doubleSanitation =  objDic["DoubleSanitation"] as? Bool{
            if doubleSanitation {
                peNewAssessmentWas.hatcheryAntibiotics = 1
            }
        }
        let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Approvers")
        let visitNameArray = visitDetailsArray.value(forKey: "username") as? NSArray ?? NSArray()
        let visitIDArray = visitDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
        if  peNewAssessmentWas.selectedTSRID != 0 {
            if visitIDArray.contains( peNewAssessmentWas.selectedTSRID){
                let indexOfe =  visitIDArray.index(of: peNewAssessmentWas.selectedTSRID)
                let TSRName = visitNameArray[indexOfe] as? String ?? ""
                peNewAssessmentWas.selectedTSR =  TSRName
            }
        }
        
        peNewAssessmentWas.evaluatorName = objDic["UserName"] as? String ?? ""
        peNewAssessmentWas.evaluatorID =  objDic["UserId"] as? Int ?? 0
        peNewAssessmentWas.evaluationName = objDic["EvaluationName"] as? String ?? ""
        peNewAssessmentWas.evaluationID = objDic["EvaluationId"] as? Int ?? 0
        peNewAssessmentWas.statusType = objDic["Status_Type"] as? Int ?? 0
        peNewAssessmentWas.incubation = objDic["IncubationStyleName"] as? String ?? ""
        peNewAssessmentWas.breedOfBird = objDic["BreedBirdsName"] as? String ?? ""
        peNewAssessmentWas.breedOfBirdOther = objDic["BreedOfBirdsOther"] as? String ?? ""
        peNewAssessmentWas.dataToSubmitID = objDic["DeviceId"] as? String ?? ""
        peNewAssessmentWas.rejectionComment = objDic["RejectionComments"] as? String ?? ""
        peNewAssessmentWas.manufacturer = objDic["ManufacturerName"] as? String ?? ""
        peNewAssessmentWas.refrigeratorNote = objDic["RefrigeratorNote"] as? String ?? ""
        let manuOthers = objDic["ManufacturerOther"] as? String ?? ""
        if manuOthers != "" {
            peNewAssessmentWas.manufacturer = "S" + manuOthers
        }
        let eggStr = objDic["EggsPerFlatName"] as? String ?? "0"
        peNewAssessmentWas.noOfEggs = Int64(eggStr)
        
        let eggsOthers = objDic["EggsPerFlatOther"]  as? String ?? ""
        if eggsOthers != "" {
            let txt = eggsOthers
            let str =   txt  + "000"
            let iii = Int64(str)
            if iii != nil{
                peNewAssessmentWas.noOfEggs = iii!
            }
        }
        
        let f = objDic["FlockAgeId"] as? Int ?? 0
        peNewAssessmentWas.isFlopSelected =  f
        let Camera =  objDic["Camera"]  as? Bool ?? false
        if  Camera == true {
            peNewAssessmentWas.camera = 1
        } else {
            peNewAssessmentWas.camera = 0
        }
        
        peNewAssessmentWas.notes = objDic["Notes"] as? String ?? ""
        let strBase64Signatture =  objDic["SignatureImage"] as? String ?? ""
        let representaiveName =  objDic["RepresentativeName"] as? String ?? ""
        let RoleName =  objDic["RoleName"] as? String ?? ""
        let imageData : Data? = Data(base64Encoded: strBase64Signatture, options: .ignoreUnknownCharacters)
        
        let strBase64Signatture2 =  objDic["SignatureImage2"] as? String ?? ""
        let representaiveName2 =  objDic["RepresentativeName2"] as? String ?? ""
        let RoleName2 =  objDic["RoleName2"] as? String ?? ""
        
        let imageData2 : Data = Data(base64Encoded: strBase64Signatture2, options: .ignoreUnknownCharacters) ?? Data()
        let representaiveNotes =  objDic["RepresentativeNotes"] as? String ?? ""
        let SignatureDate =  objDic["SignatureDate"] as? String ?? ""
        let id = self.saveImageInPEModule(imageData: imageData ?? Data())
        let id2 = self.saveImageInPEModule(imageData: imageData2)
        var sigDate = ""
        if SignatureDate != "" {
            sigDate = self.convertDateFormat(inputDate: SignatureDate)
        } else {
            sigDate = Date().stringFormat(format: "MMM d, yyyy")
        }
        let param : [String:String] = ["sig":String(id),"sig2":String(id2),"sig_Date":sigDate ,"sig_EmpID":RoleName,"sig_Name":representaiveName ?? "","sig_EmpID2":RoleName2,"sig_Name2":representaiveName2 ?? "","sig_Phone":representaiveNotes ?? ""]
        
        jsonRe = (getJSON("QuestionAns") ?? JSON())
        pECategoriesAssesmentsResponse =  PECategoriesAssesmentsResponse(jsonRe)
        let questionInfo = (getJSON("QuestionAnsInfo") ?? JSON())
        let infoImageDataResponse = InfoImageDataResponse(questionInfo)
        var peNewAssessmentNew = PENewAssessment()
        let categoryCount = filterCategoryCount(peNewAssessmentOf: peNewAssessmentWas)
        if categoryCount > 0 {
            for  cat in  pECategoriesAssesmentsResponse.peCategoryArray {
                for (index, ass) in cat.assessmentQuestions.enumerated(){
                    
                    peNewAssessmentNew = peNewAssessmentWas
                    peNewAssessmentNew.cID = index
                    peNewAssessmentNew.catID = cat.id
                    peNewAssessmentNew.catName = cat.categoryName
                    peNewAssessmentNew.catMaxMark = cat.maxMark
                    peNewAssessmentNew.sequenceNo = cat.id
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
                    peNewAssessmentNew.isNA = ass.isNA
                    peNewAssessmentNew.isAllowNA = ass.isAllowNA
                    peNewAssessmentNew.rollOut = ass.rollOut
                    peNewAssessmentNew.qSeqNo = ass.qSeqNo
                    peNewAssessmentNew.informationText = infoImageDataResponse.getInfoTextByQuestionId(questionID: ass.id ?? 151)
                    CoreDataHandlerPE().saveNewAssessmentInProgressInDB(newAssessment:peNewAssessmentNew)
                }
            }
            
            let allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
            var filterScoreData : [[String:Any]] = [[:]]
            for questionMark in assessmentScoresPostingData {
                let AssessmentScore = questionMark["AssessmentScore"] as? Int ?? 0
                let QCCount = questionMark["QCCount"] as? String ?? ""
                
                let FrequencyValue = questionMark["FrequencyValue"] as? Int ?? 32
                var FrequencyValueStr = ""
                
                let visitDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_Frequency")
                let visitNameArray = visitDetailsArray.value(forKey: "frequencyName") as? NSArray ?? NSArray()
                let visitIDArray = visitDetailsArray.value(forKey: "frequencyId") as? NSArray ?? NSArray()
                if FrequencyValue != 32 {
                    if visitIDArray.contains(FrequencyValue){
                        let indexOfe =  visitIDArray.index(of: FrequencyValue) //
                        FrequencyValueStr = visitNameArray[indexOfe] as? String ?? ""
                    }
                }
                
                let TextAmPm = questionMark["TextAmPm"] as? String ?? ""
                let PersonName = questionMark["PersonName"] as? String ?? ""
                
                let isNA = questionMark["IsNA"] as? Bool ?? false
                var assIDD = questionMark["ModuleAssessmentId"] as? Int ?? 64
                CoreDataHandlerPE().update_isNAInAssessmentInProgress(isNA: isNA,assID:Int(truncating: (assIDD ?? 0) as NSNumber))
                if QCCount.count > 0 {
                    CoreDataHandlerPE().updateQCCountInAssessmentInProgress(qcCount:QCCount)
                }
                if FrequencyValueStr.count > 0 {
                    CoreDataHandlerPE().updateFrequencyInAssessmentInProgress(frequency:FrequencyValueStr)
                }
                if PersonName.count > 0 {
                    CoreDataHandlerPE().updatePersonNameInAssessmentInProgress(personName: PersonName)
                }
                if TextAmPm.count > 0 {
                    CoreDataHandlerPE().updateAMPMInAssessmentInProgress(ampmValue: TextAmPm)
                }
                
                if AssessmentScore  ==  0  {
                    filterScoreData.append(questionMark)
                }
            }
            
            var assArray : [Int] = []
            for cat in filterScoreData {
                let assID = cat["ModuleAssessmentId"] as? Int ?? 0
                assArray.append(assID)
            }
            
            for qMark in allAssesmentArr {
                let objMark = qMark as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
                for assID in assArray {
                    
                    if ( Int(truncating: objMark.assID ?? 0) == assID ) {
                        var totalMark = GetLatestMarkOfAss(assID: objMark.assID as? Int ?? 0)
                        let catISSelected = 0
                        let maxMarks =  objMark.assMaxScore ?? 0
                        let reMark = Int(totalMark) - Int(truncating: maxMarks)
                        totalMark = Int(truncating: NSNumber(value: reMark))
                        CoreDataHandlerPE().updateChangeInAnsInProgressTable(catISSelected:catISSelected,catResultMark:Int(totalMark),catID:Int(truncating: objMark.catID ?? 0),assID:Int(objMark.assID ?? 0), userID:Int(objMark.userID ?? 0))
                    }
                    
                }
            }
            //score ends
            //comment start
            var filterCommentData : [[String:Any]] = [[:]]
            for questionMark in assessmentCommentsPostingData {
                let AssessmentComment = questionMark["AssessmentComment"] as? String ?? ""
                if AssessmentComment.count > 0  {
                    filterCommentData.append(questionMark)
                }
            }
            
            for qMark in allAssesmentArr {
                let objMark = qMark as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
                for assID in filterCommentData {
                    let AssessmentComment = assID["AssessmentComment"] as? String ?? ""
                    let AssessmentId = assID["AssessmentId"] as? Int ?? 0
                    
                    if ( Int(truncating: objMark.assID ?? 0) == AssessmentId ) {
                        CoreDataHandlerPE().updateNoteInProgressTable(assID:Int(objMark.assID ?? 0),text:AssessmentComment)
                    }
                }
            }
            //comment ends
            let InovojectPostingData = objDic["InovojectPostingData"] as? [Any] ?? []
            let VaccineMixerObservedPostingData = objDic["VaccineMixerObservedPostingData"] as? [Any] ?? []
            
            for inoDic in InovojectPostingData {
                
                let inoDicIS = inoDic as? [String:Any] ?? [:]
                let Dosage = inoDicIS["Dosage"] as? String ?? ""
                let otherString = inoDicIS["OtherText"] as? String ?? ""
                let VaccineId = inoDicIS["VaccineId"] as? Int ?? 0
                let AmpuleSize = inoDicIS["AmpuleSize"] as? Int ?? 0
                var AmpuleSizeStr = ""
                let AntibioticInformation =  inoDicIS["AntibioticInformation"] as? String ?? ""
                var ampleSizeesNameArray = NSArray()
                var ampleSizeIDArray = NSArray()
                var ampleSizeDetailArray = NSArray()
                ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
                ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
                if AmpuleSize != 0 {
                    let indexOfe =  ampleSizeIDArray.index(of: AmpuleSize)
                    AmpuleSizeStr = ampleSizeesNameArray[indexOfe] as? String  ?? ""
                }
                
                let AmpulePerbag = inoDicIS["AmpulePerbag"] as? Int ?? 0
                let HatcheryAntibiotics =  inoDicIS["HatcheryAntibiotics"] as? Bool ?? false
                let ManufacturerId = inoDicIS["ManufacturerId"] as? Int ?? 0
                let BagSizeType = inoDicIS["BagSizeType"] as? String ?? ""
                let DiluentMfg = inoDicIS["DiluentMfg"] as? String ?? ""
                var VName = ""
                let ProgramName = inoDicIS["ProgramName"] as? String ?? ""
                let DiluentsMfgOtherName = inoDicIS["DiluentsMfgOtherName"] as? String ?? ""
                
                var vNameArray = NSArray()
                var vIDArray = NSArray()
                var vDetailsArray = NSArray()
                vDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
                vNameArray = vDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                vIDArray = vDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                let xxxx =    VaccineId
                if xxxx != 0 {
                    if vIDArray.contains(xxxx){
                        let indexOfd = vIDArray.index(of: xxxx) // 3
                        VName = vNameArray[indexOfd] as? String ?? ""
                    }
                }  else {
                    VName = otherString
                }
                
                if otherString != "" {
                    VName = otherString
                }
                
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                
                var HatcheryAntibioticsIntVal = 0
                if HatcheryAntibiotics == true{
                    HatcheryAntibioticsIntVal = 1
                } else {
                    HatcheryAntibioticsIntVal = 0
                }
                
                peNewAssessmentInProgress.iCS  = inoDicIS["BagSizeType"] as? String ?? ""
                let diluentMfg  = inoDicIS["DiluentMfg"] as? String ?? ""
                peNewAssessmentInProgress.iDT = diluentMfg
                
                peNewAssessmentInProgress.micro  = ""
                peNewAssessmentInProgress.residue = ""
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment:peNewAssessmentInProgress,fromInvo: true)
                
                let inVoDataNew = InovojectData(id: 0,vaccineMan:DiluentMfg,name:VName,ampuleSize:AmpuleSizeStr,ampulePerBag:String(AmpulePerbag),bagSizeType:BagSizeType,dosage:Dosage, dilute: DiluentMfg,invoHatchAntibiotic: HatcheryAntibioticsIntVal, invoHatchAntibioticText: AntibioticInformation,  invoProgramName: ProgramName, doaDilManOther: DiluentsMfgOtherName)
                let id = self.saveInovojectInPEModule(inovojectData: inVoDataNew, assessment: allAssesmentArr[0] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress())
                inVoDataNew.id = id
                
            }
            
            let DayPostingData = objDic["DayOfAgePostingData"] as? [Any] ?? []
            for inoDic in DayPostingData {
                
                let DayOfAgeIS = inoDic as? [String:Any] ?? [:]
                let Dosage = DayOfAgeIS["DayOfAgeDosage"] as? String ?? ""
                let otherText = DayOfAgeIS["OtherText"] as? String ?? ""
                let VaccineId = DayOfAgeIS["DayOfAgeMfgNameId"] as? Int ?? 0
                let AmpuleSize = DayOfAgeIS["DayOfAgeAmpuleSize"] as? Int ?? 0
                var AmpuleSizeStr = ""
                
                var ampleSizeesNameArray = NSArray()
                var ampleSizeIDArray = NSArray()
                var ampleSizeDetailArray = NSArray()
                ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
                ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
                if AmpuleSize != 0 {
                    let indexOfe =  ampleSizeIDArray.index(of: AmpuleSize)
                    AmpuleSizeStr = ampleSizeesNameArray[indexOfe] as? String  ?? ""
                }
                
                let AmpulePerbag = DayOfAgeIS["DayOfAgeAmpulePerbag"] as? Int ?? 0
                let HatcheryAntibiotics =  DayOfAgeIS["DayOfBagHatcheryAntibiotics"] as? Bool ?? false
                let ManufacturerId = DayOfAgeIS["DayOfAgeMfgId"] as? Int ?? 0
                let BagSizeType = DayOfAgeIS["DayOfAgeBagSizeType"] as? String ?? ""
                
                let DiluentMfg = DayOfAgeIS["DiluentMfg"] as? String ?? ""
                var VManufacturerName = ""
                var VName = ""
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                let xxx =    ManufacturerId
                if xxx != 0 {
                    let indexOfd = vManufacutrerIDArray.index(of: xxx) // 3
                    VManufacturerName = vManufacutrerNameArray[indexOfd] as? String ?? ""
                }
                var vNameArray = NSArray()
                var vIDArray = NSArray()
                var vDetailsArray = NSArray()
                vDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VNames")
                vDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 1)
                
                vNameArray = vDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                vIDArray = vDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                let xxxx =    VaccineId
                if xxxx != 0 {
                    if vIDArray.contains(xxxx){
                        let indexOfd = vIDArray.index(of: xxxx) // 3
                        VName = vNameArray[indexOfd] as? String ?? ""
                    }
                }else {
                    if VManufacturerName.lowercased().contains("other"){
                        VName  = otherText
                        
                    }
                }
                if otherText != "" {
                    VName = otherText
                }
                
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                let DayOfAgeDataNew = InovojectData(id: 0,vaccineMan:VManufacturerName,name:VName,ampuleSize:AmpuleSizeStr,ampulePerBag:String(AmpulePerbag),bagSizeType:BagSizeType,dosage:Dosage, dilute: DiluentMfg)
                
                peNewAssessmentInProgress.dCS  = DiluentMfg
                peNewAssessmentInProgress.dDT = BagSizeType
                peNewAssessmentInProgress.micro  = ""
                peNewAssessmentInProgress.residue = ""
                if HatcheryAntibiotics == true{
                    peNewAssessmentInProgress.hatcheryAntibioticsDoa = 1
                } else{
                    peNewAssessmentInProgress.hatcheryAntibioticsDoa = 0
                }
                let AntibioticInformation = DayOfAgeIS["AntibioticInformation"] as? String ?? ""
                peNewAssessmentInProgress.hatcheryAntibioticsDoaText = AntibioticInformation
                let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: "\(serverAssessmentId)")
                
                PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: sanitationEmbrexValue, assessmentId: "\(serverAssessmentId)", date: nil,subcutaneousTxt: infoObj?.subcutaneousAntibioticTxt, dayOfAgeTxt: AntibioticInformation)
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment:peNewAssessmentInProgress,fromDoa : true)
                let id = self.saveDOAInPEModule(inovojectData: DayOfAgeDataNew, assessment: allAssesmentArr[0] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress())
                DayOfAgeDataNew.id = id
            }
            
            let DayAgeSubcutaneousDetailsPostingData = objDic["DayAgeSubcutaneousDetailsPostingData"] as? [Any] ?? []
            
            for inoDic in DayAgeSubcutaneousDetailsPostingData {
                
                let DayOfAgeIS = inoDic as? [String:Any] ?? [:]
                let Dosage = DayOfAgeIS["DayAgeSubcutaneousDosage"] as? String ?? ""
                let otherText = DayOfAgeIS["OtherText"] as? String ?? ""
                let VaccineId = DayOfAgeIS["DayAgeSubcutaneousMfgNameId"] as? Int ?? 0
                let AmpuleSize = DayOfAgeIS["DayAgeSubcutaneousAmpuleSize"] as? Int ?? 0
                var AmpuleSizeStr = ""
                var ampleSizeesNameArray = NSArray()
                var ampleSizeIDArray = NSArray()
                var ampleSizeDetailArray = NSArray()
                ampleSizeDetailArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AmpleSizes")
                ampleSizeesNameArray = ampleSizeDetailArray.value(forKey: "size") as? NSArray ?? NSArray()
                ampleSizeIDArray = ampleSizeDetailArray.value(forKey: "id") as? NSArray ?? NSArray()
                if AmpuleSize != 0 {
                    let indexOfe =  ampleSizeIDArray.index(of: AmpuleSize)
                    AmpuleSizeStr = ampleSizeesNameArray[indexOfe] as? String  ?? ""
                }
                let AmpulePerbag = DayOfAgeIS["DayAgeSubcutaneousAmpulePerbag"] as? Int ?? 0
                let HatcheryAntibiotics =  DayOfAgeIS["DayAgeSubcutaneousHatcheryAntibiotics"] as? Bool ?? false
                let ManufacturerId = DayOfAgeIS["DayAgeSubcutaneousMfgId"] as? Int ?? 0
                let BagSizeType = DayOfAgeIS["DayAgeSubcutaneousBagSizeType"] as? String ?? ""
                let DiluentMfg = DayOfAgeIS["DayAgeSubcutaneousDiluentMfg"] as? String ?? ""
                var VManufacturerName = ""
                var VName = ""
                var vManufacutrerNameArray = NSArray()
                var vManufacutrerIDArray = NSArray()
                var vManufacutrerDetailsArray = NSArray()
                vManufacutrerDetailsArray = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_VManufacturer")
                vManufacutrerNameArray = vManufacutrerDetailsArray.value(forKey: "mfgName") as? NSArray ?? NSArray()
                vManufacutrerIDArray = vManufacutrerDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                let xxx =    ManufacturerId
                if xxx != 0 {
                    let indexOfd = vManufacutrerIDArray.index(of: xxx)
                    if vManufacutrerNameArray.count > indexOfd{
                        VManufacturerName = vManufacutrerNameArray[indexOfd] as? String ?? ""
                    }
                }
                var vNameArray = NSArray()
                var vIDArray = NSArray()
                var vDetailsArray = NSArray()
                vDetailsArray = CoreDataHandlerPE().fetchDetailsForVaccineNames(typeId: 2)
                vNameArray = vDetailsArray.value(forKey: "name") as? NSArray ?? NSArray()
                vIDArray = vDetailsArray.value(forKey: "id") as? NSArray ?? NSArray()
                let xxxx =    VaccineId
                if xxxx != 0 {
                    if vIDArray.contains(xxxx){
                        let indexOfd = vIDArray.index(of: xxxx) // 3
                        VName = vNameArray[indexOfd] as? String ?? ""
                    }
                } else {
                    if VManufacturerName.lowercased().contains("other"){
                        VName  = otherText
                    }
                }
                if otherText != "" {
                    VName = otherText
                }
                
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                let DayOfAgeDataNew = InovojectData(id: 0,vaccineMan:VManufacturerName,name:VName,ampuleSize:AmpuleSizeStr,ampulePerBag:String(AmpulePerbag),bagSizeType:BagSizeType,dosage:Dosage, dilute: DiluentMfg)
                
                peNewAssessmentInProgress.dDCS  = DiluentMfg
                peNewAssessmentInProgress.dDDT = BagSizeType
                peNewAssessmentInProgress.micro  = ""
                peNewAssessmentInProgress.residue = ""
                if HatcheryAntibiotics == true{
                    peNewAssessmentInProgress.hatcheryAntibioticsDoaS = 1
                } else{
                    peNewAssessmentInProgress.hatcheryAntibioticsDoaS = 0
                }
                let AntibioticInformation = DayOfAgeIS["AntibioticInformation"] as? String ?? ""
                peNewAssessmentInProgress.hatcheryAntibioticsDoaSText = AntibioticInformation
                let infoObj = PEInfoDAO.sharedInstance.fetchInfoVMObj(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", assessmentId: "\(serverAssessmentId)")
                PEInfoDAO.sharedInstance.saveData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", isExtendedPE: sanitationEmbrexValue, assessmentId: "\(serverAssessmentId)", date: nil,subcutaneousTxt: AntibioticInformation, dayOfAgeTxt: infoObj?.dayOfAgeTxtAntibiotic)
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment:peNewAssessmentInProgress,fromDoaS : true)
                let id = self.saveDOAInPEModule(inovojectData: DayOfAgeDataNew, assessment: allAssesmentArr[0] as? PE_AssessmentInProgress ?? PE_AssessmentInProgress(),fromDoaS: true)
                DayOfAgeDataNew.id = id
            }
            
            for  vmixer in  VaccineMixerObservedPostingData{
                let vmixerIS = vmixer as? [String:Any] ?? [:]
                let Name = vmixerIS["Name"] as? String ?? ""
                var CertificationDate = vmixerIS["CertificationDate"] as? String ?? ""
                var CertificationDateIS = ""
                if CertificationDate != "" {
                    CertificationDate =  CertificationDate.replacingOccurrences(of: "T", with: "")
                    CertificationDate =  CertificationDate.replacingOccurrences(of: "00", with: "")
                    CertificationDate = CertificationDate.replacingOccurrences(of: ":", with: "")
                    let array = CertificationDate.components(separatedBy: "-")
                    let date = array[2]
                    let month = array[1]
                    let year = array[0]
                    CertificationDateIS = month + "-" +  date + "-" +  year
                }
                let isCertExpired = vmixerIS["IsCertExpired"] as? Bool ?? false
                let isReCert = vmixerIS["IsReCert"] as? Bool ?? false
                let vacOperatorId = vmixerIS["vacOperatorId"] as? Int ?? 0
                let signatureImg = vmixerIS["SignatureImg"] as? String ?? ""
                
                let imageCount = getVMixerCountInPEModule()
                let certificateData =  PECertificateData(id:imageCount + 1,name:Name,date:CertificationDateIS,isCertExpired: isCertExpired,isReCert: isReCert,vacOperatorId: vacOperatorId, signatureImg: signatureImg, fsrSign: "")
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                
                CoreDataHandlerPE().saveVMixerPEModuleGet(peCertificateData: certificateData,evalutionID:peNewAssessmentInProgress.evaluationID)
            }
            
            var VaccineMicroSamplesPostingData = objDic["VaccineMicroSamplesPostingData"] as? [Any] ?? []
            //Micro
            for  vmixer in  VaccineMicroSamplesPostingData{
                let vmixerIS = vmixer as? [String:Any] ?? [:]
                let Name = vmixerIS["Name"] as? String ?? ""
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                peNewAssessmentInProgress.micro  = Name
                
                
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment:peNewAssessmentInProgress)
                
            }
            let VaccineResiduePostinData = objDic["VaccineResiduePostinData"] as? [Any] ?? []
            
            //Residue
            for  vmixer in  VaccineResiduePostinData{
                let vmixerIS = vmixer as? [String:Any] ?? [:]
                let Name = vmixerIS["Name"] as? String ?? ""
                let  peNewAssessmentInProgress = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
                peNewAssessmentInProgress.residue  = Name
                CoreDataHandlerPE().updateInDoGInProgressInDB(newAssessment:peNewAssessmentInProgress)
            }
            
            //Saving in Progress Data to Draft
            let draftNumber = getDraftCountFromDb()
            for obj in allAssesmentArr {
                CoreDataHandlerPE().saveGetDraftDataToSyncPEInDBFromGet(newAssessment: obj as? PE_AssessmentInProgress ?? PE_AssessmentInProgress(), dataToSubmitNumber: draftNumber + 1,param:param,formateFromServer: AppCreationTime,deviceID:DeviceId)
            }
            CoreDataHandler().deleteAllData("PE_AssessmentInProgress")
            CoreDataHandler().deleteAllData("PE_Refrigator")
        }
        
        showtoast(message: "Assessment moved to draft")
    }
    // MARK: - Save DOA Data in PE Module
    private func saveDOAInPEModule(inovojectData:InovojectData,assessment: PE_AssessmentInProgress,fromDoaS:Bool?=false) -> Int{
        let imageCount = getDOACountInPEModule()
        CoreDataHandlerPE().saveDOAPEModule(assessment: assessment, doaId: imageCount+1,inovojectData: inovojectData,fromDoaS: fromDoaS)
        return imageCount+1
    }
    // MARK: - Save Images in PE Module
    private func saveImageInPEModule(imageData:Data)->Int{
        var allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_ImageEntity")
        let imageCount = getImageCountInPEModule()
        CoreDataHandlerPE().saveImageInPEFinishModule(imageId: imageCount+1, imageData: imageData)
        return imageCount+1
    }
    // MARK: - Get Images Count
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
    // MARK: - Change Data Format
    func convertDateFormat(inputDate: String) -> String {
        
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
    // MARK: - Dismiss Loader
    func dismissHUD(){
        let mainQueue = OperationQueue.main
        mainQueue.addOperation{
            self.dismissGlobalHUD(self.view)
        }
    }
    // MARK: - Save Inovoject Data in PE Module
    private func saveInovojectInPEModule(inovojectData:InovojectData,assessment: PE_AssessmentInProgress) -> Int{
        let imageCount = getDOACountInPEModule()
        CoreDataHandlerPE().saveInovojectPEModule(assessment: assessment ?? PE_AssessmentInProgress(), doaId: imageCount+1,inovojectData: inovojectData)
        return imageCount+1
        
    }
    // MARK: - Filter Category Count
    func filterCategoryCount(peNewAssessmentOf:PENewAssessment) -> Int {
        var peCategoryFilteredArray: [PECategory] =  []
        for object in pECategoriesAssesmentsResponse.peCategoryArray{
            if peNewAssessmentOf.evaluationID == object.evaluationID{
                peCategoryFilteredArray.append(object)
            }
        }
        pECategoriesAssesmentsResponse.peCategoryArray = peCategoryFilteredArray
        return pECategoriesAssesmentsResponse.peCategoryArray.count ?? 0
    }
    
    // MARK: - Get DOA Count In PE
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
    // MARK: - Get Vaccine Mixture
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
    // MARK: - Get Latest Marks of Assessment
    private func GetLatestMarkOfAss(assID:Int) -> Int{
        let allAssesmentArr = CoreDataHandlerPE().fetchDetailsFor(entityName: "PE_AssessmentInProgress")
        for ass in allAssesmentArr{
            let objMark = ass as? PE_AssessmentInProgress ?? PE_AssessmentInProgress()
            if Int(objMark.assID ?? 0) == assID{
                return  objMark.catResultMark as? Int ?? 0
            }
        }
        return 0
    }
    
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC") //TimeZone(name: "UTC") //as TimeZone
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            return ""
        }
        
        dateFormatter.dateFormat = "MM/dd/yyyy"///this is what you want to convert format
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC") //NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: convertedDate ?? Date())
        
        return timeStamp
    }
    // MARK: - Save Draft Data
    private func saveDraftData(assessmentId: String, index: Int){
        let userId = UserContext.sharedInstance.userDetailsObj?.userId ?? "No id found"
        let allAssesmentArr = CoreDataHandlerPE().getRejectedAssessmentArrayPEObject(ofCurrentAssessment:true)
        
        PEAssessmentsDAO.sharedInstance.updateAssessmentStatus(status:"draft",userId:UserContext.sharedInstance.userDetailsObj?.userId ?? "", serverAssessmentId: assessmentId)
        let draftNumber = getDraftCountFromDb()
        CoreDataHandlerPE().saveDraftPEInDB(newAssessmentArray: allAssesmentArr , draftNumber: draftNumber + 1)
        let predicate = NSPredicate(format:"serverAssessmentId = %@", peAssessmentRejectedArray[index].serverAssessmentId ?? "" )
        CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentRejected", predicate: predicate)
        peAssessmentRejectedArray.remove(at: index)
        tableview.reloadData()
        UserDefaults.standard.set(peAssessmentRejectedArray.count, forKey: "rejected_count")
        UserDefaults.standard.synchronize()
        self.showAlertViewWithMessageAndActionHandler("Alert", message: "Your Assessment moved to draft") {
            
        }
        
        finishSession()
    }
    // MARK: - Finish & Clean Session
    func finishSession()  {
        cleanSession()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardPE"),object: nil))
    }
    // MARK: - Get Draft Data Count
    func getDraftCountFromDb() -> Int {
        var allAssesmentDraftArr = CoreDataHandlerPE().fetchDetailsWithUserIDForAny(entityName: "PE_AssessmentInDraft")
        var carColIdArrayDraftNumbers  = allAssesmentDraftArr.value(forKey: "draftID") as? NSArray ?? []
        var carColIdArray : [String] = []
        for obj in carColIdArrayDraftNumbers {
            if !carColIdArray.contains(obj as? String ?? ""){
                carColIdArray.append(obj as? String ?? "")
            }
        }
        return carColIdArray.count
    }
    // MARK: - Clean Session
    private func cleanSession(){
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboard"),object: nil))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        showtoast(message: "In Dev")
    }
    // MARK: - Add Info Pop Up
    @objc func addInfoPopup(sender: UIButton){
        loadPopupVw(index: sender.tag)
    }
    // MARK: - Extended Micro Pop Up
    @objc func addExtendedInfoPopup(sender: UIButton)
    {
        loadExtendedPopupVw(index: sender.tag)
    }
    // MARK: - Close PopUp
    @objc func closePopupBtnAction(){
        hidePopup()
    }
    // MARK: - DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    // MARK: - Load Pop Up View
    private func loadPopupVw(index: Int){
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
        vc.headerValue = "Rejection Comment"
        vc.textOfTextView = peAssessmentRejectedArray[index].rejectionComment ?? ""
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    // MARK: - Load Extended Pop UP View
    private func loadExtendedPopupVw(index: Int){
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CommentPopupViewController") as! CommentPopupViewController
        vc.headerValue = "Extended Micro Rejection Comment"
        //        vc.titleValue = "Comment"
        vc.textOfTextView = peAssessmentRejectedArray[index].emRejectedComment ?? ""
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    // MARK: - Hide Popup View
    private func hidePopup(){
        popupBackView.isHidden = true
        popupView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let NewcountryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID == 3
        {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PESessionHeader" ) as! PESessionHeader
            return headerView
        }else{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PESessionIntHeader" ) as! PESessionIntHeader
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 77.0
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.adjustUITextViewHeight()
    }
    
}

extension UITextView {
    func adjustUITextViewHeight() {
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
    }
}

extension PESessionViewController{
    // MARK: - Get rejected Assessments Images
    private func getRejectedAssessmentImagesListByUser(assId: String){
        let param = ["assessmentId":assId] as JSONDictionary
        ZoetisWebServices.shared.getRejectedAssessmentImagesListByUser(controller: self, parameters: param, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else {
                self?.dismissGlobalHUD(self?.view ?? UIView()); return; }
            let mainQueue = OperationQueue.main
            mainQueue.addOperation{
                self?.handlGetRejectedAssessmentImagesListByUser(json, assId)
            }
        })
    }
    // MARK: - Handle Rejected Assessments Images List
    private func handlGetRejectedAssessmentImagesListByUser(_ json: JSON, _ assId: String) {
        //  print(json)
        
        //convert the JSON to a raw String
        var dataDic : [String:Any] = [:]
        var dataArray : [Any] = []
        if let string = json.rawString() {
            dataDic = string.convertToDictionary() ?? [:]
        }
        
        dataArray = dataDic["Data"] as? [Any] ?? []
        
        for obj in dataArray {
            DispatchQueue.main.async {
                
                var objDic : [String:Any] = [:]
                objDic =  obj as? [String:Any] ?? [:]
                let base64Encoded = objDic["ImageBase64"] as? String ?? ""
                let DisplayId = objDic["DisplayId"] as? String ?? ""
                let DeviceId = objDic["Device_Id"] as? String ?? ""
                let UserId = objDic["UserId"] as? Int ?? 0
                let Assessment_Id = objDic["Assessment_Id"] as? Int ?? 0
                let Module_Assessment_Categories_Id = objDic["Module_Assessment_Categories_Id"] as? Int ?? 0
                let decodedData = Data(base64Encoded: base64Encoded) ?? Data()
                let AppCreationTime = DisplayId.replacingOccurrences(of: "C-", with: "")
                
                let imageCount = self.getImageCountInPEModule()
                CoreDataHandlerPE().saveImageInGetApi(imageId:imageCount+1,imageData:decodedData)
                
                CoreDataHandlerPE().saveImageIdGetApi(imageId:imageCount+1,userID:UserId,catID:Module_Assessment_Categories_Id,assID:Assessment_Id,dataToSubmitID:AppCreationTime)
                CoreDataHandlerPE().saveImageOngoingDraftIdGetApi(imageId:imageCount+1,userID:UserId,catID:Module_Assessment_Categories_Id,assID:Assessment_Id,dataToSubmitID:AppCreationTime)
                CoreDataHandlerPE().saveImageDraftIdGetApi(imageId:imageCount+1,userID:UserId,catID:Module_Assessment_Categories_Id,assID:Assessment_Id,dataToSubmitID:AppCreationTime)
                
            }
        }
        let predicate = NSPredicate(format:"serverAssessmentId = %@", assId )
        CoreDataHandlerPE().deleteExisitingData(entityName: "PE_AssessmentRejected", predicate: predicate)
        
        self.tableview.reloadData()
        self.showtoast(message: "Assessment moved to draft")
        self.navigationController?.popToViewController(ofClass: PEDraftViewController.self)
        self.dismissGlobalHUD(self.view ?? UIView())
        
    }
    
}


extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
}
