//  Zoetis -Feathers
//
//  Created by "" ""on 08/11/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    static var isFromRejected = false
    static var isDataLoaded = false
    static var rejectedCount = 0
    static var isMovementDone = false
    static var isFirstTime = true
    static var isFromSyncAssess = false
    var isApiLoaded: Bool?
    static var isMovedOn = false
    static var isDashboard = false
    static var isExtendedPopup = false
    static var liveComment = ""
    static var inactiveComment = ""
    static var locationValueType : Int = 0
    static var cell = EnviromentalSampleInfoCell()
    static var baseUrl = ""
    static var versionUrl = ""
    static var isLastSession = false
    static var modeType = ""
    static var selectedIndex = 0
    static var isFromPsoting = false
    static var isFromPsotingTurkey = false
    static var informDataSync = "You have an assessment that needs to be synced in order to logout of the app. Do you wish to sync the data first?"
    static var askForDataSync = "Data is available to sync. Do you wish to continue?"
    static var forceSyncMessage = "You cannot logout of the app without syncing as you may risk losing your data. Please sync the data in order to proceed with the log out."
    static var syncToWebTapped : Bool = false
    static var isFromDraft : Bool = false
    static var isPPmValueChanged : Bool = false
    static var isDraftAssessment : Bool = false
    static var isfromDraftStartVC: Bool = false
    static var anotherSwitchOFF: Bool = false
    static var switchCount : Int = 0
    static var isEMCalledFromDraft : Bool = false
    static var isAssessmentRejected : Bool = false
    static var appInstalledFirstTime : Bool = false
    static var offline = "You are currently offline. Please go online to sync data."
    static var isForUnlinkedTurkey = false
    static var isForUnlinkedChicken = false
    static var SelectedFarmChicken : Int = 0
    static var SelectedFarmTurkey : Int = 0
    static var deviceType = "iOS"
    
    
    struct ControllerIdentifier {
        static let dashboardController = "DashboardViewController"
        static let searchController = "SearchViewController"
        static let articleController = "ArticleListViewController"
        static let datePickerPopupViewController = "DatePickerPopupViewController"
        
        // PVE-------------
        static let PVEFinalizeSNA = "PVEStartNewAssFinalizeAssement"
        
    }
    
    struct CellIdentifiers {
        static let docCell = "DocCell"
        static let listCell = "cell"
        static let articleCell = "ArticleCell"
        static let plusMinusCell = "MyCell"
        static let addNote_StartNewAssCell = "AddNote_StartNewAssCell"
        static let startNewAssignmentCell = "StartNewAssignmentCell"
        
    }
    
    struct AppData {
        static let dashboardData = [["title": "Spotflock Login", "value": ["Login"]], ["title": "Spotflock Registration", "value": ["Registration"]]]
    }
    
    struct Storyboard {
        static let selection = "Selection"
        static let peStoryboard = "PEStoryboard"
        static let pve360Storyboard = "Main"
        static let pveStoryboard = "PVEStoryboard"
        static let microbialStoryboard = "Microbial"
        static let VACCINATIONCERTIFICATION = "Certification"
    }
    
    struct ClickedFieldMicrobialSurvey {
        static let company = "Company"
        static let reviewer = "Reviewer"
        static let surveyCondustedOn = "SurveyCondustedOn"
        static let siteId = "SiteId"
        static let reasonForVisit = "VisitReason"
        static let SampleCollectedBy = "SampleCollectedBy"
        static let purposeOfSurvey = "PurposeOfSurvey"
        static let transferIn = "TransferIn"
        static let evaluationType = "evaluationType"
        static let locationType = "locationType"
        static let locationValue = "locationValue"
        static let specimenType = "specimenType"
        static let birdType = "birdType"
        static let mediaType = "mediaType"
        static let mediaTypeId = "mediaTypeId"
        static let notes = "notes"
        static let sampling = "sampling"
        
    }
    
    struct ClickedFieldStartNewAssPVE {
        static let customer = "customer"
        static let housing = "Housing"
        static let ageOfBirds = "ageOfBirds"
        static let breedOfBirds = "breedOfBirds"
        static let breedOfBirdsFemale = "breedOfBirdsFemale"
        static let accountManager = "accountManager"
        static let siteId = "siteId"
        static let evaluationDetails = "evaluationDetails"
        static let evaluationFor = "evaluationFor"
        static let evaluationType = "evaluationType"
    }
    
    struct Api {
        
        //************************* Dev Migration URL***************************//
        // Dev Migration        
//        static let versionUrl = "https://devapi.mypoultryview360.com"
//        static let pveBaseUrl = "https://devPVEapi.mypoultryview360.com"
//        static let peBaseUrl = "https://devpeapi.mypoultryview360.com"
//        static let fhBaseUrl = "https://devapi.mypoultryview360.com"
//        static let tcBaseUrl = "https://devpeapi.mypoultryview360.com"
//        static let miBaseUrl = "https://devmicrobialapi.mypoultryview360.com"
//        static let fcmUrl = "https://devapi.mypoultryview360.com/api/GlobalDashboard/SaveNotificationSyncData"
        
        
        //************************* Stage Migration URL***************************//
        //  Stage
        static let versionUrl = "https://stageapi.mypoultryview360.com"
        static let pveBaseUrl = "https://stagePVEapi.mypoultryview360.com"
        static let peBaseUrl = "https://stagepeapi.mypoultryview360.com"
        static let fhBaseUrl = "https://stageapi.mypoultryview360.com"
        static let tcBaseUrl = "https://stagepeapi.mypoultryview360.com"
        static let miBaseUrl = "https://stagemicrobialapi.mypoultryview360.com"
        static let fcmUrl = "https://stageapi.mypoultryview360.com/api/GlobalDashboard/SaveNotificationSyncData"
        
        //************************* Live Migration URL***************************//
        //         Live Migration
//                        static let versionUrl = "https://api.mypoultryview360.com"
//                        static let pveBaseUrl = "https://pveapi.mypoultryview360.com"
//                        static let peBaseUrl = "https://peapi.mypoultryview360.com"
//                        static let fhBaseUrl = "https://api.mypoultryview360.com"
//                        static let tcBaseUrl = "https://peapi.mypoultryview360.com"
//                        static let miBaseUrl = "https://microbialapi.mypoultryview360.com"
//                        static let fcmUrl = "https://api.mypoultryview360.com/api/GlobalDashboard/SaveNotificationSyncData"
        
        //************************* Dev Support URL***************************//
        //        Dev Support URLs
        //                        static let versionUrl = "https://supportapi.mypoultryview360.com"
        //                        static let pveBaseUrl = "https://supportPVEapi.mypoultryview360.com"
        //                        static let peBaseUrl = "https://supportpeapi.mypoultryview360.com"
        //                        static let fhBaseUrl = "https://supportapi.mypoultryview360.com"
        //                        static let tcBaseUrl = "https://supportpeapi.mypoultryview360.com"
        //                        static let miBaseUrl = "https://supportMicrobialapi.mypoultryview360.com"
        //                        static let fcmUrl = "https://supportapi.mypoultryview360.com/api/GlobalDashboard/SaveNotificationSyncData"
        
    }
    
    struct GlobalVariables {
        
        // **********Chicken DataBase delete**************//
        
        static var chickenDB = ["AlternativeFeed", "AntiboticFeed", "BirdPhotoCapture", "BirdSizePosting", "Breed", "CamraImage", "CaptureNecropsyData", "CaptureNecropsyViewData", "Coccidiosis", "CoccidiosisControlFeed", "CocciProgramPosting", "ComplexPosting", "Custmer", "CustomerReprestative", "FarmsList", "FeedProgram", "FieldVaccination", "GITract", "HatcheryVac", "Immune", "Login", "MyCotoxinBindersFeed", "Necropsy", "NotesBird", "PostingSession", "Respiratory", "Route", "Salesrep", "Sessiontype", "Skeleta", "Veteration", "differernt user"]
        
        // **********Turkey DataBase delete**************//
        
        static var TurkeyDBArray = ["AlternativeFeedTurkey", "AntiboticFeedTurkey", "BirdPhotoCaptureTurkey", "BirdSizePostingTurkey", "BreedTurkey", "CamraImageTurkey", "CaptureNecropsyDataTurkey", "CaptureNecropsyViewDataTurkey", "CoccidiosisTurkey", "CoccidiosisControlFeedTurkey", "CocciProgramPostingTurkey", "ComplexPostingTurkey", "CustmerTurkey", "CustomerReprestativeTurkey", "FarmsListTurkey", "FeedProgramTurkey", "FieldVaccinationTurkey", "GITractTurkey", "HatcheryVacTurkey", "ImmuneTurkey", "LoginTurkey", "MyCotoxinBindersFeedTurkey", "NecropsyTurkey", "NotesBirdTurkey", "PostingSessionTurkey", "RespiratoryTurkey", "RouteTurkey", "SalesrepTurkey", "SessiontypeTurkey", "SkeletaTurkey", "VeterationTurkey"]
    }
    
    struct Module {
        static let hatchery = "IsHatchery"
        static let hatchery_PV = "IsHatcheryPV"
        static let breeder = "IsBreeder"
        static let growout = "IsGrowout"
        static let breeder_PVE = "IsbreederPVE"
    }
    
    struct Image {
        static let popup_bg_hatchery = "popup_bg_hatchery"
        static let popup_bg_breeder = "popup_bg_breeder"
        static let popup_bg_growout = "popup_bg_growout"
        static let add_icon = "add_icon"
        static let delete_icon = "delete_icon"
    }
    
    static let failedPosting = "Failed to get Posting Assessment list"
}

