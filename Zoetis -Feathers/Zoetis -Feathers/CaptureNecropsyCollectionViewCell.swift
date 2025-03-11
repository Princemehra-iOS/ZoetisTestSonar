//
//  CaptureNecropsyCollectionViewCell.swift
//  Zoetis -Feathers
//
//  Created by "" on 8/25/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit

class CaptureNecropsyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var helpButtonAction: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var switchNec: UISwitch!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var farmLabel: UILabel!
    @IBOutlet weak var myLabeldata: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var QuickLink: UIButton!
    @IBOutlet weak var dataIncrement: UILabel!
    @IBOutlet weak var switchBirds: UISwitch!
    @IBOutlet weak var sliderBirds: UISlider!
     @IBOutlet weak var textFieldActual: UITextField!

    @IBOutlet weak var quickLinkIcon: UIImageView!
    @IBOutlet weak var observationImage: UIImageView!
     @IBOutlet weak var infoImage: UIImageView!
     @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var notePopBtn: UIButton!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var badgeButton: MIBadgeButton!

    var mesureValue: String = ""
    var incrementValue  = 0

    @IBOutlet weak var birdsCountLabel: UILabel!
    @IBOutlet weak var incrementLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        self.makeItCircle()
    }

    func makeItCircle() {

    }

}
class CaptureNecropsyCollectionViewCellModel {
    var name: String!
//    var switchOnorOff : Bool!
//    var arrayImage : NSMutableArray!
}
