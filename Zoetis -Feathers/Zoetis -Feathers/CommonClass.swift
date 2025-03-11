////  CommonClass.swift
////  Zoetis -Feathers
////  Created by "" on 23/08/16.
////  Copyright © 2016 "". All rights reserved.
//  CommonClass.swift
//  Zoetis -Feathers
//  Created by "" on 23/08/16.
//  Copyright © 2016 "". All rights reserved.

import UIKit

protocol DatePickerDelegate: class {
    func didCancel()
    func didDone()
}
func showDropDown(_ button: UIButton, lblName: UILabel, array: NSArray  ) {

    if (button.superview?.frame)!.height - button.frame.origin.y < 200 {
        Dropper.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .top, button: button, newItems: array) { (responseData) in
            print(responseData)
            lblName.text = responseData?.routeName
            //routeId1 = responseData.routeId
        }
    } else {
        Dropper.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .bottom, button: button, newItems: array) { (responseData) in
            print(responseData)
            lblName.text = responseData?.routeName
            // routeId1 = responseData.routeId
        }
    }
}
func hideDropDown() {

    Dropper.sharedInstance.hideWithAnimation(0.1)
}

//////// Turkey
func showDropDownTurkey(_ button: UIButton, lblName: UILabel, array: NSArray  ) {

    if (button.superview?.frame)!.height - button.frame.origin.y < 200 {
        DropperTurkey.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .top, button: button, newItems: array) { (responseData) in
            print(responseData)
            lblName.text = responseData?.routeName
            //routeId1 = responseData.routeId
        }
    } else {

        DropperTurkey.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .bottom, button: button, newItems: array) { (responseData) in
            print(responseData)
            lblName.text = responseData?.routeName
            // routeId1 = responseData.routeId
        }
    }
}
func hideDropDownTurkey() {

    DropperTurkey.sharedInstance.hideWithAnimation(0.1)
}

class CommonClass: NSObject {

    weak var delegate: DatePickerDelegate?
    static let sharedInstance = CommonClass()

    func pickUpDate() -> (button: UIButton, donebutton: UIBarButtonItem, spaceButton: UIBarButtonItem, cancelButton: UIBarButtonItem, datePicker: UIDatePicker) {

        let buttonBg: UIButton = UIButton()
        buttonBg.setTitleColor(UIColor.blue, for: UIControl.State())
        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
        buttonBg.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 0.8)
        var datePicker: UIDatePicker = UIDatePicker()
        // DatePicker
        datePicker = UIDatePicker(frame: CGRect(x: 200, y: 200, width: 600, height: 300))
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.layer.borderWidth = 1
        datePicker.layer.cornerRadius = 3
        datePicker.layer.borderColor = UIColor.white.cgColor

        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: NSDate = NSDate()
        let components: NSDateComponents = NSDateComponents()

