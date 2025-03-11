//
//  SettingsViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 9/6/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import ReachabilitySwift
import SystemConfiguration

class SettingsViewController: UIViewController, UINavigationControllerDelegate, closeButton, userLogOut, syncApi {
    var customPopV: infoLink!
    var quicklinksValue =  Bool()
    var dataSource: CommonTableView!
    var acessToken = String()
    let buttonbg = UIButton()
    let objApiSync = ApiSync()
    var customPopView1: UserListView!
    let buttonDroper = UIButton()

    @IBOutlet weak var syncNotifcCount: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var skeltaLabel: UILabel!
    @IBOutlet weak var cocodissLabel: UILabel!
    @IBOutlet weak var gitractLabel: UILabel!
    @IBOutlet weak var respLabel: UILabel!
    @IBOutlet weak var immuLabel: UILabel!

    @IBOutlet weak var btnSkleton: UIButton!
    @IBOutlet weak var btnCocii: UIButton!
    @IBOutlet weak var btnGit: UIButton!
    @IBOutlet weak var btnResp: UIButton!
    @IBOutlet weak var btnImmu: UIButton!
    @IBOutlet weak var tblView: UITableView!
    /******** Intilizing Array **************************/
    var dataSkeletaArray = NSArray()
    var dataCocoiiArray = NSArray()
    var dataGiTractArray = NSArray()
    var dataRespiratoryArray = NSArray()
    var dataImmuneArray = NSArray()
    var lngId = NSInteger()

    /************ Delare Array ******************************/

    var dataArray = NSMutableArray()
    /*************************************************************/
    var strButtonNmae = String()
    var btnTag = NSInteger()
    var serviceDataHldArr = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @objc func methodOfReceivedNotification(notification: Notification) {
        //Take Action on Notification
        UserDefaults.standard.set(0, forKey: "postingId")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        objApiSync.delegeteSyncApi = self
        btnTag = 0
        btnSkleton.setImage(UIImage(named: "skeletal_select"), for: .normal)
        btnCocii.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
        btnGit.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
        btnImmu.setImage(UIImage(named: "immune_unselect"), for: .normal)
        btnResp.setImage(UIImage(named: "respiratory_unselect"), for: .normal)

        if WebClass.sharedInstance.connected() {
            if (appDelegate.globalDataArr.count) > 0 {
            dataArray = appDelegate.globalDataArr
        }
        }

        self.skeletalMusclarAction(sender: "0" as AnyObject)
        }

    override func viewWillAppear(_ animated: Bool) {
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 5 {
            skeltaLabel.text = "Esquelético/Muscular/Integumental"
            cocodissLabel.text = "Coccidiosis"
            gitractLabel.text = "Tracto gastrointestinal"
            respLabel.text = "Respiratorio"
            immuLabel.text = "Inmune/Otros"
        } else if lngId == 3 {
            skeltaLabel.text = "Squelettique/Musculaire/Tégumentaire"
            cocodissLabel.text = "Coccidiose"
            gitractLabel.text = "Tractus GI"
            respLabel.text = "Respiratoire"
            immuLabel.text = "Immunité/Autres"
        }
        self.printSyncLblCount()
        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String

    }

