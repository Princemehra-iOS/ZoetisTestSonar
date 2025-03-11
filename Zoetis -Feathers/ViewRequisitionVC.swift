//
//  ViewRequisitionVC.swift
//  Zoetis -Feathers
//
//  Created by Avinash Singh on 07/01/20.
//  Copyright © 2020 . All rights reserved.
//

//import UIKit
//
//class ViewRequisitionVC: BaseViewController {
//
//    @IBOutlet weak var requisitionTableView: UITableView!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    @IBOutlet weak var buttonMenu: UIButton!
//
//    @IBAction func actionMenu(_ sender: Any) {
//       // self.onSlideMenuButtonPressed(self.buttonMenu)
//
//          NotificationCenter.default.post(name: NSNotification.Name("LeftMenuBtnNoti"), object: nil, userInfo: nil)
//    }
//
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension ViewRequisitionVC : UITableViewDelegate,UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "requisitionDataCell", for: indexPath) as! requisitionDataCell
//
//        cell.requisitionNumberTxt.text = "1235478"
//        cell.requisitionDateTxt.text = "12/12/2020"
//        cell.surveyTypeTxt.text = "######"
//        cell.statusTxt.text = "#####"
//
//
//        return cell
//
//
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//       return 5
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 87
//    }
//
//}
