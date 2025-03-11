//
//  shippindAddressViewController.swift
//  Zoetis -Feathers
//
//  Created by PRINCE on 28/09/24.
//

import UIKit

class shippindAddressViewController: BaseViewController , UITextFieldDelegate {
    
    @IBOutlet weak var countryBtn: UIButton!
    @IBOutlet weak var stateBtn: UIButton!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var addressline1TxtFld: UITextField!
    @IBOutlet weak var addressline2TxtFld: UITextField!
    @IBOutlet weak var zipCodeTxtFld: UITextField!
    @IBOutlet weak var addAddressBtn: UIButton!
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var selectedState: UILabel!
    @IBOutlet weak var selectedCity: UILabel!
    @IBOutlet weak var selectedCountry: UILabel!
    
    @IBOutlet weak var fsmName: UILabel!
    
    var curentCertification:VaccinationCertificationVM?
    let maxLengthForTextField1 = 100
    let maxLengthForTextField2 = 7
    var countryList = [VaccinationCountry]()
    var stateList = [VaccinationState]()
    var isSafetyCertification:Bool = false
    var shippingInfo : ShippingAddressDTO?
    var countryId = Int()
    var stateId = Int()
    var trainingId = Int()
    var fssId = Int()
    
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        countryBtn.setTitle("", for: .normal)
        stateBtn.setTitle("", for: .normal)
        cityTextField.tintColor = .black
        addressline1TxtFld.tintColor = .black
        addressline2TxtFld.tintColor = .black
        zipCodeTxtFld.tintColor = .black
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        if curentCertification?.certificationStatus == VaccinationCertificationStatus.draft.rawValue || curentCertification?.certificationStatus == VaccinationCertificationStatus.submitted.rawValue {
            let shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfoByTrainingId(trainingId: self.trainingId)
            if shippingInfoDB != nil {
                
                if curentCertification?.fsmName != "" {
                    fsmName.text = curentCertification?.fsrName
                }
                else
                {
                    fsmName.text =  shippingInfoDB?.fssName
                }
               
                shippingInfo = shippingInfoDB!
                self.addressline1TxtFld.text = shippingInfo?.address1
                self.addressline2TxtFld.text = shippingInfo?.address2
                self.cityTextField.text = shippingInfo?.city
                self.zipCodeTxtFld.text = shippingInfo?.pincode
                var countryId = String(shippingInfo?.countryID ?? 0)
                self.countryId = shippingInfo?.countryID ?? 0
                self.stateId = shippingInfo?.stateID ?? 0
                var countryName = VaccinationCustomersDAO.sharedInstance.fetchCountryNameFromCountryId(countryId: countryId)
                var stateId = String(shippingInfo?.stateID ?? 0)
                var stateName = VaccinationCustomersDAO.sharedInstance.fetchStateNameFromStateId(stateId: stateId)
                if stateName == "" {
                    self.getVaccinationStateList(countryId: countryId)
                    stateName = VaccinationCustomersDAO.sharedInstance.fetchStateNameFromStateId(stateId: stateId)
                    self.selectedState.text = stateName
                }
                self.selectedState.text = stateName
                self.selectedCountry.text = countryName
                self.addressline1TxtFld.text = shippingInfo?.address1
                self.curentCertification?.FSSId = shippingInfo?.fssID
                VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
            }
        }
        else{
            var shippingInfoDB: ShippingAddressDTO?
            if curentCertification?.selectedFsmId == nil || curentCertification?.selectedFsmId == "" {
                shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfo(fssId: Int(self.curentCertification?.fsrId ?? "") ?? 0 )
            }
            else {
                shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfo(fssId: Int(self.curentCertification?.selectedFsmId ?? "") ?? 0 )
            }
            
            if shippingInfoDB != nil {
                shippingInfo = shippingInfoDB!
                
                if curentCertification?.selectedFsmId == nil {
                    fsmName.text =  curentCertification?.fsrName
                }
                else
                {
                    fsmName.text =  curentCertification?.selectedFsmName
                }
                
                self.addressline1TxtFld.text = shippingInfo?.address1
                self.addressline2TxtFld.text = shippingInfo?.address2
                self.cityTextField.text = shippingInfo?.city
                self.zipCodeTxtFld.text = shippingInfo?.pincode
                var countryId = String(shippingInfo?.countryID ?? 0)
                self.countryId = shippingInfo?.countryID ?? 0
                self.stateId = shippingInfo?.stateID ?? 0
                var countryName = VaccinationCustomersDAO.sharedInstance.fetchCountryNameFromCountryId(countryId: countryId)
                var stateId = String(shippingInfo?.stateID ?? 0)
                var stateName = VaccinationCustomersDAO.sharedInstance.fetchStateNameFromStateId(stateId: stateId)
                if stateName == "" {
                    self.getVaccinationStateList(countryId: countryId)
                    stateName = VaccinationCustomersDAO.sharedInstance.fetchStateNameFromStateId(stateId: stateId)
                    self.selectedState.text = stateName
                }
                self.selectedState.text = stateName
                self.selectedCountry.text = countryName
                self.addressline1TxtFld.text = shippingInfo?.address1
                self.curentCertification?.FSSId = shippingInfo?.fssID
                VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
            }
        }
        setBorderView(countryBtn)
        setBorderView(stateBtn)
        setBorderForTxtFld(addressline1TxtFld , padding: 10)
        setBorderForTxtFld(addressline2TxtFld, padding: 10)
        setBorderForTxtFld(cityTextField, padding: 10)
        setBorderForTxtFld(zipCodeTxtFld, padding: 10)
        
