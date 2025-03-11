//
//  OtherDetailsTurkey.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 16/10/23.
//

import UIKit

// MARK: - PROTOCOL & FUNCTIONS
protocol otherFuncDetailsTurkey {
    func DoneFuncTurkey ()
   // func doneBtnFunc (_ notes : NSMutableArray , notesText : String , noOfBird : Int)
   // func postingNotesdoneBtnFunc(_ notesText : String)
}

class OtherDetailsTurkey: UIView {

    @IBOutlet weak var liveTxtFld: UITextField!
    
    @IBOutlet weak var mortalityTxtFld: UITextField!
    
    @IBOutlet weak var avgAgeTxtField: UITextField!
    
    @IBOutlet weak var avgWeightTxtFld: UITextField!
    
    @IBOutlet weak var outTimeTxtFld: UITextField!
    
    @IBOutlet weak var fcrTxtFld: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    var liveText = String()
    var mortalityText = String()
    var avgAgeText = String()
    var avgWeightText = String()
    var outTimeText = String()
    var fcrText = String()
    var buttonDroper = UIButton ()
    var otherFuncDetailsTurkeyDelegate: otherFuncDetailsTurkey!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBAction func doneBtnAction(_ sender: UIButton) {
        otherFuncDetailsTurkeyDelegate.DoneFuncTurkey()
    }
        
    override func draw(_ rect: CGRect) {
        
        self.bgView.layer.cornerRadius = 7
        self.bgView.layer.borderWidth = 3
        self.bgView.layer.borderColor = UIColor.white.cgColor
        
        liveTxtFld.text = liveText
        mortalityTxtFld.text = mortalityText
        avgWeightTxtFld.text = avgWeightText
        avgAgeTxtField.text = avgAgeText
        fcrTxtFld.text = fcrText
        outTimeTxtFld.text = outTimeText
        buttonDroper.alpha = 0

        buttonDroper.frame = CGRect(x: 0, y: 0, width: 942, height: 428)
        buttonDroper.addTarget(self, action: #selector(AddFarmTurkey.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.addSubview(buttonDroper)
       
    }

}
