//
//  BacterialSampleInfoCell.swift
//  Zoetis -Feathers
//
//  Created by Avinash Singh on 31/12/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

protocol BacterialSampleInfoCellDelegate {
    
    func noOfPlates(count: Int, clicked :Bool)
   
}


class BacterialSampleInfoCell: UITableViewCell {
    
    var delegate: BacterialSampleInfoCellDelegate? = nil
   
  
    @IBOutlet weak var plateContainerView: customView!
    
    @IBOutlet weak var plusBtnOutlet: UIButton!
    
     @IBOutlet weak var noOfPlates: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.noOfPlates.keyboardType = .phonePad
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusBtnAction(_ sender: UIButton) {
    
        var barcode = UserDefaults.standard.value(forKey: "barcode")
       
        //   print("you tapped :\(sender.tag)")
        
        //   print("---->>>>>>>>>>>>\(noOfPlates.text)")
        
        guard let text =  noOfPlates.text  else {
            return
        }
        
        if(text == "")
        {
            noOfPlates.text = "enter a value"
            
           //  self.isNoOfPlates = false
            
            return
        }
        else
        {
            
            var txtVale = Int()
            let sessionId = UserDefaults.standard.integer(forKey: "sessionId")
            txtVale =  Int(noOfPlates.text!)!
            
            for i in 0..<txtVale {
                var plate =  "\(String(describing: barcode!))-" + "\(i+1)"
                CoreDataHandlerMicro().saveSampleInfoDataInDB(plate, plateId: i, sampleDescriptiopn: "", additionalTests: "Bacterial", checkMark: "false",  microsporeCheck: "false", sessionId: sessionId)
               // CoreDataHandlerMicro().saveSampleInfoDataInDB(plate ,plateId : 10, sampleDescriptiopn: "" , additionalTests:"Microbial", checkMark: "false",sessionId : sessionId)
            }
            

        }
        delegate?.noOfPlates(count: Int(text)!, clicked: true)
        
     //
        
    }
    
   

}