enum ZoetisArt {
    
    struct FontSize {
        
        static let extraLarge: CGFloat = 20.0
        static let large: CGFloat = 18.0
        static let medium: CGFloat = 16.0
        static let regular: CGFloat = 17.0
        static let small: CGFloat = 12.0
        static let extraSmall: CGFloat = 10.0
    }
    
    struct ColorCode {
        static let black = "#000000"
        static let lightGray = "#AAAAAA"
        static let red = "#E86E6E"
        static let blueBackgroundColor = "#3A3D65"
        static let textFieldBackGroundColor = "#F8F8FB"
        static let gradientlightGreen = "#97e8c3"
        static let gradientDarkGreen = "#31c588"
        static let gradientlightOrange = "#f6be81"
        static let gradientDarkOrange = "#c5631c"
        static let gradientCyan = "#21d4fd"
        static let gradientBlue = "#3721ff"
        static let gradientLightRed = "#f07f7f"
        static let gradientDarkRed = "#FF0000"
        static let background = "#D8D8D8"
        static let orangeColor = UIColor(red: 246.0 / 255.0, green: 121.0 / 255.0, blue: 45.0 / 255.0, alpha: CGFloat(1))
        
        static let loginButtonColor = UIColor(red: 40.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: CGFloat(1))
        
