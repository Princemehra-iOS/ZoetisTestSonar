//  Zoetis -Feathers
//
//  Created by "" ""on 08/11/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import MBProgressHUD

typealias CompletionBlock = (JSON, NSError?) -> Void

class ZoetisWebServices: BaseViewController {
    
    static let shared = ZoetisWebServices()
    var viewController = UIViewController()
    let languageIdStr = "&LanguageId=1"
    let countryIdStr = "&CountryId="
    let regionIdStr = "&RegionId="
    enum EndPoint: String {
        case login = "Token"
        //        case getPostingSessionList = "/ProcessEvaluation/API/api/PostingSession/GetPostingSessionListByUser?UserId="
        //        case getAllCustomerPE = "/ProcessEvaluation/API/api/Assessment/GetAllCustomer_PE"
        //        case getPEDosages = "/ProcessEvaluation/API/api/Assessment/GetPEDosages"
        //        case getCustomerPE = "/ProcessEvaluation/API/api/Assessment/GetAssignedCustomerByUser?userId="
        //        case getSitesPE = "/ProcessEvaluation/API/api/Assessment/GetAssignedSitesByUser?userId="
        //        case getApproversPE = "/ProcessEvaluation/API/api/Assessment/GetTSRUser"
        //        case getEvaluator = "/ProcessEvaluation/API/api/Assessment/GetEvaluator?CountryId="
        //        case getVisitTypes = "/ProcessEvaluation/API/api/Assessment/GetReasonForVisitTypes"
        //        case getEvaluatorTypes = "/ProcessEvaluation/API/api/Assessment/GetEvaluationTypes"
        //        case getManufacturer = "/ProcessEvaluation/API/api/Assessment/GetManufacturer"
        //        case getBirdBreed = "/ProcessEvaluation/API/api/Assessment/GetBirdBreeds"
        //        case getEggs = "/ProcessEvaluation/API/api/Assessment/GetEggsPerFlat"
        //        case getVaccineManufacturer = "/ProcessEvaluation/API/api/Assessment/GetVaccineManufacturer"
        //        case getVaccineNames = "/ProcessEvaluation/API/api/Assessment/GetVaccineNames"
        //
        //         case getSubVaccineNames = "/ProcessEvaluation/API/api/Assessment/GetVaccineNamesSubcutaneous"
        //        case getDiluentManufacturer = "/ProcessEvaluation/API/api/Assessment/DiluentManufacturer"
        //        case getbagSizes = "/ProcessEvaluation/API/api/Assessment/GetBagSizeTypes"
        //        case getAmplePerBag = "/ProcessEvaluation/API/api/Assessment/GetAmpulePerBag"
        //        case getAmpleSizes = "/ProcessEvaluation/API/api/Assessment/GetAmpuleSizes"
        //        case getPERoles = "/ProcessEvaluation/API/api/Assessment/GetRoles"
        //        case getPEFrequency = "/ProcessEvaluation/API/api/Assessment/GetAssessmentFreuqncies"
        //
        //        case getPEDOADiluentType = "/ProcessEvaluation/API/api/Assessment/GetDayOfAgeDiluentType"
        //        case getIncubationStyle = "/ProcessEvaluation/API/api/Assessment/GetIncubationStyles"
        //        case getPEDOASizes = "/ProcessEvaluation/API/api/Assessment/GetDayOfAgeBagSizeTypes"
        ////      New
        //        case getDuplicacyCheck = "/ProcessEvaluation/API/api/Assessment/DuplicateAssessmentcheck"
        //
        //        case getPostingAssessmentListByUserPE = "/ProcessEvaluation/API/api/Assessment/GetPostingAssessmentListByUser?UserId="
        //        case getPostingAssessmentImagesListByUserPE = "/ProcessEvaluation/API/api/AssessmentImage/GetPostingAssessmentImagesListByUser?UserId="
        //        case getModuleAssessmentCategoriesDetailsPE = "/ProcessEvaluation/API/api/Assessment/GetQuestionAnswerCategories?"
        //        case getAssessmentQuesInfoPE = "/ProcessEvaluation/API/api/Assessment/GetAssessmentInfosDetails"
        //        case postAddAttachmentDetails = "/ProcessEvaluation/API/api/Assessment/AddAssessment"
        //        case postAddScores = "/ProcessEvaluation/API/api/Assessment/AddScores"
        //          case postAddDayOfAgeAndInvoject = "/ProcessEvaluation/API/api/Assessment/AddInovojectDayOfAgeDetails"
        //        case postImagesBase64 = "/ProcessEvaluation/API/api/AssessmentImage/SaveAssessmentImagesDetails"
        //        case getPEScheduledCertifications = "/ProcessEvaluation/API/api/Assessment/GetAssessmentSchedulesListById/"
        //        case getPERejectedAssessment = "/ProcessEvaluation/API/api/Assessment/GetRejectedAssessmentListByUser?UserId="
        //        case getPERejectedAssessmentImages = "/ProcessEvaluation/API/api/AssessmentImage/GetAssessmentImageById?AssessmentId="
        //        case getPlateTypes = "/ProcessEvaluation/API/api/Assessment/GetPlateTypes"
        //        case deleteDrafts = "/ProcessEvaluation/API/api/Assessment/DeleteDrafts?draftIds="
        //        case postUpdateStatus = "/ProcessEvaluation/API/api/Assessment/updateStatusType?assessmentId="
        //
        //********************************Master Data Update*******************
        
        case getMasterDataVersion = "/api/UserManagement/GetMasterTableDataVersion"
        
        //********************************PE Migration**************************
                                   
