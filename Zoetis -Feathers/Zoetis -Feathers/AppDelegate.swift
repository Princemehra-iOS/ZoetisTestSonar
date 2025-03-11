//  AppDelegate.swift
//  Zoetis -Feathers
//  Created by "" on 11/08/16.
//  Copyright © 2016 "". All rights reserved.
//com.a1distribute.hms

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Fabric
import Crashlytics
import ReachabilitySwift
import Siren

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
    /************************************/
    var newColor = Int()
    var strImpFedd = String()
    var metricOrImperialClick = String()
    var isDoneClick: Bool = false
    var isFeedProgramClick: Bool = false
    var window: UIWindow?
    var globalDataArr = NSMutableArray()
    var sendFeedVariable = String()
    var  globalDataArrTurkey = NSMutableArray()
    var surveySelected :String  = ""

    /*************************************/
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UserDefaults.standard.set(false, forKey: "login")

        Fabric.with([Crashlytics.self])

        Localizer.DoTheMagic()
        IQKeyboardManager.shared.enable = true
        application.isStatusBarHidden = true
        setUpSlideMenu()
        metricOrImperialClick = "Imperial"
        var i: Int?
        i = UserDefaults.standard.integer(forKey: "isFeed")
        if i != 1 {
        let feed = UserDefaults.standard.integer(forKey: "feedId")
            if feed>0 {
            } else {
                UserDefaults.standard.set(-1, forKey: "feedId")
                UserDefaults.standard.synchronize()
            }
        }
        var isNewPostingId = UserDefaults.standard.bool(forKey: "isNewPostingId")

        if isNewPostingId == true {
            //let pId =  UserDefaults.standard.integer(forKey: "postingId")
//            CoreDataHandler().deleteDataWithPostingId(pId as NSNumber)
//            CoreDataHandler().deleteHetcharyVacDataWithPostingId(pId as NSNumber)
//            CoreDataHandler().deletefieldVACDataWithPostingId(pId as NSNumber)
//            CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(pId as NSNumber)
//            CoreDataHandlerTurkey().deleteHetcharyVacDataWithPostingIdTurkey(pId as NSNumber)
//            CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(pId as NSNumber)
            var pId1 =  UserDefaults.standard.integer(forKey: "postingId")

            if pId1 > 0 {
                pId1 = pId1 - 1
                UserDefaults.standard.set(pId1, forKey: "postingId")
                UserDefaults.standard.synchronize()
            }
            UserDefaults.standard.set(false, forKey: "isNewPostingId")
            UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
            UserDefaults.standard.synchronize()
        }

        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "ApplicationIdentifier") == nil {
            let UUID = Foundation.UUID().uuidString
            userDefaults.set(UUID, forKey: "ApplicationIdentifier")
            userDefaults.synchronize()
        }

        UserDefaults.standard.set(true, forKey: "promt")
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        let val = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(0, birdTypeId: 0) as NSArray
        for i in 0..<val.count {
            let posting: PostingSession = val.object(at: i) as! PostingSession
            let pidSession = posting.postingId
            let feedProgram =  CoreDataHandler().FetchFeedProgram(pidSession!)
            if feedProgram.count == 0 {
                CoreDataHandler().deleteDataWithPostingId(pidSession!)
                CoreDataHandler().deletefieldVACDataWithPostingId(pidSession!)
                CoreDataHandler().deleteDataWithPostingIdHatchery(pidSession!)
            }
        }

        let val1 = CoreDataHandlerTurkey().fetchAllPostingExistingSessionwithFullSessionTurkey(0, birdTypeId: 0) as NSArray
        for i in 0..<val1.count {
            let posting: PostingSessionTurkey = val1.object(at: i) as! PostingSessionTurkey
            let pidSession = posting.postingId
            let feedProgram =  CoreDataHandlerTurkey().FetchFeedProgramTurkey(pidSession!)
            if feedProgram.count == 0 {
                CoreDataHandlerTurkey().deleteDataWithPostingIdTurkey(pidSession!)
                CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(pidSession!)
                CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(pidSession!)
            }
        }
        return true
    }

    func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            //let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=com.zoetis.us.pv360") else {
                return false
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            return false

        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
            return version != currentVersion
        }
        return false

    }
    func updateNow() {
        guard let url = URL(string: "https://itunes.apple.com/us/app/poultryview-360/id1228196698?mt=8") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let val = UserDefaults.standard.integer(forKey: "chick")
        if val  ==  4 {
        if let VC = window?.rootViewController as? DashViewController {
            // Update JSON data
            VC.self.callSyncApi()
            completionHandler(.newData)
        } else {
            completionHandler(.failed)
        }
        } else {
            if let VC = window?.rootViewController as? DashViewControllerTurkey {
                // Update JSON data
                VC.self.callSyncApi()
                completionHandler(.newData)
            } else {
                completionHandler(.failed)
            }
        }
    }

    /*********** Implement Siren for Update App store **********/
    func setupSiren() {
        let siren = Siren.shared

        // Optional
        siren.delegate = self

        // Optional
        siren.debugEnabled = true
        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 3

        // Optional - Change the name of your app. Useful if you have a long app name and want to display a shortened version in the update dialog (e.g., the UIAlertController).
        //        siren.appName = "Test App Name"

        // Optional - Defaults to .Option
        //        siren.alertType = .option // or .force, .skip, .none

        // Optional - Can set differentiated Alerts for Major, Minor, Patch, and Revision Updates (Must be called AFTER siren.alertType, if you are using siren.alertType)

        siren.majorUpdateAlertType = .option
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.revisionUpdateAlertType = .option

        // Optional - Sets all messages to appear in Russian. Siren supports many other languages, not just English and Russian.
        //        siren.forceLanguageLocalization = .Russian

        // Optional - Set this variable if your app is not available in the U.S. App Store. List of codes: https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/AppStoreTerritories.html
        //        siren.countryCode = ""

        // Optional - Set this variable if you would only like to show an alert if your app has been available on the store for a few days.
        // This default value is set to 1 to avoid this issue: https://github.com/ArtSabintsev/Siren#words-of-caution
        // To show the update immediately after Apple has updated their JSON, set this value to 0. Not recommended due to aforementioned reason in https://github.com/ArtSabintsev/Siren#words-of-caution.
        //        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 3

        // Required
        siren.checkVersion(checkType: .immediately)
    }

    func setUpSlideMenu() {
        let storyBord = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBord.instantiateViewController(withIdentifier: "LeftMenuViewController")
        SlideNavigationController.sharedInstance().leftMenu = vc
        SlideNavigationController.sharedInstance().menuRevealAnimationDuration = 0.18
        SlideNavigationController.sharedInstance().enableSwipeGesture = true
        SlideNavigationController.sharedInstance().landscapeSlideOffset = (self.window?.frame.width)! - 158
        //SlideNavigationController.sharedInstance().landscapeSlideOffset = 1024-158

    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

        print(UserDefaults.standard.bool(forKey: "IAMONFEED"))
        print(UserDefaults.standard.integer(forKey: "MYPOSTINGID"))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Siren.shared.checkVersion(checkType: .immediately)
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Siren.shared.checkVersion(checkType: .daily)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {

         UserDefaults.standard.set(false, forKey: "isNewPostingId")
         UserDefaults.standard.set(true, forKey: "callWebService")

        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()

    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.app.Zoetis__Feathers" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Zoetis__Feathers", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            let options = [ NSInferMappingModelAutomaticallyOption: true,
                            NSMigratePersistentStoresAutomaticallyOption: true]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }

        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

 }
/**************** Siren Integarte for App store Update *********/
extension AppDelegate: SirenDelegate {
    func sirenDidShowUpdateDialog(alertType: Siren.AlertType) {
        print(#function, alertType)
    }

    func sirenUserDidCancel() {
        print(#function)
    }

    func sirenUserDidSkipVersion() {
        print(#function)
    }

    func sirenUserDidLaunchAppStore() {
        print(#function)
    }

    func sirenDidFailVersionCheck(error: NSError) {
        print(#function, error)
    }

    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }

    // This delegate method is only hit when alertType is initialized to .none
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
        print(#function, "\(message)")
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
