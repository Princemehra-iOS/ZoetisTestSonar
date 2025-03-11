//
//  obsFieldCollectionViewCell.swift
//  Zoetis -Feathers
//
//  Created by "" on 18/11/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit

class obsFieldCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var obsNameLabel: UILabel!

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var imageBrdNumber: UIImageView!
    @IBOutlet weak var lblBirdSize: UILabel!
    @IBOutlet weak var incrementBtnOutlet: UIButton!
    @IBOutlet weak var minusBtnOutlet: UIButton!

    @IBOutlet weak var switchQuickLink: UISwitch!
    @IBOutlet weak var actualTexField: UITextField?

    //var capture  =  CaptureNecropsyViewData()
    var incernmeString: Int = 0

    @IBAction func incrementBtn(_ sender: AnyObject) {

    }

    @IBAction func minusBtn(_ sender: AnyObject) {

    }

}
