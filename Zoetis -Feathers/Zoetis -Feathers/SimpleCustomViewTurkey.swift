//
//  SimpleCustomViewTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 06/04/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit

protocol infoLinkkTurkey: class {
    func cancelBtnActionTurkey (_ btnTag: Int, data: CaptureNecropsyViewDataTurkey)
}

@IBDesignable class SimpleCustomViewTurkey: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    var view: UIView!
    var birdImages = [String]()
    var obsNmae = String()
    var finailValue = Int()
    var btnIndex = Int()
    var necId = Int()
    var obsDescArr = NSMutableArray()
    var infoImages = NSMutableArray()
    var obsData: CaptureNecropsyViewDataTurkey!
    var items = ["1", "2", "3", "4"]

    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var lblHeader: UILabel!
    var infoLinkkDelegateT: infoLinkkTurkey?

    var finalizeValue: Int!
    @IBOutlet weak var lblTitle: UILabel!
    @IBInspectable var lblTitleText: String? {
        get {
            return lblTitle.text
        }
        set(lblTitleText) {
            lblTitle.text = lblTitleText!
        }
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        loadViewFromNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    func loadViewFromNib() {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SimpleCustomViewTurkey", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)

        self.infoCollectionView.delegate = self
        self.infoCollectionView.dataSource = self

        let nibName = UINib(nibName: "TurkeyInfoCollectionViewCell", bundle: nil)
        infoCollectionView.register(nibName, forCellWithReuseIdentifier: "TurkeyInfoCollectionViewCell")
    }

    @IBAction func closeBttn(_ sender: AnyObject) {

        self.infoLinkkDelegateT!.cancelBtnActionTurkey(btnIndex, data: obsData)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.infoImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: "TurkeyInfoCollectionViewCell", for: indexPath) as! TurkeyInfoCollectionViewCell
        let image = infoImages[indexPath.row] as! UIImage
        cell.infoImageView.image = image
        lblHeader.text = obsNmae
        cell.indexLbl.layer.cornerRadius = cell.indexLbl.frame.size.width / 2
        cell.indexLbl.clipsToBounds = true

        cell.indexLbl.text = String(indexPath.row)
        cell.obsDesc.text = obsDescArr[indexPath.row] as! String
                cell.obsDesc.layoutIfNeeded()
   cell.obsDesc.contentMode = .scaleAspectFit
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let cellSize: CGSize = CGSize(width: 252, height: 380)
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        finailValue =  UserDefaults.standard.value(forKey: "finalizeValue") as! Int

        if finailValue == 1 {

            return
        } else {

            if obsData.measure ==  "Y,N" {

                if indexPath.item == 0 {
                    CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnSwitchMethodTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, switchValue: false, necId: necId as NSNumber)
                } else {
                    CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnSwitchMethodTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, switchValue: true, necId: necId as NSNumber)
                }

                self.infoLinkkDelegateT!.cancelBtnActionTurkey(btnIndex, data: obsData)

            } else if obsData.measure ==  "Actual" {

            } else {
                if  obsData.refId == 58 {

                    if indexPath.row == 0 {
                        let trimmed = obsData.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnStepperTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, index: Int(array[0])!, necId: necId as NSNumber)

                    } else if indexPath.row == 1 {
                        let trimmed = obsData.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnStepperTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, index: Int(array[3])!, necId: necId as NSNumber)

                    } else if indexPath.row == 2 {
                        let trimmed = obsData.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let array = (trimmed.components(separatedBy: ",") as [String])

                        CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnStepperTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, index: Int(array[7])!, necId: necId as NSNumber)
                    }
                } else {
                    let trimmed = obsData.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                    let array = (trimmed.components(separatedBy: ",") as [String])

                    CoreDataHandlerTurkey().updateCaptureSkeletaInDatabaseOnStepperTurkey(obsData.catName!, obsName: obsData.obsName!, formName: obsData.formName!, birdNo: obsData.birdNo!, obsId: obsData.obsID!, index: Int(array[indexPath.row])!, necId: necId as NSNumber)

                }
                self.infoLinkkDelegateT!.cancelBtnActionTurkey(btnIndex, data: obsData)
            }
        }
    }
}
