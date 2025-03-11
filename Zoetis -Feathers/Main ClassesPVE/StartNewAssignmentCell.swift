//
//  StartNewAssignmentNoteCell.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 16/12/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit

class StartNewAssignmentCell: UITableViewCell {
    
    let sharedManager = PVEShared.sharedInstance
    var timeStampStr = ""
    
    @IBOutlet weak var cameraImg: UIImageView!
    
    @IBOutlet weak var evaluationDateBtn: UIButton!
    @IBOutlet weak var customerBtn: UIButton!
    @IBOutlet weak var accManagerBtn: UIButton!
    @IBOutlet weak var breedOfBirdsBtn: UIButton!
    @IBOutlet weak var housingBtn: UIButton!
    @IBOutlet weak var evaluationForBtn: UIButton!
    @IBOutlet weak var siteIdBtn: UIButton!
    @IBOutlet weak var evaluatorBtn: UIButton!
    @IBOutlet weak var ageOfBirdsBtn: UIButton!
    
    @IBOutlet weak var breedOfBirdsOtherBtn: UIButton!
    @IBOutlet weak var breedOfBirdsFemaleBtn: UIButton!
    @IBOutlet weak var breedOfBirdsOtherTxtfield: UITextField!
    @IBOutlet weak var breedOfBirdsFemaleTxtfield: UITextField!
    @IBOutlet weak var breedOfBirdsFemaleOtherBtn: UIButton!
    @IBOutlet weak var breedOfBirdsFemaleOtherTxtfield: UITextField!
    
    
    @IBOutlet weak var evaluationDateTxtfield: UITextField!
    @IBOutlet weak var customerTxtfield: UITextField!
    @IBOutlet weak var accManagerTxtfield: UITextField!
    @IBOutlet weak var breedOfBirdsTxtfield: UITextField!
    @IBOutlet weak var housingTxtfield: UITextField!
    @IBOutlet weak var evaluationForTxtfield: UITextField!
    @IBOutlet weak var siteIdTxtfield: UITextField!
    @IBOutlet weak var evaluatorTxtfield: UITextField!
    @IBOutlet weak var ageOfBirdsTxtfield: UITextField!
    
    @IBOutlet weak var farmNameBtn: UIButton!
    @IBOutlet weak var farmNameTxtfield: UITextField!
    @IBOutlet weak var houseNoBtn: UIButton!
    @IBOutlet weak var houseNoTxtfield: UITextField!
    @IBOutlet weak var noOfBirdsBtn: UIButton!
    @IBOutlet weak var noOfBirdsTxtfield: UITextField!
    
    
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var birdWelfareImg : UIImageView!
    @IBOutlet weak var birdPresentationImg : UIImageView!
    @IBOutlet weak var cameraToggleSuperView: UIView!
    @IBOutlet weak var breesOfBirdsSuperView: UIView!
    @IBOutlet weak var farmNameSuperView: UIView!
    
    @IBOutlet weak var breesOfBirdsTitleLbl: UILabel!
    @IBOutlet weak var breesOfBirdsMaleOtherSuperView: UIView!
    @IBOutlet weak var breesOfBirdsFemaleOtherSuperView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let btns = [evaluationDateBtn,accManagerBtn,breedOfBirdsBtn,housingBtn,evaluationForBtn,evaluatorBtn,ageOfBirdsBtn,farmNameBtn,houseNoBtn,noOfBirdsBtn, breedOfBirdsOtherBtn, breedOfBirdsFemaleBtn, breedOfBirdsFemaleOtherBtn]
        for btn in btns{
            
            let superviewCurrent =  btn?.superview
            for view in superviewCurrent!.subviews {
                if view.isKind(of:UIButton.self) {
                    if view == evaluationDateBtn{
                        view.setDropdownStartAsessmentView(imageName:"calendarIconPE")
                    } else{
                        view.setDropdownStartAsessmentView(imageName:"dd")
                    }
                }
            }
        }
        
    }
    
    func getDraftValueForKey(key:String) -> Any{
        let valuee = CoreDataHandlerPVE().fetchDraftForSyncId(type: "draft", syncId: timeStampStr)
        let valueArr = valuee.value(forKey: key) as! NSArray
        return valueArr[0]
    }
    
    func selectButton(){
        var selectedBirdTypeId = Int()
        
        if timeStampStr.count > 0 {
            selectedBirdTypeId = getDraftValueForKey(key: "selectedBirdTypeId") as! Int
        }else{
            selectedBirdTypeId = sharedManager.getSessionValueForKeyFromDB(key: "selectedBirdTypeId") as! Int
        }
        if selectedBirdTypeId == 14 {
            birdWelfareImg.image = UIImage(named: "checkIconPE")
            birdPresentationImg.image = UIImage(named: "uncheckIconPE")
        }else{
            birdWelfareImg.image = UIImage(named: "uncheckIconPE")
            birdPresentationImg.image = UIImage(named: "checkIconPE")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        var cameraBtnSelected = String()
        if sender.isOn == true {
            cameraBtnSelected = "true"
        }else{
            cameraBtnSelected = "false"
        }
        
        if timeStampStr.count > 0 {
            CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: cameraBtnSelected, forAttribute: "cameraEnabled")
        }else{
            CoreDataHandlerPVE().updateSessionDetails(1, text: cameraBtnSelected, forAttribute: "cameraEnabled")
        }
    }
    
    
    @IBAction func birdWelfareBtnAction(_ sender: UIButton) {
        
        birdWelfareImg.image = UIImage(named: "checkIconPE")
        birdPresentationImg.image = UIImage(named: "uncheckIconPE")
        
        if timeStampStr.count > 0 {
            CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: 14, forAttribute: "selectedBirdTypeId")
            CoreDataHandlerPVE().updateStatusForSync(timeStampStr, text: false, forAttribute: "syncedStatus")
            
        }else{
            
            CoreDataHandlerPVE().updateSessionDetails(1, text: 14, forAttribute: "selectedBirdTypeId")
        }
        
    }
    
    @IBAction func birdPresentationBtnAction(_ sender: UIButton) {
        
        birdWelfareImg.image = UIImage(named: "uncheckIconPE")
        birdPresentationImg.image = UIImage(named: "checkIconPE")
        if timeStampStr.count > 0 {
            CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: 13, forAttribute: "selectedBirdTypeId")
            CoreDataHandlerPVE().updateStatusForSync(timeStampStr, text: false, forAttribute: "syncedStatus")
        }else{
            CoreDataHandlerPVE().updateSessionDetails(1, text: 13, forAttribute: "selectedBirdTypeId")
        }
    }
}

