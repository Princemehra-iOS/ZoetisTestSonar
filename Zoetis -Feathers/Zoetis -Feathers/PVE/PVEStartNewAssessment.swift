//
//  PVEStartNewAssessment.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 11/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
class PVEStartNewAssessment: BaseViewController {
    
    let dropdownManager = ZoetisDropdownShared.sharedInstance
    
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var plusMinusCellArr = [String]()
    
    private var breedOfBirdsArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plusMinusCellArr = ["cellPlusMinus"]
        
      //  showGlobalProgressHUDWithTitle(self.view, title: "")
//
//        fetchtHousingDetailsResponse()
//        fetchtAgeOfBirdsResponse()
//        fetchtBreedOfBirdsResponse()
//        fetchtAssignUserDetailResponse()
//        fetchSiteIdNameResponse()
//        fetchtEvaluatorDetailsResponse()
//        fetchEvaluationForList()
//        fetchEvaluationTypeList()
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionMenu(_ sender: Any) {
        self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
}




extension PVEStartNewAssessment: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return plusMinusCellArr.count
        default:
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        switch indexPath.section {
        case 0:
            height = 410
        case 1:
            height = 65
        case 2:
            height = 125
        default:
            height = 0
        }
        
        return height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0: do {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.startNewAssignmentCell, for: indexPath) as! StartNewAssignmentCell
            cell.customerTxtfield.text = dropdownManager.selectedCustomer
            
            return cell
            
            }
        case 1:do {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.plusMinusCell, for: indexPath) as! CustomCell_AddNewAssessment
            //cell.textLabel?.text = plusMinusCellArr[indexPath.row]
            
            if indexPath.row == 0 {
                cell.plusMinusBtn.setBackgroundImage(UIImage(named: Constants.Image.add_icon), for: UIControl.State.normal)
            }else{
                cell.plusMinusBtn.setBackgroundImage(UIImage(named: Constants.Image.delete_icon), for: UIControl.State.normal)
            }
            
            return cell
            
            }
        default: do {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.addNote_StartNewAssCell, for: indexPath) as! AddNote_StartNewAssCell
            return cell
            
            }
            
        }
    }
    
    @IBAction func addNewCellBtnAction(_ sender: UIButton) {
        print("addNewCellBtnAction")
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tblView)
        let clickedBtnIndPath = self.tblView.indexPathForRow(at:buttonPosition)
        
        tblView.beginUpdates()
        
        if clickedBtnIndPath!.row == 0 {
            let indexPath = IndexPath(row: clickedBtnIndPath!.row - 1, section: clickedBtnIndPath!.section)
            plusMinusCellArr.append("NewCell")
            tblView.insertRows(at: [indexPath], with: .automatic)
        }else{
            let indexPath = IndexPath(row: clickedBtnIndPath!.row, section: clickedBtnIndPath!.section)
            plusMinusCellArr.remove(at: indexPath.row)
            tblView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        tblView.endUpdates()
        view.endEditing(true)
        tblView.reloadData()
    }
    
}



extension CustomCell_AddNewAssessment: UITextFieldDelegate{
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        print(newString)
        //let tagg = self.tag as NSNumber
        
        return true
    }
    
}

//  MARK:------------------------------Button Action and Set Values in Fields-----------------

extension PVEStartNewAssessment{
    
    @IBAction func evaluationDateBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.selection, bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier:  Constants.ControllerIdentifier.datePickerPopupViewController) as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        present(datePickerPopupViewController, animated: false, completion: nil)
    }
    
    @IBAction func evaluationTypeBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.evaluationType, dropDownArr: dropdownManager.sharedEvaluationTypeResArrPVE ?? [])
    }
    
    @IBAction func customerBtnAction(_ sender: UIButton) {
        print("customerBtnAction")
        var customerNamesArray = [String]()
        customerNamesArray = dropdownManager.sharedCustomerNameArrPVE ?? []
        
        if  customerNamesArray.count > 0 {
            self.dropDownVIew(arrayData: customerNamesArray, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) {  selectedVal in
                self.dropdownManager.selectedCustomer = selectedVal
            }
            self.dropHiddenAndShow()
        }
    }
    
    @IBAction func evaluationForBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.evaluationFor, dropDownArr: dropdownManager.sharedEvaluationForResArrPVE ?? [])
    }
    
    @IBAction func siteIdBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.siteId, dropDownArr: dropdownManager.sharedSiteIdNameResArrPVE ?? [])
    }
    
    @IBAction func accountManagerBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.accountManager, dropDownArr: dropdownManager.sharedAssignUserDetailsResArrPVE ?? [])
    }
    
    @IBAction func evaluatorBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.evaluationDetails, dropDownArr: dropdownManager.sharedEvaluatorDetailsResArrPVE ?? [])
    }
    
    @IBAction func breedOfBirdsBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.breedOfBirds, dropDownArr: dropdownManager.sharedBreedOfBirdsResArrPVE ?? [])
    }
    
    @IBAction func ageOfBirdsBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.ageOfBirds, dropDownArr: dropdownManager.sharedAgeOfBirdsResArrPVE ?? [])
    }
    
    @IBAction func housingBtnAction(_ sender: UIButton) {
        setDropdrown(sender, clickedField: Constants.ClickedFieldStartNewAssPVE.housing, dropDownArr: dropdownManager.sharedHousingDetailsResArrPVE ?? [])
    }
    
    func setDropdrown(_ sender: UIButton, clickedField:String, dropDownArr:[String]?){
        
        if  dropDownArr!.count > 0 {
            self.dropDownVIewNew(arrayData: dropDownArr!, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) {  selectedVal,index  in
                self.setValueInTextFields(selectedValue: selectedVal, selectedIndex: index, clickedField: clickedField)
            }
            self.dropHiddenAndShow()
            
        } else {
           // fetchResponse(clickedField: clickedField)
        }
    }
    
