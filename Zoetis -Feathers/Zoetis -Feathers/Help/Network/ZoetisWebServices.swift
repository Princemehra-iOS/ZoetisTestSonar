//  Zoetis -Feathers
//
//  Created by Suraj Kumar Panday on 08/11/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import MBProgressHUD

typealias CompletionBlock = (JSON, NSError?) -> Void

class ZoetisWebServices: BaseViewController {

    static let shared = ZoetisWebServices()
    var viewController = UIViewController()

    enum EndPoint: String {
        
        /*
         case getCompanyPE = "Assessment/GetAllCustomerList_PE"
        case getComplexPE = "Assessment/GetComplex_PE?CountryId=4"
        case getCustomerListPVE = "ZoetisPV/PVEWebAPI/api/CustomerDetails/GetCustomerList?CountryId="
        case getComplexPVE = "/ZoetisPV/PVEWebAPI/api/ComplexDetails?customerId="
        case getBirdBreedsDetailsPVE = "ZoetisPV/PVEWebAPI/api/BirdBreedsDetails"
         */
        
        case login = "Token"
//PE--------------------
        case getPostingSessionList = "PostingSession/GetPostingSessionListByUser?UserId="
        case getAllCustomerPE = "ZoetisPE/API/api/Assessment/GetAllCustomer_PE"
        case getComplexPE = "ZoetisPE/API/api/Assessment/GetComplex_PE?CountryId="
        case getCustomerPE = "ZoetisPE/API/api/Assessment/GetCustomer?CountryId="
        case getSitesPE = "ZoetisPE/API/api/Assessment/GetSite_PE?CustomerId="
        case getEvaluator = "ZoetisPE/API/api/Assessment/GetEvaluator"
        case getVisitTypes = "ZoetisPE/API/api/Assessment/GetVisitTypes"
        case getEvaluatorTypes = "ZoetisPE/API/api/Assessment/GetEvaluationTypes"

//PVE--------------------
        
        case getCustomerListPVE = "ZoetisPV/PVEWebAPI/api/CustomerDetails/GetCustomerList?CountryId="
        case getComplexPVEOld = "/ZoetisPV/PVEWebAPI/api/ComplexDetails?customerId="
        case getComplexPVE = ""
        case getEvaluationTypePVE = "ZoetisPV/PVEWebAPI/api/EvaluationDetails/GetEvaluationType?Module_Id=2"
        case getEvaluationForPVE = "ZoetisPV/PVEWebAPI/api/EvaluationDetails/GetEvaluationFor"
        case getSiteIDNameDetailsPVE = "ZoetisPV/PVEWebAPI/api/SiteIDNameDetails"
        case getBirdAgeDetailsPVE = "ZoetisPV/PVEWebAPI/api/BirdAgeDetails"
        case getBirdBreedsDetailsPVE = "ZoetisPV/PVEWebAPI/api/BirdBreedsDetails"
        case getHousingDetailsPVE = "ZoetisPV/PVEWebAPI/api/HousingDetails"
        case getAssignUserDetailPVE = "ZoetisPV/PVEWebAPI/api/AssignUserDetails?Sub_Product_Id=1&User_Type_Id=2"
        case getEvaluatorDetailPVE = "ZoetisPV/PVEWebAPI/api/UserDetails/GetEvaluatorDetails?UserTypeId=2"
        case getModuleAssessmentCategoriesDetailsPVE = "ZoetisPV/PVEWebAPI/api/ModuleAssessmentCategoriesDetails/GetModuleAssessmentCategoriesDetails?Module_Id=2"
        case getModuleAssessmentsPVE = "ZoetisPV/PVEWebAPI/api/ModuleAssessmentsDetails?Module_Cat_Id="

//
///Microbial-----------------------------
       // https://pv360.mobileprogramming.net/ZoetisMicrobial/API/api/Customer/GetAllCustomers
        case getAllCustomersMicrobial = "ZoetisMicrobial/API/api/Customer/GetAllCustomers"


        
        var latestUrl: String {
            return "\(Constants.Api.baseUrl)\(self.rawValue)"
        }
    }
}
//https://pv360.mobileprogramming.net/ZoetisPV/PVEWebAPI/api/ComplexDetails?customerId=1599&CountryId=40
extension NSError {

    convenience init(localizedDescription: String) {
        self.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }

