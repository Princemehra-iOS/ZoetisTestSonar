//
//  AllBirdsViewControllerTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 06/04/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import UIKit

class AllBirdsViewControllerTurkey: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var bgTableView: UITableView!
    @IBOutlet weak var lblForm: UILabel!

    var quickLinkArray  = NSMutableArray()
    var obsNameArray = NSMutableArray()
    var obsFiledArray = NSMutableArray()
    var observationArray = NSMutableArray()
    var birdArray = NSMutableArray()
    var categoryArray = NSMutableArray()
    var birdNo = Int()
    var formName = String()
    var  necId = Int()
    var index = Int()
    var ageValue = String()
    var obsArr = NSMutableArray()
    var storedOffsets = [Int: CGFloat]()
    var postingIdFromExistingNavigate = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(ageValue)
        self.loadData()
        self.bgTableView.estimatedRowHeight = 100
    }

    func loadData() {

        let farmName =  formName + " " + "[" + ageValue + "]"

        var farmName2 = String()
        let range = farmName.range(of: ".")
        if range != nil {
            var abc = String(farmName[range!.upperBound...]) as NSString
            print(abc)
            farmName2 = String(index+1) + "." + " " + String(describing: abc)

        }

//
//
//        let farmNamestr = farmName.components(separatedBy: ". ") as! NSArray
//        var farmName1 = farmNamestr[1]
//        farmName1 = String(index+1) + "." + " " + String(describing:farmName1)
        lblForm.text = farmName2

        var dict = [String: AnyObject]()
        var i = Int()
        i = -1

        let arr =  CoreDataHandlerTurkey().fetchCaptureWithFormNameNecSkeltonDataTurkey(farmName: formName, necID: necId as NSNumber)

        for  j in 0..<arr.count {
            if ((arr.object(at: j) as AnyObject).value(forKey: "quickLink") as AnyObject).int32Value == 1 {

                self.obsNameArray.add((arr.object(at: j) as AnyObject).value(forKey: "obsName")!)

                self.observationArray.add(arr.object(at: j))
                i = i + 1

                let obsName = (self.observationArray.object(at: i) as AnyObject).value(forKey: "obsName") as! String
                let matchObsName = self.obsNameArray.object(at: i) as! String

                if obsName == matchObsName {
                    dict[matchObsName] = arr.object(at: j) as AnyObject

                }
            }
        }

        //print(self.observationArray)

        let arrKeys =  [String](dict.keys) as NSArray

        self.obsNameArray.removeAllObjects()

        for i in 0..<arrKeys.count {
            let obsName = arrKeys.object(at: i) as! String
            self.obsNameArray.add(obsName)
            let captureN = dict[obsName] as! CaptureNecropsyViewDataTurkey
            let noOfBird = self.birdNo
            let obsDictVal = NSMutableDictionary()

            for j in 0..<noOfBird {
                obsDictVal.setObject(captureN, forKey: j+1 as NSCopying)

            }

            obsArr.add(obsDictVal)
        }

        if obsArr.count > 0 {
            //print(obsArr)
            //print(self.observationArray.count)

            self.bgTableView.reloadData()

        } else {
            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "No quicklink is selected. Please go to Settings and select quicklink.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    @IBAction func cancelBtn(_ sender: AnyObject) {
        navigateRoot()
    }

    @IBAction func doneButton(_ sender: AnyObject) {
        navigateRoot()
    }

    func navigateRoot() {
        let isQuickLink: Bool = true

        UserDefaults.standard.set(isQuickLink, forKey: "isQuickLink")
        UserDefaults.standard.synchronize()

        self.navigationController?.popViewController(animated: true)

    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.obsArr.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.obsArr[section] as AnyObject).count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "obsName", for: indexPath) as! ObsNameCollectionViewCell
            cell.obsNameLabel.text = self.obsNameArray.object(at: collectionView.tag) as? String
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "obsField", for: indexPath) as! obsFieldCollectionViewCell
            cell.backgroundColor = UIColor.white
            let d  = self.obsArr.object(at: collectionView.tag) as! NSDictionary
            let arr = d.allKeys as NSArray
            let captureNec: CaptureNecropsyViewDataTurkey = (d.object(forKey: arr.object(at: indexPath.row - 1)) as? CaptureNecropsyViewDataTurkey)!

            let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(indexPath.row as NSNumber, farmname: captureNec.formName!, obsId: captureNec.obsID!, necId: necId as NSNumber)

            let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey

            if c.measure == "Y,N" {
                cell.switchQuickLink.alpha = 1
                cell.actualTexField?.alpha = 0
                cell.incrementBtnOutlet.alpha = 0
                cell.minusBtnOutlet.alpha = 0
                cell.displayLabel.alpha = 0

                if c.objsVisibilty == 1 {
                    cell.switchQuickLink.isOn = true
                } else {
                    cell.switchQuickLink.isOn = false
                }

            } else if c.measure == "Actual" {

                let farmWeight =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkeyWithFarmName(captureNec.formName!, necropsyId: necId as NSNumber)
                let arrdata = farmWeight.object(at: 0) as! CaptureNecropsyDataTurkey
                let result: Float = Float(arrdata.farmWeight!)! / Float(arrdata.noOfBirds!)!
                cell.actualTexField?.delegate = self as UITextFieldDelegate
                cell.switchQuickLink.alpha = 0
                cell.actualTexField?.alpha = 1
                cell.incrementBtnOutlet.alpha = 0
                cell.minusBtnOutlet.alpha = 0
                cell.displayLabel.alpha = 0
                cell.actualTexField?.tag = indexPath.row
                cell.actualTexField?.text = String(describing: result)
                cell.actualTexField?.isUserInteractionEnabled = false
            } else {
                cell.switchQuickLink.alpha = 0
                cell.actualTexField?.alpha = 0
                cell.incrementBtnOutlet.alpha = 1
                cell.minusBtnOutlet.alpha = 1
                cell.displayLabel.alpha = 1
                cell.displayLabel.text = String(c.obsPoint!.int32Value)
                cell.actualTexField?.isUserInteractionEnabled = false
            }

            cell.lblBirdSize.text = String(indexPath.row)
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.black.cgColor

            cell.incrementBtnOutlet.addTarget(self, action: #selector(AllBirdsViewController.plusButtonClick(_:)), for: .touchUpInside)
            cell.incrementBtnOutlet.tag = indexPath.row
            cell.minusBtnOutlet.addTarget(self, action: #selector(AllBirdsViewController.minusButtonClick(_:)), for: .touchUpInside)
            cell.minusBtnOutlet.tag = indexPath.row
            cell.switchQuickLink .addTarget(self, action: #selector(AllBirdsViewControllerTurkey.switchClick(_:)), for: .valueChanged)
            cell.switchQuickLink.tag = indexPath.row

            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print(indexPath.row)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? allBirdsTableViewCell

        if cell == nil {
            cell = allBirdsTableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 180, height: 100)

        cell!.backgroundColor = UIColor.white
        return cell!
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? allBirdsTableViewCell else { return }

        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        guard let tableViewCell = cell as? allBirdsTableViewCell else { return }

        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }

    func plusButtonClick (_ sender: UIButton) {

        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {

            return

        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int

        if cellIndexPath?.row == nil {
            return
        }

        let obsName = self.obsNameArray.object(at: (cellIndexPath?.row)!)
        let formNameValue  = self.formName as String

        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray

        let noofBirdArrOnObs = NSMutableArray()

        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }

        let captureNec: CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!

        let trimmed = captureNec.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let array = (trimmed.components(separatedBy: ",") as [String])

        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)

        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey

        if c.obsPoint == 0 {
            if Int(array[0]) != 0 {
                cell.displayLabel.text = String(array[0])

                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[0])!, necId: necId as NSNumber)
            } else {
                cell.displayLabel.text = String(array[1])

                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[1])!, necId: necId as NSNumber)

            }
        } else {
            for  i in 0..<array.count {
                let lastElement = (Int(array.last!)! as Int)
                if lastElement == Int(array[i])! {

                } else {
                    let value =  Int(array[i] as String)!
                    if  (value as NSNumber == c.obsPoint) {
                        cell.displayLabel.text = String(array[i+1])

                        CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[i+1])!, necId: necId as NSNumber)
                        break

                    }

                }

            }

        }

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync: true)

        } else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }

    func minusButtonClick (_ sender: UIButton) {

        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {

            return
        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int
        if cellIndexPath?.row == nil {
            return
        }
        let obsName = self.obsNameArray.object(at: (cellIndexPath?.row)!)
        let formNameValue  = self.formName as String

        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()

        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec: CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!

        let trimmed = captureNec.measure!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let array = (trimmed.components(separatedBy: ",") as [String])

        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)

        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey

        if fethchArr.count > 0 {
            if c.obsPoint == 0 {

            } else {

                for  i in 0..<array.count {

                    if Int(array[i]) == 1 {

                    } else {

                        if c.obsPoint == 1 {
                            if Int(array[i]) == 0 {
                                cell.displayLabel.text = array[0]
                                CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[0])!, necId: necId as NSNumber)

                                break
                            }
                        }
                        let value = Int(array[i])
                        if ((value! as NSNumber) == c.obsPoint) {
                            cell.displayLabel.text = array[i-1]
                            CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(obsName as! String, formName: formNameValue, birdNo: noOfBird as NSNumber, obsId: captureNec.obsID!, index: Int(array[i-1])!, necId: necId as NSNumber)

                            break

                        }
                    }

                }

            }

        }
        if UserDefaults.standard.bool(forKey: "Unlinked") == true {
            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync: true)
        } else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }

    @objc func switchClick(_ sender: UISwitch) {

        guard let cell = sender.superview!.superview as? obsFieldCollectionViewCell else {
            return
        }
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =  cell.incrementBtnOutlet.tag as Int

        let formNameValue  = self.formName as String
        if cellIndexPath?.row == nil {
            return
        }
        guard let d = self.obsArr.object(at: (cellIndexPath?.row)!) as? NSDictionary else {
            return
        }
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()

        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec: CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!

        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)

        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey

        CoreDataHandlerTurkey().updateSwitchDataInCaptureSkeletaInDatabaseOnSwitchTurkey(formNameValue, birdNo: noOfBird as NSNumber, obsId: c.obsID!, obsVisibility: sender.isOn, necId: necId as NSNumber)

        cell.switchQuickLink.isOn = sender.isOn

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync: true)
        } else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

        let rowIndex: Int = textField.tag
        let cell = textField.superview!.superview as! obsFieldCollectionViewCell
        let pointInTable: CGPoint = textField.convert(textField.bounds.origin, to: self.bgTableView)
        let cellIndexPath = self.bgTableView.indexPathForRow(at: pointInTable)
        let noOfBird =   cell.actualTexField?.tag

        let formNameValue  = self.formName as String
        if cellIndexPath?.row == nil {
            return
        }

        let d  = self.obsArr.object(at: (cellIndexPath?.row)!) as! NSDictionary
        let arr = d.allKeys as NSArray
        let noofBirdArrOnObs = NSMutableArray()

        for i in 0..<arr.count {
            noofBirdArrOnObs.add(i+1)
        }
        let captureNec: CaptureNecropsyViewDataTurkey = (d.object(forKey: noofBirdArrOnObs.object(at: cell.incrementBtnOutlet.tag - 1)) as? CaptureNecropsyViewDataTurkey)!

        let fethchArr = CoreDataHandlerTurkey().fecthFrmWithBirdAndObservationTurkey(noOfBird! as NSNumber, farmname: formNameValue, obsId: captureNec.obsID!, necId: necId as NSNumber)

        let c = fethchArr.object(at: 0) as! CaptureNecropsyViewDataTurkey

        CoreDataHandlerTurkey().updateObsDataInCaptureSkeletaInDatabaseOnActualTurkey(formName, formName: formNameValue, birdNo: noOfBird! as NSNumber, obsId: captureNec.obsID!, actualName: textField.text!, necId: necId as NSNumber)

        if UserDefaults.standard.bool(forKey: "Unlinked") == true {

            CoreDataHandlerTurkey().updateisSyncNecropsystep1WithneccIdTurkey(necId as NSNumber, isSync: true)
        } else {
            CoreDataHandlerTurkey().updateisSyncTrueOnPostingSessionTurkey(necId as NSNumber)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")

        if (string == "1" || string == "2" || string == "3" || string == "4" || string == "5" || string == "6" || string == "7" || string == "8" || string == "9" || string == "0" || string == "." || isBackSpace == -92 ) {
            var _ : Bool!
            if(self.checkCharacter(string, textField: textField)) {
                let cell = textField.superview!.superview as! obsFieldCollectionViewCell
                if textField == cell.actualTexField {

                    var computationString: String = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let length = computationString.characters.count
                    if (length > 5) {
                        return false
                    }
                }
            }
            return true
        }
        return false
    }

    func checkCharacter( _ inputChar: String, textField: UITextField ) -> Bool {

        let newCharacters = CharacterSet(charactersIn: inputChar)
        let boolIsNumber = CharacterSet.decimalDigits.isSuperset(of: newCharacters)
        if boolIsNumber == true {
            return true

        } else {

            if inputChar == "." {
                let countdots = textField.text!.components(separatedBy: ".").count - 1
                if countdots == 0 {
                    return true

                } else {
                    if countdots > 0 && inputChar == "." {
                        return false
                    } else {
                        return true
                    }
                }
            } else {
                return false
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}