extension StartNewAssignmentCell: UITextFieldDelegate{
    
    func dismissKeyboard() {
        self.endEditing(true)
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == ageOfBirdsTxtfield || textField == noOfBirdsTxtfield{
            guard CharacterSet(charactersIn: "1234567890").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
            
        }
        
        var newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        if textField == ageOfBirdsTxtfield || textField == noOfBirdsTxtfield{
            if newString.count > 5{
                return false
            }
            let sum = newString.compactMap{$0.wholeNumberValue}.reduce(0, +)
            if sum == 0 && newString.count > 0{
                newString = "0"
                return false
            }
            
        }
        
        if textField == ageOfBirdsTxtfield{
            
            if timeStampStr.count > 0 {
                CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: Int(newString) ?? 0, forAttribute: "ageOfBirds")
            }else{
                CoreDataHandlerPVE().updateSessionDetails(1, text: Int(newString) ?? 0, forAttribute: "ageOfBirds")
            }
            self.sharedManager.setBorderBlue(btn: ageOfBirdsBtn)
        }
        if textField == farmNameTxtfield{
            if newString.count > 40{
                return false
            }
            
            CoreDataHandlerPVE().updateSessionDetails(1, text: newString ?? "", forAttribute: "farm")
            self.sharedManager.setBorderBlue(btn: farmNameBtn)
        }
        if textField == houseNoTxtfield{
            if newString.count > 40{
                return false
            }
            
            if timeStampStr.count > 0 {
                CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: newString ?? "", forAttribute: "houseNumber")
            }else{
                CoreDataHandlerPVE().updateSessionDetails(1, text: newString ?? "", forAttribute: "houseNumber")
            }
            self.sharedManager.setBorderBlue(btn: houseNoBtn)
        }
        if textField == noOfBirdsTxtfield{
            if timeStampStr.count > 0 {
                CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: Int(newString) ?? 0, forAttribute: "noOfBirds")
            }else{
                CoreDataHandlerPVE().updateSessionDetails(1, text: Int(newString) ?? 0, forAttribute: "noOfBirds")
            }
            self.sharedManager.setBorderBlue(btn: noOfBirdsBtn)
        }
        
        if textField == breedOfBirdsOtherTxtfield{
            if newString.count > 40{
                return false
            }
            
            if timeStampStr.count > 0 {
                CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: newString ?? "", forAttribute: "breedOfBirdsOther")
            }else{
                CoreDataHandlerPVE().updateSessionDetails(1, text: newString ?? "", forAttribute: "breedOfBirdsOther")
            }
            self.sharedManager.setBorderBlue(btn: breedOfBirdsOtherBtn)
        }
        if textField == breedOfBirdsFemaleOtherTxtfield{
            if newString.count > 40{
                return false
            }
            
            if timeStampStr.count > 0 {
                CoreDataHandlerPVE().updateDraftSNAFor(timeStampStr, syncedStatus: false, text: newString ?? "", forAttribute: "breedOfBirdsFemaleOther")
            }else{
                CoreDataHandlerPVE().updateSessionDetails(1, text: newString ?? "", forAttribute: "breedOfBirdsFemaleOther")
            }
            self.sharedManager.setBorderBlue(btn: breedOfBirdsFemaleOtherBtn)
        }
        let dataSavedInDB =  CoreDataHandlerPVE().fetchCurrentSessionInDB()
        
        return true
    }
    
}
