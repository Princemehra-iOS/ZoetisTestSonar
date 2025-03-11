//
//  PEHeaderViewController.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 25/12/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import SwiftyJSON
import Reachability
import Gigya
import GigyaTfa
import GigyaAuth




// MARK: - PROTOCOLS

protocol SyncBtnDelegate: AnyObject {
    func syncBtnTapped()
}

protocol SyncBtnDelegatePE: AnyObject {
    func getVaccinationServiceResponse(showHud:Bool)
}


class PEHeaderViewController: BaseViewController {
    
    // MARK: - OUTLETS

    @IBOutlet weak var syncCountImg: UIImageView!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var onGoingSessionView: UIView!
    @IBOutlet weak var syncView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelFirstname: UILabel!
    @IBOutlet weak var labelSyncCount: UILabel!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var killSessionBtn: UIButton!
    @IBOutlet weak var assIdLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    
    
    @IBOutlet weak var pdfOptionsBtn: UIButton!
    
    // MARK: - VARIABLES
    
    weak var delegate: SyncBtnDelegate?
    weak var delegatePE: SyncBtnDelegatePE?
    var titleOfHeader: String = "0"
    var assId: String = ""
    var titleofSync: String = ""
    var showSession : Bool = false
    let gigya =  Gigya.sharedInstance(GigyaAccount.self)
    init(){
        super.init(nibName:"PEHeaderViewController", bundle: nil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS

    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        syncView.isHidden = true
        onGoingSessionView.isHidden = true
        btnLogout.isHidden = true
        pdfOptionsBtn.isHidden = true
        
        if (titleOfHeader == "Process Evaluation") || (titleOfHeader == "Pullet Vaccine Evaluation") {
            syncView.isHidden = false
            onGoingSessionView.isHidden = false
            btnLogout.isHidden = false
            pdfOptionsBtn.isHidden = true
        }
        if !(titleOfHeader == "View Assessment") && !(titleOfHeader == "Draft Assessment"){
            labelTitle.isHidden = true
            assIdLabel.isHidden = true
            centerLabel.isHidden = false
            centerLabel.text = titleOfHeader
            pdfOptionsBtn.isHidden = true
        }
        if (titleOfHeader == "Process Evaluation") {
            syncView.isHidden = false
            onGoingSessionView.isHidden = false
            btnLogout.isHidden = false
           
        }
        else{
            labelTitle.isHidden = false
            assIdLabel.isHidden = false
            centerLabel.isHidden = true
            labelTitle.text = titleOfHeader
            assIdLabel.text = assId
        }
        
        labelSyncCount.text = titleofSync
        labelFirstname.text = String(UserDefaults.standard.value(forKey: "FirstName") as? String ?? "") + " " + String(UserDefaults.standard.value(forKey: "LastName") as? String ?? "")
        
        if titleofSync == "0"{
            labelSyncCount.isHidden = true
            syncCountImg.isHidden = true
        } else {
            labelSyncCount.isHidden = false
            syncCountImg.isHidden = false
        }
    }
    
    
    func logoutBtnAction(){
        let moduleID =   UserDefaults.standard.string(forKey:"ModuleId")
        let moduleName =   UserDefaults.standard.string(forKey:"ModuleName")
        let userType =   UserDefaults.standard.string(forKey:"userType")
        
        let errorMSg = "Are you sure you want to logout?"
        let alertController = UIAlertController(title: "Alert", message: errorMSg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            NSLog("OK Pressed")
            
            self.ssologoutMethod()
            if userType == "PVE" {// For PVE
              //  UserDefaults.standard.set(false, forKey: "newlogin")
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "syncDataNoti"),object: nil))
//                for controller in (self.navigationController?.viewControllers ?? []) as Array {
//                    if controller.isKind(of: ViewController.self) {
//                        self.navigationController!.popToViewController(controller, animated: true)
//                        break
//                    }
//                }
            }
            if userType == "PE" {// For PE
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "peSyncDataNoti"),object: nil))
            }
            else  if userType == "Microbial"{
                UserDefaults.standard.set(false, forKey: "newlogin")
                NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "microbialSyncDataNoti"),object: nil))
                for controller in (self.navigationController?.viewControllers ?? []) as Array {
                    if controller.isKind(of: ViewController.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
            }

        }
        
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    




        // MARK:  /*********** Logout SSO Account **************/
        func ssologoutMethod()
        {
            gigya.logout() { result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    
    
    
    func finishSession()  {
        cleanSession()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboardForPVE"),object: nil))
    }
    
    func finishSessionPE()  {
        let userDefault = UserDefaults.standard
        userDefault.set(nil, forKey: "PE_Selected_Customer_Id")
        userDefault.set(nil, forKey: "PE_Selected_Customer_Name")
        userDefault.set(nil, forKey: "PE_Selected_Site_Id")
        userDefault.set(nil, forKey: "PE_Selected_Site_Name")
        UserDefaults.standard.set(true, forKey:"PECleanSession")
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "FinishSessionPEClicked"),object: nil))
    }
    
    private func cleanSession(){
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "UpdateComplexOnDashboard"),object: nil))
    }
    
    // MARK: - IBACTIONS
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        let errorMSg = "Are you sure you want to Logout?"
        let alertController = UIAlertController(title: "Alert", message: errorMSg as? String, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
                let userDefault = UserDefaults.standard
                  userDefault.set(nil, forKey: "PE_Selected_Customer_Id")
                  userDefault.set(nil, forKey: "PE_Selected_Customer_Name")
                  userDefault.set(nil, forKey: "PE_Selected_Site_Id")
                  userDefault.set(nil, forKey: "PE_Selected_Site_Name")
                  
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "LogoutClicked"),object: nil))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func syncBtnClicked(_ sender: Any) {
        if ConnectionManager.shared.hasConnectivity(){
            delegate?.syncBtnTapped()
            delegatePE?.getVaccinationServiceResponse(showHud: true)
        } else {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
        }
    }
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
        
    }
    
    @IBAction func pdfOptionBtnAction(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "pdfOptionsViewController") as! pdfOptionsViewController
       // vc.pdfURL = pdfUrl
        vc.modalPresentationStyle = .currentContext
        self.present(vc, animated: false, completion: nil)
//        
//                    if let viewController = UIStoryboard(name: "PEStoryboard", bundle: nil).instantiateViewController(withIdentifier: "pdfOptionsViewController") as? pdfOptionsViewController {
//                        if let navigator = navigationController {
//                           // viewController.base64Data = base64String
//                            navigator.pushViewController(viewController, animated: true)
//                        }
//                    }
    }
    
    
    
    
    @IBAction func clickToLogout(_ sender: Any) {
        logoutBtnAction()
    }
    
    @IBAction func clickToKillSession(_ sender: Any) {
        var errorMSg =  String()
        if (titleOfHeader == "Pullet Vaccine Evaluation"){
            errorMSg =  "Are you sure you want to reset Customer and Complex?"
        }else{
            errorMSg =  "Are you sure you want to reset customer and site?"
        }
        let alertController = UIAlertController(title: "Exit Session", message: errorMSg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            _ in
            NSLog("OK Pressed")
            let userType =   UserDefaults.standard.string(forKey:"userType")
            if userType == "PE" {// For PE
                self.finishSessionPE()
            } else {
                self.finishSession()
            }
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
