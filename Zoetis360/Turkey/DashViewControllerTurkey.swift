//
//  DashViewControllerTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 12/03/18.
//
import UIKit
//import Charts
import Alamofire
import Reachability

import SystemConfiguration
import CoreData

import Gigya
import GigyaTfa
import GigyaAuth
import SwiftyJSON

class DashViewControllerTurkey: UIViewController,syncApiTurkey,SyncApiDataTurkey {
    
    
    // MARK: - VARIABLES
    var postingId = Int()
    var feedId = Int()
    var btnTag = Int()
    var lngId = NSInteger()
    let images  = [UIImage(named: "turkey_dashboard@1908x.jpg")!,
                   UIImage(named: "embrex_banner_graphic_1786x432.jpg")!,
                   UIImage(named: "PoulvacEcoli_banner_graphic_1908x802.jpg")!,
                   UIImage(named: "PoulvacIB_banner_graphic_1908x802.jpg")!,
                   UIImage(named: "Rotecc_banner_graphic_1908x802.jpg")!]
    var index = 0
    let animationDuration: TimeInterval = 0.75
    let switchingInterval: TimeInterval = 5
    let buttonbg = UIButton ()
    var customPopView1 :UserListView!
    var postingIdArr = NSMutableArray()
    var dataArray = NSMutableArray()
    var dataArray1 = NSMutableArray()
    var RouteArray = NSArray ()
    var custmorArr = NSArray ()
    var salesRepArr = NSArray ()
    
    var cocoiiProgramArr = NSArray ()
    var sessiontypeArr = NSArray ()
    var birdSizeArr = NSArray ()
    var breedArr = NSArray ()
    var veterianArr = NSArray ()
    var complexArr = NSArray()
    var FeedProgramArray = NSMutableArray()
    var cocciVaccine = NSMutableArray()
    var targetWeight = NSMutableArray()
    var dataSkeletaArray = NSArray ()
    var dataCocoiiArray = NSArray ()
    var dataGiTractArray = NSArray ()
    var dataRespiratoryArray = NSArray ()
    var dataImmuneArray = NSArray ()
    
