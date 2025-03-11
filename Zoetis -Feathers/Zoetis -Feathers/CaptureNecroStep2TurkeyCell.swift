//
//  CaptureNecroStep2TurkeyCell.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 21/03/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import UIKit

class CaptureNecroStep2TurkeyCell: UICollectionViewCell {

    // Mark :- Necropsy Collection View Cell

    @IBOutlet weak var observationImage: UIImageView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var badgeButton: MIBadgeButton!
    @IBOutlet weak var textFieldActual: UITextField!
    @IBOutlet weak var switchNecropsyBtn: UISwitch!

    // Mark :- Bird Collection View Cell

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var editImage: UIImageView!

    // Mark :- Form Collection View Cell

    @IBOutlet weak var quickLinkIcon: UIImageView!
    @IBOutlet weak var helpButtonOutlet: UIButton!
    @IBOutlet weak var cameraButtonOutlet: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var farmLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var QuickLink: UIButton!

    @IBOutlet weak var notePopBtn: UIButton!

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