        case getPostingSessionList = "/api/PostingSession/GetPostingSessionListByUser?UserId="
        case getAllCustomerPE = "/api/Assessment/GetAllCustomer_PE"
        case getPEDosages = "/api/Assessment/GetPEDosages"
        case getCustomerPE = "/api/Assessment/GetAssignedCustomerByUser?userId="
        case getSitesPE = "/api/Assessment/GetAssignedSitesByUser?userId="
        case getApproversPE = "/api/Assessment/GetTSRUser?CountryId="
        case getEvaluator = "/api/Assessment/GetEvaluator?CountryId="
        case getVisitTypes = "/api/Assessment/GetReasonForVisitTypes"
        case getEvaluatorTypes = "/api/Assessment/GetEvaluationTypes?userId="
        case getManufacturer = "/api/Assessment/GetManufacturer"
        case getBirdBreed = "/api/Assessment/GetBirdBreeds?userId="
        case getEggs = "/api/Assessment/GetEggsPerFlat"
        case getVaccineManufacturer = "/api/Assessment/GetVaccineManufacturer?userId="
        case getVaccineNames = "/api/Assessment/GetVaccineNames?userId="
        case getSubVaccineNames = "/api/Assessment/GetVaccineNamesSubcutaneous?userId="
        case getDiluentManufacturer = "/api/Assessment/DiluentManufacturer"
        case getbagSizes = "/api/Assessment/GetBagSizeTypes"
        case getAmplePerBag = "/api/Assessment/GetAmpulePerBag"
        case getAmpleSizes = "/api/Assessment/GetAmpuleSizes"
        case getPERoles = "/api/Assessment/GetRoles?"
        case getPEFrequency = "/api/Assessment/GetAssessmentFreuqncies"
        case getPECountry = "/api/Assessment/GetCountry"
        case getPEDOADiluentType = "/api/Assessment/GetDayOfAgeDiluentType"
        case getIncubationStyle = "/api/Assessment/GetIncubationStyles"
        case getPEDOASizes = "/api/Assessment/GetDayOfAgeBagSizeTypes?"
        case getPEClorine = "/api/Assessment/GetChlorineTypes?"
        
        //      New
        case getDuplicacyCheck = "/api/Assessment/DuplicateAssessmentcheck"
        case getPostingAssessmentListByUserPE = "/api/Assessment/GetPostingAssessmentListByUser?UserId="
        case getPostingAssessmentImagesListByUserPE = "/api/AssessmentImage/GetPostingAssessmentImagesListByUser?UserId="
        case getModuleAssessmentCategoriesDetailsPE = "/api/Assessment/GetQuestionAnswerCategories?"
        case getAssessmentQuesInfoPE = "/api/Assessment/GetAssessmentInfosDetails"
        case postAddAttachmentDetails = "/api/Assessment/AddAssessment"
        case postAddScores = "/api/Assessment/AddScores"
        case postAddDayOfAgeAndInvoject = "/api/Assessment/AddInovojectDayOfAgeDetails"
        case postImagesBase64 = "/api/AssessmentImage/SaveAssessmentImagesDetails"
        case getPEScheduledCertifications = "/api/Assessment/GetAssessmentSchedulesListById/"
        case getPERejectedAssessment = "/api/Assessment/GetRejectedAssessmentListByUser?UserId="
        case getPERejectedAssessmentImages = "/api/AssessmentImage/GetAssessmentImageById?AssessmentId="
        case getPlateTypes = "/api/Assessment/GetPlateTypes"
        case deleteDrafts = "/api/Assessment/DeleteDrafts?draftIds="
        case postUpdateStatus = "/api/Assessment/updateStatusType?assessmentId="
        case getAppVersion = "/api/user/GetAppversion?Versionno="
        case getAssessmentStatus = "/api/Assessment/GetAssessmentStatusType?AssessmentId="
        case getVaccineMixerList = "/api/Assessment/GetVaccineMixerOperatorNames?CustomerId="
        case finalAssessmentStatus = "/api/Assessment/FinalAssessmentStatus_V2"
        case postExtendedMicro = "/api/Assessment/AddEMAssessment"
        case getGigyaCountries = "/api/Login/GetCountrys"
        case getGigyaCountryLanguages = "/api/Login/GetLanguage?"
        case getGigyaApiKeys = "/api/Login/GetGigyaApiKeys?"
        //&StatusType=1
        //PVE--------------------
        /* Dev */
        ///*
        
        case getCustomerListPVE = "/api/CustomerDetails/GetAssignedCustomerByUser?userId="
        case getComplexPVEOld = "/api/ComplexDetails?customerId="
        case getComplexPVE = "/api/ComplexDetails?"
        case getEvaluationTypePVE = "/api/EvaluationDetails/GetEvaluationType?Module_Id=2"
        case getEvaluationForPVE = "/api/EvaluationDetails/GetEvaluationFor"
        case getSiteIDNameDetailsPVE = "/api/HatcherySitesDetails"
        case getBirdAgeDetailsPVE = "/api/BirdAgeDetails"
        case getBirdBreedsDetailsPVE = "/api/BirdBreedsDetails/GetBirdBreeds"
        case getHousingDetailsPVE = "/api/HousingDetails"
        case getAssignUserDetailPVE = "/api/AssignUserDetails/GetAccountManagerList"
        case getEvaluatorDetailPVE = "/api/UserDetails/GetEvaluator"
        case getModuleAssessmentCategoriesDetailsPVE = "/api/ModuleAssessmentCategoriesDetails/GetModuleAssessmentCategoriesDetails?Module_Id=2"
        case getModuleAssessmentsPVE = "/api/ModuleAssessmentsDetails?Module_Cat_Id="
        case getSerotypeDetailsPVE = "/api/VaccineNamesDetails/GetAntigen"
        case getSurveyTypeDetailsPVE = "/api/SurveyTypeDetails"
        case getSiteInjctsDetailssPVE = "/api/SiteInjctsDetails"
        case getVaccineManDetailsPVE = "/api/VaccineManDetails"
        case getVaccineNamesDetailsPVE = "/api/VaccineNamesDetails/GetVaccineNamesDetails?api_key=GetPostingAssessmentListByUs"
        case getPostingAssessmentListByUser = "/api/AssignUserDetails/GetPostingAssessmentListByUser"
        case getBlankAssessmentFiles = "/api/Assessment/GetBlankAssessmentFiles"
        case getDownloadBlankFile = "/api/Assessment/GetDownloadBlankFile?"
        
      
        case getPostingAssessmentImagesListByUser = "/api/AssignUserDetails/GetPostingAssessmentImagesListByUser?DeviceType=ios&api_key=GetPostingAssessmentListByUser"
        case postSNADetailsPVE = "/api/AssessmentDetails/CreateAssessmentDetails"
        case postScoreDetailsPVE = "/api/AssessmentDetails/SaveAssessmentScoresDetails"
        case postSaveAssessmentImagesDetailsPVE = "/api/AssessmentDetails/SaveAssessmentImagesDetails"
        case postPDFPVE = "/api/VaccineNamesDetails/GetPdfReport?ReportType=1"
        case postPDFPVENotBlank = "/api/VaccineNamesDetails/GetPdfReport?ReportType=0"
        case getPostingAssessmentCompleteImagesListByUser = "/api/AssignUserDetails/GetPostingAssessmentCompleteImagesListByUser?DeviceType=ios&api_key=GetPostingAssessmentListByUser"
        
