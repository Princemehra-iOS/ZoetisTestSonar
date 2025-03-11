//
//  PVEStartNewAssFinalizeAssement.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 12/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import SwiftyJSON

class PVEStartNewAssFinalizeAssement: BaseViewController, CategorySelectionDelegate {
    
    
    let dropdownManager = ZoetisDropdownShared.sharedInstance
    @IBOutlet weak var buttonMenu: UIButton!
    var delegate: CategorySelectionDelegate? = nil
    var selectedAssessmentId = Int()
    @IBOutlet weak var tblView: UITableView!
    var currentArr = [[String : AnyObject]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // currentArr.append(["nnn": "qq"])
        //self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
       
    @IBAction func actionMenu(_ sender: Any) {
        self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
    @IBAction func btnAction(_ sender: Any) {
        print("btnAction")
//        let storyBoard : UIStoryboard = UIStoryboard(name: Constants.Storyboard.pveStoryboard, bundle:nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "GradientDemoVC") as! GradientDemoVC
//        navigationController?.pushViewController(vc, animated: true)

    }

//
//
//    @IBAction func optionBtnAction(_ sender: UIButton) {
//
//        switch sender.titleLabel?.text! {
//        case "Crew Safety":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Vaccine Preparation":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Bird Welfare":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Vaccine Evaluation":
//            print("\(String(describing: sender.titleLabel?.text))")
//        default:
//            print("\(String(describing: sender.titleLabel?.text))")
//        }
//        print("\(String(describing: sender.titleLabel?.text))")
//        print("optionBtnAction")
//    }

    
}


extension PVEStartNewAssFinalizeAssement: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return currentArr.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height:CGFloat = CGFloat()
        switch indexPath.section {
        case 0:
            height = 100
        case 1:
            height = 100
        case 2:
            height = 60
        default:
            height = 0
        }
        
        return height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopCell", for: indexPath) as! TopCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PVEFinalizeAsseementCell", for: indexPath) as! PVEFinalizeAsseementCell
            cell.delegate = self

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PVEVaccinationCrewSafetyCell", for: indexPath) as! PVEVaccinationCrewSafetyCell
           // cell.currentAssessmentDetails =  currentArr[indexPath.row]
            let assessmentStr = currentArr[indexPath.row]["Assessment"] as! String
            cell.assessmentLbl.text = assessmentStr
            
            if(indexPath.row % 2 == 0) {
                cell.contentView.backgroundColor = #colorLiteral(red: 0.9727752805, green: 0.9729382396, blue: 0.9727523923, alpha: 1)
            } else {
                cell.contentView.backgroundColor =  #colorLiteral(red: 0.9998950362, green: 1, blue: 0.9998714328, alpha: 1)
            }

            return cell
        }
        
    }
    
//    func reloadCellForId(SelectedAssessmentId:Int, cell:AddNote_StartNewAssCell) {
//
//        switch selectedAssessmentId {
//        case 11:do {
//            }
//        case 12:do {
//            }
//        default:
//            print("No selectedAssessmentId Matched")
//        }
//    }
}



extension PVEStartNewAssFinalizeAssement  {
    
    func selectedAssessmentId(selectedId: Int, selectedArr:[[String : AnyObject]]){
        print("----\(selectedId)")
        //print("----\(selectedArr)")
        
        selectedAssessmentId = selectedId
        currentArr = selectedArr
 //       let tempArr = currentArr[0]["Assessment"] as! String
//        print("currentArr----\(tempArr)")


        tblView.reloadData()
    }
    
}
