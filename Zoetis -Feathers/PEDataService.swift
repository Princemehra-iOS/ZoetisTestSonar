//
//  PEDataService.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 26/08/20.
//

import Foundation
import Foundation
import UIKit

class PEDataService{
    private init(){print("Initializer")}
    static let sharedInstance = PEDataService()
    
    func getScheduledAssessments(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        var id = loginuserId
        let url = ZoetisWebServices.EndPoint.getPEScheduledCertifications.latestUrl + "\(id)?customerId=null&siteId=null"
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([ScheduledPEAssessmentsDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                
                                PEAssessmentsDAO.sharedInstance.saveScheduledAssessments(certificationDTOArr: vaccinationCertificationObj ?? [ScheduledPEAssessmentsDTO](), loginUserId: loginuserId)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }else{

                                completion("No Data Found", nil)
                            }
                        }else{
                            completion("No Data Found", nil)
                        }
                        
                    }else{
                        completion("No Data Found", nil)
                    }
                    
                }else{
                    completion("No Data Found", nil)
                }
            }else{
                completion("No Data Found", nil)
            }
            
        })
    }
    
    func getRejectedAssessments(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        var id = loginuserId//1667
        let url = ZoetisWebServices.EndPoint.getPERejectedAssessment.latestUrl + "\(id)"
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([PE_AssessmentRejectedDTO].self, from: data)
                            print(vaccinationCertificationObj?.count)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                PEAssessmentsDAO.sharedInstance.saveRejectedAssessments(certificationDTOArr: vaccinationCertificationObj ?? [PE_AssessmentRejectedDTO](), loginUserId: loginuserId)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }else{
                                completion("No Data Found", nil)
                            }
                            
                        }else{
                            completion("No Data Found", nil)
                        }
                        
                    }else{
                        completion("No Data Found", nil)
                    }
                    
                }else{
                    completion("No Data Found", nil)
                }
            }else{
                completion("No Data Found", nil)
            }
        })
    }
    
    func deleteDeletedAssessments(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        let userId = loginuserId//1667
        var url = ZoetisWebServices.EndPoint.deleteDrafts.latestUrl
        let deletedAssessments = PEDeletedDraftsDAO.sharedInstance.fetchDeletedAssessments(userId:  loginuserId)
        PEDeletedDraftsDAO.sharedInstance.deleteExisitingData("PE_DeletedAssessments", predicate: NSPredicate(format:"userId = %@", userId))
        if deletedAssessments.count > 0{
            url = url + deletedAssessments + "&userId=" + loginuserId + "&appVersion=" + Bundle.main.versionNumber
        }else{
            url = url + "&userId=" + loginuserId + "&appVersion=" + Bundle.main.versionNumber
        }
        ZoetisWebServices.shared.deleteDeletedDrafts(controller:viewController , parameters: [String:Any](),  url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        do {
                            // make sure this JSON is in the format we expect
                            if let jsonNew = try JSONSerialization.jsonObject(with: jsonData ?? Data(), options: []) as? [String: NSArray] {
                                // try to read out a string array
                                let deletedIdArray = jsonNew["AssesssmentId"]
                                print(deletedIdArray?.count)
                                PEDeletedDraftsDAO.sharedInstance.deleteExisitingData(predicate: nil)
                                if deletedIdArray?.count ?? 0 > 0{
                                    for assessmentId in deletedIdArray ?? []{
                                        self?.getAllDateArrayStored(assessmentId: assessmentId as? Int ?? 0)
                                    }
                                    completion(responseStr, nil)
                                }else{
                                    completion("No Data Found", nil)
                                }
                            }else{
                                completion("No Data Found", nil)
                            }
                        } catch let error as NSError {
                            print("Failed to load: \(error.localizedDescription)")
                            completion("No Data Found", nil)
                        }
                    }else{
                        completion("No Data Found", nil)
                    }
                }else{
                    completion("No Data Found", nil)
                }
            }else{
                completion("No Data Found", nil)
            }
            
        })
    }
    
    func getAllDateArrayStored(assessmentId: Int){
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        let drafts  = CoreDataHandlerPE().getDraftAssessmentArrayPEObject(ofCurrentAssessment:true)
        
        for obj in drafts {
            if obj.serverAssessmentId == String(assessmentId){
                let predicate = NSPredicate(format: "userID == %d AND serverAssessmentId == %d", userID, assessmentId)
                CoreDataHandlerPE().deleteExisitingData(entityName:"PE_AssessmentInDraft", predicate:predicate)
            }
        }
        
        let submited  = CoreDataHandlerPE().getSessionForViewAssessmentArrayPEObject(ofCurrentAssessment:true)
        
        for obj in submited {
            if obj.serverAssessmentId == String(assessmentId){
                let predicate = NSPredicate(format: "userID == %d AND serverAssessmentId == %d", userID, assessmentId)
                CoreDataHandlerPE().deleteExisitingData(entityName:"PE_AssessmentInOffline", predicate:predicate)
            }
        }
    }
    
    func getPlateTypes(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        var id = loginuserId//1667
        let url = ZoetisWebServices.EndPoint.getPlateTypes.latestUrl
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([PlateTypesDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                PlateTypesDAO.sharedInstance.savePlateTypes(userId: loginuserId, plateTypeDTO: vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }else{
                                completion("No Data Found", nil)
                            }
                            
                        }else{
                            completion("No Data Found", nil)
                        }
                        
                    }else{
                        completion("No Data Found", nil)
                    }
                    
                }else{
                    completion("No Data Found", nil)
                }
            }else{
                completion("No Data Found", nil)
            }
            
        })
    }
}