        //*/
        
        //Staging
        
        //         case getCustomerListPVE = "/PulletVaccineEvaluation/API/api/CustomerDetails/GetAssignedCustomerByUser?userId="
        //          case getComplexPVEOld = "/PulletVaccineEvaluation/API/api/ComplexDetails?customerId="
        //          case getComplexPVE = "/PulletVaccineEvaluation/API/api/ComplexDetails?"
        //          case getEvaluationTypePVE = "/PulletVaccineEvaluation/API/api/EvaluationDetails/GetEvaluationType?Module_Id=2"
        //          case getEvaluationForPVE = "/PulletVaccineEvaluation/API/api/EvaluationDetails/GetEvaluationFor"
        //          case getSiteIDNameDetailsPVE = "/PulletVaccineEvaluation/API/api/HatcherySitesDetails"
        //          case getBirdAgeDetailsPVE = "/PulletVaccineEvaluation/API/api/BirdAgeDetails"
        //         case getBirdBreedsDetailsPVE = "/PulletVaccineEvaluation/API/api/BirdBreedsDetails/GetBirdBreeds"
        //          case getHousingDetailsPVE = "/PulletVaccineEvaluation/API/api/HousingDetails"
        //          case getAssignUserDetailPVE = "/PulletVaccineEvaluation/API/api/AssignUserDetails/GetAccountManagerList"
        //          case getEvaluatorDetailPVE = "/PulletVaccineEvaluation/API/api/UserDetails/GetEvaluator"
        //          case getModuleAssessmentCategoriesDetailsPVE = "/PulletVaccineEvaluation/API/api/ModuleAssessmentCategoriesDetails/GetModuleAssessmentCategoriesDetails?Module_Id=2"
        //          case getModuleAssessmentsPVE = "/PulletVaccineEvaluation/API/api/ModuleAssessmentsDetails?Module_Cat_Id="
        //          case getSerotypeDetailsPVE = "/PulletVaccineEvaluation/API/api/SerotypeDetails"
        //          case getSurveyTypeDetailsPVE = "/PulletVaccineEvaluation/API/api/SurveyTypeDetails"
        //          case getSiteInjctsDetailssPVE = "/PulletVaccineEvaluation/API/api/SiteInjctsDetails"
        //          case getVaccineManDetailsPVE = "/PulletVaccineEvaluation/API/api/VaccineManDetails"
        //         case getVaccineNamesDetailsPVE = "/PulletVaccineEvaluation/API/api/VaccineNamesDetails/GetVaccineNamesDetails?api_key=GetPostingAssessmentListByUs"
        //         case getPostingAssessmentListByUser = "/PulletVaccineEvaluation/API/api/AssignUserDetails/GetPostingAssessmentListByUser"
        //         case getPostingAssessmentImagesListByUser = "/PulletVaccineEvaluation/API/api/AssignUserDetails/GetPostingAssessmentImagesListByUser?DeviceType=ios&api_key=GetPostingAssessmentListByUser"
        //         case postSNADetailsPVE = "/PulletVaccineEvaluation/API/api/AssessmentDetails/CreateAssessmentDetails"
        //        case postScoreDetailsPVE = "/PulletVaccineEvaluation/API/api/AssessmentDetails/SaveAssessmentScoresDetails"
        //        case postSaveAssessmentImagesDetailsPVE = "/PulletVaccineEvaluation/API/api/AssessmentDetails/SaveAssessmentImagesDetails"
        
        
        ///Microbial-----------------------------
        case getAllEnvironmentalLocationTypes = "/api/MicrobialLocationTypes/AllMicrobiallEnvironmentalLocationTypes"
        case getAllBacterialLocationTypes = "/api/MicrobialLocationTypes/AllMicrobialBacterialLocationTypes"
        case getAllCustomersMicrobial = "/api/Customer/GetAllCustomersByUser?UserId="
        case getAllLocationValues = "/api/MicrobialLocationValues/AllMicrobialLocationValues"
        case getAllHatcherySiteMicrobial =  "/api/HatcherySites/GetAllHatcherySites"
        case getAllHatcheryReviewerMicrobial = "/api/Users/GetAllTsrUsers"
        case getAllHatcheryConductTypesMicrobial = "/api/MicrobialConductTypes/AllConductTypes"
        case getAllHatcheryPurposeOfSurveyURLPathMicrobial = "/api/MicrobialSurveyPurpose/AllSurveyPurpose"
        case getAllHatcheryAllTransferTypeURLPathMicrobial = "/api/MicrobialTransferTypes/AllMicrobialTransferTypes"
        case getAllHatcheryAllVisitTypeURLPathMicrobial = "/api/MicrobialVisitTypes/GetAllVisitTypes"
        case getAllMicrobialSpecimenTypes = "/api/MicrobialSpecimenType/AllMicrobialSpecimenTypes"
        case getAllMicrobialFeatherPulpTests = "/api/MicrobialFeatherPulpTests/AllMicrobialFeatherPulpTests"
        case getAllMicrobialBirdTypes = "/api/MicrobialBirdType/AllMicrobialBirdTypes"
        case syncEnvironmentalData = "/api/MicrobialEnvironmentalDetails/AddMicrobialEnvironmentalDetails"
        case syncBacterialData = "/api/MicrobialBacterialDetails/AddMicrobialBacterialDetails"
        case syncFeathurePulp = "/api/MicrobialFeatherPulpDetails/AddMicrobialFeatherPulpDetails"
        case getSyncedReqData = "/api/MicrobialDetails/GetDetailsByApiCount"
        case getAllCaseStatus = "/api/MicrobialCaseStatus/AllCaseStatus"
        case getAllMediaTypeValues = "/api/MicrobialMediaTypes/AllMicrobialMediaTypes"
        case getAllSamplingMethodList = "/api/MicrobialSamplingMethod/AllMicrobialSamplingMethod"
        
        
        //Microbial API's Finish
        
