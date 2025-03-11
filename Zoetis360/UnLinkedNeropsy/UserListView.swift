//
//  UserListView.swift
//  Crocodile
//
//  Created by Nibha Aggarwal on 6/13/16.
//  Copyright © 2016 Nibha Aggarwal. All rights reserved.
//

import UIKit
import CoreData

import Reachability
import SystemConfiguration
import Alamofire

protocol userlistProtocol: class {
    func cancelMethod()
    func DoneMethod(_ EmailUsers: String!)
    
}

protocol userLogOut: class {
    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView  ,indexValue :String)
    
}

class UserListView: UIView,syncApi,syncApiTurkey,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - VARIABLES
    
    let objApiSync = ApiSync()
    let objApiSyncTurkey = ApiSyncTurkey()
    var str = String()
    var lngId = NSInteger()
    var delegate:userlistProtocol!
    var logoutDelegate :userLogOut!
    var array_List = NSMutableArray()
    var array_ListImage: NSMutableArray = []
    var selecteditems: NSMutableArray! = []
    var webApi = ApiSync()
    var accesTokn = String()
    
    // MARK: - OUTLET
    @IBOutlet var tabelview_UserList: UITableView!
    
    // MARK: - METHODS AND FUNCTIONS
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "UserListView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func draw(_ rect: CGRect) {
        
        self.logOutApi()
        
        array_List = [NSLocalizedString("Log Out", comment: ""),NSLocalizedString("Full Site", comment: "")]
        array_ListImage = ["Log Out","full_site"]
        tabelview_UserList.layer.cornerRadius = 8
        tabelview_UserList.layer.borderWidth = 3
        tabelview_UserList.layer.borderColor =  UIColor.clear.cgColor
        
        tabelview_UserList.reloadData()
        if array_List.count != 0 {
            for _ in 0 ..< array_List.count {
                selecteditems.add(NSLocalizedString("No", comment: ""))
            }
        }
        tabelview_UserList.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    
    func showView(_ view1: UIView, frame1: CGRect) -> UIView {
        for i in 0 ..< selecteditems.count {
            selecteditems.replaceObject(at: i, with: NSLocalizedString("No", comment: ""))
        }
        
        tabelview_UserList.reloadData()
        self.frame = frame1
        view1.addSubview(self)
        self.alpha = 0
        let transitionOptions = UIView.AnimationOptions.transitionCurlDown
        UIView.transition(with: self, duration: 0.75, options: transitionOptions, animations: {
            self.alpha = 1
            
        }, completion: { finished in
            
        })
        return self
    }
    
    
    func removeView(_ view1: UIView) -> UIView {
        let transitionOptions = UIView.AnimationOptions.transitionCurlUp
        UIView.transition(with: self, duration: 0.75, options: transitionOptions, animations: {
            self.alpha = 0
            
        }, completion: { finished in
            self.removeFromSuperview()
        })
        
        return self
    }
    
    // MARK: 🟠 - IBACTION
    @IBAction func Cancel_btnAction(_ sender: AnyObject) {
        self.delegate.cancelMethod()
    }
    
    @IBAction func Done_btnAction(_ sender: AnyObject) {
        let temparray: NSMutableArray! = []
        for i in 0 ..< selecteditems.count {
            if !(selecteditems[i] as! String == NSLocalizedString("No", comment: "")) {
                temparray.add(selecteditems[i] as! String)
            }
        }
        
        var comma: String!
        if temparray.count > 0 {
            comma = temparray.componentsJoined(by: ",")
        }
        
        self.delegate.DoneMethod(comma)
    }
    
    // MARK: 🟠 - TABLE VIEW DATA SOURCE AND DELEGATES
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_List.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor(red: 59 / 255.0, green: 59 / 255.0, blue: 59 / 255.0, alpha: 1.0)
        
        cell.textLabel?.text = array_List.object(at: indexPath.row) as? String
        cell.textLabel?.textColor = UIColor.white
        cell.imageView?.image = UIImage(named: array_ListImage[indexPath.row] as! String)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        str = array_List[indexPath.row] as! String
        
        if UserDefaults.standard.bool(forKey: "chickenSyncStatus") == true {
            
            objApiSync.delegeteSyncApi = self
            
            if self.allSessionArr().count > 0 {
                if WebClass.sharedInstance.connected() == true{
                    Helper.showGlobalProgressHUDWithTitleWithoutHudBack(self, title: NSLocalizedString("Data syncing...", comment: ""))
                    self.callSyncApi()
                } else {
                    self.logoutDelegate?.leftController(self, didSelectTableView: tabelview_UserList ,indexValue:str)
                    
                }
            } else {
                
                self.logoutDelegate?.leftController(self, didSelectTableView: tabelview_UserList ,indexValue:str)
            }
        }else if UserDefaults.standard.bool(forKey: "turkeySyncStatus") == true {
            objApiSyncTurkey.delegeteSyncApiTurkey = self
            
            if self.allSessionArrTurkey().count > 0 {
                if WebClass.sharedInstance.connected() == true{
                    Helper.showGlobalProgressHUDWithTitleWithoutHudBack(self, title: NSLocalizedString("Data syncing...", comment: ""))
                    self.callSyncApiTurkey()
                } else {
                    self.logoutDelegate?.leftController(self, didSelectTableView: tabelview_UserList ,indexValue:str)
                }
            } else {
                
                self.logoutDelegate?.leftController(self, didSelectTableView: tabelview_UserList ,indexValue:str)
            }
            
        }
    }
    
    // MARK: - METHODS AND FUNCTIONS
    func deleteAllData(_ entity: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            
        } catch let error as NSError {
            
            debugPrint("Detele all data in \(entity) error : \(error) \(error.userInfo)")
            
        }
    }
    
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
    // MARK: 🟠 Call Sync API
    func callSyncApi() {
        
        objApiSync.feedprogram()
    }
    // MARK: 🟠 Call Sync API (Turkey)
    func callSyncApiTurkey() {
        
        objApiSyncTurkey.feedprogram()
    }
    // MARK: 🟠 Internet Failed Error function
    func failWithError(statusCode:Int) {
        
        Helper.dismissGlobalHUD(self)
        self.printSyncLblCount()
        if statusCode == 0{
            showAlertIfNeeded(message: NSLocalizedString("There are problem in data syncing please try again.(NA)", comment: ""))
          //  Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again.(NA)")
        } else {
            
            if lngId == 1 {
                showAlertIfNeeded(message: NSLocalizedString("There are problem in data syncing please try again. \n(\(statusCode))", comment: ""))
                
              //  Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"There are problem in data syncing please try again. \n(\(statusCode))")
                
                
            } else if lngId == 3 {
                showAlertIfNeeded(message: NSLocalizedString("Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))", comment: ""))
              //  Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:"Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
                
            }
        }
    }
    func showAlertIfNeeded(message: String) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            let title = NSLocalizedString("Alert", comment: "")
            
            Helper.showAlertMessage(rootViewController, titleStr: title, messageStr: message)
        }
    }
    
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self)
        self.printSyncLblCount()
        showAlertIfNeeded(message: NSLocalizedString("No internet connection. Please try again!", comment: ""))
     //   Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("No internet connection. Please try again!", comment: ""))
        
    }
    
    func didFinishApi(){
        
        Helper.dismissGlobalHUD(self)
        self.logoutDelegate?.leftController(self, didSelectTableView: tabelview_UserList ,indexValue:str)
    }
    
    func failWithInternetConnection() {
        showAlertIfNeeded(message: NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
       // Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
    }
    func printSyncLblCount() {
        appDelegate.testFuntion()
    }
    
    // MARK: 🟠Logout API
    func logOutApi() {
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
        /*
        if WebClass.sharedInstance.connected() {
            var Id = Int()
            Id =  UserDefaults.standard.value(forKey: "Id") as! Int
            let Url = "Login/UpdateUserLog"
            accesTokn = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let parameters = ["UserID" :Id,"DeviceId":udid as! String,"LoginType":"iOS"] as [String : Any]
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            
            
            AF.request(urlString, method: .get, parameters: parameters).responseJSON { response in
                switch response.result {
                case let .success(value):
                    
                    let statusCode = response.response?.statusCode
                    if statusCode == 400{
                    }
                    break
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    break
                }
            }
        } else{
            
        }
        */
    }
    
    // MARK: 🟠 All Session Array Turkey.
    func allSessionArrTurkey() ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
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
}

