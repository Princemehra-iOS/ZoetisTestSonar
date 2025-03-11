//
//  GradientDemoVC.swift
//  Zoetis -Feathers
//
//  Created by Nitin kumar Kanojia on 27/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation

class GradientDemoVC: UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // currentArr.append(["nnn": "qq"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
       
    @IBAction func actionMenu(_ sender: Any) {
        navigationController?.popViewController(animated: true)
     //   self.onSlideMenuButtonPressed(self.buttonMenu)
    }
    
    @IBAction func btnAction(_ sender: Any) {
        print("btnAction")
    }

//
//
//    @IBAction func optionBtnAction(_ sender: UIButton) {
//
//        switch sender.titleLabel?.text! {
//        case "Crew Safety":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Vaccine Preparation":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Bird Welfare":
//            print("\(String(describing: sender.titleLabel?.text))")
//        case "Vaccine Evaluation":
//            print("\(String(describing: sender.titleLabel?.text))")
//        default:
//            print("\(String(describing: sender.titleLabel?.text))")
//        }
//        print("\(String(describing: sender.titleLabel?.text))")
//        print("optionBtnAction")
//    }

    
}