        //Vaccination API's
        
        //        case getUpcomingCertifications = "/ProcessEvaluation/API/api/VaccinationTraining/GetScheduleTrainingByFSRId/"
        //
        //        case getQuestionsMasterData = "/ProcessEvaluation/API/api/VaccinationTraining/GetCertificateQuestion"
        //
        //        case getVaccinationMasterDropdowndata = "/ProcessEvaluation/API/api/VaccinationTraining/GetlanguagesAndTshirtSizes"
        //
        //        case getEmployessById = "/ProcessEvaluation/API/api/VaccinationTraining/GetEmployeeList"
        //
        //        case getSiteByCustomerIds  = "/ProcessEvaluation/API/api/VaccinationTraining/GetCustomerListByCustomerlst?customerIds="
        //
        //        case getCustomersByUserId = "/ProcessEvaluation/API/api/VaccinationTraining/GetAssingedCustomerListByUser?userId="
        //
        //        case postvaccinationCertification = "/ProcessEvaluation/API/api/VaccinationTraining/SubmitTrainingDataSync"
        //
        //        case getSubmittedCertifications = "/ProcessEvaluation/API/api/VaccinationTraining/GetPostingCertificateByUserId?userId="
        //
        //        case getFSMList = "/ProcessEvaluation/API/api/VaccinationTraining/GetFSMList"
        
        //**********************Vaccine Migration API**********************
        
        case getUpcomingCertifications = "/api/VaccinationTraining/GetScheduleTrainingByFSRId/"
        
        case getQuestionsMasterData = "/api/VaccinationTraining/GetCertificateQuestion"
        
        case getVaccinationMasterDropdowndata = "/api/VaccinationTraining/GetlanguagesAndTshirtSizes"
        
        case getEmployessById = "/api/VaccinationTraining/GetEmployeeList"
        
        case getSiteByCustomerIds  = "/api/VaccinationTraining/GetCustomerListByCustomerlst?customerIds="
        
        case getCustomersByUserId = "/api/VaccinationTraining/GetAssingedCustomerListByUser?userId="
        
        case postvaccinationCertification = "/api/VaccinationTraining/SubmitTrainingDataSync"
        case postNewvaccinationCertification = "/api/VaccinationTraining/SubmitTrainingWithoutSchedule"
        case getSubmittedCertifications = "/api/VaccinationTraining/GetPostingCertificateByUserId?userId="
        
        case getFSMList = "/api/VaccinationTraining/GetFSMList?CountryId="
        
        case getStateList = "/api/Assessment/GetStates?CountryId="
        
       // case getShippingAddressDetails = "/api/VaccinationTraining/GetTrackingFSSAddress?userId="
        case getShippingAddressDetails = "/api/VaccinationTraining/GetTrackingFSSAddress?FSSId="
        
        
        //**********************Flock Health **********************
        
        case getNecropsyListForChicken = "/api/PostingSession/GetNecropsyListByUser?UserId="
        
        case getFlockFeedList = "/api/PostingSession/GetFeedListByUser?UserId="
        
        case getSubmitedPostingVaccinationData = "/api/PostingSession/GetVaccinationListByUser?UserId="
        
        case getSubmittedNotesForChicken = "/api/PostingSession/GetBirdNotesListByUser?UserId="
        
       case getNecropsyFarmListForChicken = "/api/PostingSession/GetFarmListByUser?UserId="
         
        case getNecropsySubmittedImagesforChicken = "/api/PostingSession/GetBirdImagesListByUser?UserId="
        
        case getTargetWeightForTurkey = "/api/PostingSession/GetTargetWeightProcessing"
        
        case getTurkeyCocciVaccine = "/api/PostingSession/GetCocciVaccine"
        
        case getChickenAndTurkeyComplexByUserId = "/api/PostingSession/GetComplexByUserId?UserId="
        
        case getTurkeySalesRepresentative = "/api/PostingSession/GetSalesRepresentativeBySubProductList?UserId="
        
        case getRoutes = "/api/PostingSession/GetRoute"
        
        case getTurkeyHatcheryStrain = "/api/PostingSession/GetHatcheryStrain"
        
        case getTurkeyFieldStrain = "/api/PostingSession/GetFieldStrain"
        
        case getTurkeyDosage = "/api/PostingSession/GetDosage"
        
        case getTurkeyGeneratiobnType = "/api/PostingSession/GetGeneration"
        
        case getTurkeyDosageByMoulecule = "/api/PostingSession/GetDosagebyMoleculeId"
        
        case getCustomerOfChickenAndTurkey = "/api/PostingSession/GetCustomerByUser?UserId="
        
        case getCocciProgram = "/api/PostingSession/GetCocciProgram"
        
        case getSessionType = "/api/PostingSession/GetSessionType"
        
        case getBirdSizeTurkey = "/api/PostingSession/GetBirdSize"
        
        case termAndCondtion = "/api/User/PostTermsAccepted"
        
        case getBirdBreedChickenAndTurkey = "/api/PostingSession/GetBirdBreed"
        
        case GetFeedProgramCatagoryAndMoleculeDetails  = "/api/PostingSession/GetFeedProgramCatagoryAndMoleculeDetails"
        
