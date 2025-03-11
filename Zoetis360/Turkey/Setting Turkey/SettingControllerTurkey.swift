//
//  SettingControllerTurkey.swift
//  Zoetis -Feathers
//  Created by Manish Behl on 16/03/18.
//  Copyright © 2018 . All rights reserved.

import UIKit
import CoreData
import Alamofire
import Reachability
import SystemConfiguration

class SettingControllerTurkey: UIViewController,UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - VARIABLES
    var quicklinksValue =  Bool()
    var dataSkeletaArray = NSArray ()
    var dataCocoiiArray = NSArray ()
    var dataGiTractArray = NSArray ()
    var dataRespiratoryArray = NSArray ()
    var dataImmuneArray = NSArray ()
    var lngId = NSInteger()
    var dataArray = NSMutableArray()
    var strButtonNmae = String()
    var btnTag = NSInteger()
    var serviceDataHldArr = NSMutableArray()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - OUTLETS
    @IBOutlet weak var skeltaLabel: UILabel!
    @IBOutlet weak var cocodissLabel: UILabel!
    @IBOutlet weak var gitractLabel: UILabel!
    @IBOutlet weak var respLabel: UILabel!
    @IBOutlet weak var immuLabel: UILabel!
    @IBOutlet weak var skeletalMusclarBtnOutlet: UIButton!
    @IBOutlet weak var microscopyBtnOutlet: UIButton!
    @IBOutlet weak var gitractBtnOutlet: UIButton!
    @IBOutlet weak var immuneOtherBtnOutlet: UIButton!
    @IBOutlet weak var respiratoryBtnOutlet: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(SettingControllerTurkey.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifierTurkey"), object: nil)
        
        btnTag = 0
        skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_select"), for: .normal)
        microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
        gitractBtnOutlet.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
        immuneOtherBtnOutlet.setImage(UIImage(named: "immune_unselect"), for: .normal)
        respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
        if WebClass.sharedInstance.connected() {
            if (appDelegate.globalDataArrTurkey.count) > 0 {
                dataArray = appDelegate.globalDataArrTurkey
            }
        }
        self.skeletalMusclarAction(sender: "0" as AnyObject)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 5{
            skeltaLabel.text = "Esquelético/Muscular/Integumental"
            cocodissLabel.text = "Coccidiosis"
            gitractLabel.text = "Tracto gastrointestinal"
            respLabel.text = "Respiratorio"
            immuLabel.text = "Inmune/Otros"
        }
        userNameLbl.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
    }
    
    // MARK: - IBACTIONS
    @IBAction func skeletalMusclarAction(sender: AnyObject) {
        
        btnTag = 0
        if(skeletalMusclarBtnOutlet.isSelected == false){
            skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_select"), for: .normal)
            microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            gitractBtnOutlet.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            immuneOtherBtnOutlet.setImage(UIImage(named: "immune_unselect"), for: .normal)
            respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
            gitractBtnOutlet.setBackgroundImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            respiratoryBtnOutlet.setBackgroundImage(UIImage(named: "respiratory_unselect"), for: .normal)
            
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataSkeletaArray = CoreDataHandlerTurkey().fetchAllSeettingdataWithLngIdTurkey(lngId:lngId as NSNumber)
        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
        
    }
    @IBAction func microscopyBtnAction(sender: AnyObject) {
        btnTag = 1
        if(microscopyBtnOutlet.isSelected == false){
            
            skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_select"), for: .normal)
            gitractBtnOutlet.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            immuneOtherBtnOutlet.setImage(UIImage(named: "immune_unselect"), for: .normal)
            respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
            gitractBtnOutlet.setBackgroundImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            respiratoryBtnOutlet.setBackgroundImage(UIImage(named: "respiratory_unselect"), for: .normal)
        }
        
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataCocoiiArray = CoreDataHandlerTurkey().fetchAllCocoiiDataUsinglngIdTurkey(lngId: lngId as NSNumber)
        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
    }
    @IBAction func gitractBtnAction(sender: AnyObject) {
        strButtonNmae = "gitract"
        btnTag = 2
        if(gitractBtnOutlet.isSelected == false){
            skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            gitractBtnOutlet.setBackgroundImage(UIImage(named: "gi_tract_select"), for: .normal)
            gitractBtnOutlet.setImage(UIImage(named: "gi_tract_select"), for: .normal)
            respiratoryBtnOutlet.setBackgroundImage(UIImage(named: "respiratory_unselect"), for: .normal)
            immuneOtherBtnOutlet.setImage(UIImage(named: "immune_unselect"), for: .normal)
            respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataGiTractArray = CoreDataHandlerTurkey().fetchAllGITractDataUsingLngIdTurkey(lngId: lngId as NSNumber)
        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
        
    }
    @IBAction func respiratoryBtnAction(sender: AnyObject) {
        btnTag = 3
        if (respiratoryBtnOutlet.isSelected == false) {
            skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            gitractBtnOutlet.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            immuneOtherBtnOutlet.setImage(UIImage(named: "immune_unselect"), for: .normal)
            respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_select"), for: .normal)
            respiratoryBtnOutlet.setBackgroundImage(UIImage(named: "respiratory_select"), for: .normal)
            
            gitractBtnOutlet.setBackgroundImage(UIImage(named: "gi_tract_unselect"), for: .normal)
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataRespiratoryArray = CoreDataHandlerTurkey().fetchAllRespiratoryusingLngIdTurkey(lngId: lngId as NSNumber)
        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
    }
    
    
    @IBAction func immuneOthersBtnAction(sender: AnyObject) {
        
        btnTag = 4
        if (immuneOtherBtnOutlet.isSelected == false) {
            skeletalMusclarBtnOutlet.setImage(UIImage(named: "skeletal_unselect"), for: .normal)
            microscopyBtnOutlet.setImage(UIImage(named: "Coccidiosis_unselect"), for: .normal)
            gitractBtnOutlet.setImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            immuneOtherBtnOutlet.setImage(UIImage(named: "immune_select"), for: .normal)
            respiratoryBtnOutlet.setImage(UIImage(named: "respiratory_unselect"), for: .normal)
            gitractBtnOutlet.setBackgroundImage(UIImage(named: "gi_tract_unselect"), for: .normal)
            respiratoryBtnOutlet.setBackgroundImage(UIImage(named: "respiratory_unselect"), for: .normal)
        }
        lngId = UserDefaults.standard.integer(forKey: "lngId")
        dataImmuneArray = CoreDataHandlerTurkey().fetchAllImmuneUsingLngIdTurkey(lngId: lngId as NSNumber)
        Helper.dismissGlobalHUD(self.view)
        self.tblView.reloadData()
    }
    /************* Save Obs in To data Base *********************/
    func callSaveMethod( skeletaArr : NSArray) {
        for i in 0..<skeletaArr.count {
            let strObservationField =
            (skeletaArr.object(at: i) as AnyObject).value(forKey:"ObservationDescription") as! String
            let visibilityCheck = (skeletaArr.object(at: i) as AnyObject)
                .value(forKey:"DefaultQLink") as! Bool
            let obsId = (skeletaArr.object(at: i) as AnyObject).value(forKey:"ObservationId") as! NSInteger
            let visibilitySwitch = (skeletaArr.object(at: i) as AnyObject).value(forKey:"Visibility") as! Bool
            let measure =  (skeletaArr.object(at: i) as AnyObject).value(forKey:"Measure") as! String
            let lngIdValue =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! NSNumber
            let refId =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "ReferenceId") as! NSNumber
            let quickLinkIndex =  (skeletaArr.object(at: i) as AnyObject).value(forKey: "quicklinkIndex") as! Int
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
                CoreDataHandlerTurkey().saveSettingsSkeletaInDatabaseTurkey(strObservationField,visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataSkeletaArray,obsId:obsId,measure:measure,isSync:false,lngId: lngIdValue,refId:refId,quicklinkIndex: quickLinkIndex)
                
            } else if btnTag == 1{
                
                CoreDataHandlerTurkey().saveSettingsCocoiiInDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataCocoiiArray,obsId:obsId,measure:measure,isSync: false,lngId: lngIdValue,refId: refId, quicklinkIndex: quickLinkIndex)
            } else if btnTag == 2{
                
                CoreDataHandlerTurkey().saveSettingsGITractDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataGiTractArray,obsId:obsId,measure:measure,isSync: false,lngId: lngIdValue,refId:refId,quicklinkIndex: quickLinkIndex )
            } else if btnTag == 3{
                
                CoreDataHandlerTurkey().saveSettingsRespiratoryDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataRespiratoryArray,obsId:obsId,measure:measure,isSync:false,lngId: lngIdValue,refId: refId,quicklinkIndex: quickLinkIndex)
            } else {
                CoreDataHandlerTurkey().saveSettingsImmuneDatabaseTurkey(strObservationField, visibilityCheck: isVisibilityCheck, quicklinks: isQuicklinksCheck, strInformation: "xyz", index: i, dbArray:dataImmuneArray,obsId:obsId,measure:measure,isSync:false,lngId: lngIdValue,refId:refId,quicklinkIndex: quickLinkIndex)
            }
        }
    }
    /**************** tableView DataSource & Delegate Methods ***********************************/
    
    
    
    /**************** Action Of CheckBox Button *******************************************/
    @objc func checkBoxClick(_ sender:UIButton){
        sender.isSelected = !sender.isSelected
        if  sender.isSelected {
            sender.isSelected = true
            if  btnTag == 4{
                let cocoii : ImmuneTurkey = dataImmuneArray.object(at: sender.tag) as! ImmuneTurkey
                let obs = cocoii.observationField
                if obs == "Body Weight"{
                    sender.setImage(UIImage(named: "Uncheck_")!, for: .normal)
                }
                else{
                    sender.setImage(UIImage(named: "Check_")!, for: .normal)
                }
            }
            else{
                sender.setImage(UIImage(named: "Check_")!, for: .normal)
            }
        } else {
            
            sender.setImage(nil, for: .normal)
            sender.setImage(UIImage(named: "Uncheck_")!, for: .normal)
        }
        var observationId = NSInteger()
        var  vsibilityValue = Bool()
        
        if btnTag == 0 {
            let skeletaObject : SkeletaTurkey = dataSkeletaArray.object(at: sender.tag) as! SkeletaTurkey
            vsibilityValue = skeletaObject.visibilityCheck as! Bool
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId
            CoreDataHandlerTurkey().updateSettingDataSkeltaTurkey(skeletaObject.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag,dbArray: dataSkeletaArray,obsId:observationId,measure: measure!,isSync: true,lngId: lngIdValue!,refId:refId!)
        } else if  btnTag == 1{
            
            let cocoii : CoccidiosisTurkey = dataCocoiiArray.object(at: sender.tag) as! CoccidiosisTurkey
            vsibilityValue = cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            CoreDataHandlerTurkey().updateSettingDataCocoiiTurkey(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag,dbArray: dataCocoiiArray,obsId: observationId,measure: measure!,isSync: true,lngId: lngIdValue!,refId: refId!)
            
        } else if  btnTag == 2 {
            let skeletaObject : GITractTurkey = dataGiTractArray.object(at: sender.tag) as! GITractTurkey
            vsibilityValue = skeletaObject.visibilityCheck as! Bool
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId
            
            CoreDataHandlerTurkey().updateSettingDataGitractTurkey(skeletaObject.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag,dbArray: dataGiTractArray,obsId: observationId,measure:measure!,isSync:true,lngId: lngIdValue!,refId:refId! )
            
        } else if  btnTag == 3{
            
            let cocoii : RespiratoryTurkey = dataRespiratoryArray.object(at: sender.tag) as! RespiratoryTurkey
            vsibilityValue =
            cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            
            CoreDataHandlerTurkey().updateSettingDataRespTurkey(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag,dbArray: dataRespiratoryArray,obsId: observationId,measure:measure!,isSync:true,lngId: lngIdValue! ,refId:refId!)
            
        } else if  btnTag == 4{
            
            let cocoii : ImmuneTurkey = dataImmuneArray.object(at: sender.tag) as! ImmuneTurkey
            vsibilityValue = cocoii.visibilityCheck as! Bool
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let lngIdValue = cocoii.lngId
            let refId = cocoii.refId
            let obsName = cocoii.observationField
            
            
            
            if obsName == "Body Weight"{
                CoreDataHandlerTurkey().updateSettingDataImmuneTurkey(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: false, strInformation: "xyz", index: sender.tag,dbArray: dataImmuneArray,obsId: observationId,measure: measure!,isSync:true, lngId: lngIdValue!,refId:refId! )
            }
            else{
                
                CoreDataHandlerTurkey().updateSettingDataImmuneTurkey(cocoii.observationField!, visibilityCheck: vsibilityValue, quicklinks: sender.isSelected, strInformation: "xyz", index: sender.tag,dbArray: dataImmuneArray,obsId: observationId,measure: measure!,isSync:true, lngId: lngIdValue!,refId:refId! )
            }
            
        }
    }
    
    //*******************// Action Of Switch Button Action //*******************//*******************//
    @objc func switchClick(_ sender:UISwitch){
        
        let indexpath = NSIndexPath(row:sender.tag, section: 0) 
        
        
        guard let cell :SettingTblCell = tblView.cellForRow(at: indexpath as IndexPath) as? SettingTblCell else{
            
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
            
            let skeletaObject : SkeletaTurkey = dataSkeletaArray.object(at: sender.tag) as! SkeletaTurkey
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let  lngIdValue = skeletaObject.lngId
            let  refId = skeletaObject.refId
            CoreDataHandlerTurkey().updateSettingDataSkeltaTurkey(skeletaObject.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag,dbArray: dataSkeletaArray,obsId:observationId ,measure: measure!,isSync: true,lngId:lngIdValue!,refId:refId!)
        }
        else if btnTag == 1{
            
            let cocoii : CoccidiosisTurkey = dataCocoiiArray.object(at: sender.tag) as! CoccidiosisTurkey
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId
            
            CoreDataHandlerTurkey().updateSettingDataCocoiiTurkey(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag,dbArray: dataCocoiiArray,obsId:observationId,measure: measure!,isSync: true,lngId:lngIdValue!,refId:refId! )
            
        } else if btnTag == 2{
            let skeletaObject : GITractTurkey = dataGiTractArray.object(at: sender.tag) as! GITractTurkey
            observationId = skeletaObject.observationId as! NSInteger
            let measure = skeletaObject.measure
            let  lngIdValue = skeletaObject.lngId
            let refId = skeletaObject.refId
            CoreDataHandlerTurkey().updateSettingDataGitractTurkey(skeletaObject.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag,dbArray: dataGiTractArray,obsId:observationId,measure: measure!,isSync:true,lngId:lngIdValue!,refId:refId!)
            
        }  else if btnTag == 3{
            
            let cocoii : RespiratoryTurkey = dataRespiratoryArray.object(at: sender.tag) as! RespiratoryTurkey
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId
            CoreDataHandlerTurkey().updateSettingDataRespTurkey(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag,dbArray: dataRespiratoryArray,obsId:observationId,measure:measure!,isSync:true,lngId:lngIdValue!,refId:refId!)
            
        } else if btnTag == 4{
            
            let cocoii : ImmuneTurkey = dataImmuneArray.object(at: sender.tag) as! ImmuneTurkey
            observationId = cocoii.observationId as! NSInteger
            let measure = cocoii.measure
            let  lngIdValue = cocoii.lngId
            let  refId = cocoii.refId
            CoreDataHandlerTurkey().updateSettingDataImmuneTurkey(cocoii.observationField!, visibilityCheck: sender.isOn, quicklinks: quicklinksValue, strInformation: "xyz", index: sender.tag,dbArray: dataImmuneArray,obsId: observationId,measure: measure!,isSync:true,lngId:lngIdValue!,refId:refId! )
            
        }
    }
    
    @IBAction func menuBtnAction(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
        
    }
    
    /**********************************************************************************************/
    // MARK: - TABLE VIEW DATA SOURCE AND DELEGATES
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingTblCell
        // or fatalError() or whatever
        
        if indexPath.row % 2 == 0 {
            
            cell.bgView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        } else {
            
            cell.bgView.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
        }
        
        if btnTag == 0 {
            let skeletaObject : SkeletaTurkey = dataSkeletaArray.object(at: indexPath.row) as! SkeletaTurkey
            
            
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
        } else if btnTag == 1{
            
            let cocoii : CoccidiosisTurkey = dataCocoiiArray.object(at: indexPath.row) as! CoccidiosisTurkey
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
            let skeletaObject : GITractTurkey = dataGiTractArray.object(at: indexPath.row) as! GITractTurkey
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
        }  else if btnTag == 3 {
            
            let cocoii : RespiratoryTurkey = dataRespiratoryArray.object(at: indexPath.row) as! RespiratoryTurkey
            cell.lblName.text = cocoii.observationField
            cell.switchView.isOn = cocoii.visibilityCheck as! Bool
            
            if cell.switchView.isOn == true {
                cell.checkBoxOutlet.isUserInteractionEnabled = true
            }  else {
                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }
            
            cell.checkBoxOutlet.isSelected = cocoii.quicklinks as! Bool
            
            if cell.checkBoxOutlet.isSelected == true {
                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {
                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }
        } else if btnTag ==  4{
            
            let cocoii : ImmuneTurkey = dataImmuneArray.object(at: indexPath.row) as! ImmuneTurkey
            cell.lblName.text = cocoii.observationField
            cell.switchView.isOn = cocoii.visibilityCheck as! Bool
            
            
            if cell.switchView.isOn == true {
                cell.checkBoxOutlet.isUserInteractionEnabled = true
            }
            else {
                cell.checkBoxOutlet.isUserInteractionEnabled = false
            }
            
            cell.checkBoxOutlet.isSelected = cocoii.quicklinks as! Bool
            
            
            
            if cell.checkBoxOutlet.isSelected == true {
                cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            } else {
                
                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }
        }
        if btnTag ==  4{
            if  cell.lblName.text == "Body Weight"{
                cell.checkBoxOutlet.isUserInteractionEnabled = false
                cell.checkBoxOutlet.setImage(UIImage(named: "Uncheck_")!, for: .normal)
            }
            //        else{
            //            cell.checkBoxOutlet.isUserInteractionEnabled = true
            //            cell.checkBoxOutlet.setImage(UIImage(named: "Check_")!, for: .normal)
            //        }
        }
        cell.checkBoxOutlet.addTarget(self, action: #selector(SettingControllerTurkey.checkBoxClick(_:)) , for: .touchUpInside )
        cell.switchView.addTarget(self, action: #selector(SettingControllerTurkey.switchClick(_:)) , for: .valueChanged)
        cell.switchView.tag = indexPath.row
        cell.checkBoxOutlet.tag = indexPath.row
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
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
    
    
    // MARK: - METHODS AND FUNCTIONS
    @objc func methodOfReceivedNotification(notification: Notification){
        //Take Action on Notification
        UserDefaults.standard.set(0, forKey: "postingId")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let navigateTo = self.storyboard?.instantiateViewController(withIdentifier: "PostingVCTurkey") as! PostingVCTurkey
        self.navigationController?.pushViewController(navigateTo, animated: false)
    }
    
}

