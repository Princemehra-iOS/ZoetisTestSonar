//
//  DataService.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 03/04/20.
//  Copyright © 2020 Rishabh Gulati. All rights reserved.
//

import Foundation
import UIKit

class DataService{
    private init(){print("Initializer")}
    static let sharedInstance = DataService()
    
    func getScheduledCertifications(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        
        let url = ZoetisWebServices.EndPoint.getUpcomingCertifications.latestUrl + loginuserId
        debugPrint(url)
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([VaccinationCertificationsResponseDTO].self, from: data)
                            VaccinationDashboardDAO.sharedInstance.saveUpcomingCertifications(certificationDTOArr: vaccinationCertificationObj ?? [VaccinationCertificationsResponseDTO](), loginUserId: loginuserId)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }else{
                                completion("No Data Found", nil)
                            }
                        }
                    }
                }
            }
            else{
                completion("No Data Found", nil)
            }
        })
    }
    
    func getCertificationMasterQuestions(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        let url = ZoetisWebServices.EndPoint.getQuestionsMasterData.latestUrl
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else{ completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationMasterQuestionsResponseObj = try? jsonDecoder.decode(CertificationQuestionTypesDTO.self, from: data)
                            if vaccinationMasterQuestionsResponseObj != nil{
                                QuestionnaireDAO.sharedInstance.saveQuestionData(dtoObj: vaccinationMasterQuestionsResponseObj!, userId: loginuserId)
                            }
                            completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            
                        }
                    }
                    
                }
            }
        })
    }
    
    func getDropdownMasterData(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        let url = ZoetisWebServices.EndPoint.getVaccinationMasterDropdowndata.latestUrl
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationMasterQuestionsResponseObj = try? jsonDecoder.decode(MasterDataTypesDTO.self, from: data)
                            if vaccinationMasterQuestionsResponseObj != nil{
                                AddEmployeesDAO.sharedInstance.saveDropdownMasterData(dtoObj:vaccinationMasterQuestionsResponseObj! , loginUserId: loginuserId)
                            }
                            completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                        }
                    }
                    
                }
            }
        })
        
        
    }
    
    func getEmployeesById(loginuserId:String, viewController:UIViewController, customerId:String, siteId:String, completion: @escaping (String?, NSError?) -> Void){
        let url = ZoetisWebServices.EndPoint.getEmployessById.latestUrl + "?customerId=\(customerId)&siteId=\(siteId)"
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let employeesArr = try? jsonDecoder.decode([EmployeesInformationDTO].self, from: data)
                            if employeesArr != nil{
                                AddEmployeesDAO.sharedInstance.saveEmployees(loginUserId: loginuserId, customerId: customerId, siteId: siteId, empoyeeDTO: employeesArr!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                            
                            
                            
                        }
                    }
                    
                }
            }
        })
        
    }
    
    func getFilledCertObj(certificationId:String, userId:String, siteId:String, customerId:String, fssId: Int = 0 , FsrId: String, trainingId: Int = 0)-> [String:Any]?{
        let mainCertObj = VaccinationCertificationDetail()
        let vacStartedCertObj = VaccinationDashboardDAO.sharedInstance.getStartedCertStatusMoObj(userId:userId , certificationId: certificationId)
        mainCertObj.OperatorInfo = fillOperatorInfo(certificationId:certificationId, userId:userId, customerId: customerId, siteId: siteId)
        mainCertObj.QuestionAnswer = fillQuestionAnsData(certificationId:certificationId, userId:userId)
        if vacStartedCertObj?.certificationCategoryId != "1" {
            if trainingId != 0 {
                mainCertObj.VacOperatorFSSgAddress = fillShippingAddressInfo(certificationId:certificationId, userId:userId, customerId: customerId, siteId: siteId, fssId: fssId , fsrId: FsrId, trainingId: trainingId )
            } else {
                mainCertObj.VacOperatorFSSgAddress = fillShippingAddressInfo(certificationId:certificationId, userId:userId, customerId: customerId, siteId: siteId, fssId: fssId , fsrId: FsrId )
            }
        }
        else {
            mainCertObj.VacOperatorFSSgAddress = []
        }
        
        
        if let userId = UserContext.sharedInstance.userDetailsObj?.userId{
            if userId != ""{
                mainCertObj.CreatedBy = Int64(userId)
            }
        }
        if certificationId != ""{
            mainCertObj.Id = Int64(certificationId)
        }
        if customerId != ""{
            mainCertObj.CustomerId = Int64(customerId)
        }
        if let  vacObj = vacStartedCertObj{
            if vacObj.siteid != nil {
                mainCertObj.SiteId = Int64(vacObj.siteid!)
            }
            if vacObj.certificationCategoryId == "1"{
                mainCertObj.OperatorCertificate = false
                mainCertObj.Cretification_Type_Id = 2
            }else{
                mainCertObj.OperatorCertificate = true
                mainCertObj.Cretification_Type_Id = 1
            }
            
            mainCertObj.SiteName = vacObj.siteName
            mainCertObj.AssignToName = vacObj.assignedName
            
            if vacObj.assignedTo != nil &&   vacObj.assignedTo != ""{
                mainCertObj.AssingToId = Int64(vacObj.assignedTo!)
            }
            if vacObj.certificationTypeId != nil && vacObj.certificationTypeId != ""{
                mainCertObj.CertificateTypeId = Int64(vacObj.certificationTypeId!)
            }
            mainCertObj.AssingToId = Int64(userId)
            mainCertObj.CustShipping = vacObj.custShippingNum
            mainCertObj.ExistingSite = vacObj.isExistingSite as? Bool
            if vacObj.certificationCategoryId == "1"{
                mainCertObj.OperatorCertificate = false
            } else{
                mainCertObj.OperatorCertificate = true
            }
            
            if vacObj.certificationStatus == VaccinationCertificationStatus.draft.rawValue{
                mainCertObj.TrainingStatus = "Draft"
                mainCertObj.TrainingStatusId = 2
            }else if vacObj.certificationStatus == VaccinationCertificationStatus.submitted.rawValue{
                mainCertObj.IsAcknowledge = true
                if (UserContext.sharedInstance.userDetailsObj?.roleId?.contains(VaccinationConstants.Roles.ROLE_FSM_ID) ?? false || UserContext.sharedInstance.userDetailsObj?.roleId?.contains(VaccinationConstants.Roles.ROLE_TSR_ID) ?? false ){
                    mainCertObj.TrainingStatus = "Approved"
                    mainCertObj.TrainingStatusId = 4
                }else{
                    
                    if mainCertObj.OperatorCertificate{
                        mainCertObj.TrainingStatus = "Submitted"
                        mainCertObj.TrainingStatusId = 3
                    }else{
                        mainCertObj.TrainingStatus = "Approved"
                        mainCertObj.TrainingStatusId = 4
                    }
                }
            }else{
                mainCertObj.TrainingStatus = "Scheduled"
                mainCertObj.TrainingStatusId = 1
            }
            let dateFormatterObj = DateFormatter()
            
            dateFormatterObj.timeZone = Calendar.current.timeZone
            dateFormatterObj.locale = Calendar.current.locale
            dateFormatterObj.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            if let submittedDate = vacObj.submittedDate{
                mainCertObj.SubmitedDate = dateFormatterObj.string(from:submittedDate )
            }
            
            mainCertObj.GpColleagueName = vacObj.colleagueName
            mainCertObj.GpColleagueJobTitle = vacObj.colleagueJobTitle
            mainCertObj.GpSupervisorName = vacObj.supervisorName
            mainCertObj.GpSupervisorJobTitle = vacObj.supervisorJobTitle
            
            mainCertObj.HatcheryManagerName = vacObj.hatcheryManager
            mainCertObj.FSRSignature = vacObj.fsrSign
            mainCertObj.ApprovedRejectedById = vacObj.approvedRejectedById
            mainCertObj.ApproverId = vacObj.approvedRejectedById
            if mainCertObj.FSRSignature != nil && mainCertObj.FSRSignature != ""{
                mainCertObj.IsAcknowledge = true
            }
            
            if vacObj.hatcheryManagerSign != nil && vacObj.hatcheryManagerSign != ""{
                mainCertObj.IsAcknowledge = true
            }
            mainCertObj.HatcheryManagerSignature = vacObj.hatcheryManagerSign
            
            
            var formattedDateString = ""
            if let date = dateFormatterObj.date(from: vacObj.scheduledDate ?? "") {
                
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "MM/dd/YYYY"
    
                formattedDateString = outputDateFormatter.string(from: date)
                debugPrint("Formatted Date String: \(formattedDateString)")
            } else {
                debugPrint("Failed to convert the original date string.")
            }
            
            
            
            if let scheduledDate = vacObj.scheduledDate{
                mainCertObj.ScheduleDate = formattedDateString // dateFormatterObj.string(from: scheduledDate)
            }
            
            mainCertObj.ScheduleDate = vacObj.scheduledDate
            mainCertObj.CustomerName = vacObj.customerName
            if !(vacObj.deviceId != nil &&  vacObj.deviceId != ""){
                mainCertObj.DeviceId = getDeviceId(dateObj: vacObj.createdDate ?? (vacObj.submittedDate ?? Date() ), id: vacObj.certificationId ?? "")
                vacStartedCertObj?.deviceId = mainCertObj.DeviceId
                for value in mainCertObj.VacOperatorFSSgAddress! {
                    vacStartedCertObj?.fssId = NSNumber(value: value.fssID ?? 0)
                }
                VaccinationDashboardDAO.sharedInstance.saveCertStartedObj(moObj:vacStartedCertObj! )
            } else{
                mainCertObj.DeviceId =   vacObj.deviceId
            }
        }
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(mainCertObj)
        if data != nil{
            let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            do{
                let jsonDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                debugPrint(jsonDict)
                return jsonDict
            } catch{
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    func getDeviceId(dateObj:Date, id:String)-> String{
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier") ?? ""
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "MMddYYYYHHmmss"
        let dateStr = dateFormatter.string(from:dateObj)
        
        // var dateTimeOfAssessment = dateTimeOfAssessment  (format: )
        let deviceIdForServer = "\(dateStr)_\(id)_iOS_\(udid)"
        return deviceIdForServer
    }
    
    func postCertifications(loginuserId:String, viewController:UIViewController, param:[String:Any], completion: @escaping (String?, NSError?) -> Void){
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject:param, options:[])
            let jsonDataString = String(data: jsonData, encoding: String.Encoding.utf8)!
            print("Post Request Params : \(jsonDataString)")
        } catch {
            // // print("JSON serialization failed:  \(error)")
        }
        
        let url = ZoetisWebServices.EndPoint.postvaccinationCertification.latestUrl
        ZoetisWebServices.shared.sendPostDataToServerVaccination(controller: viewController, parameters: param as JSONDictionary, url: url,  completion: {
            [weak self] (json, error) in
            guard let `self` = self, error == nil else { completion(nil, error) ;return  ;}
            if json["StatusCode"]  == 200{
                completion("SUCCESS", nil)
            } else {
                completion("FAILURE", nil)
            }
        })
    }
    
    func postNewCertifications(loginuserId:String, viewController:UIViewController, param:[String:Any], completion: @escaping (String?, NSError?) -> Void){
        let url = ZoetisWebServices.EndPoint.postNewvaccinationCertification.latestUrl
        var jsonDict : NSDictionary!
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject:param, options:[])
            let jsonDataString = String(data: jsonData, encoding: String.Encoding.utf8)!
          //  print(<#T##Any...#>)
            print("Post Request Params : \(jsonDataString)")
        } catch {
            // // print("JSON serialization failed:  \(error)")
        }
        ZoetisWebServices.shared.sendPostDataToServerVaccination(controller: viewController, parameters: param as JSONDictionary, url: url,  completion: {
            [weak self] (json, error) in
            guard let `self` = self, error == nil else { completion(nil, error) ;return  ;}
            if json["StatusCode"]  == 200{
                completion("SUCCESS", nil)
            } else {
                completion("FAILURE", nil)
            }
        })
    }
    
    func fillShippingAddressInfo(certificationId:String, userId:String, customerId:String, siteId:String, fssId: Int , fsrId: String, trainingId: Int = 0) ->[ShippingAddressDTO]?{
        var shippingArr  = [ShippingAddressDTO]()
        if trainingId != 0  {
            let shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfoByTrainingId(trainingId: trainingId)
            if shippingInfoDB != nil {
                shippingArr.append(shippingInfoDB!)
            }
        }
        else {
            let shippingInfoDB = VaccinationCustomersDAO.sharedInstance.fetchShippingInfo(fssId: fssId, FsrId: Int(fsrId) ?? 0)
            if fssId == 0
            {
                shippingInfoDB?.id = 0
            }
            else
            {
                shippingInfoDB?.id =  Int(certificationId) ?? 0
            }
            
            if let id = shippingInfoDB?.fssID {
                
                print("ID is: \(id)")
            } else {
            }
            shippingInfoDB?.trainingID =  Int(certificationId) ?? 0
            if shippingInfoDB != nil {
                shippingArr.append(shippingInfoDB!)
            }
        }
        return shippingArr
        
        
    }
    
    func fillOperatorInfo(certificationId:String, userId:String, customerId:String, siteId:String)->[OperatorInfoDTO]?{
        var operatorArr = [OperatorInfoDTO]()
        let moObjArr:[VaccinationEmployeeVM] = AddEmployeesDAO.sharedInstance.getAllCertEmployees(userId: userId, certificationId: certificationId)
        if moObjArr.count > 0{
            for moObj in moObjArr{
                let operatorObj = OperatorInfoDTO()
                if moObj.employeeId != nil && moObj.employeeId != ""{
                    operatorObj.Id = Int64.init(moObj.employeeId!)
                    operatorObj.OperatorUniqueId = moObj.employeeId
                }
                operatorObj.FirstName = moObj.firstName
                operatorObj.MiddleName = moObj.middleName
                operatorObj.LastName = moObj.lastName
                if userId != ""{
                    operatorObj.CreatedBy = Int64.init(userId)
                }
                operatorObj.CustomerId = Int64(customerId)
                operatorObj.SiteId = Int64(siteId)
                operatorObj.OperatorSignature = moObj.signBase64
                if moObj.selectedLangId != ""{
                    operatorObj.LanguageId = Int64(moObj.selectedLangId)
                }
                if let selectedTshirtId = moObj.selectedTshirtId{
                    operatorObj.TshirtSizeId = Int64(selectedTshirtId)
                }
                let selectedValueObjStr = moObj.rolesArrStr
                var selectedRoleArr = [DropwnMasterDataVM]()
                if selectedValueObjStr != "" && selectedValueObjStr != nil{
                    
                    let data = selectedValueObjStr?.data(using: .utf8)
                    let decoder = JSONDecoder()
                    do{
                        if data != nil{
                            selectedRoleArr =  try decoder.decode([DropwnMasterDataVM].self, from: data!)
                            var roleDTOArr = [RolesTransferDTO]()
                            for role in selectedRoleArr{
                                roleDTOArr.append(fillRolesObj(role))
                            }
                            operatorObj.Roles = roleDTOArr
                        }
                    } catch{
                        
                    }
                    
                    
                    let dateFormatterObj = DateFormatter()
                    dateFormatterObj.timeZone = Calendar.current.timeZone
                    dateFormatterObj.locale = Calendar.current.locale
                    dateFormatterObj.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    operatorObj.FromDate = moObj.startDate
                    operatorArr.append(operatorObj)
                }
            }
        }
        if operatorArr.count > 0{
            return operatorArr
        }
        return nil
    }
    
    
    func fillRolesObj(_ roleVMObj: DropwnMasterDataVM)-> RolesTransferDTO{
        let rolesDTO = RolesTransferDTO()
        if roleVMObj.id != nil && roleVMObj.id != ""{
            rolesDTO.RoleId = Int64(roleVMObj.id!)
        }
        
        rolesDTO.RoleName = roleVMObj.value
        rolesDTO.IsSelected = roleVMObj.isSelected
        return rolesDTO
    }
    
    
    func fillQuestionAnsData(certificationId:String, userId:String) -> [QuestionAnswerDTO]?{
        var questionArr = [QuestionAnswerDTO]()
        let questionnaireVMObj = UserFilledQuestionnaireDAO.sharedInstance.fetchQuestionnaireData(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", certificationId: certificationId )
        
        if questionnaireVMObj?.questionTypeObj != nil && (questionnaireVMObj?.questionTypeObj?.count)! > 0{
            for qustionTypeObj in (questionnaireVMObj?.questionTypeObj)!{
                if qustionTypeObj.questionCategories != nil && qustionTypeObj.questionCategories!.count > 0{
                    for categoryObj in qustionTypeObj.questionCategories!{
                        let questionAnswerDTO =  QuestionAnswerDTO()
                        if categoryObj.categoryId != nil && categoryObj.categoryId != ""
                        {
                            questionAnswerDTO.catId = Int64(categoryObj.categoryId!)
                        }
                        if categoryObj.typeId != nil && categoryObj.typeId != ""
                        {
                            questionAnswerDTO.TypeId = Int64(categoryObj.typeId!)
                        }
                        
                        questionAnswerDTO.CategorieName = categoryObj.categoryName
                        var moduleAssessmentArr =  [ModuleAssessmentsCertDTO]()
                        if categoryObj.questionArr != nil && categoryObj.questionArr!.count > 0{
                            for questionObj in categoryObj.questionArr!{
                                let  moduleAssObj = ModuleAssessmentsCertDTO()
                                if questionObj.questionId != nil && questionObj.questionId != ""{
                                    moduleAssObj.Assessment_Id = Int64( questionObj.questionId!)
                                }
                                if certificationId != ""{
                                    moduleAssObj.TrainingScheduleId = Int64(certificationId)
                                }
                                
                                moduleAssObj.Answer = questionObj.selectedResponse
                                moduleAssObj.LocationPhone = questionObj.locationPhone
                                moduleAssObj.SequenceNo = Int( questionObj.sequenceNo ?? 0)
                                if questionObj.categoryId != nil && questionObj.categoryId != ""{
                                    moduleAssObj.ModuleCatId = Int64(questionObj.categoryId!)
                                }
                                
                                moduleAssObj.Comments = questionObj.userComments
                                moduleAssessmentArr.append(moduleAssObj)
                            }
                        }
                        questionAnswerDTO.ModuleAssessments = moduleAssessmentArr
                        
                        var attendeeDetails = [AddAttendeeDetailsDTO]()
                        if let employees =  categoryObj.employees{
                            if employees.count > 0{
                                for categoryEmp in employees{
                                    let attendeeObj =  AddAttendeeDetailsDTO()
                                    if userId != nil && userId != ""{
                                        attendeeObj.CreatedBy = Int64(userId)
                                    }
                                    if categoryObj.categoryId != nil && categoryObj.categoryId != ""{
                                        attendeeObj.ModuleCatId = Int64(categoryObj.categoryId!)
                                    }
                                    if certificationId != nil && certificationId != ""{
                                        attendeeObj.TrainingId = Int64(certificationId)
                                    }
                                    if certificationId != nil && certificationId != ""{
                                        attendeeObj.TrainingId = Int64(certificationId)
                                    }
                                    if categoryEmp.employeeId != nil && categoryEmp.employeeId != ""{
                                        attendeeObj.OperatorId = Int64(categoryEmp.employeeId!)
                                        attendeeObj.OperatorUniqueId = categoryEmp.employeeId
                                    }
                                    
                                    attendeeDetails.append(attendeeObj)
                                }
                            }
                            
                        }
                        questionAnswerDTO.AddAttendeeDetails = attendeeDetails
                        questionArr.append(questionAnswerDTO)
                    }
                    
                }
            }
        }
        
        if questionArr.count > 0{
            return questionArr
        }
        return nil
    }
    
    func getVaccinationCustomers(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        
        let url = ZoetisWebServices.EndPoint.getCustomersByUserId.latestUrl + loginuserId
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: {
            [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([CustomerDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.insertCustomers(userId: loginuserId, customerDTOArr: vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                        }
                    }
                    
                }else{
                    
                }
            }
            
            
            
        })
    }
    
    
    func getVaccinationCustomerSites(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        
        let customers = VaccinationCustomersDAO.sharedInstance.getCustomersVM(userId: loginuserId)
        let customerIdsStr = customers.map{ $0.customerId ?? ""}.joined(separator: ",")
        
        let url = ZoetisWebServices.EndPoint.getSiteByCustomerIds.latestUrl + customerIdsStr
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([CustomerSitesDTO].self, from: data)
                            
                            
                            //  print(vaccinationCertificationObj!.count)// ?? 100)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.insertCustomerSites(userId: loginuserId
                                                                                           , customerDTOArr: vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
        })
    }
    
    func getVaccinationFSMList(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = ZoetisWebServices.EndPoint.getFSMList.latestUrl + String(countryId)
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([FSMListDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.insertFSMList(userId: loginuserId, FSMListDTOArr:vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                        }
                    }
                    
                }
            }
            
        })
    }
    
    
    
    
    
    
    func getVaccinationStateList(countryId: String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        // let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = ZoetisWebServices.EndPoint.getStateList.latestUrl + String(countryId)
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([StateListDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.insertStateList(userId: UserContext.sharedInstance.userDetailsObj?.userId ?? "", StateListDTOArr:vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                        }
                    }
                    
                }
            }
            
        })
    }
    
    
    
    func getVaccinationCountryList(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        
        let url = ZoetisWebServices.EndPoint.getPECountry.latestUrl
        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let vaccinationCertificationObj = try? jsonDecoder.decode([CountryListDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.insertCountryList(userId: loginuserId, CountryListDTOArr:vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                        }
                    }
                    
                }
            }
            
        })
    }
    
    
    //GetSubmittedCertificationsDTO
    func getSubmittedCertifications(loginuserId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        let url = ZoetisWebServices.EndPoint.getSubmittedCertifications.latestUrl + loginuserId
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            _ = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                            do {
                                let model = try JSONDecoder().decode([GetSubmittedCertificationsDTO].self, from: data)
                                debugPrint(model)
                            }
                            catch {
                                //print(error.localizedDescription)
                                debugPrint(String(describing: error))
                            }
                            let vaccinationCertificationObj = try? jsonDecoder.decode([GetSubmittedCertificationsDTO].self, from: data)
                            if  vaccinationCertificationObj != nil && vaccinationCertificationObj?.count ?? 0 > 0{
                                VaccinationCustomersDAO.sharedInstance.deleteAllData("VaccinationStartedCertifications")
                                VaccinationCustomersDAO.sharedInstance.deleteAllData("VaccinationShippingAddress")
                                SubmittedCertificationsService.sharedInstance.insertData(userId: loginuserId, vaccinationCertificationObj!)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                            completion("No Data Found", nil)
                            
                        }
                        
                    }
                    
                }
            }
            
        })
    }
    
    
    func getShippingDetails(loginuserId:String, SelectedFsmId:String, viewController:UIViewController, completion: @escaping (String?, NSError?) -> Void){
        
        let url = ZoetisWebServices.EndPoint.getShippingAddressDetails.latestUrl + SelectedFsmId        
        ZoetisWebServices.shared.getVaccinationServicesResponse(controller: viewController, url: url, completion: { [weak self] (json, error) in
            guard let _ = self, error == nil else { completion(nil, error) ;return  ;}
            if let responseJSONDict = json.dictionary{
                if let response = responseJSONDict["Data"]{
                    if response == [] {
                        return
                    }
                    let jsonDecoder = JSONDecoder()
                    let responseStr = response.description
                    if responseStr != ""{
                        let jsonData = try? Data(responseStr.utf8 )
                        if let data = jsonData{
                            let shippingInfoObj = try? jsonDecoder.decode([ShippingAddressDTO].self, from: data)
                            if  shippingInfoObj != nil && shippingInfoObj?.count ?? 0 > 0{
                                
                                if shippingInfoObj?[0].fssID == 0{
                                    VaccinationCustomersDAO.sharedInstance.deleteShippingInfoByFssId(shippingInfoObj?[0].fssID ?? 0)
                                }
                                else
                                {
                                    VaccinationCustomersDAO.sharedInstance.deleteShippingInfoByFssId(Int(SelectedFsmId) ?? 0)
                                }
                                
                                UserDefaults.standard.setValue(shippingInfoObj?[0].countryID, forKey: "countryId")
                                VaccinationCustomersDAO.sharedInstance.saveShippingInfoInDB(newAssessment: shippingInfoObj)
                                completion(VaccinationConstants.VaccinationStatus.COREDATA_SAVED_SUCCESSFULLY, nil)
                            }
                        }
                    }
                    
                }
            }
            
        })
    }
    
    
}