    @IBAction func skeletalMusclarAction(sender: AnyObject) {
        btnTag = 0
        if(btnSkleton.isSelected == false) {

            btnSkleton.setImage(UIImage(named: "skeletal_select"), for: .normal)
            btnCocii.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            btnGit.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            btnImmu.setImage(UIImage(named: "immune_unselect"), for: .normal)
            btnResp.setImage(UIImage(named: "respiratory_unselect"), for: .normal)

        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataSkeletaArray = CoreDataHandler().fetchAllSeettingdataWithLngId(lngId: lngId as NSNumber)

        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()

    }

    @IBAction func coccidiosisAction(sender: AnyObject) {

        btnTag = 1
        if(btnCocii.isSelected == false) {

            btnSkleton.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            btnCocii.setImage(UIImage(named: "Coccidiosis_select"), for: .normal)
            btnGit.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            btnImmu.setImage(UIImage(named: "immune_unselect"), for: .normal)
            btnResp.setImage(UIImage(named: "respiratory_unselect"), for: .normal)

        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataCocoiiArray = CoreDataHandler().fetchAllCocoiiDataUsinglngId(lngId: lngId as NSNumber)

        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()

    }

    @IBAction func giTractAction(sender: AnyObject) {
        strButtonNmae = "gitract"

        btnTag = 2
        if(btnGit.isSelected == false) {
            btnSkleton.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            btnCocii.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            btnGit.setImage(UIImage(named: "skeletal_select"), for: .normal)
            btnImmu.setImage(UIImage(named: "immune_unselect"), for: .normal)
            btnResp.setImage(UIImage(named: "respiratory_unselect"), for: .normal)

        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataGiTractArray = CoreDataHandler().fetchAllGITractDataUsingLngId(lngId: lngId as NSNumber)

        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()

    }

    @IBAction func respiratoryAction(sender: AnyObject) {
        strButtonNmae = "respiro"

        btnTag = 3
        if (btnResp.isSelected == false) {
            btnSkleton.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            btnCocii.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            btnGit.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            btnImmu.setImage(UIImage(named: "immune_unselect"), for: .normal)
            btnResp.setImage(UIImage(named: "skeletal_select"), for: .normal)
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataRespiratoryArray = CoreDataHandler().fetchAllRespiratoryusingLngId(lngId: lngId as NSNumber)

        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
    }

    @IBAction func immuneOthers(sender: AnyObject) {
        strButtonNmae = "immu"

        btnTag = 4
        if (btnImmu.isSelected == false) {

            btnSkleton.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            btnCocii.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            btnGit.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            btnImmu.setImage(UIImage(named: "immune_select"), for: .normal)
            btnResp.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataImmuneArray = CoreDataHandler().fetchAllImmuneUsingLngId(lngId: lngId as NSNumber)

        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()

    }
    func callSaveMethod( skeletaArr: NSArray) {
        for i in 0..<skeletaArr.count {
            let strObservationField =
                (skeletaArr.object(at: i) as AnyObject).value(forKey: "ObservationDescription") as! String
            let visibilityCheck = (skeletaArr.object(at: i) as AnyObject)
                .value(forKey: "DefaultQLink") as! Bool
            let obsId = (skeletaArr.object(at: i) as AnyObject).value(forKey: "ObservationId") as! NSInteger
            let visibilitySwitch = (skeletaArr.object(at: i) as AnyObject).value(forKey: "Visibility") as! Bool
            let measure =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "Measure") as! String
            let lngIdValue =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! NSNumber
            let refId =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "ReferenceId") as! NSNumber

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
                CoreDataHandler().saveSettingsSkeletaInDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray: dataSkeletaArray, obsId: obsId, measure: measure, isSync: false, lngId: lngIdValue, refId: refId)

            } else if btnTag == 1 {

                CoreDataHandler().saveSettingsCocoiiInDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray: dataCocoiiArray, obsId: obsId, measure: measure, isSync: false, lngId: lngIdValue, refId: refId)
            } else if btnTag == 2 {

                CoreDataHandler().saveSettingsGITractDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray: dataGiTractArray, obsId: obsId, measure: measure, isSync: false, lngId: lngIdValue, refId: refId )
            } else if btnTag == 3 {

                CoreDataHandler().saveSettingsRespiratoryDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray: dataRespiratoryArray, obsId: obsId, measure: measure, isSync: false, lngId: lngIdValue, refId: refId)
            } else {
                CoreDataHandler().saveSettingsImmuneDatabase(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray: dataImmuneArray, obsId: obsId, measure: measure, isSync: false, lngId: lngIdValue, refId: refId )
            }
        }
    }

    /**************** tableView DataSource & Delegate Methods ***********************************/

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomeTableViewCell
        if indexPath.row % 2 == 0 {

            cell.bgView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        } else {

            cell.bgView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)

        }

        if btnTag == 0 {
            let skeletaObject: Skeleta = dataSkeletaArray.object(at: indexPath.row) as! Skeleta
            cell.lblName.text = skeletaObject.observationField
            cell.switchView.isOn = skeletaObject.visibilityCheck as! Bool

            if cell.switchView.isOn == true {

                cell.checkBoxOutlet.isUserInteractionEnabled = true
            } else {

                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }

            cell.checkBoxOutlet.isSelected = skeletaObject.quicklinks as! Bool

            if cell.checkBoxOutlet.isSelected == true {

                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {

                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }

        } else if btnTag == 1 {

            let cocoii: Coccidiosis = dataCocoiiArray.object(at: indexPath.row) as! Coccidiosis
            cell.lblName.text = cocoii.observationField
            cell.switchView.isOn = cocoii.visibilityCheck as! Bool

            if cell.switchView.isOn == true {

                cell.checkBoxOutlet.isUserInteractionEnabled = true
            } else {

                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }

            cell.checkBoxOutlet.isSelected = cocoii.quicklinks as! Bool

            if cell.checkBoxOutlet.isSelected == true {

                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {

                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }

        } else if btnTag == 2 {
            let skeletaObject: GITract = dataGiTractArray.object(at: indexPath.row) as! GITract
            cell.lblName.text = skeletaObject.observationField
            cell.switchView.isOn = skeletaObject.visibilityCheck as! Bool

            if cell.switchView.isOn == true {

                cell.checkBoxOutlet.isUserInteractionEnabled = true
            } else {

                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }
            cell.checkBoxOutlet.isSelected = skeletaObject.quicklinks as! Bool

            if cell.checkBoxOutlet.isSelected == true {

                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {

                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }
        } else if btnTag == 3 {

            let cocoii: Respiratory = dataRespiratoryArray.object(at: indexPath.row) as! Respiratory
            cell.lblName.text = cocoii.observationField
            cell.switchView.isOn = cocoii.visibilityCheck as! Bool

            if cell.switchView.isOn == true {

                cell.checkBoxOutlet.isUserInteractionEnabled = true
            } else {

                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }

            cell.checkBoxOutlet.isSelected = cocoii.quicklinks as! Bool

            if cell.checkBoxOutlet.isSelected == true {

                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {

                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }

        } else if btnTag ==  4 {

            let cocoii: Immune = dataImmuneArray.object(at: indexPath.row) as! Immune
            cell.lblName.text = cocoii.observationField
            cell.switchView.isOn = cocoii.visibilityCheck as! Bool

            if cell.switchView.isOn == true {

                cell.checkBoxOutlet.isUserInteractionEnabled = true
            } else {

                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }

            cell.checkBoxOutlet.isSelected = cocoii.quicklinks as! Bool

            if cell.checkBoxOutlet.isSelected == true {

                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {

                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }

        }

        cell.checkBoxOutlet.addTarget(self, action: #selector(SettingsViewController.checkBoxClick(_:)), for: .touchUpInside )
        cell.switchView.addTarget(self, action: #selector(SettingsViewController.switchClick(_:)), for: .valueChanged)
        cell.switchView.tag = indexPath.row
        cell.checkBoxOutlet.tag = indexPath.row
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }

    /**************** Action Of CheckBox Button *******************************************/
    @objc func checkBoxClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if  sender.isSelected {
            sender.isSelected = true
            sender.setImage(UIImage(named: "Check_")!, for: .normal)

        } else {

            sender.setImage(nil, for: .normal)
            sender.setImage(UIImage(named: "Uncheck_")!, for: .normal)
        }
        var observationId = NSInteger()
        var  vsibilityValue = Bool()

        if btnTag == 0 {
            let skeletaObject: Skeleta = dataSkeletaArray.object(at: sender.tag) as! Skeleta
            vsibilityValue = skeletaObject.visibilityCheck as! Bool
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId
            CoreDataHandler().updateSettingDataSkelta(skeletaObject.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag, dbArray: dataSkeletaArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)
            //self.SaveDatOnServer(obsId: observationId, quickLink: sender.isSelected,visibility:vsibilityValue)

        } else if  btnTag == 1 {

            let cocoii: Coccidiosis = dataCocoiiArray.object(at: sender.tag) as! Coccidiosis
            vsibilityValue = cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            CoreDataHandler().updateSettingDataCocoii(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag, dbArray: dataCocoiiArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)

           // self.SaveDatOnServer(obsId: observationId, quickLink: sender.isSelected,visibility:vsibilityValue)

        } else if  btnTag == 2 {
            let skeletaObject: GITract = dataGiTractArray.object(at: sender.tag) as! GITract
            vsibilityValue = skeletaObject.visibilityCheck as! Bool
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId

            CoreDataHandler().updateSettingDataGitract(skeletaObject.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag, dbArray: dataGiTractArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId! )

           // self.SaveDatOnServer(obsId: observationId, quickLink: sender.isSelected,visibility:vsibilityValue)

        } else if  btnTag == 3 {

            let cocoii: Respiratory = dataRespiratoryArray.object(at: sender.tag) as! Respiratory
            vsibilityValue =
                cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            CoreDataHandler().updateSettingDataResp(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag, dbArray: dataRespiratoryArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)
            //self.SaveDatOnServer(obsId: observationId, quickLink: sender.isSelected,visibility:vsibilityValue)

        } else if  btnTag == 4 {

            let cocoii: Immune = dataImmuneArray.object(at: sender.tag) as! Immune
            vsibilityValue = cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            CoreDataHandler().updateSettingDataImmune(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag, dbArray: dataImmuneArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId! )
           // self.SaveDatOnServer(obsId: observationId, quickLink: sender.isSelected,visibility:vsibilityValue)
        }

    }

    func SaveDatOnServer(obsId: NSInteger, quickLink: Bool, visibility: Bool) {

        let Internaldict = NSMutableDictionary()
        let outerDict = NSMutableDictionary()
        let arr1 = NSMutableArray()
        let Id = UserDefaults.standard.integer(forKey: "Id")
        outerDict.setValue(Id, forKey: "UserId")

        Internaldict.setValue(obsId, forKey: "ObservationId")
        Internaldict.setValue(quickLink, forKey: "QuickLink")
        Internaldict.setValue(visibility, forKey: "Visibility")
        Internaldict.setValue(lngId, forKey: "LanguageId")
        arr1.add(Internaldict)
        outerDict.setValue(arr1, forKey: "ObservationUserDetails")
        // print(outerDict)
        let jsonData = try! JSONSerialization.data(withJSONObject: outerDict, options: JSONSerialization.WritingOptions.prettyPrinted)

        var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        jsonString = jsonString.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if WebClass.sharedInstance.connected() {

            let Url = "Setting/SaveUserSetting"
            acessToken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": acessToken]

            let urlString: String = WebClass.sharedInstance.webUrl.appending(Url)
            var request = URLRequest(url: NSURL(string: urlString)! as URL)

            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: outerDict, options: [])

            Alamofire.request(request as URLRequestConvertible)
                .responseJSON { response in
                    switch response.result {
                    case .failure(let error):

                        if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            print(error)
                            print(responseString)
                        }

                    case .success(let responseObject):

                        print(responseObject)
                    }
            }
        }

    }

    /******************* Action Of Switch Button Action ***********************************************/
    @objc func switchClick(_ sender: UISwitch) {

       let indexpath = NSIndexPath(row: sender.tag, section: 0)
       guard let cell = tblView.cellForRow(at: indexpath as IndexPath) as? CustomeTableViewCell else {

            return
        }

        if sender.isOn == true {
            cell.checkBoxOutlet.isUserInteractionEnabled = true

            quicklinksValue = false
            cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
        } else {

            cell.checkBoxOutlet.isUserInteractionEnabled = false
            quicklinksValue = false
            cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)

        }

        var observationId = NSInteger()

        if btnTag == 0 {

            let skeletaObject: Skeleta = dataSkeletaArray.object(at: sender.tag) as! Skeleta
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let  lngIdValue = skeletaObject.lngId
            let  refId = skeletaObject.refId
            CoreDataHandler().updateSettingDataSkelta(skeletaObject.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag, dbArray: dataSkeletaArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)
           // self.SaveDatOnServer(obsId: observationId, quickLink: quicklinksValue,visibility:sender.isOn)
        } else if btnTag == 1 {

            let cocoii: Coccidiosis = dataCocoiiArray.object(at: sender.tag) as! Coccidiosis
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId

            CoreDataHandler().updateSettingDataCocoii(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag, dbArray: dataCocoiiArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId! )
          //  self.SaveDatOnServer(obsId: observationId, quickLink: quicklinksValue,visibility:sender.isOn)
        } else if btnTag == 2 {
            let skeletaObject: GITract = dataGiTractArray.object(at: sender.tag) as! GITract
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let  lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId
            CoreDataHandler().updateSettingDataGitract(skeletaObject.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag, dbArray: dataGiTractArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)
           // self.SaveDatOnServer(obsId: observationId, quickLink: quicklinksValue,visibility:sender.isOn)
        } else if btnTag == 3 {

            let cocoii: Respiratory = dataRespiratoryArray.object(at: sender.tag) as! Respiratory
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId
            CoreDataHandler().updateSettingDataResp(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag, dbArray: dataRespiratoryArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId!)
           // self.SaveDatOnServer(obsId: observationId, quickLink: quicklinksValue,visibility:sender.isOn)
        } else if btnTag == 4 {

            let cocoii: Immune = dataImmuneArray.object(at: sender.tag) as! Immune
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId
            CoreDataHandler().updateSettingDataImmune(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag, dbArray: dataImmuneArray, obsId: observationId, measure: measure!, isSync: true, lngId: lngIdValue!, refId: refId! )
            //self.SaveDatOnServer(obsId: observationId, quickLink: quicklinksValue,visibility:sender.isOn)

        }

    }
    /**********************************************************************************************/

    func tableView(_ tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch btnTag {
        case 0:
            return dataSkeletaArray.count
        case 1:
            return dataCocoiiArray.count
        case 2:
            return dataGiTractArray.count
        case 3:
            return dataRespiratoryArray.count
        default:
            return dataImmuneArray.count
        }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()

        return view
    }

    @IBAction func sideMenu(sender: AnyObject) {

        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    let button1 = UIButton()

    func clickHelpPopUpqw() {

        buttonDroper.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonDroper.addTarget(self, action: #selector(SettingsViewController.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonDroper)

        customPopV = (infoLink.loadFromNibNamed("infoLink") as! infoLink)
        customPopV.delegateInfo = self
        customPopV.center = self.view.center
        buttonDroper.addSubview(customPopV)

    }

    @objc func buttonPressedDroper(sender: UIButton!) {
        buttonDroper.removeFromSuperview()
    }

    func noPopUpPosting() {
        buttonDroper.removeFromSuperview()
        customPopV.removeView(view)

    }

    func doneButton() {
        customPopV.removeView(view)
    }
    @IBAction func logOutBttn(sender: AnyObject) {
        clickHelpPopUp()

    }

    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView, indexValue: String) {

        if indexValue == "Log Out" {

            UserDefaults.standard.removeObject(forKey: "login")
            if Reachability()?.isReachable == true {

                CoreDataHandler().deleteAllData("Custmer")
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
            buttonbg.removeFromSuperview()
            customPopView1.removeView(view)
        }
    }

    func clickHelpPopUp() {

        buttonbg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg.addTarget(self, action: #selector(SettingsViewController.buttonPressed1), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonbg)
        customPopView1 = UserListView.loadFromNibNamed("UserListView") as? UserListView
        customPopView1.logoutDelegate = self
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView1)
        customPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200, y: 60, width: 150, height: 60))
    }

    @objc func buttonPressed1() {
        customPopView1.removeView(view)
        buttonbg.removeFromSuperview()
    }
    func allSessionArr() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0 ..< necArrWithoutPosting.count - 1 {
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

    @IBAction func syncBtnAction(sender: AnyObject) {
        // self.saveDatOnServerAllSeting()

        if self.allSessionArr().count > 0 {
            if Reachability()?.isReachable == true {

                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data syncing...", comment: ""))

                self.callSyncApi()
            } else {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
            }
        } else {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data not available for syncing.", comment: ""))
        }
    }

    func callSyncApi() {
        objApiSync.feedprogram()
    }

    // MARK: -- Delegate SyNC Api

    func failWithError(statusCode: Int) {

        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()

        if statusCode == 0 {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        } else {

            if lngId == 1 {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again. \n(\(statusCode))")

            } else if lngId == 3 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")

            }
        }
    }

    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }

    func didFinishApi() {
        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
    }

    func failWithInternetConnection() {

        self.printSyncLblCount()
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }

    func printSyncLblCount() {

        //  syncNotifcCount.text = String(self.allSessionArr().count)
    }

    /*******************************************************************************/

    func saveDatOnServerAllSeting() {

        let outerDict = NSMutableDictionary()
        let arr1 = NSMutableArray()
        let Id = UserDefaults.standard.integer(forKey: "Id")
        outerDict.setValue(Id, forKey: "UserId")

        let cocoii =  CoreDataHandler().fetchAllCocoiiData().mutableCopy() as! NSMutableArray
        let gitract =  CoreDataHandler().fetchAllGITractData().mutableCopy() as! NSMutableArray
        let resp =  CoreDataHandler().fetchAllRespiratory().mutableCopy() as! NSMutableArray
        let immu =  CoreDataHandler().fetchAllImmune().mutableCopy() as! NSMutableArray
        let skeletenArr =  CoreDataHandler().fetchAllSeettingdata().mutableCopy() as! NSMutableArray

        for i in 0..<skeletenArr.count {
            let obsId = (skeletenArr.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (skeletenArr.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (skeletenArr.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            // Internaldict.setValue(quickLink, forKey: "visibilityCheck")
            arr1.add(Internaldict)
            print(arr1)
        }

        for i in 0..<cocoii.count {
            let obsId = (cocoii.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (cocoii.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (cocoii.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            // Internaldict.setValue(quickLink, forKey: "visibilityCheck")
            arr1.add(Internaldict)
            print(arr1)
        }

        for i in 0..<gitract.count {
            let obsId = (gitract.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (gitract.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (gitract.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            // Internaldict.setValue(quickLink, forKey: "visibilityCheck")
            arr1.add(Internaldict)
            print(arr1)
        }
        for i in 0..<resp.count {
            let obsId = (resp.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (resp.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (resp.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            // Internaldict.setValue(quickLink, forKey: "visibilityCheck")
            arr1.add(Internaldict)
            print(arr1)
        }

        for i in 0..<immu.count {
            let obsId = (immu.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (immu.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (immu.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            // Internaldict.setValue(quickLink, forKey: "visibilityCheck")
            arr1.add(Internaldict)
            print(arr1)
        }

        outerDict.setValue(arr1, forKey: "ObservationUserDetails")
        // print(outerDict)

        let jsonData = try! JSONSerialization.data(withJSONObject: outerDict, options: JSONSerialization.WritingOptions.prettyPrinted)

        var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        jsonString = jsonString.trimmingCharacters(in: NSCharacterSet.whitespaces)

        if WebClass.sharedInstance.connected() {

            let Url = "Setting/SaveUserSetting"
            acessToken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": acessToken]

            let urlString: String = WebClass.sharedInstance.webUrl.appending(Url)
            let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL )

            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = try! JSONSerialization.data(withJSONObject: outerDict, options: [])

            Alamofire.request(request as! URLRequestConvertible)

                .responseJSON { response in

                    switch response.result {

                    case .failure(let error):

                        if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            print(error)
                            print(responseString)

                        }

                    case .success(let responseObject):

                        print(responseObject)

                }
            }
        }
    }
}