    var serviceDataHldArr = NSMutableArray()
    var NecropsiesPostingSess =  NSMutableArray()
    var farmsListAray = NSArray ()
    let objApiSync = ApiSyncTurkey()
    let objApiSyncOneSetTurkey = SingleSyncDataTurkey()
    var complexSize = NSMutableArray()
    var arraVetType  = NSMutableArray()
    var getFormArray = NSMutableArray ()
    var arraCustmer = NSMutableArray ()
    var arraSalesRep = NSMutableArray ()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var genType = NSMutableArray()
    var genTypeArray = NSArray()
    var val = NSArray()
    var valnecPos = NSArray()
    var isSync : Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var dataSyncCount: UILabel!
    @IBOutlet weak var dataAvailbleForSync: UILabel!
    @IBOutlet weak var syncBackImageView: UIImageView!
    @IBOutlet weak var sideMenuBtnOutlet: UIButton!
    @IBOutlet weak var syncCount: UILabel!
    @IBOutlet weak var syncBtnOutlet: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var sessionBadgeLbl: UILabel!
    @IBOutlet weak var unlinkdBadgeLbl: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var PostingSessionButton: UIButton!
    @IBOutlet weak var ActiveSessionButton: UIButton!
    @IBOutlet weak var ReportsButton: UIButton!
    @IBOutlet weak var startSessionButton: UIButton!
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    
    private let sessionManager: Session = {
           let configuration = URLSessionConfiguration.default
           configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
           configuration.urlCache = nil
           return Session(configuration: configuration)
       }()
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "PostingVCTurkey") as! PostingVCTurkey
        self.navigationController?.pushViewController(navigateTo, animated: false)
    }
    // MARK: - **************** View Life Cycle ***********************************/
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        
        if lngId == 3{
            callLoginView()
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(DashViewControllerTurkey.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifierTurkey"), object: nil)
        
        self.printSyncLblCountChicken()
        UserDefaults.standard.set(true, forKey: "turkeySyncStatus")
        UserDefaults.standard.set(2, forKey: "birdTypeId")
        UserDefaults.standard.set(false, forKey: "ChickenBird")
        if UserDefaults.standard.integer(forKey: "Role") == 0 {
            PostingSessionButton.isUserInteractionEnabled = false
            ActiveSessionButton.isUserInteractionEnabled = false
            ReportsButton.isUserInteractionEnabled = false
            startSessionButton.isUserInteractionEnabled = false
            syncBtnOutlet.isUserInteractionEnabled = false
        }
        else{
            ActiveSessionButton.isUserInteractionEnabled = true
            ReportsButton.isUserInteractionEnabled = true
            PostingSessionButton.isUserInteractionEnabled = true
            startSessionButton.isUserInteractionEnabled = true
            syncBtnOutlet.isUserInteractionEnabled = true
        }
        objApiSync.delegeteSyncApiTurkey = self
        objApiSyncOneSetTurkey.delegeteSyncApiData = self
        UserDefaults.standard.set(false, forKey: "Unlinked")
        UserDefaults.standard.set(false, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        appDelegate.sendFeedVariable = ""
        btnTag = 0
        bannerImageView.startAnimating()
        
        let custArr = CoreDataHandlerTurkey().fetchCustomerTurkey()
        if(custArr.count == 0){
            callWebService()
        }
    }
    
    override  func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(false, forKey: "Unlinked")
        UserDefaults.standard.set(false, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        
        self.printSyncLblCount()
        let sync =  UserDefaults.standard.bool(forKey: "promt")
        if sync == true && self.allSessionArr().count > 0
        {
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callPrmpApi), userInfo: nil, repeats: false)
        }
        if sync == false || self.allSessionArr().count == 0
        {
            Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(iSfarmSync), userInfo: nil, repeats: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierLeftMenu"), object: nil)
        UserDefaults.standard.set(2, forKey: "LastScreenRef")
        userNameLbl.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        
        UserDefaults.standard.set(true, forKey: "nec")
        UserDefaults.standard.set(true, forKey: "timeStampTrue")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        UserDefaults.standard.set(1, forKey: "sessionId")
        UserDefaults.standard.set(0, forKey: "isBackWithoutFedd")
        UserDefaults.standard.removeObject(forKey: "count")
        UserDefaults.standard.synchronize()
        
        userNameLbl.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        
        let totalExustingArr = CoreDataHandlerTurkey().fetchAllPostingExistingSessionwithFullSessionTurkey(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        val = CoreDataHandlerTurkey().fetchAllPostingExistingSessionwithFullSessionTurkey(0, birdTypeId: 0) as NSArray
        for i in 0..<val.count{
            let posting : PostingSessionTurkey = val.object(at: i) as! PostingSessionTurkey
            let pidSession = posting.postingId
            let feedProgram =  CoreDataHandlerTurkey().FetchFeedProgramTurkey(pidSession!)
            if feedProgram.count == 0{
                CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(pidSession!)
                CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(pidSession!)
                CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(pidSession!)
            }
        }
        
        for i in 0..<totalExustingArr.count{
            let postingSession : PostingSessionTurkey = totalExustingArr.object(at: i) as! PostingSessionTurkey
            let pid = postingSession.postingId
            let feedProgram =  CoreDataHandlerTurkey().FetchFeedProgramTurkey(pid!)
            if feedProgram.count == 0{
                CoreDataHandlerTurkey().updatePostingSessionOndashBoardTurkey(pid!, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
                CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(pid!)
                CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(pid!)
            }
        }
        
        self.NecropsiesPostingSess =  CoreDataHandlerTurkey().FetchNecropsystep1UpdateFromUnlinkedTurkey(0).mutableCopy() as! NSMutableArray
        valnecPos  = CoreDataHandlerTurkey().fetchAllPostingSessionWithVetIdTurkey(_VetName: "") as NSArray
        let arr = NSMutableArray()
        
        for i in 0..<totalExustingArr.count {
            let posting : PostingSessionTurkey = totalExustingArr.object(at: i) as! PostingSessionTurkey
            let finializeB = posting.finalizeExit as! Int
            arr.add(posting)
        }
        
        sessionBadgeLbl.text = String(arr.count + valnecPos.count + val.count)
        unlinkdBadgeLbl.text =  String(valnecPos.count + val.count )
        self.printSyncLblCount()
    }
    
    // MARK: - Button Action
    
    @IBAction func sideMenuBttnAction(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
    }
    
    @IBAction func logOutBtnAction(_ sender: UIButton) {
        clickHelpPopUp()
    }
    
    @IBAction func syncBtnAction(_ sender: UIButton) {
        
        if self.allSessionArr().count > 0 {
            if ConnectionManager.shared.hasConnectivity() {
                Helper.showGlobalProgressHUDWithTitle(self.view, title: "Data syncing ...")
                self.callSyncApi()
                
            } else {
                Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:Constants.offline)
            }
        } else {
            
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data not available for syncing.", comment: ""))
        }
    }
    
    @IBAction func trainingEducationAction(_ sender: UIButton) {
        
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "TrainingNew") as! TrainingViewController
        self.navigationController?.pushViewController(navigateTo, animated: true)
    }
    
    @IBAction func startNewSessionAction(_ sender: UIButton) {
        
        UserDefaults.standard.set(0, forKey: "postingId")
        UserDefaults.standard.set(0, forKey: "necUnLinked")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        Constants.isForUnlinkedTurkey = false
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "PostingVCTurkey") as! PostingVCTurkey
        self.navigationController?.pushViewController(navigateTo, animated: true)
    }
    
    @IBAction func openExistingSession(_ sender: UIButton) {
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "ExistingTurkey") as! ExistingPostingSessionTurkey
        self.navigationController?.pushViewController(navigateTo, animated: true)
    }
    
    @IBAction func reportsBttnAction(_ sender: UIButton) {
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "ReportTurkey") as! ReportDashboardTurkey
        self.navigationController?.pushViewController(navigateTo, animated: true)
    }
    
    @IBAction func startSessionAction(_ sender: UIButton) {
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "StartNecropsyVcTurky") as? StartNecropsyVcTurky
        self.navigationController?.pushViewController(navigateTo!, animated: true)
    }
    
    @IBAction func unlinkedSessionAction(_ sender: UIButton) {
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "UnlinkedNecrTurkey") as! UnlinkedNecropsyControllerTurkey
        self.navigationController?.pushViewController(navigateTo, animated: true)
    }
    
    // MARK: - METHODS AND FUNCTIONS
    
    @objc func callPrmpApi()  {
        self.promtSyncing()
    }
    
    func animateImageView() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            let delay = DispatchTime.now() + Double(Int64(self.switchingInterval * TimeInterval(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.animateImageView()
            }
        }
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        bannerImageView.layer.add(transition, forKey: kCATransition)
        bannerImageView.image = images[index]
        CATransaction.commit()
        index = index < images.count - 1 ? index + 1 : 0
    }
    func printSyncLblCountChicken() {
        
        dataSyncCount.text = String(self.allSessionArrChicken().count)
        if dataSyncCount.text == String(0)
        {
            dataSyncCount.isHidden = true
            dataAvailbleForSync.isHidden = true
            syncBackImageView.isHidden = true
        }
        else
        {
            dataAvailbleForSync.isHidden = false
            syncBackImageView.isHidden = false
            dataSyncCount.isHidden = false
        }
        
    }
    var accestoken = String()
    ///// Setting get Turkey
    
    func callWebService() {
        if WebClass.sharedInstance.connected() {
            Helper.showGlobalProgressHUDWithTitle(self.view, title: "Loading...")
            let keychainHelper = AccessTokenHelper()
            accestoken = keychainHelper.getFromKeychain(keyed: "aceesTokentype") ?? ""
          //  accestoken = UserDefaults.standard.string(forKey: "aceesTokentype") ?? ""
            let headerDict: HTTPHeaders = [
                "Authorization": accestoken,
                "Cache-Control": "no-store, no-cache, must-revalidate, private"
            ]
            let Id = UserDefaults.standard.integer(forKey: "Id")
            let countryId = UserDefaults.standard.integer(forKey: "countryId")
            let Url = WebClass.sharedInstance.webUrl + "Setting/T_GetNecroCategoryObservationList?UserId=\(Id)&CountryId=\(countryId)"
            let urlString = URL(string: Url)

            // Create a session with disabled caching
//            let configuration = URLSessionConfiguration.default
////            configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//            let session = Session(configuration: configuration)
            sessionManager.request(urlString!, method: .get, headers: headerDict).responseJSON { response in
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get status code")
                    Helper.dismissGlobalHUD(self.view)
                    return
                }
                
                if statusCode == 401 {
                    self.loginMethod()
                } else if (400...404).contains(statusCode) || (500...504).contains(statusCode) {
                    let alertController = UIAlertController(
                        title: "",
                        message: "Unable to get data from server. \n(\(statusCode))",
                        preferredStyle: .alert
                    )
                    let okAction = UIAlertAction(title: "Retry", style: .default) { _ in
                        Helper.dismissGlobalHUD(self.view)
                        self.callWebService()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true)
                } else {
                    switch response.result {
                    case let .success(value):
                        if let arrayValue = value as? NSArray {
                            self.dataArray.removeAllObjects()
                            self.appDelegate.globalDataArrTurkey.removeAllObjects()
                            
                            for i in 0..<arrayValue.count {
                                if let tempDict = arrayValue[i] as? NSDictionary {
                                    let serviceHolder = ServiceDataHolder()
                                    serviceHolder.CategoryDescp = tempDict["CategoryDescription"] as? NSString ?? ""
                                    serviceHolder.CataID = tempDict["CategoryId"] as? NSInteger ?? 0
                                    serviceHolder.ObservaionDetailsArr = (tempDict["ObservaionDetails"] as? NSArray)?.mutableCopy() as? NSMutableArray ?? []
                                    self.dataArray.add(serviceHolder)
                                }
                            }
                            
                            self.appDelegate.globalDataArrTurkey = self.dataArray
                            self.skelta(0)
                            self.cocoii(1)
                            self.gitract(2)
                            self.res(3)
                            self.immu(4)
                            
                            self.callCustmerWebService()
                        } else {
                            self.callCustmerWebService()
                        }
                    case let .failure(error):
                        debugPrint("Network error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            self.appDelegate.globalDataArrTurkey = self.dataArray
            self.skelta(0)
            self.cocoii(1)
            self.gitract(2)
            self.res(3)
            self.immu(4)
            self.callCustmerWebService()
        }
    }

    
    func loginMethod() {
        guard WebClass.sharedInstance.connected() else {
            debugPrint("No internet connection")
            return
        }

        // Retrieve sensitive data securely
        guard let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier") as? String else {
            debugPrint("Missing Application Identifier")
            return
        }
        let userName = PasswordService.shared.getUsername()
        let password = PasswordService.shared.getPassword()

        // Encrypt sensitive parameters
        let encryptedUsername = CryptoHelper.encrypt(input: userName) as? String ?? ""
        let encryptedPassword = CryptoHelper.encrypt(input: password) as? String ?? ""

        let url = WebClass.sharedInstance.webUrl + "Token"
        let headers: HTTPHeaders = [
            "Authorization": accestoken,
            "Cache-Control": "no-store, no-cache, must-revalidate, private",
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        let parameters: [String: String] = [
            "grant_type": "password",
            "UserName": encryptedUsername,
            "Password": encryptedPassword,
            "LoginType": "Web",
            "DeviceId": udid
        ]

        // Disable HTTP caching
//        let configuration = URLSessionConfiguration.default
//        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
//        let sessionManager = Session(configuration: configuration)

        // Send the request
        sessionManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            
            Helper.dismissGlobalHUD(self.view)
            switch response.result {
            case .success(let value):
                guard let statusCode = response.response?.statusCode else {
                    debugPrint("Invalid response")
                    return
                }
                let dict = value as? [String: Any] ?? [:]

                switch statusCode {
                case 400, 401:
                    debugPrint("Error: \(dict["error_description"] as? String ?? "Unknown error")")
                case 200:
                    let acessToken = (dict["access_token"] as? String)!
                    
                    let tokenType = (dict["token_type"] as? String)!
                    let aceesTokentype: String = tokenType + " " + acessToken
                    _ = dict["HasAccess"]! as AnyObject
                    let keychainHelper = AccessTokenHelper()
                    keychainHelper.saveToKeychain(valued: aceesTokentype, keyed: "aceesTokentype")
//                    UserDefaults.standard.set(aceesTokentype,forKey: "aceesTokentype")
//                    UserDefaults.standard.synchronize()
                    self.callWebService()
                default:
                    debugPrint("Unhandled status code: \(statusCode)")
                }
            case .failure(let error):
                debugPrint("Request failed: \(error.localizedDescription)")
            }
        }
    }
    
    func promtSyncing (){
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleFont = [convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "HelveticaNeue-Light", size: 19.0)]
        let messageFont = [convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "HelveticaNeue-Light", size: 12.0)]
        
        var myString = "Data available for sync. Do you want to sync now? \n\n\n *Note - Please don't minimize App while syncing."
        let titleAttrString = NSMutableAttributedString(string: "Alert", attributes: convertToOptionalNSAttributedStringKeyDictionary(titleFont))
        var messageAttrString = NSMutableAttributedString(string: myString , attributes: convertToOptionalNSAttributedStringKeyDictionary(messageFont))
        messageAttrString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:50,length:52))
        let font = UIFont(name: "HelveticaNeue-Light", size: 11.0)
        messageAttrString.addAttribute(NSAttributedString.Key.font, value:font!, range: NSRange.init(location: 50 , length: 52))
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            if self.allSessionArr().count > 0
            {
                if ConnectionManager.shared.hasConnectivity() {
                    DispatchQueue.main.async {
                        Helper.showGlobalProgressHUDWithTitle(self.view, title: "Data syncing ...")
                        self.callSyncApi()
                    }
                }
                else
                {
                    Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:Constants.offline)
                }
                
            }
            else{
                Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"Data not available for syncing.")
            }
            Helper.dismissGlobalHUD(self.view)
            
        }
        
        let CancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.iSfarmSync()
            self.printSyncLblCount()
            UserDefaults.standard.set(false, forKey: "promt")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func callSyncApi() {
        self.isSync = false
        let arr = self.allSessionArr()
        for postingId in arr {
            if isSync == false{
                isSync = true
                if (UserDefaults.standard.value(forKey: "postingTurkey") != nil){
                    Constants.isFromPsotingTurkey = UserDefaults.standard.value(forKey: "postingTurkey") as? Bool ?? false
                    if Constants.isFromPsotingTurkey
                    {
                        objApiSyncOneSetTurkey.feedprogram(postingId: NSNumber(value: postingId as! Int))
                    }
                    else
                    {
                        objApiSync.feedprogram()
                    }
                }else{
                    objApiSync.feedprogram()
                }
            }
        }
    }
    
    func failWithError(statusCode:Int){
        
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        
        if statusCode == 0 {
            Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"There are problem in data syncing please try again.(NA))")
        } else {
            
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
                
            } else if lngId == 3 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
                
            } else if lngId == 1000 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Há problemas na sincronização de dados, tente novamente. \n(\(statusCode))")
            }
        }
    }
    
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:"Alert" , messageStr:"No internet connection. Please try again!")
    }
    
    func didFinishApi() {
        self.printSyncLblCount()
        
        if self.allSessionArr().count > 0 {
            self.showToastWithTimer(message: "Assessment synced successfully. Please Wait while we set this up for you.", duration: 2.0)
            self.isSync = false
            self.callSyncApi()
        }
        else {
            let alertView = UIAlertController(title:NSLocalizedString("Alert", comment: "") , message:NSLocalizedString("Data Sync has completed.", comment: ""), preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: "") , style: .default, handler: { (alertAction) -> Void in
                Helper.dismissGlobalHUD(self.view)
                self.iSfarmSync()
                
            }))
            present(alertView, animated: true, completion: nil)
        }
    }
    
    func failWithInternetConnection() {
        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:"Alert" , messageStr: Constants.offline)
    }
    
    // ******************************* Get FormList From Server ************************************* //
    
    
    func getListFarms() {
        guard WebClass.sharedInstance.connected() else {
            // Offline mode: Fetch data from Core Data
            self.farmsListAray = CoreDataHandlerTurkey().fetchFarmsDataDatabaseTurkey()
            if self.farmsListAray.count == 0 {
                self.callSaveMethodgetListFarms(self.getFormArray)
            }
            return
        }
        accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
      //  accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
        // Set up headers and parameters
        let headers: HTTPHeaders = [
            "Authorization": accestoken,
            "Cache-Control": "no-store, no-cache, must-revalidate, private"
        ]

        let userId = UserDefaults.standard.integer(forKey: "Id")
        let parameters: [String: Any] = ["userId": userId]
        
        // Construct URL
        let urlString = WebClass.sharedInstance.webUrl + "Farm/GetFarmListByUserId"
        guard let url = URL(string: urlString) else {
            debugPrint("Invalid URL")
            return
        }
                
        // Make the request
        sessionManager.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            guard let statusCode = response.response?.statusCode else {
                debugPrint("Failed to get response")
                return
            }
            
            switch statusCode {
            case 401:
                self.loginMethod() // Re-login on unauthorized access
            case 400...599:
                // Handle server errors with a user-friendly alert
                let alertController = UIAlertController(
                    title: "Error",
                    message: "Unable to get data from the server. (\(statusCode))",
                    preferredStyle: .alert
                )
                let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                    Helper.dismissGlobalHUD(self.view)
                    self.getListFarms()
                }
                alertController.addAction(retryAction)
                self.present(alertController, animated: true)
            default:
                // Handle success response
                switch response.result {
                case .success(let value):
                    if let farmsArray = value as? [[String: Any]] {
                        self.getFormArray = NSMutableArray()
                        
                        // Process farm data
                        for farm in farmsArray {
                            let farmDict = NSMutableDictionary()
                            farmDict["CountryId"] = farm["CountryId"] as? Int
                            farmDict["FarmId"] = farm["FarmId"] as? Int
                            farmDict["FarmName"] = farm["FarmName"] as? String
                            self.getFormArray.add(farmDict)
                        }
                        
                        // Save to Core Data
                        CoreDataHandlerTurkey().deleteAllDataTurkey("FarmsListTurkey")
                        self.callSaveMethodgetListFarms(self.getFormArray)
                        self.callVeterianService()
                    } else {
                        // No farms found, proceed to next service call
                        self.callVeterianService()
                    }
                case .failure(let error):
                    debugPrint("Request failed: \(error.localizedDescription)")
                }
            }
        }
    }

    
    func callSaveMethodgetListFarms(_ farmsArray : NSArray) {
        
        for i in 0..<farmsArray.count {
            
            let FarmId = (farmsArray.object(at: i) as AnyObject).value(forKey: "FarmId") as! NSNumber
            let FarmName = (farmsArray.object(at: i) as AnyObject).value(forKey: "FarmName") as! String
            let CountryId = (farmsArray.object(at: i) as AnyObject).value(forKey: "CountryId") as! NSNumber
            /***************** All details Save in to FarmdataBase ****************************************/
            CoreDataHandlerTurkey().FarmsDataDatabaseTurkey("", stateId: 0, farmName: FarmName, farmId: FarmId, countryName: "", countryId: CountryId, city: "")
        }
    }
    
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
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
    
    //*********   Feed Program molecule ************\////

    func FeedProgramMoleculeService() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getFeedProgramCatagoryAndMoleculeDetailsResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Feed Program molecule list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary,
                       let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Feed Program molecule: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    if let arr = JSON(json).array, !arr.isEmpty {
                        self.FeedProgramArray = NSMutableArray() // Ensure it is mutable
                        
                        for i in 0..<arr.count {
                            let tempDict  = arr[i].dictionaryObject as NSDictionary? // Convert JSON to NSDictionary
                            tempDict!.value(forKey: "FeedProgramCategoryDescription") as! String
                            tempDict!.value(forKey: "FeedProgramCategoryId") as! Int
                            self.FeedProgramArray.add(tempDict as Any)
                          
                        }
                        
                        // Store in UserDefaults
                        UserDefaults.standard.set(self.FeedProgramArray, forKey: "Molucule")

                        // Proceed with the next function call
                        self.callGetCocciVaccine()
                    } else {
                        // Handle empty array case
                        print("Feed Program molecule list is empty.")
                        self.callGetCocciVaccine()
                    }
 
                }
                
            })
            
        } else{
            self.failWithInternetConnection()
        }
    }


    
    func callFeedProgramMoleculeService( _ breedTypeArr : NSArray) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    func callSaveMethodforSessiontype( _ seessionTypeArr : NSArray) {
        
        for i in 0..<seessionTypeArr.count {
            
            let SessionId = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "SessionTypeId") as! Int
            let sessionName = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "SessionTypeName") as! String
            let lngId = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            CoreDataHandlerTurkey().SessionTypeDatabaseTurkey(SessionId, sesionType: sessionName, lngId: lngId, dbArray: self.sessiontypeArr, index: i)
        }
    }
    
    func callSaveMethodforeterian( _ veterianArray : NSArray) {
        var vetId = 0
        var vetName = ""
        for i in 0..<veterianArray.count {
            if let num = (veterianArray.object(at: i) as AnyObject).value(forKey: "VeterinarianId") {
                vetId = num as! Int
            }
            if let str = (veterianArray.object(at: i) as AnyObject).value(forKey: "VeterinarianName") {
                vetName = str as! String
            }
            CoreDataHandlerTurkey().VetDataDatabaseTurkey(vetId, vtName: vetName, complexId: 0, dbArray: self.veterianArr, index: i)
        }
    }
    
    func callSaveMethodforBirdSize( _ birdSizeTypeArr : NSArray) {
        
        for i in 0..<birdSizeTypeArr.count {
            
            let birdSizeId = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "BirdSizeId") as! Int
            let birdSizeName = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "BirdSize") as! String
            let birdtype = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "ScaleType") as! String
            CoreDataHandlerTurkey().BirdSizeDatabaseTurkey(birdSizeId, birdSize: birdSizeName, scaleType: birdtype, dbArray: self.birdSizeArr, index: i)
        }
    }
    
    func callSaveMethod( _ routeArr : NSArray) {
        
        for i in 0..<routeArr.count {
            let routeId = (routeArr.object(at: i) as AnyObject).value(forKey: "RouteId") as! Int
            let lngId = (routeArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            let routeName = (routeArr.object(at: i) as AnyObject).value(forKey: "RouteName") as! String
            
            CoreDataHandlerTurkey().saveRouteDatabaseTurkey(routeId, routeName: routeName,lngId:lngId, dbArray: self.RouteArray, index: i)
        }
    }
    
    func skelta (_ tag: Int) {
        btnTag = 0
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataSkeletaArray = CoreDataHandlerTurkey().fetchAllSeettingdataTurkey()
        if dataSkeletaArray.count == 0 {
            
            self.callSaveMethod1(serviceDataHldArr)
            dataSkeletaArray = CoreDataHandlerTurkey().fetchAllSeettingdataTurkey()
        }
    }
    
    func skeltaInfoArr(){
        
        for i in 0..<dataSkeletaArray.count{
            let sketlaVal = dataSkeletaArray[i] as! Skeleta
            let obsName12 = sketlaVal.observationField
            var dict12 = [String: Any]()
            let skeltaArr12 = NSMutableArray()
            skeltaArr12.add(sketlaVal.observationId ?? 0)
            skeltaArr12.add(sketlaVal.observationId ?? 0)
            dict12[obsName12!] = skeltaArr12
        }
    }
    
    func cocoii (_ tag: Int) {
        
        btnTag = 1
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataCocoiiArray = CoreDataHandlerTurkey().fetchAllCocoiiDataTurkey()
        if dataCocoiiArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataCocoiiArray = CoreDataHandlerTurkey().fetchAllCocoiiDataTurkey()
        }
    }
    func callLoginView()  {
        UserDefaults.standard.removeObject(forKey: "login")
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    
    func gitract (_ tag: Int) {
        
        btnTag = 2
        
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            
            var _temp = ServiceDataHolder()
            
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataGiTractArray = CoreDataHandlerTurkey().fetchAllGITractDataTurkey()
        if dataGiTractArray.count == 0 {
            
            self.callSaveMethod1(serviceDataHldArr)
            dataGiTractArray = CoreDataHandlerTurkey().fetchAllGITractDataTurkey()
        }
    }
    
    func res (_ tag: Int) {
        btnTag = 3
        
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            
            var _temp = ServiceDataHolder()
            
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataRespiratoryArray = CoreDataHandlerTurkey().fetchAllRespiratoryTurkey()
        if dataRespiratoryArray.count == 0 {
            
            self.callSaveMethod1(serviceDataHldArr)
            dataRespiratoryArray = CoreDataHandlerTurkey().fetchAllRespiratoryTurkey()
        }
    }
    
    
    func immu (_ tag: Int) {
        btnTag = 4
        
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            
            var _temp = ServiceDataHolder()
            
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataImmuneArray = CoreDataHandlerTurkey().fetchAllImmuneTurkey()
        if dataImmuneArray.count == 0 {
            
            self.callSaveMethod1(serviceDataHldArr)
            dataImmuneArray = CoreDataHandlerTurkey().fetchAllImmuneTurkey()
        }
    }
    
    
    func callSaveMethod1( _ skeletaArr : NSArray) {
        
        for i in 0..<skeletaArr.count {
            
            let strObservationField = (skeletaArr.object(at: i) as AnyObject).value(forKey: "ObservationDescription") as! String
            let visibilityCheck = (skeletaArr.object(at: i) as AnyObject).value(forKey: "DefaultQLink") as! Bool
            let obsId = (skeletaArr.object(at: i) as AnyObject).value(forKey: "ObservationId") as! NSInteger
            let visibilitySwitch = (skeletaArr.object(at: i) as AnyObject).value(forKey: "Visibility") as! Bool
            let measure =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "Measure") as! String
            let lngIdValue =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! NSNumber
            let refId =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "ReferenceId") as! NSNumber
            let quickLinkIndex =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "SequenceId") as? Int
            
            var isVisibilityCheck = Bool()
            var isQuicklinksCheck = Bool()
            if visibilityCheck == true {
                isQuicklinksCheck = true
                
            } else if visibilityCheck == false {
                isQuicklinksCheck = false
            }
            if visibilitySwitch == true {
                isVisibilityCheck = true
            } else {
                
                isVisibilityCheck = false
            }
            
            if  btnTag == 0 {
                CoreDataHandlerTurkey().saveSettingsSkeletaInDatabaseTurkey(strObservationField,visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataSkeletaArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId:refId, quicklinkIndex: quickLinkIndex ?? 0 )
                
            } else if btnTag == 1{
                CoreDataHandlerTurkey().saveSettingsCocoiiInDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataCocoiiArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
                
            } else if btnTag == 2{
                CoreDataHandlerTurkey().saveSettingsGITractDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataGiTractArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId:refId,quicklinkIndex: quickLinkIndex ?? 0)
                
            } else if btnTag == 3 {
                CoreDataHandlerTurkey().saveSettingsRespiratoryDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataRespiratoryArray,obsId:obsId,measure:measure,isSync:false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
                
            } else {
                CoreDataHandlerTurkey().saveSettingsImmuneDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataImmuneArray,obsId:obsId,measure:measure,isSync:false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
            }
            
        }
    }
    @objc func iSfarmSync(){
        let totalExustingArr = CoreDataHandlerTurkey().fetchAllPostingExistingSessionwithFullSessionTurkey(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        var isFarmSync = Bool()
        for i in 0..<totalExustingArr.count{
            let postingSession : PostingSessionTurkey = totalExustingArr.object(at: i) as! PostingSessionTurkey
            let pid = postingSession.postingId
            let farms = CoreDataHandlerTurkey().fetchNecropsystep1neccIdFeedProgramTurkey(pid!)
            if farms.count > 0 {
                CoreDataHandlerTurkey().updatedPostigSessionwithIsFarmSyncPostingIdTurkey(pid!, isFarmSync: true)
                if isFarmSync == false{
                    Helper.showAlertMessage(self,titleStr:"Alert" , messageStr: "You have unlinked farm(s) to your feed in posting session. Visit '' Open Existing Session '' to link farm(s) to feed program.")
                    isFarmSync = true
                }
            }
        }
    }
    
    func printSyncLblCount() {
        syncCount.text = String(self.allSessionArr().count)
    }
    
    func showToastWithTimer(message : String, duration: TimeInterval ) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 100))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        
        toastLabel.font  = UIFont(name: "HelveticaNeue-Light", size: 14.0)
        toastLabel.text = message
        toastLabel.numberOfLines = 3
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func callSaveMethodforCocoiiProgram( _ cocoiArr : NSArray) {
        
        for i in 0..<cocoiArr.count {
            let cocoiiId = (cocoiArr.object(at: i) as AnyObject).value(forKey: "CocciProgramId") as! Int
            let lngId = (cocoiArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            let cocoiiIdName = (cocoiArr.object(at: i) as AnyObject).value(forKey: "CocciProgramName") as! String
            CoreDataHandlerTurkey().CocoiiProgramDatabaseTurkey(cocoiiId, cocoiProgram: cocoiiIdName, lngId: lngId, dbArray: self.cocoiiProgramArr, index: i)
            
        }
    }
    
    func callSaveMethodforSalesRep( _ SalesRepArr : NSArray) {
        
        for i in 0..<SalesRepArr.count {
            let SalesId = (SalesRepArr.object(at: i) as AnyObject).value(forKey: "SalesRepresentativeId") as! Int
            let SalesNameName = (SalesRepArr.object(at: i) as AnyObject).value(forKey: "SalesRepresentativeName") as! String
            CoreDataHandlerTurkey().SalesRepDataDatabaseTurkey(SalesId, salesRepName: SalesNameName, dbArray: self.salesRepArr, index: i)
        }
    }
    
    func callSaveMethodforBreedType( _ breedTypeArr : NSArray) {
        for i in 0..<breedTypeArr.count {
            
            let breeId = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedId") as! Int
            let breedName = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedName") as! String
            let breedType = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedType") as! String
            CoreDataHandlerTurkey().BreedTypeDatabaseTurkey(breeId, breedType: breedType, breedName: breedName, dbArray: self.breedArr, index: i)
            
        }
    }
    
    func callSaveMethodforCustomer( _ custmorArr : NSArray) {
        for i in 0..<custmorArr.count {
            
            let CustId = (custmorArr.object(at: i) as AnyObject).value(forKey: "CustomerId") as! Int
            let CustName = (custmorArr.object(at: i) as AnyObject).value(forKey: "CustomerName") as! String
            CoreDataHandlerTurkey().saveCustmerDatabaseTurkey(CustId, CustName: CustName, dbArray: self.custmorArr, index: i)
        }
    }
    
    // MARK: Zoetis Web services to Get DATA API'S CALLING
    func callGetCocciVaccine() {
        if WebClass.sharedInstance.connected() {
            CoreDataHandlerTurkey().deleteAllDataTurkey("CocoiVaccineTurkey")
            
            ZoetisWebServices.shared.getCocciVaccineTurkeyResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Cocci Vaccine list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Cocci Vaccine list: \(errorMessage)")
                        self?.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        for item in arr {
                            if let cocciDict = item.dictionary {
                                // Safely unwrap and parse each key
                                let cocciVaccineId = cocciDict["CocciVaccineId"]?.int ?? -1
                                let cocciVaccineName = cocciDict["CocciVaccineName"]?.string ?? "Unknown"
                                let languageId = cocciDict["LanguageId"]?.int ?? -1
                                
                                // Save to CoreData
                                CoreDataHandlerTurkey().saveCocoiiVacTurkey(
                                    cocciVaccineId,
                                    decscMolecule: cocciVaccineName,
                                    lngId: languageId
                                )
                            } else {
                                print("Invalid data format in CocciVaccine array: \(item)")
                            }
                        }
                        
                        // Save serialized data to UserDefaults (if needed)
                        UserDefaults.standard.set(
                            arr.map { $0.dictionaryObject },
                            forKey: "cocci"
                        )
                    } else {
                        print("Cocci Vaccine list is empty.")
                        
                    }
                    
                    // Proceed with the next API call
                    self?.callTargetWeightProcessing()
                }
                
                
            })
            
        } else{
            self.failWithInternetConnection()
        }
    }
    
    func callCocciVaccineService( _ CocciVaccine : NSArray) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    func callTargetWeightProcessing() {
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getTargetWeightResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Target Weight Processing list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API: \(errorMessage)")
                        self?.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    if let arr = JSON(json).array, !arr.isEmpty {
                        var serializedArray: [[String: Any]] = []
                        for i in 0..<arr.count {
                            if let dictionary = arr[i].dictionaryObject {
                                serializedArray.append(dictionary)
                                self?.targetWeight.add(dictionary as AnyObject)
                            }
                        }
                        
                        UserDefaults.standard.set(serializedArray, forKey: "target")
                        self?.getListFarms()
                    } else {
                        self?.getListFarms()
                        print("No data received from the API.")
                        self?.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                    }
                }
                
            })
            
        } else {
            self.failWithErrorInternal()
        }
    }
    //MARK: ********* Zoetis API call to get Complex's list ******************************************
    func complexService() {
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getChickenTurkeyComplexByUserIdResponce(controller: self, parameters: ["UserId" :"UserId"], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Complex list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                DispatchQueue.main.async {
                    
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API: \(errorMessage)")
                        self?.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Check if the response contains an array
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Initialize the `complexSize` array
                        self?.complexSize = NSMutableArray()
                        
                        // Parse the array and populate `complexSize`
                        for item in arr {
                            if let tempDict = item.dictionaryObject {
                                let dictData = NSMutableDictionary()
                                dictData.setValue(tempDict["CustomerId"] as? Int, forKey: "CustomerId")
                                dictData.setValue(tempDict["ComplexName"] as? String, forKey: "ComplexName")
                                dictData.setValue(tempDict["ComplexId"] as? Int, forKey: "ComplexId")
                                self?.complexSize.add(dictData)
                            } else {
                                print("Invalid data format in array: \(item)")
                            }
                        }
                        
                        // Delete old data and save new data
                        CoreDataHandlerTurkey().deleteAllDataTurkey("ComplexPostingTurkey")
                        if let complexSize = self?.complexSize {
                            self?.callcomplexService(complexSize)
                        }
                        self?.callSalesRepWebService()
                    } else {
                        // Handle the case where the array is empty or nil
                        print("No data received from the API.")
                        self?.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                    }
                }
            })
        }
        else {
            self.complexArr = CoreDataHandlerTurkey().fetchCompexTypeTurkey()
            if(self.complexArr.count == 0){
                self.callcomplexService(self.complexSize)
                
            }
        }
    }
    
    
    func callcomplexService( _ complexArrrr : NSArray) {
        for i in 0..<complexArrrr.count {
            let custmerId = (complexArrrr.object(at: i) as AnyObject).value(forKey: "CustomerId") as! NSNumber
            let custmerName = (complexArrrr.object(at: i) as AnyObject).value(forKey: "ComplexName") as! String
            let complexid = (complexArrrr.object(at: i) as AnyObject).value(forKey: "ComplexId") as! NSNumber
            CoreDataHandlerTurkey().ComplexDatabaseTurkey(complexid, cutmerid: custmerId, complexName: custmerName, dbArray: complexArr, index: i)
        }
    }
    
    
    func callVeterianService() {
        
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getVeterinarianResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Bird Size list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary,
                       let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Bird Size list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        self.arraVetType = NSMutableArray()
                        CoreDataHandler().deleteAllData("VeterationTurkey")
                        for item in arr {
                            guard let tempDict = item.dictionaryObject else {
                                print("Invalid item structure in array.")
                                continue
                            }
                            
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["VeterinarianName"] as? String, forKey: "VeterinarianName")
                            dictData.setValue(tempDict["VeterinarianId"] as? Int, forKey: "VeterinarianId")
                           
                            arraVetType.add(dictData)
                        }
                        
                        self.callSaveMethodforeterian(self.arraVetType)
                        self.callhatcheryStrain()
                    } else {
                        // Handle the case when the array is empty
                        print("Bird Size list is empty.")
                        self.callhatcheryStrain()
                    }
                }
                
            })
        }
        else
        {
            self.failWithInternetConnection()
        }

    }


    
    func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                
            }
        }
        return nil
    }
    
    func callBreedService() {
        
        if WebClass.sharedInstance.connected() {
        ZoetisWebServices.shared.getBirdBreedChickenAndTurkeyResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else {
                self?.showToastWithTimer(message: "Failed to get Bird Size list", duration: 3.0)
                self?.dismissGlobalHUD(self?.view ?? UIView())
                return
            }
            
            DispatchQueue.main.async {
                
                if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                    print("Error from API: \(errorMessage)")
                    self?.showToastWithTimer(message: errorMessage, duration: 3.0)
                    return
                }
                
                // Check if the response contains an array
                if let arr = JSON(json).array, !arr.isEmpty {
                    // Initialize the `complexSize` array
                    let arraBreedType = NSMutableArray()
                    
                    // Parse the array and populate `complexSize`
                    for item in arr {
                        if let tempDict = item.dictionaryObject {
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["BirdBreedType"] as? String, forKey: "BirdBreedType")
                            dictData.setValue(tempDict["BirdBreedName"] as? String, forKey: "BirdBreedName")
                            dictData.setValue(tempDict["BirdBreedId"] as? Int, forKey: "BirdBreedId")
                            arraBreedType.add(dictData)
                        } else {
                            print("Invalid data format in array: \(item)")
                        }
                    }
                    
                    // Save data securely using Core Data
                    self?.breedArr = CoreDataHandlerTurkey().fetchBreedTypeTurkey()
                    if self?.breedArr.count == 0 {
                        self?.callSaveMethodforBreedType(arraBreedType)
                    }
                    
                    // Proceed with the next service call
                    self?.FeedProgramMoleculeService()
                } else {
                    // Handle the case where the array is empty or nil
                    print("No data received from the API.")
                    self?.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                }
            }
            
        })
    
    }
        else
        {
            self.failWithInternetConnection()
        }
    }
    
    func callBirdTypeService() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getBirdSizeResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Bird Size list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary,
                       let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Bird Size list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        let arraBirdSize = NSMutableArray()
                        CoreDataHandler().deleteAllData("BirdSizePostingTurkey")
                        for item in arr {
                            guard let tempDict = item.dictionaryObject else {
                                print("Invalid item structure in array.")
                                continue
                            }
                            
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["BirdSize"] as? String, forKey: "BirdSize")
                            dictData.setValue(tempDict["BirdSizeId"] as? Int, forKey: "BirdSizeId")
                            dictData.setValue(tempDict["ScaleType"] as? String, forKey: "ScaleType")
                            arraBirdSize.add(dictData)
                        }
                        
                        
                        self.birdSizeArr = CoreDataHandlerTurkey().fetchBirdSizeTurkey()
                        if(self.birdSizeArr.count == 0)
                        {
                            self.callSaveMethodforBirdSize(arraBirdSize)
                        }
                        self.callBreedService()
                    } else {
                        // Handle the case when the array is empty
                        print("Bird Size list is empty.")
                        self.callBreedService()
                    }
                }
                
            })
        } else{
            self.failWithInternetConnection()
        }
    }
    
    
    /*********** SessionType data call Web Service *******************************************************/
    //MARK: ********* Zoetis API call to get Session's type list ****************************************************/
    func callSessionTypeService() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getSessionTypeResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Session's type list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        let arraSessionType = NSMutableArray ()
                        
                        CoreDataHandler().deleteAllData("SessiontypeTurkey")
                        for item in arr {
                            guard let tempDict = item.dictionaryObject else {
                                print("Invalid item structure in array.")
                                continue
                            }
                            
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["SessionTypeName"] as? String, forKey: "SessionTypeName")
                            dictData.setValue(tempDict["SessionTypeId"] as? Int, forKey: "SessionTypeId")
                            dictData.setValue(tempDict["LanguageId"] as? Int, forKey: "LanguageId")
                            arraSessionType.add(dictData)
                        }
                        
                        self.sessiontypeArr = CoreDataHandlerTurkey().fetchSessiontypeTurkey()
                        
                        if(self.cocoiiProgramArr.count == 0)
                        {
                            self.callSaveMethodforSessiontype(arraSessionType)
                        }
                        
                        self.callBirdTypeService()
                        
                    }
                    else
                    {
                        self.callBirdTypeService()
                    }
                    
                }
                
            })
            
        } else {
            self.failWithInternetConnection()
        }
    }
    
    /*********** CocoiiProgram data call Web Service *******************************************************/
    //MARK: ********* Zoetis API call to get Cocci Program list ****************************************************/
    func callCocoiiProgramService() {
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getCocciProgramResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Cocci Program list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary,
                       let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Cocci Program list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        let cocoiiProgramArray = NSMutableArray()
                        CoreDataHandler().deleteAllData("CocciProgramPostingTurkey")
                        //
                        // Parse each item in the array
                        for item in arr {
                            guard let tempDict = item.dictionaryObject else {
                                print("Invalid item structure in array.")
                                continue
                            }
                            
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["CocciProgramName"] as? String, forKey: "CocciProgramName")
                            dictData.setValue(tempDict["CocciProgramId"] as? Int, forKey: "CocciProgramId")
                            dictData.setValue(tempDict["LanguageId"] as? Int, forKey: "LanguageId")
                            
                            cocoiiProgramArray.add(dictData)
                        }
                        
                        // Fetch existing data from Core Data
                        self.cocoiiProgramArr = CoreDataHandlerTurkey().fetchCocoiiProgramTurkey()
                        
                        // Save data only if there is no existing data
                        if self.cocoiiProgramArr.count == 0 {
                            self.callSaveMethodforCocoiiProgram(cocoiiProgramArray)
                        }
                        
                        // Proceed with the next service call
                        self.callSessionTypeService()
                    } else {
                        // Handle the case when the array is empty
                        print("Cocci Program list is empty.")
                        self.callSessionTypeService()
                    }
                }
                
                
            })
        } else{
            self.failWithInternetConnection()
        }
    }
    
    /*********** SalesRep data call Web Service *******************************************************/
    //MARK: ********* Zoetis API call to get Sales Representatives list ****************************************************/
    func callSalesRepWebService() {
        
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getSalesRepresentativeResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Sales Representatives list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                DispatchQueue.main.async {
                    // Check for an error message in the JSON response
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API: \(errorMessage)")
                        self?.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from the JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Initialize the array to store sales representative data
                        self?.arraSalesRep = NSMutableArray()
                        
                        // Iterate through the array and populate `arraSalesRep`
                        for item in arr {
                            if let tempDict = item.dictionaryObject {
                                let dictDat = NSMutableDictionary()
                                dictDat.setValue(tempDict["SalesRepresentativeName"] as? String, forKey: "SalesRepresentativeName")
                                dictDat.setValue(tempDict["SalesRepresentativeId"] as? Int, forKey: "SalesRepresentativeId")
                                self?.arraSalesRep.add(dictDat)
                            } else {
                                print("Invalid data format in Sales Representative array: \(item)")
                            }
                        }
                        
                        // Delete old Core Data entries and save new data
                        CoreDataHandlerTurkey().deleteAllDataTurkey("SalesrepTurkey")
                        if let salesRepArray = self?.arraSalesRep {
                            self?.callSaveMethodforSalesRep(salesRepArray)
                        }
                        
                        // Proceed to the next step
                        self?.callAddVaccination()
                    } else {
                        // Handle the case where the array is empty or nil
                        print("No data received for Sales Representatives.")
                        self?.callAddVaccination()
                    }
                }
                
            })
            
            
        } else{
            
            self.salesRepArr = CoreDataHandlerTurkey().fetchSalesrepTurkey()
            if(self.salesRepArr.count == 0){
                self.callSaveMethodforSalesRep(self.arraSalesRep)
            }
        }
    }
    /*********** 0 data call Web Service *******************************************************/
    //MARK: ********* Zoetis API call to get Customers list ****************************************************/
    func callCustmerWebService() {
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getCustomerListResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Customers list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        var customerArray: [NSDictionary] = []
                        
                        // Parse each item in the array
                        for item in arr {
                            if let tempDict = item.dictionary {
                                let customerName = tempDict["CustomerName"]?.string ?? "Unknown"
                                let customerId = tempDict["CustomerId"]?.int ?? -1
                                
                                // Create a dictionary for the customer
                                let dictData: NSDictionary = [
                                    "CustomerName": customerName,
                                    "CustomerId": customerId
                                ]
                                
                                customerArray.append(dictData)
                            } else {
                                print("Invalid data format for item: \(item)")
                            }
                        }
                        
                        // Save parsed data and proceed with business logic
                        self.arraCustmer = NSMutableArray(array: customerArray)
                        CoreDataHandlerTurkey().deleteAllDataTurkey("CustmerTurkey")
                        self.callSaveMethodforCustomer(self.arraCustmer)
                        self.complexService()
                    } else {
                        // Handle case when the route list is empty
                        print("Customer's list is empty.")
                        self.complexService()
                    }
                }
            })
        } else{
            
            self.custmorArr = CoreDataHandlerTurkey().fetchCustomerTurkey()
            if(self.custmorArr.count == 0){
                self.callSaveMethodforCustomer(self.arraCustmer)
            }
        }
    }
    
    //MARK: ********* Zoetis API call to get route list ****************************************************/
    
    func callAddVaccination() {
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getRouteResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Route list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        var routeArray: [NSDictionary] = []
                        
                        // Parse each item in the array
                        for item in arr {
                            if let tempDict = item.dictionaryObject {
                                let routeData: NSMutableDictionary = [
                                    "RouteName": tempDict["RouteName"] as? String ?? "",
                                    "RouteId": tempDict["RouteId"] as? Int ?? -1,
                                    "LanguageId": tempDict["LanguageId"] as? Int ?? -1
                                ]
                                routeArray.append(routeData)
                            } else {
                                print("Invalid route data format: \(item)")
                            }
                        }
                        
                        // Fetch existing routes from CoreData
                        self.RouteArray = CoreDataHandlerTurkey().fetchRouteTurkey()
                        
                        // Save new routes if CoreData is empty
                        if self.RouteArray.count == 0 {
                            self.callSaveMethod(routeArray as NSArray)
                        }
                        
                        // Proceed to the next service call
                        self.callCocoiiProgramService()
                    } else {
                        // Handle case when the route list is empty
                        print("Route list is empty.")
                        self.callCocoiiProgramService()
                    }
                }
                
                
                
            })
            
        } else {
            self.failWithInternetConnection()
        }
    }
    
    func allSessionArrChicken() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
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
    //MARK: ********* Zoetis API call to get Hatchery Strain list ****************************************************/
    func callhatcheryStrain() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getTurkeyHatcheryStrainResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Hatchery Strain list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("HatcheryStrain")
                        
                        // Process each item in the array
                        for item in arr {
                            if let strainDict = item.dictionary {
                                // Safely unwrap and parse the keys
                                let strainId = strainDict["StrainId"]?.int ?? -1
                                let strainName = strainDict["StrainName"]?.string ?? "Unknown"
                                let langID = strainDict["LanguageId"]?.int ?? -1
                                
                                // Save the parsed data to Core Data
                                CoreDataHandler().SaveStrainDataDatabase(strainName, StrainId: strainId, lngId: langID)
                            } else {
                                print("Invalid data format for HatcheryStrain: \(item)")
                            }
                        }
                        
                        // Call the next service after processing
                        self.callGetFieldStrain()
                    } else {
                        // Handle the case where the array is empty
                        print("Hatchery strain list is empty.")
                        self.showToastWithTimer(message: "No data available from the server.", duration: 3.0)
                        
                        // Call the next service
                        self.callGetFieldStrain()
                    }
                }
            })
            
        } else{
            self.failWithInternetConnection()
        }
    }
    //MARK: ********* Zoetis API call to get Field Strain list ****************************************************/
    func callGetFieldStrain() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getTurkeyFieldStrainResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Field Strain list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("GetFieldStrain")
                        
                        // Process each item in the array
                        for item in arr {
                            if let strainDict = item.dictionary {
                                // Safely unwrap and parse the keys
                                let strainId = strainDict["StrainId"]?.int ?? -1
                                let strainName = strainDict["StrainName"]?.string ?? "Unknown"
                                let langID = strainDict["LanguageId"]?.int ?? -1
                                
                                // Save the parsed data to Core Data
                                CoreDataHandler().SaveStrainDataDatabaseField(strainName, StrainId: strainId, lngId: langID)
                                
                            } else {
                                print("Invalid data format for Field Strain: \(item)")
                            }
                        }
                        
                        // Call the next service after processing
                        self.callGetDosage()
                    } else {
                        // Handle the case where the array is empty
                        print("Field Strain list is empty.")
                        self.showToastWithTimer(message: "No data available from the server.", duration: 3.0)
                        
                        // Call the next service
                        self.callGetDosage()
                    }
                }
                
            })
            
        } else{
            self.failWithInternetConnection()
        }
    }
    //MARK: ********* Zoetis API call to get Dossage list ****************************************************/
    func callGetDosage() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getDosageResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Dossage list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Route list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("GetDosage")
                        
                        // Process each item in the array
                        for item in arr {
                            if let strainDict = item.dictionary {
                                // Safely unwrap and parse the keys
                                let doseId = strainDict["DoseId"]?.int ?? -1
                                let dosename = strainDict["Dose"]?.string ?? "Unknown"
                                
                                // Save the parsed data to Core Data
                                CoreDataHandler().SaveDosageDataDatabaseField(dosename, doseId: doseId)
                            } else {
                                print("Invalid data format for Get Dosage: \(item)")
                            }
                        }
                        
                        // Call the next service after processing
                        self.getGenerationType()
                    } else {
                        // Handle the case where the array is empty
                        print("Get Dosage list is empty.")
                        self.showToastWithTimer(message: "No data available from the server.", duration: 3.0)
                        
                        // Call the next service
                        self.getGenerationType()
                    }
                }
            })
            
        } else{
            self.failWithInternetConnection()
        }
    }
    //MARK: ********* Zoetis API call to get Generation Type list ****************************************************/
    func getGenerationType() {
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getTurkeyGenerationResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Generation Type list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Generation Type list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("GenerationType")
                        
                        // Process each item in the array
                        for item in arr {
                            if let tempDict = item.dictionary {
                                // Safely parse the "Name" and "Id" fields
                                let generationName = tempDict["Name"]?.string ?? "Unknown"
                                let generationId = tempDict["Id"]?.int ?? -1
                                
                                // Create a dictionary and add it to the genType array
                                let dictData: [String: Any] = [
                                    "generationName": generationName,
                                    "generationId": generationId
                                ]
                                
                                self.genType.add(dictData)
                            } else {
                                print("Invalid data format in array item: \(item)")
                            }
                        }
                        
                        self.callGenerationType(self.genType)
                    } else {
                        // Handle the case where the array is empty
                        self.genType = CoreDataHandler().fetchGenerationType() as! NSMutableArray
                        if(self.genType.count == 0){
                            self.callGenerationType(self.genType)
                        }
                    }
                }
            })
        } else{
            self.failWithInternetConnection()
        }
    }
    
    //MARK: ********* Save Generation type ****************************************************/
    func callGenerationType( _ generationTypArrrr : NSArray) {
        
        for i in 0..<generationTypArrrr.count {
            let genName = (generationTypArrrr.object(at: i) as AnyObject).value(forKey: "generationName") as! String
            let genid = (generationTypArrrr.object(at: i) as AnyObject).value(forKey: "generationId") as! NSNumber
            CoreDataHandler().generationTypeDatabase(genid, generationName: genName, dbArray: genTypeArray, index: i)
        }
        
        self.callGetDosageTurkeyWithMoleculeId()
    }
    
    //MARK: ********* Zoetis API call to get Dossage By Molecule ID ****************************************************/
    func callGetDosageTurkeyWithMoleculeId() {
        
        if WebClass.sharedInstance.connected() {
            
            ZoetisWebServices.shared.getTurkeyDoseByMoleculeIdResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Dossage By Molecule ID list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Route list API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    // Check if the JSON response contains an error message
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API Generation Type list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("GetDosageTurkeyWithMoleculeID")
                        
                        // Process each item in the array
                        for item in arr {
                            if let strainDict = item.dictionary {
                                let doseId = strainDict["DoseId"]?.int ?? -1
                                let dosename = strainDict["Dose"]?.string ?? "Unknown"
                                let moleculeId = strainDict["MoleculeId"]?.int ?? -1
                                CoreDataHandler().SaveTurkeyDosageDataWithMoleculeIDDatabaseField(dosename, doseId: doseId, molecukeId: moleculeId)
                            } else {
                                print("Invalid data format for Get Dosage: \(item)")
                            }
                        }
                        Helper.dismissGlobalHUD(self.view)
                    }
                    
                    else {
                        Helper.dismissGlobalHUD(self.view)
                    }
                }
            })
            
        } else{
            Helper.dismissGlobalHUD(self.view)
            self.failWithInternetConnection()
        }
    }
}