    convenience init(code: Int, localizedDescription: String) {
        self.init(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

extension ZoetisWebServices {


    //Services Used
    /*
    func login(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        print("POST SERVICE : login ", EndPoint.login.latestUrl)
        let header = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
        postRequest(showHud: false, showHudText: "", endPoint: EndPoint.login.latestUrl, controller: controller, parameters: parameters, headers: header, completion: completion)
    }*/

      func getComplexListForPE( controller: UIViewController, countryID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
             let url = EndPoint.getComplexPE.latestUrl + countryID
             print("GET SERVICE*** : getComplexListForPE ", url)
          getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
      
      func getAllCustomerListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
             let url = EndPoint.getAllCustomerPE.latestUrl
             print("GET SERVICE*** : getAllCustomerListForPE ", url)
          getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
    
      func getCustomerListForPE( controller: UIViewController, countryID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
             let url = EndPoint.getCustomerPE.latestUrl + countryID
             print("GET SERVICE*** : getCustomerListForPE ", url)
          getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
      
      func getSitesListForPE( controller: UIViewController, sitesID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
             let url = EndPoint.getSitesPE.latestUrl + sitesID
             print("GET SERVICE*** : getSitesListForPE ", url)
          getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
      
      func getEvaluatorListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
                let url = EndPoint.getEvaluator.latestUrl
                print("GET SERVICE*** : getEvaluatorListForPE ", url)
             getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
      
      func getVisitTypesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
               let url = EndPoint.getVisitTypes.latestUrl
               print("GET SERVICE*** : getVisitTypesListForPE ", url)
               getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
      
      func getEvaluatorTypesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
              let url = EndPoint.getEvaluatorTypes.latestUrl
              print("GET SERVICE*** : getEvaluatorTypesListForPE ", url)
              getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
      }
    
//-----------------PVE-----------------------

    func getCustomerListForPVE( controller: UIViewController, countryID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getCustomerListPVE.latestUrl + countryID
           print("GET SERVICE*** : getCustomerListForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getComplexListForPVE( controller: UIViewController, countryID: String,  parameters: JSONDictionary, completion: @escaping CompletionBlock) {
          // let url = EndPoint.getComplexPVE.latestUrl + customerID + "&CountryId=\(countryID)"
        //ZoetisPE/API/api/Assessment/GetComplex_PE?CountryId=
        let url = EndPoint.getComplexPVE.latestUrl + "ZoetisPE/API/api/Assessment/GetComplex_PE?CountryId=\(countryID)"
           print("GET SERVICE*** : getComplexListForPVE ", url)
           /*let accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
           let headers: HTTPHeaders = [
               "Authorization": accestoken,
               "Accept": "application/json"
           ]*/
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    ///// Start New Assessment
    
    func getBreedOfBirldsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getBirdBreedsDetailsPVE.latestUrl
           print("GET SERVICE*** : getBirdBreedsDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getEvaluationTypeForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getEvaluationTypePVE.latestUrl
           print("GET SERVICE*** : getEvaluationTypePVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getEvaluationForForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getEvaluationForPVE.latestUrl
           print("GET SERVICE*** : getEvaluationForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getSiteIdNameForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getSiteIDNameDetailsPVE.latestUrl
           print("GET SERVICE*** : getSiteIdNameForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getAgeOfBirdsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getBirdAgeDetailsPVE.latestUrl
           print("GET SERVICE*** : getAgeOfBirdsForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getBreedOfBirdsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getBirdBreedsDetailsPVE.latestUrl
           print("GET SERVICE*** : getBreedOfBirdsForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getHousingDetailsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getHousingDetailsPVE.latestUrl
           print("GET SERVICE*** : getHousingDetailsForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAssignUserDetailForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getAssignUserDetailPVE.latestUrl
           print("GET SERVICE*** : getAssignUserDetailForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getEvaluatorDetailForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getEvaluatorDetailPVE.latestUrl
           print("GET SERVICE*** : getEvaluatorDetailForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    func getAssessmentCategoriesDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getModuleAssessmentCategoriesDetailsPVE.latestUrl
           print("GET SERVICE*** : getAssessmentCategoriesDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

//    //---- Question Page for PVE
//
//    func getModuleAssessmentsPVE( controller: UIViewController, moduleCategoryId:String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
//           let url = EndPoint.getModuleAssessmentsPVE.latestUrl + moduleCategoryId
//           print("GET SERVICE*** : getModuleAssessmentsPVE ", url)
//        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
//    }

    
    

//-----------------Microbial-----------------------
    
    func getAllCustomersForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
           let url = EndPoint.getAllCustomersMicrobial.latestUrl
           print("GET SERVICE*** : getAllCustomersForMicrobial ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    
    //Handlers

    func handleFailureBlock(error: NSError? = nil, json: JSON? = nil) {
            if error?.code == -1009 {
            viewController.noInternetConnection()
        } else if error?.code == 405 {
            //  UserManager.instance.moveToLogin()
        } else if error?.code == 400 ||  error?.code == 401 {
            //let errorMSg = json?["error_description"]
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 400 || 401", actionHandler: nil)
        } else if error?.code == 405 {
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 405", actionHandler: nil)
        } else if error?.code == 402 {
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 402", actionHandler: nil)
        } else {
            if error?.localizedDescription == "cancelled" {
                return
            }
            viewController.showAlertViewWithMessageAndActionHandler(message: error?.localizedDescription ?? "Something went wrong.", actionHandler: nil)
        }
        dismissGlobalHUD(self.view)
    }

    func getRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, pageNumber: Int = 1, controller: UIViewController, endPoint: String, parameters: JSONDictionary, headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ZoetisApiManager.GET(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
           shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }

    func postRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, endPoint: String, controller: UIViewController, parameters: JSONDictionary, imageData: Data = Data(), imageKey: String = "", headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ZoetisApiManager.POST(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, imageData: imageData, imageKey: imageKey, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
           shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }

    func handlecompletionResponse(_ json: JSON, shouldErrorRequired: Bool = false, completion: @escaping CompletionBlock) {

        let jsonDic = json["error"].stringValue

        if jsonDic.count > 0 {
             handleFailureBlock(json: json)
        } else {
             completion(json, nil)
        }

    }

}