        components.month = -12
        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate as NSDate
        datePicker.minimumDate = minDate as Date
        buttonBg.addSubview(datePicker)

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.frame = CGRect(x: 200, y: 150, width: 600, height: 50)
        toolBar.isTranslucent = true
        toolBar.layer.borderWidth = 1
        toolBar.layer.cornerRadius = 3
        toolBar.layer.borderColor = UIColor.white.cgColor
        toolBar.tintColor = UIColor.red

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: nil, action: nil)

        // doneButton.
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        buttonBg.addSubview(toolBar)
        return ( buttonBg, doneButton, spaceButton, cancelButton, datePicker)
    }

    func updateCount () {

        let totalExustingArr = CoreDataHandler().fetchAllPostingExistingSessionwithFullSession(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        for i in 0..<totalExustingArr.count {
            let postingSession: PostingSession = totalExustingArr.object(at: i) as! PostingSession
            let pid = postingSession.postingId
            let feedProgram =  CoreDataHandler().FetchFeedProgram(pid!)
            if feedProgram.count == 0 {
                CoreDataHandler().updatePostingSessionOndashBoard(pid!, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
                CoreDataHandler().deletefieldVACDataWithPostingId(pid!)
                CoreDataHandler().deleteDataWithPostingIdHatchery(pid!)
            }

        }
    }

    func updateCountTurkey() {
        let totalExustingArr = CoreDataHandlerTurkey().fetchAllPostingExistingSessionwithFullSessionTurkey(1, birdTypeId: 1).mutableCopy() as! NSMutableArray
        for i in 0..<totalExustingArr.count {
            let postingSession: PostingSessionTurkey = totalExustingArr.object(at: i) as! PostingSessionTurkey
            let pid = postingSession.postingId
            let feedProgram =  CoreDataHandlerTurkey().FetchFeedProgramTurkey(pid!)
            if feedProgram.count == 0 {
                CoreDataHandlerTurkey().updatePostingSessionOndashBoardTurkey(pid!, vetanatrionName: "", veterinarianId: 0, captureNec: 2)
                CoreDataHandlerTurkey().deletefieldVACDataWithPostingIdTurkey(pid!)
                CoreDataHandlerTurkey().deleteDataWithPostingIdHatcheryTurkey(pid!)
            }
        }
    }
}

//*************************
//import UIKit
//
//protocol DatePickerDelegate: class {
//    func didCancel()
//    func didDone()
//}
//
//func showDropDown(_ button:UIButton, lblName: UILabel, array:NSArray  ) {
//
//    if (button.superview?.frame)!.height - button.frame.origin.y < 200 {
//        Dropper.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .top, button:button , newItems:array) { (responseData) in
//            ////print(responseData)
//
//            lblName.text = responseData?.routeName
//            //routeId1 = responseData.routeId
//
//
//        }
//    }
//    else{
//        Dropper.sharedInstance.showWithAnimationWithBlocks(0.15, options: .left, position: .bottom, button:button , newItems:array) { (responseData) in
//            ////print(responseData)
//
//            lblName.text = responseData?.routeName
//            // routeId1 = responseData.routeId
//        }
//    }
//
//
//
//
//}
//func hideDropDown() {
//
//    Dropper.sharedInstance.hideWithAnimation(0.1)
//}
//
//class CommonClass: NSObject {
//
//    weak var delegate:DatePickerDelegate?
//
//
//    static let sharedInstance = CommonClass()
//
//
//    func pickUpDate() -> (button: UIButton, donebutton: UIBarButtonItem ,spaceButton:UIBarButtonItem, cancelButton : UIBarButtonItem ,datePicker:UIDatePicker) {
//
//        let buttonBg: UIButton = UIButton()
//        // buttonBg.setTitle("Add", forState: .Normal)
//        buttonBg.setTitleColor(UIColor.blue, for: UIControlState())
//        buttonBg.frame = CGRect(x: 0, y: 0, width: 1024, height: 768) // X, Y, width, height
//        buttonBg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.8)
////        buttonBg.addTarget(self, action: #selector(PostingViewController.buttonPressed), forControlEvents: .TouchUpInside)
////        self.view.addSubview(buttonBg)
//        var datePicker: UIDatePicker = UIDatePicker()
//
//        // DatePicker
//        datePicker = UIDatePicker(frame:CGRect(x: 200, y: 200, width: 600, height: 300))
//        datePicker.backgroundColor = UIColor.white
//        datePicker.datePickerMode = UIDatePickerMode.date
//        datePicker.layer.borderWidth = 1
//        datePicker.layer.cornerRadius = 3
//        datePicker.layer.borderColor = UIColor.white.cgColor
//
//        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
//        let currentDate: NSDate = NSDate()
//        let components: NSDateComponents = NSDateComponents()
//
//        components.month = -3
//        let minDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate as NSDate
//        datePicker.minimumDate = minDate as Date
//        buttonBg.addSubview(datePicker)
//
//
//        // ToolBar
//        let toolBar = UIToolbar()
//        toolBar.barStyle = .default
//        toolBar.frame = CGRect(x: 200, y: 150, width: 600, height: 50)
//        toolBar.isTranslucent = true
//        toolBar.layer.borderWidth = 1
//        toolBar.layer.cornerRadius = 3
//        toolBar.layer.borderColor = UIColor.white.cgColor
//        //        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
//        toolBar.tintColor = UIColor.red
//        //toolBar.sizeToFit()
//
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
//
//        // doneButton.
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: nil, action:nil)
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//        buttonBg.addSubview(toolBar)
//        return ( buttonBg, doneButton, spaceButton ,  cancelButton, datePicker)
//
//    }
//
//
//
//
////
// MARK: - Button Done and Cancel
////    func doneClick() {
////
//////        self.delegate done
////
////        let dateFormatter1 = NSDateFormatter()
////        dateFormatter1.dateStyle = .MediumStyle
////        dateFormatter1.timeStyle = .NoStyle
////        lblDate.text = dateFormatter1.stringFromDate(datePicker.date)
////        buttonBg.removeFromSuperview()
////    }
////    func cancelClick() {
////
////        buttonBg.removeFromSuperview()
////    }
//
//
//
//
//
//}