// MARK: - EXTENSION
extension DashViewControllerTurkey :userlistProtocol,userLogOut {
    
    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView, indexValue: String) {
        
        if indexValue == "Log Out" || indexValue == "Cerrar sesión" {
            
            self.ssologoutMethod()
            UserDefaults.standard.removeObject(forKey: "login")
            UserDefaults.standard.set(false, forKey: "newlogin")
            UserDefaults.standard.set(true, forKey: "callDraftApi")
            
            for controller in (self.navigationController?.viewControllers ?? []) as Array {
                if controller.isKind(of: ViewController.self) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
            
            buttonbg.removeFromSuperview()
            customPopView1.removeView(view)
        }
        else{
            
            guard let url = URL(string: "https://mypoultryview360.com") else {
                return
            }
            UIApplication.shared.open(url)
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
    
    func cancelMethod(){
        customPopView1.removeView(view)
    }
    @objc func buttonPressed1() {
        customPopView1.removeView(view)
        buttonbg.removeFromSuperview()
    }
    
    func DoneMethod(_ EmailUsers: String!){
        customPopView1.removeView(view)
    }
    
    func clickHelpPopUp() {
        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg.addTarget(self, action: #selector(DashViewControllerTurkey.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view .addSubview(buttonbg)
        customPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        customPopView1.logoutDelegate = self
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView1)
        customPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 210, y: 60, width: 150, height: 130))
    }
    
    /// COPIED FROM THE BELOW EXTENSION METHOD
    func failWithErrorSyncdata(statusCode:Int){
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        
        if statusCode == 0 {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        }
        else{
            
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
            }
            if lngId == 1000 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("There are problem in data syncing please try again(NA))", comment: ""))
            }
            else if lngId == 3 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
            }
        }
    }
    
    func failWithErrorInternalSyncdata(){
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:" Server error please try again .")
    }
    
    func didFinishApiSyncdata(){
        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data sync has been completed.", comment: ""))
    }
    
    func failWithInternetConnectionSyncdata(){
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