//    func fetchResponse(clickedField:String) {
//
//        showGlobalProgressHUDWithTitle(self.view, title: "")
//
//        switch clickedField {
//        case Constants.ClickedFieldStartNewAssPVE.housing:do {
//            fetchtHousingDetailsResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.ageOfBirds:do {
//            fetchtAgeOfBirdsResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.breedOfBirds:do {
//            fetchtBreedOfBirdsResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.accountManager:do {
//            fetchtAssignUserDetailResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.siteId:do {
//            fetchSiteIdNameResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.evaluationDetails:do {
//            fetchtEvaluatorDetailsResponse()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.evaluationFor:do {
//            fetchEvaluationForList()
//            }
//        case Constants.ClickedFieldStartNewAssPVE.evaluationType:do {
//            fetchEvaluationTypeList()
//            }
//
//        default:
//            do {}
//        }
//
//    }
    
    
    func setValueInTextFields(selectedValue: String, selectedIndex: Int, clickedField:String) {
        
        if  let cell = self.tblView.cellForRow(at: IndexPath(row: 0, section: 0) ) as? StartNewAssignmentCell
        {
            switch clickedField {
            case Constants.ClickedFieldStartNewAssPVE.housing:do {
                //self.dropdownManager.selectedHousingDetailsPVE = selectedValue
                cell.housingTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.ageOfBirds:do {
                //self.dropdownManager.selectedAgeOfBirdsPVE = selectedValue
                cell.ageOfBirdsTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.breedOfBirds:do {
                //self.dropdownManager.selectedBreedOfBirdsPVE = selectedValue
                cell.breedOfBirdsTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.accountManager:do {
                //self.dropdownManager.selectedAssignUserDetailsPVE = selectedValue
                cell.accManagerTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.siteId:do {
                //self.dropdownManager.sharedSiteIdNameResArrPVE = selectedValue
                cell.siteIdTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.evaluationFor:do {
                //self.dropdownManager.sharedEvaluationForResArrPVE = selectedValue
                cell.evaluationForTxtfield.text = selectedValue
                }
            case Constants.ClickedFieldStartNewAssPVE.evaluationType:do {
                //self.dropdownManager.sharedEvaluationForResArrPVE = selectedValue
                cell.evaluationTypeTxtfield.text = selectedValue
                }
                
            default:
                do {}
            }
        }
        
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.pveStoryboard, bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.ControllerIdentifier.PVEFinalizeSNA) as! PVEStartNewAssFinalizeAssement
        navigationController?.pushViewController(vc, animated: true)

       // fetchtAssessmentCategoriesResponse()
    }
    
}

// MARK: - Other Delegates -------------Date Picker Delegate------------------

extension PVEStartNewAssessment: DatePickerPopupViewControllerProtocol{
    func doneButtonTapped(string:String){
        
        if  let cell = self.tblView.cellForRow(at: IndexPath(row: 0, section: 0) ) as? StartNewAssignmentCell
        {
            cell.evaluationDateTxtfield.text = string
        }
        
    }
}

/*
// MARK: ------------------------------Fetch & handle Response Data-----------------

extension PVEStartNewAssessment{
    
    //---fetchEvaluationTypeList-------------
    
    private func fetchEvaluationTypeList(){
        ZoetisWebServices.shared.getEvaluationTypeForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleEvaluationTypeResponse(json)
        })
    }
    
    private func handleEvaluationTypeResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetEvaluationTypeResponse(json)
        dropdownManager.sharedEvaluationTypeResArrPVE = jsonObject.getEvaluationTypes(dataArray: jsonObject.evaluationTypeArr ?? [])
        dropdownManager.sharedEvaluationTypeResPVE =  jsonObject.evaluationTypeArr ?? []

    }
    
    //---fetchEvaluationTypeList-------------
    
    private func fetchEvaluationForList(){
        ZoetisWebServices.shared.getEvaluationForForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleEvaluationForResponse(json)
        })
    }
    
    private func handleEvaluationForResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetEvaluationForResponse(json)
        dropdownManager.sharedEvaluationForResArrPVE = jsonObject.getEvaluationFor(dataArray: jsonObject.evaluationForArr ?? [])
        dropdownManager.sharedEvaluationForResPVE =  jsonObject.evaluationForArr ?? []
//
    }
    
    //---fetchSiteIdNameResponse-------------
    
    private func fetchSiteIdNameResponse(){
        ZoetisWebServices.shared.getSiteIdNameForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleSiteIdNameResponse(json)
        })
    }
    
    private func handleSiteIdNameResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetSiteIdNameResponse(json)
        dropdownManager.sharedSiteIdNameResArrPVE = jsonObject.getSiteIdNameResponse(dataArray: jsonObject.siteIdNameArr ?? [])
        dropdownManager.sharedSiteIdNameResPVE =  jsonObject.siteIdNameArr ?? []

    }
    
    //---fetchSiteIdNameResponse-------------
    
    private func fetchtAgeOfBirdsResponse(){
        ZoetisWebServices.shared.getAgeOfBirdsForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleAgeOfBirdsResponse(json)
        })
    }
    
    private func handleAgeOfBirdsResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetAgeOfBirdsResponse(json)
        dropdownManager.sharedAgeOfBirdsResArrPVE = jsonObject.getAgeOfBirdsResponse(dataArray: jsonObject.ageOfBirdsArr ?? [])
        dropdownManager.sharedAgeOfBirdsResPVE =  jsonObject.ageOfBirdsArr ?? []

    }
    
    //---fetchtBreedOfBirdsResponse-------------
    
    private func fetchtBreedOfBirdsResponse(){
        ZoetisWebServices.shared.getBreedOfBirdsForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleBreedOfBirdsResponse(json)
        })
    }
    
    private func handleBreedOfBirdsResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetBreedOfBirdsResponse(json)
        dropdownManager.sharedBreedOfBirdsResArrPVE = jsonObject.getBreedOfBirdsResponse(dataArray: jsonObject.breedOfBirdsArr ?? [])
        dropdownManager.sharedBreedOfBirdsResPVE = jsonObject.breedOfBirdsArr ?? []
        
    }
    
    //---fetchtHousingDetailsResponse-------------
    
    private func fetchtHousingDetailsResponse(){
        ZoetisWebServices.shared.getHousingDetailsForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleHousingDetailsResponse(json)
        })
    }
    
    private func handleHousingDetailsResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetHousingDetailsResponse(json)
        dropdownManager.sharedHousingDetailsResArrPVE = jsonObject.getHousingDetailsResponse(dataArray: jsonObject.housingArr ?? [])
        dropdownManager.sharedHousingDetailsResPVE =  jsonObject.housingArr ?? []
    }
    
    //---fetchtHousingDetailsResponse-------------Zoetis Account Manager
    
    private func fetchtAssignUserDetailResponse(){
        ZoetisWebServices.shared.getAssignUserDetailForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleAssignUserDetailResponse(json)
        })
    }
    
    private func handleAssignUserDetailResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetAssignUserDetailsResponse(json)
        dropdownManager.sharedAssignUserDetailsResArrPVE = jsonObject.getHousingDetailsResponse(dataArray: jsonObject.userDetailsArr ?? [])
        dropdownManager.sharedAssignUserDetailsResPVE =  jsonObject.userDetailsArr ?? []

    }
    
    //---fetchtEvaluatorDetailsResponse-------------Zoetis Account Manager
    
    private func fetchtEvaluatorDetailsResponse(){
        ZoetisWebServices.shared.getEvaluatorDetailForPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleEvaluatorDetailsResponse(json)
        })
    }
    
    private func handleEvaluatorDetailsResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetEvaluatorDetailsResponse(json)
        dropdownManager.sharedEvaluatorDetailsResArrPVE = jsonObject.getEvaluatorDetails(dataArray: jsonObject.evaluatorArr ?? [])
        dropdownManager.sharedEvaluatorDetailsResPVE =  jsonObject.evaluatorArr ?? []

    }

    // ---- Fetch Category Details for PVE -----------------
    
    private func fetchtAssessmentCategoriesResponse(){
        showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getAssessmentCategoriesDetailsPVE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleAssessmentCategoriesResponse(json)
        })
    }
    
    private func handleAssessmentCategoriesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEAssessmentCategoriesDetailsResponse(json)
        dropdownManager.sharedAssCategoriesDetailsResArrPVE = jsonObject.getCategoriesDetailsResponse(dataArray: jsonObject.categoriesDetailsArr ?? [])
        dropdownManager.sharedAssCategoriesDetailsResPVE =  jsonObject.categoriesDetailsArr ?? []
        
        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.pveStoryboard, bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Constants.ControllerIdentifier.PVEFinalizeSNA) as! PVEStartNewAssFinalizeAssement
        navigationController?.pushViewController(vc, animated: true)

    }

}
*/
