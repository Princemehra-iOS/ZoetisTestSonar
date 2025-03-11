//
//  feedPopUpTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 26/03/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import UIKit

protocol  feedPop {
    func yesBtnPop()
    func noBtnPop()
}

class feedPopUpTurkey: UIView {

    @IBOutlet weak var lblFedPrgram: UILabel!
    var delegatefeedPop: feedPop!

    override func draw(_ rect: CGRect) {
    }

    @IBAction func yesBtnAction(_ sender: UIButton) {

        delegatefeedPop.yesBtnPop()

    }

    @IBAction func noBtnAction(_ sender: UIButton) {

        delegatefeedPop.noBtnPop()

    }

}
