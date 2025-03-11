//
//  PEStartNewAssessment.swift
//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 13/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class PEStartNewAssessment: BaseViewController {
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var selectedEvaluationDateText: UITextField!
    @IBOutlet weak var selectedCustomerText: UITextField!
    @IBOutlet weak var selectedSiteText: UITextField!
    @IBOutlet weak var selectedEvaluatorText: UITextField!
    @IBOutlet weak var selectedTSR: UITextField!
    @IBOutlet weak var selectedEvaluationType: UITextField!
    @IBOutlet weak var selectedVisitText: UITextField!
    @IBOutlet weak var customerButton: customButton!
    @IBOutlet weak var siteButton: customButton!
    @IBOutlet weak var evaluatorButton: customButton!
    @IBOutlet weak var visitButton: customButton!
    @IBOutlet weak var evaluationTypeButton: customButton!
    @IBOutlet weak var tsrButton: customButton!
    @IBOutlet weak var hatcherySwitch: UISwitch!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTextView.delegate = self
        notesTextView.layer.borderColor = UIColor.black.cgColor
        notesTextView.textContainer.lineFragmentPadding = 12
        notesTextView.text = ""

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionMenu(_ sender: Any) {
        self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
       @IBAction func evaluationDateBtnAction(_ sender: UIButton) {
           print("evaluationDateBtnAction")
           let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
           let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
           datePickerPopupViewController.delegate = self
           present(datePickerPopupViewController, animated: false, completion: nil)
}

       @IBAction func evaluationTypeBtnAction(_ sender: UIButton) {
           print("evaluationTypeBtnAction")
       }
    
       @IBAction func customerBtnAction(_ sender: UIButton) {
           print("customerBtnAction")
       }

       @IBAction func evaluationForBtnAction(_ sender: UIButton) {
           print("evaluationForBtnAction")
       }

       @IBAction func siteIdBtnAction(_ sender: UIButton) {
           print("siteIdBtnAction÷")
       }

       @IBAction func accountManagerBtnAction(_ sender: UIButton) {
           print("accountManagerBtnAction")
       }

       @IBAction func evaluatorBtnAction(_ sender: UIButton) {
           print("evaluatorBtnAction")
       }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        print("btnAction")
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEAssesmentFinalize") as! PEAssesmentFinalize
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    @IBAction func evaluationDateClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Selection", bundle:nil)
        let datePickerPopupViewController = storyBoard.instantiateViewController(withIdentifier: "DatePickerPopupViewController") as! DatePickerPopupViewController
        datePickerPopupViewController.delegate = self
        present(datePickerPopupViewController, animated: false, completion: nil)
    }
    
    //Customer Company is same
    @IBAction func customerClicked(_ sender: Any) {
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        let customerNamesArray = dropdownManager.sharedCustomerNamesPE ?? []
        if  customerNamesArray.count > 0 {
            self.dropDownVIew(arrayData: customerNamesArray, kWidth: customerButton.frame.width, kAnchor: customerButton, yheight: customerButton.bounds.height) { [unowned self] selectedVal in
                self.selectedCustomerText.text = selectedVal
                let indexOfItem = customerNamesArray.firstIndex(of: selectedVal)
                dropdownManager.sharedSelectedCustomerPE = dropdownManager.sharedCustomerPE?[indexOfItem ?? 0]
                dropdownManager.selectedCustomer = selectedVal
                dropdownManager.sharedSitesNamesPE = []
                self.selectedSiteText.text = ""
                
            }
            self.dropHiddenAndShow();
        } else {
            fetchAllCustomer()
        }
    }
    
    //Complex Site is same
    @IBAction func siteClicked(_ sender: Any) {
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        let siteNamesArray = dropdownManager.sharedSitesNamesPE ?? []
        if  siteNamesArray.count > 0 {
            self.dropDownVIew(arrayData: siteNamesArray, kWidth: siteButton.frame.width, kAnchor: siteButton, yheight: siteButton.bounds.height) { [unowned self] selectedVal in
                self.selectedSiteText.text = selectedVal
                dropdownManager.selectedSite = selectedVal
            }
            self.dropHiddenAndShow();
        } else {
          //  let customerIdString = dropdownManager.sharedSelectedCustomerPE?.customerId ?? 0
          //  fetchSites(customerID: String(customerIdString))
        }
    }
    
    @IBAction func evaluatorClicked(_ sender: Any) {
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        let evaluatorNamesArray = dropdownManager.sharedEvaluatorNamesPE ?? []
        if  evaluatorNamesArray.count > 0 {
            self.dropDownVIew(arrayData: evaluatorNamesArray, kWidth: evaluatorButton.frame.width, kAnchor: evaluatorButton, yheight: evaluatorButton.bounds.height) { [unowned self] selectedVal in
                self.selectedEvaluatorText.text = selectedVal
                let indexOfItem = evaluatorNamesArray.firstIndex(of: selectedVal)
                dropdownManager.sharedSelectedEvaluatorPE = dropdownManager.sharedEvaluatorPE?[indexOfItem ?? 0]
                dropdownManager.selectedEvaluator = selectedVal
            }
            self.dropHiddenAndShow();
        } else {
            fetchEvaluator()
        }
    }
    
    @IBAction func visitClicked(_ sender: Any) {
        //fetchVisitTypes
        let dropdownManager = ZoetisDropdownShared.sharedInstance
               let visitTypeNamesArray = dropdownManager.sharedVisitTypeNamesPE ?? []
               if  visitTypeNamesArray.count > 0 {
                   self.dropDownVIew(arrayData: visitTypeNamesArray, kWidth: visitButton.frame.width, kAnchor: visitButton, yheight: visitButton.bounds.height) { [unowned self] selectedVal in
                       self.selectedVisitText.text = selectedVal
                       let indexOfItem = visitTypeNamesArray.firstIndex(of: selectedVal)
                       dropdownManager.sharedSelectedVisitTypePE = dropdownManager.sharedVisitTypePE?[indexOfItem ?? 0]
                       dropdownManager.selectedVisitType = selectedVal
                   }
                   self.dropHiddenAndShow();
               } else {
                   fetchVisitTypes()
            }
    }
    
    @IBAction func evaluationClicked(_ sender: Any) {
        //fetchEvaluatorTypes
        let dropdownManager = ZoetisDropdownShared.sharedInstance
            let evaluationTypeNamesArray = dropdownManager.sharedEvaluationTypeNamesPE ?? []
            if  evaluationTypeNamesArray.count > 0 {
                self.dropDownVIew(arrayData: evaluationTypeNamesArray, kWidth: evaluationTypeButton.frame.width, kAnchor: evaluationTypeButton, yheight: evaluationTypeButton.bounds.height) { [unowned self] selectedVal in
                    self.selectedEvaluationType.text = selectedVal
                    let indexOfItem = evaluationTypeNamesArray.firstIndex(of: selectedVal)
                    dropdownManager.sharedSelectedEvaluationTypePE = dropdownManager.sharedEvaluationTypePE?[indexOfItem ?? 0]
                    dropdownManager.selectedEvaluationType = selectedVal
                }
                self.dropHiddenAndShow();
            } else {
                fetchEvaluationTypes()
            }
    }
    
    @IBAction func tsrClicked(_ sender: Any) {
        self.dropDownVIew(arrayData: ["Self","FSR"], kWidth: tsrButton.frame.width, kAnchor: tsrButton, yheight: tsrButton.bounds.height) { [unowned self] selectedVal in
            self.selectedTSR.text = selectedVal
        }
        self.dropHiddenAndShow();
    }
    
    @IBAction func switchClicked(_ sender: Any) {
    }
    
    //MARKS: DROP DOWN HIDDEN AND SHOW
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
}

