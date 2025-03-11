//
//  Extensions.swift
//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 24/10/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift
import SystemConfiguration

extension UILabel {
    @objc public func cstmlayoutSubviews() {
            self.cstmlayoutSubviews()
            return
        }

}


extension String {
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }

    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
}

extension UITextField {
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        if self.tag <= 0 {
            if UIApplication.isRTL() {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}

extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if LanguageUtility.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}

extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = LanguageUtility.currentAppleLanguage()
            var bundle = Bundle()
            if let _path = Bundle.main.path(forResource: LanguageUtility.currentAppleLanguageFull(), ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }

}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
    }

}

extension UIApplication {
    class func isRTL() -> Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

extension String {

    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
}
extension NSString {
    func crop() -> NSString {

        var frNme1 = self
        if  frNme1.length > 21 {
            var index: Int = -1
            var loc = Int()
            let newTemp: String = frNme1 as String
            for c in 0...frNme1.length - 1 {
                index = index + 1
                if  newTemp[c] == "(" {
                    loc = index
                }
            }
            let temp = frNme1.substring(from: loc) as NSString
            frNme1 = frNme1.substring(to: 15) as NSString
            frNme1 = NSString(format: "%@...%@", frNme1, temp)
        } else {
            let spaces = String(repeating: " ", count: 21 - frNme1.length)
            frNme1 = frNme1.appending(spaces) as NSString
        }
        return frNme1
        }
}
extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options())
    }
}
extension UIImage {

    func cropToBounds(_ image: UIImage, width: Double, height: Double, ismove: Bool) -> UIImage {

        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)

        let posX: CGFloat = 0
        let posY: CGFloat = ismove ? 116 : 63
        let cgwidth: CGFloat = CGFloat(width)
        let cgheight: CGFloat = CGFloat(ismove ? height : height + 63)

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
}

extension UIView {
    class func loadFromNibNamedPop(_ nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

extension NSRange {
    func toRange(_ string: String) -> Range<String.Index> {
    let startIndex = string.characters.index(string.startIndex, offsetBy: location)
    let endIndex = string.characters.index(string.endIndex, offsetBy: location)
    return startIndex..<endIndex
 }
}

extension Date {
    func isGreaterThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }

        //Return Result
        return isGreater
    }

    func isLessThanDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }

        //Return Result
        return isLess
    }

    func equalToDate(_ dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false

        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }

        //Return Result
        return isEqualTo
    }
}

extension UIImage {

    public class func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("image doesn't exist")
            return nil
        }

        return UIImage.animatedImageWithSource(source)
    }

    public class func gifImageWithURL(_ gifUrl: String) -> UIImage? {
        guard let bundleURL = URL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    public class func gifImageWithName(_ name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        guard let imageData = try? Data(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }

        return gifImageWithData(imageData)
    }

    class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()),
            to: CFDictionary.self)

        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
            to: AnyObject.self)
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }

        delay = delayObject as! Double

        if delay < 0.1 {
            delay = 0.1
        }

        return delay
    }

    class func gcdForPair(_ a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }

        if a! < b! {
            let c = a
            a = b
            b = c
        }

        var rest: Int
        while true {
            rest = a! % b!

            if rest == 0 {
                return b!
            } else {
                a = b
                b = rest
            }
        }
    }

    class func gcdForArray(_ array: [Int]) -> Int {
        if array.isEmpty {
            return 1
        }

        var gcd = array[0]

        for val in array {
            gcd = UIImage.gcdForPair(val, gcd)
        }

        return gcd
    }

    class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()

        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }

            let delaySeconds = UIImage.delayForImageAtIndex(Int(i),
                source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }

        let duration: Int = {
            var sum = 0

            for val: Int in delays {
                sum += val
            }

            return sum
        }()

        let gcd = gcdForArray(delays)
        var frames = [UIImage]()

        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)

            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }

        let animation = UIImage.animatedImage(with: frames,
            duration: Double(duration) / 1000.0)

        return animation
    }
}


//Designable

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
  
  @IBInspectable
  var setCornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
    }
  }
  

}
