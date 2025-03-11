//
//  CountrySelectViewController.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 03/04/24.
//

import UIKit
import Gigya
import GigyaTfa
import GigyaAuth
import WebKit
import Alamofire
import CoreData
import Reachability
import FirebaseCrashlytics
import JNKeychain
import simd

class CountrySelectViewController: BaseViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    @IBOutlet weak var countryView: UIView!
    
    @IBOutlet weak var languageView: UIView!
    
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var btnCountry: UIButton!
    
    @IBOutlet weak var btnLanguage: UIButton!
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var necxtBtn: PESubmitButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    var langNameArray: [String] = []
    var langCultureArray : [String] = []
    var langIdArray : [NSNumber] = []
    var countryArray: [String] = []
    var countryId: [NSNumber] = []
    var apiKeyId: NSNumber?
    var domainName : String?
    var apiKey: String?
    
    var btnTag = Int()
    var bottomViewController:BottomViewController!
    var isLoggedIn = false
    var termsCond = Int()
    var accestoken = String()
    var loginArray = NSArray()
    var userName = String()
    var lastScreenFlag: Int!
    
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.fetchGigyaCountryList()
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
        
        let seelectedLanguage = UserDefaults.standard.value(forKey: "AppleLanguages") as! [String]
        if seelectedLanguage[0] == "en" {
            UserDefaults.standard.set(1, forKey: "lngId")
            lblLanguage.text = "English"
            lblCountry.text = "USA"
            
        } else if seelectedLanguage[0] == "fr" {
            UserDefaults.standard.set(3, forKey: "lngId")
            lblLanguage.text = "French"
            //lblLanuage.text = "Select language"
            
        } else if seelectedLanguage[0] == "es" {
            UserDefaults.standard.set(3, forKey: "lngId")
            lblLanguage.text = "Spanish"
        }
        else {
            //UserDefaults.standard.set(1, forKey: "lngId")
            lblLanguage.text = "English"
            UserDefaults.standard.set(1, forKey: "lngId")
        }
        setupHeader()
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:  /*********** Fetch Gigya Country List **************/
    private func fetchGigyaCountryList(){
        Constants.baseUrl = Constants.Api.fhBaseUrl
        self.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
        if ConnectionManager.shared.hasConnectivity() {
            ZoetisWebServices.shared.getGigyaCountryList(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                let mainQueue = OperationQueue.main
                mainQueue.addOperation{
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    var dataArray = json
                    for countries in dataArray {
                        var countryName = countries.1
                        print(countryName)
                        let country = countryName["CountryName"]
                        print(country)
                        let countryIds = countryName["CountryId"]
                        print(countryIds)
                        self?.countryArray.append(country.rawValue as! String)
                        self?.countryId.append(countryIds.rawValue as! NSNumber)
                    }
                    
                }
            })
        }
        
        else{
            self.showToastWithTimer(message: Constants.failedPosting, duration: 3.0)
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
                        print(language)
                        let langCulture = language["Language_Culture"]
                        print(langCulture)
                        self?.langCultureArray.append(langCulture.rawValue as! String)
                        let langName = language["Language_Name"]
                        print(langName)
                        self?.langNameArray.append(langName.rawValue as! String)
                        let langId = language["Id"]
                        print(langId)
                        self?.langIdArray.append(langId.rawValue as! NSNumber)
                        
                    }
                }
            })
        }
        
        else{
            self.showToastWithTimer(message: Constants.failedPosting, duration: 3.0)
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
                        self?.apiKey = countryApiKey.rawValue as? String
                        let domainName = apiKeys["Data_Center"]
                        self?.domainName = domainName.rawValue as? String
                        let apiKeyId = apiKeys["Id"]
                        self?.apiKeyId = apiKeyId.rawValue as? NSNumber
                        self?.gigya.initFor(apiKey: self?.apiKey ?? "" , apiDomain: self?.domainName)
                    }
                }
            })
        }
        else{
            self.showToastWithTimer(message: Constants.failedPosting, duration: 3.0)
            self.dismissGlobalHUD(self.view ?? UIView())
        }
    }
    
    private func setupHeader() {
        bottomViewController = BottomViewController()
        self.bottomView.addSubview(bottomViewController.view)
        self.topviewConstraint(vwTop: bottomViewController.view)
    }
    
    // MARK:  /*********** Country Button Action **************/
    @IBAction func countryBtnAction(_ sender: Any) {
        btnTag = 1
        tableViewpop()
    }
    // MARK:  /*********** Language button Action **************/
    @IBAction func languageBtnAction(_ sender: Any) {
        btnTag = 2
        tableViewpop()
    }
    // MARK:  /*********** Next button Action **************/