        addAddressBtn.setGradient(topGradientColor: UIColor.getEmployeeStartBtnUpperGradient(), bottomGradientColor: UIColor.getDashboardTableHeaderLowerGradColor())
        
        if (self.curentCertification == nil || self.curentCertification?.certificationId == nil){
            if isSafetyCertification || self.curentCertification?.certificationCategoryId == "1"{
                
                if let certobj = VaccinationDashboardDAO.sharedInstance.getStartedCertObjByCategory(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", certificationCategoryId: VaccinationConstants.LookupMaster.SAFETY_CERTIFICATION_CATEGORY_ID){
                    self.curentCertification = certobj
                }
            }
        }
        
        if (self.curentCertification == nil || self.curentCertification?.certificationId == nil){
            if !(self.curentCertification  != nil){
                self.curentCertification = VaccinationCertificationVM()
            }
        }
        
        headerView.roundCorners(corners: [.topLeft, .topRight], radius: 18.5)
        headerView.setGradient(topGradientColor: UIColor.getDashboardTableHeaderUpperGradColor(), bottomGradientColor: UIColor.getDashboardTableHeaderLowerGradColor())
        mainContentView.setGradient(topGradientColor: UIColor.white , bottomGradientColor: UIColor.getAddEmployeeGradient())
        setupUI()
        
        if self.curentCertification?.certificationCategoryId == "1"{
            isSafetyCertification = true
        }
        
