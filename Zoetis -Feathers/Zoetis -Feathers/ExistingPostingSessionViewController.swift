//
//  ExistingPostingSessionViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 04/11/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit
import ReachabilitySwift
import SystemConfiguration

class ExistingPostingSessionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, userLogOut, UITextFieldDelegate, startNecropsyP, syncApi {

    var lngId = NSInteger()

    var fromDate = Date()
    var toDate   = Date()
    var fromString = String()
    var toString = String()
    var dateFormatter = DateFormatter()
    let objApiSync = ApiSync()

    @IBOutlet weak var syncNotiCount: UILabel!
    var customPopView1: UserListView!
    let buttonbg1 = UIButton()
    let buttonbg = UIButton()
    var buttonback = UIButton()
    var customPopV: startNecropsyXib!
    var finializeB = NSNumber()
    @IBOutlet weak var userNameLabel: UILabel!
    let buttonDroper = UIButton()

    var existingArray = NSMutableArray()
    let textCellIdentifier = "cell"
    var buttonBg = UIButton()
    var datePicker: UIDatePicker!
    var fetchcustRep = NSArray()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fromLblDate: UILabel!
    @IBOutlet weak var toLblDate: UILabel!
    @IBOutlet weak var fromLblDateFrench: UILabel!
    @IBOutlet weak var toLblDateFrench: UILabel!
    @IBOutlet weak var lblLng: UILabel!
    @IBOutlet weak var searchWidComplexName: UITextField!
    var complexTypeFetchArray = NSMutableArray()
    var autoSerchTable = UITableView()
    var autocompleteUrls = NSMutableArray()
    var fetchcomplexArray = NSArray()
    let cellReuseIdentifier = "cell"
    var imageChange = String()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @objc func methodOfReceivedNotification(notification: Notification) {
        //Take Action on Notification
        UserDefaults.standard.set(0, forKey: "postingId")
        UserDefaults.standard.set(false, forKey: "ispostingIdIncrease")
        appDelegate.sendFeedVariable = ""
        let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "PostingViewController") as? PostingViewController
        self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(ExistingPostingSessionViewController.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

        searchWidComplexName.layer.borderWidth = 1
        searchWidComplexName.layer.cornerRadius = 3.5
        searchWidComplexName.layer.borderColor = UIColor.black.cgColor

        objApiSync.delegeteSyncApi = self
        let lngid = UserDefaults.standard.integer(forKey: "lngId")
        if lngid == 3 {
            fromLblDate.alpha = 0
            toLblDate.alpha = 0
            var dateFormatter = DateFormatter()
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            // fromString = dateFormatter.string(from: Date())
            //toString = dateFormatter.string(from: Date())
            fromLblDateFrench.text = dateFormatter.string(from: Date())
            toLblDateFrench.text = dateFormatter.string(from: Date())
        } else {
            fromLblDateFrench.alpha = 0
            toLblDateFrench.alpha = 0
            fromLblDate.alpha = 1
            toLblDate.alpha = 1
        }

        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        fromString = dateFormatter.string(from: Date())
        toString = dateFormatter.string(from: Date())
        fromLblDate.text = fromString
        toLblDate.text = toString

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        lngId = UserDefaults.standard.integer(forKey: "lngId")

        self.printSyncLblCount()
        searchWidComplexName.delegate = self
        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String
        tableView.tableFooterView = UIView()
        existingArray = CoreDataHandler().fetchAllPostingExistingSessionwithFullSessionWithCapId(1).mutableCopy() as! NSMutableArray

        for i in 0..<existingArray.count {
            let postingSession: PostingSession = existingArray.object(at: i) as! PostingSession
            let pid = postingSession.postingId
            let farms = CoreDataHandler().fetchNecropsystep1neccIdFeedProgram(pid!)

            if farms.count > 0 {
                CoreDataHandler().updatedPostigSessionwithIsFarmSyncPostingId(pid!, isFarmSync: true)

            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        complexTypeFetchArray = CoreDataHandler().fetchCompexType().mutableCopy() as! NSMutableArray
        if  let data: NSArray = CoreDataHandler().fetchCompexType() {
            fetchcustRep = data
        }

        buttonDroper.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonDroper.addTarget(self, action: #selector(ExistingPostingSessionViewController.buttonPressedDroper), for: .touchUpInside)
        buttonDroper.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonDroper)
        autoSerchTable.delegate = self
        autoSerchTable.dataSource = self
        autoSerchTable.delegate = self
        autoSerchTable.layer.cornerRadius = 7
        autoSerchTable.layer.borderWidth = 1
        autoSerchTable.layer.borderColor = UIColor.lightGray.cgColor
        self.autoSerchTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        buttonDroper .addSubview(autoSerchTable)
        buttonDroper.alpha = 0
    }

    @objc func buttonPressedDroper() {

        buttonDroper.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sliderButtonAction(_ sender: AnyObject) {

        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }

    @IBAction func fromDateAction(_ sender: AnyObject) {

        view.endEditing(true)
        let buttons  = DatepickerClass.sharedInstance.pickUpDate()
        buttonBg  = buttons.0
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonBg.addTarget(self, action: #selector(ExistingPostingSessionViewController.buttonPressed), for: .touchUpInside)
        let donebutton: UIBarButtonItem = buttons.1
        donebutton.action =  #selector(ExistingPostingSessionViewController.doneClick)
        let cancelbutton: UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(ExistingPostingSessionViewController.cancelClick)
        datePicker = buttons.4
        self.view.addSubview(buttonBg)

    }

    @objc func buttonPressed() {

        buttonBg.removeFromSuperview()
    }
    @objc func doneClick() {

        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 3 {
            fromLblDate.alpha = 0
             fromLblDateFrench.alpha = 1
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strdate = dateFormatter.string(from: datePicker.date) as String
            fromLblDateFrench.text = strdate
        } else {
            fromLblDate.alpha = 1
            fromLblDateFrench.alpha = 0
        }

        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        fromString = dateFormatter.string(from: datePicker.date)
        fromDate = datePicker.date

        if fromString == toString {

            if lngId == 3 {
                fromLblDate.alpha = 0
                 fromLblDateFrench.alpha = 1
                dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let strdate = dateFormatter.string(from: datePicker.date) as String
                fromLblDateFrench.text = strdate
            } else {
                fromLblDate.alpha = 1
                fromLblDateFrench.alpha = 0

            }

            let strdate = dateFormatter.string(from: datePicker.date) as String
            fromLblDate.text = strdate
            UserDefaults.standard.set( fromLblDate.text, forKey: "date")

            buttonBg.removeFromSuperview()
            tableView.reloadData()
        } else if fromDate.isLessThanDate(toDate) {

            if lngId == 3 {
                fromLblDate.alpha = 0
                fromLblDateFrench.alpha = 1
                dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let strdate = dateFormatter.string(from: datePicker.date) as String
                fromLblDateFrench.text = strdate
            } else {
                fromLblDate.alpha = 1
                fromLblDateFrench.alpha = 0

            }
            let strdate = dateFormatter.string(from: datePicker.date) as String
            fromLblDate.text = strdate
            UserDefaults.standard.set( fromLblDate.text, forKey: "date")

            buttonBg.removeFromSuperview()
            tableView.reloadData()

        } else {
            self.cancelClick()

            fromString = fromLblDate.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            fromDate = dateFormatter.date(from: fromString)!

            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("From date must be smaller than to date.", comment: ""))
        }
    }

    @objc func cancelClick() {

        buttonBg.removeFromSuperview()
    }

    @IBAction func toDateAction(_ sender: AnyObject) {

        view.endEditing(true)

        let buttons  = DatepickerClass.sharedInstance.pickUpDate()
        buttonBg  = buttons.0
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonBg.addTarget(self, action: #selector(ExistingPostingSessionViewController.buttonPressed), for: .touchUpInside)
        let donebutton: UIBarButtonItem = buttons.1
        donebutton.action =  #selector(ExistingPostingSessionViewController.todoneClick)
        let cancelbutton: UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(ExistingPostingSessionViewController.cancelClick)
        datePicker = buttons.4
        self.view.addSubview(buttonBg)

    }
    @objc func todoneClick() {

        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        if lngId == 3 {
            toLblDate.alpha = 0
            toLblDateFrench.alpha = 1
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let strdate = dateFormatter.string(from: datePicker.date) as String
            toLblDateFrench.text = strdate
        } else {
            toLblDate.alpha = 1
            toLblDateFrench.alpha = 0
        }

        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MM/dd/yyyy"
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "MM/dd/yyyy"
        toString = dateFormatter1.string(from: datePicker.date)
        toDate = datePicker.date

        if fromString == toString {

            if lngId == 3 {
                toLblDate.alpha = 0
                dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let strdate = dateFormatter.string(from: datePicker.date) as String
                toLblDateFrench.text = strdate
            } else {
                toLblDate.alpha = 1
                toLblDateFrench.alpha = 0

            }

            let strdate = dateFormatter2.string(from: datePicker.date) as String
            toLblDate.text = strdate
            UserDefaults.standard.set( toLblDate.text, forKey: "date")
            buttonBg.removeFromSuperview()
            tableView.reloadData()

        } else if toDate.isGreaterThanDate(fromDate) {

            if lngId == 3 {
                toLblDate.alpha = 0
                dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let strdate = dateFormatter.string(from: datePicker.date) as String
                toLblDateFrench.text = strdate
            } else {
                toLblDate.alpha = 1
                toLblDateFrench.alpha = 0

            }

            let strdate = dateFormatter2.string(from: datePicker.date) as String
            toLblDate.text = strdate
            UserDefaults.standard.set( toLblDate.text, forKey: "date")
            buttonBg.removeFromSuperview()
            tableView.reloadData()
        } else {
            self.cancelClick()

            fromString = toLblDate.text!

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            toDate = dateFormatter.date(from: fromString)!
            Helper.showAlertMessage((UIApplication.shared.keyWindow?.rootViewController)!, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("To date must be greater than from date.", comment: ""))
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == autoSerchTable {
            return autocompleteUrls.count
        } else {

            return existingArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == autoSerchTable {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!
            let cuatomerep: ComplexPosting = autocompleteUrls.object(at: indexPath.row) as! ComplexPosting

            cell.textLabel?.text = cuatomerep.complexName
            cell.textLabel?.font = searchWidComplexName.font
            return cell

        } else {

            let cell: ExistingPostingTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ExistingPostingTableViewCell

            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
            } else {
                cell.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)

            }

            let posting: PostingSession = existingArray.object(at: indexPath.row) as! PostingSession

            let isfarmSync = posting.isfarmSync
            cell.infoButton.alpha = isfarmSync == 1 ? 1 : 0

            let lngIdFr = UserDefaults.standard.integer(forKey: "lngId")
            if lngIdFr == 3 {
                let dateString = posting.sessiondate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                let dateObj = dateFormatter.date(from: dateString!)
                dateFormatter.dateFormat = "dd/MM/yyyy"
                cell.datelabel.text = dateFormatter.string(from: dateObj!)
            } else {
              cell.datelabel.text  = posting.sessiondate
            }

            cell.sessionTypeLabel.text  = posting.sessionTypeName
            cell.complexLabel.text  = posting.complexName
            cell.veterinartionLabel.text  = posting.vetanatrionName
            let lngId =  posting.lngId
            if lngId == 1 {
                cell.lblLng.text = "(En)"
            } else if lngId == 3 {
                cell.lblLng.text = "(Fr)"
            } else {
                cell.lblLng.text = "(Es)"
            }
            cell.infoButton.addTarget(self, action: #selector(ExistingPostingSessionViewController.infoButton), for: .touchUpInside)

            finializeB = posting.finalizeExit!

            if finializeB == 1 {
                cell.eyeIamgeView.image = UIImage(named: "eye_blue")!
            } else if finializeB == 0 {
                cell.eyeIamgeView.image =  UIImage(named: "eye_orange")!
            }
            return cell
        }
    }

    @objc func infoButton() {
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please connect farm(s) with feed program.", comment: ""))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView == autoSerchTable {
            let cuatomerep: ComplexPosting = autocompleteUrls.object(at: indexPath.row) as! ComplexPosting

            searchWidComplexName.text = cuatomerep.complexName

            UserDefaults.standard.set(  searchWidComplexName.text, forKey: "complex")
            autoSerchTable.alpha = 0
            searchWidComplexName.endEditing(true)
            buttonDroper.alpha = 0
        } else {

            let posting: PostingSession = existingArray.object(at: indexPath.row) as! PostingSession

            let lngId = UserDefaults.standard.integer(forKey: "lngId") as NSNumber
            if lngId == posting.lngId {

                let postingSessionDetails = self.storyboard?.instantiateViewController(withIdentifier: "PostingSession") as? PostingSessionDetailController
                postingSessionDetails?.postingId = posting.postingId!
                postingSessionDetails?.editFinalizeValue = editFinalizeValue as NSNumber
                postingSessionDetails?.finilizeValue = posting.finalizeExit!
                self.navigationController?.pushViewController(postingSessionDetails!, animated: true)
            } else {
                var lanStr  = String()
                let lngId = UserDefaults.standard.integer(forKey: "lngId") as NSNumber
                if lngId == 1 {
                    lanStr = "English"
                     Helper.showAlertMessage(self, titleStr: NSLocalizedString(NSLocalizedString("Alert", comment: ""), comment: ""), messageStr: NSLocalizedString("This session has been created in french language. Please logout and select french as a language to edit / view this session.", comment: ""))

                } else  if lngId == 3 {
                    lanStr = "French"
                    Helper.showAlertMessage(self, titleStr: NSLocalizedString(NSLocalizedString("Alert", comment: ""), comment: ""), messageStr: NSLocalizedString("Cette session a été créée en langue anglaise. Veuillez vous déconnecter et sélectionnez l'anglais en tant que langue pour éditer / voir cette session.", comment: ""))

                } else {
                    lanStr = "Spanish"
                }

             //   Helper.showAlertMessage(self,titleStr:NSLocalizedString(NSLocalizedString("Warning", comment: ""), comment: "") , messageStr:NSLocalizedString("This session has been created in \(lanStr) language. Please logout and select \(lanStr) as a language to edit /proceed this session.", comment: ""))
            }
        }
    }
    let editFinalizeValue = 2

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()

        return view
    }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if (textField.tag == 101) {
            let bPredicate: NSPredicate = NSPredicate(format: "complexName contains[cd] %@", newString)
            fetchcomplexArray = CoreDataHandler().fetchCompexType().filtered(using: bPredicate) as NSArray
            autocompleteUrls = fetchcomplexArray.mutableCopy() as! NSMutableArray
            autoSerchTable.frame = CGRect(x: 675, y: 120, width: 250, height: 200)

            buttonDroper.alpha = 1
            autoSerchTable.alpha = 1

            if autocompleteUrls.count == 0 {
                buttonDroper.alpha = 0
                autoSerchTable.alpha = 0
            } else {
                autoSerchTable.reloadData()
            }
        }
        return true
    }

    @IBAction func serchButtonAction(_ sender: AnyObject) {
        let newString = searchWidComplexName.text
        if newString!.isEmpty == true {
            fetchcustRep = CoreDataHandler().fetchAllPostingExistingSessionwithFullSessionSessionDate(1, birdTypeId: 1, todate: fromLblDate.text!, lasatdate: toLblDate.text!) as NSArray
            existingArray = fetchcustRep.mutableCopy() as! NSMutableArray

            if existingArray.count == 0 {
                self.Alert()
            }
            tableView.reloadData()
        } else {

            let bPredicate: NSPredicate = NSPredicate(format: "(sessiondate >= %@) AND (sessiondate <= %@) AND complexName contains[c] %@", fromLblDate.text!, toLblDate.text!, newString!)

            fetchcustRep = CoreDataHandler().fetchAllPostingExistingSessionwithFullSessionWithCapId(1).filtered(using: bPredicate) as NSArray

            existingArray = fetchcustRep.mutableCopy() as! NSMutableArray

            if existingArray.count == 0 {
                self.Alert()
            }
            tableView.reloadData()
        }

    }

    func Alert() {

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No sessions found.", comment: ""))
    }
    func CallPopoupStartNec() {
        buttonback = UIButton(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        buttonback.backgroundColor = UIColor.black
        buttonback.alpha = 0.6
        buttonback.setTitle("", for: UIControl.State())
        buttonback.addTarget(self, action: #selector(buttonAcn), for: .touchUpInside)
        self.view.addSubview(buttonback)

        customPopV = startNecropsyXib.loadFromNibNamed("startNecropsyXib") as! startNecropsyXib
        customPopV.necropsyDelegate = self
        customPopV.center = self.view.center
        self.view.addSubview(customPopV)

    }

    @objc func buttonAcn(_ sender: UIButton!) {
        customPopV.removeFromSuperview()
        buttonback.removeFromSuperview()

    }

    func startNecropsyBtnFunc () {

        let navigateToAnother = self.storyboard?.instantiateViewController(withIdentifier: "Step1") as? captureNecropsyStep1Data
        self.navigationController?.pushViewController(navigateToAnother!, animated: false)

    }
    func crossBtnFunc () {

        customPopV.removeFromSuperview()
        buttonback.removeFromSuperview()

    }

    @IBAction func logOutBtnAction(_ sender: AnyObject) {
        clickHelpPopUp()
    }

    func leftController(_ leftController: UserListView, didSelectTableView tableView: UITableView, indexValue: String) {

        if indexValue == "Log Out" {

            UserDefaults.standard.removeObject(forKey: "login")
            if WebClass.sharedInstance.connected()  == true {

                CoreDataHandler().deleteAllData("Custmer")
            }
            let mapViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "viewC") as? ViewController
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: false)
            buttonbg.removeFromSuperview()
            customPopView1.removeView(view)
        }
    }

    func clickHelpPopUp() {

        buttonbg1.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonbg1.addTarget(self, action: #selector(PostingViewController.buttonPressed11), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.3)
        self.view .addSubview(buttonbg1)

        customPopView1 = UserListView.loadFromNibNamed("UserListView") as! UserListView
        customPopView1.logoutDelegate = self
        customPopView1.layer.cornerRadius = 8
        customPopView1.layer.borderWidth = 3
        customPopView1.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg1 .addSubview(customPopView1)
        customPopView1.showView(self.view, frame1: CGRect(x: self.view.frame.size.width - 200, y: 60, width: 150, height: 60))

    }
    func buttonPressed11() {
        customPopView1.removeView(view)
        buttonbg1.removeFromSuperview()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        buttonDroper.alpha = 0
        autoSerchTable.alpha = 0

        view.endEditing(true)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        existingArray = CoreDataHandler().fetchAllPostingExistingSessionwithFullSessionWithCapId(1).mutableCopy() as! NSMutableArray
        tableView.reloadData()

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
    @IBAction func synvBtnAction(_ sender: AnyObject) {

        if self.allSessionArr().count > 0 {
            if WebClass.sharedInstance.connected()  == true {

                Helper.showGlobalProgressHUDWithTitle(self.view, title: NSLocalizedString("Data syncing...", comment: ""))

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

            //Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:NSLocalizedString("There are problem in data syncing please try again. \n(\(statusCode))", comment: "") )
        }
    }
    func failWithErrorInternal() {
        Helper.dismissGlobalHUD(self.view)

        self.printSyncLblCount()

        //Helper.showAlertMessage(self,titleStr:NSLocalizedString("Alert", comment: "") , messageStr:" Server error please try again .")

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("No internet connection. Please try again!", comment: ""))
    }

    func didFinishApi() {
        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)
        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Data sync has been completed.", comment: ""))
    }

    func failWithInternetConnection() {

        self.printSyncLblCount()

        Helper.dismissGlobalHUD(self.view)

        Helper.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("You are currently offline. Please go online to sync data.", comment: ""))
    }

    func printSyncLblCount() {

        syncNotiCount.text = String(self.allSessionArr().count)
    }
}
