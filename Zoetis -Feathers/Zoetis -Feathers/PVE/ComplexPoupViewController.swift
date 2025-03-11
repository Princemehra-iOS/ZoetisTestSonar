//
//  ComplexPoupVC.swift
//  TestApp
//
//  Created by Nitin kumar Kanojia on 08/11/19.
//  Copyright © 2019 Nitin kumar Kanojia. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

protocol ComplexDelegate {
    func didSelectedName(SelectedName: String)
}

class ComplexPoupViewController: BaseViewController {
    
    let dropdownManager = ZoetisDropdownShared.sharedInstance

    @IBOutlet weak var selectCustomerButton: UIButton!
    @IBOutlet weak var selectComplexButton: UIButton!
    @IBOutlet weak var selectCompanyText: UITextField!
    @IBOutlet weak var selectComplexText: UITextField!
    
    var delegate: ComplexDelegate? = nil
    var currentSelectedModule = String()
    
    var customerId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentSelectedModule == Constants.Module.breeder_PVE{
            fetchCustomerList()
            fetchComplexListForPVE()
            
            fetchtHousingDetailsResponse()
            fetchtAgeOfBirdsResponse()
            fetchtBreedOfBirdsResponse()
            fetchtAssignUserDetailResponse()
            fetchSiteIdNameResponse()
            fetchtEvaluatorDetailsResponse()
            fetchEvaluationForList()
            fetchEvaluationTypeList()

        }
        else if currentSelectedModule == Constants.Module.hatchery_PV{
            fetchAllCustomer()
            fetchAllComplexes()
        }

        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if selectCompanyText.text == "" {
            showAlert(title: "error", message: "Please select customer first", owner: self)
            return
        }
        if selectComplexText.text == "" {
            showAlert(title: "error", message: "Please select complex", owner: self)
            return
        }
        if selectComplexText.text == "" && selectCompanyText.text == "" {
            showAlert(title: "error", message: "Please select customer first", owner: self)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func customerBtnAction(_ sender: UIButton) {
        
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        var customerNamesArray = NSArray()
        var customerDetailsArray = NSArray()

        if currentSelectedModule == Constants.Module.breeder_PVE{
            
            customerDetailsArray = CoreDataHandlerPVE().fetchDetailsFor(entityName: "Customer_PVE")
            customerNamesArray = customerDetailsArray.value(forKey: "customerName") as! NSArray
            print("CustId---\(customerNamesArray)")

         //   customerNamesArray = dropdownManager.sharedCustomerNameArrPVE ?? []
        }else{
           // customerNamesArray = dropdownManager.sharedCustomerNamesPE ?? []
        }
        
        if  customerNamesArray.count > 0 {
            self.dropDownVIewNew(arrayData: customerNamesArray as! [String], kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) { [unowned self] selectedVal, index  in
               // let customerId = dropdownManager.sharedCustomerPVE?[index].customerId
              //  print("customerId--\(customerId!)")
                self.customerId = (customerDetailsArray.object(at: index) as AnyObject).value(forKey: "customerId") as! Int
                print("customerId--\(self.customerId)")

                self.selectCompanyText.text = selectedVal
                dropdownManager.selectedCustomer = selectedVal
                self.selectComplexText.text = ""

            }
            self.dropHiddenAndShow()
        }
//        } else {
//
//            if currentSelectedModule == Constants.Module.breeder_PVE{
//                fetchCustomerList()
//            }else if currentSelectedModule == Constants.Module.hatchery_PV{
//                fetchAllCustomer()
//            }
//        }
    }
    
    @IBAction func complexBtnAction(_ sender: UIButton) {
        

        var complexNamesArray = NSArray()
        var complexDetailsArray = NSArray()
        
        if currentSelectedModule == Constants.Module.breeder_PVE{
            
          //  complexDetailsArray = CoreDataHandlerPVE().fetchDetailsFor(entityName: "Complex_PVE")
            complexDetailsArray = CoreDataHandlerPVE().fetchCustomerWithCustId( customerId as NSNumber)
            complexNamesArray = complexDetailsArray.value(forKey: "complexName") as! NSArray


           // complexNamesArray = dropdownManager.sharedComplexResArrPVE ?? []
        }
        else{
           // complexNamesArray = dropdownManager.sharedComplexNamesPE ?? []
        }
        
        if  complexNamesArray.count > 0 {
            
//            if selectComplexText.text == "" {
//                showAlert(title: "error", message: "no complex available", owner: self)
//                return
//            }

            self.dropDownVIewNew(arrayData: complexNamesArray as! [String], kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) { [unowned self] selectedVal, index in
               // let complexId = (complexDetailsArray.object(at: index) as AnyObject).value(forKey: "complexId") as! String
               //  print("complexId--\(complexId)")

                self.selectComplexText.text = selectedVal
                self.dropdownManager.selectedComplex = selectedVal
            }
            self.dropHiddenAndShow()
        }
        else{
            
            showAlert(title: "error", message: "Sorry! No Complex available this customer", owner: self)

        }
//        } else {
//
//            if currentSelectedModule == Constants.Module.breeder_PVE{
//                //fetchComplexListForPVE()
//            }else if currentSelectedModule == Constants.Module.hatchery_PV{
//                fetchAllComplexes()
//            }
//        }

    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        let touch: UITouch = touches.first!
//        if (touch.view?.tag == 1111){
//           // self.dismiss(animated: true, completion: nil)
//        }
//    }
    
    //MARKS: DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
}

extension ComplexPoupViewController {
    //Fetch Streams
    // MARK: - WebServices
    private func fetchAllComplexes(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        ZoetisWebServices.shared.getComplexListForPE(controller: self, countryID: String(countryId), parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchAllComplexesResponse(json)
        })
    }
    
    private func handlefetchAllComplexesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = ComplexResponse(json)
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        dropdownManager.sharedComplexNamesPE = jsonObject.getAllComplexNames(complexArray: jsonObject.complexArray ?? [])
        dropdownManager.sharedComplexPE =  jsonObject.complexArray ?? []
        //self.complexBtnAction(self.selectComplexButton)
    }
    
