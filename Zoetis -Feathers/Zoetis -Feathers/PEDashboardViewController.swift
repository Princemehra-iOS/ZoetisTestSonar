//
//  PEDashboardViewController.swift
//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 05/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import UIKit

class PEDashboardViewController: BaseViewController {
    
    @IBOutlet weak var buttonMenu: UIButton!
    var currentSelectedModule = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addComplexPopup()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func startNewSessionClicked(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "PEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PEStartNewAssessment") as! PEStartNewAssessment
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openExistingSessionClicked(_ sender: Any) {
        
    }
    
    @IBAction func trainingEducationClicked(_ sender: Any) {
        
    }
    
       
    @IBAction func actionMenu(_ sender: Any) {
        self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
    func addComplexPopup() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "PVEStoryboard", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ComplexPoupVC") as! ComplexPoupViewController
        vc.currentSelectedModule = currentSelectedModule
        navigationController?.present(vc, animated: false, completion: nil)
    }
}