        case GetChickenTurkeyVeterinarian  = "/api/PostingSession/GetVeterinarian?UserId="
        
        case getFarmListTurkey = "/api/Farm/GetFarmListByUserId"
        
        case getProductionType = "/api/PostingSession/GetProductionType"
        
        case getPostedSessionsByDeviceSessionID = "/api/PostingSession/GetPostingSessionListBySessionId?DeviceSessionId="
        
        case getPostedVaccinationListByDeviceSessionID = "/api/PostingSession/GetVaccinationListBySessionId?DeviceSessionId="
        
        case getFeedListByDeviceSessionID = "/api/PostingSession/GetFeedListBySessionId?DeviceSessionId="
        
        case getFarmListDataByDeviceSessionId = "/api/PostingSession/GetFarmListBySessionId?DeviceSessionId="
        
        
        case getBirdsNotesDataByDeviceSessionId = "/api/PostingSession/GetBirdNotesListBySessionId?DeviceSessionId="
        
        
        case getNecropsyDataByDeviceSessionId  = "/api/PostingSession/GetNecropsyListBySessionId?UserId="
        
        // ********************************************* CHICKEN **************************************************
     
        
        // ********************************************* Turkey **************************************************
        case getTurkeyPostedSession  = "/api/PostingSession/T_GetPostingSessionListByUser?UserId="
        
        case getTurkeyPostedSessionsVacccine = "/api/PostingSession/T_GetVaccinationListByUser?UserId="
        
        case getTurkeyPostedNotes = "/api/PostingSession/T_GetBirdNotesListByUser?UserId="
        
        case getTurkeyPostedImages = "/api/PostingSession/T_GetBirdImagesListByUser?UserId="
        
        case getTukeyPostedFarmList = "/api/PostingSession/T_GetFarmListByUser?UserId="
        
        case getTutorial = "/api/PostingSession/GetTutorial"
        
        case postFeedProgramToServer = "/api/PostingSession/SaveMultipleFeedsSyncData"
        
        //
        //
       
        var latestUrl: String {
            return "\(Constants.baseUrl)\(self.rawValue)"
        }
        var VerUrl: String {
            return "\(Constants.Api.versionUrl)\(self.rawValue)"
        }
    }
}

/* Error Formats */

extension NSError {
    