//    @IBAction func nextBtnAction(_ sender: Any) {
//      print("nextBtnAction")
//    }
    
    // MARK: ************* Call Dashboard View ***************
    func callDashBordView() {
        callSelectionModule()
    }
    
    // MARK: ************* Call Selection View ***************
    func callSelectionModule(){
        UserDefaults.standard.set(true, forKey: "newlogin")
        let vc = UIStoryboard.init(name: Constants.Storyboard.selection, bundle: Bundle.main).instantiateViewController(withIdentifier: "GlobalDashboardViewController") as? GlobalDashboardViewController
        self.navigationController?.pushViewController(vc!, animated: false)
        
    }
    // MARK: ************* Dropdown popup  ***************
    func tableViewpop() {
        
        if btnTag == 1
        {
            self.dropDownVIewNew(arrayData: countryArray, kWidth: countryView.frame.width, kAnchor: countryView, yheight: countryView.bounds.height) { [unowned self] selectedVal, index  in
                self.lblCountry.text = selectedVal
                let countryID = countryId[index]
                let strCountryId = String(describing: countryID)
                self.langNameArray.removeAll()
                self.langIdArray.removeAll()
                self.langCultureArray.removeAll()
                self.fetchGigyaCountryLang(countryId: strCountryId)
                self.fetchGigyaApiKeys(countryId: strCountryId)
                
                self.lblLanguage.text = ""
                
                //                if selectedVal == "English" {
                //                    UserDefaults.standard.set(1, forKey: "lngId")
                //                    LanguageUtility.setAppleLAnguageTo(lang: "en")
                //                    UserDefaults.standard.synchronize()
                //                } else {
                //                    UserDefaults.standard.set(3, forKey: "lngId")
                //                    LanguageUtility.setAppleLAnguageTo(lang: "fr")
                //                    UserDefaults.standard.synchronize()
                //                }
            }
        }
        else
        {
            self.dropDownVIewNew(arrayData: langNameArray, kWidth: languageView.frame.width, kAnchor: languageView, yheight: languageView.bounds.height) { [unowned self] selectedVal, index  in
                self.lblLanguage.text = selectedVal
                
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
    
    //MARKS: DROP DOWN HIDDEN AND SHOW
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
        }
        else
        {
            return langNameArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if btnTag == 1
        {
            let country  = countryArray[indexPath.row]
            cell.textLabel!.text = country as? String
        }
        else
        {
            let lang  = langNameArray[indexPath.row]
            cell.textLabel!.text = lang as? String
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if btnTag == 1
        {
            let str = countryArray[indexPath.row]
            let id = countryId[indexPath.row]
            lblCountry.text = str
            lblLanguage.text = ""
            langNameArray.removeAll()
            langIdArray.removeAll()
            langCultureArray.removeAll()
        }
        else
        {
            let str = langNameArray[indexPath.row]
            lblLanguage.text = str
            
            if  lblLanguage.text == "French" {
                UserDefaults.standard.set(3, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "fr")
                UserDefaults.standard.synchronize()
            }
            else if  lblLanguage.text == "Portuguese" {
                UserDefaults.standard.set(4, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "pt-BR")
                UserDefaults.standard.synchronize()
            }
            else {
                UserDefaults.standard.set(1, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "en")
                UserDefaults.standard.synchronize()
            }
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
    
    // MARK: ************* Custome alert Messages ***************
    func alerView(statusCode: Int) {
        UserDefaults.standard.removeObject(forKey: "Id")
        self.deleteAllData("Login")
        let alertController = UIAlertController(title: "", message: "Unable to get data from server.\n(\(statusCode))", preferredStyle: UIAlertController.Style.alert) //Replace
        let okAction = UIAlertAction(title: "Retry", style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            Helper.dismissGlobalHUD(self.view)
            
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: ************* Custome Internet fail message ***************
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
    
}

class WebBridgeViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: .zero)
        webView.uiDelegate = self
        view = webView
        
        let webBridge = Gigya.sharedInstance(UserHost.self).createWebBridge()
        
        webBridge.attachTo(webView: webView, viewController: self) { [weak self] (event) in
            switch event {
            case .onLogin(let account):
                self?.navigationController?.popViewController(animated: true)
            default: break
            }
        }
    }
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        
        let myURL = URL(string: "https://matts.gigya-cs.com/nfl/notifyLogin.php")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
