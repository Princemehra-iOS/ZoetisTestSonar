//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 08/11/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    struct ControllerIdentifier {
        static let dashboardController = "DashboardViewController"
        static let searchController = "SearchViewController"
        static let articleController = "ArticleListViewController"
        static let datePickerPopupViewController = "DatePickerPopupViewController"

     // PVE-------------
        static let PVEFinalizeSNA = "PVEStartNewAssFinalizeAssement"
    }
//"evaluationFor"
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
        static let pveStoryboard = "PVEStoryboard"
        static let microbialStoryboard = "Microbial"
    }

    struct ClickedFieldStartNewAssPVE {
        static let housing = "Housing"
        static let ageOfBirds = "ageOfBirds"
        static let breedOfBirds = "breedOfBirds"
        static let accountManager = "accountManager"
        static let siteId = "siteId"
        static let evaluationDetails = "evaluationDetails"
        static let evaluationFor = "evaluationFor"
        static let evaluationType = "evaluationType"
    }

    struct Api {
        //static let baseUrl = "https://pv360.mobileprogramming.net/ZoetisPE/API/api/"
       // static let baseUrl = "https://pv360.mobileprogramming.net/"
        static let baseUrl = "https://pv360.mobileprogramming.net/"
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

}

enum ZoetisArt {

    struct FontSize {
        static let extraLarge: CGFloat = 20.0
        static let large: CGFloat = 18.0
        static let medium: CGFloat = 16.0
        static let regular: CGFloat = 14.0
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
        static let PVE_category_Orange = "#F6792D"
    }

    struct Font {
        static let light = "SFProText-Regular"
        static let regular = "SFProText-Regular"
        static let medium = "SFProText-Regular"
        static let semiBold = "SFProText-Regular"
        static let bold = "SFProText-Regular"
    }

    struct SfProTextFont {

        static let light = "SFProText-Light"
        static let regular = "SFProText-Regular"
        static let medium = "SFProDisplay-Medium"
        static let semiBold = "SFProText-Semibold"
        static let bold = "SFProDisplay-Bold"
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
