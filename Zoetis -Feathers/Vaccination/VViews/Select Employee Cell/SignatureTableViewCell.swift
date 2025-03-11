//
//  SignatureTableViewCell.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 29/05/20.
//  Copyright © 2020 . All rights reserved.
//

import UIKit

class SignatureTableViewCell: UITableViewCell, SignatureViewDelegate  {
    
    // MARK: - OUTLETS
    
    
    @IBOutlet weak var shippindAddressBtn: UIButton!
    
    @IBOutlet weak var shipToLbl: UILabel!
    @IBOutlet weak var deviceOperatorNamebl: UILabel!
    @IBOutlet weak var operatorSignLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var signImgVw: UIImageView!
    @IBOutlet weak var operatornameConstraint: NSLayoutConstraint!
    @IBOutlet weak var operatorNameTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var signView: SignatureView!
    
    
    // MARK: - VARIABLES
    
    var employeesAddedArr = [VaccinationEmployeeVM]()
    var empIndex = -1
    var rowIndex = -1
    var signImage:UIImage?
    var prevController = ""
    var fromScreen = ""
    var certificateData : [PECertificateData] = []
    var blockSignature : (([PECertificateData])-> Void)?
    var isRunningBack = false
    var isRunningForward = false
    var index = -1
    static let identifier = "signatureTableViewCell"
    var curentCertification:VaccinationCertificationVM?
    var regionID = Int()
    class var classIdentifier: String {
        return String(describing: self)
    }
    class var nib: UINib {
        return UINib(nibName: classIdentifier, bundle: nil)
    }
    
    // MARK: - INITIALIZATION METHODS
    
    override func awakeFromNib() {
        super.awakeFromNib()
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        setBordeViewWithColor(signView)
        nextBtn.setGradient(topGradientColor: UIColor.getEmployeeStartBtnUpperGradient(), bottomGradientColor: UIColor.getDashboardTableHeaderLowerGradColor())
        clearBtn.setGradient(topGradientColor: UIColor.getEmployeeStartBtnUpperGradient(), bottomGradientColor: UIColor.getDashboardTableHeaderLowerGradColor())
        
        previousBtn.setGradient(topGradientColor: UIColor.getViewCertUpperGradColor() , bottomGradientColor: UIColor.getViewCertLowerGradColor())
        self.signView.delegate = self
        previousBtn.isHidden = true
        
        shippindAddressBtn.setTitleColor(.white, for: .normal)
        shippindAddressBtn.layer.cornerRadius = 10
        
        shippindAddressBtn.setGradient(topGradientColor: UIColor.getEmployeeStartBtnUpperGradient(), bottomGradientColor: UIColor.getDashboardTableHeaderLowerGradColor())
        
    }
    
    func animateButton(button: UIButton) {
        UIView.animate(withDuration: 0.6, delay: 0, options: [.repeat, .autoreverse], animations: {
            button.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        })
    }
    
