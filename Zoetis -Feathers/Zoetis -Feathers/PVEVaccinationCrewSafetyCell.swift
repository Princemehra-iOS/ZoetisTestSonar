//
//  PVEVaccinationCrewSafetyCell.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 26/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit

class PVEVaccinationCrewSafetyCell: UITableViewCell {

    var currentAssessmentDetails = [String : AnyObject]()
    
    @IBOutlet weak var assessmentLbl: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()

    //    assessmentLbl.text = currentAssessmentDetails["Assessment"] as? String
    //    setControls(controlType: currentAssessmentDetails["Types"] as? String)

    }
    
    func setControls(controlType: String?) {
        switch controlType {
        case "Drop Value": do{
            switchBtn.isHidden = false
        }
        case "Text": do{
            switchBtn.isHidden = true
        }
        default:
            print("No control matched")
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    @IBAction func switchAction(_ sender: UISwitch) {
        
        if sender.isOn{
            //genderLabel.text = "Female"
        }else{
            //genderLabel.text = "Male"
        }
        print("sender.isOn")
    }
    
}
