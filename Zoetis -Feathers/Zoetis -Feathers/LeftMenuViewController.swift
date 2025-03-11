//  LeftMenuViewController.swift
//  Topaz
//  Created by Chandan Kumar on 11/08/16.
//  Copyright © 2016 Chandan Kumar. All rights reserved.

import UIKit
import MBProgressHUD
import ReachabilitySwift
import CoreData

var hud1: MBProgressHUD = MBProgressHUD()
class LeftMenuViewController: UIViewController, UITableViewDelegate, syncApi, syncApiTurkey {
    func failWithInternetConnection() {

    }
    var lngId = NSInteger()

    @IBOutlet weak var tableView: UITableView!
    var swiftBlogs: [String]  = []
    let objApiSync = ApiSync()
    let objApiSyncTurkey = ApiSyncTurkey()
    var swiftBlogsTitles: [String]  = []
    let textCellIdentifier = "TextCell"
    var dataArray: NSMutableArray?
    var postingId = Int()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var switchBird1: Int!

    @objc func methodOfReceivedNotification(notification: Notification) {
        //Take Action on Notification
        switchBird1 =  UserDefaults.standard.integer(forKey: "switchBird")
        print(switchBird1)

        swiftBlogsTitles = [NSLocalizedString("Poultry Health Monitoring", comment: ""), NSLocalizedString("Start New Session", comment: ""), NSLocalizedString("Open Existing Session", comment: ""), NSLocalizedString("Training & Education", comment: ""), NSLocalizedString("Reports", comment: ""), NSLocalizedString("Help", comment: ""), NSLocalizedString("Settings", comment: ""), NSLocalizedString("Species", comment: "")]
        //  swiftBlogsTitles = ["Poultry Health Monitoring","Start New Session","Open Existing Session","Training & Education", "Reports","Help","Settings","Species"]

        tableView.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(LeftMenuViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifierLeftMenu"), object: nil)
         //UserDefaults.standard.set(0, forKey: "postingId")
         UserDefaults.standard.set(0, forKey: "necUnLinked")
         UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
         UserDefaults.standard.set(false, forKey: "Unlinked")
         UserDefaults.standard.set(true, forKey: "nec")
         UserDefaults.standard.set(false, forKey: "backFromStep1")
         UserDefaults.standard.synchronize()
         tableView.separatorColor = UIColor.black
      
         tableView.isScrollEnabled = true
         swiftBlogs = ["slider_dashboard", "slider_start_new_session", "slider_open_existing", "slider_training", "slider_reports", "slider_help", "slider_setings", "slider_switch"]
    }

    override func viewWillAppear(_ animated: Bool) {
        switchBird1 =  UserDefaults.standard.integer(forKey: "switchBird")

        lngId = UserDefaults.standard.integer(forKey: "lngId")

        swiftBlogsTitles = [NSLocalizedString("Poultry Health Monitoring", comment: ""), NSLocalizedString("Start New Session", comment: ""), NSLocalizedString("Open Existing Session", comment: ""), NSLocalizedString("Training & Education", comment: ""), NSLocalizedString("Reports", comment: ""), NSLocalizedString("Help", comment: ""), NSLocalizedString("Settings", comment: ""), NSLocalizedString("Species", comment: "")]
       // tableView.register(UITableViewCell.self, forCellReuseIdentifier: textCellIdentifier)
        tableView.reloadData()
        
    }

    /****** Call Function Of Chicken *******/
    func callSyncApi() {
       objApiSync.feedprogram()
    }
      /****** Call Function Of Turkey *******/
    func callSyncApiTurkey() {

        objApiSyncTurkey.feedprogram()
    }
    /******* delegate Method Of data syncing of checken*****/
    func failWithError(statusCode: Int) {

        Helper.dismissGlobalHUD((UIApplication.shared.keyWindow)!)
        if statusCode == 0 {
            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again.(NA)")
        } else {

            if lngId == 1 {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again. \n(\(statusCode))")

            } else if lngId == 3 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")
            }
        }
    }

