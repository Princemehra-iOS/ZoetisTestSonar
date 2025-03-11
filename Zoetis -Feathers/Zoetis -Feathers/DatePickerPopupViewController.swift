//
//  DatePickerPopupViewController.swift
//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 14/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import UIKit

protocol DatePickerPopupViewControllerProtocol {
    func doneButtonTapped(string:String)
}

class DatePickerPopupViewController: BaseViewController {
    @IBOutlet weak var buttonBg: UIButton!
    var delegate: DatePickerPopupViewControllerProtocol?
    var datePicker: UIDatePicker = UIDatePicker()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        pickUpDate()
    }
    
    func pickUpDate()  {

        var donebutton: UIBarButtonItem = UIBarButtonItem()
        var spaceButton: UIBarButtonItem = UIBarButtonItem()

        datePicker = UIDatePicker(frame: CGRect(x: self.view.frame.width/2 - datePicker.frame.width/2, y: self.view.frame.height/2-150, width: datePicker.frame.width, height: 300))
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

        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.frame = CGRect(x: datePicker.frame.origin.x, y: datePicker.frame.origin.y-50, width: datePicker.frame.width, height: 50)
        toolBar.isTranslucent = true
        toolBar.layer.borderWidth = 1
        toolBar.layer.cornerRadius = 3
        toolBar.layer.borderColor = UIColor.white.cgColor
        toolBar.tintColor = UIColor.red

        // Adding Button ToolBar
        donebutton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: nil, action: #selector(doneClick1))

        spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("Cancel", comment: ""), style: .plain, target: nil, action: #selector(dismissKeyboard))
        
        toolBar.setItems([cancelButton,spaceButton,donebutton], animated: false)
        toolBar.isUserInteractionEnabled = true
        view.addSubview(toolBar)
        let tapGesture = UITapGestureRecognizer(target: self,
                            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addSubview(datePicker)
    }
    
    @objc func dismissKeyboard() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneClick1() {
        let dateFormatter = DateFormatter()
        //dateFormatter3.dateFormat="MM/dd/yyyy/HH:mm:ss"
        dateFormatter.dateFormat="MM/dd/yyyy"
        let strdate1 = dateFormatter.string(from: datePicker.date) as String
        delegate?.doneButtonTapped(string: strdate1)
        dismiss(animated: true, completion: nil)
    }

    @objc func cancelClick1() {
            dismiss(animated: true, completion: nil)
    }

    @objc func buttonPressed() {
            dismiss(animated: true, completion: nil)
    }

}
