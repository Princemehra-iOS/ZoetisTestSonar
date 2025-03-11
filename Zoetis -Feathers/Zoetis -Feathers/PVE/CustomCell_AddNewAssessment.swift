//
//  CustomCell_AddNewAssessment.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 16/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//


import UIKit

class CustomCell_AddNewAssessment: UITableViewCell {

    @IBOutlet weak var plusMinusBtn: UIButton!
    @IBOutlet weak var farmNameTxtField: UITextField!
    @IBOutlet weak var houseNoTxtField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


//extension CustomCell_AddNewAssessment: UITextFieldDelegate{
//    
//    
//    func dismissKeyboard() {
//        self.endEditing(true)
//    }
//    
//    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.endEditing(true)
//    }
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    /**
//     * Called when the user click on the view (outside the UITextField).
//     */
//    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.endEditing(true)
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//    }
//    
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
////        print(textField.placeholder!,cellTypeName)
//        //let tagg = self.tag as NSNumber
//        
//        return true
//    }
//
//}