    private func fetchAllCustomer(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getAllCustomerListForPE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchAllCompaniesResponse(json)
        })
    }
    
    private func handlefetchAllCompaniesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = CustomerResponse(json)
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        dropdownManager.sharedCustomerNamesPE = jsonObject.getAllCustomerNames(customerArray: jsonObject.customerArray ?? [])
        dropdownManager.sharedCustomerPE =  jsonObject.customerArray ?? []
        //self.customerBtnAction(self.selectCustomerButton)
        
    }

}

//// For PVE
extension ComplexPoupViewController {
    
    private func fetchCustomerList(){
        CoreDataHandler().deleteAllData("Customer_PVE")

        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
 //       let countryId = "40"
        ZoetisWebServices.shared.getCustomerListForPVE(controller: self, countryID: String(countryId), parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchCustomerResponse(json)
        })
    }

    private func handlefetchCustomerResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = CustomerPVEResponse(json)
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        dropdownManager.sharedCustomerNameArrPVE = jsonObject.getAllCustomerNames(customerArray: jsonObject.customerArray ?? [])
        dropdownManager.sharedCustomerPVE =  jsonObject.customerArray ?? []
        //self.customerBtnAction(self.selectCustomerButton)
        print("DDDDD---\(CoreDataHandlerPVE().fetchDetailsFor(entityName: "Customer_PVE"))")
//        let custmorArr = CoreDataHandlerPVE().fetchCustomer()
//
//
//        let CustId = (custmorArr.object(at: 0) as AnyObject).value(forKey: "customerName") as! String
//        print("DDDDD---\(CustId)")

       // let CustName = (custmorArr.object(at: i) as AnyObject).value(forKey: "CustomerName") as! String


    }
    
    private func fetchComplexListForPVE(){
        CoreDataHandler().deleteAllData("Complex_PVE")
        selectComplexText.text = ""
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
             //   let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let countryId = "40"
       // let customerId = "1599"
        ZoetisWebServices.shared.getComplexListForPVE(controller: self, countryID: String(countryId), parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchAllComplexesResponseForPVE(json)
        })
    }

//    private func fetchComplexListForPVE(){
//        self.showGlobalProgressHUDWithTitle(self.view, title: "")
//                let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
//       // let countryId = "40"
//        let customerId = "1599"
//        ZoetisWebServices.shared.getComplexListForPVE(controller: self, countryID: String(countryId), customerID: String(customerId), parameters: [:], completion: { [weak self] (json, error) in
//            guard let `self` = self, error == nil else { return }
//            self.handlefetchAllComplexesResponseForPVE(json)
//        })
//    }

    private func handlefetchAllComplexesResponseForPVE(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = PVEGetComplexResponse(json)
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        dropdownManager.sharedComplexResArrPVE = jsonObject.getAllComplexNames(complexArray: jsonObject.complexArray ?? [])
        dropdownManager.sharedComplexResPVE =  jsonObject.complexArray ?? []
       // self.complexBtnAction(self.selectComplexButton)
        print("DDDDD---\(CoreDataHandlerPVE().fetchDetailsFor(entityName: "Complex_PVE"))")

    }


}


// MARK: ------------------------------Fetch & handle Response Data-----------------

extension ComplexPoupViewController{
    
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