        if curentCertification?.certificationStatus == VaccinationCertificationStatus.submitted.rawValue {
            self.addressline1TxtFld.isUserInteractionEnabled = false
            self.addressline2TxtFld.isUserInteractionEnabled = false
            self.cityTextField.isUserInteractionEnabled = false
            self.zipCodeTxtFld.isUserInteractionEnabled = false
            self.countryBtn.isUserInteractionEnabled = false
            self.stateBtn.isUserInteractionEnabled = false
            self.addAddressBtn.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func doneBtnAction(_ sender: Any) {
        countryBtn.setTitle("", for: .normal)
        stateBtn.setTitle("", for: .normal)
        if checkVaidations() {
            self.dismiss(animated: true, completion: nil)
        }
        
        if curentCertification?.selectedFsmId == nil {
            self.shippingInfo?.fssID =  Int(curentCertification?.fsrId ?? "")
        }
        else
        {
            self.shippingInfo?.fssID = Int(self.curentCertification?.selectedFsmId ?? "")
        }
        
        if curentCertification?.certificationId == nil || curentCertification?.certificationId == "0" {
            self.shippingInfo?.trainingID = 0
            self.curentCertification?.TrainingId = 0
        }
        else
        {
            self.shippingInfo?.trainingID =  Int(curentCertification?.certificationId ?? "")
        }
        
        self.shippingInfo?.id = Int(self.curentCertification?.Id ?? 0)
        self.shippingInfo?.fssName = self.fsmName.text
        self.shippingInfo?.countryID = self.countryId
        self.shippingInfo?.stateID = self.stateId
        self.shippingInfo?.address1 = self.addressline1TxtFld.text
        self.shippingInfo?.address2 = self.addressline2TxtFld.text
        self.shippingInfo?.pincode = self.zipCodeTxtFld.text
        var shippingInfoArr = [ShippingAddressDTO]()
        shippingInfoArr.append(shippingInfo!)
        VaccinationCustomersDAO.sharedInstance.saveShippingInfoInDB(newAssessment: shippingInfoArr)
        var shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfo(fssId: Int(self.curentCertification?.selectedFsmId ?? "") ?? 0)
        self.curentCertification?.FSSId = shippingInfo?.fssID
        VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
        
    }
    
    @IBAction func crossBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func countryBtnAction(_ sender: Any) {
        countryList = VaccinationCustomersDAO.sharedInstance.getCountryListVM()
        countryList = countryList.sorted { $0.countryName ?? "" < $1.countryName ?? "" }
        self.setDropDown(countryBtn)
        
    }
    
    @IBAction func StateBtnAction(_ sender: Any) {
        stateList = VaccinationCustomersDAO.sharedInstance.getStateListVM(user_id: UserContext.sharedInstance.userDetailsObj?.userId ?? "No id found")
        stateList = stateList.sorted { $0.stateName ?? "" < $1.stateName ?? "" }
        if selectedCountry.text != "" {
            self.setDropDown(stateBtn)
        }
        else {
            let alertController = UIAlertController(title: "Alert", message: "Please select a country first.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    func checkVaidations() -> Bool {
        var isValidated = Bool()
        if addressline1TxtFld.text == "" && addressline2TxtFld.text == "" && selectedCountry.text == "" && selectedState.text == "" && cityTextField.text == "" && zipCodeTxtFld.text == ""{
            isValidated = false
            addressline1TxtFld.layer.borderColor = UIColor.red.cgColor
            addressline2TxtFld.layer.borderColor = UIColor.red.cgColor
            countryBtn.layer.borderColor = UIColor.red.cgColor
            stateBtn.layer.borderColor = UIColor.red.cgColor
            cityTextField.layer.borderColor = UIColor.red.cgColor
            zipCodeTxtFld.layer.borderColor = UIColor.red.cgColor
        }
        else if addressline1TxtFld.text == ""  {
            isValidated = false
            addressline1TxtFld.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else if addressline2TxtFld.text == ""  {
            isValidated = false
            addressline2TxtFld.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else if selectedCountry.text == "" {
            isValidated = false
            countryBtn.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else if selectedState.text == "" {
            isValidated = false
            stateBtn.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else if cityTextField.text == ""{
            isValidated = false
            cityTextField.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else if zipCodeTxtFld.text == "" {
            isValidated = false
            zipCodeTxtFld.layer.borderColor = UIColor.red.cgColor
            self.showValidationAlert(alertText : "Please fill all the mandatory fields.")
        }
        else {
            isValidated = true
        }
        return isValidated
        
    }
    
    func showValidationAlert(alertText : String) {
        let alertController = UIAlertController(title: "Alert", message: alertText, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func getVaccinationStateList(countryId: String){
        DataService.sharedInstance.getVaccinationStateList(countryId: countryId, viewController: self, completion: { [weak self] (status, error) in
            guard let _ = self, error == nil else { return }
            if status == VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY || status == VaccinationConstants.VaccinationStatus.COREDATA_FETCHED_SUCCESSFULLY{
                let mainQueue = OperationQueue.main
                mainQueue.addOperation{
                    UserContext.sharedInstance.markSynced(apiCallName: .getVaccinationStatesList)
                    
                }
            }
        })
    }
    
    
    func setDropDown(_ btn:UIButton){
                
        if curentCertification?.certificationStatus != VaccinationCertificationStatus.submitted.rawValue{
            var arr = self.countryList.map{ $0.countryName}
            var countryId = String()
            if btn == countryBtn
            {
                arr = self.countryList.map{ $0.countryName}
            }
            else if btn == stateBtn
            {
                arr = self.stateList.map{ $0.stateName}
            }
            
            self.dropDownVIewNew(arrayData: arr as! [String], kWidth: btn.frame.width, kAnchor: btn, yheight: btn.bounds.height) {
                [unowned self] selectedVal, index  in
                
                if btn == stateBtn
                {
                    selectedState.text = selectedVal
                    let element = self.stateList[index]
                    let stateId = element.stateId
                    self.curentCertification?.StateId = Int(element.stateId ?? "")
                    self.shippingInfo?.stateID = Int(element.stateId ?? "")
                    self.stateId = Int(element.stateId ?? "") ?? 0
                    VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
                    if stateBtn.layer.borderColor == UIColor.red.cgColor {
                        stateBtn.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
                    }
                    
                }
                else
                {
                    selectedCountry.text = selectedVal
                    selectedState.text = ""
                    let country = VaccinationCustomersDAO.sharedInstance.fetchCountryIdFromCountryName(countryName: selectedVal)
                    let value = country.first
                    countryId = value?.countryId ?? ""
                    self.getVaccinationStateList(countryId: countryId)
                    let element = self.countryList[index]
                    self.curentCertification?.CountryId = Int(element.countryId ?? "")
                    self.shippingInfo?.countryID = Int(element.countryId ?? "")
                    self.countryId = Int(element.countryId ?? "") ?? 0
                    VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
                    if countryBtn.layer.borderColor == UIColor.red.cgColor {
                        countryBtn.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
                    }
                    
                }
            }
            self.dropHiddenAndShow()
        }
    }
    
    // MARK: - DROP DOWN HIDDEN AND SHOW
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
    func setBorderView(_ btn:UIButton){
        btn.layer.borderWidth  = 2
        btn.layer.borderColor = UIColor.getBorderColorr().cgColor
        btn.layer.cornerRadius = 18.5
        btn.backgroundColor = UIColor.white
    }
    
    
    func setBorderForTxtFld(_ textField:UITextField ,  padding: CGFloat){
        textField.delegate = self
        textField.layer.borderWidth  = 2
        textField.layer.borderColor = UIColor.getBorderColorr().cgColor
        textField.layer.cornerRadius = 18.5
        textField.backgroundColor = UIColor.white
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
    }
    
    
    func setupUI(){
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length
        
        if textField == addressline1TxtFld {
            if addressline1TxtFld.layer.borderColor == UIColor.red.cgColor {
                addressline1TxtFld.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
            }
            
            return newLength <= maxLengthForTextField1
        } else if textField == addressline2TxtFld {
            if addressline2TxtFld.layer.borderColor == UIColor.red.cgColor {
                addressline2TxtFld.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
            }
            
            return newLength <= maxLengthForTextField1
        }else if textField == zipCodeTxtFld {
            guard !string.isEmpty else {
                return true
            }
            if zipCodeTxtFld.layer.borderColor == UIColor.red.cgColor {
                zipCodeTxtFld.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
            }
            let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            let check  = ACCEPTABLE_CHARACTERS.contains(string)
            if check == false {
                return false
            }
            return newLength <= maxLengthForTextField2
        }
        else if textField == cityTextField {
            if cityTextField.layer.borderColor == UIColor.red.cgColor {
                cityTextField.layer.borderColor = UIColor(displayP3Red: 216/255, green: 236/228, blue: 253/255, alpha: 1).cgColor
            }
            
        }
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92){
            
        } else if ((textField.text?.count)! > 45  ){
            return false
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addressline1TxtFld {
            self.curentCertification?.Address1 = textField.text
            self.shippingInfo?.address1 = textField.text
        }
        else if textField == addressline2TxtFld {
            self.curentCertification?.Address2 = textField.text
            self.shippingInfo?.address2 = textField.text
        }
        else if textField == cityTextField {
            self.curentCertification?.City = textField.text
            self.shippingInfo?.city = textField.text
        }
        else if textField == zipCodeTxtFld {
            self.curentCertification?.Pincode = textField.text
            self.shippingInfo?.pincode = textField.text
        }
        
        VaccinationDashboardDAO.sharedInstance.insertLastVisitedModuleName(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", lastModuleName: .AddEmployeesVC, certificationId: curentCertification?.certificationId  ?? "", subModule: nil, certObj: self.curentCertification!)
    }
    
}

