
//  DashViewController.swift
//  Zoetis -Feathers
//  Created by "" on 11/08/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit
import Charts
import Alamofire
import Reachability
import SystemConfiguration
import CoreData
import SwiftyJSON
import Gigya
import GigyaTfa
import GigyaAuth


class DashViewController: UIViewController,MDRotatingPieChartDataSource,userlistProtocol,userLogOut ,syncApi,SyncApiData {
    
    // MARK: - VARIABLES
    var  postingIdArr = NSMutableArray()
    var lngId = NSInteger()
    
    let dropDown = DropDown()
    typealias CompletionHandler = (_ selectedVal:String) -> Void
    typealias CompletionHandlerWithIndex = (_ selectedVal:String, _ index:Int) -> Void
    
    var customPopView1 :UserListView!
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
    let buttonbg = UIButton ()
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
    let objApiSync = ApiSync()
    let objApiSyncOneSet = SingleSyncData()
    var complexSize = NSMutableArray()
    var arraVetType  = NSMutableArray()
    var getFormArray = NSMutableArray ()
    var arraCustmer = NSMutableArray ()
    var arraSalesRep = NSMutableArray ()
    var prodType = NSMutableArray()
    var prodTypeArray = NSArray()
    /****************** Api Sync ************/
    var strdateTimeStamp = String()
    var datePicker = UIDatePicker()
    var accestoken = String()
    var isSync : Bool = false
    var postingId = Int()
    var feedId = Int()
    var btnTag = Int ()
    var val = NSArray()
    var valnecPos = NSArray()
    var slicesData:Array<DataSet> = Array<DataSet>()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var postingArrWithAllData = NSMutableArray()
    let images  = [UIImage(named: "Poultry_App_1908x802.jpg")!,
                   UIImage(named: "embrex_banner_graphic_1786x432.jpg")!,
                   UIImage(named: "PoulvacEcoli_banner_graphic_1908x802.jpg")!,
                   UIImage(named: "PoulvacIB_banner_graphic_1908x802.jpg")!,
                   UIImage(named: "Rotecc_banner_graphic_1908x802.jpg")!]
    var index = 0
    let animationDuration: TimeInterval = 0.75
    let switchingInterval: TimeInterval = 5
    var langArray: [String] = []
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var syncBackImageView: UIImageView!
    @IBOutlet weak var syncCountLbl: UILabel!
    @IBOutlet weak var openExixtingLbl: UILabel!
    @IBOutlet weak var dataAvailbleForSync: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var uinLinkedBadgeLabel: UILabel!
    @IBOutlet weak var sessionBadgeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var PostingSessionButton: UIButton!
    @IBOutlet weak var ActiveSessionButton: UIButton!
    @IBOutlet weak var PostingSessionHistroyButton: UIButton!
    @IBOutlet weak var ReportsButton: UIButton!
    @IBOutlet weak var trainingEductionLbl: UILabel!
    @IBOutlet weak var btnSelectLanguage: UIButton!
    @IBOutlet weak var startSessionButton: UIButton!
    @IBOutlet weak var unlinkedSessionButton: UIButton!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var piChartView: BarChartView!
    @IBOutlet weak var barChartViewView: BarChartView!
    @IBOutlet weak var syncCount: UILabel!
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return Session(configuration: configuration)
    }()

    // MARK: - CLASS DECLERATION
    class DataSet {
        var value:CGFloat
        var color:UIColor = UIColor.gray
        var label:String = ""
        
        init(myValue:CGFloat, myColor:UIColor, myLabel:String) {
            value = myValue
            color = myColor
            label = myLabel
        }
    }
    
    @objc func methodOfReceivedNotification(notification: Notification){
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    // MARK: 🟠 - VIEW LIFE CYCLE
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 1 {
            self.trainingEductionLbl.frame = CGRect(x: 303, y: 128, width: 130, height: 60)
            openExixtingLbl.text =  "Open Existing Session"
            
        }else if lngId == 3 {
            self.trainingEductionLbl.frame = CGRect(x: 303, y: 120, width: 130, height: 60)
            openExixtingLbl.text = "Abrir Sessão Existente"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(DashViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        UserDefaults.standard.set(true, forKey: "chickenSyncStatus")
        UserDefaults.standard.set(1, forKey: "birdTypeId")
        self.printSyncLblCountTurkey()
        UserDefaults.standard.set(false, forKey: "TurkeyBird")
        
        if UserDefaults.standard.integer(forKey: "Role") == 0 {
            PostingSessionButton.isUserInteractionEnabled = false
            ActiveSessionButton.isUserInteractionEnabled = false
            ReportsButton.isUserInteractionEnabled = false
            startSessionButton.isUserInteractionEnabled = false
            unlinkedSessionButton.isUserInteractionEnabled = false
            syncButton.isUserInteractionEnabled = false
        } else {
            ActiveSessionButton.isUserInteractionEnabled = true
            ReportsButton.isUserInteractionEnabled = true
            PostingSessionButton.isUserInteractionEnabled = true
            startSessionButton.isUserInteractionEnabled = true
            unlinkedSessionButton.isUserInteractionEnabled = true
            syncButton.isUserInteractionEnabled = true
        }
        objApiSync.delegeteSyncApi = self
        objApiSyncOneSet.delegeteSyncApiData = self
        UserDefaults.standard.set(false, forKey: "Unlinked")
        UserDefaults.standard.set(false, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        appDelegate.sendFeedVariable = ""
        btnTag = 0
        bannerImageView.startAnimating()
        animateImageView()
        
        let custArr = CoreDataHandler().fetchCustomer()
        if(custArr.count == 0){
            callWebService()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UserDefaults.standard.set(false, forKey: "Unlinked")
        UserDefaults.standard.set(false, forKey: "backFromStep1")
        UserDefaults.standard.synchronize()
        let sync =  UserDefaults.standard.bool(forKey: "promt")
        
        uinLinkedBadgeLabel.text =  String(valnecPos.count  ) // + val.count
        self.printSyncLblCount()
        if sync == true && self.allSessionArr().count > 0{
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(callPrmpApi), userInfo: nil, repeats: false)
        }
        if sync == false || self.allSessionArr().count == 0 {
            Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(iSfarmSync), userInfo: nil, repeats: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierLeftMenu"), object: nil)
        let totalExustingArr = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        for i in 0..<totalExustingArr.count{
            let postingSession : PostingSession = totalExustingArr.object(at: i) as! PostingSession
            let pid = postingSession.postingId
            let feedProgram =  CoreDataHandler().FetchFeedProgram(pid!)
            if feedProgram.count == 0{
                CoreDataHandler().updatePostingSessionOndashBoard(pid!, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
                CoreDataHandler().deletefieldVACDataWithPostingId(pid!)
                CoreDataHandler().deleteDataWithPostingIdHatchery(pid!)
            }
        }
        UserDefaults.standard.set(1, forKey: "LastScreenRef")
        UserDefaults.standard.set(true, forKey: "nec")
        UserDefaults.standard.set(true, forKey: "timeStampTrue")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        UserDefaults.standard.set(1, forKey: "sessionId")
        UserDefaults.standard.set(0, forKey: "isBackWithoutFedd")
        UserDefaults.standard.removeObject(forKey: "count")
        UserDefaults.standard.synchronize()
        
        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        val = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(0, birdTypeId: 0) as NSArray
        for i in 0..<val.count{
            let posting : PostingSession = val.object(at: i) as! PostingSession
            let pidSession = posting.postingId
            let feedProgram =  CoreDataHandler().FetchFeedProgram(pidSession!)
            if feedProgram.count == 0{
                CoreDataHandler().deleteDataWithPostingId(pidSession!)
                CoreDataHandler().deletefieldVACDataWithPostingId(pidSession!)
                CoreDataHandler().deleteDataWithPostingIdHatchery(pidSession!)
            }
        }
        
        self.NecropsiesPostingSess =  CoreDataHandler().FetchNecropsystep1UpdateFromUnlinked(0).mutableCopy() as! NSMutableArray
        valnecPos  = CoreDataHandler().fetchAllPostingSessionWithVetId(_VetName: "") as NSArray
        let arr = NSMutableArray()
        
        for i in 0..<totalExustingArr.count {
            
            let posting : PostingSession = totalExustingArr.object(at: i) as! PostingSession
            let finializeB = posting.finalizeExit as! Int
            
            if finializeB == 0 {
                arr.add(posting)
            }
        }
        
        sessionBadgeLabel.text = String(arr.count + valnecPos.count ) // + val.count
        uinLinkedBadgeLabel.text =  String(valnecPos.count  ) // + val.count
        self.printSyncLblCount()
    }
    
    
    // MARK: 🟠 - New POsting Session  Button Action
    @IBAction func PostingSessionButtonPress(_ sender: AnyObject) {
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
        Constants.isForUnlinkedChicken = false
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    // MARK: 🟠 - Existing Posting Session Button Action
    @IBAction func ActiveSessionButtonPress(_ sender: AnyObject) {
        Constants.isForUnlinkedChicken = false
        UserDefaults.standard.set(true, forKey: "postingSession")
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "Existing") as? ExistingPostingSessionViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    // MARK: 🟠 - Tranning & Certification Button Action
    @IBAction func PostingSessionHistoryButtonPress(_ sender: AnyObject) {
        Constants.isForUnlinkedChicken = false
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "TrainingNew") as? TrainingViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    // MARK: 🟠 - Reports Button Action
    @IBAction func ReportsButtonPress(_ sender: AnyObject) {
        Constants.isForUnlinkedChicken = false
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "Report") as? Report_MainVCViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    /**************************************************************************************************************/
    
    @IBAction func didSelectOnUnlinkedNecrp(_ sender: AnyObject) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    @IBAction func NacropsyButtonPress(_ sender: AnyObject) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    // MARK: 🟠 - Logout Button Action
    @IBAction func logOutButtonAction(_ sender: AnyObject) {
        clickHelpPopUp()
    }
    
    // MARK: 🟠 - METHODS AND FUNCTIONS
    func printSyncLblCountTurkey() {
        syncCountLbl.text = String(self.allSessionArrTurkey().count)
        
        if syncCountLbl.text == String(0) {
            syncCountLbl.isHidden = true
            dataAvailbleForSync.isHidden = true
            syncBackImageView.isHidden = true
        }
        else {
            
            dataAvailbleForSync.isHidden = false
            syncBackImageView.isHidden = false
            syncCountLbl.isHidden = false
        }
    }
    // MARK: 🟠 - Get all Session array for Turkey.
    func allSessionArrTurkey() ->NSMutableArray{
        
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
    
    // MARK: 🟠 - function for Sync Prompt
    @objc func callPrmpApi()  {
        self.promtSyncing()
    }
    
    // MARK: 🟠 - Unlinked Sessions
    @IBAction func didSelectOnSeesion(_ sender: AnyObject) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "unlinkSessionSecond") as? UnlinkNecrpoSecondViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }
    
    // MARK: 🟠 - Language Button Action
    @IBAction func ActionSelectLanguage(_ sender: UIButton) {
        self.dropDownVIewNew(arrayData: langArray, kWidth: btnSelectLanguage.frame.width, kAnchor: btnSelectLanguage, yheight: btnSelectLanguage.bounds.height) { [unowned self] selectedVal, index  in
            btnSelectLanguage.setTitle(selectedVal, for: .normal)
            
            if selectedVal == "English(Default)" {
                UserDefaults.standard.set(1, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "en")
                UserDefaults.standard.synchronize()
            }
            else if selectedVal == "Spanish" {
                UserDefaults.standard.set(3, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "fr")
                UserDefaults.standard.synchronize()
            }
            else {
                UserDefaults.standard.set(3, forKey: "lngId")
                LanguageUtility.setAppleLAnguageTo(lang: "fr")
                UserDefaults.standard.synchronize()
            }
            self.loadView()
            self.viewWillAppear(true)
            self.viewDidLoad()
            self.viewDidAppear(true)
        }
        self.dropHiddenAndShow()
        
    }
    
    // MARK: 🟠 - Load Drop down
    func dropDownVIewNew(arrayData:[String], kWidth:CGFloat,kAnchor:UIView,yheight:CGFloat,completionHandler:@escaping CompletionHandlerWithIndex){
        dropDown.dataSource = arrayData as [AnyObject];
        dropDown.width = kWidth
        dropDown.anchorView = kAnchor
        dropDown.bottomOffset = CGPoint(x: 0, y:yheight+1)
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.dropDown.deselectRowAtIndexPath(index)
            completionHandler(item, index);
        }
    }
    
    // MARK: 🟠 DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
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
    
    // MARK: 🟠 Check for unlinked farm to feed program
    @objc func iSfarmSync(){
        let totalExustingArr = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        var isFarmSync = Bool()
        for i in 0..<totalExustingArr.count{
            let postingSession : PostingSession = totalExustingArr.object(at: i) as! PostingSession
            let pid = postingSession.postingId
            let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(pid!)
            if farms.count > 0 {
                CoreDataHandler().updatedPostigSessionwithIsFarmSyncPostingId(pid!, isFarmSync: true)
                if isFarmSync == false{
                    
                    if lngId == 1 {
                        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr: NSLocalizedString("You have unlinked farm(s) to your feed in posting session. Visit '' Open Existing Session '' to link farm(s) to feed program.", comment: ""))
                        isFarmSync = true
                        
                    } else if lngId == 3 {
                        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr: NSLocalizedString("Vous avez dissocié la/les ferme(s) de votre aliment en affichant. La visite '' Ouvrir la séance existante '' pour associer la ferme(s) au programme alimentaire.", comment: ""))
                        isFarmSync = true
                    }
                }
            }
        }
    }
    // MARK: 🟠 - Sync Count
    func printSyncLblCount()
    {
        syncCount.text = String(self.allSessionArr().count)
    }
    
    // MARK: 🟠 - Toast view with timmer.
    func showToastWithTimer(message : String, duration: TimeInterval ) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-100, width: 250, height: 100))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "HelveticaNeue-Light", size: 11.0) //UIFont(name: "Montserrat-Light", size: 14.0)
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
    
    // MARK: 🟠Datasource & Delegate of Pie Chart ************************//
    
    func colorForSliceAtIndex(_ index:Int) -> UIColor {
        return slicesData[index].color
    }
    
    func valueForSliceAtIndex(_ index:Int) -> CGFloat {
        return slicesData[index].value
    }
    
    func labelForSliceAtIndex(_ index:Int) -> String {
        return slicesData[index].label
    }
    
    func numberOfSlices() -> Int {
        return slicesData.count
    }
    /**************************************************************************/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: 🟠 Side Menu Button action
    @IBAction func sideMenuButtonPress(_ sender: AnyObject) {
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
    }
    // MARK: 🟢  Call Web Services to get Observation's List
    func callWebService() {
        if WebClass.sharedInstance.connected() {
            Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Loading...", comment: ""))
            let keychainHelper = AccessTokenHelper()
            accestoken = keychainHelper.getFromKeychain(keyed: "aceesTokentype") ?? ""
           // accestoken = UserDefaults.standard.string(forKey: "aceesTokentype") ?? ""
            let headers: HTTPHeaders = [
                "Authorization": accestoken,
                "Cache-Control": "no-store, no-cache, must-revalidate, private"
            ]
            let Id = UserDefaults.standard.integer(forKey: "Id")
            let countryId = UserDefaults.standard.integer(forKey: "countryId")
            let Url = WebClass.sharedInstance.webUrl + "Setting/GetNecroCategoryObservationList?UserId=\(Id)&CountryId=\(countryId)"
            
            let urlString = URL(string: Url)
            sessionManager.request(urlString!, method: .get, headers: headers).responseJSON { response in
                
                guard let statusCode = response.response?.statusCode else {
                    print("Failed to get status code")
                    Helper.dismissGlobalHUD(self.view)
                    return
                }

                if statusCode == 401 {
                    self.loginMethod()
                } else if (400...404).contains(statusCode) || (500...504).contains(statusCode) {
                    let alertController = UIAlertController(title: "", message:NSLocalizedString("Unable to get data from server. \n(\(String(describing: statusCode)))", comment: "") , preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default) {
                        (result : UIAlertAction) -> Void in
                        Helper.dismissGlobalHUD(self.view)
                        self.callWebService()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {/// HTTP Status code - 200
                    switch response.result {
                    case let .success(JSON):
                        if (JSON is NSArray)
                        {
                            self.dataArray.removeAllObjects()
                            self.appDelegate.globalDataArr.removeAllObjects()
                            let arr : NSArray = JSON as! NSArray
                            for  i in 0..<arr.count {
                                let tempDict = arr.object(at: i) as AnyObject
                                let ObJServiceHolder = ServiceDataHolder()
                                ObJServiceHolder.CategoryDescp = (tempDict as! NSDictionary).value(forKey:"CategoryDescription") as!  NSString
                                ObJServiceHolder.CataID = (tempDict as! NSDictionary).value(forKey:"CategoryId") as! NSInteger
                                ObJServiceHolder.ObservaionDetailsArr = ((tempDict as! NSDictionary).value(forKey: "ObservaionDetails") as! NSArray).mutableCopy() as! NSMutableArray
                                self.dataArray.add(ObJServiceHolder)
                            }
                            
                            self.appDelegate.globalDataArr = self.dataArray
                            self.skelta(0)
                            self.cocoii(1)
                            self.gitract(2)
                            self.res(3)
                            self.immu(4)
                            
                            self.callCustmerWebService()
                        }
                        else{
                            self.callCustmerWebService()
                        }
                        break
                    case let .failure(error):
                        debugPrint(error.localizedDescription)
                        //completion(nil, error as NSError)
                        break
                    }
                }
            }
        }
        
        else{
            self.appDelegate.globalDataArr = self.dataArray
            self.skelta(0)
            self.cocoii(1)
            self.gitract(2)
            self.res(3)
            self.immu(4)
            self.callCustmerWebService()
        }
    }
    
    // MARK: 🟠 Skeletan Info
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
    
    // MARK: 🟠 Coccidiosis
    func cocoii (_ tag: Int) {
        
        btnTag = 1
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        dataCocoiiArray = CoreDataHandler().fetchAllCocoiiData()
        if dataCocoiiArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataCocoiiArray = CoreDataHandler().fetchAllCocoiiData()
        }
    }
    
    // MARK: 🟠 Skeletan
    func skelta (_ tag: Int) {
        btnTag = 0
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataSkeletaArray = CoreDataHandler().fetchAllSeettingdata()
        if dataSkeletaArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataSkeletaArray = CoreDataHandler().fetchAllSeettingdata()
        }
    }
    
    // MARK: 🟠 GiTract
    func gitract (_ tag: Int) {
        
        btnTag = 2
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataGiTractArray = CoreDataHandler().fetchAllGITractData()
        if dataGiTractArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataGiTractArray = CoreDataHandler().fetchAllGITractData()
        }
    }
    
    // MARK: 🟠 Respiratory
    func res (_ tag: Int) {
        btnTag = 3
        
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataRespiratoryArray = CoreDataHandler().fetchAllRespiratory()
        if dataRespiratoryArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataRespiratoryArray = CoreDataHandler().fetchAllRespiratory()
        }
    }
    
    
    // MARK: 🟠 Immune
    func immu (_ tag: Int) {
        btnTag = 4
        
        if WebClass.sharedInstance.connected() || dataArray.count > 0{
            var _temp = ServiceDataHolder()
            _temp = self.dataArray.object(at: btnTag) as! ServiceDataHolder
            serviceDataHldArr = _temp.ObservaionDetailsArr
        }
        
        dataImmuneArray = CoreDataHandler().fetchAllImmune()
        if dataImmuneArray.count == 0 {
            self.callSaveMethod1(serviceDataHldArr)
            dataImmuneArray = CoreDataHandler().fetchAllImmune()
        }
    }
    
    
    // MARK: 🟠 Save Session details in Local Database
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
            }
            else if visibilityCheck == false {
                isQuicklinksCheck = false
            }
            if visibilitySwitch == true {
                isVisibilityCheck = true
            }
            else{
                isVisibilityCheck = false
            }
            
            if  btnTag == 0 {
                CoreDataHandler().saveSettingsSkeletaInDatabase(strObservationField,visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataSkeletaArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId:refId, quicklinkIndex: quickLinkIndex ?? 0 )
            }
            else if btnTag == 1{
                CoreDataHandler().saveSettingsCocoiiInDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataCocoiiArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
            }
            else if btnTag == 2{
                CoreDataHandler().saveSettingsGITractDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataGiTractArray,obsId:obsId,measure:measure,isSync: false,lngId:lngIdValue,refId:refId,quicklinkIndex: quickLinkIndex ?? 0)
            }
            else if btnTag == 3{
                CoreDataHandler().saveSettingsRespiratoryDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataRespiratoryArray,obsId:obsId,measure:measure,isSync:false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
            }
            else{
                CoreDataHandler().saveSettingsImmuneDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataImmuneArray,obsId:obsId,measure:measure,isSync:false,lngId:lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex ?? 0)
            }
        }
    }
    // MARK: 🟢 Get Route's Name & ID
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
                       // var routeArray: [NSDictionary] = []
                        let arraRoute = NSMutableArray ()
                        // Parse each item in the array
                        for item in arr {
                            if let tempDict = item.dictionaryObject {
                                 let routeData = NSMutableDictionary()
                                 routeData.setValue(tempDict["RouteName"] as? String ?? "", forKey: "RouteName")
                                 routeData.setValue(tempDict["RouteId"] as? Int ?? -1, forKey: "RouteId")
                                 routeData.setValue(tempDict["LanguageId"] as? Int ?? -1, forKey: "LanguageId")
                                 
                                 arraRoute.add(routeData) // ✅ Use add() on NSMutableArray
                             } else {
                                 print("Invalid route data format: \(item)")
                             }
                         }
                        
                        // Fetch existing routes from CoreData
                        self.RouteArray = CoreDataHandler().fetchRoute()
                        
                        // Save new routes if CoreData is empty
                        if self.RouteArray.count == 0 {
                            self.callSaveMethod(arraRoute)
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
 
        } else{
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟠 Save Route Name & ID
    func callSaveMethod( _ routeArr : NSArray) {
        
        for i in 0..<routeArr.count {
            let routeId = (routeArr.object(at: i) as AnyObject).value(forKey: "RouteId") as! Int
            let lngId = (routeArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            let routeName = (routeArr.object(at: i) as AnyObject).value(forKey: "RouteName") as! String
            CoreDataHandler().saveRouteDatabase(routeId, routeName: routeName,lngId:lngId, dbArray: self.RouteArray, index: i)
        }
    }
    // MARK: 🟢 Get Customer's List
    
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
                        
                        CoreDataHandler().deleteAllData("Custmer")
                        self.callSaveMethodforCustomer(customerArray as NSArray)
                        self.complexService()
                    } else {
                        // Handle case when the route list is empty
                        print("Customer's list is empty.")
                        self.complexService()
                    }
                }
            })
        } else{
            
            self.custmorArr = CoreDataHandler().fetchCustomer()
            if(self.custmorArr.count == 0){
                self.callSaveMethodforCustomer(self.arraCustmer)
            }
        }
    }
    
    // MARK: 🟠 Save Customer's name
    func callSaveMethodforCustomer( _ custmorArr : NSArray) {
        
        for i in 0..<custmorArr.count {
            let CustId = (custmorArr.object(at: i) as AnyObject).value(forKey: "CustomerId") as! Int
            let CustName = (custmorArr.object(at: i) as AnyObject).value(forKey: "CustomerName") as! String
            CoreDataHandler().saveCustmerDatabase(CustId, CustName: CustName, dbArray: self.custmorArr, index: i)
        }
    }
    
    // MARK: 🟢 SalesRep data call Web Service *******************************************************/
    
    func callSalesRepWebService() {
        
        if WebClass.sharedInstance.connected() {

                ZoetisWebServices.shared.getSalesRepresentativeResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                    guard let _ = self, error == nil else {
                        self?.showToastWithTimer(message: "Failed to get Sales Representatives list", duration: 3.0)
                        self?.dismissGlobalHUD(self?.view ?? UIView())
                        return
                    }
                    
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        // Check for an error message in the JSON response
                        if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                            print("Error from API: \(errorMessage)")
                            self.showToastWithTimer(message: errorMessage, duration: 3.0)
                            return
                        }
                        
                        // Parse the array from the JSON response
                        if let arr = JSON(json).array, !arr.isEmpty {
                            // Initialize the array to store sales representative data
                            self.arraSalesRep = NSMutableArray()
                            
                            // Iterate through the array and populate `arraSalesRep`
                            for item in arr {
                                if let tempDict = item.dictionaryObject {
                                    let dictDat = NSMutableDictionary()
                                    dictDat.setValue(tempDict["SalesRepresentativeName"] as? String, forKey: "SalesRepresentativeName")
                                    dictDat.setValue(tempDict["SalesRepresentativeId"] as? Int, forKey: "SalesRepresentativeId")
                                    self.arraSalesRep.add(dictDat)
                                } else {
                                    print("Invalid data format in Sales Representative array: \(item)")
                                }
                            }
                            
                            CoreDataHandler().deleteAllData("Salesrep")
                            self.callSaveMethodforSalesRep(self.arraSalesRep)
                            self.callAddVaccination()
                        } else {
                            // Handle the case where the array is empty or nil
                            print("No data received for Sales Representatives.")
                            self.callAddVaccination()
                        }
                    }
                    
                })

        } else{
            
            self.salesRepArr = CoreDataHandler().fetchSalesrep()
            if(self.salesRepArr.count == 0){
                self.callSaveMethodforSalesRep(self.arraSalesRep)
            }
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟠 Save Sale's representative
    func callSaveMethodforSalesRep( _ SalesRepArr : NSArray) {
        
        for i in 0..<SalesRepArr.count {
            let SalesId = (SalesRepArr.object(at: i) as AnyObject).value(forKey: "SalesRepresentativeId") as? Int
            let SalesNameName = (SalesRepArr.object(at: i) as AnyObject).value(forKey: "SalesRepresentativeName") as? String
            CoreDataHandler().SalesRepDataDatabase(SalesId, salesRepName: SalesNameName, dbArray: self.salesRepArr, index: i)
        }
    }
    
    // MARK: 🟢********* CocoiiProgram data call Web Service *******************************************************/
    
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
                        CoreDataHandler().deleteAllData("CocciProgramPosting")
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
                        self.cocoiiProgramArr = CoreDataHandler().fetchCocoiiProgram()
                        
                        if(self.cocoiiProgramArr.count == 0){
                            self.callSaveMethodforCocoiiProgram(cocoiiProgramArray)
                        }
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
    // MARK: 🟠 Save Coccidiosis Program
    func callSaveMethodforCocoiiProgram( _ cocoiArr : NSArray) {
        
        for i in 0..<cocoiArr.count {
            let cocoiiId = (cocoiArr.object(at: i) as AnyObject).value(forKey: "CocciProgramId") as! Int
            let lngId = (cocoiArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            let cocoiiIdName = (cocoiArr.object(at: i) as AnyObject).value(forKey: "CocciProgramName") as! String
            CoreDataHandler().CocoiiProgramDatabase(cocoiiId, cocoiProgram: cocoiiIdName,lngId:lngId,dbArray: self.cocoiiProgramArr, index: i)
        }
    }
    // MARK: 🟢 Get Session's Type
    
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
                        
                        CoreDataHandler().deleteAllData("Sessiontype")
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
                        
                        self.sessiontypeArr = CoreDataHandler().fetchSessiontype()
                        if(self.cocoiiProgramArr.count == 0){
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

        } else{
            self.failWithInternetConnection()
        }
    }
    // MARK: 🟠 Save Session type
    func callSaveMethodforSessiontype( _ seessionTypeArr : NSArray) {
        
        for i in 0..<seessionTypeArr.count {
            let SessionId = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "SessionTypeId") as! Int
            let sessionName = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "SessionTypeName") as! String
            let lngId = (seessionTypeArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            CoreDataHandler().SessionTypeDatabase(SessionId, sesionType: sessionName, lngId: lngId as NSNumber, dbArray: self.sessiontypeArr, index: i)
        }
    }
    
    // MARK: 🟢******** BirdSize data call Web Service *******************************************************/
    
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
                        CoreDataHandler().deleteAllData("BirdSizePosting")
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
                        
                        self.birdSizeArr = CoreDataHandler().fetchBirdSize()
                        if(self.birdSizeArr.count == 0){
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
            print("test message")
        }
    }
    // MARK: 🟠 Save Bird Size
    func callSaveMethodforBirdSize( _ birdSizeTypeArr : NSArray) {
        
        for i in 0..<birdSizeTypeArr.count {
            let birdSizeId = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "BirdSizeId") as! Int
            let birdSizeName = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "BirdSize") as! String
            let birdtype = (birdSizeTypeArr.object(at: i) as AnyObject).value(forKey: "ScaleType") as! String
            CoreDataHandler().BirdSizeDatabase(birdSizeId, birdSize: birdSizeName, scaleType: birdtype, dbArray: self.birdSizeArr, index: i)
        }
    }
    // MARK: 🟢******** Breed type data call Web Service *******************************************************/
    
    func callBreedService() {
        
        if WebClass.sharedInstance.connected() {
 
            ZoetisWebServices.shared.getBirdBreedChickenAndTurkeyResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Bird Size list", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    return
                }
                
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
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
                                dictData.setValue(tempDict["LanguageId"] as? Int, forKey: "LanguageId")
                                arraBreedType.add(dictData)
                            } else {
                                print("Invalid data format in array: \(item)")
                            }
                        }
                        self.breedArr = CoreDataHandler().fetchBreedType()
                        
                        if(self.breedArr.count == 0){
                            self.callSaveMethodforBreedType(arraBreedType)
                        }
                        self.FeedProgramMoleculeService()
                    } else {
                        // Handle the case where the array is empty or nil
                        print("No data received from the API.")
                        self.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                    }
                }
                
            })
            
        } else{
            print("test message")
        }
    }
    // MARK: 🟠 Save Breed type
    func callSaveMethodforBreedType( _ breedTypeArr : NSArray) {
        
        for i in 0..<breedTypeArr.count {
            let breeId = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedId") as! Int
            let breedName = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedName") as! String
            let breedType = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "BirdBreedType") as! String
            let languageId = (breedTypeArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! Int
            CoreDataHandler().BreedTypeDatabase(breeId, breedType: breedType, breedName: breedName, lngId: languageId, dbArray: self.breedArr, index: i)
        }
    }
    // MARK: 🟠 Load Custome Popup
    func clickHelpPopUp() {
        
        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonbg.addTarget(self, action: #selector(DashViewController.buttonPressed1), for: .touchUpInside)
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
    // MARK: 🟠 Dismiss Popup
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
    // MARK: 🟠 Side Menu Button Action
    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView ,indexValue : String){
        
        if indexValue == "Log Out" || indexValue == "Cerrar sesión" || indexValue == "Déconnexion" || indexValue == "Sair"
        {
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
            // https://mypoultryview360.com/
        }
    }
    
    // MARK: 🟠  /*********** Logout SSO Account **************/
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
    
    
    // MARK: 🟢 Get feed Program & Molecule Service
    
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
    /*
    func FeedProgramMoleculeService() {
        
        if WebClass.sharedInstance.connected() {
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict: HTTPHeaders = [
                "Authorization": accestoken,
                "Cache-Control": "no-store, no-cache, must-revalidate, private"
            ]
            
            let Url = WebClass.sharedInstance.webUrl + "PostingSession/GetFeedProgramCatagoryAndMoleculeDetails"
            let urlString = URL(string: Url)
            
           
            sessionManager.request(urlString!, method: .get, headers: headerDict).responseJSON { response in
                switch response.result {
                case let .success(value):
                    
                    if (value is NSArray)
                    {
                        let arr : NSArray = value as! NSArray
                        for  i in 0..<arr.count {
                            let _tempDict = arr.object(at: i) as AnyObject
                            
                            _tempDict.value(forKey: "FeedProgramCategoryDescription") as! String
                            _tempDict.value(forKey: "FeedProgramCategoryId") as! Int
                            self.FeedProgramArray.add(_tempDict)
                        }
                        UserDefaults.standard.set(self.FeedProgramArray, forKey: "Molucule")
                        
                        self.callGetCocciVaccine()
                    }
                    else{
                        self.callGetCocciVaccine()
                    }
                    break
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    break
                }
            }
        } else{
            print("test message")
        }
    }
    */
    // MARK: 🟢 Get Cocci Vaccine List
    func callGetCocciVaccine() {
        if WebClass.sharedInstance.connected() {
            ZoetisWebServices.shared.getCocciVaccineTurkeyResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
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
                        print("Error from API Cocci Vaccine list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }

                    // Parse the array from JSON response
                    guard let arr = JSON(json).array, !arr.isEmpty else {
                        self.callTargetWeightProcessing()
                        return
                    }

                    // Delete existing data
                    CoreDataHandler().deleteAllData("CocoiVaccine")

                    // Process data safely
                    let cocciProgramArray = NSMutableArray()
                    
                    for item in arr {
                        guard let tempDict = item.dictionary else {
                            print("Invalid data format in array: \(item)")
                            continue
                        }
                        
                        if let CocciVaccineId = tempDict["CocciVaccineId"]?.int,
                           let CocciVaccineName = tempDict["CocciVaccineName"]?.string,
                           let LanguageId = tempDict["LanguageId"]?.int {
                            CoreDataHandler().saveCocoiiVac(CocciVaccineId, decscMolecule: CocciVaccineName, lngId: LanguageId)
                        } else {
                            print("Missing required fields in JSON item: \(tempDict)")
                        }
                    }
                    
                    // Store data in UserDefaults
                    UserDefaults.standard.set(self.cocciVaccine, forKey: "cocci")
                    
                    // Proceed with next API call
                    self.callTargetWeightProcessing()
                }

         })
        
        } else{
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟢 Get Target Weight Processing List
    func callTargetWeightProcessing() {
        if WebClass.sharedInstance.connected() {
  
            ZoetisWebServices.shared.getTargetWeightResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Target Weight Processing List", duration: 3.0)
                    self?.dismissGlobalHUD(self?.view ?? UIView())
                    
                    return
                }
                
                let jsonResponse = JSON(json)
                // Check for the "errorResult" key and handle errors
                if let errorResult = jsonResponse["errorResult"].dictionary {
                    let errorMsg = errorResult["errorMsg"]?.string ?? "Unknown error"
                    let errorCode = errorResult["errorCode"]?.string ?? "Unknown code"
                    
                    print("Error from get Target Weight Processing List API : \(errorMsg) (Code: \(errorCode))")
                    if errorCode == "401" || errorCode == "404"{
                        self!.loginMethod()
                    }
                }
                
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                        print("Error from API: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    if let dataArray = JSON(json).array, !dataArray.isEmpty {
                        self.targetWeight = NSMutableArray()

                           for item in dataArray {
                               guard let dictionary = item.dictionaryObject else {
                                   print("Invalid data format in array: \(item)")
                                   continue
                               }
                               self.targetWeight.add(dictionary)
                           }

                           // Store in UserDefaults
                        UserDefaults.standard.set(self.targetWeight, forKey: "target")

                           // Assign to instance variable
                        self.targetWeight = self.targetWeight

                           // Proceed to next API call
                           self.getListFarms()
                       } else {
                           // Handle empty response
                           print("No data received from the API.")
                           self.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                           self.getListFarms()
                       }
                }

                
            })

        } else{
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟢 Get Complex's List  ✅  Zoetis Call
    func complexService() {
        if WebClass.sharedInstance.connected() {
        
                ZoetisWebServices.shared.getChickenTurkeyComplexByUserIdResponce(controller: self, parameters: ["UserId" :"UserId"], completion: { [weak self] (json, error) in
                    guard let _ = self, error == nil else {
                        self?.showToastWithTimer(message: "Failed to get Complex list", duration: 3.0)
                        self?.dismissGlobalHUD(self?.view ?? UIView())
                        return
                    }
                    
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        if let jsonDict = JSON(json).dictionary, let errorMessage = jsonDict["Message"]?.string {
                            print("Error from API: \(errorMessage)")
                            self.showToastWithTimer(message: errorMessage, duration: 3.0)
                            return
                        }
                        
                        // Check if the response contains an array
                        if let arr = JSON(json).array, !arr.isEmpty {
                            // Delete old data and save new data
                            CoreDataHandler().deleteAllData("ComplexPosting")
                            self.complexSize = NSMutableArray()
                            
                            // Parse the array and populate `complexSize`
                            for item in arr {
                                if let tempDict = item.dictionaryObject {
                                    let dictData = NSMutableDictionary()
                                    dictData.setValue(tempDict["CustomerId"] as? Int, forKey: "CustomerId")
                                    dictData.setValue(tempDict["ComplexName"] as? String, forKey: "ComplexName")
                                    dictData.setValue(tempDict["ComplexId"] as? Int, forKey: "ComplexId")
                                    self.complexSize.add(dictData)
                                } else {
                                    print("Invalid data format in array: \(item)")
                                }
                            }
                           
                            self.callcomplexService(self.complexSize)
                            self.callSalesRepWebService()
                            
                        } else {
                            // Handle the case where the array is empty or nil
                            print("No data received from the API.")
                            self.showToastWithTimer(message: "No data received from the server.", duration: 3.0)
                            self.callSalesRepWebService()
                        }
                    }
                })
 
        } else{
            self.complexArr = CoreDataHandler().fetchCompexType()
            if(self.complexArr.count == 0){
                self.callcomplexService(self.complexSize)
            }
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟠 Save Complex Name
    func callcomplexService( _ complexArrrr : NSArray) {
        
        for i in 0..<complexArrrr.count {
            let custmerId = (complexArrrr.object(at: i) as AnyObject).value(forKey: "CustomerId") as! NSNumber
            let custmerName = (complexArrrr.object(at: i) as AnyObject).value(forKey: "ComplexName") as! String
            let complexid = (complexArrrr.object(at: i) as AnyObject).value(forKey: "ComplexId") as! NSNumber
            CoreDataHandler().ComplexDatabase(complexid, cutmerid: custmerId, complexName: custmerName, dbArray: complexArr, index: i)
        }
    }
    // MARK: 🟢 Get Veterinarian List from server
    func callVeterianService() {
        
        if WebClass.sharedInstance.connected() {
       
            ZoetisWebServices.shared.getVeterinarianResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
                guard let _ = self, error == nil else {
                    self?.showToastWithTimer(message: "Failed to get Veterinarian List list", duration: 3.0)
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
                        print("Error from API Veterinarian List list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        self.arraVetType = NSMutableArray()
                        CoreDataHandler().deleteAllData("Veteration")
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
                        print("Veterinarian Listt is empty.")
                        self.callhatcheryStrain()
                    }
                }
                
            })
            
        } else{
            
            self.veterianArr = CoreDataHandler().fetchVetData()
            if(self.veterianArr.count == 0){
                self.callSaveMethodforeterian(self.arraVetType)
            }
            self.failWithInternetConnection()
            
        }
    }
    // MARK: 🟢 Get Hatchery Strain List from server
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
    // MARK: 🟢 Get Field Strain List from server
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
            
        }
    }
    // MARK: 🟢 Get Dossage List from server
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
                        self.getProductionType()
                    } else {
                        // Handle the case where the array is empty
                        print("Get Dosage list is empty.")
                        self.showToastWithTimer(message: "No data available from the server.", duration: 3.0)
                        
                        // Call the next service
                        self.getProductionType()
                    }
                }
            })

        } else{
            print("test message")
        }
    }
    // MARK: 🟢 Get Dossage List with Molecule ID from server
    func callGetDosageWithMoleculeId() {
        
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
                        print("Error from API  Dossage List with Molecule ID list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        // Clear existing data in Core Data
                        CoreDataHandler().deleteAllData("GetDosageWithMoleculeID")
                        
                        // Process each item in the array
                        for item in arr {
                            if let strainDict = item.dictionary {
                                let doseId = strainDict["DoseId"]?.int ?? -1
                                let dosename = strainDict["Dose"]?.string ?? "Unknown"
                                let moleculeId = strainDict["MoleculeId"]?.int ?? -1
                                CoreDataHandler().SaveDosageDataWithMoleculeIDDatabaseField(dosename, doseId: doseId, molecukeId: moleculeId)
                            } else {
                                print("Invalid data format for Dossage List with Molecule ID: \(item)")
                            }
                        }
                        self.getProductionType()
                    }
                    
                    else {
                        self.getProductionType()
                    }
                }
            })
           
        } else{
            print("test message")
        }
    }
    // MARK: 🟢  ZoetisWebServices Get production type List from server
    func getProductionType() {
        if WebClass.sharedInstance.connected() {
      
            ZoetisWebServices.shared.getProductionTypeResponce(controller: self, parameters: [:], completion: { [weak self] (json, error) in
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
                        print("Error from API Production Type list: \(errorMessage)")
                        self.showToastWithTimer(message: errorMessage, duration: 3.0)
                        return
                    }
                    
                    // Parse the array from JSON response
                    if let arr = JSON(json).array, !arr.isEmpty {
                        CoreDataHandler().deleteAllData("ProductionType")
                        self.prodType = NSMutableArray ()
                        
                        for item in arr {
                            guard let tempDict = item.dictionaryObject else {
                                print("Invalid item structure in array.")
                                continue
                            }
                            let dictData = NSMutableDictionary()
                            dictData.setValue(tempDict["Name"] as? String, forKey: "productionName")
                            dictData.setValue(tempDict["Id"] as? Int, forKey: "productionId")
                            dictData.setValue(tempDict["LanguageId"] as? Int, forKey: "langID")
                            
                            prodType.add(dictData)
                        }
                        
                        self.callProductionType(self.prodType)
                        // Dismiss HUD
                        Helper.dismissGlobalHUD(self.view)
                    }
                    else
                    {
                        Helper.dismissGlobalHUD(self.view)
                    }
                }
            })
     
        } else{
            
            self.prodType = CoreDataHandler().fetchProductionType(lngID: lngId) as! NSMutableArray
            if(self.prodType.count == 0){
                self.callProductionType(self.prodType)
            }
            self.failWithInternetConnection()
        }
    }
    
    // MARK: 🟠 Save Production type data
    func callProductionType( _ productionTypArrrr : NSArray) {
        
        for i in 0..<productionTypArrrr.count {
            let productionTypeName = (productionTypArrrr.object(at: i) as AnyObject).value(forKey: "productionName") as! String
            let productionTypeid = (productionTypArrrr.object(at: i) as AnyObject).value(forKey: "productionId") as! NSNumber
            let lngTypeid = (productionTypArrrr.object(at: i) as AnyObject).value(forKey: "langID") as! NSNumber
            CoreDataHandler().productionTypeDatabase(productionTypeid, productionName: productionTypeName, dbArray: prodTypeArray, index: i,lngID: lngTypeid)
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
    // MARK: 🟠 Save Veterinarian data
    func callSaveMethodforeterian( _ veterianArray : NSArray) {
        var vetId = 0
        var vetName = ""
        for i in 0..<veterianArray.count {
            if let num = (veterianArray.object(at: i) as AnyObject).value(forKey: "VeterinarianId")
            {
                vetId = num as! Int
            }
            if let str = (veterianArray.object(at: i) as AnyObject).value(forKey: "VeterinarianName")
            {
                vetName = str as! String
            }
            
            CoreDataHandler().VetDataDatabase(vetId, vtName: vetName, complexId: 0, dbArray: self.veterianArr, index: i)
        }
    }
    // MARK: 🟠 Captured Necropsy Button Action
    @IBAction func captureNecropsyaAction(_ sender: AnyObject) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "CaptureNecropsy") as? CaptureNecropsyDataViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        
        
    }
    @IBOutlet weak var captureNecropsy2: UIButton!
    // MARK: 🟠 Unlinked NEcropsy button action
    @IBAction func unlinkedNecropsyBtnAction(_ sender: AnyObject) {
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "UnlinkedNecr") as? UnlinkedNecropsiesViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    
    // MARK: 🟢 ******************************* Get FarmList From Server ************************************* //
    
    func getListFarms() {
        
        if WebClass.sharedInstance.connected() {
            accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
          //  accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
//            let headers: HTTPHeaders = ["Authorization":accestoken]
            let Id = UserDefaults.standard.integer(forKey: "Id")
            let parameters = ["userId" :Id]
            let Url = WebClass.sharedInstance.webUrl + "Farm/GetFarmListByUserId"
            let urlString = URL(string: Url)
            
            let headers: HTTPHeaders = [
                "Authorization": accestoken,
                "Cache-Control": "no-store, no-cache, must-revalidate, private"
            ]
            sessionManager.request(urlString!, method: .post, parameters:parameters, headers: headers).responseJSON { response in
                
                let statusCode =  response.response?.statusCode
                if statusCode == 401{
                    self.loginMethod()
                }
                
                if statusCode == 500  || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    let alertController = UIAlertController(title:"", message: NSLocalizedString("Unable to get data from server. \n(\(String(describing: statusCode!)))", comment: "") , preferredStyle: UIAlertController.Style.alert) //Replace
                    let okAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: UIAlertAction.Style.default) {
                        (result : UIAlertAction) -> Void in
                        Helper.dismissGlobalHUD(self.view)
                        self.callWebService()
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    switch response.result {
                    case let .success(value):
                        if (value is NSArray)
                        {
                            let arr : NSArray = value as! NSArray
                            self.getFormArray = NSMutableArray ()
                            
                            for  i in 0..<arr.count {
                                let dictDat = NSMutableDictionary ()
                                let tempDict = arr.object(at: i) as AnyObject
                                dictDat.setValue(tempDict["CountryId"] as? Int, forKey: "CountryId")
                                dictDat.setValue(tempDict["FarmId"] as? Int, forKey: "FarmId")
                                dictDat.setValue(tempDict["FarmName"] as? String, forKey: "FarmName")
                                self.getFormArray.add(dictDat)
                            }
                            
                            CoreDataHandler().deleteAllData("FarmsList")
                            self.callSaveMethodgetListFarms( self.getFormArray)
                            self.callVeterianService()
                        }
                        else{
                            self.callVeterianService()
                        }
                        break
                    case let .failure(error):
                        debugPrint(error.localizedDescription)
                        break
                    }
                }
            }
            
        } else{
            self.farmsListAray = CoreDataHandler().fetchFarmsDataDatabase()
            if(self.farmsListAray.count == 0){
                self.callSaveMethodgetListFarms( self.getFormArray)
            }
        }
    }
    // MARK: 🟠 Save Farm's in Local Database
    func callSaveMethodgetListFarms(_ farmsArray : NSArray) {
        
        for i in 0..<farmsArray.count {
            let FarmId = (farmsArray.object(at: i) as AnyObject).value(forKey: "FarmId") as! NSNumber
            let FarmName = (farmsArray.object(at: i) as AnyObject).value(forKey: "FarmName") as! String
            let CountryId = (farmsArray.object(at: i) as AnyObject).value(forKey: "CountryId") as! NSNumber
            /***************** All details Save in to FarmdataBase ****************************************/
            CoreDataHandler().FarmsDataDatabase("", stateId: 0, farmName: FarmName, farmId: FarmId, countryName: "", countryId: CountryId, city: "")
        }
    }
    // MARK: 🟠 Get All Session's List
    func allSessionArr() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandler().fetchPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for i in 0..<postingArrWithAllData.count
        {
            let pSession =  postingArrWithAllData.object(at: i) as! PostingSession
            let farmSync = pSession.isfarmSync
            if farmSync != nil{
                Constants.isFromPsoting = true
            }
            else{
                Constants.isFromPsoting = false
            }
            break
        }
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId{
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        
        let allPostingSessionArr = NSMutableArray()
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count
        {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSession
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }
        for i in 0..<necArrWithoutPosting.count
        {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyData
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }
        return allPostingSessionArr
    }
    // MARK: 🟠 Sync Button Action
    @IBAction func SyncButtonAction(_ sender: AnyObject) {
        if self.allSessionArr().count > 0
        {
            if ConnectionManager.shared.hasConnectivity() {
                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data sync is in progress, please do not close the app. \n*Note - Please don't minimize App while syncing.", comment: ""))
                self.callSyncApi()
            }
            else{
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
            }
        }
        else{
            let  lngId = UserDefaults.standard.integer(forKey: "lngId")
            var strMsg = String()
            if lngId == 5 {
                strMsg = "Datos no disponibles para la sincronización."
            } else if lngId == 3 {
                strMsg = "Aucune données disponible pour la synchronisation."
            }else if lngId == 1{
                strMsg = "Data not available for syncing."
            }
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:strMsg)
        }
    }
    // MARK: 🟢 Sync API method call for Feed Program
    func callSyncApi()
    {
        self.isSync = false
        let arr = self.allSessionArr()
        for postingId in arr {
            if isSync == false {
                isSync = true
                if (UserDefaults.standard.value(forKey: "postingSession") != nil){
                    Constants.isFromPsoting = UserDefaults.standard.value(forKey: "postingSession") as? Bool ?? false
                    if Constants.isFromPsoting
                    {
                        UserDefaults.standard.removeObject(forKey: "postingSession") // We added this here
                        objApiSyncOneSet.feedprogram(postingId: NSNumber(value: postingId as! Int))
                    }
                    else{
                        objApiSync.feedprogram()
                    }
                }else{
                    objApiSync.feedprogram()
                }
            }
        }
    }
    // MARK: 🟠 No Internet Alert Message
    func failWithError(statusCode:Int)
    {
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        
        if statusCode == 0 {
            Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr: NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        }
        else{
            if lngId == 1 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
            } else if lngId == 3 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
            }
        }
    }
    
    func failWithErrorInternal()
    {
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }
    
    func failWithInternetConnection()
    {
        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }
    // MARK: 🟠 Alert Message
    func promtSyncing (){
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        let titleFont = [convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "HelveticaNeue-Light", size: 19.0)]
        let messageFont = [convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "HelveticaNeue-Light", size: 12.0)]
        let myMsgString = NSLocalizedString("Data available for sync. Do you want to sync now? \n\n\n *Note - Please don't minimize App while syncing.", comment: "")
        let titleAttrString = NSMutableAttributedString(string: NSLocalizedString("Alert", comment: ""), attributes: convertToOptionalNSAttributedStringKeyDictionary(titleFont))
        var messageAttrString = NSMutableAttributedString(string: myMsgString , attributes: convertToOptionalNSAttributedStringKeyDictionary(messageFont))
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
                        Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data sync is in progress, please do not close the app. \n*Note - Please don't minimize App while syncing.", comment: ""))
                        self.callSyncApi()
                    }
                }
                else{
                    Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
                }
            }
            else{
                let  lngId = UserDefaults.standard.integer(forKey: "lngId")
                var strMsg = String()
                if lngId == 5 {
                    strMsg = "Datos no disponibles para la sincronización."
                } else if lngId == 3 {
                    strMsg = "Aucune données disponible pour la synchronisation."
                }
                else if lngId == 1{
                    strMsg = "Data not available for syncing."
                }
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:strMsg)
            }
            Helper.dismissGlobalHUD(self.view)
        }
        let CancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("Cancel Pressed")
            self.iSfarmSync()
            self.printSyncLblCount()
            UserDefaults.standard.set(false, forKey: "promt")
        }
        alertController.addAction(okAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: 🟠 APi Sync finished Sucessfully
    func didFinishApi()
    {
        self.printSyncLblCount()
        if self.allSessionArr().count > 0 {
            self.showToastWithTimer(message: "Assessment synced successfully. Please Wait while we set this up for you.", duration: 2.0)
            self.isSync = false
            self.callSyncApi()
        }
        else {
            Helper.dismissGlobalHUD(self.view)
            let alertView = UIAlertController(title:NSLocalizedString("Alert", comment: "") , message:NSLocalizedString("Data Sync has been completed.", comment: ""), preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: "") , style: .default, handler: { (alertAction) -> Void in
                self.iSfarmSync()
                
            }))
            present(alertView, animated: true, completion: nil)
        }
    }
    // MARK: 🟠 Hit login API
    func loginMethod(){
        if WebClass.sharedInstance.connected() {
            let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
            let userName = PasswordService.shared.getUsername()
            let pass =  PasswordService.shared.getPassword()
            let Url = "Token"
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded",
                                        "Accept": "application/json",
                                        "Cache-Control": "no-store, no-cache, must-revalidate, private"]
            
            let parameters:[String:String] = ["grant_type": "password","UserName" : CryptoHelper.encrypt(input: userName) as! String, "Password" : CryptoHelper.encrypt(input: pass) as! String,"LoginType": "Web","DeviceId":udid as! String]
            
            sessionManager.request(urlString, method: .post, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case let .success(value):
                    let statusCode = response.response?.statusCode
                    let dict : NSDictionary = value as! NSDictionary
                    if statusCode == 400{
                        _ = dict["error_description"]
                        self.callLoginView()
                    }
                    else if statusCode == 401{
                        _ = dict["error_description"]
                        self.callLoginView()
                    }
                    else{
                        let acessToken = (dict.value(forKey: "access_token") as? String)!
                        let tokenType = (dict.value(forKey: "token_type") as? String)!
                        let aceesTokentype: String = tokenType + " " + acessToken
                        _ = dict.value(forKey: "HasAccess")! as AnyObject
                        
                        
                        let keychainHelper = AccessTokenHelper()
                        keychainHelper.saveToKeychain(valued: aceesTokentype, keyed: "aceesTokentype")
                      //  UserDefaults.standard.set(aceesTokentype,forKey: "aceesTokentype")
                        UserDefaults.standard.synchronize()
                        Helper.dismissGlobalHUD(self.view)
                        self.callWebService()
                    }
                    break
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    break
                }
            }
        }
    }
    // MARK: 🟠 Move to Login view
    func callLoginView()  {
        UserDefaults.standard.removeObject(forKey: "login")
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
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
// MARK: 🟠 - EXTENSION
extension DashViewController{
    // MARK: 🟠 API Fail Sync Delegates
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
            else if lngId == 3 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
            }
            else if lngId == 4 {
                Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Há problemas na sincronização de dados, tente novamente. \n(\(statusCode))")
            }
        }
    }
    
    func failWithErrorInternalSyncdata(){
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Server error please try again .", comment: "") )
    }
    func didFinishApiSyncdata(){
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Data Sync has been completed.", comment: ""))
        self.printSyncLblCount()
    }
    func failWithInternetConnectionSyncdata(){
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }
}
