//
//  KeyConstants.swift
//  Zoetis -Feathers
//
//  Created by   on 29/01/18.
//  Copyright © 2018   . All rights reserved.
//

import Foundation
import Charts

let MicroscopyObservationNameArray = CoreDataHandlerTurkey().getObservationNameForMicroscopy(refID: Regions.getObservationsMicroscopy(countryID: Regions.countryId)) as! [String]
let weekArray = ["\(NSLocalizedString("Week", comment: "")) 1", "\(NSLocalizedString("Week", comment: "")) 2", "\(NSLocalizedString("Week", comment: "")) 3", "\(NSLocalizedString("Week", comment: "")) 4", "\(NSLocalizedString("Week", comment: "")) 5", "\(NSLocalizedString("Week", comment: "")) 6", "\(NSLocalizedString("Week", comment: "")) 7", "\(NSLocalizedString("Week", comment: "")) 8", "\(NSLocalizedString("Week", comment: "")) 9", "\(NSLocalizedString("Week", comment: "")) 10"]

var sessionDateSingle = NSString()

class Regions: NSObject {

    static var countryId = UserDefaults.standard.integer(forKey: "countryId")
    static var languageID = UserDefaults.standard.integer(forKey: "lngId")

    class func getObservationsMicroscopy(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [607, 612, 613, 611]
            break
        case 35: observations = [607, 612, 613, 611]
            break

        default: break

        }
        return observations!
    }

    class func getObservationsForImmune(countryID: Int) -> [Int] {

                var observations: [Int]?

                switch countryID {

                case 40: observations = [59]
                    break
                case 35: observations = [59, 57]
                    break
                default: break

                }
                return observations!
        }
    class func getObservationsForImmuneTr(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [643, 641, 645, 647, 650]
            break
        case 35: observations = [643, 645, 650]
            break
        default: break

        }
        return observations!
    }

    class func getobservationsSkeletal(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [1, 2, 4, 5, 6, 7, 8, 9, 12]
            break
        case 35: observations = [1, 4, 7, 14]
            break
        default: break

        }
        return observations!
    }
    class func getobservationsSkeletalTr(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [596, 597, 598, 599, 600, 601, 602, 603]
            break
        case 35: observations = [596, 601]
            break

        default: break

        }
        return observations!
    }

    class func getObservationsResp(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [49, 50, 51]
            break
        case 35: observations = [50, 51]
            break
        default: break

        }
        return observations!
    }
    class func getObservationsRespTr(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [635, 636, 637, 638, 639, 640]
            break
        case 35: observations = [636, 637]
            break

        default: break

        }
        return observations!
    }
    class func getObservationsGITract(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [32, 34, 29, 31, 27, 33, 28, 37, 35]
            break
        case 35: observations = [32, 34, 29, 31, 27, 28, 38, 41]
            break
        default: break

        }
        return observations!
    }

    class func getObservationsGITractTr(countryID: Int) -> [Int] {

        var observations: [Int]?

        switch countryID {

        case 40: observations = [622, 619, 621, 617, 623, 675, 627, 632, 633, 624]
            break
        case 35: observations = [622, 624, 619, 621, 617, 618]
            break
        default: break

        }
        return observations!
    }
}

func nameCrop(inputSting: [String]) -> [String] {

    var observationsNames = [String]()
    for Nme in inputSting {
        var frNme1 = Nme as NSString
        frNme1 = frNme1.length > 17 ? NSString(format: "\(frNme1.substring(to: 17)).." as NSString) : frNme1
        observationsNames.append(frNme1 as String)
    }
    return observationsNames
}

class CalculationError: NSObject {
    static var hasError: Bool = false
}

func customString(inputStr: String) -> NSMutableAttributedString {
    let string = inputStr
    let attributedString = NSMutableAttributedString(string: string)

    let attributes = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.boldSystemFont(ofSize: 14)]
    let attributesLast = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 10)]

    if inputStr.count == 14 {
        attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(attributes), range: NSRange(location: 0, length: 13))
    }
    if inputStr.count == 15 {
        attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(attributes), range: NSRange(location: 0, length: 14))
    }
    if inputStr.count > 15 {
        attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(attributes), range: NSRange(location: 0, length: 14))
        attributedString.addAttributes(convertToNSAttributedStringKeyDictionary(attributesLast), range: NSRange(location: 15, length: inputStr.count-15))
    }
    return attributedString
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
private func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
