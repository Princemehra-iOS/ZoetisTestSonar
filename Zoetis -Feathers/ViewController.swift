// ViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 11/08/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import Reachability
import FirebaseCrashlytics
import JNKeychain
import simd
import Gigya
import GigyaTfa
import GigyaAuth
import SwiftyJSON
//import JNKeychain

class ViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, syncApiTurkey, syncApi {
    
    
    var delegate: SidePenalDelegate?
    let myBlueColor = (UIColor(red: 204.0, green: 227.0, blue: 255.0, alpha: 1.0))
    var loginArray = NSArray()
    var hatcheryVaccDict = NSMutableDictionary()
    var fieldVaccDict = NSMutableDictionary()
    var otherDict = NSMutableDictionary()
    var dashboardVC: PEDashboardViewController = PEDashboardViewController()
    
    
    var objApiSync = ApiSync()
    var objApiSyncTurkey = ApiSyncTurkey()
    @IBOutlet weak var versionNumber: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    
    var accestoken = String()
    var userName = String()
    var password = String()
    var termsCond = Int()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var lastScreenFlag: Int!
    let buttonbg = UIButton()
    var droperTableView  =  UITableView()
    var langArray: [String] = []
    var langDict = NSMutableDictionary()
    var newOpenModules : Bool = true
    var bottomViewController:BottomViewController!
    var isPassHidden = true;
    
    @IBOutlet weak var lblAppName: UILabel!
    @IBOutlet weak var lblAppVersion: UILabel!
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnLanguage: UIButton!
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var nextBtn: PESubmitButton!
    
    var btnTag = Int()
    var langNameArray: [String] = []
    var langCultureArray : [String] = []
    var langIdArray : [NSNumber] = []
    var countryArray: [String] = []
    var countryId: [NSNumber] = []
    var apiKeyId: NSNumber?
    var domainName : String?
    var apiKey: String?
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
   
    
    
    private let sessionManager: Session = {
           let configuration = URLSessionConfiguration.default
           configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
           configuration.urlCache = nil
           return Session(configuration: configuration)
       }()
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        
        lblCountry.text = "Select country"
        lblLanguage.text = "Select language"
        
        lblCountry.textColor = .lightGray
        lblLanguage.textColor = .lightGray
        
        btnLanguage.layer.cornerRadius = 1
        btnLanguage.layer.borderColor = UIColor.black.cgColor
        
        btnCountry.layer.cornerRadius = 1
        btnCountry.layer.borderColor = UIColor.black.cgColor
        
        countryView.layer.borderWidth  = 2
        countryView.layer.borderColor = UIColor.getBorderColorr().cgColor
        countryView.layer.cornerRadius = 18.5
        countryView.backgroundColor = UIColor.white
        
        languageView.layer.borderWidth  = 2
        languageView.layer.borderColor = UIColor.getBorderColorr().cgColor
        languageView.layer.cornerRadius = 18.5
        languageView.backgroundColor = UIColor.white
        
        
        setLeftPenalNotification()
        if ConnectionManager.shared.hasConnectivity() {
            CoreDataHandler().deleteAllData("Custmer")
            CoreDataHandlerTurkey().deleteAllDataTurkey("CustmerTurkey")
        }
        
        UserDefaults.standard.synchronize()
        
        setupHeader()
        
        lblAppName.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        
        var liveAlbums = 3
        let environmentIs = Constants.Api.versionUrl
        
        if environmentIs.contains("stageapi") {
            liveAlbums = 0
        } else if environmentIs.contains("devapi") {
            liveAlbums = 1
        } else if environmentIs.contains("supportapi") {
            liveAlbums = 2
        } else {
            liveAlbums = 3
        }
        
