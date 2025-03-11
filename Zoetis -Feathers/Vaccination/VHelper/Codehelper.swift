//
//  Codehelper.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 01/04/20.
//  Copyright © 2020 Rishabh Gulati. All rights reserved.
//

import Foundation
import Reachability

//UIImage
class  CodeHelper{
    var reachability = try! Reachability()
    
    private init(){print("Initializer")}
    static let sharedInstance = CodeHelper()
    
    func dictKeyExists(dict: Dictionary<String, Any>, key: String) -> Bool{
        if dict.index(forKey: key) != nil{
            return true
        }
        return false
    }
    
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func prettyPrint(with json: [String: Any]) -> String?{
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        let str = string! as String
        
        return str
    }
    
    func convertToBase64(image: UIImage) -> String?{
        let imageData: Data? = (image.pngData()! as NSData) as Data
        let strBase64:String? = (imageData?.base64EncodedString(options: .lineLength64Characters))
        if let str = strBase64{
            return str
        }
        return nil
    }
    
    func convertToImage(base64: String) -> UIImage?{
        let datas = Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
        if let data = datas{
            let image = UIImage(data: data)
            if image != nil{
                return image!
            }
        }
        return nil
    }
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data(base64Encoded: imageBase64String)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func convertDateFormater(_ date: String, inputFormat:String = "yyyy-MM-dd'T'HH:mm:ss", outputString:String = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = inputFormat//"yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: date) else {
            return ""
        }
        dateFormatter.dateFormat = outputString//"MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    
    func getDateFormatterObj(_ date: String, inputFormat:String = "yyyy-MM-dd'T'HH:mm:ss")-> DateFormatter{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat//"yyyy-MM-dd'T'HH:mm:ss"
        // dateFormatter.timeZone = Calendar.current.timeZone commented this
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC") // added this
        dateFormatter.locale = Calendar.current.locale
        return  dateFormatter
   
    }
    
    func compareDates(firstDate:String, scondDate:String){
        let formatter = DateFormatter()
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        formatter.dateFormat = "dd/MM/yyyy"
        var firstDate = formatter.date(from: "10/08/2017")
        var secondDate = formatter.date(from: "10/08/2017")
        
        firstDate = formatter.date(from: "8/08/2017")
        secondDate = formatter.date(from: "10/08/2017")
        
        firstDate = formatter.date(from: "18/08/2017")
        secondDate = formatter.date(from: "10/08/2017")
        
    }
    
}

extension UIView {
    func roundVsCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}

extension Date {
    public var startOfQuarter: Date {
        let startOfMonth = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
        
        var components = Calendar.current.dateComponents([.month, .day, .year], from: startOfMonth)
        
        let newMonth: Int
        switch components.month! {
        case 1,2,3: newMonth = 1
        case 4,5,6: newMonth = 4
        case 7,8,9: newMonth = 7
        case 10,11,12: newMonth = 10
        default: newMonth = 1
        }
        components.month = newMonth
        return Calendar.current.date(from: components)!
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
}
