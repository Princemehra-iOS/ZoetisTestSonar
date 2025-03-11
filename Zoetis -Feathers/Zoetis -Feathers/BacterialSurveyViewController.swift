//
//  BacterialSurveyViewController.swift
//  Zoetis -Feathers
//
//  Created by Avinash Singh on 11/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class BacterialSurveyViewController: BaseViewController {

    @IBOutlet weak var surveyTitle: UILabel!
    @IBOutlet weak var yesImageView: UIImageView!
    @IBOutlet weak var noImageView: UIImageView!
    @IBOutlet weak var requestorTxt: customButton!
    @IBOutlet weak var siteBtn: customButton!
    @IBOutlet weak var companyBtn: customButton!
    @IBOutlet weak var barCodeTxt: FormTextField!
    @IBOutlet weak var sampleCollectedByBtn: customButton!
    @IBOutlet weak var reviewerBtn: customButton!
    @IBOutlet weak var sampleCollectionDateBtn: customButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestorTxt.setTitle("John Smith",for: .normal)

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var buttonMenu: UIButton!
    
 
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionMenu(_ sender: Any) {
        self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
    
    @IBAction func ackYesBtnClk(_ sender: UIButton) {
        
        
        //  UIImageView(image: image)
        
        self.yesImageView.image  =  UIImage(named:"Radio_Btn")!
        self.noImageView.image  =  UIImage(named:"Radio_Btn01")!
    }
    
    
    @IBAction func ackNoBtnClk(_ sender: UIButton) {
        
        self.noImageView.image  =  UIImage(named:"Radio_Btn")!
        self.yesImageView.image  =  UIImage(named:"Radio_Btn01")!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func companyBtnAction(_ sender: UIButton) {
        
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        var customerNamesArray = [String]()
            customerNamesArray = dropdownManager.sharedCustomerNameArrMicrobial ?? []

        if  customerNamesArray.count > 0 {
            self.dropDownVIew(arrayData: customerNamesArray, kWidth: sender.frame.width, kAnchor: sender, yheight: sender.bounds.height) { [unowned self] selectedVal in
                //self.selectCompanyText.text = selectedVal
                self.companyBtn.titleLabel?.text = selectedVal
                dropdownManager.selectedCustomerMicrobial = selectedVal
            }
            self.dropHiddenAndShow()

        } else {
                fetchCustomerList()
         }
    }

}

extension BacterialSurveyViewController{
    
    private func fetchCustomerList(){
        self.showGlobalProgressHUDWithTitle(self.view, title: "")
        ZoetisWebServices.shared.getAllCustomersForMicrobial(controller: self, parameters: [:], completion: { [weak self] (json, error) in
            guard let `self` = self, error == nil else { return }
            self.handlefetchCustomerResponse(json)
        })
    }
    
    private func handlefetchCustomerResponse(_ json: JSON) {
        dismissGlobalHUD(self.view)
        let jsonObject = MicroabialAllCustomerResponse(json)
        let dropdownManager = ZoetisDropdownShared.sharedInstance
        dropdownManager.sharedCustomerNameArrMicrobial = jsonObject.getAllCustomerNames(customerArray: jsonObject.customerArray ?? [])
        dropdownManager.sharedComplexMicroabial =  jsonObject.customerArray ?? []
        self.companyBtnAction(self.companyBtn)
        
    }
    
    func dropHiddenAndShow(){
        if dropDown.isHidden{
            let _ = dropDown.show()
        } else {
            dropDown.hide()
        }
    }
    
}