        static let blue1 = UIColor(red: 40.0 / 255.0, green: 237.0 / 255.0, blue: 255.0 / 255.0, alpha: CGFloat(1))
        static let blue2 = UIColor(red: 1.0 / 255.0, green: 167.0 / 255.0, blue: 199.0 / 255.0, alpha: CGFloat(1))
        static let orange = "#F6792D"
        static let green = UIColor(red: 41.0 / 255.0, green: 193.0 / 255.0, blue: 86.0 / 255.0, alpha: CGFloat(1))
    }
    
    struct Font {
        static let light = Font.regular
        static let regular = "SFProText-Regular"
        static let medium = Font.regular
        static let semiBold = Font.regular
        static let bold = Font.regular
    }
//    struct Font {
//        static let light = "SFProText-Regular"
//        static let regular = "SFProText-Regular"
//        static let medium = "SFProText-Regular"
//        static let semiBold = "SFProText-Regular"
//        static let bold = "SFProText-Regular"
//    }
    
    struct SfProTextFont {
        
        static let light = "SFProText-Light"
        static let regular = "SFProText-Regular"
        static let medium = "SFProDisplay-Medium"
        static let semiBold = "SFProText-Semibold"
        static let bold = "SFProDisplay-Bold"
    }
    
    struct HelveticaNeueFont {
        static let regular = "Helvetica"
        static let light = "Helvetica-Light"
        static let medium = "HelveticaNeue-Medium"
        static let semiBold = "Helvetica-LightOblique"
        static let bold = "Helvetica-Bold"
    }
    
}

extension ZoetisArt {
    
    struct Color {
        static let white = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        static let appThemeColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        static let appGray = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        static let black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let textBlack = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        static let backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        static let textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 0.6)
        
    }
}
func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

struct AccessTokenHelper {
    static func saveData(_ encodedToken:String) {
        KeyChainHelper.saveData(key: "aceesTokentype", value: encodedToken)
    }
    
    static func getData() -> String? {
        return KeyChainHelper.getData(key: "aceesTokentype")
    }
    
    
    
    func saveToKeychain(valued: String, keyed: String) {
        KeyChainHelper.saveData(key: keyed, value: valued)
    }
    
    
    func getFromKeychain(keyed: String) -> String? {
        return KeyChainHelper.getData(key: keyed)
    }
    
    
}


struct KeyChainHelper {
    static func saveData(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Remove existing item if it exists
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("Data saved to Keychain.")
        } else {
            print("Failed to save data: \(status)")
        }
    }
    
    static func getData(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("Failed to retrieve data: \(status)")
            return nil
        }
    }
}

extension NSMutableDictionary {
    func toJSONDictionary() -> [String: Any]? {
        // Convert NSMutableDictionary to Data
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            
            // Convert Data back to Swift Dictionary
            if let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return jsonDictionary
            }
        }
        return nil
    }
}

let appDelegate = UIApplication.shared.delegate as! AppDelegate
