//
//  CoreDataHandlerMicro.swift
//  Zoetis -Feathers
//
//  Created by Avinash Singh on 09/01/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandlerMicro: NSObject {
    
    private var managedContext  = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType) //: NSManagedObjectContext! = nil
    
    
    private var CustData = [NSManagedObject]()
    var CustData1 = [NSManagedObject]()
    
    private var ManagedCustData = [NSManagedObject]()
    var dataArray = NSArray()
    
    private var routeArray = NSArray()
    let predicateSessionId = "sessionId == %d AND noOfPlates ==%@"
    
    override init() {
        super.init()
        self.setupContext()
    }
    
    func setupContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.managedObjectContext
        
    }
    
    func saveCustomerDetailsInDB(_ custId: NSNumber, CustName: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Micro_Customer", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(custId, forKey: "customerId")
        person.setValue(CustName, forKey: "customerName")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func saveCustomerDetailsInDBSessionData(_ barcode: String ,company : String,companyId:Int , emailId : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleColectionDate : String, sessionId : String , site: String, siteId : Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SessionMicrobial", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "companyName")
        person.setValue(companyId, forKey: "companyId")
        person.setValue(barcode, forKey: "barcode")
        person.setValue(emailId, forKey: "emailId")
        person.setValue(requestor, forKey: "requestor")
        person.setValue(reviewer, forKey: "reviewer")
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        person.setValue(sampleColectionDate, forKey: "sampleColectionDate")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(site, forKey: "site")
        person.setValue(siteId, forKey: "siteId")
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
    }
    
    func fetchSampleInfoDataForATimeStamp(_ entityName: String, predicate: NSPredicate) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    
    func deleteWithPredicatesFeaherPulpSampleInfo(_ entity: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate.init(format: "isSessionPlate==\(1)")
        let objects = try? managedContext.fetch(fetchRequest)
        if let objects1 = objects {
            for obj in objects1 {
                managedContext.delete(obj as! NSManagedObject)
            }
            
            do {
                try managedContext.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    func saveFeatherPulpSampleInfoDataInDB(_ plateIdGenerated: String ,plateId : Int,flockId:String,houseNo:String ,sampleDescriptiopn:String , additionalTests : String , checkMark:String, microsporeCheck: String, sessionId : Int, timeStamp: String, isSessionPlate: Bool) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpSampleInfo", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(plateIdGenerated, forKey: "plateIdGenerated")
        person.setValue(plateId, forKey: "plateId")
        person.setValue(flockId, forKey: "flockId")
        person.setValue(houseNo, forKey: "houseNo")
        person.setValue(sampleDescriptiopn, forKey: "sampleDescription")
        person.setValue(additionalTests, forKey: "additionalTests")
        person.setValue(checkMark, forKey: "checkMark")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(microsporeCheck, forKey: "microsporeCheckMark")
        person.setValue(timeStamp, forKey: "timeStamp")
        person.setValue(isSessionPlate, forKey: "isSessionPlate")
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func saveCustomerDetailsInDBSubmitData(_ barcode: String ,company : String,companyId:Int , emailId : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleColectionDate : String, sessionId : Int , site: String, siteId : Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialSession", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        person.setValue(companyId, forKey: "companyId")
        person.setValue(barcode, forKey: "barcode")
        person.setValue(emailId, forKey: "emailId")
        person.setValue(requestor, forKey: "requestor")
        person.setValue(reviewer, forKey: "reviewer")
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        person.setValue(sampleColectionDate, forKey: "sampleCollectionDate")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(site, forKey: "site")
        person.setValue(siteId, forKey: "siteId")
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
    }
    
    func updateFeatherPulpDetailsAsSubmittedData(timeStramp: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp, argumentArray: [timeStramp])
        let objects = try? managedContext.fetch(fetchRequest)
        if let objects1 = objects {
            for obj in objects1 {
                (obj as! Microbial_EnviromentalSurveyFormSubmitted).setValue(SessionStatus.submitted.rawValue, forKey: "sessionStatus")
                (obj as! Microbial_EnviromentalSurveyFormSubmitted).setValue(false, forKey: "isSynced")
                do {
                    try managedContext.save() // <- remember to put this :)
                } catch {
                }
            }
        }
    }
    
    //MARK: - Save Enviromental Sample Info/ Case Info data Case Info When Submitted or Save As Draft
    
    func saveFeatherPulpDetailsInDBDraftData(_ barcode: String ,company : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleCollectionDate : String , site: String, reasonForVisit: String,requisitionType : Int)
    {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_EnviromentalSurveyFormSubmitted", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        person.setValue(requestor, forKey: "requestor")
        person.setValue(reviewer, forKey: "reviewer")
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        person.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        person.setValue(reasonForVisit, forKey: "reasonForVisit")
        person.setValue(site, forKey: "site")
        person.setValue(requisitionType, forKey: "requisitionType")
        person.setValue(barcode, forKey: "barcode")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    func saveCaseInfoDataInToDB(requestor: String, sampleCollectedBy: String, company: String,
                                companyId: Int, site: String, siteId: Int, email: String, reviewer: String,
                                surveyConductedOn: String, sampleCollectionDate: String, sampleCollectionDateWithTimeStamp: String,
                                purposeOfSurvey: String, transferIn: String, barCode: String, barCodeManualEntered: String, notes: String, reasonForVisit: String, currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, requisition_Id: String, timeStamp: String, isPlateIdGenerated: Bool, typeOfBird: String, typeOfBirdId: Int, reviewerId: Int, purposeOfSurveyId: Int, surveyConductedOnId: Int, reasonForVisitId: Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_EnviromentalSurveyFormSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(reasonForVisitId, forKey: "reasonForVisitId")
        managedObject.setValue(surveyConductedOnId, forKey: "surveyConductedOnId")
        managedObject.setValue(purposeOfSurveyId, forKey: "purposeOfSurveyId")
        managedObject.setValue(reviewerId, forKey: "reviewerId")
        managedObject.setValue(requestor, forKey: "requestor")
        managedObject.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        managedObject.setValue(company, forKey: "company")
        managedObject.setValue(companyId, forKey: "companyId")
        managedObject.setValue(site, forKey: "site")
        managedObject.setValue(siteId, forKey: "siteId")
        managedObject.setValue(email, forKey: "email")
        managedObject.setValue(reviewer, forKey: "reviewer")
        managedObject.setValue(surveyConductedOn, forKey: "surveyConductedOn")
        managedObject.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        managedObject.setValue(sampleCollectionDateWithTimeStamp, forKey: "sampleCollectionDateWithTimeStamp")
        managedObject.setValue(purposeOfSurvey, forKey: "purposeOfSurvey")
        managedObject.setValue(transferIn, forKey: "transferIn")
        managedObject.setValue(barCode, forKey: "barcode")
        managedObject.setValue(barCodeManualEntered, forKey: "barcodeManualEntered")
        managedObject.setValue(notes, forKey: "notes")
        managedObject.setValue(reasonForVisit, forKey: "reasonForVisit")
        managedObject.setValue(typeOfBird, forKey: "typeOfBird")
        managedObject.setValue(typeOfBirdId, forKey: "typeOfBirdId")
        managedObject.setValue(currentdate, forKey: "currentdate")
        managedObject.setValue(customerId, forKey: "customerId")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        managedObject.setValue(isPlateIdGenerated, forKey: "isPlateIdGenerated")
        managedObject.setValue(false, forKey: "isSynced")
        managedObject.setValue(UserDefaults.standard.value(forKey:"Id") ?? 0, forKey: "userId")
        
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier") as? String ?? ""
        
        let syncDeviceId = "\(timeStamp)_\(UserDefaults.standard.value(forKey:"Id") ?? 0)_iOS_\(udid)"
        managedObject.setValue(syncDeviceId, forKey: "syncDeviceId")
        managedObject.setValue("C-\(timeStamp)", forKey: "reqNo")
        if let caseStatusArray = CoreDataHandlerMicro().fetchDetailsFor(entityName: "MicrobialCaseStatus") as? [MicrobialCaseStatus] {
            managedObject.setValue(caseStatusArray.first?.id ?? 0, forKey: "reqStatus")
        }else{
            managedObject.setValue(0, forKey: "reqStatus")
        }
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    func saveSampleInfoHeaderDataInToDB_Enviromental(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, locationType: String, locationTypeId: Int, noOfPlates: Int, section: Int, requisition_Id: String, timeStamp: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeadersSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(currentdate, forKey: "currentdate")
        managedObject.setValue(customerId, forKey: "customerId")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        
        managedObject.setValue(locationType, forKey: "locationType")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(noOfPlates, forKey: "noOfPlates")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    func addNewRowToPlatesSubmitted(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, isBacterialChecked: Bool, isMicoscoreChecked: Bool, locationTypeId: Int, locationValue: String, plateId: String, row: Int, sampleDescription: String, section: Int, requisition_Id: String, timeStamp: String){
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaderPlatesSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(currentdate, forKey: "currentdate")
        managedObject.setValue(customerId, forKey: "customerId")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        managedObject.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
        managedObject.setValue(isBacterialChecked, forKey: "isBacterialChecked")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(locationValue, forKey: "locationValue")
        managedObject.setValue(plateId, forKey: "plateId")
        managedObject.setValue(row, forKey: "row")
        managedObject.setValue(sampleDescription, forKey: "sampleDescription")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    
    
    
    func saveRequisitionalIDs_Enviromental(requisition_Id: String, requisitionType: Int, sessionStatus: Int, totalHeader: Int, totalPlates: Int, timeStamp: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_Enviromental_RequisitionIDs", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        managedObject.setValue(totalHeader, forKey: "totalHeader")
        managedObject.setValue(totalPlates, forKey: "totalPlates")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        
        do {
            try managedContext.save()
        } catch {
            
        }
    }
    
    func fetchEnviromentalHeadersWith(requisition_Id: String, requisitionType: NSNumber) -> [Microbial_LocationTypeHeadersSubmitted] {
        
        var dataArray = [Microbial_LocationTypeHeadersSubmitted]()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "requisition_Id == %@", "\(requisition_Id)")
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeadersSubmitted]
            if let results = fetchedResult {
                dataArray = results
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    func fetchEnviromentalPlatesWith(section: String, requisition_Id: String, locationTypeId: NSNumber, timeStamp: String) -> [Microbial_LocationTypeHeaderPlatesSubmitted] {
        
        var dataArray = [Microbial_LocationTypeHeaderPlatesSubmitted]()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlatesSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "section == %@ AND requisition_Id == %@ AND locationTypeId == %@ AND timeStamp == %@", section, requisition_Id, "\(locationTypeId)", timeStamp)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeaderPlatesSubmitted]
            if let results = fetchedResult {
                dataArray = results
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    
    
    func fetchSubmittedOrSaveAsDraftRequisitions(sessionStatus: Int, requisitionType: Int) -> NSArray {
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        let userId = UserDefaults.standard.value(forKey: "Id") ?? 0
        fetchRequest.predicate = NSPredicate(format: "sessionStatus == \(sessionStatus) AND requisitionType == \(requisitionType) AND userId == \(userId) AND isSynced == 0")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_EnviromentalSurveyFormSubmitted]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    //MARK: - Save Enviromental Session In Progress
    func saveEnviromentalSessionInProgress(requestor: String, sampleCollectedBy: String, company: String,
                                           companyId: Int, site: String, siteId: Int, email: String, reviewer: String,
                                           surveyConductedOn: String, sampleCollectionDate: String, sampleCollectionDateWithTimeStamp: String,
                                           purposeOfSurvey: String, transferIn: String, barCode: String, barCodeManualEntered: String, notes: String, reasonForVisit: String,
                                           requisition_Id: String, requisitionType: Int, isPlateIdGenerate: Bool, typeOfBird: String, typeOfBirdId: Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_EnviromentalSessionInProgress", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(requestor, forKey: "requestor")
        managedObject.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        managedObject.setValue(company, forKey: "company")
        managedObject.setValue(companyId, forKey: "companyId")
        managedObject.setValue(site, forKey: "site")
        managedObject.setValue(siteId, forKey: "siteId")
        managedObject.setValue(email, forKey: "email")
        managedObject.setValue(reviewer, forKey: "reviewer")
        managedObject.setValue(surveyConductedOn, forKey: "surveyConductedOn")
        managedObject.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        managedObject.setValue(sampleCollectionDateWithTimeStamp, forKey: "sampleCollectionDateWithTimeStamp")
        managedObject.setValue(purposeOfSurvey, forKey: "purposeOfSurvey")
        managedObject.setValue(transferIn, forKey: "transferIn")
        managedObject.setValue(barCode, forKey: "barcode")
        managedObject.setValue(barCodeManualEntered, forKey: "barcodeManualEntered")
        managedObject.setValue(notes, forKey: "notes")
        managedObject.setValue(reasonForVisit, forKey: "reasonForVisit")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(isPlateIdGenerate, forKey: "isPlateIdGenerated")
        managedObject.setValue(typeOfBird, forKey: "typeOfBird")
        managedObject.setValue(typeOfBirdId, forKey: "typeOfBirdId")
        do {
            try managedContext.save()
        } catch { }
    }
    
    func saveEnviromentalLocationTypeHeaderInfo(locationType: String, locationTypeId: Int,
                                                noOfPlates: Int, section: Int, requisition_Id: String, requisitionType: Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaders", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(locationType, forKey: "locationType")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(noOfPlates, forKey: "noOfPlates")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    func saveEnviromentalLocationTypePlatesInfo(isBacterialChecked: Bool, isMicoscoreChecked: Bool,
                                                locationValue: String, plateId: String,
                                                row: Int, section: Int, sampleDescription: String,
                                                locationTypeId: Int?, requisition_Id: String, requisitionType: Int, mediaTypeValue: String, mediaTypeId: Int?, notes: String, samplingMethodId : Int?,samplingMethodTypeValue : String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaderPlates", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(isBacterialChecked, forKey: "isBacterialChecked")
        managedObject.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
        managedObject.setValue(locationValue, forKey: "locationValue")
        managedObject.setValue(mediaTypeValue, forKey: "mediaTypeValue")
        managedObject.setValue(samplingMethodTypeValue, forKey: "samplingMethodTypeValue")
        managedObject.setValue(plateId, forKey: "plateId")
        managedObject.setValue(row, forKey: "row")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(sampleDescription, forKey: "sampleDescription")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(mediaTypeId, forKey: "mediaTypeId")
        managedObject.setValue(samplingMethodId, forKey: "samplingMethodTypeId")
        managedObject.setValue(notes, forKey: "notes")
        
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    func fetchEnviromentalLocationTypeHeaderInfoFor() -> NSArray {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaders")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeaders]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    func fetchEnviromentalLocationTypePlatesInfoFor(section: Int, locationTypeId: Int) -> NSArray {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlates")
        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.predicate = NSPredicate(format: "locationTypeId == %@", "\(locationTypeId)")
        fetchRequest.predicate = NSPredicate(format: "locationTypeId == %@ AND section == %d", "\(locationTypeId)", section)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeaderPlates]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    
    
    func saveSessionProgress(_ barcode: String ,company : String,companyId:Int , emailId : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleColectionDate : String, sampleCollectionDateWithTimeStamp: String, sessionId : Int , site: String, siteId : Int, manualEnteredBarCode: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ProgressSessionMicrobial", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        person.setValue(companyId, forKey: "companyId")
        person.setValue(barcode, forKey: "barcode")
        person.setValue(emailId, forKey: "emailId")
        person.setValue(requestor, forKey: "requestor")
        person.setValue(reviewer, forKey: "reviewer")
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        person.setValue(sampleColectionDate, forKey: "sampleCollectionDate")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(site, forKey: "site")
        person.setValue(siteId, forKey: "siteId")
        person.setValue(sampleCollectionDateWithTimeStamp, forKey: "sampleCollectionDateWithTimeStamp")
        person.setValue(manualEnteredBarCode, forKey: "manualEnteredBarCode")
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
    }
    
    func saveSampleInfoDataInDB(_ noOfPlates: String ,plateId : Int,sampleDescriptiopn:String , additionalTests : String , checkMark:String, microsporeCheck: String, sessionId : Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialSampleInfo", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(noOfPlates, forKey: "noOfPlates")
        person.setValue(plateId, forKey: "plateId")
        person.setValue(sampleDescriptiopn, forKey: "sampleDescription")
        person.setValue(additionalTests, forKey: "additionalTests")
        person.setValue(checkMark, forKey: "checkMark")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(microsporeCheck, forKey: "microsporeCheckMark")
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func fetchSampleInfo(_ sessionId: Int) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %d", sessionId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                dataArray = results as NSArray
                
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "plateId", ascending: true)
                let sortedResults = dataArray.sortedArray(using: [descriptor])
                dataArray = sortedResults as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func fetchFeatherPulpSampleInfo(_ sessionId: Int) -> [MicrobialFeatherPulpSampleInfo] {
        var dataArray = [MicrobialFeatherPulpSampleInfo]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %d", sessionId)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "plateId", ascending: true)]
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [MicrobialFeatherPulpSampleInfo]
            if let results = fetchedResult {
                dataArray = results
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func deleteLastRowFeatherPulpData(predicate: NSPredicate) {
        let fetchUsers  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchUsers.predicate = predicate
        do {
            let results = try managedContext.fetch(fetchUsers)
            if let lastObject = results.last as? NSManagedObject {
                managedContext.delete(lastObject)
                try managedContext.save()
            }
        } catch {
            print("test message")
        }
    }
    
    func fetchDataFromDraftsAndRequisition(draftOrSubmit: Int, entityName: String)-> NSArray{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionStatus == \(draftOrSubmit) AND userId == \(String(describing: UserDefaults.standard.value(forKey: "Id") ?? 0))")
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                dataArray = results as NSArray
                
                return dataArray
                
            } else {
                return []
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    func fetchAllData1(_ entityName: String) -> [NSManagedObject] {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        var dataArrayNew = [NSManagedObject()]
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                dataArrayNew = results
                
                
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArrayNew
    }
    func fetchAllData(_ entityName: String) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        var dataArrayNew = [NSManagedObject()]
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                dataArray = results as! NSArray
                
                
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    func updateSampledesc(_ sessionId: Int,plateId: String,sampleDesc: String) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialSampleInfo = (fetchedResult![0] as? MicrobialSampleInfo)!
                
                objTable.setValue(sampleDesc, forKey: "sampleDescription")
                do {
                    try managedContext.save()
                } catch {
                }
                
                
            }
            
            
            
        } catch {
            
        }
        
        
    }
    
    func updateFeatherPulpSampledesc(plateData: MicrobialFeatherPulpSampleInfo, predicate: NSPredicate) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialFeatherPulpSampleInfo = (fetchedResult![0] as? MicrobialFeatherPulpSampleInfo)!
                do {
                    try managedContext.save()
                } catch {
                }
            }
        } catch {
            print("test message")
        }
    }
    
    func updateFeatherPulpCheckMark(_ sessionId: Int,plateId: String,checkMark: String) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialFeatherPulpSampleInfo = (fetchedResult![0] as? MicrobialFeatherPulpSampleInfo)!
                
                objTable.setValue(checkMark, forKey: "checkMark")
                do {
                    try managedContext.save()
                } catch {
                }
            }
            
        } catch {
            
        }
    }
    
    func updateFeatherPulpMicrosporeCheckMark(_ sessionId: Int,plateId: String,checkMark: String) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialFeatherPulpSampleInfo = (fetchedResult![0] as? MicrobialFeatherPulpSampleInfo)!
                
                objTable.setValue(checkMark, forKey: "microsporeCheckMark")
                do {
                    try managedContext.save()
                } catch {
                }
            }
            
        } catch {
            
        }
    }
    
    
    func deleteRowData ( sessionId: Int,plateId: String) {
        
        let fetchPredicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        fetchUsers.predicate                = fetchPredicate
        
        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            
        } catch {
            print("test message")
        }
        
    }
    
    
    func deleteRowDataOfAnEntity(predicate: NSPredicate, entityName: String) {
        let fetchPredicate = predicate
        let fetchUsers     = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchUsers.predicate = fetchPredicate
        
        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            do {
                try managedContext.save()
            } catch {
            }
            
        } catch {
            print("test message")
        }
    }
    
    
    func deleteLastRowData( sessionId: Int,plateId: String) {
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        do {
            let results = try managedContext.fetch(fetchUsers)
            if let lastObject = results.last as? NSManagedObject {
                print(lastObject)
                managedContext.delete(lastObject)
                try managedContext.save()
            }
        } catch {
            print("test message")
        }
    }
    
    func updateMicrosporeCheckMark(_ sessionId: Int,plateId: String,checkMark: String) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialSampleInfo = (fetchedResult![0] as? MicrobialSampleInfo)!
                
                objTable.setValue(checkMark, forKey: "microsporeCheckMark")
                do {
                    try managedContext.save()
                } catch {
                }
            }
            
        } catch {
            
        }
    }
    
    func updateCheckMark(_ sessionId: Int,plateId: String,checkMark: String) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSampleInfo")
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: predicateSessionId, sessionId,plateId)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if fetchedResult!.count > 0 {
                
                let objTable: MicrobialSampleInfo = (fetchedResult![0] as? MicrobialSampleInfo)!
                
                objTable.setValue(checkMark, forKey: "checkMark")
                do {
                    try managedContext.save()
                } catch {
                }
            }
            
        } catch {
            
        }
    }
    
    
    func saveCustomerDetailsInDraftData(_ barcode: String ,company : String,companyId:Int , emailId : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleColectionDate : String, sessionId : Int , site: String, siteId : Int,draftCheck : String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialDraft", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        person.setValue(companyId, forKey: "companyId")
        person.setValue(barcode, forKey: "barcode")
        person.setValue(emailId, forKey: "emailId")
        person.setValue(requestor, forKey: "requestor")
        person.setValue(reviewer, forKey: "reviewer")
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        person.setValue(sampleColectionDate, forKey: "sampleCollectionDate")
        person.setValue(sessionId, forKey: "sessionId")
        person.setValue(site, forKey: "site")
        person.setValue(siteId, forKey: "siteId")
        person.setValue(draftCheck, forKey: "draftCheck")
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    
    
    func fetchCustomerWithCustId(_ custId: NSNumber) -> NSArray {
        
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Micro_Customer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customerId == %@", custId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func saveReviewerDetailsInDB(_ custId: NSNumber, ReviewerName: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Micro_Reviewer", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(custId, forKey: "reviewerId")
        person.setValue(ReviewerName, forKey: "reviewerName")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func saveAllConductTypeDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Micro_AllConductType", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    
    func saveAllSitesIdInDB(_ id: Int, text: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Micro_siteByCustomer", in: managedContext!)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext!)
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(text, forKey: "text")
        do {
            try managedContext?.save()
        } catch {
            
        }
        CustData.append(managedObject)
    }
    
    func fectAllSitesIdFromDB(_ entityName: String) -> NSArray {
        var result = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                result = results as NSArray
            } else {print("Test message")}
        } catch {
            
        }
        return result
    }
    
    
    
    func saveLocationTypeValuesInDB(_ locationId: NSNumber, id: NSNumber, value: String, std40: Bool, std20: Bool, rep20: Int, rep40: Int, standard: Bool, stnRep: Int , mediaTypeDefault : String, samplingMethodDefault : String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationValues", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(locationId, forKey: "locationTypeId")
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(value, forKey: "text")
        managedObject.setValue(std20, forKey: "std20")
        managedObject.setValue(std40, forKey: "std40")
        managedObject.setValue(rep40, forKey: "rep40")
        managedObject.setValue(rep20, forKey: "rep20")
        managedObject.setValue(standard, forKey: "standard")
        managedObject.setValue(stnRep, forKey: "stnRep")
        managedObject.setValue(mediaTypeDefault, forKey: "media")
        managedObject.setValue(samplingMethodDefault, forKey: "sampling")
        
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(managedObject)
        
    }
    
    func fetchLocationValueFor(locationId: Int) -> NSArray {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationValues")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "locationTypeId == %@", "\(locationId)")
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationValues]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func fetchMediaTypesFor() -> NSArray {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_AllMediaTypes")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_AllMediaTypes]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func saveAllMediaTypeDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_AllMediaTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    
    func saveAllsamplingMethodTypeDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_SamplingMethodTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func saveAllSurveyPurposeDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Micro_AllSurveyPurpose", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func saveAllMicrobialTransferTypesDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Micro_AllMicrobialTransferTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    func fetchDetailsFor(entityName:String, customerId: Int? = nil, companyName: String? = nil) -> NSArray {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        if let customerId = customerId {
            fetchRequest.predicate = NSPredicate(format: "customerId == %d", customerId)
        }
        
        if let companyName = companyName {
            fetchRequest.predicate = NSPredicate(format: "customerName == %@", companyName)
        }
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func deleteAllData(_ entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
                try managedContext.save()
            }
            
        } catch let error as NSError {
            
        }
    }
    
    func autoIncrementidtable() {
        var auto = self.fetchFromAutoIncrement()
        auto += 1
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Id", in: managedContext)
        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue(auto, forKey: "autoId")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    
    func fetchFromAutoIncrement() -> Int {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "Id")
        fetchRequest.returnsObjectsAsFaults = false
        var auto: Int?
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            auto = fetchedResult?.count == 0 ? 0 : 0
            if let results = fetchedResult {
                if results.count > 0 {
                    let ob: Id = results.last as! Id
                    auto = Int(ob.autoId!)
                }
            } else {
                
            }
            
            
        } catch {
            print("test message")
        }
        
        return auto!
        
    }
    
    
    func updateRequestorBacterialServeyFormDetails(_ sessionId: Int, text: String, forAttribute:String ) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "SessionMicrobial", in: managedContext)
        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue(text, forKey: forAttribute)
        contact1.setValue(sessionId, forKey: "sessionId")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
    }
    
    
    func fetchDataForBacterialServeyForm(_ sessionId: NSNumber) -> NSArray {
        
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionMicrobial")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %@", sessionId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
        
    }
    
    func fetchCertificationDateForMixer(_ mixerId: NSNumber) -> String {
        
        var data = String()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PE_VaccineMixerDetail")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "id == %@", mixerId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult?[0] {
                data = results.value(forKey: "certificationDate") as? String ?? ""
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return data
        
    }
    
    
    func saveStartNewAsessmentFormDetailsInDB() {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "SessionMicrobial", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue("", forKey: "customer")
        person.setValue("company", forKey: "company")
        person.setValue("companyId", forKey: "companyId")
        person.setValue("emailId", forKey: "emailId")
        person.setValue("requestor", forKey: "requestor")
        person.setValue("reviewer", forKey: "reviewer")
        person.setValue(1, forKey: "sessionId")
        person.setValue("site", forKey: "site")
        person.setValue("siteId", forKey: "siteId")
        person.setValue("sampleCollectedBy", forKey: "sampleCollectedBy")
        person.setValue("sampleCollectionDate", forKey: "sampleCollectionDate")
        person.setValue("barcode", forKey: "barcode")
        
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        ManagedCustData.append(person)
        
    }
    
    func updateStartNewAsessmentFormDetails(_ sessionId: Int, text: String, forAttribute:String ) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SessionMicrobial")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %@", argumentArray: [sessionId])
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                results![0].setValue(text, forKey: forAttribute)
            }
        } catch {
            print("test message")
        }
        
        do {
            try managedContext.save()
        }
        catch {
            print("test message")
        }
        
    }
    
    func saveAllMicrobialHatcherySiteDetailsInDB(_ id :NSNumber, siteId :NSNumber, SiteName:String, ComplexId:Int,customerId:Int!) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Micro_siteByCustomer", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(siteId, forKey: "siteId")
        person.setValue(SiteName, forKey: "siteName")
        person.setValue(ComplexId, forKey: "complexId")
        person.setValue(customerId, forKey: "customerId")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    
    func saveAllMicrobialVisitTypesDetailsInDB(_ id: NSNumber, text: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Micro_AllMicrobialVisitTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
        CustData.append(person)
        
    }
    
    //----
    func saveFeatherPulpSessionInProgressInDB(_ barcode: String ,company : String, requestor:String,reviewer :String , sampleCollectedBy : String , sampleCollectionDate : String, sessionId : Int , site: String,reasonForVisit :String)
    {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_FeatherPulpCurrentSession", in: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        person.setValue(company, forKey: "company")
        
        person.setValue(barcode, forKey: "barcode")
        
        person.setValue(requestor, forKey: "requestor")
        
        person.setValue(reviewer, forKey: "reviewer")
        
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        
        person.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        
        person.setValue(reasonForVisit, forKey: "reasonForVisit")
        
        person.setValue(site, forKey: "site")
        
        person.setValue(sessionId, forKey: "sessionId")
        
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
    }
    
    
    
    //MARK: - Save Feather Pulp customer Submitted Data in DB
    func saveFeatherPulpCustomerDetailsInDBSubmitData(_ barcode: String ,company : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleCollectionDate : String, sessionId : Int , site: String, siteId : Int,reasonForVisit: String)
    {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_FeatherPulp", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        
        person.setValue(requestor, forKey: "requestor")
        
        person.setValue(reviewer, forKey: "reviewer")
        
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        
        person.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        
        person.setValue(reasonForVisit, forKey: "reasonForVisit")
        
        person.setValue(site, forKey: "site")
        
        person.setValue(sessionId, forKey: "sessionId")
        
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
    }
    
    //MARK: - Save Feather Pulp customer Draft Data in DB
    
    func saveFeatherPulpCustomerDetailsInDBDraftData(_ barcode: String ,company : String , requestor:String,reviewer :String , sampleCollectedBy : String , sampleCollectionDate : String, sessionId : Int , site: String, siteId : Int,reasonForVisit: String)
    {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_FeatherPulpDraft", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(company, forKey: "company")
        
        person.setValue(requestor, forKey: "requestor")
        
        person.setValue(reviewer, forKey: "reviewer")
        
        person.setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
        
        person.setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
        
        person.setValue(reasonForVisit, forKey: "reasonForVisit")
        
        person.setValue(site, forKey: "site")
        
        person.setValue(sessionId, forKey: "sessionId")
        
        
        do {
            try managedContext.save()
            
            
        } catch {
            print("test message")
        }
        
    }
    
    
    
    func updateDataInTheEntityWithPredicates(predicate: NSPredicate, entity: String, requestor: String, sampleCollectedBy: String, company: String, companyId: Int, site: String, siteId: Int, email: String, reviewer: String, surveyConductedOn: String, sampleCollectionDate: String, sampleCollectionDateWithTimeStamp: String, purposeOfSurvey: String, transferIn: String, barCode: String, barCodeManualEntered: String, notes: String, reasonForVisit: String, currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, requisition_Id: String, timeStamp: String, isPlateIdGenerated: Bool, typeOfBird: String, typeOfBirdId: Int, reviewerId: Int, purposeOfSurveyId: Int, surveyConductedOnId: Int, reasonForVisitId: Int){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                
                results?[0].setValue(requestor, forKey: "requestor")
                results?[0].setValue(sampleCollectedBy, forKey: "sampleCollectedBy")
                results?[0].setValue(company, forKey: "company")
                results?[0].setValue(companyId, forKey: "companyId")
                results?[0].setValue(site, forKey: "site")
                results?[0].setValue(siteId, forKey: "siteId")
                results?[0].setValue(email, forKey: "email")
                results?[0].setValue(reviewer, forKey: "reviewer")
                results?[0].setValue(surveyConductedOn, forKey: "surveyConductedOn")
                results?[0].setValue(sampleCollectionDate, forKey: "sampleCollectionDate")
                results?[0].setValue(sampleCollectionDateWithTimeStamp, forKey: "sampleCollectionDateWithTimeStamp")
                results?[0].setValue(purposeOfSurvey, forKey: "purposeOfSurvey")
                results?[0].setValue(transferIn, forKey: "transferIn")
                results?[0].setValue(barCode, forKey: "barcode")
                results?[0].setValue(barCodeManualEntered, forKey: "barcodeManualEntered")
                results?[0].setValue(notes, forKey: "notes")
                results?[0].setValue(reasonForVisit, forKey: "reasonForVisit")
                results?[0].setValue(currentdate, forKey: "currentdate")
                results?[0].setValue(customerId, forKey: "customerId")
                results?[0].setValue(requisitionType, forKey: "requisitionType")
                results?[0].setValue(sessionStatus, forKey: "sessionStatus")
                results?[0].setValue(requisition_Id, forKey: "requisition_Id")
                results?[0].setValue(timeStamp, forKey: "timeStamp")
                results?[0].setValue(isPlateIdGenerated, forKey: "isPlateIdGenerated")
                results?[0].setValue(typeOfBirdId, forKey: "typeOfBirdId")
                results?[0].setValue(typeOfBird, forKey: "typeOfBird")
                results?[0].setValue(reviewerId, forKey: "reviewerId")
                results?[0].setValue(purposeOfSurveyId, forKey: "purposeOfSurveyId")
                results?[0].setValue(surveyConductedOnId, forKey: "surveyConductedOnId")
                results?[0].setValue(reasonForVisitId, forKey: "reasonForVisitId")
                results?[0].setValue(false, forKey: "isSynced")
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    func deleteSampleInfoHeaderDataInToDB_Enviromental(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, locationType: String, locationTypeId: Int, noOfPlates: Int, section: Int, requisition_Id: String, timeStamp: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        fetchRequest.predicate = NSPredicate(format: "timeStamp = %@ AND requisition_Id = %@ AND requisitionType = %i", argumentArray: [timeStamp, requisition_Id, requisitionType])
        if let objects = try? context.fetch(fetchRequest) {
            for obj in objects {
                context.delete(obj as! NSManagedObject)
            }
            
            do {
                try context.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    func updateSampleInfoHeaderDataInToDB_Enviromental(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, locationType: String, locationTypeId: Int, noOfPlates: Int, section: Int, requisition_Id: String, timeStamp: String, prevSection: Int) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        
        fetchRequest.predicate = NSPredicate(format: "timeStamp = %@ AND requisition_Id = %@ AND requisitionType = %i AND section = %i", argumentArray: [timeStamp, requisition_Id, requisitionType, section])
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                for data in results ?? []{
                    data.setValue(currentdate, forKey: "currentdate")
                    data.setValue(customerId, forKey: "customerId")
                    data.setValue(requisitionType, forKey: "requisitionType")
                    data.setValue(sessionStatus, forKey: "sessionStatus")
                    
                    data.setValue(locationType, forKey: "locationType")
                    data.setValue(locationTypeId, forKey: "locationTypeId")
                    data.setValue(noOfPlates, forKey: "noOfPlates")
                    data.setValue(section, forKey: "section")
                    data.setValue(requisition_Id, forKey: "requisition_Id")
                }
            }else{
                let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeadersSubmitted", in: managedContext)
                let managedObject = NSManagedObject(entity: entity!, insertInto: context)
                
                managedObject.setValue(currentdate, forKey: "currentdate")
                managedObject.setValue(customerId, forKey: "customerId")
                managedObject.setValue(requisitionType, forKey: "requisitionType")
                managedObject.setValue(sessionStatus, forKey: "sessionStatus")
                
                managedObject.setValue(locationType, forKey: "locationType")
                managedObject.setValue(locationTypeId, forKey: "locationTypeId")
                managedObject.setValue(noOfPlates, forKey: "noOfPlates")
                managedObject.setValue(section, forKey: "section")
                managedObject.setValue(requisition_Id, forKey: "requisition_Id")
                managedObject.setValue(timeStamp, forKey: "timeStamp")
                
                do {
                    try managedContext.save()
                } catch { }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    func deleteHeaderPlates(timeStamp: String, barcode: String, locationId: Int, section: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequestOfHeaders = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        fetchRequestOfHeaders.predicate = NSPredicate(format: "timeStamp = %@ AND locationTypeId = %i AND section = %i", argumentArray: [timeStamp, locationId, section])
        do {
            let results = try context.fetch(fetchRequestOfHeaders)
            for obj in results{
                context.delete(obj as! NSManagedObject)
                try context.save()
            }
        } catch {
            //   print("ERROR - deleting")
        }
        
        
    }
    
    func reArrangeHeaders(timeStamp: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequestOfHeaders = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        let predicate = NSPredicate(format: appDelegate.timeStamp, argumentArray: [timeStamp])
        fetchRequestOfHeaders.predicate = predicate
        do {
            let results = try context.fetch(fetchRequestOfHeaders) as! [Microbial_LocationTypeHeadersSubmitted]
            if results.count > 0{
                for index in 0..<results.count{
                    Microbial_LocationTypeHeaderPlatesSubmitted.updateSection(prevSection: results[index].section?.intValue ?? 0, newSection: index + 1, timeStamp: timeStamp)
                    (results[index] as AnyObject).setValue(index + 1, forKey: "section")
                }
            }
        } catch {
            //   print("ERROR - deleting")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    
    
    func updateNumberOfPlates(predicate: NSPredicate, noOfPlates: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequestOfHeaders = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        fetchRequestOfHeaders.predicate = predicate
        //NSPredicate(format: "timeStamp = %@ AND requisition_Id = %@ AND requisitionType = %i AND section = %i", argumentArray: [timeStamp, requisition_Id, requisitionType, section])
        do {
            let results = try context.fetch(fetchRequestOfHeaders) as? [NSManagedObject]
            if results?.count != 0 {
                for data in results ?? []{
                    data.setValue(noOfPlates, forKey: "noOfPlates")
                    try managedContext.save()
                }
            }else{print("Test message")}
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
    }
    
    func updatePlateIDInfoForFeatherPulp(timeStamp: String){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSessionPlate == 1")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for plate in fetchedResult!{
                    plate.setValue(false, forKey: "isSessionPlate")
                    plate.setValue(timeStamp, forKey: "timeStamp")
                }
                do {
                    try managedContext.save()
                } catch {
                }
            }
        } catch {
            print("test message")
        }
    }
    
}

//MARK:- MicrobialFeatherPulpBirdType
extension MicrobialFeatherPulpBirdType{
    class func saveBirdTypeValuesInDB(id: NSNumber, birdText: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpBirdType", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(birdText, forKey: "birdText")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
}


//MARK:- MicrobialFeatherPulpSpecimenType
extension MicrobialFeatherPulpSpecimenType{
    class func saveSpecimenTypeValuesInDB(id: NSNumber, specimenText: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpSpecimenType", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(specimenText, forKey: "specimenText")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
}

//MARK:- MicrobialFeatherPulpSampleInfo
extension MicrobialFeatherPulpSampleInfo{
    class func fetchDataPlatesToBeSynced(predicate: NSPredicate) -> [MicrobialFeatherPulpSampleInfo] {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherPulpSampleInfo]
            if let arrPlate = results {
                return arrPlate
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
        return []
    }
    
    
    class func updateSpecimenTypeId(value: Int, predicate: NSPredicate) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherPulpSampleInfo]
            if let arrPlate = results {
                for i in 0..<arrPlate.count{
                    results?[i].setValue(value, forKey: "specimenTypeId")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func updateFarmDetails(key: String, value: String, predicate: NSPredicate) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherPulpSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherPulpSampleInfo]
            if let arrPlate = results {
                for i in 0..<arrPlate.count{
                    results?[i].setValue(value, forKey: key)
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func addSingleFarmDetails(isSessionPlate: Bool, plateId: Int, timeStamp: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpSampleInfo", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(isSessionPlate, forKey: "isSessionPlate")
        person.setValue(plateId, forKey: "plateId")
        person.setValue(timeStamp, forKey: "timeStamp")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    class func insertAlreadySyncedFarmData(microbialFeatherDetailsList: MicrobialFeatherDetailsList, timeStamp: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpSampleInfo", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(false, forKey: "isSessionPlate")
        person.setValue(1, forKey: "plateId")
        person.setValue(timeStamp, forKey: "timeStamp")
        person.setValue("\(microbialFeatherDetailsList.AgeDays ?? 0)", forKey: "days")
        person.setValue("\(microbialFeatherDetailsList.Farm ?? "")", forKey: "farmName")
        person.setValue("\(microbialFeatherDetailsList.SamplesCount ?? 0)", forKey: "noOfSamples")
        person.setValue(FeatherPulpVC.getSpecimenFromItsId(id: microbialFeatherDetailsList.SpecimenTypeId ?? 0), forKey: "specimenType")
        person.setValue(microbialFeatherDetailsList.SpecimenTypeId ?? 0, forKey: "specimenTypeId")
        person.setValue("\(microbialFeatherDetailsList.AgeWeeks ?? 0)", forKey: "weeks")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    class func updatePlateIdGenerates(entity: String, predicate: NSPredicate, barcode: String) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherPulpSampleInfo]
            if let arrPlate = results {
                for i in 0..<arrPlate.count{
                    results?[i].setValue("\(barcode)-\(i + 1)", forKey: "plateIdGenerated")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
}


//MARK:- MicrobialFeatherpulpServiceTestSampleInfo
extension MicrobialFeatherpulpServiceTestSampleInfo{
    
    class func deleteWithPredicatesFeaherPulpSampleInfo() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherpulpServiceTestSampleInfo")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate.init(format: "isSessionType==\(1)")
        if let objects = try? managedContext.fetch(fetchRequest) {
            for obj in objects {
                managedContext.delete(obj as! NSManagedObject)
            }
            
            do {
                try managedContext.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    class func saveFirstTimeTestOptionValuesInDB(timeStamp: String, testId: NSNumber, testType: String, isSessionType: Bool, isCheckBoxSelected: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherpulpServiceTestSampleInfo", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        managedObject.setValue(testId, forKey: "testId")
        managedObject.setValue(testType, forKey: "testType")
        managedObject.setValue(isSessionType, forKey: "isSessionType")
        managedObject.setValue(isCheckBoxSelected, forKey: "isCheckBoxSelected")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    class func fetchDataOfTestOptions(predicate: NSPredicate) -> [MicrobialFeatherpulpServiceTestSampleInfo] {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherpulpServiceTestSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherpulpServiceTestSampleInfo]
            if let arrPlate = results {
                return arrPlate
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
        return []
    }
    
    class func updateBoolTypesTestOptions(key: String, value: Bool, predicate: NSPredicate) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherpulpServiceTestSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherpulpServiceTestSampleInfo]
            if let arrPlate = results {
                for i in 0..<arrPlate.count{
                    results?[i].setValue(value, forKey: key)
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func updateDataOfTestOptions(key: String, value: String, predicate: NSPredicate) {
        let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialFeatherpulpServiceTestSampleInfo")
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [MicrobialFeatherpulpServiceTestSampleInfo]
            if let arrPlate = results {
                for i in 0..<arrPlate.count{
                    results?[i].setValue(value, forKey: key)
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
}



//MARK:- MicrobialFeatherPulpTestOptions
extension MicrobialFeatherPulpTestOptions{
    class func saveTestOptionValuesInDB(id: NSNumber, text: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialFeatherPulpTestOptions", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
}


extension MicrobialCaseStatus{
    class func saveCaseStatus(id: NSNumber, text: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialCaseStatus", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(id, forKey: "id")
        managedObject.setValue(text, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
}

extension Microbial_EnviromentalSurveyFormSubmitted{
    
    class func saveDataWhichIsAlreadySynced(reqData: MicrobialDetailsList, reqText: String, reqId: Int, isPlateIdGenerated: Bool, reviewerText: String) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_EnviromentalSurveyFormSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        managedObject.setValue(reqData.timeStamp, forKey: "timeStamp")
        managedObject.setValue(UserDefaults.standard.value(forKey: "Id") ?? 0, forKey: "userId")
        managedObject.setValue(reqData.visitReason ?? 0, forKey: "reasonForVisitId")
        
        if let typeOfBirdId = reqData.typeOfBirdId{
            managedObject.setValue(FeatherPulpVC.getTypeOfBirdFromItsId(id: typeOfBirdId), forKey: "typeOfBird")
        }else{
            managedObject.setValue("", forKey: "typeOfBird")
        }
        
        managedObject.setValue(reqData.typeOfBirdId ?? 0, forKey: "typeOfBirdId")
        managedObject.setValue(UserDefaults.standard.value(forKey: "FirstName") as? String ?? "", forKey: "requestor")
        managedObject.setValue(isPlateIdGenerated, forKey: "isPlateIdGenerated")
        managedObject.setValue(reqData.deviceId ?? "", forKey: "syncDeviceId")
        
        if let visitReasonId = reqData.visitReason{ managedObject.setValue(RequisitionModel().getReasonForVisitFromItsId(reasonForVisitId: visitReasonId), forKey: "reasonForVisit")
        }else{
            managedObject.setValue("", forKey: "reasonForVisit")
        }
        
        managedObject.setValue(reqData.conductedType ?? 0, forKey: "surveyConductedOnId")
        
        
        managedObject.setValue(reqData.purposeType ?? 0, forKey: "purposeOfSurveyId")
        
        if let purposeType = reqData.purposeType{
            managedObject.setValue(RequisitionModel().getPurposeOfSurveyFromItsId(purposeOfSurveyId: purposeType), forKey: "purposeOfSurvey")
        }else{
            managedObject.setValue("", forKey: "purposeOfSurvey")
        }
        
        managedObject.setValue(0, forKey: "reviewerId")
        managedObject.setValue(reviewerText, forKey: "reviewer")
        
        //        managedObject.setValue(reqData.requestorId ?? 0, forKey: "requestor_Id")
        //        managedObject.setValue(reqData.requestorId ?? 0, forKey: "requestor")
        
        managedObject.setValue(reqData.customerId ?? 0, forKey: "companyId")
        
        if let customerId = reqData.customerId{
            managedObject.setValue(RequisitionModel().getCompanyfromId(id: customerId), forKey: "company")
        }else{
            managedObject.setValue("", forKey: "company")
        }
        
        managedObject.setValue(reqData.siteId ?? 0, forKey: "siteId")
        
        if let siteId = reqData.siteId{
            managedObject.setValue(RequisitionModel().getSiteIdforSelectedSite(id: siteId), forKey: "site")
        }else{
            managedObject.setValue("", forKey: "site")
        }
        
        managedObject.setValue(reqData.barcode ?? "", forKey: "barcode")
        managedObject.setValue(reqData.sampleDate ?? "", forKey: "sampleCollectionDate")
        managedObject.setValue(true, forKey: "isSynced")
        managedObject.setValue(reqData.deviceId ?? "", forKey: "syncDeviceId")
        managedObject.setValue(reqData.notes ?? "", forKey: "notes")
        managedObject.setValue(reqData.conductedType ?? 0, forKey: "surveyConductedOnId")
        
        if let conductedType = reqData.conductedType{
            managedObject.setValue(RequisitionModel().getSurveyConductedOnFromItsId(surveyConductedOnId: conductedType), forKey: "surveyConductedOn")
        }else{
            managedObject.setValue("", forKey: "surveyConductedOn")
        }
        
        //        managedObject.setValue(RequisitionModel().getSurveyConductedOnFromItsId(surveyConductedOnId: reqData.conductedType ?? 0) , forKey: "surveyConductedOn")
        
        managedObject.setValue(reqId, forKey: "requisitionType")
        managedObject.setValue(reqData.barcode ?? "", forKey: "requisition_Id")
        managedObject.setValue(reqData.sessionStatus ?? 0, forKey: "sessionStatus")
        managedObject.setValue(reqData.status ?? 0, forKey: "reqStatus")
        managedObject.setValue(reqData.requisitionNo ?? "", forKey: "reqNo")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
    
    class func doReqOfSameSiteAndSameDateExists(siteId: Int, sampleCollectionDate: String, reqType: Int, sessionStatus: SessionStatus) -> Bool{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        let userId = UserDefaults.standard.value(forKey: "Id") ?? 0
        if sessionStatus == .submitted{
            fetchRequest.predicate = NSPredicate(format: "siteId == %@ AND userId == %d AND sampleCollectionDate == %@ AND requisitionType == %d AND sessionStatus == %d", argumentArray: [siteId, userId, sampleCollectionDate, reqType, SessionStatus.submitted.rawValue])
        }else{
            fetchRequest.predicate = NSPredicate(format: "siteId == %@ AND userId == %d AND sampleCollectionDate == %@ AND requisitionType == %d", argumentArray: [siteId, userId, sampleCollectionDate, reqType])
        }
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_EnviromentalSurveyFormSubmitted]
            if let results = fetchedResult {
                return results.count > 0
            }
        } catch {
            print("test message")
        }
        return false
    }
    
    
    
    class func isSameTimeStampAndUserIdAlreadyExisits(reqData: MicrobialDetailsList) -> Bool{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        let userId = UserDefaults.standard.value(forKey: "Id") ?? 0
        fetchRequest.predicate = NSPredicate(format: "timeStamp == %@ AND userId == %d", argumentArray: [reqData.timeStamp ?? "", userId])
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_EnviromentalSurveyFormSubmitted]
            if let results = fetchedResult {
                return results.count > 0
            }
        } catch {
            print("test message")
        }
        return false
    }
    
    
    class func dataToBeSynced(requisitionType: Int) -> NSArray {
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        let userId = UserDefaults.standard.value(forKey: "Id") ?? 0
        fetchRequest.predicate = NSPredicate(format: "requisitionType == \(requisitionType) AND userId == \(userId) AND isSynced == 0")
        //NSPredicate(format: "sessionStatus == %@ AND requisitionType == %@ AND isSynced == 0 AND userId == %d", "\(sessionStatus)", "\(requisitionType)", "\(userId)")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_EnviromentalSurveyFormSubmitted]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    class func fetchSubmittedOrSaveAsDraftRequisitionsForGraphs(sessionStatus: Int, requisitionType: Int) -> NSArray {
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        let userId = UserDefaults.standard.value(forKey: "Id") ?? 0
        fetchRequest.predicate = NSPredicate(format: "sessionStatus == \(sessionStatus) AND requisitionType == \(requisitionType) AND userId == \(userId)")
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_EnviromentalSurveyFormSubmitted]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    class func updateCaseStatusOfReq(timeStamp: String, caseStatus: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp2, argumentArray: [timeStamp])
        if let objects = try? managedContext.fetch(fetchRequest) {
            for obj in objects {
                (obj as! Microbial_EnviromentalSurveyFormSubmitted).setValue(caseStatus, forKey: "reqStatus")
                do {
                    try managedContext.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
            }
        }
    }
    
    class func updateSyncCheckForAll(reqType: Int, sessionStatus: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_EnviromentalSurveyFormSubmitted")
        fetchRequest.predicate = NSPredicate(format: "requisitionType == \(reqType) AND sessionStatus == \(sessionStatus)", argumentArray: [])
        if let objects = try? managedContext.fetch(fetchRequest) {
            for obj in objects {
                (obj as! Microbial_EnviromentalSurveyFormSubmitted).setValue(true, forKey: "isSynced")
                do {
                    try managedContext.save() // <- remember to put this :)
                } catch {
                    // Do something... fatalerror
                }
            }
        }
    }
}

extension Microbial_LocationTypeHeadersSubmitted{
    
    class func isSameTimeStampAlreadyExistsInHeader(reqData: MicrobialDetailsList, section: Int) -> Bool{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "timeStamp == %@ AND section == %d", argumentArray: [reqData.timeStamp ?? "", section])
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeadersSubmitted]
            if let results = fetchedResult {
                return results.count > 0
            }
        } catch {
            print("test message")
        }
        return false
    }
    
    class func saveSampleInfoHeaderDataInToDB_Enviromental(reqDetails: MicrobialDetailsList, headerDetails: MicrobialSampleDetailsList, reqId: Int, reqName: String, numOfPlates: Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeadersSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(reqDetails.sampleDate ?? "", forKey: "currentdate")
        managedObject.setValue("", forKey: "customerId")
        managedObject.setValue(reqId, forKey: "requisitionType")
        managedObject.setValue(reqDetails.status ?? 0, forKey: "sessionStatus")
        
        managedObject.setValue(RequisitionModel().getLocationType(id: headerDetails.locationType ?? 0, reqType: reqId), forKey: "locationType")
        managedObject.setValue(headerDetails.locationType ?? 0, forKey: "locationTypeId")
        managedObject.setValue(numOfPlates, forKey: "noOfPlates")
        managedObject.setValue(headerDetails.section ?? 0, forKey: "section")
        managedObject.setValue(reqDetails.barcode ?? "", forKey: "requisition_Id")
        managedObject.setValue(reqDetails.timeStamp ?? "", forKey: "timeStamp")
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    class func incrementNumOfPlates(reqDetails: MicrobialDetailsList, section: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        
        fetchRequest.predicate = NSPredicate(format: "timeStamp = %@  AND section == %d", argumentArray: [reqDetails.timeStamp ?? "", section])
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    data.setValue((data.value(forKey: "noOfPlates") as! Int) + 1, forKey: "noOfPlates")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func updateBarcode(barCode: String, timeStamp: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeadersSubmitted")
        
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp, argumentArray: [timeStamp])
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    data.setValue(barCode, forKey: "requisition_Id")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
}


extension Microbial_LocationTypeHeaderPlatesSubmitted{
    
    class func updateSection(prevSection: Int, newSection: Int, timeStamp: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlatesSubmitted")
        let predicate = NSPredicate(format: "timeStamp = %@ AND section = %i", argumentArray: [timeStamp, prevSection])
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [Microbial_LocationTypeHeaderPlatesSubmitted]
            if results?.count != 0 { // Atleast one was returned
                for index in 0..<results!.count{
                    results![index].setValue(newSection , forKey: "section")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    class func updateBarcode(barCode: String, timeStamp: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlatesSubmitted")
        
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp, argumentArray: [timeStamp])
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    data.setValue(barCode, forKey: "requisition_Id")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func saveSampleInfoPlateDataInToDB_Enviromental(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, isBacterialChecked: Bool, isMicoscoreChecked: Bool, locationTypeId: Int, locationValue: String, plateId: String, row: Int, sampleDescription: String, section: Int, requisition_Id: String, timeStamp: String, locationValueId: Int, mediaTypeId: Int, notes: String ,  samplingMethodTypeId: Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaderPlatesSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(currentdate, forKey: "currentdate")
        managedObject.setValue(customerId, forKey: "customerId")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        managedObject.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
        managedObject.setValue(isBacterialChecked, forKey: "isBacterialChecked")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(mediaTypeId, forKey: "mediaTypeId")
        managedObject.setValue(samplingMethodTypeId, forKey: "samplingMethodTypeId")
        managedObject.setValue(plateId, forKey: "plateId")
        managedObject.setValue(row, forKey: "row")
        managedObject.setValue(sampleDescription, forKey: "sampleDescription")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        managedObject.setValue(locationValueId, forKey: "locationValueId")
        managedObject.setValue(notes, forKey: "notes")
        managedObject.setValue(RequisitionModel().getLocationValuesFromIds(id: locationValueId), forKey: "locationValue")
        
        do {
            try managedContext.save()
        } catch { }
    }
    
    
    class func saveSampleInfoPlateDataInToDB(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, isBacterialChecked: Bool, isMicoscoreChecked: Bool, locationTypeId: Int, locationValue: String, plateId: String, row: Int, sampleDescription: String, section: Int, requisition_Id: String, timeStamp: String, locationValueId: Int, mediaTypeValue: String, mediaTypeId: Int, notes: String ,samplingMethodTypeValue : String, samplingMethodTypeId : Int) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaderPlatesSubmitted", in: managedContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        managedObject.setValue(currentdate, forKey: "currentdate")
        managedObject.setValue(customerId, forKey: "customerId")
        managedObject.setValue(requisitionType, forKey: "requisitionType")
        managedObject.setValue(sessionStatus, forKey: "sessionStatus")
        managedObject.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
        managedObject.setValue(isBacterialChecked, forKey: "isBacterialChecked")
        managedObject.setValue(locationTypeId, forKey: "locationTypeId")
        managedObject.setValue(plateId, forKey: "plateId")
        managedObject.setValue(row, forKey: "row")
        managedObject.setValue(sampleDescription, forKey: "sampleDescription")
        managedObject.setValue(section, forKey: "section")
        managedObject.setValue(requisition_Id, forKey: "requisition_Id")
        managedObject.setValue(timeStamp, forKey: "timeStamp")
        managedObject.setValue(RequisitionModel().getLocationValues(selectedValue: locationValue), forKey: "locationValueId")
        managedObject.setValue(locationValue, forKey: "locationValue")
        managedObject.setValue(mediaTypeValue, forKey: "mediaTypeValue")
        managedObject.setValue(mediaTypeId, forKey: "mediaTypeId")
        managedObject.setValue(notes, forKey: "notes")
        
        managedObject.setValue(samplingMethodTypeValue, forKey: "samplingMethodTypeValue")
        managedObject.setValue(samplingMethodTypeId, forKey: "samplingMethodTypeId")
        do {
            try managedContext.save()
        } catch { }
    }
    
    
    class func deleteAndUpdateCountSampleInfoPlateDataInToDB_Enviromental(predicate: NSPredicate){
        let entity = "Microbial_LocationTypeHeaderPlatesSubmitted"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequestOfPlates = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequestOfPlates.predicate = predicate
        //NSPredicate(format: "timeStamp = %@ AND requisition_Id = %@ AND requisitionType = %i AND section = %i AND locationTypeId = %i AND row = %i", argumentArray: [timeStamp, requisition_Id, requisitionType, section, locationTypeId, row])
        do {
            let results = try context.fetch(fetchRequestOfPlates)
            if results.count > 0{
                for obj in results{
                    context.delete(obj as! NSManagedObject)
                    try context.save()
                }
            }
        } catch {
            //   print("ERROR - deleting")
        }
    }
    
    class func fetchEnviromentalPlatesWith(timeStamp: String) -> [Microbial_LocationTypeHeaderPlatesSubmitted] {
        
        var dataArray = [Microbial_LocationTypeHeaderPlatesSubmitted]()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlatesSubmitted")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp2, timeStamp)
        
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [Microbial_LocationTypeHeaderPlatesSubmitted]
            if let results = fetchedResult {
                dataArray = results
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return dataArray
    }
    
    
    class func updateSampleInfoPlateDataInToDB_Enviromental(currentdate: String, customerId: String, requisitionType: Int, sessionStatus: Int, isBacterialChecked: Bool, isMicoscoreChecked: Bool, locationTypeId: Int, locationValue: String, locationValueId: Int, plateId: String, row: Int, sampleDescription: String, section: Int, requisition_Id: String, timeStamp: String, prevSection: Int, mediaTypeValue: String, mediaTypeId: Int, notes: String,samplingMethodTypeId : Int, samplingMethodTypeValue :String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Microbial_LocationTypeHeaderPlatesSubmitted")
        
        fetchRequest.predicate = NSPredicate(format: "timeStamp = %@ AND requisition_Id = %@ AND requisitionType = %i AND section = %i AND locationTypeId = %i AND row = %i", argumentArray: [timeStamp, requisition_Id, requisitionType, section, locationTypeId, row])
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    data.setValue(currentdate, forKey: "currentdate")
                    data.setValue(customerId, forKey: "customerId")
                    data.setValue(requisitionType, forKey: "requisitionType")
                    data.setValue(sessionStatus, forKey: "sessionStatus")
                    data.setValue(isBacterialChecked, forKey: "isBacterialChecked")
                    data.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
                    data.setValue(locationTypeId, forKey: "locationTypeId")
                    data.setValue(locationValue, forKey: "locationValue")
                    data.setValue(mediaTypeValue, forKey: "mediaTypeValue")
                    data.setValue(plateId, forKey: "plateId")
                    data.setValue(row, forKey: "row")
                    data.setValue(sampleDescription, forKey: "sampleDescription")
                    data.setValue(section, forKey: "section")
                    data.setValue(requisition_Id, forKey: "requisition_Id")
                    data.setValue(timeStamp, forKey: "timeStamp")
                    data.setValue(locationValueId, forKey: "locationValueId")
                    data.setValue(mediaTypeId, forKey: "mediaTypeId")
                    data.setValue(notes, forKey: "notes")
                    data.setValue(samplingMethodTypeId, forKey: "samplingMethodTypeId")
                    data.setValue(samplingMethodTypeValue, forKey: "samplingMethodTypeValue")
                    
                }
            }else{
                
                let entity = NSEntityDescription.entity(forEntityName: "Microbial_LocationTypeHeaderPlatesSubmitted", in: context)
                let managedObject = NSManagedObject(entity: entity!, insertInto: context)
                
                managedObject.setValue(currentdate, forKey: "currentdate")
                managedObject.setValue(customerId, forKey: "customerId")
                managedObject.setValue(requisitionType, forKey: "requisitionType")
                managedObject.setValue(sessionStatus, forKey: "sessionStatus")
                managedObject.setValue(isMicoscoreChecked, forKey: "isMicoscoreChecked")
                managedObject.setValue(isBacterialChecked, forKey: "isBacterialChecked")
                managedObject.setValue(locationTypeId, forKey: "locationTypeId")
                managedObject.setValue(locationValue, forKey: "locationValue")
                managedObject.setValue(mediaTypeValue, forKey: "mediaTypeValue")
                managedObject.setValue(plateId, forKey: "plateId")
                managedObject.setValue(row, forKey: "row")
                managedObject.setValue(sampleDescription, forKey: "sampleDescription")
                managedObject.setValue(section, forKey: "section")
                managedObject.setValue(requisition_Id, forKey: "requisition_Id")
                managedObject.setValue(timeStamp, forKey: "timeStamp")
                managedObject.setValue(locationValueId, forKey: "locationValueId")
                managedObject.setValue(mediaTypeId, forKey: "mediaTypeId")
                managedObject.setValue(notes, forKey: "notes")
                managedObject.setValue(samplingMethodTypeId, forKey: "samplingMethodTypeId")
                managedObject.setValue(samplingMethodTypeValue, forKey: "samplingMethodTypeValue")
                
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
}

extension Microbial_EnvironmentalLocationTypes{
    class func saveLocationTypesInDB(_ locationId: NSNumber, locationName: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_EnvironmentalLocationTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(locationId, forKey: "id")
        person.setValue(locationName, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
    }
}

extension Microbial_BacterialLocationTypes{
    class func saveLocationTypesInDB(_ locationId: NSNumber, locationName: String) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Microbial_BacterialLocationTypes", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(locationId, forKey: "id")
        person.setValue(locationName, forKey: "text")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
        
    }
}


extension MicrobialSelectedUnselectedReviewer{
    
    class func deleteReviewer(predicate: NSPredicate){
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        if let fetchedResult = try? managedContext.fetch(fetchRequest) as? [MicrobialSelectedUnselectedReviewer] {
//            if let results = fetchedResult {
                for obj in fetchedResult {
                    managedContext.delete(obj as NSManagedObject)
                }
//            }
            do {
                try managedContext.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    class func fetchDetailsForReviewer(predicate: NSPredicate) -> [MicrobialSelectedUnselectedReviewer] {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [MicrobialSelectedUnselectedReviewer]
            if let results = fetchedResult {
                return results
                
            } else {
                
            }
        } catch {
            print("test message")
        }
        
        return []
        
    }
    
    
    class func deleteDraftType(timeStamp: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: appDelegate.timeStamp, timeStamp)
        if let objects = try? managedContext.fetch(fetchRequest) {
            for obj in objects {
                managedContext.delete(obj as! NSManagedObject)
            }
            
            do {
                try managedContext.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    class func deleteSessionType() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate.init(format: "isSessionType==\(1)")
        if let objects = try? managedContext.fetch(fetchRequest) {
            for obj in objects {
                managedContext.delete(obj as! NSManagedObject)
            }
            
            do {
                try managedContext.save() // <- remember to put this :)
            } catch {
                // Do something... fatalerror
            }
        }
    }
    
    
    class func updateBoolValueOfReviewer(predicate: NSPredicate) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    let isSelected = data.value(forKey: "isSelected") as! Bool
                    data.setValue(!isSelected, forKey: "isSelected")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    
    class func updateTimeStampFromSession(predicate: NSPredicate, timeStamp: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for data in results ?? []{
                    data.setValue(timeStamp, forKey: "timeStamp")
                    data.setValue(false, forKey: "isSessionType")
                }
            }
        } catch {
            //   print("Fetch Failed: \(error)")
        }
        
        do {
            try context.save()
        }
        catch {
            //   print("Saving Core Data Failed: \(error)")
        }
    }
    
    class func doReviewersExisitsFortheTimeStamp(predicate: NSPredicate) -> Bool{
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MicrobialSelectedUnselectedReviewer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [MicrobialSelectedUnselectedReviewer]
            if let results = fetchedResult {
                return results.count > 0
            }
        } catch {
            print("test message")
        }
        return false
    }
    
    class func saveReviewersInDB(_ timeStamp: String, reviewerId: Int, reviewerName: String, isSelected: Bool, isSessionType: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "MicrobialSelectedUnselectedReviewer", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(isSelected, forKey: "isSelected")
        person.setValue(isSessionType, forKey: "isSessionType")
        person.setValue(reviewerId, forKey: "reviewerId")
        person.setValue(reviewerName, forKey: "reviewerName")
        person.setValue(timeStamp, forKey: "timeStamp")
        do {
            try managedContext.save()
        } catch {
            print("test message")
        }
    }
}