    convenience init(localizedDescription: String) {
        self.init(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
    
    convenience init(code: Int, localizedDescription: String) {
        self.init(domain: "", code: code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

extension ZoetisWebServices {
    
    /* Random number creator */
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    /*-----------------------------------------PE-------------------------------------------------*/
    /* Draft assessment deleted */
    
    func deleteDeletedDrafts( controller: UIViewController, parameters: JSONDictionary, url:String, completion: @escaping CompletionBlock) {
        deleteRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Dosage list PE */
    
    func getPEDosagesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getPEDosages.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Customer list PE */
    
    func getAllCustomerListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllCustomerPE.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
        
    /* Get Chlorine strip List */
    func getClorineStripsForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getPEClorine.latestUrl + "RegionId=" + String(Regionid)  + languageIdStr
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* App version check */
    
    func getAppVersionCheck( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAppVersion.VerUrl + Bundle.main.versionNumber
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Master data version check */
    
    func getMasterDataVersionCheck( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getMasterDataVersion.VerUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Customer list by user PE */
    
    func getCustomerListForPE( controller : UIViewController, countryID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let id = UserDefaults.standard.integer(forKey: "Id")
        let countryid = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getCustomerPE.latestUrl + String(id) + countryIdStr + String(countryid)  + regionIdStr + String(Regionid)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Site list PE */
    
    func getSitesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let id = UserDefaults.standard.integer(forKey: "Id")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        
        let url = EndPoint.getSitesPE.latestUrl + String(id) + countryIdStr + String(countryId)  + regionIdStr + String(Regionid)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    /* Evaluator list PE */
    
    func getEvaluatorListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getEvaluator.latestUrl + String(countryId)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getApproversListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getApproversPE.latestUrl + String(countryId)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVisitTypesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getVisitTypes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getEvaluatorTypesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let countryid = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let id = UserDefaults.standard.integer(forKey: "Id")
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        
        let url = EndPoint.getEvaluatorTypes.latestUrl + String(id) + countryIdStr + String(countryid) + languageIdStr + regionIdStr + String(Regionid)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getManufacturerListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getManufacturer.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getBirdBreedListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let countryid = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let id = UserDefaults.standard.integer(forKey: "Id")
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        
        let url = EndPoint.getBirdBreed.latestUrl  + String(id) + countryIdStr + String(countryid) + languageIdStr + regionIdStr + String(Regionid)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getEggsListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getEggs.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccineManufacturerListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let id = UserDefaults.standard.integer(forKey: "Id")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getVaccineManufacturer.latestUrl + String(id) +  countryIdStr + String(countryId) + languageIdStr  + "&Rollout=USC"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccineNamesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let id = UserDefaults.standard.integer(forKey: "Id")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getVaccineNames.latestUrl  + String(id)  +  countryIdStr + String(countryId) + languageIdStr + "&Rollout=USC"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccineSubNamesListForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let id = UserDefaults.standard.integer(forKey: "Id")
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getSubVaccineNames.latestUrl + String(id) + countryIdStr + String(countryId) + languageIdStr + "&Rollout=PEI"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
        
    }
    
    
    func getDiluentManufacturerList( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getDiluentManufacturer.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getBagSizes( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getbagSizes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAmplePerBag( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAmplePerBag.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAmpleSizes( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAmpleSizes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPERoles( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let RoleIds = UserDefaults.standard.integer(forKey: "RoleIds")
        let id = 0
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getPERoles.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPEFrequency( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPEFrequency.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPEIncubationStyle( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getIncubationStyle.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPEDOASizes( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getPEDOASizes.latestUrl + "LanguageId=1" + regionIdStr + String(Regionid)
        
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getDuplicacyCheck( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getDuplicacyCheck.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: parameters, headers: [:], completion: completion)
    }
    
    func getPEDOADiluentType( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPEDOADiluentType.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAssessmentCategoriesDetailsPE( controller: UIViewController,evalType: String,moduleID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let countryid = UserDefaults.standard.integer(forKey: "nonUScountryId")
        
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getModuleAssessmentCategoriesDetailsPE.latestUrl + "Module_Id=" + moduleID +  countryIdStr + String(countryid) + languageIdStr + regionIdStr + String(Regionid) + "&EvalType=" + String(evalType) + "&Rollout="
        
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAssessmentQuesInfoPE( controller: UIViewController,evalType: String,moduleID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getAssessmentQuesInfoPE.latestUrl  + "?RegionId=" + String(Regionid) + languageIdStr
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func checkAssessment( controller: UIViewController,assessmentId: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAssessmentStatus.latestUrl + assessmentId + "&StatusType=1"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getMixerList( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let custId = parameters["customerId"] as? String ?? ""
        let siteId = parameters["siteId"] as? String ?? ""
        let countryId = parameters["countryId"] as? String ?? ""
        
        let url = EndPoint.getVaccineMixerList.latestUrl + custId + "&SiteId=" + siteId + countryIdStr + countryId
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPostingAssessmentListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let Id =  UserDefaults.standard.value(forKey: "Id") as? Int ?? 0
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getPostingAssessmentListByUserPE.latestUrl + String(Id) + "&DeviceType=ios"  + regionIdStr + String(Regionid)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getCountryForPE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPECountry.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
   
    
    func getGigyaCountryList( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getGigyaCountries.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getGigyaCountryLanguage(countryID: String, controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getGigyaCountryLanguages.latestUrl + "countryid=\(countryID)"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getGigyaApiKeys(countryID: String, controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getGigyaApiKeys.latestUrl + "countryid=\(countryID)" + "&TokenVersion=V2" + "&LoginType=App"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getRejectedAssessmentListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let Id =  UserDefaults.standard.value(forKey: "Id") as? Int ?? 0
        let Regionid = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getPERejectedAssessment.latestUrl + String(Id)  + regionIdStr + String(Regionid)
        
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getRejectedAssessmentImagesListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        let assId = parameters["assessmentId"] as? String ?? ""
        let url = EndPoint.getPERejectedAssessmentImages.latestUrl + assId
        getRequest(showHud: true, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    //getPostingAssessmentImagesListByUserPE
    func getPostingAssessmentImagesListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let Id =  UserDefaults.standard.value(forKey: "Id") as? Int ?? 0
        let url = EndPoint.getPostingAssessmentImagesListByUserPE.latestUrl + String(Id) + "&DeviceType=ios" //+ countryIdStr + String(countryId) + regionIdStr + String(Regionid)
        
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func sendPostDataToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.postAddAttachmentDetails.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func sendPostDataToServerVaccination(controller: UIViewController, parameters: JSONDictionary,url:String,  completion: @escaping CompletionBlock) {
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
 
    func sendAssessmentStatusTOWeb(controller: UIViewController, parameters: JSONDictionary,  completion: @escaping CompletionBlock) {
        
        let assesId = parameters["AssessmentID"] as? String ?? ""
        let saveType = parameters["SaveType"] as? Int ?? 1
        let userId = parameters["UserID"] as? Int ?? UserDefaults.standard.value(forKey: "Id") as? Int ?? 0
        let AppVersion = parameters["appVersion"] as? String ?? ""
        
        let url = EndPoint.postUpdateStatus.latestUrl + assesId + "&saveType=" + String(saveType) + "&userId=" + String(userId) + "&appVersion=" + AppVersion
        postRequest(showHud: true, showHudText: "", endPoint: url , controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    
    
    func postStatusUpdate(controller: UIViewController, parameters: JSONDictionary,url:String,  completion: @escaping CompletionBlock) {
        let assId = parameters["assessmentId"] as? String ?? ""
        let sType = parameters["saveType"] as? Int ?? 0
        let urls = EndPoint.postUpdateStatus.latestUrl + assId + "&userId=\(UserContext.sharedInstance.userDetailsObj?.userId ?? "")" + "&saveType=\(sType)" + "&appVersion=\(Bundle.main.versionNumber)"
        postRequest(showHud: true, showHudText: "", endPoint: urls, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func sendFCMTokenDataToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        
        postRequest(showHud: true, showHudText: "", endPoint: Constants.Api.fcmUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    
    func sendScoresDataToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        print("scccccccoooooooo",parameters)
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.postAddScores.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func sendMultipleImagesBase64ToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.postImagesBase64.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    
    func sendAddDayOfAgeAndInvoject(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.postAddDayOfAgeAndInvoject.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func sendExtendedMicroToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
   //     print("Extended Micro ",parameters)
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.postExtendedMicro.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func submitFinalStatusOfAssessmentToServer(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
   //     print("Extended Micro ",parameters)
        postRequest(showHud: true, showHudText: "", endPoint: EndPoint.finalAssessmentStatus.latestUrl, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    
    
    
    
    
    /*---------------------------------------------------PVE--------------------------------------------*/
    
    func getVaccineNamesDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getVaccineNamesDetailsPVE.latestUrl
        print("GET SERVICE*** : getVaccineNamesDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccineManDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getVaccineManDetailsPVE.latestUrl
        print("GET SERVICE*** : getVaccineManDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getSiteInjctsDetailssPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getSiteInjctsDetailssPVE.latestUrl
        print("GET SERVICE*** : getSiteInjctsDetailssPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getSurveyTypeDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getSurveyTypeDetailsPVE.latestUrl
        print("GET SERVICE*** : getSurveyTypeDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getSerotypeDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getSerotypeDetailsPVE.latestUrl
        print("GET SERVICE*** : getSerotypeDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    func getAssessmentCategoriesDetailsPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getModuleAssessmentCategoriesDetailsPVE.latestUrl
        print("GET SERVICE*** : getAssessmentCategoriesDetailsPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getCustomerListForPVE( controller: UIViewController, countryID: String, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let Id =  UserDefaults.standard.value(forKey: "Id") as? Int
        let url = EndPoint.getCustomerListPVE.latestUrl + String(Id ?? 0) + "&CountryId=\(countryID)"
        print("GET SERVICE*** : getCustomerListForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getComplexListForPVE( controller: UIViewController, countryID: String,  parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let customerID =  UserDefaults.standard.value(forKey: "Id") as? Int
        let url = EndPoint.getComplexPVE.latestUrl + "CountryId=\(countryID)"
        print("GET SERVICE*** : getComplexListForPVE ", url)
        
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
    
    func getblankPDFPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.postPDFPVE.latestUrl
        print("get SERVICE*** : postPDFPVE ", url)
        
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getBlankAssessmentFiles( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let regionId = UserDefaults.standard.integer(forKey: "Regionid")
        let url = EndPoint.getBlankAssessmentFiles.latestUrl + "?RegionId=\(regionId)"
     
        print("get Blank Assessments *** : PDF ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getDownloadBlankFile( controller: UIViewController, parameters: JSONDictionary, fileName: String, completion: @escaping CompletionBlock) {
        let url = EndPoint.getDownloadBlankFile.latestUrl + "fileName=\(fileName)" + "&userId=\(UserContext.sharedInstance.userDetailsObj?.userId ?? "")"
//        let urls = EndPoint.postUpdateStatus.latestUrl + assId + "&userId=\(UserContext.sharedInstance.userDetailsObj?.userId ?? "")" + "&saveType=\(sType)" + "&appVersion=\(Bundle.main.versionNumber)"
        print("get SERVICE*** : PDF DOWNLOAD LINK ", url)
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
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getAssignUserDetailPVE.latestUrl + "?CountryId=\(countryId)"
        print("GET SERVICE*** : getAssignUserDetailForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getEvaluatorDetailForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
   
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.getEvaluatorDetailPVE.latestUrl + "?CountryId=\(countryId)"
        
        print("GET SERVICE*** : getEvaluatorDetailForPVE ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func GetPostingAssessmentListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPostingAssessmentListByUser.latestUrl + "?DeviceType=ios"
        print("GET SERVICE*** : getPostingAssessmentListByUser ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func GetPostingAssessmentImagesListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPostingAssessmentImagesListByUser.latestUrl
        print("GET SERVICE*** : getPostingAssessmentImagesListByUser ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func GetPostingAssessmentCompleteImagesListByUser( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getPostingAssessmentCompleteImagesListByUser.latestUrl
        print("GET SERVICE*** : getPostingAssessmentCompleteImagesListByUser ", url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    // PVE - Sync API ---- Start
    
    func postStartNewAssessmentDetailForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.postSNADetailsPVE.latestUrl
        postRequest(showHud: false, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
    }
    
    func postScoreDetailsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.postScoreDetailsPVE.latestUrl
        postRequest(showHud: false, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
    }
    
    func postSaveAssessmentImagesDetailsForPVE( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.postSaveAssessmentImagesDetailsPVE.latestUrl
        var jsonDict : NSDictionary!
        do{
            let jsonData = try JSONSerialization.data(withJSONObject:parameters, options:[])
            let jsonDataString = String(data: jsonData, encoding: String.Encoding.utf8)!
        }
        catch
        {
            
        }
        postRequest(showHud: false, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
    }
    
    // PVE - Sync API ---- End
    
    //-----------------Microbial-----------------------
    func getAllLocationTypeValues( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllLocationValues.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllMediaTypeValues( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllMediaTypeValues.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    func getAllSamplingMethodValues( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllSamplingMethodList.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllEnvironmentalLocationTypes( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllEnvironmentalLocationTypes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllBacterialLocationTypes( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllBacterialLocationTypes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllMicrobialSpecimenTypes(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllMicrobialSpecimenTypes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllMicrobialBirdTypes(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllMicrobialBirdTypes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllMicrobialFeatherPulpTest(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllMicrobialFeatherPulpTests.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllCaseStatus(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllCaseStatus.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllHatcheryAllVisitTypeForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcheryAllVisitTypeURLPathMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllCustomersForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let userId = UserDefaults.standard.value(forKey: "Id") as? Int
        let url = EndPoint.getAllCustomersMicrobial.latestUrl + "\(userId ?? 0)"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllSyncedRequisitionData( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getSyncedReqData.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func syncEnvironmentalData(reqType: RequisitionType, controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        var url = ""
        if reqType == .enviromental{
            url = EndPoint.syncEnvironmentalData.latestUrl
        }else if reqType == .bacterial{
            url = EndPoint.syncBacterialData.latestUrl
        }else{
            url = EndPoint.syncFeathurePulp.latestUrl
        }
        postRequest(showHud: false, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
    }
    
    func getAllHatcherySitesForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcherySiteMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getAllHatcheryReviewerForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcheryReviewerMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getAllHatcheryAllConductTypeForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcheryConductTypesMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getAllHatcheryAllSurveyPurposeForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcheryPurposeOfSurveyURLPathMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getAllHatcheryAllTransferTypeForMicrobial( controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock) {
        let url = EndPoint.getAllHatcheryAllTransferTypeURLPathMicrobial.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccinationServicesResponse(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
 
    // Flock Health API ---- Start
    
    func getPostedSessionByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getVaccineListByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getFeedListByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getFarmListByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getNecropsyByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func  getBirdsNotesDataByDeviceIDResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPostedSessionResponceForChicken(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getFlockFeedSessionResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPostedSessionVaccinationResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
 
    func getPostedSessionNotesResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getPostedNecropsyFarmListResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getNecropsyListResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getNecropsyImagesListResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTukeyPostedFarmListResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
 
    
    
    
    func getTargetWeightResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTargetWeightForTurkey.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getCocciVaccineTurkeyResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyCocciVaccine.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getChickenTurkeyComplexByUserIdResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        
        var Id = Int()
        Id =  UserDefaults.standard.value(forKey: "Id") as! Int
        let url = EndPoint.getChickenAndTurkeyComplexByUserId.latestUrl + "\(Id)"
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
     
       // getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: ["UserId" :"UserId"], headers: [:], completion: completion)
    }
    
    func getSalesRepresentativeResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        var Id = Int()
        Id =  UserDefaults.standard.value(forKey: "Id") as! Int
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        var FlockType =   UserDefaults.standard.value(forKey: "chick") as! Int
        
        if FlockType == 4{
            let url = EndPoint.getTurkeySalesRepresentative.latestUrl + "\(Id)" + "&SubProductID=1&CountryId=\(countryId)"
            getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
        }
        else{
            let url = EndPoint.getTurkeySalesRepresentative.latestUrl + "\(Id)" + "&SubProductID=2&CountryId=\(countryId)"
            getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
        }
    }
    
    
    func getRouteResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getRoutes.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTurkeyHatcheryStrainResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyHatcheryStrain.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getTurkeyFieldStrainResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyFieldStrain.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getDosageResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyDosage.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTurkeyGenerationResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyGeneratiobnType.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTurkeyDoseByMoleculeIdResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getTurkeyDosageByMoulecule.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getCocciProgramResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getCocciProgram.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getSessionTypeResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getSessionType.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getBirdSizeResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getBirdSizeTurkey.latestUrl
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
       // getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTermConditionResponceResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.termAndCondtion.latestUrl
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
       // getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
  
    
    func getBirdBreedChickenAndTurkeyResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getBirdBreedChickenAndTurkey.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getFeedProgramCatagoryAndMoleculeDetailsResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.GetFeedProgramCatagoryAndMoleculeDetails.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getVeterinarianResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        var Id = Int()
        Id =  UserDefaults.standard.value(forKey: "Id") as! Int
        let countryId = UserDefaults.standard.integer(forKey: "nonUScountryId")
        let url = EndPoint.GetChickenTurkeyVeterinarian.latestUrl + "\(Id)" + "&SubProductID=2&CountryId=\(countryId)"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    
    func getCustomerListResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        var Id = Int()
        Id =  UserDefaults.standard.value(forKey: "Id") as! Int
        let url = EndPoint.getCustomerOfChickenAndTurkey.latestUrl + "\(Id)"
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getFarmListTurkeyResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getFarmListTurkey.latestUrl
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
       // getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getProductionTypeResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.getProductionType.latestUrl
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getTurkeyPostedSessionsListResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getTurkeyPostedSessionsVacccineResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    func getTurkeyPostedNotesResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    
    func getTurkeyPostedImagesResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    func getTutorialResponce(controller: UIViewController, url: String, completion: @escaping CompletionBlock){
        print(url)
        getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }
    
    
    
    
    //    ***************************** Post Data to Server *************************************
  //

    func getFeedProgramResponceResponce(controller: UIViewController, parameters: JSONDictionary, completion: @escaping CompletionBlock){
        let url = EndPoint.postFeedProgramToServer.latestUrl
        postRequest(showHud: true, showHudText: "", endPoint: url, controller: controller, parameters: parameters, headers: [:], completion: completion)
        
       // getRequest(showHud: false, showHudText: "", controller: controller, endPoint: url, parameters: [:], headers: [:], completion: completion)
    }

    
    
    //Handlers
    
    func handleFailureBlock(error: NSError? = nil, json: JSON? = nil) {
        viewController.dismissGlobalHUD(viewController.view)
        if error?.code == -1009 {
            viewController.noInternetConnection()
        } else if error?.code == 405 {
            print("error in api 405")
        } else if error?.code == 400 ||  error?.code == 401 {
            print("error in api 6090")
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 400 || 401", actionHandler: nil)
        } else if error?.code == 405 {
            print("error in api 456789")
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 405", actionHandler: nil)
        } else if error?.code == 402 {
            print("error in api 456")
            viewController.showAlertViewWithMessageAndActionHandler(message: "server response 402", actionHandler: nil)
        } else {
            if error?.localizedDescription == "cancelled" {
                print("error in api 22")
                return
            }
            viewController.showAlertViewWithMessageAndActionHandler(message: error?.localizedDescription ?? "Something went wrong.", actionHandler: nil)
        }
        dismissGlobalHUD(viewController.view)
    }
    
    func getRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, pageNumber: Int = 1, controller: UIViewController, endPoint: String, parameters: JSONDictionary, headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ZoetisApiManager.GET(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
            print("error in api 1",error, endPoint)
            shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }
    
    func deleteRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, pageNumber: Int = 1, controller: UIViewController, endPoint: String, parameters: JSONDictionary, headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
        ZoetisApiManager.POST(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, headers: headers, success: { (json) in
            print("response is ",json, endPoint)
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
            print("error in api 1",error)
            shouldErrorRequired ? completion(JSON([:]), error) : self.handleFailureBlock(error: error)
        }
    }
    
    func postRequest(showHud: Bool, showHudText: String, shouldErrorRequired: Bool = false, endPoint: String, controller: UIViewController, parameters: JSONDictionary, imageData: Data = Data(), imageKey: String = "", headers: JSONDictionary, completion: @escaping CompletionBlock) {
        viewController = controller
    
        ZoetisApiManager.POST(showHud: showHud, showHudText: showHudText, endPoint: endPoint, parameters: parameters, imageData: imageData, imageKey: imageKey, headers: headers, success: { (json) in
            self.handlecompletionResponse(json, shouldErrorRequired: shouldErrorRequired, completion: completion)
        }) { (error) in
            print("error in api with End Point -- " , endPoint)
            
            shouldErrorRequired ? completion(JSON([:]), error) : completion(JSON([:]), error)
        }
    }
    
    func handlecompletionResponse(_ json: JSON, shouldErrorRequired: Bool = false, completion: @escaping CompletionBlock) {
        
        let jsonDic = json["error"].stringValue
        
        if jsonDic.count > 0 {
            print("error in api 3")
            handleFailureBlock(json: json)
            
        } else {
            completion(json, nil)
        }
        
    }
    
    
}

