//
//  BacterialTextfieldInfoCell.swift
//  Zoetis -Feathers
//
//  Created by Avinash Singh on 31/12/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit
import CoreData
//protocol BacterialTextfieldInfoCellDelegate {
//    func removeRows()
//}

class BacterialTextfieldInfoCell: UITableViewCell {
    
 //    var delegate: BacterialTextfieldInfoCellDelegate? = nil
    
    var isSelectedStatus : Bool = false
    
    
    
    @IBOutlet weak var bacterialTxt: UILabel!
    
    @IBOutlet weak var sampleDescriptionTxt: UITextField!
    
    @IBOutlet weak var PlateIdTxt: UILabel!
    
     var completion:((_ error: String?) -> Void)?
    
    @IBOutlet weak var chkBtnTag: UIButton!
    @IBOutlet weak var microsporeCheck: UIButton!
    
    
//    @IBAction func checkBtnAction(_ sender: UIButton) {
//
//        //   print(">>>>>\(sender.isSelected)")
//
//        if(!sender.isSelected )
//        {
//            CoreDataHandlerMicro().updateCheckMark(Int, plateId: <#T##String#>, checkMark: <#T##String#>)
//            chkBtnTag.setImage(UIImage(named: "check"), for: .normal)
//
//             //   print(">>>>>")
//        }
//        else{
//
//           chkBtnTag.setImage(UIImage(named: "uncheck"), for: .normal)
//
//            //   print("#####")
//        }
//
//        sender.isSelected = !sender.isSelected
//
//
//
//
//
//      //  chkBtnTag.setImage(UIImage(named: "check"), for: .normal)
//
//        //   print("cell tapped status : \(sender.tag) \(isSelectedStatus)")
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
//    @IBAction func deleteRowa(_ sender: UIButton) {
//
//
//        delegate?.removeRows()
//    }
    
    
//    @IBAction func deleteRow(_ sender: UIButton) {
//       
//      }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
