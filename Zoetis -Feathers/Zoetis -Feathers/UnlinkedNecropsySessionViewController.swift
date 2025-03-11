//  UnlinkedNecropsySessionViewController.swift
//  Zoetis -Feathers
//  Created by "" on 05/11/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit

class UnlinkedNecropsySessionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]

    let textCellIdentifier = "cell"
    var buttonBg = UIButton()
    var datePicker: UIDatePicker!

    @IBOutlet weak var syncNotifCount: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {

        let  postingArrWithAllData1 = CoreDataHandler().fetchAllPostingSessionWithisSyncisTrue(true).mutableCopy() as! NSMutableArray
        syncNotifCount.text = String(postingArrWithAllData1.count)

        userNameLabel.text! = UserDefaults.standard.value(forKey: "FirstName") as! String

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swiftBlogs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath)

        let row = indexPath.row
        cell.textLabel?.text = swiftBlogs[row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let row = indexPath.row
        //print(swiftBlogs[row])
    }

    @IBAction func sliderButton(_ sender: AnyObject) {

        SlideNavigationController.sharedInstance().toggleLeftMenu()
    }

    @IBAction func fromDateSelected(_ sender: AnyObject) {

        let buttons  = CommonClass.sharedInstance.pickUpDate()
        buttonBg  = buttons.0
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonBg.addTarget(self, action: #selector(UnlinkedNecropsySessionViewController.fromDateP), for: .touchUpInside)
        let donebutton: UIBarButtonItem = buttons.1

        donebutton.action =  #selector(UnlinkedNecropsySessionViewController.doneClick1)

        let cancelbutton: UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(UnlinkedNecropsySessionViewController.cancelClick1)

        datePicker = buttons.4
        self.view.addSubview(buttonBg)

    }
    @objc func doneClick1() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        toDateLabel.text = dateFormatter1.string(from: datePicker.date)
        buttonBg.removeFromSuperview()
    }
    @objc func cancelClick1() {

        buttonBg.removeFromSuperview()
    }
    @objc func fromDateP() {

        buttonBg.removeFromSuperview()
    }
    @objc func toDatepre() {

        buttonBg.removeFromSuperview()
    }

    @IBAction func toDateSelected(_ sender: AnyObject) {

        let buttons  = CommonClass.sharedInstance.pickUpDate()
        buttonBg  = buttons.0
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonBg.addTarget(self, action: #selector(UnlinkedNecropsySessionViewController.toDatepre), for: .touchUpInside)
        let donebutton: UIBarButtonItem = buttons.1

        donebutton.action =  #selector(UnlinkedNecropsySessionViewController.doneClick1)

        let cancelbutton: UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(UnlinkedNecropsySessionViewController.cancelClick1)

        datePicker = buttons.4
        self.view.addSubview(buttonBg)

    }

    @IBAction func logOutBtnActon(_ sender: AnyObject) {
    }

    @IBAction func syncBttnAction(_ sender: AnyObject) {
    }

}