    func glowEffect(button: UIButton) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 10
            button.isUserInteractionEnabled = true
            
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = button.bounds
            gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
            button.layer.insertSublayer(gradientLayer, at: 0)
            
        })
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - IBACTIONS
    @IBAction func nextBtnAction(_ sender: UIButton) {
        if fromScreen == "PEFinishPopUpScreen" {
            empIndex += 1
            signView.clearCanvas()
            if empIndex > -1  {
                var fullName = ""
                if certificateData.count > empIndex {
                    let firstname = certificateData[empIndex].name
                    fullName = firstname ?? ""
                    fullName = "\(firstname ?? "") "
                    
                    operatorSignLbl.text = "Vaccine Mixer Signature*"
                    operatorSignLbl.text = operatorSignLbl.text  ?? "" + "*"
                    deviceOperatorNamebl.text  = "Vaccine Mixer Name: \(fullName)"
                    showImgVw(true)
                    
                    if (certificateData[empIndex].isSigned){
                        hideShowImgVw(false)
                        signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                    }
                    if !(certificateData[empIndex].isCertExpired)! && (prevController == "Rejected"){
                        hideShowImgVw(false)
                        if certificateData[empIndex].signatureImg == "" {
                            hideShowImgVw(true)
                        }
                        else {
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        }
                    }
                    
                    else if !(certificateData[empIndex].isCertExpired)! && (prevController == "Draft"){
                        hideShowImgVw(false)
                        signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        if certificateData[empIndex].signatureImg == "" {
                            hideShowImgVw(true)
                        }
                    }
                    
                    else if (certificateData[empIndex].isCertExpired)! && (prevController == "Draft") {
                        hideShowImgVw(false)
                        if certificateData[empIndex].signatureImg == "" {
                            hideShowImgVw(true)
                        }
                        else {
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        }
                    }
                    
                }
            }
            if empIndex > 0{
                previousBtn.isEnabled = true
                previousBtn.isUserInteractionEnabled = true
                previousBtn.isHidden = false
            }
            
            if empIndex > -1 && empIndex == certificateData.count {
                operatorSignLbl.text =  "FSR Signature"
                deviceOperatorNamebl.text  = "Zoetis Representative: " + String(UserDefaults.standard.value(forKey: "FirstName") as? String ?? "") + " " + String(UserDefaults.standard.value(forKey: "LastName") as? String ?? "")
                nextBtn.isUserInteractionEnabled = false
                nextBtn.isHidden = true
                for item in certificateData {
                    
                    if item.fsrSign != "" {
                        signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[0].fsrSign)
                        hideShowImgVw(false)
                        
                    }
                    else {
                        if(certificateData[0].fsrSign != ""){
                            hideShowImgVw(false)
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[0].fsrSign)
                        }
                        else{
                            hideShowImgVw(true)
                        }
                    }
                }
                
                if let isSignedFSR = UserDefaults.standard.value(forKey: "isSignedFSR") as? Bool {
                    if isSignedFSR {
                        hideShowImgVw(false)
                        
                        if let signatureImg = UserDefaults.standard.value(forKey: "FsrSign") as? String {
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:signatureImg)
                        }
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex
                                                                                                                              ])
        }
        else {
            empIndex += 1
            signView.clearCanvas()
            if empIndex > -1 && empIndex == employeesAddedArr.count + 1 {
                var fullName = ""
                let firstname = UserContext.sharedInstance.userDetailsObj?.firstname
                let lastName = UserContext.sharedInstance.userDetailsObj?.lastName
                fullName = firstname ?? ""
                if lastName != nil && lastName != ""{
                    fullName = "\(firstname ?? "") \(lastName!)"
                }
                operatorSignLbl.text = "Field Service Technician Signature*"
                operatorSignLbl.text = operatorSignLbl.text  ?? "" + "*"
                deviceOperatorNamebl.text  = "Field Service Technician: \(fullName)"
                if curentCertification?.fsrSignature != nil && !(curentCertification?.fsrSignature!.isEmpty)!{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:(curentCertification?.fsrSignature!)! )
                }else{
                    hideShowImgVw(true)
                }
                
            }
            if empIndex > -1 && empIndex == employeesAddedArr.count{
                operatorSignLbl.text = "Hatchery Manager Signature"
                deviceOperatorNamebl.text  = "Hatchery Manager Name: "
                if curentCertification?.fsmName != nil{
                    var hName = ""
                    hName = (curentCertification?.fsmName)!
                    deviceOperatorNamebl.text  = "Hatchery Manager Name: \(hName)"
                    
                }
                if curentCertification?.hatcheryManagerSign != nil && !(curentCertification?.hatcheryManagerSign!.isEmpty)!{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:(curentCertification?.hatcheryManagerSign!)! )
                }else{
                    hideShowImgVw(true)
                }
                
            }
            if empIndex > -1 && empIndex < employeesAddedArr.count {
                let emp = employeesAddedArr[empIndex]
                deviceOperatorNamebl.text = getEmpName(empobj:emp)
                if emp.signBase64 != nil && !emp.signBase64!.isEmpty{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:emp.signBase64! )
                }else{
                    hideShowImgVw(true)
                }
            }
            if empIndex > 0{
                previousBtn.isEnabled = true
                previousBtn.isUserInteractionEnabled = true
                previousBtn.isHidden = false
            }
            if empIndex == employeesAddedArr.count + 2 - 1 {
                nextBtn.isEnabled = false
                nextBtn.isUserInteractionEnabled = false
                nextBtn.isHidden = true
                previousBtn.isEnabled = true
                previousBtn.isUserInteractionEnabled = true
                previousBtn.isHidden = false
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex
                                                                                                                              ])
        }
    }
    
    @IBAction func previousBtnAction(_ sender: UIButton) {
        
        if fromScreen == "PEFinishPopUpScreen" {
            empIndex -= 1
            signView.clearCanvas()
            nextBtn.isUserInteractionEnabled = true
            nextBtn.isHidden = false
            if empIndex == 0 {
                previousBtn.isHidden = true
            }
            if empIndex > -1  && certificateData.count > empIndex {
                var fullName = ""
                let firstname = certificateData[empIndex].name
                fullName = firstname ?? ""
                fullName = "\(firstname ?? "") "
                nextBtn.isUserInteractionEnabled = true
                operatorSignLbl.text = "Vaccine Mixer Signature*"
                operatorSignLbl.text = operatorSignLbl.text  ?? "" + "*"
                deviceOperatorNamebl.text  = "Vaccine Mixer Name: \(fullName)"
                hideShowImgVw(true)
                if certificateData[empIndex].isSigned {
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                }
                
                if regionID == 3
                {
                    if !(certificateData[empIndex].isCertExpired)! {
                        hideShowImgVw(false)
                        if certificateData[empIndex].signatureImg == "" {
                            hideShowImgVw(true)
                        }
                        else {
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        }
                    }
                    else
                    {
                        hideShowImgVw(false)
                        if certificateData[empIndex].signatureImg == "" {
                            hideShowImgVw(true)
                        }
                        else {
                            signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        }
                    }
                }
                else
                
                {
                    hideShowImgVw(false)
                    if certificateData[empIndex].signatureImg == "" {
                        hideShowImgVw(true)
                    }
                    else {
                        
                        signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].signatureImg)
                        hideShowImgVw(false)
                    }
                    
                }
            }
            
            if empIndex > -1 && empIndex == certificateData.count {
                operatorSignLbl.text =  "Manager Signature"
                deviceOperatorNamebl.text  = "Manager Name: "
                nextBtn.isUserInteractionEnabled = false
                
                if let isSignedFSR = UserDefaults.standard.value(forKey: "isSignedFSR") as? Bool {
                    if isSignedFSR {
                        hideShowImgVw(false)
                        
                        if let signatureImg = UserDefaults.standard.value(forKey: "FsrSign") as? String {
                            if signatureImg == "" {
                                hideShowImgVw(false)
                            }
                            else {
                                signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:signatureImg)
                            }
                        }
                    }
                }
                if certificateData[empIndex - 1].fsrSign != "" {
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:certificateData[empIndex].fsrSign)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex
                                                                                                                              ])
        }
        else {
            empIndex -= 1
            signView.clearCanvas()
            
            if empIndex > -1 && empIndex == employeesAddedArr.count + 1 {
                var fullName = ""
                let firstname = UserContext.sharedInstance.userDetailsObj?.firstname
                let lastName = UserContext.sharedInstance.userDetailsObj?.lastName
                fullName = firstname ?? ""
                if lastName != nil && lastName != ""{
                    fullName = "\(firstname ?? "") \(lastName!)"
                }
                operatorSignLbl.text = "Field Service Technician Signature*"
                operatorSignLbl.text = operatorSignLbl.text  ?? "" + "*"
                deviceOperatorNamebl.text  = "Field Service Technician: \(fullName)"
                if curentCertification?.fsrSignature != nil && !(curentCertification?.fsrSignature!.isEmpty)!{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:(curentCertification?.fsrSignature!)! )
                }else{
                    hideShowImgVw(true)
                }
            }
            if empIndex > -1 && empIndex == employeesAddedArr.count{
                operatorSignLbl.text = "Hatchery Manager Signature"
                deviceOperatorNamebl.text  = "Hatchery Manager Name: "
                if curentCertification?.fsmName != nil{
                    var hName = ""
                    hName = (curentCertification?.fsmName)!
                    deviceOperatorNamebl.text  = "Hatchery Manager Name: \(hName)"
                }
                
                if curentCertification?.hatcheryManagerSign != nil && !(curentCertification?.hatcheryManagerSign!.isEmpty)!{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:(curentCertification?.hatcheryManagerSign!)! )
                }else{
                    hideShowImgVw(true)
                }
                
            }
            if empIndex > -1 && empIndex < employeesAddedArr.count {
                operatorSignLbl.text = "Device Operator Signature*"
                operatorSignLbl.text = operatorSignLbl.text ?? "" + "*"
                
                let emp = employeesAddedArr[empIndex]
                deviceOperatorNamebl.text = getEmpName(empobj:emp)
                
                if emp.signBase64 != nil && !emp.signBase64!.isEmpty{
                    hideShowImgVw(false)
                    signImgVw.image = CodeHelper.sharedInstance.convertToImage(base64:emp.signBase64!)
                }else{
                    hideShowImgVw(true)
                }
            }
            if empIndex == 0{
                
                previousBtn.isEnabled = false
                previousBtn.isUserInteractionEnabled = false
                previousBtn.isHidden = true
                nextBtn.isEnabled = true
                nextBtn.isUserInteractionEnabled = true
                nextBtn.isHidden = false
            }
            if  employeesAddedArr.count > 0{
                nextBtn.isEnabled = true
                nextBtn.isUserInteractionEnabled = true
                nextBtn.isHidden = false
            }
            if empIndex == employeesAddedArr.count + 2 {
                nextBtn.isEnabled = false
                nextBtn.isUserInteractionEnabled = false
                nextBtn.isHidden = true
            }
            if empIndex == employeesAddedArr.count + 2 {
                nextBtn.isEnabled = false
                nextBtn.isUserInteractionEnabled = false
                nextBtn.isHidden = true
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex
                                                                                                                              ])
            
        }
    }
    
    @IBAction func clearBtnAction(_ sender: UIButton) {
        if fromScreen == "PEFinishPopUpScreen" {
            
            var base64 = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex, "hasSignCleared": true
                                                                                                                              ])
            if empIndex > -1 &&  certificateData.count > empIndex {
                certificateData[empIndex].isSigned = false
                certificateData[empIndex].signatureImg = base64
            }
            
            if empIndex > -1 && empIndex == certificateData.count{
                
                if let isSignedFSR = UserDefaults.standard.value(forKey: "isSignedFSR") as? Bool {
                    if isSignedFSR {
                        hideShowImgVw(false)
                        
                        if let signatureImg = UserDefaults.standard.value(forKey: "FsrSign") as? String {
                            UserDefaults.standard.setValue(nil, forKey: "FsrSign")
                            UserDefaults.standard.setValue(false, forKey: "isSignedFSR")
                        }
                    }
                }
                var k = 0
                for item in certificateData {
                    
                    certificateData[k].fsrSign = ""
                    k = k + 1
                }
            }
            hideShowImgVw(true)
            signView.clearCanvas()
            
        }
        else {
            var base64 = ""
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex, "hasSignCleared": true
                                                                                                                              ])
            if empIndex > -1 && empIndex == employeesAddedArr.count + 1 {
                curentCertification?.fsrSignature = base64
            }
            
            if empIndex > -1 && empIndex == employeesAddedArr.count{
                curentCertification?.hatcheryManagerSign = base64
            }
            
            if rowIndex == 1 && employeesAddedArr.count > 0 && empIndex > -1 && employeesAddedArr.count > empIndex{
                var emp = employeesAddedArr[empIndex]
                emp.signBase64 = base64
                employeesAddedArr[empIndex] = emp
            }
            
            if empIndex > -1 && employeesAddedArr.count > empIndex{
                var emp = employeesAddedArr[empIndex]
                emp.signBase64 = base64
                employeesAddedArr[empIndex] = emp
            }
            hideShowImgVw(true)
            signView.clearCanvas()
        }
    }
    
    @IBAction func shippingBtnAction(_ sender: UIButton) {
        print("Test Message",appDelegate.testFuntion())
    }
    
    // MARK: - METHODS
    
    func hideShowImgVw(_ hide:Bool){
        signImgVw.isHidden = hide
    }
    
    func showImgVw(_ hide:Bool){
        signImgVw.isHidden = !hide
    }
    
    func getEmpName(empobj:VaccinationEmployeeVM)-> String{
        var nameArr = [String]()
        if empobj.firstName != nil && empobj.firstName != ""{
            nameArr.append(empobj.firstName!)
        }
        if empobj.middleName != nil && empobj.middleName != ""{
            nameArr.append(empobj.middleName!)
        }
        if empobj.lastName != nil && empobj.lastName != ""{
            nameArr.append(empobj.lastName!)
        }
        
        let nameStr = "Device Operator Name: \( nameArr.joined(separator: " "))"
        
        return nameStr
    }
    
    
    func showHideBtn(flag:Bool){
        nextBtn.isHidden = flag
        nextBtn.isUserInteractionEnabled = !flag
        previousBtn.isHidden = flag
        previousBtn.isUserInteractionEnabled = !flag
    }
    
    func setConstraint(){
        operatorNameTopConstraint.constant = 10
        operatornameConstraint.constant = 21
    }
    
    func setBordeViewWithColor(_ view:UIView){
        view.layer.borderWidth  = 2
        view.layer.borderColor = UIColor.getBorderColorr().cgColor
        view.layer.cornerRadius = 18.5
    }
    
    func removeConstraint(){
        operatorNameTopConstraint.constant = 0
        operatornameConstraint.constant = 0
    }
    
    
    func SignatureViewDidCaptureSignature(view: SignatureView, signature: Signature?) {
        
        
    }
    
    func SignatureViewDidFinishDrawing(view: SignatureView) {
        
        if fromScreen == "PEFinishPopUpScreen" {
            signImage = view.captureSignatureFromView()!
            var base64 = ""
            if let sign = signImage{
                base64 = CodeHelper.sharedInstance.convertToBase64(image: sign ) ?? ""
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex, "sign": base64
                                                                                                                              ])
            if empIndex > -1 &&  certificateData.count > empIndex {
                if certificateData.count > empIndex {
                    isRunningBack = true
                    certificateData[empIndex].isSigned = true
                    certificateData[empIndex].signatureImg = base64
                }
            }
            if empIndex > -1 && empIndex == certificateData.count {
                curentCertification?.hatcheryManagerSign = base64
                certificateData[0].fsrSign = base64
                UserDefaults.standard.setValue(base64, forKey: "FsrSign")
                UserDefaults.standard.setValue(true, forKey: "isSignedFSR")
            }
            blockSignature?(certificateData)
        }
        else {
            
            signImage = view.captureSignatureFromView()!
            var base64 = ""
            if let sign = signImage{
                base64 = CodeHelper.sharedInstance.convertToBase64(image: sign ) ?? ""
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateEmployeeSign"), object: nil, userInfo: ["index":empIndex, "rowIndex":rowIndex, "sign": base64])
            if empIndex > -1 && empIndex == employeesAddedArr.count + 1 {
                
                curentCertification?.fsrSignature = base64
            }
            if empIndex > -1 && empIndex == employeesAddedArr.count{
                curentCertification?.hatcheryManagerSign = base64
            }
            
            if rowIndex == 1 && employeesAddedArr.count > 0 && empIndex > -1 && employeesAddedArr.count > empIndex{
                var emp = employeesAddedArr[empIndex]
                emp.signBase64 = base64
                employeesAddedArr[empIndex] = emp
            }
        }
    }
    
}
