//
//  PostingSessionDetailController.swift
//  Zoetis -Feathers
//
//  Created by "" on 8/22/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import Alamofire
import ReachabilitySwift
import SystemConfiguration

class PostingSessionDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource, userLogOut, syncApi, SyncApiData,
openNotes, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var synCount: UILabel!

    @IBOutlet weak var updateDateButton: UIButton!
    var customPopView1: UserListView!
    var age: String?
    let bttnbckround = UIButton()
    var myPickerView = UIPickerView()
    var buttonbgNew = UIButton()
    var accestoken = String()
    var deviceTokenId = String()
    var  fullData  = String()
    var  strFeddCheck  = String()
    var timer  = Timer()
    var feedTableView  =  UITableView()
    var btnTag = Int()
    var strfarmName = String()
    var strFeddUpdate = String()
    var feedIdUpdate = NSNumber()
    var buttonbgNew2 = UIButton()
    let buttonEdit: UIButton = UIButton()
    var camraImgeArr  = NSArray()
    var strdateTimeStamp = String()
    var strfarmNameArray = NSArray()
    var strFarmNameFeedId = String()
    var  strMsgforDelete = String()
    var strFeedId = Int()
    let objApiSync = ApiSync()
    let objApiSyncOneSet = SingleSyncData()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let AgeOp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]
    @IBOutlet weak var finializeBttnOutlet: UIButton!
    var finilizeValue = NSNumber()
    var oldFarmName = NSString()
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var lblFeedProgram: UILabel!
    @IBOutlet weak var sessionDate: UILabel!
    @IBOutlet weak var complexNamelbl: UILabel!
    @IBOutlet weak var salesRepLbl: UILabel!
    @IBOutlet weak var btnAddVaci: UIButton!
    @IBOutlet weak var sessionTypeLbl: UILabel!
    @IBOutlet weak var customerRepLbl: UILabel!
    @IBOutlet weak var cocciProgramLbl: UILabel!
    @IBOutlet weak var customerLbl: UILabel!
    @IBOutlet weak var veterinarianLbl: UILabel!
    @IBOutlet weak var notesTextField: UILabel!
    @IBOutlet weak var eyeImageView: UIImageView!
    @IBOutlet weak var vaccinationTextField: UILabel!
    @IBOutlet weak var feedProtableView: UITableView!
    var lngId = NSInteger()
    let buttonbg1 = UIButton()
    var droperTableView  =  UITableView()
    var postingArrWithId = NSMutableArray()
    var feedProArrWithId = NSMutableArray()
    var captureNecropsy = [NSManagedObject]()
    var postingId = NSNumber()
    var necId = NSNumber()
    var farmArray = NSMutableArray()
    var vacArray = NSMutableArray()
    let cellReuseIdentifier = "cell"
    var editFinalizeValue = NSNumber()
    var datePicker = UIDatePicker()
    var timeStamp = String()
    var actualTimestamp = String()
    let editView = UIView(frame: CGRect(x: 250, y: 220, width: 500, height: 330))
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 50))
    let nameLabel = UILabel(frame: CGRect(x: 42, y: 53, width: 300, height: 50))
    let titleLabel = UILabel(frame: CGRect(x: 150, y: 0, width: 400, height: 50))
    let ageLabel = UILabel(frame: CGRect(x: 42, y: 142, width: 100, height: 50))
    let feedLabel = UILabel(frame: CGRect(x: 190, y: 142, width: 300, height: 50))
    let nameText = UITextField(frame: CGRect(x: 40, y: 98, width: 420, height: 50))
    let ageButton = UIButton(frame: CGRect(x: 43, y: 184, width: 120, height: 50))
    let feedButton = UIButton(frame: CGRect(x: 190, y: 184, width: 268, height: 50))
    let submitButton = UIButton(frame: CGRect(x: 30, y: 270, width: 175, height: 40))
    let cancelButton = UIButton(frame: CGRect(x: 290, y: 270, width: 175, height: 40))
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
    let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
    let targetWeight = UITextField(frame: CGRect(x: 40, y: 270, width: 420, height: 50))
    @IBOutlet weak var feedProgramBtnOutlet: UIButton!

    @IBAction func bckBttnAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        objApiSync.delegeteSyncApi = self
        objApiSyncOneSet.delegeteSyncApiData = self
        feedProtableView.estimatedRowHeight = 50
        feedProtableView.rowHeight = UITableView.automaticDimension

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="MM-dd-yyyy HH:mm:ss"
        strdateTimeStamp = dateFormatter.string(from: datePicker.date) as String
        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        notesBtnnOutlet.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        btnAddVaci.layer.borderWidth = 1.0
        btnAddVaci.layer.borderColor = UIColor.black.cgColor
        notesBtnnOutlet.layer.borderWidth = 1.0
        notesBtnnOutlet.layer.borderColor = UIColor.black.cgColor
        postingArrWithId = CoreDataHandler().fetchAllPostingSession(postingId).mutableCopy() as! NSMutableArray
        let posting: PostingSession = postingArrWithId.object(at: 0) as! PostingSession

        let lngIdFr = UserDefaults.standard.integer(forKey: "lngId")
        if lngIdFr == 3 {
            let dateString = posting.sessiondate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateObj = dateFormatter.date(from: dateString!)
            dateFormatter.dateFormat = "dd/MM/yyyy"
            sessionDate.text = dateFormatter.string(from: dateObj!)
            UserDefaults.standard.set(dateFormatter.string(from: dateObj!), forKey: "dateFrench")    // value(forKey: "dateFrench") as? String
        } else {
            sessionDate.text = posting.sessiondate
        }

        complexNamelbl.text = posting.complexName
        deviceTokenId = posting.timeStamp!
        let optionalName: String? = posting.actualTimeStamp

        if optionalName == nil {
            actualTimestamp = ""
        }
        UserDefaults.standard.set(sessionDate.text, forKey: "date")
        UserDefaults.standard.set(complexNamelbl.text, forKey: "complex")
        UserDefaults.standard.synchronize()
        if posting.salesRepName == NSLocalizedString("- Select -", comment: "") || posting.salesRepName == "- Select -"{
            salesRepLbl.text = "NA"
        } else {
            salesRepLbl.text = posting.salesRepName
        }

        sessionTypeLbl.text = posting.sessionTypeName
        if  posting.customerRepName == ""{
            customerRepLbl.text = "NA"
        } else {
            customerRepLbl.text = posting.customerRepName
        }

        cocciProgramLbl.text = posting.cociiProgramName
        if cocciProgramLbl.text == NSLocalizedString("- Select -", comment: "") {
            cocciProgramLbl.text = ""
        }

        customerLbl.text = posting.customerName
        UserDefaults.standard.set( customerLbl.text, forKey: "custmer")
        veterinarianLbl.text = posting.vetanatrionName
        notesBtnnOutlet.setTitle(posting.notes, for: UIControl.State())
        UserDefaults.standard.set( posting.notes, forKey: "postingSessionNotes")
        feedProtableView.reloadData()
        feedProgramBtnOutlet.layer.borderWidth = 1
        feedProgramBtnOutlet.layer.borderColor = UIColor.black.cgColor
    }

    override func viewWillAppear(_ animated: Bool) {
        self.printSyncLblCount()
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1NecId(postingId) as! [NSManagedObject]
        notesBtnnOutlet.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
        self.fetcFarmData()
        vacArray  =  CoreDataHandler().fetchAddvacinationData(postingId).mutableCopy() as! NSMutableArray
        if vacArray.count>0 {
            let vac: HatcheryVac = vacArray.object(at: 0) as! HatcheryVac
            vaccinationTextField.text = vac.vaciNationProgram
        }
        feedProArrWithId = CoreDataHandler().FetchFeedProgram(postingId).mutableCopy() as! NSMutableArray

        if  feedProArrWithId.count == 1 {

            lblFeedProgram.text = (feedProArrWithId.object(at: 0) as AnyObject).value(forKey: "feddProgramNam") as? String
            (feedProArrWithId.object(at: 0) as AnyObject).value(forKey: "feddProgramNam") as? String
        }

        if feedProArrWithId.count > 1 {
            let ftitle = NSMutableString()
            for i in 0..<feedProArrWithId.count {

                var label = UILabel()
                let feepRGMR = (feedProArrWithId.object(at: i) as AnyObject).value(forKey: "feddProgramNam") as! String

                if i == 0 {

                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111, height: 21))
                    ftitle.append( feepRGMR + " " )

                } else {

                    label  = UILabel(frame: CGRect(x: 50, y: 519, width: 111*(CGFloat(i)+1)+10, height: 21))
                    ftitle.append(", " + feepRGMR + " " )
                }

                label.textAlignment = NSTextAlignment.center
                label.backgroundColor = UIColor.red
                lblFeedProgram.text = ftitle as String
            }
        }

        if finilizeValue == 1 {

            finializeBttnOutlet.isHidden = true
            notesBtnnOutlet.isUserInteractionEnabled = true
            btnAddVaci.isUserInteractionEnabled = true
            feedProgramBtnOutlet.isUserInteractionEnabled = true
            eyeImageView.image = UIImage(named: "eye_blue")!

        } else if finilizeValue == 0 {
            eyeImageView.image =  UIImage(named: "eye_orange")!

        }

        finializeBttnOutlet.layer.cornerRadius = 7
        self.feedProtableView.reloadData()

    }
    @IBAction func addVacButtonAction(_ sender: AnyObject) {

        let navigateToController = self.storyboard?.instantiateViewController(withIdentifier: "add") as? AddVaccinationViewController
        navigateToController?.postingIdFromExisting = postingId as NSNumber
        navigateToController?.finalizeValue = finilizeValue
        navigateToController?.postingIdFromExistingNavigate = "Exting"
        self.navigationController?.pushViewController(navigateToController!, animated: false)

    }

    func fetcFarmData() {

        self.captureNecropsy =  CoreDataHandler().FetchNecropsystep1NecId(postingId) as! [NSManagedObject]
        farmArray.removeAllObjects()
        for object in captureNecropsy {

            let dictDat = NSMutableDictionary()

            dictDat.setObject(object.value(forKey: "farmName") ?? "", forKey: ("farmName" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "noOfBirds") ?? 0, forKey: ("noOfBirds" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "houseNo") ?? 0, forKey: ("houseNo" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "age")  ?? 0, forKey: ("age" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "necropsyId") ?? 0, forKey: ("necropsyId" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "timeStamp") ?? "", forKey: ("timeStamp" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "feedProgram") ?? "", forKey: ("feedProgram" as? NSCopying)!)
            dictDat.setObject(object.value(forKey: "feedId") ?? -2332, forKey: ("feedId" as? NSCopying)!)
            farmArray.add(dictDat)

        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == droperTableView {
            return feedProArrWithId.count
        }
        return farmArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == droperTableView {

            let cell = UITableViewCell()
            let feedProgram: FeedProgram = feedProArrWithId.object(at: indexPath.row) as! FeedProgram
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.textLabel!.text = feedProgram.feddProgramNam
            cell.tag = feedProgram.feedId as! Int
            return cell

        } else {

            let cell: PostingSessionDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PostingSessionDetailTableViewCell

            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
            } else {
                cell.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
            }

            var farmArrayWithoutAge = (farmArray.object(at: indexPath.row) as AnyObject).value(forKey: "farmName") as? String
            let age = ((farmArray as AnyObject).object(at: indexPath.row) as AnyObject).value(forKey: "age") as! String
            let farmNamevalue =  farmArrayWithoutAge!  + " " + "[" + age + "]"

            var farmName2 = String()
            let range = farmNamevalue.range(of: ".")
            if range != nil {
                let abc = String(farmNamevalue[range!.upperBound...]) as NSString
                print(abc)
                farmName2 = String(indexPath.row+1) + "." + " " + String(describing: abc)
            }

            cell.farmsLabel.text = farmName2
            cell.updateButton.layer.borderWidth = 8.0
            cell.updateButton.layer.cornerRadius = 17.5
            cell.updateButton.layer.borderColor = UIColor.clear.cgColor
            cell.updateButton.tag = indexPath.row
            cell.houseNoLbl.text = (farmArray.object(at: indexPath.row) as AnyObject).value(forKey: "houseNo") as? String
            cell.noofBirdsLbl.text = (farmArray.object(at: indexPath.row) as AnyObject).value(forKey: "noOfBirds") as? String

            camraImgeArr = CoreDataHandler().fecthPhotoWithFormName(farmArrayWithoutAge!, necId: (((farmArray.object(at: indexPath.row)) as AnyObject).value(forKey: "necropsyId") as? NSNumber)!)
            cell.backgroundColor = UIColor.clear
            cell.badgeBttn.alpha = 1
            cell.badgeBttn.badgeString = String(camraImgeArr.count) as String
            cell.badgeBttn.badgeTextColor = UIColor.white
            cell.badgeBttn.badgeEdgeInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 15)
            cell.badgeBttn.addTarget(self, action: #selector(PostingSessionDetailController.clickImage(_:)), for: .touchUpInside)
            cell.badgeBttn.tag = indexPath.row
            cell.feedPrgrmLbl.text = (farmArray.object(at: indexPath.row) as AnyObject).value(forKey: "feedProgram") as? String
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(PostingSessionDetailController.ClickDeleteBtton(_:)), for: .touchUpInside)

            if finilizeValue == 1 {
                cell.badgeBttn.setImage(UIImage(named: "galaryBlue"), for: UIControl.State())
                cell.deleteButton.isUserInteractionEnabled = false
                cell.deleteButton.isHidden = true

            } else {
                cell.badgeBttn.setImage(UIImage(named: "galary"), for: UIControl.State())
                cell.deleteButton.isUserInteractionEnabled = true
                cell.deleteButton.isHidden = false
            }
            if camraImgeArr.count<1 {
                cell.badgeBttn.isEnabled = false
            } else {
                cell.badgeBttn.isEnabled = true
            }
            return cell
        }
    }

    @objc func ClickDeleteBtton(_ sender: UIButton) {
        let indexpath = NSIndexPath(row: sender.tag, section: 0)
        let cell =  self.feedProtableView.cellForRow(at: indexpath as IndexPath) as? PostingSessionDetailTableViewCell
        cell?.backgroundColor = UIColor.gray
        if farmArray.count == 1 {

            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("You can not delete all farms. One farm is mandatory for this session.", comment: ""), preferredStyle: .alert)
            let action1 = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (_) in
                print("Default is pressed.....")
                cell?.backgroundColor = UIColor.clear
            }
            alertController.addAction(action1)
            self.present(alertController, animated: true, completion: nil)

        } else {

            let farmArrayWithoutAge = (farmArray.object(at: sender.tag) as AnyObject).value(forKey: "farmName") as? String
            let necId = ((farmArray.object(at: sender.tag) as AnyObject).value(forKey: "necropsyId") as? Int)!

            let dataArr = CoreDataHandler().fecthFrmWithCatnameWithBirdAndObservationWithDelete(farmname: farmArrayWithoutAge!, necId: necId as NSNumber)
            if dataArr.count > 0 {

                for i in 0..<dataArr.count {

                    let obspoint = (dataArr.object(at: i) as AnyObject).value(forKey: "obsPoint") as! Int
                    let obsVal = (dataArr.object(at: i) as AnyObject).value(forKey: "objsVisibilty") as! Int

                    if obspoint > 0 || obsVal > 0 {
                        //print("tum mile ")
                        strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm? You have observation recorded for this farm.", comment: "")

                        break
                    } else {
                        strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm?", comment: "")
                    }
                }
            } else {
                strMsgforDelete = NSLocalizedString("Are you sure you want to delete this farm?", comment: "")
            }

            let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString(strMsgforDelete, comment: ""), preferredStyle: .alert)
            let action1 = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default) { (_) in
                print("Default is pressed.....")

                CoreDataHandler().deleteDataWithPostingIdStep1dataWithfarmName(necId as NSNumber, farmName: farmArrayWithoutAge!, { (success) in
                    if success == true {
                        CoreDataHandler().deleteDataWithPostingIdStep2dataCaptureNecViewWithfarmName(necId as NSNumber, farmName: farmArrayWithoutAge!, { (success) in
                            if success == true {

                                CoreDataHandler().deleteDataWithPostingIdStep2NotesBirdWithFarmName(necId as NSNumber, farmName: farmArrayWithoutAge!, { (success) in
                                    if success == true {

                                        CoreDataHandler().deleteDataWithPostingIdStep2CameraIamgeWithFarmName(necId as NSNumber, farmName: farmArrayWithoutAge!, { (success) in
                                            if success == true {

                                                self.fetcFarmData()
                                                self.appDelegate.saveContext()
                                                self.feedProtableView.reloadData()

                                            }
                                        })
                                    }})

                            }})

                    }})
            }

            let action2 = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel) { (_) in
                print("Cancel is pressed......")
                cell?.backgroundColor = UIColor.clear
            }

            alertController.addAction(action1)
            alertController.addAction(action2)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if tableView == droperTableView {

            let feedProgram: FeedProgram = feedProArrWithId.object(at: indexPath.row) as! FeedProgram
            strFeddUpdate = feedProgram.feddProgramNam!
            feedIdUpdate = feedProgram.feedId!
            if btnTag == 1 {

                CoreDataHandler().updatedPostigSessionwithIsFarmSyncPostingId(self.postingId, isFarmSync: false)
                feedButton.setTitle(feedProgram.feddProgramNam!, for: .normal)
            } else {

                let navigateToController = self.storyboard?.instantiateViewController(withIdentifier: "feed") as? FeedProgramViewController
                navigateToController!.postingIdFromExisting = postingId as! Int
                navigateToController!.FeedIdFromExisting = feedProgram.feedId as! Int

                navigateToController!.finializeCount = finilizeValue
                navigateToController?.postingIdFromExistingNavigate = "Exting"
                self.navigationController?.pushViewController(navigateToController!, animated: false)
                lblFeedProgram.text = feedProgram.feddProgramNam
            }
            self.buttonPreddDroper()

        } else {

            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "capture") as? CaptureNecropsyDataViewController
            mapViewControllerObj?.editFinalizeValue = editFinalizeValue as! Int
            let necIdFromExist =  (farmArray.object(at: indexPath.row) as AnyObject).value(forKey: "necropsyId") as? Int
            mapViewControllerObj?.postingIdFromExisting = necIdFromExist!
            mapViewControllerObj?.nsIndexPathFromExist = indexPath.row
            mapViewControllerObj?.postingIdFromExistingNavigate = "Exting"
            mapViewControllerObj!.finalizeValue = finilizeValue as! Int

            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
        }
    }

    @objc func clickImage(_ sender: UIButton) {

        let formname = (farmArray.object(at: sender.tag) as AnyObject).value(forKey: "farmName") as? String
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "image") as? ImageViewController
        //photoDict.setValue(sender.tag, forKey: "index")
        mapViewControllerObj!.farmname = formname!
        //mapViewControllerObj.
        mapViewControllerObj!.necId = ((farmArray.object(at: sender.tag) as AnyObject).value(forKey: "necropsyId") as? Int)!
        mapViewControllerObj!.postingIdFromExistingNavigate = "Exting"
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
    }

    @IBAction func feedProgramBtnAction(_ sender: AnyObject) {
        btnTag = 0
        feedProArrWithId = CoreDataHandler().FetchFeedProgram(postingId).mutableCopy() as! NSMutableArray
        self.tableViewpop()
        droperTableView.frame = CGRect( x: 190, y: 280, width: 300, height: 130)
        droperTableView.reloadData()

    }
    func tableViewpop() {

        buttonbg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg1.addTarget(self, action: #selector(PostingSessionDetailController.buttonPreddDroper), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view.addSubview(buttonbg1)
        droperTableView.delegate = self
        droperTableView.dataSource = self
        droperTableView.layer.cornerRadius = 8.0
        droperTableView.layer.borderWidth = 1.0
        droperTableView.layer.borderColor =  UIColor.lightGray.cgColor
        buttonbg1.addSubview(droperTableView)

    }

    @objc func buttonPreddDroper() {

        buttonbg1.removeFromSuperview()
    }

    @IBAction func finalizeBtnAction(_ sender: AnyObject) {

        CoreDataHandler().updateFinalizeData(self.postingId, finalize: 1, isSync: true)
        let navigateController = self.storyboard?.instantiateViewController(withIdentifier: "Existing") as? ExistingPostingSessionViewController
        self.navigationController?.pushViewController(navigateController!, animated: false)

    }

    @IBAction func logOutBtnAction(_ sender: AnyObject) {
        clickHelpPopUp()
    }

    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView, indexValue: String) {

        if indexValue == "Log Out" {

            UserDefaults.standard.removeObject(forKey: "login")
            if WebClass.sharedInstance.connected() == true {

                CoreDataHandler().deleteAllData("Custmer")
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)

            buttonbgNew2.removeFromSuperview()
            customPopView1.removeView(view)
        }
    }

    func clickHelpPopUp() {

        bttnbckround.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        bttnbckround.addTarget(self, action: #selector(PostingViewController.buttonPressed11), for: .touchUpInside)
        bttnbckround.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(bttnbckround)

        customPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        customPopView1.logoutDelegate = self
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.bttnbckround .addSubview(customPopView1)
        customPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200, y: 60, width: 150, height: 60))

    }

    func buttonPressed11() {
        customPopView1.removeView(view)
        bttnbckround.removeFromSuperview()
    }

    var notesBGbtn = UIButton()
    var notesView: notes!
    @IBOutlet weak var notesBtnnOutlet: UIButton!
    @IBAction func notesBttnAction(_ sender: AnyObject) {

        let notesDict = NSMutableArray()
        notesBGbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        notesBGbtn.backgroundColor = UIColor.black
        notesBGbtn.alpha = 0.6
        notesBGbtn.setTitle("", for: UIControl.State())
        notesBGbtn.addTarget(self, action: #selector(notesButtonAcn), for: .touchUpInside)
        self.view.addSubview(notesBGbtn)

        notesView = notes.loadFromNibNamed("Notes") as! notes
        notesView.strExist = "Exting"
        notesView.noteDelegate = self
        notesView.noOfBird = sender.tag + 1
        notesView.notesDict = notesDict
        notesView.finalizeValue = finilizeValue as! Int
        notesView.center = self.view.center

        self.view.addSubview(notesView)

    }

    @objc func notesButtonAcn(_ sender: UIButton!) {

        self.notesBGbtn.removeFromSuperview()
        self.notesView.removeFromSuperview()
    }

    func openNoteFunc() {

        self.notesBGbtn.removeFromSuperview()
        self.notesView.removeFromSuperview()
    }

    func doneBtnFunc(_ notes: NSMutableArray, notesText: String, noOfBird: Int) {
        // deafult

    }

    func  postingNotesdoneBtnFunc(_ notesText: String) {

        CoreDataHandler().updateFinalizeDataWithNecNotes(postingId, notes: notesText)
        postingArrWithId = CoreDataHandler().fetchAllPostingSession(postingId).mutableCopy() as! NSMutableArray
        let posting: PostingSession = postingArrWithId.object(at: 0) as! PostingSession
        notesBtnnOutlet.setTitle(posting.notes, for: UIControl.State())
        // notesTextField.text = posting.notes
        UserDefaults.standard.set( posting.notes, forKey: "postingSessionNotes")
        self.notesBGbtn.removeFromSuperview()
        self.notesView.removeFromSuperview()
        self.printSyncLblCount()

    }
    func allSessionArr() -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        let cNecArr = CoreDataHandler().FetchNecropsystep1WithisSync(true)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }

        let allPostingSessionArr = NSMutableArray()

        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSession
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }

        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyData
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }

        return allPostingSessionArr
    }

    func allSessionArrWithPostingId(PId: NSNumber) -> NSMutableArray {

        let postingArrWithAllData = CoreDataHandler().fetchAllPostingSession(postingId).mutableCopy() as! NSMutableArray
        let cNecArr =  CoreDataHandler().FetchNecropsystep1NecId(postingId)
        let necArrWithoutPosting = NSMutableArray()

        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyData
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1 {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyData
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
            }
        }

        let allPostingSessionArr = NSMutableArray()

        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSession
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }

        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyData
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }

        return allPostingSessionArr
    }
    @IBAction func syncAction(_ sender: AnyObject) {

        if self.allSessionArr().count > 0 {
            if WebClass.sharedInstance.connected()  == true {

                let lngId = UserDefaults.standard.integer(forKey: "lngId")
                var strMsg = String()
                if lngId == 5 {
                    strMsg = "Sincronización de datos ..."
                } else if lngId == 1 {
                    strMsg = "Data syncing..."
                } else if lngId == 3 {
                    strMsg = "Synchronisation des données ..."
                }
                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString(strMsg, comment: ""))

                self.callSyncApi()
            } else {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))

            }

        } else {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data not available for syncing.", comment: ""))
        }

    }
    func callSyncApi() {
        objApiSync.feedprogram()
    }
    func callSyncApiPostingId(Pid: NSNumber) {
        objApiSyncOneSet.feedprogram(postingId: Pid)
    }
    // MARK: -- Delegate SyNC Api

    func failWithError(statusCode: Int) {

        Helper.dismissGlobalHUD(self.view)
        self.printSyncLblCount()

        if statusCode == 0 {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        } else {

            if lngId == 1 {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again. \n(\(statusCode))")

            } else if lngId == 3 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")

            }

        }
    }
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)

        self.printSyncLblCount()

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Server error please try again .", comment: ""))
    }

    func didFinishApi() {
        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
        self.printSyncLblCount()
    }

    func failWithInternetConnection() {

        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }

    func printSyncLblCount() {

        synCount.text = String(self.allSessionArr().count)
    }

    @IBAction func updateDateButtonClicked(_ sender: UIButton) {

    }
    // MARK: - Button Done and Cancel
    func doneClick() {
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat="MM/dd/yyyy"
        let strdate = dateFormatter2.string(from: datePicker.date) as String
        sessionDate.text = strdate

        //CoreDataHandler().updatePostingdate(postingId, sessiondate: sessionDate.text! as NSString)
        self.buttonbgNew.removeFromSuperview()
    }
    func cancelClick() {

        self.buttonbgNew.removeFromSuperview()
    }

    @objc func buttonPressed() {
        feedButton.titleLabel?.text = ""
        strFeddUpdate = ""
        strFarmNameFeedId = ""
        strFeddCheck = ""

        UIView.animate(withDuration: 0.5, animations: {
            self.buttonEdit.frame = CGRect(x: 0, y: 768, width: 1024, height: 768)
        })
        DispatchQueue.main.async {
            sleep(1)
            self.buttonbgNew2.removeFromSuperview()
            self.buttonEdit.removeFromSuperview()
        }
    }
    @objc func buttonPressedAgeList() {

        self.buttonbgNew2.removeFromSuperview()

    }

    // MARK: - Farm Table Update Action

    @IBAction func editFarmNameTable(_ sender: UIButton) {

        showUpdateView(sender: sender.tag)

    }
    @objc func updateAge() {
        // ageButton.setTitle(age, for: .normal)
        showAgesList()

    }

    func showUpdateView(sender: Int) {
        buttonEdit.setTitleColor(UIColor.blue, for: UIControl.State())
        buttonEdit.frame = CGRect(x: 0, y: 1500, width: 1024, height: 768)
        buttonEdit.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        buttonEdit.addTarget(self, action: #selector( PostingSessionDetailController.buttonPressed), for: .touchUpInside)
        editView.backgroundColor = UIColor.white
        editView.layer.cornerRadius = 25
        editView.layer.masksToBounds = true
        titleView.backgroundColor = UIColor(red: 11/255, green: 88/255, blue: 160/255, alpha: 1.0)

        titleLabel.text = NSLocalizedString("Update Farm", comment: "")
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.textColor = UIColor.white
        nameLabel.text = NSLocalizedString("Farm Name * : ", comment: "")
        ageLabel.text = NSLocalizedString("Age * :", comment: "")
        feedLabel.text = NSLocalizedString("Feed Program * :", comment: "")
        nameText.layer.borderColor =  UIColor.gray.cgColor
        nameText.delegate = self
        nameText.layer.borderWidth = 1
        nameText.leftView = paddingView
        nameText.leftViewMode = UITextField.ViewMode.always

        targetWeight.layer.borderColor =  UIColor.red.cgColor
        targetWeight.delegate = self
        targetWeight.layer.borderWidth = 1
        targetWeight.leftView = paddingView1
        targetWeight.leftViewMode = UITextField.ViewMode.always
        strfarmName = ((farmArray.object(at: sender) as AnyObject).value(forKey: "farmName") as? String)!
        strFeedId = ((farmArray.object(at: sender) as AnyObject).value(forKey: "feedId") as? Int)!
        strFarmNameFeedId = ((farmArray.object(at: sender) as AnyObject).value(forKey: "feedProgram") as? String)!
        feedButton.setTitle((farmArray.object(at: sender) as AnyObject).value(forKey: "feedProgram") as? String, for: .normal)
        strfarmNameArray = strfarmName.components(separatedBy: ". ") as NSArray
        let farmName = strfarmNameArray[1]

        nameText.text = farmName as? String
        nameText.layer.cornerRadius = 5.0
        nameText.layer.borderWidth = 1
        nameText.returnKeyType = UIReturnKeyType.done

        targetWeight.text = UserDefaults.standard.value(forKey: "targetWeight") as? String
        targetWeight.layer.cornerRadius = 5.0
        targetWeight.layer.borderWidth = 1
        targetWeight.returnKeyType = UIReturnKeyType.done

        oldFarmName = strfarmName as NSString
        ageButton.layer.borderColor =  UIColor.gray.cgColor
        ageButton.layer.cornerRadius = 5.0
        ageButton.layer.borderWidth = 1
        ageButton.setTitleColor(UIColor.red, for: .normal)
        ageButton.contentVerticalAlignment = .center
        ageButton.titleEdgeInsets = UIEdgeInsets.init(top: 5.0, left: 10.0, bottom: 0.0, right: 0.0)
        ageButton.setTitle("\(((farmArray.object(at: sender) as AnyObject).value(forKey: "age") as? String)!)", for: .normal)
        ageButton.addTarget(self, action: #selector( PostingSessionDetailController.updateAge), for: .touchUpInside)
        ageButton.setBackgroundImage(UIImage(named: "dialer01"), for: .normal)
        ageButton.contentHorizontalAlignment = .left
        feedButton.layer.cornerRadius = 5.0
        feedButton.layer.borderWidth = 1
        feedButton.contentHorizontalAlignment = .left
        feedButton.contentEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        feedButton.setTitle(strFarmNameFeedId, for: .normal)
        if let value = feedButton.titleLabel?.text {
            strFeddCheck = value
        }
        feedButton.setTitleColor(UIColor.black, for: .normal)
        feedButton.layer.borderColor =  UIColor.gray.cgColor
        feedButton.addTarget(self, action: #selector( PostingSessionDetailController.feedPressed), for: .touchUpInside)
        let  btnView = UIView()
        let  btnView1 = UIView()

        btnView.frame =   CGRect(x: 20, y: 260, width: 460, height: 0.5)
        btnView.backgroundColor = UIColor.gray
        btnView1.frame =  CGRect(x: 250, y: 268, width: 1, height: 50)
        btnView1.backgroundColor = UIColor.gray
        editView.addSubview(btnView)
        editView.addSubview(btnView1)
        submitButton.backgroundColor = UIColor.clear
        submitButton.tintColor = UIColor.white
        submitButton.setTitle(NSLocalizedString("Update", comment: ""), for: .normal)
        submitButton.titleLabel!.font =  UIFont(name: "Arial", size: 20)
        submitButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 228/255, alpha: 1.0), for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        submitButton.addTarget(self, action: #selector( PostingSessionDetailController.updatePressed), for: .touchUpInside)

        cancelButton.backgroundColor = UIColor.clear
        cancelButton.tintColor = UIColor.white
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.titleLabel!.font =  UIFont(name: "Arial", size: 20)
        cancelButton.setTitleColor(UIColor(red: 0/255, green: 122/255, blue: 228/255, alpha: 1.0), for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector( PostingSessionDetailController.buttonPressed), for: .touchUpInside)
        editView.addSubview(titleView)
        titleView.addSubview(titleLabel)
        editView.addSubview(nameLabel)
        editView.addSubview(ageLabel)
        editView.addSubview(feedLabel)
        editView.addSubview(nameText)
        editView.addSubview(ageButton)
        editView.addSubview(submitButton)
        editView.addSubview(cancelButton)
        editView.addSubview(feedButton)

        buttonEdit.addSubview(editView)
        self.view.addSubview(buttonEdit)
        UIView.animate(withDuration: 0.5, animations: {
            self.buttonEdit.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        })
    }
    func showAgesList() {

        self.myPickerView.frame = CGRect(x: 420, y: 363, width: 100, height: 120)
        pickerView()
        let lblAge = ageButton.titleLabel?.text
        if(lblAge == "") {
            myPickerView.selectRow(0, inComponent: 0, animated: true)
        } else {
            let lblAge = ageButton.titleLabel?.text
            var pickerIndex = Int()
            for i in 0..<AgeOp.count {
                if (lblAge == AgeOp[i] ) {
                    pickerIndex = i
                    break
                }
            }
            myPickerView.selectRow(pickerIndex, inComponent: 0, animated: true)

        }
        myPickerView.reloadInputViews()
    }
    @objc func feedPressed() {
        btnTag = 1
        feedProArrWithId = CoreDataHandler().FetchFeedProgram(postingId).mutableCopy() as! NSMutableArray
        self.tableViewpop()
        droperTableView.frame = CGRect( x: 441, y: 455, width: 250, height: 90)
        droperTableView.reloadData()
    }
    func pickerView () {
        buttonbgNew2.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonbgNew2.addTarget(self, action: #selector(PostingSessionDetailController.buttonPressedAgeList), for: .touchUpInside)
        buttonbgNew2.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view.addSubview(buttonbgNew2)
        myPickerView.layer.borderWidth = 1
        myPickerView.layer.cornerRadius = 5
        myPickerView.layer.borderColor = UIColor.clear.cgColor
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.backgroundColor = UIColor.white
        buttonbgNew2.addSubview(myPickerView)
    }

    // MARK: - Picker View Delegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if let value = AgeOp.count as? Int {
            return value
        } else {
            return 0
        }

        //  return AgeOp.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if let value = AgeOp[row] as? String {
            return value
        } else {
            return nil
        }

        //    return AgeOp[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if let value = AgeOp[row] as? String {

            return ageButton.setTitle("\(value)", for: .normal)

        } else {
            return  ageButton.setTitle("\0)", for: .normal)

        }

        //    age = AgeOp[row]
        // ageButton.setTitle("\(AgeOp[row])", for: .normal)
        myPickerView.endEditing(true)
        buttonbgNew2.removeFromSuperview()
    }
    @objc func updatePressed() {

        var trimmedString = nameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        trimmedString = trimmedString.replacingOccurrences(of: ".", with: "", options:
            NSString.CompareOptions.literal, range: nil)

        if strFeddCheck == "" && strFeddUpdate == "" && trimmedString == "" {

            feedButton.layer.borderColor = UIColor.red.cgColor
            nameText.layer.borderColor = UIColor.red.cgColor
        }
        if strFarmNameFeedId == ""{
            if strFeddUpdate == "" {
                feedButton.layer.borderColor = UIColor.red.cgColor
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
            }
        }
        if strFeddCheck == "" && strFeddUpdate == "" && strFarmNameFeedId == ""{

            if trimmedString == "" {
                nameText.layer.borderColor = UIColor.red.cgColor
            } else {

                nameText.layer.borderColor = UIColor.black.cgColor

            }
            feedButton.layer.borderColor = UIColor.red.cgColor
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
        } else {

            if trimmedString == "" {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Fields marked as (*) are mandatory. Please fill all the fields.", comment: ""))
                nameText.layer.borderColor = UIColor.red.cgColor
                feedButton.layer.borderColor = UIColor.black.cgColor
                // strFeddUpdate = ""
                //strFarmNameFeedId = ""
                //   strFeddCheck = ""
            } else {

                let str = strfarmNameArray[0] as! String
                let strNewFarm = str+". "+trimmedString
                if strFeddUpdate == ""{
                    CoreDataHandler().updateFeddProgramInStep1UsingFarmName(self.postingId, feedname: strFeddCheck, feedId: feedIdUpdate, formName: strfarmName)

                } else if strFarmNameFeedId == ""{
                    CoreDataHandler().updateFeddProgramInStep1UsingFarmName(self.postingId, feedname: strFeddUpdate, feedId: feedIdUpdate, formName: strfarmName)
                } else {

                    CoreDataHandler().updateFeddProgramInStep1UsingFarmName(self.postingId, feedname: strFeddUpdate, feedId: feedIdUpdate, formName: strfarmName)

                }

                CoreDataHandler().updateNecropsystep1WithNecIdAndFarmName(postingId, farmName: oldFarmName as NSString, newFarmName: strNewFarm as NSString, age: (ageButton.titleLabel?.text!)!, isSync: true)

                CoreDataHandler().updateNewFarmAndAgeOnCaptureNecropsyViewData(postingId, oldFarmName: oldFarmName as String, newFarmName: strNewFarm, isSync: true)
                CoreDataHandler().updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdNotes(postingId, oldFarmName: oldFarmName as String, newFarmName: strNewFarm, isSync: true)
                CoreDataHandler().updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdPhoto(postingId, oldFarmName: oldFarmName as String, newFarmName: strNewFarm)
                CoreDataHandler().updateisSyncTrueOnPostingSession(postingId as NSNumber)
                self.feedProtableView.reloadData()
                self.fetcFarmData()
                self.printSyncLblCount()

                self.buttonbgNew2.removeFromSuperview()
                self.buttonEdit.removeFromSuperview()
            }

        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        if (isBackSpace == -92) {

        } else if ((textField.text?.characters.count)! > 50  ) {
            return false
        }

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()

        return true
    }
    @IBAction func datOneSetSync(_ sender: Any) {

        if self.allSessionArrWithPostingId(PId: postingId).count > 0 {
            if WebClass.sharedInstance.connected()  == true {

                let lngId = UserDefaults.standard.integer(forKey: "lngId")
                var strMsg = String()
                if lngId == 5 {
                    strMsg = "Sincronización de datos ..."
                } else if lngId == 1 {
                    strMsg = "Data syncing..."
                } else if lngId == 3 {
                    strMsg = "Synchronisation des données ..."
                }
                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString(strMsg, comment: ""))

                self.callSyncApiPostingId(Pid: postingId)
            } else {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))

            }
        } else {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data not available for syncing.", comment: ""))
        }
    }
    func failWithErrorSyncdata(statusCode: Int) {
        Helper.dismissGlobalHUD(self.view)

        if statusCode == 0 {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("There are problem in data syncing please try again.(NA))", comment: ""))
        } else {

            if lngId == 1 {
                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "There are problem in data syncing please try again. \n(\(statusCode))")

            } else if lngId == 3 {

                Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: "Problème de synchronisation des données, veuillez réessayer à nouveau. \n(\(statusCode))")

            }

        }
    }
    func failWithErrorInternalSyncdata() {
        Helper.dismissGlobalHUD(self.view)

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Server error please try again .", comment: "") )
    }
    func didFinishApiSyncdata() {
        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
        self.printSyncLblCount()
    }
    func failWithInternetConnectionSyncdata() {

        Helper.dismissGlobalHUD(self.view)

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))

    }
    @IBAction func reciveButton(_ sender: Any) {

        let postingSess = CoreDataHandler().checkPostingSessionHasiSyncTrue(self.postingId, isSync: true)
        let necropcySess = CoreDataHandler().checkNecropcySessionHasiSyncTrue(self.postingId, isSync: true)

        if (postingSess == true || necropcySess == true) {
            let alertController = UIAlertController(title: NSLocalizedString("Sync to device", comment: ""), message: NSLocalizedString("By clicking this button, your session data on the web will be downloaded to your device and override any session data captured on your device. Are you sure you want to perform this action?", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                _ in
                self.pullFromWeb()
                return
            }
            let CancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                _ in
                NSLog("Cancel Pressed")
            }
            alertController.addAction(CancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {

            let alertController = UIAlertController(title: NSLocalizedString("Sync to device", comment: ""), message: NSLocalizedString("The most updated information related to this posting session will be downloaded from web to your device. Are you sure you want to perform this action?", comment: ""), preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) {
                _ in
                self.pullFromWeb()
                return
            }
            let CancelAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) {
                _ in
                NSLog("Cancel Pressed")
            }
            alertController.addAction(CancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)

        }
    }
    func pullFromWeb() {
        fullData =  deviceTokenId
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)

        if WebClass.sharedInstance.connected() {
            Helper.dismissGlobalHUD(self.view)

            lngId = UserDefaults.standard.integer(forKey: "lngId")
            if  lngId == 1 {
                Helper.showGlobalProgressHUDWithTitle(self.view, title: "Fetching data from server...")

            } else {
                Helper.showGlobalProgressHUDWithTitle(self.view, title: "Récupération des données du serveur ...")
            }

            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]
            let Url = "PostingSession/GetPostingSessionListBySessionId?DeviceSessionId=\(fullData)"
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                let statusCode =  response.response?.statusCode
                if statusCode == 404 {

                    let alertController = UIAlertController(title: "", message: NSLocalizedString("There is no update available on the server.", comment: ""), preferredStyle: UIAlertController.Style.alert) //Replace
                    let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
                        (_: UIAlertAction) -> Void in
                        Helper.dismissGlobalHUD(self.view)
                    }

                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else if statusCode == 500  || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                    self.alerView(statusCode: statusCode!)
                } else {
                    switch response.result {
                    case .success(let responseObject):

                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            if JSON is NSArray {
                                let arr: NSArray = JSON as! NSArray
                                if arr.count>0 {
                                    for  i in 0..<arr.count {
                                        let posDict = arr.object(at: i)

                                        let deviceId = (posDict as AnyObject).value(forKey: "DeviceSessionId") as! String
                                        CoreDataHandler().getPostingDatWithSpecificId(posDict as! NSDictionary, postinngId: self.postingId)

                                    }

                                    let postingData = CoreDataHandler().fetchAllPostingSession(self.postingId)
                                    print(postingData)
                                    if postingData.count>0 {
                                        self.getPostingDataFromServerforVaccination()
                                    } else {
                                    }
                                } else {
                                }
                            } else {
                                let postingData = CoreDataHandler().fetchAllPostingExistingSession()
                                print(postingData)
                            }
                        }
                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection

                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)

                        }

                    }
                }

                response.result.error

            }

        }
    }
    func getPostingDataFromServerforVaccination() {

        if WebClass.sharedInstance.connected() {
            let id =  UserDefaults.standard.value(forKey: "Id") as! Int
            let url = "PostingSession/GetVaccinationListBySessionId?DeviceSessionId=\(fullData)"
            let urlString: String = WebClass.sharedInstance.webUrl + url

            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!

            let headerDict = ["Authorization": accestoken]

            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {
                    let statusCode =  response.response?.statusCode

                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode!)

                    } else {
                        switch response.result {
                        case .success(let responseObject):

                            if let JSON = response.result.value {
                                if json is NSArray {
                                    let arr: NSArray = json as! NSArray
                                    print(arr)

                                    if arr.count>0 {
                                        CoreDataHandler().deleteDataWithPostingIdHatchery(self.postingId)
                                        CoreDataHandler().deleteDataWithPostingIdFieldVacinationWithSingle(self.postingId)

                                        for  i in 0..<arr.count {

                                            let vac = (arr.object(at: i) as AnyObject).value(forKey: "Vaccination") as! NSArray
                                            if vac.count > 0 {
                                                let posDict = (vac as AnyObject).object(at: 0)
                                                CoreDataHandler().getHatcheryDataFromServerSingleFromDeviceId(posDict as! NSDictionary, postingId: self.postingId)

                                                CoreDataHandler().getFieldDataFromServerSingledata(posDict as! NSDictionary, postingId: self.postingId)

                                            }

                                        }
                                        self.getPostingDataFromServerforFeed()

                                    } else {
                                    }
                                } else {
                                    let errorMsg = ((json as AnyObject).value(forKey: "error") as AnyObject).value(forKey: "errorMsg") as! String
                                    print(errorMsg)

                                }
                            }
                        case .failure(let encodingError):
                            if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                                // no internet connection

                            } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                                // other failures
                                print(encodingError)
                                print(responseString)

                            }
                        }
                    }
                }
            }

        } else {

        }

    }
    func getPostingDataFromServerforFeed () {

        if WebClass.sharedInstance.connected() {

            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]

            let url = "PostingSession/GetFeedListBySessionId?DeviceSessionId=\(fullData)"
            let urlString: String = WebClass.sharedInstance.webUrl + url

            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {

                    let statusCode =  response.response?.statusCode
                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {

                    }
                    switch response.result {
                    case .success(let responseObject):
                        if let JSON = response.result.value {
                            if json is NSArray {
                                let arr: NSArray = json as! NSArray
                                print(arr)
                                if arr.count>0 {
                                    CoreDataHandler().deleteDataWithPostingIdFeddProgram(self.postingId)
                                    CoreDataHandler().deleteDataWithPostingIdFeddProgramCocoiiSinle(self.postingId)
                                    CoreDataHandler().deleteDataWithPostingIdFeddProgramAlternativeSinle(self.postingId)
                                    CoreDataHandler().deleteDataWithPostingIdFeddProgramAntiboiticSingle(self.postingId)
                                    CoreDataHandler().deleteDataWithPostingIdFeddProgramMyCotoxinSingle(self.postingId)

                                    for  t in 0..<arr.count {

                                        let posDict = arr.object(at: t)
                                        let seesionId = (posDict as AnyObject).value(forKey: "sessionId") as! Int
                                        let feedDictArr = (posDict as AnyObject).value(forKey: "Feeds")

                                        for  i in 0..<(feedDictArr! as AnyObject).count {
                                            var feedId = ((feedDictArr as AnyObject).object(at: i) as AnyObject).value(forKey: "feedId") as! Int
                                            //feedId = feedId-1
                                            let nsFeedid = UserDefaults.standard.integer(forKey: "feedId")
                                            if feedId > nsFeedid {
                                                UserDefaults.standard.set(feedId, forKey: "feedId")
                                            }
                                            let feedName = ((feedDictArr as AnyObject).object(at: i) as AnyObject).value(forKey: "feedName")
                                            CoreDataHandler().getFeedNameFromGetApiSingleDeviceToken((seesionId) as NSNumber, sessionId: seesionId as NSNumber, feedProgrameName: feedName as! String, feedId: feedId as NSNumber, postingIdFeed: self.postingId)

                                            let feedDetailArr = ((feedDictArr! as AnyObject).object(at: i) as AnyObject).value(forKey: "feedCategoryDetails")

                                            print((feedDetailArr as AnyObject).count)
                                            for  j in 0..<(feedDetailArr! as AnyObject).count {
                                                let feedCatName = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedProgramCategory") as! String

                                                if feedCatName == "Coccidiosis Control"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  m in 0..<(feedDetail! as AnyObject).count {
                                                        let postDict = (feedDetail as AnyObject).object(at: m)
                                                        CoreDataHandler().getDataFromCocoiiControllForSingleData(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName: feedName as! String, postingIdCocoii: self.postingId)

                                                    }
                                                } else if feedCatName  == "Alternatives"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  p in 0..<(feedDetail! as AnyObject).count {
                                                        let postDict = (feedDetail as AnyObject).object(at: p)

                                                        CoreDataHandler().getDataFromAlterNativeForSingleDevToken(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName: feedName as! String, postingAlterNative: self.postingId)

                                                    }
                                                } else if  feedCatName == "Antibiotic"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  a in 0..<(feedDetail! as AnyObject).count {
                                                        let postDict = (feedDetail as AnyObject).object(at: a)

                                                        CoreDataHandler().getDataFromAntiboiticWithSigleData(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName: feedName as! String, postingIdAlterNative: self.postingId)

                                                    }
                                                } else if  feedCatName  == "Mycotoxin Binders"{
                                                    let feedDetail = ((feedDetailArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedDetails")
                                                    for  y in 0..<(feedDetail! as AnyObject).count {
                                                        let postDict = (feedDetail as AnyObject).object(at: y)

                                                        CoreDataHandler().getDataFromMyCocotinBinderWithSingleData(postDict as! NSDictionary, feedId: feedId as NSNumber, postingId: seesionId as NSNumber, feedProgramName: feedName as! String, postingidMycotxin: self.postingId)

                                                    }

                                                }
                                            }
                                        }
                                    }

                                    self.getCNecStep1Data()
                                } else {
                                    // self.getCNecStep1Data()
                                }
                            } else {

                            }
                        }
                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection

                            //self.alerViewInternet()
                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)
                            //self.alerViewInternet()

                        }

                    }
                }

                response.result.error

            }

        } else {

        }

    }

    func getCNecStep1Data() {
        if WebClass.sharedInstance.connected() {
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]

            let url = "PostingSession/GetFarmListBySessionId?DeviceSessionId=\(fullData)"
            let urlString: String = WebClass.sharedInstance.webUrl + url

            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {
                    let statusCode =  response.response?.statusCode

                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode!)

                    }

                    switch response.result {
                    case .success(let responseObject):
                        if let JSON = response.result.value {
                            print("JSON: \(json)")
                            if json is NSArray {
                                let arr: NSArray = json as! NSArray
                                print(arr)
                                if arr.count>0 {
                                    CoreDataHandler().deleteDataWithPostingIdCaptureStepData(self.postingId)
                                    for  i in 0..<arr.count {
                                        var posttingId =  Int()
                                        let sessionId = (arr.object(at: i) as AnyObject).value(forKey: "SessionId") as! Int
                                        let devSessionId = (arr.object(at: i) as AnyObject).value(forKey: "deviceSessionId") as! String
                                        let lngId  = (arr.object(at: i) as AnyObject).value(forKey: "LanguageId") as! NSNumber
                                        let custId = (arr.object(at: i) as AnyObject).value(forKey: "CustomerId") as! Int
                                        let complexId = (arr.object(at: i) as AnyObject).value(forKey: "ComplexId") as! Int
                                        let complexName = (arr.object(at: i) as AnyObject).value(forKey: "ComplexName") as! String
                                        let sessionDate = (arr.object(at: i) as AnyObject).value(forKey: "SessionDate") as! String

                                        let seesDat = self.convertDateFormater(sessionDate)
                                        let farmArr = (arr.object(at: i) as AnyObject).value(forKey: "Farms")
                                        if (farmArr as AnyObject).count>0 {
                                            for  j in 0..<(farmArr! as AnyObject).count {
                                                let farmName =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "farmName") as! String
                                                let  postingArr  =  CoreDataHandler().fetchAllPostingSession(sessionId as NSNumber)
                                                if postingArr.count>0 {
                                                    posttingId = (postingArr.object(at: 0) as AnyObject).value(forKey: "postingId") as! Int
                                                    if posttingId == sessionId {
                                                        CoreDataHandler().updateFinalizeDataWithNec(self.postingId, finalizeNec: 1)
                                                        posttingId = sessionId
                                                    }

                                                } else {
                                                    posttingId = 0
                                                }
                                                let age =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "age")
                                                let birds =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "birds")
                                                let houseNo =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "houseNo")
                                                let flockId =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "flockId")
                                                let feedProgram =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "feedProgram") as! String
                                                let sick =  ((farmArr as AnyObject).object(at: j) as AnyObject).value(forKey: "sick") as! Bool
                                                let feedId = ((farmArr! as AnyObject).object(at: j) as AnyObject).value(forKey: "FeedId") as! Int
                                                let farmId = ((farmArr! as AnyObject).object(at: j) as AnyObject).value(forKey: "DeviceFarmId") as! Int
                                                let imgId = ((farmArr! as AnyObject).object(at: j) as AnyObject).value(forKey: "ImgId") as! Int
                                                // feedId = feedId-1
                                                CoreDataHandler().SaveNecropsystep1SingleData(posttingId as NSNumber, age: ((age as AnyObject).stringValue)!, farmName: farmName, feedProgram: feedProgram, flockId: ((flockId as AnyObject).stringValue)!, houseNo: ((houseNo as AnyObject).stringValue)!, noOfBirds: ((birds as AnyObject).stringValue)!, sick: sick as NSNumber, necId: sessionId as NSNumber, compexName: complexName, complexDate: seesDat, complexId: complexId as NSNumber, custmerId: custId as NSNumber, feedId: feedId as NSNumber, isSync: false, timeStamp: devSessionId, actualTimeStamp: devSessionId, necIdSingle: self.postingId, farmId: farmId as NSNumber, imgId: imgId as NSNumber)
                                                UserDefaults.standard.set(farmId as NSNumber, forKey: "farmId")
                                            }
                                        }
                                    }
                                    let necArr = CoreDataHandler().FetchNecropsystep1AllNecId()
                                    if necArr.count>0 {
                                        self.getPostingDataFromServerforNecorpsy()
                                    }
                                } else {
                                }
                            } else {

                                let errorMsg = ((json as AnyObject).value(forKey: "error") as AnyObject).value(forKey: "errorMsg") as! String
                                print(errorMsg)

                            }
                        }
                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection

                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)

                        }
                    }
                }
                response.result.error

            }

        } else {

        }
    }

    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    func getPostingDataFromServerforNecorpsy() {

        //self.deleteAllData("CaptureNecropsyViewData")
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if WebClass.sharedInstance.connected() {

            var id = Int()
            id =  UserDefaults.standard.value(forKey: "Id") as! Int
            let  lngId = UserDefaults.standard.integer(forKey: "lngId")
            let countryId = UserDefaults.standard.integer(forKey: "countryId")
            let url = "PostingSession/GetNecropsyListBySessionId?UserId=\(id)&DeviceSessionId=\(fullData)&LanguageId=\(lngId)&CountryId=\(countryId)"
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + url
            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {
                    let statusCode =  response.response?.statusCode

                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode!)

                    }
                    switch response.result {
                    case .success(_):
                        if response.result.value != nil {

                            print("JSON: \(json)")
                            if json is NSArray {
                                let arr: NSArray = json as! NSArray
                                if arr.count>0 {
                                    CoreDataHandler().deleteDataWithStep2data(self.postingId)
                                    for  i in 0..<arr.count {
                                        let seesionId = (arr.object(at: i) as AnyObject).value(forKey: "SessionId") as! Int
                                        let farmArr = (arr.object(at: i) as AnyObject).value( forKey: "Farms")
                                        for  j in 0..<(farmArr! as AnyObject).count {
                                            let farmName = ((farmArr! as AnyObject).object(at: j) as AnyObject).value( forKey: "FarmName") as! String
                                            let catArr = ((farmArr! as AnyObject).object(at: j) as AnyObject).value(forKey: "Category")
                                            for  k in 0..<(catArr! as AnyObject).count {
                                                let catName = ((catArr! as AnyObject).object(at: k) as AnyObject).value(forKey: "Category") as! String
                                                let ObArr = ((catArr! as AnyObject).object(at: k) as AnyObject).value(forKey: "Observations")
                                                for  l in 0..<(ObArr! as AnyObject).count {
                                                    let obsId  = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "ObservationId") as! Int
                                                    let refId = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "ReferenceId") as! NSNumber
                                                    let languageId = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "LanguageId") as! NSNumber
                                                    let obsName = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Observations") as! String
                                                    let measure = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Measure") as! String
                                                    let quickLink = ((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "DefaultQLink")

                                                    let birdArr = (((ObArr! as AnyObject).object(at: l) as AnyObject).value(forKey: "Birds") as AnyObject).object(at: 0)
                                                    for  m in 0..<10 {

                                                        let keyStr = NSString(format: "BirdNumber%d", m+1)
                                                        let chkKey = ((birdArr as AnyObject).value(forKey: keyStr as String) as AnyObject).boolValue
                                                        let chkKey1 = ((birdArr as AnyObject).value(forKey: keyStr as String) as AnyObject).integerValue
                                                        let chkKey3 = (birdArr as AnyObject).value(forKey: keyStr as String) as! String
                                                        if chkKey3 == "NA"{
                                                            break
                                                        } else {

                                                            var catstr = String()

                                                            if catName == "Coccidiosis"{
                                                                catstr = "Coccidiosis"
                                                            } else if catName == "GI Tract" {
                                                                catstr = "GITract"
                                                            } else if catName == "Immune/Others" {
                                                                catstr = "Immune"
                                                            } else if catName == "Respiratory" {
                                                                catstr = "Resp"
                                                            } else if catName == "Skeletal/Muscular/Integumentary" {
                                                                catstr = "skeltaMuscular"
                                                            }
                                                            CoreDataHandler().saveCaptureSkeletaInDatabaseOnSwithCaseSingleData(catName: catstr, obsName: obsName, formName: farmName, obsVisibility: chkKey!, birdNo: (m+1) as NSNumber, obsPoint: chkKey1!, index: m, obsId: obsId, measure: measure, quickLink: (quickLink! as AnyObject).integerValue! as NSNumber, necId: seesionId as NSNumber, isSync: false, necIdSingle: self.postingId, lngId: languageId, refId: refId)
                                                        }
                                                    }

                                                }

                                            }
                                        }

                                    }

                                    self.getNotesFromServer()
                                } else {
                                    //self.getNotesFromServer()
                                }
                            } else {
                                //self.getNotesFromServer()
                                let errorMsg = ((json as AnyObject).value(forKey: "error") as AnyObject).value(forKey: "errorMsg") as! String
                                // print (errorMsg)

                            }
                        }
                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection

                            //self.alerViewInternet()
                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)
                            // self.alerViewInternet()

                        }

                    }
                }

                response.result.error

                //self.alerViewInternet()

            }

        } else {

        }

    }
    func getNotesFromServer() {
        // self.deleteAllData("NotesBird")
        if WebClass.sharedInstance.connected() {
            // var id = Int()
            // id =  UserDefaults.standard.value(forKey: "Id") as! Int
            let url = "PostingSession/GetBirdNotesListBySessionId?DeviceSessionId=\(fullData)"
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + url

            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {

                    print("JSON: \(json)")
                    let statusCode =  response.response?.statusCode

                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode!)

                    }
                    switch response.result {
                    case .success(let responseObject):

                        if let JSON = response.result.value {
                            if json is NSArray {

                                let arr: NSArray = json as! NSArray
                                if arr.count>0 {
                                    CoreDataHandler().deleteDataBirdNotesWithId(self.postingId)
                                    print(arr)

                                    for  i in 0..<arr.count {

                                        let noteArr = (arr.object(at: i) as AnyObject).value(forKey: "Note")

                                        if (noteArr as AnyObject).count>0 {
                                            for  j in 0..<(noteArr! as AnyObject).count {
                                                let sessionId =  ((noteArr as AnyObject).object(at: j) as AnyObject).value(forKey: "sessionId") as! Int
                                                let farmName =  ((noteArr as AnyObject).object(at: j) as AnyObject).value(forKey: "farmName") as! String
                                                let birdNo =  ((noteArr as AnyObject).object(at: j) as AnyObject).value(forKey: "birdNumber") as! Int
                                                let birdNotes = ((noteArr as AnyObject).object(at: j) as AnyObject).value(forKey: "Notes")
                                                    as! String

                                                CoreDataHandler().saveNoofBirdWithNotesSingledata("", notes: birdNotes, formName: farmName, birdNo: birdNo as NSNumber, index: 0, necId: sessionId as NSNumber, isSync: false, necIdSingle: self.postingId)
                                            }
                                        }

                                    }
                                    self.getPostingDataFromServerforImage()

                                } else {
                                    self.getPostingDataFromServerforImage()
                                }
                            } else {
                                self.getPostingDataFromServerforImage()
                                let errorMsg = ((json as AnyObject).value(forKey: "error") as AnyObject).value(forKey: "errorMsg") as! String
                                print(errorMsg)

                            }
                        }

                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            // no internet connection

                            //  self.alerViewInternet()
                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)
                            //self.alerViewInternet()

                        }

                    }
                }

                response.result.error

            }

        } else {

        }
    }

    func getPostingDataFromServerforImage() {

        if WebClass.sharedInstance.connected() {
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization": accestoken]
            let url = "PostingSession/GetBirdImagesListBySessionId?DeviceSessionId=\(fullData)"
            let urlString: String = WebClass.sharedInstance.webUrl + url
            Alamofire.request(urlString, method: .get, headers: headerDict).responseJSON { response in
                if let json = response.result.value {
                    let statusCode =  response.response?.statusCode
                    if statusCode == 500 || statusCode == 401 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408 {
                        self.alerView(statusCode: statusCode!)

                    }
                    switch response.result {
                    case .success(let responseObject):
                        if let JSON = response.result.value {
                            if json is NSArray {

                                let arr: NSArray = json as! NSArray
                                if arr.count>0 {
                                    CoreDataHandler().deleteImageForSingle(self.postingId)

                                    print(arr.count)

                                    for  i in 0..<arr.count {
                                        let imagArr = (arr.object(at: i) as AnyObject).value(forKey: "Images")
                                        if  (imagArr as AnyObject).count>0 {
                                            for  i in 0..<(imagArr! as AnyObject).count {
                                                let posDict = (imagArr! as AnyObject).object(at: i)
                                                CoreDataHandler().getSaveImageFromServerSingledata(posDict as! NSDictionary, necIdSingle: self.postingId)
                                            }

                                        }
                                    }
                                    //  Helper.dismissGlobalHUD(self.view)
                                    self.postSesionSyncTodev(sessionId: self.fullData)
                                    // self.alerViewSucees()
                                }

                            } else {

                                //  Helper.dismissGlobalHUD(self.view)
                                self.postSesionSyncTodev(sessionId: self.fullData)

                                // self.alerViewSucees()
                                let errorMsg = ((json as AnyObject).value(forKey: "error") as AnyObject).value(forKey: "errorMsg") as! String
                                print(errorMsg)

                            }
                        }
                    case .failure(let encodingError):

                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {

                            print(err)
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            // other failures
                            print(encodingError)
                            print(responseString)

                        }
                    }
                }

                response.result.error
            }

        } else {

        }
    }
    func postSesionSyncTodev(sessionId: String) {

        if WebClass.sharedInstance.connected() {

            let Id = UserDefaults.standard.integer(forKey: "Id")
            let Url = "PostingSession/SyncToDevice"
            let parameters  = ["UserId": Id, "SessionId": sessionId] as [String: Any]
            print(parameters)
            accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!

            let headerDict = ["Authorization": accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + Url

            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)

            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String

            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)

            print(jsonString)
            Alamofire.request(urlString, method: .post, parameters: parameters, headers: headerDict).responseJSON { response in

                if let JSON = response.result.value {
                    print(JSON)
                    Helper.dismissGlobalHUD(self.view)
                    self.alerViewSucees()
                    //("JSON: \(JSON)")
                }
            }
        }
    }

    func alerView(statusCode: Int) {
        let alertController = UIAlertController(title: "", message: NSLocalizedString("Unable to get data from server.\n(\(statusCode))", comment: ""), preferredStyle: UIAlertController.Style.alert) //Replace
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            Helper.dismissGlobalHUD(self.view)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func alerViewInternet() {
        let alertController = UIAlertController(title: "", message: NSLocalizedString("No internet connection. Please try again!", comment: ""), preferredStyle: UIAlertController.Style.alert) //Replace
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            Helper.dismissGlobalHUD(self.view)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func alerViewSucees() {
        let alertController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Data sync has been completed.", comment: ""), preferredStyle: UIAlertController.Style.alert) //Replace
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default) {
            (_: UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }

        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func update() {
        // Something cool
        if WebClass.sharedInstance.connected() {
        } else {
            Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
        }
    }
}