    func failWithErrorInternal() {
        Helper.dismissGlobalHUD((UIApplication.shared.keyWindow)!)
        Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No internet connection. Please try again!", comment: ""))

    }
    func didFinishApi() {

        Helper.dismissGlobalHUD((UIApplication.shared.keyWindow)!)
        SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC"), withCompletion: nil)

    }
    /*****************************************************************************/
    /******* Data Sycc Of Chicken *************/
    func allSessionArr() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId {
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

     /******* Data Sycc Of Tutkey *************/
    func allSessionArrTurkey() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionWithisSyncisTrueTurkey(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1WithisSyncTurkey(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j) as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w) as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
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

    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {

        var imageView: UIImageView = UIImageView()
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)
        let row = indexPath.row
        for  contentview in cell.contentView.subviews {
            if contentview.isKind(of: UILabel.self) {
                let lab = contentview as! UILabel
                lab.text = ""
            }
        }
        let iconImage: UIImageView = cell.viewWithTag(10) as! UIImageView
        let iconName: UILabel = cell.viewWithTag(20) as! UILabel
        let image = UIImage.init(named: swiftBlogs[row] )
        if iconImage.image == nil {
             imageView = UIImageView.init(image: image)
        } else {
            iconImage.image = image
        }
        iconName.font = UIFont(name: "Regular", size: 16)
        iconImage.image = image
        iconName.text = swiftBlogsTitles[row]
        imageView.frame = CGRect(x: 0, y: 0, width: 158, height: 109)
        tableView.separatorColor = UIColor.black
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width/7, height: self.view.frame.size.height)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       AllValidSessions.sharedInstance.complexName = ""
        switch indexPath.row {
        case 0:

            UserDefaults.standard.set(0, forKey: "postingId")
            UserDefaults.standard.set(0, forKey: "necUnLinked")

            UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
            swiftBlogs[0] = "slider_dashboard"
            swiftBlogs[1] = "slider_start_new_session"
            swiftBlogs[2] = "slider_open_existing"
            swiftBlogs[3] = "slider_training"
            swiftBlogs[4] = "slider_reports"
            swiftBlogs[5] =  "slider_help"
            swiftBlogs[6] = "slider_setings"
            UserDefaults.standard.set(false, forKey: "Unlinked")
            UserDefaults.standard.set(true, forKey: "nec")
            UserDefaults.standard.set(false, forKey: "backFromStep1")
            let val = UserDefaults.standard.integer(forKey: "chick")
            if val  ==  4 {
                 SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "DashView_Controller"), withCompletion: nil)
            } else {
                 SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "DashViewControllerTurkey"), withCompletion: nil)
            }

        case 1:
             if UserDefaults.standard.integer(forKey: "Role") == 1 {
            swiftBlogs[0] = "slider_dashboard"
            swiftBlogs[1] = "slider_start_new_session"
            swiftBlogs[2] = "slider_open_existing"
            swiftBlogs[3] = "slider_training"
            swiftBlogs[4] = "slider_reports"
            swiftBlogs[5] =  "slider_help"
            swiftBlogs[6] = "slider_setings"

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
             //UserDefaults.standard.set(0, forKey: "postingIddddddd")
            appDelegate.sendFeedVariable = ""
                let val = UserDefaults.standard.integer(forKey: "chick")
                if val  ==  4 {
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)

                } else {
                    NotificationCenter.default.post(name: Notification.Name("NotificationIdentifierTurkey"), object: nil)
                }
            }
            case 2:

            if UserDefaults.standard.integer(forKey: "Role") == 1 {

                UserDefaults.standard.set(0, forKey: "postingId")
                 UserDefaults.standard.set(0, forKey: "necUnLinked")
                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                swiftBlogs[0] = "slider_dashboard"
                swiftBlogs[1] = "slider_start_new_session"
                swiftBlogs[2] = "slider_open_existing"
                swiftBlogs[3] = "slider_training"
                swiftBlogs[4] = "slider_reports"
                swiftBlogs[5] =  "slider_help"
                swiftBlogs[6] = "slider_setings"

                UserDefaults.standard.set(false, forKey: "Unlinked")
                UserDefaults.standard.set(true, forKey: "nec")
                UserDefaults.standard.set(false, forKey: "backFromStep1")
                    let val = UserDefaults.standard.integer(forKey: "chick")
                    if val ==  4 {
                       SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "Existing"), withCompletion: nil)
                    } else {
                        SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "ExistingTurkey"), withCompletion: nil)
                    }
            }
            case 3:

            UserDefaults.standard.set(0, forKey: "postingId")
            UserDefaults.standard.set(0, forKey: "necUnLinked")

            UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
            swiftBlogs[0] = "slider_dashboard"
            swiftBlogs[1] = "slider_start_new_session"
            swiftBlogs[2] = "slider_open_existing"
            swiftBlogs[3] = "slider_training"
            swiftBlogs[4] = "slider_reports"
            swiftBlogs[5] =  "slider_help"
            swiftBlogs[6] = "slider_setings"
            SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "Training"), withCompletion: nil)

        case 4:

             if UserDefaults.standard.integer(forKey: "Role") == 1 {
            UserDefaults.standard.set(0, forKey: "postingId")
                 UserDefaults.standard.set(0, forKey: "necUnLinked")
            UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
            swiftBlogs[0] = "slider_dashboard"
            swiftBlogs[1] = "slider_start_new_session"
            swiftBlogs[2] = "slider_open_existing"
            swiftBlogs[3] = "slider_training"
            swiftBlogs[4] = "slider_reports"
            swiftBlogs[5] =  "slider_help"
            swiftBlogs[6] = "slider_setings"

            UserDefaults.standard.set(false, forKey: "Unlinked")
            UserDefaults.standard.set(true, forKey: "nec")
            UserDefaults.standard.set(false, forKey: "backFromStep1")
            let val = UserDefaults.standard.integer(forKey: "chick")
            if val  ==  4 {
                SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "Report"), withCompletion: nil)
            } else {
                     SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "ReportTurkey"), withCompletion: nil)
            }
        }

        case 5:

            UserDefaults.standard.set(0, forKey: "postingId")
            UserDefaults.standard.set(0, forKey: "necUnLinked")

            UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
            swiftBlogs[0] = "slider_dashboard"
            swiftBlogs[1] = "slider_start_new_session"
            swiftBlogs[2] = "slider_open_existing"
            swiftBlogs[3] = "slider_training"
            swiftBlogs[4] = "slider_reports"
            swiftBlogs[5] =  "slider_help"
            swiftBlogs[6] = "slider_setings"

            UserDefaults.standard.set(false, forKey: "Unlinked")
            UserDefaults.standard.set(true, forKey: "nec")
            UserDefaults.standard.set(false, forKey: "backFromStep1")
           let val = UserDefaults.standard.integer(forKey: "chick")
          if val  ==  4 {
               SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "helpView"), withCompletion: nil)
      } else {
            SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "HelpScreenVcTurkey"), withCompletion: nil)
          }

        case 6:

            if UserDefaults.standard.integer(forKey: "Role") == 1 {
                UserDefaults.standard.set(0, forKey: "postingId")
                UserDefaults.standard.set(0, forKey: "necUnLinked")

                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                swiftBlogs[0] = "slider_dashboard"
                swiftBlogs[1] = "slider_start_new_session"
                swiftBlogs[2] = "slider_open_existing"
                swiftBlogs[3] = "slider_training"
                swiftBlogs[4] = "slider_reports"
                swiftBlogs[5] =  "slider_help"
                swiftBlogs[6] = "slider_setings"
                UserDefaults.standard.set(false, forKey: "Unlinked")
                UserDefaults.standard.set(true, forKey: "nec")
                UserDefaults.standard.set(false, forKey: "backFromStep1")

                let val = UserDefaults.standard.integer(forKey: "chick")
                if val  ==  4 {

                    SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "setting"), withCompletion: nil)
                } else {
                    SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "settingTurkey"), withCompletion: nil)
                }
            }

        default:
            let birdTypeId = UserDefaults.standard.integer(forKey: "switchBird")
            let vlue = UserDefaults.standard.bool(forKey: "turkey")
            let vlue1 = UserDefaults.standard.bool(forKey: "Chicken")
            print(birdTypeId)
            if birdTypeId ==  3 {
                if Reachability()?.isReachable == true {

                UserDefaults.standard.set(0, forKey: "postingId")
                UserDefaults.standard.set(0, forKey: "necUnLinked")
                UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
                swiftBlogs[0] = "slider_dashboard"
                swiftBlogs[1] = "slider_start_new_session"
                swiftBlogs[2] = "slider_open_existing"
                swiftBlogs[3] = "slider_training"
                swiftBlogs[4] = "slider_reports"
                swiftBlogs[5] =  "slider_help"
                swiftBlogs[6] = "slider_setings"
                swiftBlogs[7] = "slider_switch"
                UserDefaults.standard.set(false, forKey: "Unlinked")
                UserDefaults.standard.set(true, forKey: "nec")
                UserDefaults.standard.set(false, forKey: "backFromStep1")
                    if vlue == true {
                    objApiSyncTurkey.delegeteSyncApiTurkey = self
                    if self.allSessionArrTurkey().count > 0 {
                        if WebClass.sharedInstance.connected() == true {
                             Helper.showGlobalProgressHUDWithTitle(UIApplication.shared.keyWindow!, title: NSLocalizedString("Data syncing...", comment: ""))
                           self.callSyncApiTurkey()
                    } else {
                    Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
                    }
                } else {
                        SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC"), withCompletion: nil)
                        }
                    } else if vlue1 == true {
                        objApiSync.delegeteSyncApi = self
                        if self.allSessionArr().count > 0 {
                            if WebClass.sharedInstance.connected() == true {
                                Helper.showGlobalProgressHUDWithTitle(UIApplication.shared.keyWindow!, title: NSLocalizedString("Data syncing...", comment: ""))

                                self.callSyncApi()
                            } else {
                                Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please go online and sync data before logging out.", comment: ""))
                            }
                        } else {
                            SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC"), withCompletion: nil)
                        }
                    }

                } else {

                    if vlue == true {
                        let custArr = CoreDataHandler().fetchCustomer()
                        if(custArr.count == 0) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate

                            let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Please connect to Internet, switching species is only allowed when device is connected to Internet.", comment: ""), preferredStyle: UIAlertController.Style.alert)

                         //   let alert = UIAlertController(title: "Alert", message: "Please connect to Internet, switching species is only allowed when device is connected to Internet.", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            appDelegate?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        } else {

                            SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC"), withCompletion: nil)
                        }
                } else if vlue1 == true {
                        let custArr = CoreDataHandlerTurkey().fetchCustomerTurkey()
                        if(custArr.count == 0) {
                            let appDelegate = UIApplication.shared.delegate as? AppDelegate

                       let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Please connect to Internet, switching species is only allowed when device is connected to Internet.", comment: ""), preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            appDelegate?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                        } else {

                            SlideNavigationController.sharedInstance().popAllAndSwitch(to: self.storyboard?.instantiateViewController(withIdentifier: "BirdsSelectionVC"), withCompletion: nil)
                        }
                    }
               }
            }
        }
        self.tableView.reloadData()
    }
}