        switch liveAlbums {
        case 0:
            lblAppVersion.text = "Version " + Bundle.main.versionNumber + " (UAT)"
            
        case 1:
            lblAppVersion.text = "Version " + Bundle.main.versionNumber + " (Dev)"
            
        case 2:
            lblAppVersion.text = "Version " + Bundle.main.versionNumber + " (Dev Support)"
            
        case 3:
            lblAppVersion.text = "Version " + Bundle.main.versionNumber
            
        default:
            lblAppVersion.text = "Version " + Bundle.main.versionNumber
        }
    }
    
    // MARK:  /*********** Fetch Gigya Country List **************/
    private func fetchGigyaCountryList(){
        Constants.baseUrl = Constants.Api.fhBaseUrl
        self.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
        if ConnectionManager.shared.hasConnectivity() {
            ZoetisWebServices.shared.getGigyaCountryList(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Gigya Country list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                let mainQueue = OperationQueue.main
                mainQueue.addOperation{
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    self?.countryArray.removeAll()
                    self?.countryId.removeAll()
                    
                    let dataArray = json
                    for countries in dataArray {
                        let countryName = countries.1
                        let country = countryName["CountryName"]
                        let countryIds = countryName["CountryId"]
                        self?.countryArray.append(country.rawValue as! String)
                        self?.countryId.append(countryIds.rawValue as! NSNumber)
                    }
                }
            })
        }
        
        else{
            self.showToastWithTimer(message: "Failed to get Gigya Country list", duration: 3.0)
            self.dismissGlobalHUD(self.view ?? UIView())
        }
    }
    
    // MARK:  /*********** Fetch Gigya Country Languages List **************/
    private func fetchGigyaCountryLang(countryId: String){
        Constants.baseUrl = Constants.Api.fhBaseUrl
        if ConnectionManager.shared.hasConnectivity() {
            ZoetisWebServices.shared.getGigyaCountryLanguage(countryID: countryId,controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                let mainQueue = OperationQueue.main
                mainQueue.addOperation{
                    var dataArray = json
                    for languages in dataArray {
                        var language = languages.1
                        let langCulture = language["Language_Culture"]
                        
                        self?.langCultureArray.append(langCulture.rawValue as! String)
                        let langName = language["Language_Name"]
                        
                        self?.langNameArray.append(langName.rawValue as! String)
                        let langId = language["Id"]
                        
                        self?.langIdArray.append(langId.rawValue as! NSNumber)
                        
                    }
                }
            })
        }
        
        else{
            self.showToastWithTimer(message: "Failed to get Gigya Country's Language list", duration: 3.0)
            self.dismissGlobalHUD(self.view ?? UIView())
        }
    }
    // MARK:  /*********** Fetch Gigya API Keys List **************/
    private func fetchGigyaApiKeys(countryId: String){
        Constants.baseUrl = Constants.Api.fhBaseUrl
        if ConnectionManager.shared.hasConnectivity() {
            ZoetisWebServices.shared.getGigyaApiKeys(countryID: countryId,controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                let mainQueue = OperationQueue.main
                mainQueue.addOperation{
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    let dataArray = json
                    for apiKeys in dataArray {
                        let apiKeys = apiKeys.1
                        
                        let countryApiKey = apiKeys["API_Keys"]
                        debugPrint(countryApiKey)
                        
                        self?.apiKey = countryApiKey.rawValue as? String
                        let domainName = apiKeys["Data_Center"]
                        self?.domainName = domainName.rawValue as? String
                        let apiKeyId = apiKeys["Id"]
                        self?.apiKeyId = apiKeyId.rawValue as? NSNumber
                        
                        var liveAlbums = 3
                        let environmentIs = Constants.Api.versionUrl
                        
                        if environmentIs.contains("stageapi") {
                            liveAlbums = 0
                        } else if environmentIs.contains("devapi") {
                            liveAlbums = 1
                        } else if environmentIs.contains("supportapi") {
                            liveAlbums = 2
                        } else {
                            liveAlbums = 3
                        }
                        
                        switch liveAlbums {
                        case 0:
                            self?.gigya.initFor(apiKey: "4_KkOJPb7zC89ubdZyo8pEWg" , apiDomain: self?.domainName)
                          //  self?.gigya.initFor(apiKey: self?.apiKey ?? "" , apiDomain: self?.domainName)
                        case 1:
                            self?.gigya.initFor(apiKey: "4_KkOJPb7zC89ubdZyo8pEWg" , apiDomain: self?.domainName)
                        case 2:
                            self?.gigya.initFor(apiKey: "4_KkOJPb7zC89ubdZyo8pEWg" , apiDomain: self?.domainName)
                        case 3:
                            self?.gigya.initFor(apiKey: self?.apiKey ?? "" , apiDomain: self?.domainName)
                        default:
                            self?.gigya.initFor(apiKey: self?.apiKey ?? "" , apiDomain: self?.domainName)
                        }
                        
                    }
                }
            })
        }
        
        else{
            self.showToastWithTimer(message: "Failed to get Gigya API keys", duration: 3.0)
            self.dismissGlobalHUD(self.view ?? UIView())
        }
    }
    
    
    
    // MARK:  /*********** Country Button Action **************/
    @IBAction func countryBtnAction(_ sender: Any) {
        
        btnTag = 1
        tableViewpop()
    }
    // MARK:  /*********** Language button Action **************/
    @IBAction func languageBtnAction(_ sender: Any) {
        lblLanguage.textColor = .black
        btnTag = 2
        tableViewpop()
    }
    // MARK:  /*********** Next button Action **************/
    @IBAction func nextBtnAction(_ sender: Any) {
        
        if lblCountry.text == ""
        {
            self.showToastWithTimer(message: "Please select Country ", duration: 3.0)
        }
        else if lblCountry.text == "Select country"
        {
            self.showToastWithTimer(message: "Please select Country ", duration: 3.0)
        }
        else if lblLanguage.text == ""
        {
            self.showToastWithTimer(message: "Please select Language ", duration: 3.0)
        }
        else if lblLanguage.text == "Select language"
        {
            self.showToastWithTimer(message: "Please select Language ", duration: 3.0)
        }
        
        else
        {
            if ConnectionManager.shared.hasConnectivity() {
                self.ssologoutMethod()
                
                var registerloginIs = "RegistrationLogin_US"
                if lblCountry.text == "United States" {
                    registerloginIs = "RegistrationLogin_US"
                }else{
                    registerloginIs = "RegistrationLogin"
                }
                
                let newParam = ["startScreen": "gigya-login-screen"]
                
                Gigya.sharedInstance().showScreenSet(with: registerloginIs , viewController: self , params: newParam) { [weak self] (result) in
                    guard let self = self else { return }
                    
                    switch result {
                    case .onLogin(let account):
                        
                        self.loginMethod(Email: account.profile?.email ?? "", GUID: account.UID ?? "", GUIDSignature: account.UIDSignature ?? "", SignatureTimestamp: account.signatureTimestamp ?? "")
                        
                    case .error(let event):
                        
                        debugPrint(event)
                    default:
                        break
                    }
                }
                
            }
            
            else
            {
                self.alerViewInternet()
            }
        }
        
    }
    
    // MARK:  /*********** Logout SSO Account **************/
    func ssologoutMethod()
    {
        gigya.logout() { result in
            switch result {
            case .success(let data):
                debugPrint(data)
                
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // MARK:  /*********** Login With SSO Account **************/
    func loginMethod(Email : String ,GUID : String ,GUIDSignature : String ,SignatureTimestamp : String ) {
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        
        if WebClass.sharedInstance.connected() {
            self.deleteAllData("Login")
            _ = Helper.showGlobalProgressHUDWithTitle(self.view, title: "Logging in...Please Wait")
            let Url = "Token"
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded","Accept": "application/json"]
            let parameters:[String:String] = ["grant_type": "password","UserName" : CryptoHelper.encrypt(input:Email), "Password" : "" , "LoginType": "App","DeviceId":udid as! String,"ChkEnvironment":WebClass.sharedInstance.ChkEnvironmentLive , "GUID":GUID , "GUIDSignature":GUIDSignature, "SignatureTimestamp":SignatureTimestamp , "AppVersion": "\(Bundle.main.versionNumber)" , "TokenVersion":"V2"]
            
            sessionManager.request(urlString, method: .post,parameters: parameters, headers: headers).responseJSON { response in
                
                let stass = response.response?.statusCode
                if stass == 500 {
                    Helper.dismissGlobalHUD(self.view)
                    Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"InvalidWebcredentials")
                    self.ssologoutMethod()
                    return
                }
                
                if stass == 400 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.ssologoutMethod()
                        Helper.dismissGlobalHUD(self.view)
                        Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"Authorisation failed please contact PV360 support team poultryview360@zoetis.com.")
                        return
                    }
                    
                }
                
                switch response.result {
                case let .success(value):
                    UserDefaults.standard.set(false, forKey:"PECleanSession")
                    UserDefaults.standard.set(nil, forKey: "PE_Selected_Customer_Id")
                    UserDefaults.standard.set(nil, forKey: "PE_Selected_Customer_Name")
                    UserDefaults.standard.set(nil, forKey: "PE_Selected_Site_Id")
                    UserDefaults.standard.set(nil, forKey: "PE_Selected_Site_Name")
                    let mailTexts = Email ?? ""
                    let lastUsername = PasswordService.shared.getUsername()
                    if lastUsername != "" && mailTexts != ""{
                        if lastUsername.removeWhitespace().contains(mailTexts.removeWhitespace()){
                            UserDefaults.standard.set(false, forKey: "PENewUserLoginFlag")
                        }else{
                            UserDefaults.standard.set(true, forKey: "PENewUserLoginFlag")
                        }
                    }
                    
                    PasswordService.shared.setUsername(password: Email)
                    
                    UserDefaults.standard.set(false, forKey: "hasAppMovedToBackground")
                    let jsonDecoder = JSONDecoder()
                    let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    if let data = jsonData{
                        let userResponseObj = try? jsonDecoder.decode(UserResponseDTO.self, from: jsonData!)
                        if userResponseObj != nil{
                            if let lastFilledUserId =  UserContextDAO.sharedInstance.getUserContextFilledObj()?.userId?.removeWhitespace(){
                                UserContext.sharedInstance.setUserDetails(userResponseObj!)
                                if let newlyFilledUserId =  UserContextDAO.sharedInstance.getUserContextFilledObj()?.userId?.removeWhitespace(){
                                    if newlyFilledUserId == lastFilledUserId{
                                        UserDefaults.standard.set(false, forKey: "PENewUserLoginFlag")
                                    }else{
                                        UserDefaults.standard.set(true, forKey: "PENewUserLoginFlag")
                                    }
                                    
                                }
                            }
                            UserContext.sharedInstance.setUserDetails(userResponseObj!)
                            UserDefaults.standard.set(true, forKey: "hasLoggedIn")
                        }
                    }
                    
                    let dict : NSDictionary = value as! NSDictionary
                    
                    let statusCode = response.response?.statusCode
                    
                    if (dict.value(forKey: "error") as? String) ?? ""  == "invalid_grant"{
                        self.ssologoutMethod()
                        let errorMSg = dict["error_description"]
                        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            Helper.dismissGlobalHUD(self.view)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        return
                        
                    }
                    if statusCode == 401{
                        self.ssologoutMethod()
                        let errorMSg = dict["error_description"]
                        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            
                            Helper.dismissGlobalHUD(self.view)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else{
                        let ModuleId = (dict.value(forKey: "ModuleId") as? String) ?? ""
                        let arrModuleIds = ModuleId.components(separatedBy: "~")
                        if !(arrModuleIds.count > 1){
                            if arrModuleIds[0] == "21"{
                                let roleID = dict.value(forKey: "RoleIds") as? String ?? ""
                                if roleID != "31" && roleID != "33"{
                                    Helper.dismissGlobalHUD(self.view)
                                    Helper.showAlertMessage(self, titleStr: "", messageStr: "Sorry you dont have access for this.")
                                    return
                                }
                                
                            }
                        }
                        let ModuleName = (dict.value(forKey: "ModuleName") as? String) ?? ""
                        
                        let moduleIdIs = ModuleId.replacingOccurrences(of: "~", with: "")
                        UserDefaults.standard.set(ModuleId, forKey: "ModuleIdsArray")
                        UserDefaults.standard.set(moduleIdIs, forKey: "ModuleId")
                        UserDefaults.standard.set(ModuleName, forKey: "ModuleName")
                        
                        let RoleId = (dict.value(forKey: "RoleId") as? String) ?? ""
                        UserDefaults.standard.set(RoleId, forKey: "RoleId")
                        let RoleIds = (dict.value(forKey: "RoleIds") as? String) ?? ""
                        UserDefaults.standard.set(RoleIds, forKey: "RoleIds")
                        
                        let Regionid = (dict.value(forKey: "Regionid") as? String) ?? ""
                        UserDefaults.standard.set(Regionid, forKey: "Regionid")
                        
                        let acessToken =  (dict.value(forKey: "access_token") as? String) ?? ""
                        let countryId = dict.value(forKey: "CountryId")
                        let LastName = dict.value(forKey: "LastName")
                        let salcountryId = dict.value(forKey: "NonUSCountryId")
                        
                        UserDefaults.standard.set(salcountryId, forKey: "nonUScountryId")
                        
                        let  birdTypeId = dict.value(forKey: "BirdTypeId")
                        UserDefaults.standard.set(LastName, forKey: "LastName")
                        UserDefaults.standard.set(birdTypeId, forKey: "birdTypeId")
                        UserDefaults.standard.set(birdTypeId, forKey: "switchBird")
                        let switchBird = UserDefaults.standard.integer(forKey: "switchBird")
                        if switchBird == 2 {
                            UserDefaults.standard.set(true, forKey: "turkeyReport")
                        }
                        else {
                            UserDefaults.standard.set(false, forKey: "turkeyReport")
                        }
                        UserDefaults.standard.set(countryId, forKey: "countryId")
                        UserDefaults.standard.synchronize()
                        let tokenType = (dict.value(forKey: "token_type") as? String)!
                        let aceesTokentype: String = tokenType + " " + acessToken
                        let roleId = dict.value(forKey: "HasAccess")! as AnyObject
                        let role = roleId.integerValue
                      //  UserDefaults.standard.set(aceesTokentype,forKey: "aceesTokentype")
                        AccessTokenHelper().saveToKeychain(valued: aceesTokentype, keyed: "aceesTokentype")
                       // AccessTokenHelper.saveData(aceesTokentype)
                        UserDefaults.standard.set(role!, forKey: "Role")
                        UserDefaults.standard.synchronize()
                        
                        let Id = dict.value(forKey:"Id")!  as AnyObject
                        let id = Id.integerValue
                        
                        let FirstName = dict.value(forKey: "FirstName") as! String
                        
                        let terms = dict.value(forKey: "TermAccepted")! as! String
                        if terms == "true"{
                            self.termsCond = 1
                        } else {
                            self.termsCond = 0
                        }
                        
                        let userId = UserDefaults.standard.integer(forKey: "Id")
                        
                        UserDefaults.standard.set(terms, forKey: "Terms")
                        UserDefaults.standard.set(terms, forKey: "TermsChicken")
                        UserDefaults.standard.set(terms, forKey: "TermsTurkey")
                        
                        let birdId = UserDefaults.standard.integer(forKey: "birdTypeId")
                        
                        if birdId == 2 {
                            UserDefaults.standard.set(false, forKey: "turkey")
                            
                        } else if birdId == 1 {
                            UserDefaults.standard.set(false, forKey: "Chicken")
                        }
                        // **********Chicken DataBase delete**************//
                        self.deleteAllData("AlternativeFeed")
                        self.deleteAllData("AntiboticFeed")
                        self.deleteAllData("BirdPhotoCapture")
                        self.deleteAllData("BirdSizePosting")
                        self.deleteAllData("Breed")
                        self.deleteAllData("CamraImage")
                        self.deleteAllData("CaptureNecropsyData")
                        self.deleteAllData("CaptureNecropsyViewData")
                        self.deleteAllData("Coccidiosis")
                        self.deleteAllData("CoccidiosisControlFeed")
                        self.deleteAllData("CocciProgramPosting")
                        self.deleteAllData("ComplexPosting")
                        self.deleteAllData("Custmer")
                        self.deleteAllData("CustomerReprestative")
                        self.deleteAllData("FarmsList")
                        self.deleteAllData("FeedProgram")
                        self.deleteAllData("FieldVaccination")
                        self.deleteAllData("GITract")
                        self.deleteAllData("HatcheryVac")
                        self.deleteAllData("Immune")
                        self.deleteAllData("Login")
                        self.deleteAllData("MyCotoxinBindersFeed")
                        self.deleteAllData("Necropsy")
                        self.deleteAllData("NotesBird")
                        self.deleteAllData("PostingSession")
                        self.deleteAllData("Respiratory")
                        self.deleteAllData("Route")
                        self.deleteAllData("Salesrep")
                        self.deleteAllData("Sessiontype")
                        self.deleteAllData("Skeleta")
                        self.deleteAllData("Veteration")
                        
                        
                        // **********Turkey DataBase delete**************//
                        self.deleteAllData("AlternativeFeedTurkey")
                        self.deleteAllData("AntiboticFeedTurkey")
                        self.deleteAllData("BirdPhotoCaptureTurkey")
                        self.deleteAllData("BirdSizePostingTurkey")
                        self.deleteAllData("BreedTurkey")
                        self.deleteAllData("CamraImageTurkey")
                        self.deleteAllData("CaptureNecropsyDataTurkey")
                        self.deleteAllData("CaptureNecropsyViewDataTurkey")
                        self.deleteAllData("CoccidiosisTurkey")
                        self.deleteAllData("CoccidiosisControlFeedTurkey")
                        self.deleteAllData("CocciProgramPostingTurkey")
                        self.deleteAllData("ComplexPostingTurkey")
                        self.deleteAllData("CustmerTurkey")
                        self.deleteAllData("CustomerReprestativeTurkey")
                        self.deleteAllData("FarmsListTurkey")
                        self.deleteAllData("FeedProgramTurkey")
                        self.deleteAllData("FieldVaccinationTurkey")
                        self.deleteAllData("GITractTurkey")
                        self.deleteAllData("HatcheryVacTurkey")
                        self.deleteAllData("ImmuneTurkey")
                        self.deleteAllData("LoginTurkey")
                        self.deleteAllData("MyCotoxinBindersFeedTurkey")
                        self.deleteAllData("NecropsyTurkey")
                        self.deleteAllData("NotesBirdTurkey")
                        self.deleteAllData("PostingSessionTurkey")
                        self.deleteAllData("RespiratoryTurkey")
                        self.deleteAllData("RouteTurkey")
                        self.deleteAllData("SalesrepTurkey")
                        self.deleteAllData("SessiontypeTurkey")
                        self.deleteAllData("SkeletaTurkey")
                        self.deleteAllData("VeterationTurkey")
                        
                        UserDefaults.standard.set(FirstName,forKey: "FirstName")
                        UserDefaults.standard.set(id!, forKey: "Id")
                        UserDefaults.standard.synchronize()
                        let postingData = CoreDataHandler().fetchAllPostingExistingSession()
                        let postingDataTurkey = CoreDataHandlerTurkey().fetchAllPostingExistingSessionTurkey()
                        
                        if birdId == 1{
                            if postingData.count == 0{
                                self.getPostingDataFromServer()
                            }
                        }  else if birdId == 2{
                            if postingDataTurkey.count == 0{
                                self.getPostingDataFromServerTurkey()
                            }
                            
                        }  else{
                            if postingData.count == 0 || postingDataTurkey.count == 0{
                                self.getPostingDataFromServer()
                            }
                        }
                        
                        UserDefaults.standard.set(true, forKey: "isLoggedIn_successful")
                        UserDefaults.standard.synchronize()
                        
                        self.loginArray = CoreDataHandler().fetchLoginType()
                        if(self.loginArray.count == 0){
                            CoreDataHandler().LoginDatabase(1, userId: id! as NSNumber , userName: Email  , status: 1, signal: "", loginId: 0, dbArray: self.loginArray, index: 0)
                        }
                    }
                    break
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    break
                }
                
            }
        }
        // ************* Off Line Checking Login Credential  Second time *************/
        else  {
            let name = Email as String
            self.loginArray = CoreDataHandler().fetchLoginTypeWithUserEmail(email:name)
            if  loginArray.count == 0{
                Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"You are offline. Please go online for first time login.")
            }
            else {
                
                for i in 0..<loginArray.count {
                    userName = (loginArray.object(at: i) as AnyObject).value(forKey: "username") as! String
                }
                
                let name = Email as String
                if userName.lowercased() == name {
                    
                    UserDefaults.standard.set(true, forKey: "login")
                    self.lastScreenFlag = UserDefaults.standard.value(forKey: "LastScreenRef") as? Int
                    
                    if lastScreenFlag == 1 {
                        UserDefaults.standard.set(1, forKey: "birdTypeId")
                    }
                    else if lastScreenFlag == 2 {
                        UserDefaults.standard.set(2, forKey: "birdTypeId")
                    }
                    else if lastScreenFlag == 3 {
                        UserDefaults.standard.set(3, forKey: "birdTypeId")
                    }
                    
                    self.callDashBordView()
                }
                else if userName.lowercased() != name{
                    Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"Please enter valid mail .")
                }
            }
        }
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        //, name: Notification.Name.willResig, object: nil)
    }
    
    // MARK:  Call Sync API for Feed Program Chicken *******/
    func callSyncApi() {
        objApiSync.feedprogram()
    }
    // MARK:  Call Sync API for Feed Program Turkey *******/
    func callSyncApiTurkey() {
        
        objApiSyncTurkey.feedprogram()
    }
    
    
    // MARK: ******* Get All Session for Chicken**********/
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId
                {
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
    
    // MARK: ******* Get All Session for Turkey**********/
    func allSessionArrTurkey() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j) as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w) as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId
                {
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
    
    // MARK: ******* Method for Fail with Error Message **********/
    
    func failWithError(statusCode:Int) {
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        Helper.dismissGlobalHUD((UIApplication.shared.keyWindow)!)
        if statusCode == 0{
            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again.(NA)")
        } else {
            
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
                
            } else if lngId == 3 {
                
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
            }
        }
    }
    
    func dismisLoader() {
        if let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) {
            
            Helper.dismissGlobalHUD(keyWindow)
        }
    }
    
    // MARK: ******* Method for Internet Connection Fail with Error Message **********/
    func failWithErrorInternal() {
        self.dismisLoader()
        Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("No internet connection. Please try again!", comment: ""))
        
    }
    
    
    func failWithInternetConnection(){
        appDelegate.testFuntion()
    }
    // MARK: ******* Navigate to Bird Selection Screen **********/
    func didFinishApi(){
        
        Helper.dismissGlobalHUD((UIApplication.shared.keyWindow)!)
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        
    }
    
    // MARK: ******* Logout Method **********/
    func logoutBtnAction(){
        
        self.ssologoutMethod()
        let moduleID =   UserDefaults.standard.string(forKey:"ModuleId")
        let moduleName =   UserDefaults.standard.string(forKey:"ModuleName")
        let userType =   UserDefaults.standard.string(forKey:"userType")
        
        let errorMSg = "Are you sure you want to logout?"
        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            NSLog("OK Pressed")
            UserDefaults.standard.set(false, forKey: "hasVaccinationDataLoaded")
            if userType == "PVE" {// For PVE
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "syncDataNoti"),object: nil))
            }
            if userType == "PE" {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "peSyncDataNoti"),object: nil))
            }
            else  if userType == "Microbial"{
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "microbialSyncDataNoti"),object: nil))
            }
            else  if userType == "FlockHealth"{
                self.logoutActionFlockHealth()
            }
            else  if userType == "Vaccination"{
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "TraningSyncDataNoti"),object: nil))
            }
        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) 
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    // MARK: ******* Flock Health Logout Method **********/
    func logoutActionFlockHealth() {
        
        UserDefaults.standard.set(false, forKey: "newlogin")
        
        UserDefaults.standard.set(true, forKey: "callDraftApi")
        ViewController.savePrevUserLoggedInDetails()
        ViewController.clearDataBeforeLogout()
        self.ssologoutMethod()
        
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
            if controller.isKind(of: ViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    // MARK: ******* Tranning & Certification Logout Method **********/
    func logoutActionTraningAndCertification() {
        
        UserDefaults.standard.set(false, forKey: "newlogin")
        UserDefaults.standard.set(true, forKey: "callDraftApi")
        ViewController.savePrevUserLoggedInDetails()
        self.ssologoutMethod()
        for controller in (self.navigationController?.viewControllers ?? []) as Array {
            if controller.isKind(of: ViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
    // MARK: ******* Clear Data Before Logout **********/
    class func clearDataBeforeLogout(){
        
        PasswordService.shared.deleteUsername()
        PasswordService.shared.deletePassword()
        UserDefaults.standard.setValue(false, forKey: "isSession")
        UserDefaults.standard.removeObject(forKey: "ModuleId")
        UserDefaults.standard.removeObject(forKey: "ModuleName")
        UserDefaults.standard.removeObject(forKey: "RoleId")
        UserDefaults.standard.removeObject(forKey: "RoleIds")
        UserDefaults.standard.removeObject(forKey: "nonUScountryId")
        UserDefaults.standard.removeObject(forKey: "birdTypeId")
        UserDefaults.standard.removeObject(forKey: "switchBird")
        UserDefaults.standard.removeObject(forKey: "turkeyReport")
        UserDefaults.standard.removeObject(forKey: "countryId")
        UserDefaults.standard.removeObject(forKey: "aceesTokentype")
        UserDefaults.standard.removeObject(forKey: "Role")
        UserDefaults.standard.removeObject(forKey: "login")
        UserDefaults.standard.removeObject(forKey: "FirstName")
        UserDefaults.standard.removeObject(forKey: "LastName")
        UserDefaults.standard.removeObject(forKey: "Id")
        UserDefaults.standard.removeObject(forKey: "isFreshLaunched")
        CoreDataHandler().deleteAllData("PVE_CustomerComplexPopup")
        CoreDataHandler().deleteAllData("Customer_PVE")
        UserDefaults.standard.synchronize()
    }
    
    // MARK: ******* Save Previous Logged in User **********/
    class func savePrevUserLoggedInDetails(){
        let keychainHelper = AccessTokenHelper()
        let ModuleId = UserDefaults.standard.value(forKey:"ModuleId") as? String ?? ""
        let ModuleName = UserDefaults.standard.value(forKey:"ModuleName") as? String ?? ""
        let RoleId =  UserDefaults.standard.value(forKey:"RoleId") as? Int ?? 0
        let nonUScountryId =  UserDefaults.standard.value(forKey:"nonUScountryId") as? Int ?? 0
        let birdTypeId =  UserDefaults.standard.value(forKey:"birdTypeId") as? Int ?? 0
        let switchBird =  UserDefaults.standard.value(forKey:"switchBird") as? Int ?? 0
        let turkeyReport =  UserDefaults.standard.value(forKey:"turkeyReport") as? Bool ?? false
        let countryId =  UserDefaults.standard.value(forKey:"countryId") as? Int ?? 0
        
        let aceesTokentype = keychainHelper.getFromKeychain(keyed: "aceesTokentype")
      
      //  let aceesTokentype = UserDefaults.standard.value(forKey:"aceesTokentype") as? String ?? ""
        
        let Role =  UserDefaults.standard.value(forKey:"Role") as? Int ?? 0
        let login =  UserDefaults.standard.value(forKey:"login") as? Bool ?? false
        let FirstName = UserDefaults.standard.value(forKey:"FirstName") as? String ?? ""
        let LastName = UserDefaults.standard.value(forKey:"LastName") as? String ?? ""
        let Id =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        let userName = PasswordService.shared.getUsername()
        let pass = PasswordService.shared.getPassword()
        
        UserDefaults.standard.set(userName, forKey: "userNamePrev")
        UserDefaults.standard.set(pass, forKey: "passPrev")
        
        UserDefaults.standard.set(ModuleId, forKey: "ModuleIdPrev")
        UserDefaults.standard.set(ModuleName, forKey: "ModuleNamePrev")
        UserDefaults.standard.set(RoleId, forKey: "RoleIdPrev")
        UserDefaults.standard.set(nonUScountryId, forKey: "nonUScountryIdPrev")
        UserDefaults.standard.set(birdTypeId, forKey: "birdTypeIdPrev")
        UserDefaults.standard.set(switchBird, forKey: "switchBirdPrev")
        UserDefaults.standard.set(turkeyReport, forKey: "turkeyReportPrev")
        UserDefaults.standard.set(countryId, forKey: "countryIdPrev")
       // UserDefaults.standard.set(aceesTokentype, forKey: "aceesTokentypePrev")
        
        
        keychainHelper.saveToKeychain(valued: "\(String(describing: aceesTokentype))", keyed: "aceesTokentypePrev")
        
        UserDefaults.standard.set(Role, forKey: "RolePrev")
        UserDefaults.standard.set(login, forKey: "loginPrev")
        UserDefaults.standard.set(FirstName, forKey: "FirstNamePrev")
        UserDefaults.standard.set(LastName, forKey: "LastNamePrev")
        UserDefaults.standard.set(Id, forKey: "IdPrev")
        UserDefaults.standard.synchronize()
        
    }
    
    // MARK: ******* Save Previous Logged in User other Detail **********/
    func savePrevUserLoggedInDetailsToCurrentForOfflineLogin(){
        let keychainHelper = AccessTokenHelper()
        let ModuleIdPrev = UserDefaults.standard.value(forKey:"ModuleIdPrev") as? String ?? ""
        let ModuleNamePrev = UserDefaults.standard.value(forKey:"ModuleNamePrev") as? String ?? ""
        let RoleIdPrev =  UserDefaults.standard.value(forKey:"RoleIdPrev") as? Int ?? 0
        let nonUScountryIdPrev =  UserDefaults.standard.value(forKey:"nonUScountryIdPrev") as? Int ?? 0
        let birdTypeIdPrev =  UserDefaults.standard.value(forKey:"birdTypeIdPrev") as? Int ?? 0
        let switchBirdPrev =  UserDefaults.standard.value(forKey:"switchBirdPrev") as? Int ?? 0
        let turkeyReportPrev =  UserDefaults.standard.value(forKey:"turkeyReportPrev") as? Bool ?? false
        let countryIdPrev =  UserDefaults.standard.value(forKey:"countryIdPrev") as? Int ?? 0
       // let aceesTokentypePrev = UserDefaults.standard.value(forKey:"aceesTokentypePrev") as? String ?? ""
        
        
        let aceesTokentypePrev = keychainHelper.getFromKeychain(keyed: "aceesTokentypePrev")

     
        
        let RolePrev =  UserDefaults.standard.value(forKey:"RolePrev") as? Int ?? 0
        let loginPrev =  UserDefaults.standard.value(forKey:"loginPrev") as? Bool ?? false
        let FirstNamePrev = UserDefaults.standard.value(forKey:"FirstNamePrev") as? String ?? ""
        let LastNamePrev = UserDefaults.standard.value(forKey:"LastNamePrev") as? String ?? ""
        let IdPrev =  UserDefaults.standard.value(forKey:"IdPrev") as? Int ?? 0
        let LastName = UserDefaults.standard.value(forKey:"LastName") as? String ?? ""
        let userNamePrev = UserDefaults.standard.value(forKey:"userNamePrev") as? String ?? ""
        let passPrev = UserDefaults.standard.value(forKey:"passPrev") as? String ?? ""
        
        PasswordService.shared.setUsername(password: userNamePrev)
        PasswordService.shared.setPassword(password: passPrev)
        
        UserDefaults.standard.set(ModuleIdPrev, forKey: "ModuleId")
        UserDefaults.standard.set(ModuleNamePrev, forKey: "ModuleName")
        UserDefaults.standard.set(RoleIdPrev, forKey: "RoleId")
        UserDefaults.standard.set(nonUScountryIdPrev, forKey: "nonUScountryId")
        UserDefaults.standard.set(birdTypeIdPrev, forKey: "birdTypeId")
        UserDefaults.standard.set(switchBirdPrev, forKey: "switchBird")
        UserDefaults.standard.set(turkeyReportPrev, forKey: "turkeyReport")
        UserDefaults.standard.set(countryIdPrev, forKey: "countryId")
          
       
        keychainHelper.saveToKeychain(valued: "\(String(describing: aceesTokentypePrev))", keyed: "aceesTokentype")
      //  UserDefaults.standard.set(aceesTokentypePrev, forKey: "aceesTokentype")
    
        UserDefaults.standard.set(RolePrev, forKey: "Role")
        UserDefaults.standard.set(loginPrev, forKey: "login")
        UserDefaults.standard.set(FirstNamePrev, forKey: "FirstName")
        UserDefaults.standard.set(LastNamePrev, forKey: "LastName")
        UserDefaults.standard.set(LastName, forKey: "LastName")
        UserDefaults.standard.set(IdPrev, forKey: "Id")
        
    }
    // MARK: ******* Setup Header **********/
    private func setupHeader() {
        bottomViewController = BottomViewController()
        self.bottomView.addSubview(bottomViewController.view)
        self.topviewConstraint(vwTop: bottomViewController.view)
    }
    
    // MARK: ******* Select Complex **********/
    @IBAction func didSelectOnComplex(_ sender: AnyObject) {
        view.endEditing(true)
        tableViewpop()
    }
    
    // MARK: ************* Dropdown popup  ***************
    func tableViewpop() {
        
        if btnTag == 1
        {
            if countryArray.count == 0 {
                self.showToastWithTimer(message: "Failed to get Gigya Country list", duration: 3.0)
                return
            }
            
            self.dropDownVIewNew(arrayData: countryArray, kWidth: countryView.frame.width, kAnchor: countryView, yheight: countryView.bounds.height) { [unowned self] selectedVal, index  in
                self.lblCountry.text = selectedVal
                UserDefaults.standard.set(selectedVal, forKey: "Country")
                self.lblCountry.textColor = .black
                let countryID = countryId[index]
                let strCountryId = String(describing: countryID)
                self.langNameArray.removeAll()
                self.langIdArray.removeAll()
                self.langCultureArray.removeAll()
                self.fetchGigyaCountryLang(countryId: strCountryId)
                self.fetchGigyaApiKeys(countryId: strCountryId)
                self.lblLanguage.text = ""
                
            }
        }
        else
        {
            
            if countryArray.count == 0 {
                self.showToastWithTimer(message: "Failed to get Gigya Language list", duration: 3.0)
                return
            }
            self.dropDownVIewNew(arrayData: langNameArray, kWidth: languageView.frame.width, kAnchor: languageView, yheight: languageView.bounds.height) { [unowned self] selectedVal, index  in
                self.lblLanguage.text = selectedVal
                UserDefaults.standard.set(selectedVal, forKey: "Language")
                
                self.lblLanguage.textColor = .black
                if selectedVal == "English" {
                    UserDefaults.standard.set(1, forKey: "lngId")
                    LanguageUtility.setAppleLAnguageTo(lang: "en")
                    UserDefaults.standard.synchronize()
                } else {
                    UserDefaults.standard.set(3, forKey: "lngId")
                    LanguageUtility.setAppleLAnguageTo(lang: "fr")
                    UserDefaults.standard.synchronize()
                }
            }
            
        }
        self.dropHiddenAndShow()
        
    }
    
    // MARK: ************* Show Hide Drop down ***************
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    // MARK: ************* TableView delegates Method ***************
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTag == 1
        {
            return countryArray.count
        }else
        {
            return langNameArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if btnTag == 1
        {
            let country  = countryArray[indexPath.row]
            cell.textLabel!.text = country
        }else
        {
            let lang  = langNameArray[indexPath.row]
            cell.textLabel!.text = lang
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if btnTag == 1
        {
            let str = countryArray[indexPath.row]
            let id = countryId[indexPath.row]
            lblCountry.text = str
            
            lblCountry.textColor = .black
            lblLanguage.text = ""
            langNameArray.removeAll()
            langIdArray.removeAll()
            langCultureArray.removeAll()
        }else
        {
            let str = langNameArray[indexPath.row] as! String
            lblLanguage.textColor = .black
            lblLanguage.text = str
        }
        
        switch indexPath.row {
            
        case 0:
            UserDefaults.standard.set(1, forKey: "lngId")
            LanguageUtility.setAppleLAnguageTo(lang: "en")
            UserDefaults.standard.synchronize()
            
            break
        case 1:
            UserDefaults.standard.set(3, forKey: "lngId")
            LanguageUtility.setAppleLAnguageTo(lang: "fr")
            UserDefaults.standard.synchronize()
            
            break
            
        default:
            break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "newlogin") == true {
            if checkUserDataIsInDbOrNotPE(){
                navigateToPEDashboard()
            } else {
                callSelectionModule()
            }
        }else
        {
            
            if let value = UserDefaults.standard.object(forKey: "Country") {
                
                lblCountry.text = value as? String
                lblCountry.textColor = .black
                
            } else {
                lblCountry.text = "Select country"
                lblCountry.textColor = .lightGray
                
            }
            
            if let value = UserDefaults.standard.object(forKey: "Language") {
                
                lblLanguage.text = value as? String
                lblLanguage.textColor = .black
            } else {
                lblLanguage.text = "Select language"
                lblLanguage.textColor = .lightGray
            }
            
            self.fetchGigyaCountryList()
        }
    }
    
    // MARK: ************* Call Selection MOdule ***************
    func callDashBordView() {
        callSelectionModule()
    }
    
    // MARK: ************* Delete all Saved Data from DB ***************
    override func deleteAllData(_ entityName: String) {
        // Ensure this function runs on the main thread
        guard Thread.isMainThread else {
            DispatchQueue.main.sync {
                self.deleteAllData(entityName)
            }
            return
        }
        
        // Get the managed object context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Failed to get AppDelegate")
            return
        }
        let managedContext = appDelegate.managedObjectContext
        
        // Create a fetch request to delete all entities
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                if let object = managedObject as? NSManagedObject {
                    managedContext.delete(object)
                }
            }
            try managedContext.save() // Save changes to persist deletions
            //   debugPrint("Successfully deleted all data for entity: \(entityName)")
        } catch {
            print("Failed to fetch or delete data: \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func btnSignIn(_ sender: AnyObject) {
        
        // loginMethod()
        //ssologinMethod()
    }
    
    // MARK: ************* Call Selection MOdule ***************
    func callDashBoard() {
        UserDefaults.standard.set(true, forKey: "newlogin")
        callSelectionModule()
        
    }
    
    // MARK: ************* Call Global DashBoard MOdule ***************
    func callSelectionModule(){
        UserDefaults.standard.set(true, forKey: "newlogin")
        let vc = UIStoryboard.init(name: Constants.Storyboard.selection, bundle: Bundle.main).instantiateViewController(withIdentifier: "GlobalDashboardViewController") as? GlobalDashboardViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    
    
    func animateView (_ movement: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        })
    }
    
    
    // MARK: ZoetisWebServices to Call Get Api For Posting Session **************************************/

    func getPostingDataFromServer(){
        self.deleteAllData("PostingSession")
        if WebClass.sharedInstance.connected() {
            Helper.dismissGlobalHUD(self.view)
            _ = Helper.showGlobalProgressHUDWithTitle(self.view, title: "Logging in...Please Wait")
            let Id = UserDefaults.standard.value(forKey: "Id") as! Int
            let devType = Constants.deviceType
            let newUrl = ZoetisWebServices.EndPoint.getPostingSessionList.latestUrl + "\(Id)&DeviceType=\(devType)"
            
            ZoetisWebServices.shared.getPostedSessionResponceForChicken(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for item in arr {
                            // Pass the JSON item directly to the CoreDataHandler
                            CoreDataHandler().getPostingData((item.dictionaryObject as NSDictionary?)!)
                        }
                        
                        let postingData = CoreDataHandler().fetchAllPostingExistingSession()
                        
                        if postingData.count > 0 {
                            self.getPostingDataFromServerforVaccination()
                        } else {
                            self.getCNecStep1Data()
                        }
                    } else {
                        self.getPostingDataFromServerforVaccination()
                    }
                }
            })
            
        } else {
            self.alerViewInternet()
        }
    }
    
 
    // MARK: ***********ZoetisWebServices to Call Get Api For Feed Session  Implementation ************/
  
    func getPostingDataFromServerforFeed(){
        self.deleteAllData("AlternativeFeed")
        self.deleteAllData("AntiboticFeed")
        self.deleteAllData("CoccidiosisControlFeed")
        self.deleteAllData("MyCotoxinBindersFeed")
        
        if WebClass.sharedInstance.connected() {
            var id = Int()
            id = UserDefaults.standard.value(forKey: "Id") as! Int
            let devType = Constants.deviceType
            let newUrl = ZoetisWebServices.EndPoint.getFlockFeedList.latestUrl + "\(id)&DeviceType=\(devType)"
            ZoetisWebServices.shared.getFlockFeedSessionResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
          
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }
                
                   DispatchQueue.main.async {
                       let arr = json
                       // Iterate over the array of dictionaries
                       for posDict in arr {
                           let jsonData = posDict.1  // This accesses the JSON part of the tuple
                            
                            guard let sessionId = jsonData["sessionId"].int else { continue }
                            guard let feedDictArr = jsonData["Feeds"].array else { continue }

                           // Continue processing as before
                              for feedDict in feedDictArr {
                                  guard let feedId = feedDict["feedId"].int else { continue }
                                  let nsFeedId = UserDefaults.standard.integer(forKey: "feedId")

                                  if feedId > nsFeedId {
                                      UserDefaults.standard.set(feedId, forKey: "feedId")
                                  }

                                  let feedName = feedDict["feedName"].string ?? ""
                                  let startDate = feedDict["startDate"].string ?? ""

                                  CoreDataHandler().getFeedNameFromGetApi(sessionId as NSNumber, sessionId: sessionId as NSNumber, feedProgrameName: feedName, feedId: feedId as NSNumber, startDate: startDate)

                                  if let feedDetailArr = feedDict["feedCategoryDetails"].array {
                                      for feedDetail in feedDetailArr {
                                          guard let feedCatName = feedDetail["feedProgramCategory"].string else { continue }

                                          switch feedCatName {
                                          case "Coccidiosis Control":
                                              self.processFeedDetails(feedDetail.rawValue as! [String : Any], category: "Coccidiosis Control", feedId: feedId, sessionId: sessionId, feedName: feedName, startDate: startDate)
                                          case "Antibiotic":
                                              self.processFeedDetails(feedDetail.rawValue as! [String : Any], category: "Antibiotic", feedId: feedId, sessionId: sessionId, feedName: feedName, startDate: startDate)
                                          case "Alternatives":
                                              self.processFeedDetails(feedDetail.rawValue as! [String : Any], category: "Alternatives", feedId: feedId, sessionId: sessionId, feedName: feedName, startDate: startDate)
                                          case "Mycotoxin Binders":
                                              self.processFeedDetails(feedDetail.rawValue as! [String : Any], category: "Mycotoxin Binders", feedId: feedId, sessionId: sessionId, feedName: feedName, startDate: startDate)
                                          default:
                                              break
                                          }
                                      }
                                  }
                              }
                       }

                       self.getCNecStep1Data()
                   }
                     })

        } else{
            self.alerViewInternet()
        }
        
        
    }
    
    // Helper function to handle processing of different feed categories
    func processFeedDetails(_ feedDetail: [String: Any], category: String, feedId: Int, sessionId: Int, feedName: String, startDate: String) {
        if let feedDetails = feedDetail["feedDetails"] as? [[String: Any]] {
            for postDict in feedDetails {
                // Handle feed details based on category
                switch category {
                case "Coccidiosis Control":
                    CoreDataHandler().getDataFromCocoiiControll(postDict as NSDictionary, feedId: feedId as NSNumber, postingId: sessionId as NSNumber, feedProgramName: feedName, startDate: startDate)
                case "Antibiotic":
                    CoreDataHandler().getDataFromAntiboitic(postDict as NSDictionary, feedId: feedId as NSNumber, postingId: sessionId as NSNumber, feedProgramName: feedName, startDate: startDate)
                case "Alternatives":
                    CoreDataHandler().getDataFromAlterNative(postDict as NSDictionary, feedId: feedId as NSNumber, postingId: sessionId as NSNumber, feedProgramName: feedName, startDate: startDate)
                case "Mycotoxin Binders":
                    CoreDataHandler().getDataFromMyCocotinBinder(postDict as NSDictionary, feedId: feedId as NSNumber, postingId: sessionId as NSNumber, feedProgramName: feedName, startDate: startDate)
                default:
                    break
                }
            }
        }
    }
    
    // MARK: *********** ZoetisWebServices to  Get Necropsy data Acessing From Server **************/
    func getPostingDataFromServerforNecorpsy(){
        self.deleteAllData("CaptureNecropsyViewData")
        if WebClass.sharedInstance.connected() {
            
            var id = Int()
            id = UserDefaults.standard.value(forKey: "Id") as! Int
            let lngId = UserDefaults.standard.integer(forKey: "lngId")
            let countryId = UserDefaults.standard.integer(forKey: "countryId")
            
            let newUrl = ZoetisWebServices.EndPoint.getNecropsyListForChicken.latestUrl + "\(id)&LanguageId=\(lngId)&CountryId=\(countryId)"
            ZoetisWebServices.shared.getNecropsyListResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for item in arr {
                            guard
                                let sessionId = item["SessionId"].int,
                                let farms = item["Farms"].array
                            else {
                                continue
                            }

                            for farm in farms {
                                guard
                                    let farmName = farm["FarmName"].string,
                                    let categories = farm["Category"].array
                                else {
                                    continue
                                }

                                for category in categories {
                                    guard
                                        let categoryName = category["Category"].string,
                                        let observations = category["Observations"].array
                                    else {
                                        continue
                                    }

                                    for observation in observations {
                                        guard
                                            let obsId = observation["ObservationId"].int,
                                            let refId = observation["ReferenceId"].number,
                                            let languageId = observation["LanguageId"].number,
                                            let obsName = observation["Observations"].string,
                                            let measure = observation["Measure"].string,
                                            let quickLink = observation["DefaultQLink"].number,
                                            let birds = observation["Birds"].array,
                                            let birdData = birds.first
                                        else {
                                            continue
                                        }

                                        for m in 0..<10 {
                                            let keyStr = "BirdNumber\(m + 1)"
                                            if let birdValue = birdData[keyStr].string {
                                                if birdValue == "NA" {
                                                    break
                                                } else {
                                                    let categoryStr: String
                                                    switch categoryName {
                                                    case "Coccidiosis":
                                                        categoryStr = "Coccidiosis"
                                                    case "GI Tract":
                                                        categoryStr = "GITract"
                                                    case "Immune/Others":
                                                        categoryStr = "Immune"
                                                    case "Respiratory":
                                                        categoryStr = "Resp"
                                                    case "Skeletal/Muscular/Integumentary":
                                                        categoryStr = "skeltaMuscular"
                                                    default:
                                                        categoryStr = categoryName
                                                    }

                                                    CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCase(
                                                        catName: categoryStr,
                                                        obsName: obsName,
                                                        formName: farmName,
                                                        obsVisibility: birdData[keyStr].boolValue,
                                                        birdNo: NSNumber(value: m + 1),
                                                        obsPoint: birdData[keyStr].intValue,
                                                        index: m,
                                                        obsId: obsId,
                                                        measure: measure,
                                                        quickLink: NSNumber(value: quickLink.intValue),
                                                        necId: NSNumber(value: sessionId),
                                                        isSync: false,
                                                        lngId: languageId,
                                                        refId: refId,
                                                        actualText: birdValue
                                                    )
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.getNotesFromServer()
                    } else {
                        self.getNotesFromServer()
                    }
                }
            })
        } 
        else{
            self.alerViewInternet()
        }
        
    }
    
    // MARK: ************* ZoetisWebServices Calling to GetVaccination Data for Posted Session Data From Server  ***************************************/
    func getPostingDataFromServerforVaccination(){
        self.deleteAllData("HatcheryVac")
        self.deleteAllData("FieldVaccination")
        if WebClass.sharedInstance.connected() {
            let id =  UserDefaults.standard.value(forKey: "Id") as? Int ?? 0
            let devType = Constants.deviceType
            let newUrl = ZoetisWebServices.EndPoint.getSubmitedPostingVaccinationData.latestUrl + "\(id)&DeviceType=\(devType)"
            
            ZoetisWebServices.shared.getPostedSessionVaccinationResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
          
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                  //  self.alerView(statusCode:"")
                    return
                }
                
                if let jsonArray = JSON(json).array , !jsonArray.isEmpty  {
                    for item in jsonArray {
                        if let vaccinations = item["Vaccination"].array {
                            for vaccination in vaccinations {
                                let posDict = vaccination.dictionaryObject ?? [:]
                                for key in posDict.keys {
                                    if key.contains("hatchery") {
                                        CoreDataHandler().getHatcheryDataFromServer(posDict as NSDictionary)
                                    } else if key.contains("field") {
                                        CoreDataHandler().getFieldDataFromServer(posDict as NSDictionary)
                                    }
                                }
                            }
                        }
                    }
                    DispatchQueue.global(qos: .background).async {
                        self.getPostingDataFromServerforFeed()
                    }
                } else {
                    DispatchQueue.global(qos: .background).async {
                        self.getPostingDataFromServerforFeed()
                    }
                }
            })
        }
        else{
            self.alerViewInternet()
        }
    }
    
    
    // MARK: ****************************** ZoetisWebServices to Get Notes data from Server & Save  ******************************/
    func getNotesFromServer(){
        self.deleteAllData("NotesBird")
        if WebClass.sharedInstance.connected() {
            var id = Int()
            id =  UserDefaults.standard.integer(forKey: "Id")
            let devType = Constants.deviceType
            let newUrl = ZoetisWebServices.EndPoint.getSubmittedNotesForChicken.latestUrl + "\(id)&DeviceType=\(devType)"
            
            ZoetisWebServices.shared.getPostedSessionNotesResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    //  self.alerView(statusCode:"")
                    return
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for item in arr {
                            if let dict = item.dictionary {
                                let noteArr = dict["Note"]?.array ?? []
                                
                                if !noteArr.isEmpty { // Check if Note array is not empty
                                    for noteItem in noteArr {
                                        let sessionId = noteItem["sessionId"].int ?? 0
                                        let farmName = noteItem["farmName"].string ?? ""
                                        let birdNo = noteItem["birdNumber"].int ?? 0
                                        let birdNotes = noteItem["Notes"].string ?? ""
                                        
                                        CoreDataHandler().saveNoofBirdWithNotes(
                                            "",
                                            notes: birdNotes,
                                            formName: farmName,
                                            birdNo: birdNo as NSNumber,
                                            index: 0,
                                            necId: sessionId as NSNumber,
                                            isSync: false
                                        )
                                    }
                                }
                            }
                        }
                        self.getPostingDataFromServerforImage()
                    } else {
                        self.getPostingDataFromServerforImage()
                    }
                }
            })
        } else{
            self.alerViewInternet()
        }
    }
    
       // MARK: ZoetisWebServices Used to  Get Necropsy Data from Server
       func getCNecStep1Data(){
           self.deleteAllData("CaptureNecropsyData")
           if WebClass.sharedInstance.connected() {
               
               let userId = UserDefaults.standard.integer(forKey: "Id")
               let devType = Constants.deviceType
               let newUrl = ZoetisWebServices.EndPoint.getNecropsyFarmListForChicken.latestUrl + "\(userId)&DeviceType=\(devType)"
               
               ZoetisWebServices.shared.getPostedNecropsyFarmListResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                   guard let self = self else { return }
                   if let error = error {
                       print("Error fetching data: \(error.localizedDescription)")
                       //  self.alerView(statusCode:"")
                       return
                   }
                   DispatchQueue.main.async {
                       if let arr = JSON(json).array, !arr.isEmpty {
                           for item in arr {
                               let sessionId = item["SessionId"].intValue
                               let devSessionId = item["deviceSessionId"].stringValue
                               let lngId = item["LanguageId"].numberValue
                               let custId = item["CustomerId"].intValue
                               let complexId = item["ComplexId"].intValue
                               let complexName = item["ComplexName"].stringValue
                               let sessionDate = item["SessionDate"].stringValue
                               
                               let seesDat = self.convertDateFormater(sessionDate)
                               let farmArr = item["Farms"].arrayValue
                               
                               if !farmArr.isEmpty {
                                   for farmItem in farmArr {
                                       let farmName = farmItem["farmName"].stringValue
                                       let postingArr = CoreDataHandler().fetchAllPostingSession(sessionId as NSNumber)
                                       
                                       for postItem in postingArr {
                                           guard let posttingSes = postItem as? PostingSession else { continue }
                                           let vetId = posttingSes.veterinarianId
                                           
                                           if vetId == 0 {
                                               CoreDataHandler().updateFinalizeDataWithNec(sessionId as NSNumber, finalizeNec: 2)
                                           } else {
                                               CoreDataHandler().updateFinalizeDataWithNec(sessionId as NSNumber, finalizeNec: 1)
                                           }
                                       }

                                       let age = farmItem["age"].stringValue
                                       let birds = farmItem["birds"].stringValue
                                       let houseNo = farmItem["houseNo"].stringValue
                                       let flockId = farmItem["flockId"].stringValue
                                       let feedProgram = farmItem["feedProgram"].stringValue
                                       let sick = farmItem["sick"].boolValue
                                       let feedId = farmItem["FeedId"].intValue
                                       let farmId = farmItem["DeviceFarmId"].intValue
                                       let ImgId = farmItem["ImgId"].intValue

                                       CoreDataHandler().SaveNecropsystep1(sessionId as NSNumber,
                                           age: age,
                                           farmName: farmName,
                                           feedProgram: feedProgram,
                                           flockId: flockId,
                                           houseNo: houseNo,
                                           noOfBirds: birds,
                                           sick: sick as NSNumber,
                                           necId: sessionId as NSNumber,
                                           compexName: complexName,
                                           complexDate: seesDat,
                                           complexId: complexId as NSNumber,
                                           custmerId: custId as NSNumber,
                                           feedId: feedId as NSNumber,
                                           isSync: false,
                                           timeStamp: devSessionId,
                                           actualTimeStamp: devSessionId,
                                           lngId: lngId,
                                           farmId: farmId as NSNumber,
                                           imageId: ImgId as NSNumber,
                                           count: 0
                                       )
                                   }
                               }
                           }

                           let postingData = CoreDataHandler().fetchAllPostingExistingSession()
                           for pdOb in postingData {
                               guard let pdOB1 = pdOb as? PostingSession else { continue }
                               let step1data = CoreDataHandler().FetchNecropsystep1neccId(pdOB1.postingId ?? 0)
                               
                               if step1data.count < 1 {
                                   CoreDataHandler().updateFinalizeDataWithNecGetApi(pdOB1.postingId ?? 0, finalizeNec: 0)
                               }
                           }

                           let necArr = CoreDataHandler().FetchNecropsystep1AllNecId()
                           if necArr.count > 0 {
                               self.getPostingDataFromServerforNecorpsy()
                           }
                       }
                       else{
                           self.getPostingDataFromServerforNecorpsy()
                       }
                   }
                   
               })
               
           } else{
               self.alerViewInternet()
           }
           /************************************************************************************/
           
       }
    
    
    // MARK: ******************* ZoetisWebServices Get Posting Data from Server for Images
    func getPostingDataFromServerforImage(){
        let birdTypeId = UserDefaults.standard.integer(forKey: "birdTypeId")
        self.deleteAllData("BirdPhotoCapture")
        if WebClass.sharedInstance.connected() {
            
            let Id =  Constants.selectedIndex
            let DevType = Constants.deviceType
            let newUrl = ZoetisWebServices.EndPoint.getNecropsySubmittedImagesforChicken.latestUrl + "\(Id)&DeviceType=\(DevType)"
            
            ZoetisWebServices.shared.getNecropsyImagesListResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    //  self.alerView(statusCode:"")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for item in arr {
                            
                            guard let imagesArray = item["Images"].array, !imagesArray.isEmpty else {
                                continue
                            }
                            
                            for image in imagesArray {
                                if let imageDict = image.dictionaryObject as NSDictionary? {
                                    CoreDataHandler().getSaveImageFromServer(imageDict)
                                }
                            }
                        }
                        Helper.dismissGlobalHUD(self.view)
                        
                        if birdTypeId == 3{
                            self.getPostingDataFromServerTurkey()
                        }
                        else{
                            
                            if self.termsCond == 0 {
                                UserDefaults.standard.set(true, forKey: "login")
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "terms") as? Terms_ConditionViewController
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                                
                            } else {
                                UserDefaults.standard.set(true, forKey: "login")
                                self.callDashBordView()
                            }
                        }
                    }
                    else{
                        
                        Helper.dismissGlobalHUD(self.view)
                        if birdTypeId == 3{
                            self.getPostingDataFromServerTurkey()
                        }
                        else{
                            
                            if self.termsCond == 0{
                                UserDefaults.standard.set(true, forKey: "login")
                                UserDefaults.standard.set(true, forKey: "login")
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "terms") as? Terms_ConditionViewController
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                                
                            } else {
                                UserDefaults.standard.set(true, forKey: "login")
                                self.callDashBordView()
                            }
                        }
                    }
                }
            })
            
        } else{
            self.alerViewInternet()
        }
        
    }
 
    // MARK: Data Formatter
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        // New addition for below 2 line
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    // MARK: Alert View
    func alerView(statusCode: Int) {
        UserDefaults.standard.removeObject(forKey: "Id")
        self.deleteAllData("Login")
        let alertController = UIAlertController(title: "", message: "Unable to get data from server.\n(\(statusCode))", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            Helper.dismissGlobalHUD(self.view)
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: Internet Alert View
    func alerViewInternet() {
        UserDefaults.standard.removeObject(forKey: "Id")
        self.deleteAllData("Login")
        let alertController = UIAlertController(title: "", message: "No internet connection. Please try again!", preferredStyle: UIAlertController.Style.alert) //Replace
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            Helper.dismissGlobalHUD(self.view)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK:  *************************  TURKEY Modules  Methods *************************
    
    // MARK:  Get Posting Data From Server For Turkey
    func getPostingDataFromServerTurkey() {
        if WebClass.sharedInstance.connected() {
            Helper.dismissGlobalHUD(self.view)
            _ = Helper.showGlobalProgressHUDWithTitle(self.view, title: "Logging in...Please Wait")
            let Id = UserDefaults.standard.value(forKey: "Id") as! Int
            let newUrl = ZoetisWebServices.EndPoint.getTurkeyPostedSession.latestUrl + "\(Id)&DeviceType=\(Constants.deviceType)"
            ZoetisWebServices.shared.getTurkeyPostedSessionsListResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let statusCode = errorResult["errorCode"]?.int ?? 0
                    
                    print("Error from PostingSession/GetBirdNotesListBySessionId?DeviceSessionId  API : \(errorMsg) (Code: \(statusCode))")
                    
                    if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode)
                    }
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Use a single CoreDataHandler instance
                        let coreDataHandler = CoreDataHandlerTurkey()
                        
                        // Loop through and process each item in the array
                        for posDict in arr {
                            if let dict = posDict.dictionaryObject {
                                coreDataHandler.getPostingDataTurkey(dict as NSDictionary)
                            }
                        }
                        
                        // Fetch posting data only once after processing
                        let postingData = coreDataHandler.fetchAllPostingExistingSessionTurkey()
                        
                        // Check if postingData exists
                        if postingData.count>0 {
                            self.getPostingDataFromServerforVaccinationTurkey()
                        } else {
                            // Handle case where postingData is empty if necessary
                            // Maybe log a message or show an alert
                        }
                    } else {
                        // Handle case where arr is empty or nil
                        self.getPostingDataFromServerforVaccinationTurkey()
                    }
                }

            })
        } else {
            self.alerViewInternet()
        }
        
    }
    
    // MARK:  Get Necropsy Data From Server For Turkey **************************************************************************************/
    func getCNecStep1DataTurkey() {
        self.deleteAllData("CaptureNecropsyDataTurkey")
        if WebClass.sharedInstance.connected() {
            
            let userId = UserDefaults.standard.integer(forKey: "Id")

            let newUrl = ZoetisWebServices.EndPoint.getTukeyPostedFarmList.latestUrl + "\(userId)&DeviceType=\(Constants.deviceType)"
            
            ZoetisWebServices.shared.getTukeyPostedFarmListResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    //  self.alerView(statusCode:"")
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let statusCode = errorResult["errorCode"]?.int ?? 0
                    
                    print("Error from PostingSession/GetBirdNotesListBySessionId?DeviceSessionId  API : \(errorMsg) (Code: \(statusCode))")
                    
                    if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode)
                    }
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for i in 0..<arr.count {
                            // Safely extract dictionary from JSON element
                            guard let sessionDict = arr[i].dictionaryObject else { continue }
                            
                            // Safely unwrap values from sessionDict
                            guard let sessionId = sessionDict["SessionId"] as? Int,
                                  let devSessionId = sessionDict["deviceSessionId"] as? String,
                                  let lngId = sessionDict["LanguageId"] as? NSNumber,
                                  let custId = sessionDict["CustomerId"] as? Int,
                                  let complexId = sessionDict["ComplexId"] as? Int,
                                  let complexName = sessionDict["ComplexName"] as? String,
                                  let sessionDate = sessionDict["SessionDate"] as? String else {
                                continue // Skip this iteration if any of the required values are missing
                            }

                            let seesDat = self.convertDateFormater(sessionDate)

                            // Safely extract farm array
                            guard let farmArr = sessionDict["Farms"] as? [[String: Any]], farmArr.count > 0 else { continue }

                            for farmDict in farmArr {
                                // Safely unwrap farm-related values
                                guard let farmName = farmDict["farmName"] as? String else { continue }

                                let postingArr = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(sessionId as NSNumber)
                                for posttingSes in postingArr {
                                    guard let postSes = posttingSes as? PostingSessionTurkey else { continue }
                                    let vetId = postSes.veterinarianId
                                    
                                    if vetId == 0 {
                                        CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey((sessionId as NSNumber), finalizeNec: 2)
                                        
                                    } else {
                                        CoreDataHandlerTurkey().updateFinalizeDataWithNecTurkey((sessionId as NSNumber), finalizeNec: 1)
                                    }
                                }

                                // Safely unwrap all farm-related values
                                guard let age = farmDict["age"] as? Int,
                                      let birds = farmDict["birds"] as? Int,
                                      let houseNo = farmDict["houseNo"] as? String,
                                      let flockId = farmDict["flockId"] as? String,
                                      let feedProgram = farmDict["feedProgram"] as? String,
                                      let sick = farmDict["sick"] as? Bool,
                                      let feedId = farmDict["FeedId"] as? Int,
                                      let farmId = farmDict["DeviceFarmId"] as? Int,
                                      let imgId = farmDict["ImgId"] as? Int,
                                      let farmWeight = farmDict["Farm_Weight"] as? String,
                                      let abf = farmDict["ABF"] as? String,
                                      let breed = farmDict["Breed"] as? String,
                                      let sex = farmDict["Sex"] as? String,
                                      let nameGen = farmDict["GenerationName"] as? String,
                                      let idGen = farmDict["GenerationId"] as? Int else {
                                    continue // Skip if any farm-related value is missing
                                }

                                CoreDataHandlerTurkey().SaveNecropsystep1Turkey(
                                    sessionId as NSNumber, age: String(age), farmName: farmName, feedProgram: feedProgram, flockId: flockId,
                                    houseNo: houseNo, noOfBirds: String(birds), sick: sick as NSNumber, necId: sessionId as NSNumber,
                                    compexName: complexName, complexDate: seesDat, complexId: complexId as NSNumber,
                                    custmerId: custId as NSNumber, feedId: feedId as NSNumber, isSync: false, timeStamp: devSessionId,
                                    actualTimeStamp: devSessionId, lngId: lngId, farmWeight: String(farmWeight), abf: abf, breed: breed,
                                    sex: sex, farmId: farmId as NSNumber, imageId: imgId as NSNumber, count: 0, genName: nameGen,
                                    genId: idGen as NSNumber
                                )
                            }
                        }

                        // Handle finalization and move to the next step
                        let postingData = CoreDataHandlerTurkey().fetchAllPostingExistingSessionTurkey()
                        for pdOb in postingData {
                            if let pdOB1 = pdOb as? PostingSessionTurkey {
                                let step1data = CoreDataHandlerTurkey().FetchNecropsystep1neccIdTurkey(pdOB1.postingId!)
                                if step1data.count < 1 {
                                    CoreDataHandlerTurkey().updateFinalizeDataWithNecGetApiTurkey(pdOB1.postingId!, finalizeNec: 0)
                                }
                            }
                        }

                        // If nec data is available, proceed
                        let necArr = CoreDataHandlerTurkey().FetchNecropsystep1AllNecIdTurkey()
                        if necArr.count > 0 {
                            self.getPostingDataFromServerforNecorpsyTurkey()
                        }
                    } else {
                        self.getPostingDataFromServerforNecorpsyTurkey()
                    }
                }
            })
      } else {
            
        }
        /************************************************************************************/
        
    }
    
    // MARK: *************Get Posting data From Server for Necropsy ***************************************/
    func getPostingDataFromServerforNecorpsyTurkey() {
        self.deleteAllData("CaptureNecropsyViewDataTurkey")
        if WebClass.sharedInstance.connected() {
            
            var id = Int()
            id = UserDefaults.standard.value(forKey: "Id") as! Int
            let lngId = UserDefaults.standard.integer(forKey: "lngId")
            let countryId = UserDefaults.standard.integer(forKey: "countryId")
            let url = "PostingSession/T_GetNecropsyListByUser?UserId=\(id)&LanguageId=\(lngId)&CountryId=\(countryId)"
            accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
                                                        //(UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict: HTTPHeaders = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + url
            sessionManager.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                    self.alerView(statusCode: statusCode!)
                    
                }
                switch response.result {
                case let .success(value):
                    
                    DispatchQueue.main.async {
                        if value != nil {
                                                        
                            if value is NSArray {
                                
                                let arr: NSArray = value as! NSArray
                                
                                if arr.count>0 {
                                    
                                    for  i in 0..<arr.count {
                                        let seesionId = (arr.object(at: i) as AnyObject).value(forKey: "SessionId") as! Int
                                        let farmArr = (arr.object(at: i) as AnyObject).value( forKey: "Farms")
                                        for  j in 0..<(farmArr! as AnyObject).count {
                                            let farmName = ((farmArr! as AnyObject).object(at: j) as AnyObject).value( forKey: "FarmName") as! String
                                            let catArr = ((farmArr! as AnyObject).object(at: j) as AnyObject).value(forKey: "Category")
                                            for  k in 0..<(catArr! as AnyObject).count {
                                                let catName = ((catArr! as AnyObject).object(at: k) as AnyObject).value(forKey: "Category") as! String
                                                let ObArr = ((catArr! as AnyObject).object(at: k) as AnyObject).value(forKey: "Observations")
                                                for  l in 0..<(ObArr! as AnyObject).count {
                                                    let obsId  = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "ObservationId") as! Int
                                                    let refId = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "ReferenceId") as! NSNumber
                                                    let languageId = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "LanguageId") as! NSNumber
                                                    let obsName = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Observations") as! String
                                                    let measure = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Measure") as! String
                                                    let quickLink = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "DefaultQLink")
                                                    //
                                                    let birdArr = (((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Birds") as AnyObject).object(at: 0)
                                                    for  m in 0..<10 {
                                                        
                                                        let keyStr = NSString(format: "BirdNumber%d", m+1)
                                                        let chkKey = ((birdArr as AnyObject).value(forKey: keyStr as String) as AnyObject).boolValue
                                                        let chkKey1 = ((birdArr as AnyObject).value(forKey: keyStr as String) as AnyObject).integerValue
                                                        let chkKey3 = (birdArr as AnyObject).value(forKey: keyStr as String) as! String
                                                        if chkKey3 == "NA"{
                                                            break
                                                        } else {
                                                            
                                                            var catstr = String()
                                                            
                                                            if catName == "Microscopy"{
                                                                catstr = "Coccidiosis"
                                                            } else if catName == "GI Tract" {
                                                                catstr = "GITract"
                                                            } else if catName == "Immune/Others" {
                                                                catstr = "Immune"
                                                            } else if catName == "Respiratory" {
                                                                catstr = "Resp"
                                                            } else if catName == "Skeletal/Muscular/Integumentary" {
                                                                catstr = "skeltaMuscular"
                                                            }
                                                            CoreDataHandlerTurkey().saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: catstr, obsName: obsName, formName: farmName, obsVisibility: chkKey!, birdNo: (m+1) as NSNumber, obsPoint: chkKey1!, index: m, obsId: obsId, measure: measure, quickLink: (quickLink! as AnyObject).integerValue! as NSNumber, necId: seesionId as NSNumber, isSync: false, lngId: languageId, refId: refId, actualText: chkKey3)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    
                                    self.getNotesFromServerTurkey()
                                } else {
                                    self.getNotesFromServerTurkey()
                                }
                            } else {
                                self.getNotesFromServerTurkey()
                                
                                
                            }
                        }
                    }
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        
                        self.alerViewInternet()
                        debugPrint(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        debugPrint(encodingError)
                        debugPrint(responseString)
                        self.alerViewInternet()
                        
                    }
                }
            }
            
        } else {
            
        }
        
    }
    
    // MARK: ************* Get Posting Data from Server for Vaccination ***************************************/
    func getPostingDataFromServerforVaccinationTurkey() {
        self.deleteAllData("HatcheryVacTurkey")
        self.deleteAllData("FieldVaccinationTurkey")
        if WebClass.sharedInstance.connected() {
            let id = UserDefaults.standard.value(forKey: "Id") as! Int
            let newUrl = ZoetisWebServices.EndPoint.getTurkeyPostedSessionsVacccine.latestUrl + "\(id)&DeviceType=\(Constants.deviceType)"
            ZoetisWebServices.shared.getTurkeyPostedSessionsVacccineResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let statusCode = errorResult["errorCode"]?.int ?? 0
                    
                    print("Error from PostingSession/GetBirdNotesListBySessionId?DeviceSessionId  API : \(errorMsg) (Code: \(statusCode))")
                    
                    if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode)
                    }
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for vacData in arr {
                            // Safely unwrap "Vaccination"
                            if let vac = vacData["Vaccination"].array {
                                for posDict in vac {
                                    let str = "hatchery"
                                    
                                    // Convert posDict to dictionary to access keys
                                    if let posDictDict = posDict.dictionaryObject {
                                        // Safely unwrap all keys
                                        let allKeyArr = Array(posDictDict.keys)
                                        
                                        for keys in allKeyArr {
                                            if keys.range(of: str) != nil {
                                                CoreDataHandlerTurkey().getHatcheryDataFromServerTurkey(posDictDict as NSDictionary)
                                            } else {
                                                CoreDataHandlerTurkey().getFieldDataFromServerTurkey(posDictDict as NSDictionary)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        // Fetch data from server after processing
                        self.getPostingDataFromServerforFeedTurkey()
                    } else {
                        // Handle the case where the array is empty
                        self.getPostingDataFromServerforFeedTurkey()
                    }
                }

            })
  
        } else {
            self.alerViewInternet()
        }
    }
    
    // MARK:  ********** Call Get Api For Feed Session  TURKEY **************************************/
    func getPostingDataFromServerforFeedTurkey() {
        self.deleteAllData("AlternativeFeedTurkey")
        self.deleteAllData("AntiboticFeedTurkey")
        self.deleteAllData("CoccidiosisControlFeedTurkey")
        self.deleteAllData("MyCotoxinBindersFeedTurkey")
        if WebClass.sharedInstance.connected() {
            
            var id = Int()
            
            id = UserDefaults.standard.value(forKey: "Id") as! Int
            accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
           // accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict: HTTPHeaders = ["Authorization":accestoken]
            let dev = "iOS"
            let url = "PostingSession/T_GetFeedListByUser?UserId=\(id)&DeviceType=\(dev)"
            let urlString: String = WebClass.sharedInstance.webUrl + url
            
            sessionManager.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                
                let statusCode =  response.response?.statusCode
                if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.alerView(statusCode:statusCode!)
                    
                }
                switch response.result{
                case let .success(value):
                    DispatchQueue.main.async {
                        
                        
                        if value != nil {
                            if value is NSArray{
                                let arr : NSArray = value as! NSArray
                                
                                if arr.count>0{
                                    
                                    for  t in 0..<arr.count {
                                        
                                        let posDict = arr.object(at: t)
                                        let seesionId = (posDict as AnyObject).value(forKey: "sessionId") as! Int
                                        let feedDictArr = (posDict as AnyObject).value(forKey: "Feeds")
                                        
                                        
                                        for  i in 0..<(feedDictArr! as AnyObject).count {
                                            var feedId = ((feedDictArr as AnyObject).object(at: i) as AnyObject).value(forKey: "feedId") as! Int
                                            let nsFeedid = UserDefaults.standard.integer(forKey: "feedId")
                                            if feedId > nsFeedid{
                                                UserDefaults.standard.set(feedId, forKey: "feedId")
                                            }
                                            let feedName = ((feedDictArr as AnyObject).object(at: i) as AnyObject).value(forKey:"feedName")
                                            let startDate  = ((feedDictArr as AnyObject).object(at: i) as AnyObject).value(forKey:"startDate")
                                            DispatchQueue.main.async {
                                                
                                                CoreDataHandlerTurkey().getFeedNameFromGetApiTurkey((seesionId) as NSNumber, sessionId: seesionId as NSNumber, feedProgrameName: feedName as! String, feedId: feedId as NSNumber,startDate:startDate as? String ?? "")
                                            }
                                            let feedDetailArr = ((feedDictArr! as AnyObject).object(at: i) as AnyObject).value(forKey: "feedCategoryDetails")
                                            
                                            
                                            for  j in 0..<(feedDetailArr! as AnyObject).count{
                                                let feedCatName = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedProgramCategory") as! String
                                                
                                                if feedCatName == "Coccidiosis Control"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  m in 0..<(feedDetail! as AnyObject).count{
                                                        let postDict = (feedDetail as AnyObject).object(at: m)
                                                        
                                                        CoreDataHandlerTurkey().getDataFromCocoiiControllTurkey(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName: feedName as! String,startDate: startDate as? String ?? "")
                                                    }
                                                }
                                                
                                                else if  feedCatName == "Antibiotic"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey:"feedDetails")
                                                    for  a in 0..<(feedDetail! as AnyObject).count{
                                                        let postDict = (feedDetail as AnyObject).object(at: a)
                                                        CoreDataHandlerTurkey().getDataFromAntiboiticTurkey(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName:feedName as! String,startDate:startDate as? String ?? "" )
                                                    }
                                                }
                                                else if feedCatName  == "Alternatives"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  p in 0..<(feedDetail! as AnyObject).count{
                                                        let postDict = (feedDetail as AnyObject).object(at: p)
                                                        CoreDataHandlerTurkey().getDataFromAlterNativeTurkey(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName:feedName as! String,startDate:startDate as? String ?? "" )
                                                    }
                                                }
                                                else if  feedCatName  == "Mycotoxin Binders"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  y in 0..<(feedDetail! as AnyObject).count{
                                                        let postDict = (feedDetail as AnyObject).object(at: y)
                                                        CoreDataHandlerTurkey().getDataFromMyCocotinBinderTurkey(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName:feedName as! String,startDate:startDate as? String ?? "")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    self.getCNecStep1DataTurkey()
                                }
                                else{
                                    self.getCNecStep1DataTurkey()
                                }
                            }
                            
                            else {
                                self.getCNecStep1DataTurkey()
                            }
                        }
                    }
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        
                        self.alerViewInternet()
                        debugPrint(err)
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        debugPrint (encodingError)
                        debugPrint (responseString)
                        self.alerViewInternet()
                        
                    }
                }
            }
        } else{
            
        }
    }
    // MARK: Get Posting Data from Server for Images Turkey
    func getPostingDataFromServerforImageTurkey(){
        self.deleteAllData("BirdPhotoCaptureTurkey")
        if WebClass.sharedInstance.connected() {
            var id = Int()
            id = UserDefaults.standard.value(forKey: "Id") as! Int
            let newUrl = ZoetisWebServices.EndPoint.getTurkeyPostedImages.latestUrl + "\(id)&DeviceType=\(Constants.deviceType)"
            
            ZoetisWebServices.shared.getTurkeyPostedImagesResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let statusCode = errorResult["errorCode"]?.int ?? 0
                    
                    print("Error from PostingSession/GetBirdNotesListBySessionId?DeviceSessionId  API : \(errorMsg) (Code: \(statusCode))")
                    
                    if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode)
                    }
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for vacData in arr {
                            if let imagArr = vacData["Images"].array, !imagArr.isEmpty {
                                for imageData in imagArr {
                                    // Safely unwrap dictionaryObject and cast to NSDictionary
                                    if let imageDict = imageData.dictionaryObject {
                                        CoreDataHandlerTurkey().getSaveImageFromServerTurkey(imageDict as NSDictionary)
                                    }
                                }
                            }
                        }
                        
                        // Dismiss loading HUD
                        Helper.dismissGlobalHUD(self.view)
                        
                        // Handle terms and conditions flow
                        if self.termsCond == 0 {
                            UserDefaults.standard.set(true, forKey: "login")
                            if let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "terms") as? Terms_ConditionViewController {
                                self.navigationController?.pushViewController(mapViewControllerObj, animated: false)
                            }
                        } else {
                            UserDefaults.standard.set(true, forKey: "login")
                            self.callDashBordView()
                        }
                        
                    } else {
                        // If arr is empty or nil
                        Helper.dismissGlobalHUD(self.view)
                        
                        if self.termsCond == 0 {
                            UserDefaults.standard.set(true, forKey: "login")
                            if let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "terms") as? Terms_ConditionViewController {
                                self.navigationController?.pushViewController(mapViewControllerObj, animated: false)
                            }
                        } else {
                            UserDefaults.standard.set(true, forKey: "login")
                            self.callDashBordView()
                        }
                    }
                }
            })
          
        } else{
            self.alerViewInternet()
        }
    }
    
    // MARK:  ****************************** Get Notes from Server & Save ******************************/
    func getNotesFromServerTurkey() {
        self.deleteAllData("NotesBirdTurkey")
        if WebClass.sharedInstance.connected() {
            var id = Int()
            id =  UserDefaults.standard.integer(forKey: "Id")
            let dev = "iOS"
            let url = "PostingSession/T_GetBirdNotesListByUser?UserId=\(id)&DeviceType=\(dev)"
            accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
          //  accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict: HTTPHeaders = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + url
            
            let newUrl = ZoetisWebServices.EndPoint.getTurkeyPostedNotes.latestUrl + "\(id)&DeviceType=\(Constants.deviceType)"
            ZoetisWebServices.shared.getTurkeyPostedNotesResponce(controller: self, url: newUrl, completion: { [weak self] (json, error) in
                guard let self = self else { return }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let statusCode = errorResult["errorCode"]?.int ?? 0
                    
                    print("Error from PostingSession/GetBirdNotesListBySessionId?DeviceSessionId  API : \(errorMsg) (Code: \(statusCode))")
                    
                    if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode)
                    }
                }
                
                DispatchQueue.main.async {
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for vacData in arr {
                            if let noteArr = vacData["Note"].array, !noteArr.isEmpty {
                                for note in noteArr {
                                    // Safely unwrap each value
                                    if let sessionId = note["sessionId"].int,
                                       let farmName = note["farmName"].string,
                                       let birdNo = note["birdNumber"].int,
                                       let birdNotes = note["Notes"].string {
                                        
                                        // Save data using CoreDataHandlerTurkey
                                        CoreDataHandlerTurkey().saveNoofBirdWithNotesTurkey(
                                            "",
                                            notes: birdNotes,
                                            formName: farmName,
                                            birdNo: NSNumber(value: birdNo),
                                            index: 0,
                                            necId: NSNumber(value: sessionId),
                                            isSync: false
                                        )
                                    }
                                }
                            }
                        }
                        // Fetch posting data after processing
                        self.getPostingDataFromServerforImageTurkey()
                    } else {
                        // Handle the case where array is empty or nil
                        self.getPostingDataFromServerforImageTurkey()
                    }
                }

            })

        } else {
            
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
// MARK:  Side Pannel Delegates Method
extension ViewController:SidePanelViewControllerDelegate {
    
    func didSelectLeftPenal(_ selectedRow: Int, selectedDetails: [String : String]) {
        
        let userType =   UserDefaults.standard.string(forKey:"userType")
        self.navigationItem.setHidesBackButton(true, animated: true)
        if userType == "PE" {
            if selectedRow == 0 {
                self.navigationController?.popToViewController(ofClass: HatcherySelectionViewController.self)
                delegate?.collapseSidePanels?()
                return
            }
            else if selectedRow == 1 {
                Constants.isDashboard = true
                Constants.isDataLoaded = true
                UserDefaults.standard.set(true, forKey: "PEDashboard")
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboard"),object: nil))
                self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
                delegate?.collapseSidePanels?()
                return
            }
            
            else if selectedRow == 2 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "MoveToViewAssessment"),object: nil))
                delegate?.collapseSidePanels?()
                return
            }
            else if selectedRow == 3 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "NavigateToScheduledAssesments"),object: nil))
                delegate?.collapseSidePanels?()
                return
            }
            else if selectedRow == 4 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "MoveToOpenPlacards"),object: nil))
                delegate?.collapseSidePanels?()
                return
            }
            
            else if selectedRow == 1 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboard"),object: nil))
                self.navigationController?.popToViewController(ofClass: PEDashboardViewController.self)
                delegate?.collapseSidePanels?()
                return
            }
            else if selectedRow == 5 {
                logoutBtnAction()
            }
            
            else if selectedRow == 7 {
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "MoveToOpenPlacards"),object: nil))
            }
        }
        
        else  if userType == "PVE" {
            if selectedRow == 0 {
                self.navigationController?.popToViewController(ofClass: PulletSelectionViewController.self)
                delegate?.collapseSidePanels?()
                return
            }
            if selectedRow == 3{
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: PVESessionViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        delegate?.collapseSidePanels?()
                        return
                    }
                }
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: PVESessionViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                    }
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "PVEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PVESessionViewController") as! PVESessionViewController
                navigationController?.pushViewController(vc, animated: false) //navigationController?.popViewController(animated: true)
            }
            if selectedRow == 1 {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: PVEDashboardViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                    }
                }
            }
            if selectedRow == 2 {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: PVEStartNewAssessment.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        delegate?.collapseSidePanels?()
                        return
                    }
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "PVEStoryboard", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PVEStartNewAssessment") as! PVEStartNewAssessment
                navigationController?.pushViewController(vc, animated: false)
            }
            if selectedRow == 5 {
                logoutBtnAction()
            }
            delegate?.collapseSidePanels?()
        }
        
        
        //************************** Is Microbial *****************************
        
        else  if userType == "Microbial" {//
            
            if selectedRow == 0 {
                self.navigationController?.popToViewController(ofClass: HatcherySelectionViewController.self)
                delegate?.collapseSidePanels?()
                return
            }
            
            if selectedRow == 1 {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: MicrobialViewController.self) {
                        (controller as? MicrobialViewController)?.isNewRquisitionSelected = false
                        self.navigationController!.popToViewController(controller, animated: true)
                        delegate?.collapseSidePanels?()
                        return
                    }
                }
            }
            
            if selectedRow == 2 {
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: MicrobialViewController.self) {
                        if self.navigationController?.viewControllers.last == controller{
                            NotificationCenter.default.post(name: Notification.Name("openStartRequisition"), object: nil, userInfo: [:])
                        }else{
                            (controller as? MicrobialViewController)?.isNewRquisitionSelected = true
                            self.navigationController!.popToViewController(controller, animated: true)
                        }
                        delegate?.collapseSidePanels?()
                        return
                    }
                }
            }
            
            if selectedRow == 3 {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ViewRequisitionViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        delegate?.collapseSidePanels?()
                        return
                    }
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "ViewRequisition", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewRequisitionViewController") as! ViewRequisitionViewController
                navigationController?.pushViewController(vc, animated: false)
            }
            
            if selectedRow == 5 {
                logoutBtnAction()
            }
        }
        else if userType == "FlockHealth"{
            switch selectedRow {
            case 0:
                self.navigationController?.popToViewController(ofClass: GrownoutSelectionViewController.self)
                delegate?.collapseSidePanels?()
                return
            case 1:
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
                navigationController?.pushViewController(vc, animated: false)
                
                
            case 2:
                
                UserDefaults.standard.set(0, forKey: "postingId")
                UserDefaults.standard.set(0, forKey: "necUnLinked")
                
                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                UserDefaults.standard.set(false, forKey: "Unlinked")
                UserDefaults.standard.set(true, forKey: "nec")
                UserDefaults.standard.set(false, forKey: "backFromStep1")
                let val = UserDefaults.standard.integer(forKey: "chick")
                if val  ==  4  {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "DashView_Controller") as! DashViewController
                    navigationController?.pushViewController(vc, animated: false)
                    
                } else {
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "DashViewControllerTurkey") as! DashViewControllerTurkey
                    navigationController?.pushViewController(vc, animated: false)
                }
                
            case 3:
                if UserDefaults.standard.integer(forKey: "Role") == 1 {
                    
                    UserDefaults.standard.set(false, forKey: "Unlinked")
                    UserDefaults.standard.set(true, forKey: "nec")
                    UserDefaults.standard.set(false, forKey: "backFromStep1")
                    UserDefaults.standard.set(0, forKey: "postingId")
                    UserDefaults.standard.set(0, forKey: "necUnLinked")
                    UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                    UserDefaults.standard.removeObject(forKey: "count")
                    UserDefaults.standard.set(0, forKey: "postingId")
                    UserDefaults.standard.set(1, forKey: "sessionId")
                    UserDefaults.standard.set(0, forKey: "isBackWithoutFedd")
                    appDelegate.sendFeedVariable = ""
                    let val = UserDefaults.standard.integer(forKey: "chick")
                    if val  ==  4 {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
                        
                    } else {
                        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierTurkey"), object: nil)
                    }
                }
            case 4:
                
                if UserDefaults.standard.integer(forKey: "Role") == 1{
                    
                    UserDefaults.standard.set(0, forKey: "postingId")
                    UserDefaults.standard.set(0, forKey: "necUnLinked")
                    UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                    
                    UserDefaults.standard.set(false, forKey: "Unlinked")
                    UserDefaults.standard.set(true, forKey: "nec")
                    UserDefaults.standard.set(false, forKey: "backFromStep1")
                    let val = UserDefaults.standard.integer(forKey: "chick")
                    if val ==  4  {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "Existing") as! ExistingPostingSessionViewController
                        navigationController?.pushViewController(vc, animated: false)
                        
                    } else {
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "ExistingTurkey") as! ExistingPostingSessionTurkey
                        navigationController?.pushViewController(vc, animated: false)
                    }
                }
            case 5:
                
                UserDefaults.standard.set(0, forKey: "postingId")
                UserDefaults.standard.set(0, forKey: "necUnLinked")
                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "TrainingNew") as! TrainingViewController
                navigationController?.pushViewController(vc, animated: false)
                
                
            case 6:
                
                if UserDefaults.standard.integer(forKey: "Role") == 1 {
                    UserDefaults.standard.set(0, forKey: "postingId")
                    UserDefaults.standard.set(0, forKey: "necUnLinked")
                    UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                    
                    UserDefaults.standard.set(false, forKey: "Unlinked")
                    UserDefaults.standard.set(true, forKey: "nec")
                    UserDefaults.standard.set(false, forKey: "backFromStep1")
                    let val = UserDefaults.standard.integer(forKey: "chick")
                    if val  ==  4 {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "Report") as! Report_MainVCViewController
                        navigationController?.pushViewController(vc, animated: false)
                        
                    } else {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "ReportTurkey") as! ReportDashboardTurkey
                        navigationController?.pushViewController(vc, animated: false)
                    }
                }
                
            case 7:
                
                UserDefaults.standard.set(0, forKey: "postingId")
                UserDefaults.standard.set(0, forKey: "necUnLinked")
                
                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                UserDefaults.standard.set(false, forKey: "Unlinked")
                UserDefaults.standard.set(true, forKey: "nec")
                UserDefaults.standard.set(false, forKey: "backFromStep1")
                let val = UserDefaults.standard.integer(forKey: "chick")
                if val  ==  4 {
                    let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "helpView") as? HelpViewController
                    self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                } else {
                    
                    let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "HelpScreenVcTurkey") as? HelpScreenVcTurkey
                    self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                }
                
            case 8:
                
                if UserDefaults.standard.integer(forKey: "Role") == 1 {
                    UserDefaults.standard.set(0, forKey: "postingId")
                    UserDefaults.standard.set(0, forKey: "necUnLinked")
                    
                    UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                    UserDefaults.standard.set(false, forKey: "Unlinked")
                    UserDefaults.standard.set(true, forKey: "nec")
                    UserDefaults.standard.set(false, forKey: "backFromStep1")
                    
                    let val = UserDefaults.standard.integer(forKey: "chick")
                    if val  ==  4 {
                        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "setting") as? SettingsViewController
                        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                    }
                    else{
                        
                        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "settingTurkey") as? SettingControllerTurkey
                        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                    }
                }
                
            default:
                let birdTypeId = UserDefaults.standard.integer(forKey: "switchBird")
                let vlue = UserDefaults.standard.bool(forKey: "turkey")
                let vlue1 = UserDefaults.standard.bool(forKey: "Chicken")
                
                if birdTypeId ==  3 {
                    if ConnectionManager.shared.hasConnectivity() {
                        
                        UserDefaults.standard.set(0, forKey: "postingId")
                        UserDefaults.standard.set(0, forKey: "necUnLinked")
                        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                        UserDefaults.standard.set(false, forKey: "Unlinked")
                        UserDefaults.standard.set(true, forKey: "nec")
                        UserDefaults.standard.set(false, forKey: "backFromStep1")
                        if vlue == true{
                            objApiSyncTurkey.delegeteSyncApiTurkey = self
                            if self.allSessionArrTurkey().count > 0 {
                                if WebClass.sharedInstance.connected() == true{
                                    Helper.showGlobalProgressHUDWithTitle(UIApplication.shared.keyWindow!, title: NSLocalizedString("Data syncing...", comment: ""))
                                    self.callSyncApiTurkey()
                                } else {
                                    Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
                                }
                            } else {
                                
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                                
                            }
                        }
                        else if vlue1 == true{
                            objApiSync.delegeteSyncApi = self
                            if self.allSessionArr().count > 0 {
                                if WebClass.sharedInstance.connected() == true{
                                    Helper.showGlobalProgressHUDWithTitle(UIApplication.shared.keyWindow!, title: NSLocalizedString("Data syncing...", comment: ""))
                                    self.callSyncApi()
                                } else {
                                    Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
                                }
                            }
                            else {
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                            }
                        }
                        else {
                            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                        }
                    } else {
                        
                        if vlue == true{
                            let custArr = CoreDataHandler().fetchCustomer()
                            if(custArr.count == 0){
                                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Please connect to Internet, switching species is only allowed when device is connected to Internet.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                appDelegate?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                            }
                            else{
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                            }
                        }
                        else if vlue1 == true{
                            let custArr = CoreDataHandlerTurkey().fetchCustomerTurkey()
                            if(custArr.count == 0){
                                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Please connect to Internet, switching species is only allowed when device is connected to Internet.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                appDelegate?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                            }  else {
                                
                                let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                                self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                            }
                        }
                        else {
                            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC") as? BirdsSelectionVC
                            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
                        }
                    }
                }
            }
            
            
            if selectedRow == 0 {
                self.navigationController?.popToViewController(ofClass: GlobalDashboardViewController.self)
            }
         
        }
        
        //************************** Is Vaccination *****************************
        if userType == "Vaccination" {
            switch selectedRow{
            case 0:
                self.navigationController?.popToViewController(ofClass: HatcherySelectionViewController.self)
                delegate?.collapseSidePanels?()
                return
            case 1:
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: VaccinationDashboardVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                    }
                }
            case 2:
                
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ViewCertificationsVC.self) {
                        let userDefaults = UserDefaults.standard
                        if userDefaults.value(forKey: "ViewCertificationsVC") != nil{
                            let val = userDefaults.value(forKey: "ViewCertificationsVC") as? String
                            if val == VaccinationCertificationStatus.submitted.rawValue{
                                delegate?.collapseSidePanels?()
                                return
                            }
                        }
                    }
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Certification", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewCertificationsVC") as! ViewCertificationsVC //PVESessionViewController
                vc.status = VaccinationCertificationStatus.submitted
                navigationController?.pushViewController(vc, animated: true)
                
            case 3:
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: ViewCertificationsVC.self) {
                        let userDefaults = UserDefaults.standard
                        if userDefaults.value(forKey: "ViewCertificationsVC") != nil{
                            let val = userDefaults.value(forKey: "ViewCertificationsVC") as? String
                            if val == VaccinationCertificationStatus.draft.rawValue{
                                delegate?.collapseSidePanels?()
                                return
                            }
                        }
                    }
                }
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Certification", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ViewCertificationsVC") as! ViewCertificationsVC
                vc.status = VaccinationCertificationStatus.draft
                navigationController?.pushViewController(vc, animated: true)
                
            case 4:
                logoutBtnAction()
                delegate?.collapseSidePanels?()
                
            default:
                delegate?.collapseSidePanels?()
                break;
            }
        }
        
        delegate?.collapseSidePanels?()
    }
    
    @IBAction func leftPanelTapped(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
    func setLeftPenalNotification() {
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,selector: #selector(LeftMenuBtnNoti),
                                       name: NSNotification.Name("LeftMenuBtnNoti"),object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(DashBtnNoti),
                                       name: NSNotification.Name("DashBtnNoti"),object: nil)
    }
    
    @objc private func LeftMenuBtnNoti(noti: NSNotification){
        delegate?.toggleLeftPanel!()
    }
    
    @objc private func DashBtnNoti(noti: NSNotification){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            _ = touch.location(in: self.view)
            delegate?.collapseSidePanels!()
        }
    }
}

extension ViewController{
    
    func checkUserDataIsInDbOrNotPE() -> Bool{
        let peNewAssessmentInDB = CoreDataHandlerPE().getSavedOnGoingAssessmentPEObject()
        if peNewAssessmentInDB.customerName?.count ?? 0 > 0 {
            return true
        }
        return false
    }
    
    private func navigateToPEDashboard(){
        let vc = UIStoryboard.init(name: Constants.Storyboard.selection, bundle: Bundle.main).instantiateViewController(withIdentifier: "GlobalDashboardViewController") as? GlobalDashboardViewController
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
}

extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"]  as? String ?? ""
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"]  as? String ?? ""
    }
    
}
