//
//  DatePickerPopupViewController.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 14/12/19.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

protocol DatePickerPopupViewControllerProtocol {
    func doneButtonTapped(string:String)
    
    func doneButtonTappedWithDate(string:String, objDate:Date)
    
}

class DatePickerPopupViewController: BaseViewController {
    @IBOutlet weak var buttonBg: UIButton!
    var delegate: DatePickerPopupViewControllerProtocol?
    var canSelectPreviousDate : Bool = false
    var isPVE : Bool = false
    var isPVEVacExpiry : Bool = false
    var isVaccinationModule:Bool = false
    var evaluationDate:String?
    var isCertificateDate = 0
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var datePicker: UIDatePicker!
    var regionID = Int()
    override func viewDidLoad() {
        print("<<<<",self)
        super.viewDidLoad()
        regionID = UserDefaults.standard.integer(forKey: "Regionid")
        pickUpDate()
    }
    
    func pickUpDate()  {
        
        var donebutton: UIBarButtonItem = UIBarButtonItem()
        var spaceButton: UIBarButtonItem = UIBarButtonItem()
        
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
        //Vaccination
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.backgroundColor = .white
        }
        
        if isPVE == true{
            datePicker.minimumDate = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        }        // ToolBar
        else if isPVEVacExpiry == true && canSelectPreviousDate == true{
            let theDaysLater = TimeInterval(1200.months)
            datePicker.minimumDate = Date().addingTimeInterval(-theDaysLater)
           // let theyearLater = TimeInterval(1200.years)
           // datePicker.maximumDate = Date().addingTimeInterval(-theyearLater)
            //            datePicker.minimumDate = Date()
            
        }
        else if isVaccinationModule && canSelectPreviousDate{
                let theDaysLater = TimeInterval(1200.months)
                datePicker.minimumDate = Date().addingTimeInterval(-theDaysLater)
                datePicker.maximumDate = Date()
        }
        else{
            if evaluationDate != nil && evaluationDate != ""{
                let theDaysLater = TimeInterval(3.months)
                let dateFormatterObj = CodeHelper.sharedInstance.getDateFormatterObj("")
                
              //  dateFormatterObj.dateFormat = "MM/dd/yyyy"
                
                let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
                if regionID != 3 {
                    dateFormatterObj.dateFormat = "dd/MM/yyyy"
                }
                else{
                    dateFormatterObj.dateFormat="MM/dd/yyyy"
                }
          
               
                let evaluationDateObj = dateFormatterObj.date(from:self.evaluationDate!)
                    
               // let evalDate = dateFormatterObj.date(from: evaluationDate!)
                let currentQuarterDate = evaluationDateObj?.startOfQuarter.startOfMonth()
                let lastDateOfCurrentQuarter = currentQuarterDate?.addingTimeInterval(theDaysLater).endOfMonth()
                if currentQuarterDate != nil && lastDateOfCurrentQuarter != nil{
                    let date1 = dateFormatterObj.string(from: currentQuarterDate!)
                    let date2  =  dateFormatterObj.string(from: lastDateOfCurrentQuarter!)
                    datePicker.minimumDate = currentQuarterDate
                    datePicker.maximumDate =  lastDateOfCurrentQuarter
                }
               
//                datePicker.minimumDate = minDate as Date
//                           let threeDaysLater = TimeInterval(12.months)
//                           if canSelectPreviousDate {
//                               datePicker.minimumDate = Date().addingTimeInterval(-7776000)
//                           } else {
//                               datePicker.minimumDate = Date().addingTimeInterval(-threeDaysLater)
//                               datePicker.maximumDate =  Date()
//                           }
            }
            else{
                let evaluationDateObj =  Date()
              
                if isCertificateDate == 0
                {
                    let currentQuarterDate =  evaluationDateObj.startOfQuarter.startOfMonth()
                    
                    let theDaysLater = TimeInterval(3.months)
                     let lastDateOfCurrentQuarter = currentQuarterDate.addingTimeInterval(theDaysLater).endOfMonth()
                    
                    datePicker.minimumDate = Date().addingTimeInterval(-theDaysLater)
                    datePicker.maximumDate = Date()
                }
               
            }
           
        }       // ToolBar
            
        
        
        /*
         
         let threeDaysLater = TimeInterval(12.months)
         if isVaccinationModule && canSelectPreviousDate{
             let theDaysLater = TimeInterval(1200.months)
             datePicker.minimumDate = Date().addingTimeInterval(-theDaysLater)
             datePicker.maximumDate = Date()
         }else{
             datePicker.minimumDate = Date().addingTimeInterval(-threeDaysLater)
             datePicker.maximumDate = Date()
         }

         */
        
        toolBar.barStyle = .default
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
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        //   view.addSubview(datePicker)
    }
    
    @objc func dismissKeyboard() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func doneClick1() {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat="MM/dd/YYYY"
        
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        if regionID != 3 {
            dateFormatter.dateFormat = "dd/MM/YYYY"
        }
        else{
            dateFormatter.dateFormat="MM/dd/YYYY"
           
        }
  
        
        
        let strdate1 = dateFormatter.string(from: datePicker.date) as String

        delegate?.doneButtonTappedWithDate(string: strdate1, objDate: datePicker.date)
        self.isPVE = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelClick1() {
        dismiss(animated: true, completion: nil)
        self.isPVE = true
    }
    
    @objc func buttonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM yyyy HH:mm:ss Z"
        return formatter
    }()
    var formatted: String {
        return Date.formatter.string(from: self)
    }
}

extension Int {
    
    var seconds: Int {
        return self
    }
    
    var minutes: Int {
        return self.seconds * 60
    }
    
    var hours: Int {
        return self.minutes * 60
    }
    
    var days: Int {
        return self.hours * 24
    }
    
    var weeks: Int {
        return self.days * 7
    }
    
    var months: Int {
        return self.weeks * 4
    }
    
    var years: Int {
        return self.months * 12
    }
}
