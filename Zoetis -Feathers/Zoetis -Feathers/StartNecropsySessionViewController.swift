//
//  StartNecropsySessionViewController.swift
//  Zoetis -Feathers
//
//  Created by "" on 8/24/16.
//  Copyright © 2016 "". All rights reserved.
//

import UIKit

class StartNecropsySessionViewController: UIViewController {

    var datePicker: UIDatePicker!
    var buttonBg = UIButton()
    @IBOutlet weak var selectDateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    @IBAction func back_bttn(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sliderBttn(_ sender: AnyObject) {
    }
    @IBAction func selectDateBttn(_ sender: AnyObject) {

        let buttons  = CommonClass.sharedInstance.pickUpDate()
        buttonBg  = buttons.0
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
        buttonBg.addTarget(self, action: #selector(StartNecropsySessionViewController.buttonPressed), for: .touchUpInside)
        let donebutton: UIBarButtonItem = buttons.1

        donebutton.action =  #selector(StartNecropsySessionViewController.doneClick)

        let cancelbutton: UIBarButtonItem = buttons.3
        cancelbutton.action =  #selector(StartNecropsySessionViewController.cancelClick)

        datePicker = buttons.4
        self.view.addSubview(buttonBg)

    }
    @objc func buttonPressed() {

        buttonBg.removeFromSuperview()
    }
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        selectDateLabel.text = dateFormatter1.string(from: datePicker.date)
        buttonBg.removeFromSuperview()
    }
    @objc func cancelClick() {

        buttonBg.removeFromSuperview()
    }

    @IBAction func selectComplexBttn(_ sender: AnyObject) {
    }

    @IBAction func continueWithoutPostingBttn(_ sender: AnyObject) {
    }

    @IBAction func createNewPostingBttn(_ sender: AnyObject) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3

    }

    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {

        let cell: StartNecropsyTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "startNecro") as! StartNecropsyTableViewCell

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //print("You selected cell #\(indexPath.row)!")
    }

}