// MARK: - Other Delegates
extension PEStartNewAssessment: DatePickerPopupViewControllerProtocol{
    func doneButtonTapped(string:String){
        selectedEvaluationDateText.text = string
    }
}

extension PEStartNewAssessment:UITextViewDelegate{
    //MARK...

       func textViewShouldBeginEditing(_ _textView: UITextView) -> Bool {
           return true
       }

       func textViewDidEndEditing(_ textView: UITextView) {
           if (textView == notesTextView ) {
           }
       }

       func textViewDidBeginEditing(_ textView: UITextView) {

       }
    
}

// MARK: - WebServices
extension PEStartNewAssessment {
    private func fetchAllCustomer(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        ZoetisWebServices.shared.getCustomerListForPE(controller: self, countryID: String(countryId), parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchAllCustomerResponse(json)
        })
    }
    
    private func handlefetchAllCustomerResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = CustomerResponse(json)
        if jsonObject.customerArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedCustomerNamesPE = jsonObject.getAllCustomerNames(customerArray: jsonObject.customerArray ?? [])
            dropdownManager.sharedCustomerPE =  jsonObject.customerArray ?? []
            customerClicked(customerButton)
        } else {
            showToast(message: "No data Found")
        }
    }
    
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
        if jsonObject.complexArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedComplexNamesPE = jsonObject.getAllComplexNames(complexArray: jsonObject.complexArray ?? [])
            dropdownManager.sharedComplexPE =  jsonObject.complexArray ?? []
            siteClicked(siteButton)
        } else {
            showToast(message: "No data Found")
        }
    }
    
    private func fetchSites(customerID:String){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getSitesListForPE(controller: self, sitesID: customerID, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleFetchSitesResponse(json)
        })
    }
    
    private func handleFetchSitesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = SiteResponse(json)
        if jsonObject.siteArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedSitesNamesPE = jsonObject.getAllSiteNames(siteArray: jsonObject.siteArray ?? [])
            dropdownManager.sharedSitePE =  jsonObject.siteArray ?? []
            siteClicked(siteButton)
        } else {
            showToast(message: "No data Found")
        }
    }
    
    private func fetchEvaluator(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getEvaluatorListForPE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleFetchEvaluatorResponse(json)
        })
    }
    
    private func handleFetchEvaluatorResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = EvaluatorResponse(json)
        if jsonObject.evaluatorArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedEvaluatorNamesPE = jsonObject.getAllEvaluatorNames(evaluatorArray: jsonObject.evaluatorArray ?? [])
            evaluatorClicked(evaluatorButton)
        } else {
            showToast(message: "No data Found")
        }
    }
    
    private func fetchVisitTypes(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getVisitTypesListForPE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleFetchVisitTypesResponse(json)
        })
    }
    
    private func handleFetchVisitTypesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = VisitTypesResponse(json)
        if jsonObject.visitTypeArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedVisitTypeNamesPE = jsonObject.getAllVisitTypesNames(visitTypeArray: jsonObject.visitTypeArray ?? [])
            visitClicked(visitButton)
        } else {
            showToast(message: "No data Found")
        }
    }

    private func fetchEvaluationTypes(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getEvaluatorTypesListForPE(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handleFetchEvaluationTypesResponse(json)
        })
    }
    
    private func handleFetchEvaluationTypesResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = EvaluationTypeResponse(json)
        if jsonObject.evaluationTypeArray?.count ?? 0 > 0 {
            let dropdownManager = ZoetisDropdownShared.sharedInstance
            dropdownManager.sharedEvaluationTypeNamesPE = jsonObject.getAllEvaluationTypeNames(evaluationTypeArray: jsonObject.evaluationTypeArray ?? [])
            evaluationClicked(evaluationTypeButton)
        } else {
            showToast(message: "No data Found")
        }
    }

}
