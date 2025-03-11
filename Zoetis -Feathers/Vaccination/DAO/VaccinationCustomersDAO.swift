//
//  VaccinationCustomersDAO.swift
//  Zoetis -Feathers
//
//  Created by Mobile Programming on 08/07/20.
//  Copyright © 2020 . All rights reserved.
//

import Foundation
import CoreData
import UIKit

final  public class VaccinationCustomersDAO{
    private init(){print("Initializer")}
    static let sharedInstance = VaccinationCustomersDAO()
    private var shippingInfo = [NSManagedObject]()
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)!.managedObjectContext
    
    func getVaccineCustomerObj() -> VaccinationCustomers{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationCustomers" , into: managedContext) as! VaccinationCustomers
        return vaccinationCertObj
    }
    
    func getVaccinationCustomerSiteObj() -> VaccinationCustomerSites{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationCustomerSites" , into: managedContext) as! VaccinationCustomerSites
        return vaccinationCertObj
    }
    
    func getVaccinationFSMListObj() -> VaccinationFSMList{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationFSMList" , into: managedContext) as! VaccinationFSMList
        return vaccinationCertObj
    }
    
    func getVaccinationStateListObj() -> VaccinationStatesList{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationStatesList" , into: managedContext) as! VaccinationStatesList
        return vaccinationCertObj
    }
    
    func getShippingAddressDetailListObj() -> VaccinationShippingAddress{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationShippingAddress" , into: managedContext) as! VaccinationShippingAddress
        return vaccinationCertObj
    }
    
    func getVaccinationCountryListObj() -> VaccinationCountryList{
        let vaccinationCertObj = NSEntityDescription.insertNewObject(forEntityName: "VaccinationCountryList" , into: managedContext) as! VaccinationCountryList
        return vaccinationCertObj
    }
    
    func fetchCustomers(userId:String) -> [VaccinationCustomers]{
        var vaccinationMasterDataArr = [VaccinationCustomers]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationCustomers")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"userId = %@", userId)
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationCustomers]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func fetchAllCustomerSites(userId:String, customerId:String?)-> [VaccinationCustomerSites]{
        var vaccinationMasterDataArr = [VaccinationCustomerSites]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationCustomerSites")
        fetchRequest.returnsObjectsAsFaults = false
        if  customerId  != nil && !customerId!.isEmpty{
            fetchRequest.predicate = NSPredicate(format:"userId = %@ AND customerId = %@", userId, customerId!)
        }else{
            fetchRequest.predicate = NSPredicate(format:"userId = %@", userId)
        }
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationCustomerSites]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func fetchAllFSMList(userId:String)-> [VaccinationFSMList]{
        var vaccinationMasterDataArr = [VaccinationFSMList]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationFSMList")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"userId = %@", userId)
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationFSMList]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func fetchAllStateList(userId:String, countryId: String = "0")-> [VaccinationStatesList]{
        var vaccinationMasterDataArr = [VaccinationStatesList]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationStatesList")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationStatesList]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func fetchCountryIdFromCountryName(countryName: String)-> [VaccinationCountryList]{
        var vaccinationMasterDataArr = [VaccinationCountryList]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationCountryList")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"vcountryName = %@", countryName)
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationCountryList]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func fetchCountryNameFromCountryId(countryId: String)-> String {
        var str = ""
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationCountryList")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"countryId = %@", countryId)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                for result in results ?? []{
                    let countryName =  result.value(forKey: "vcountryName")  as? String
                    str = countryName ?? ""
                }
            }
            return str
        } catch {
            return str
        }
    }
    
    func fetchStateNameFromStateId(stateId: String)-> String {
        var str = ""
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationStatesList")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format:"stateId = %@", stateId)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                for result in results ?? []{
                    let countryName =  result.value(forKey: "stateName")  as? String
                    str = countryName ?? ""
                }
            }
            return str
        } catch {
            return str
        }
    }
    
    func fetchAllCountryList()-> [VaccinationCountryList] {
        var vaccinationMasterDataArr = [VaccinationCountryList]()
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationCountryList")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            vaccinationMasterDataArr = try managedContext.fetch(fetchRequest) as! [VaccinationCountryList]
        } catch{
            debugPrint("Error while fetching Customers Master Data in \(type(of: self))")
        }
        return vaccinationMasterDataArr
    }
    
    func getCustomersVM(userId:String) -> [VaccinationCustomersVM]{
        var vaccinationCustomerArr = [VaccinationCustomersVM]()
        for obj in  fetchCustomers(userId:userId){
            if obj.value != nil{
                vaccinationCustomerArr.append(convertCustomerMoToVM(moObj: obj))
            }
        }
        return vaccinationCustomerArr
    }
    
    func getCustomerSitesVM(userId:String, customerId:String?)-> [VaccinationCustomerSitesVM]{
        var vaccinationCustomerSiteArr = [VaccinationCustomerSitesVM]()
        for obj in  fetchAllCustomerSites(userId:userId, customerId:customerId){
            vaccinationCustomerSiteArr.append(convertCustomerSitesMoToVM(moObj: obj))
        }
        return vaccinationCustomerSiteArr
    }
    
    func getFSMListVM(user_id: String)-> [VaccinationFSMVM]{
        var vaccinationFSMArr = [VaccinationFSMVM]()
        for obj in  fetchAllFSMList(userId: user_id){
            vaccinationFSMArr.append(convertFSMMoToVM(moObj: obj))
        }
        return vaccinationFSMArr
    }
    
    func getStateListVM(user_id: String)-> [VaccinationState]{
        var vaccinationStateArr = [VaccinationState]()
        for obj in  fetchAllStateList(userId: user_id){
            vaccinationStateArr.append(convertStateMoToVM(moObj: obj))
        }
        return vaccinationStateArr
    }
    
    func getCountryListVM()-> [VaccinationCountry]{
        var vaccinationCountryArr = [VaccinationCountry]()
        for obj in  fetchAllCountryList(){
            vaccinationCountryArr.append(convertCountryMoToVM(moObj: obj))
        }
        return vaccinationCountryArr
    }
    
    
    
    func deleteAllCustomers(userId:String){
        do {
            for cusomterObj in  fetchCustomers(userId:userId){
                managedContext.delete(cusomterObj)
            }
            try managedContext.save()
        } catch{
            debugPrint("Error while deletiong Certification Customers in \(type(of: self))  vaccination")
        }
    }
    
    func deleteAllCustomerSites(userId:String, customerId:String?){
        do {
            for cusomterObj in  fetchAllCustomerSites(userId:userId, customerId:customerId){
                managedContext.delete(cusomterObj)
            }
            try managedContext.save()
        } catch{
            debugPrint("Error while deletiong Certification CustomerSites in \(type(of: self))  vaccination")
        }
    }
    
    func deleteAllFSMList(user_id: String){
        do {
            for fsmListObj in  fetchAllFSMList(userId: user_id){
                managedContext.delete(fsmListObj)
            }
            try managedContext.save()
        } catch{
            debugPrint("Error while deletiong Field Service Manager in \(type(of: self))  vaccination")
        }
    }
    
    func deleteAllCountryList(user_id: String){
        do {
            for countryListObj in  fetchAllCountryList(){
                managedContext.delete(countryListObj)
            }
            try managedContext.save()
        } catch{
            debugPrint("Error while deletiong Field Service Manager in \(type(of: self))  vaccination")
        }
    }
    
    
    
    func deleteAllStateList(user_id: String){
        do {
            for stateListObj in  fetchAllStateList(userId: user_id){
                managedContext.delete(stateListObj)
            }
            try managedContext.save()
        } catch{
            debugPrint("Error while deletiong Field Service Manager in \(type(of: self))  vaccination")
        }
    }
    
    
    func convertDTOToMOCustomers(customerObj: CustomerDTO, moObj:VaccinationCustomers){
        moObj.id = customerObj.id?.description
        moObj.value = customerObj.text
    }
    
    func convertDTOToMOCustomerSites(customerSiteObj: CustomerSitesDTO, moObj:VaccinationCustomerSites){
        moObj.customerId = customerSiteObj.customerId?.description
        moObj.siteName = customerSiteObj.siteName
        moObj.siteId = customerSiteObj.siteId?.description
    }
    
    func convertDTOToMOFSMList(fsmListObj: FSMListDTO, moObj:VaccinationFSMList){
        moObj.fsmId = "\(fsmListObj.fsmId!)"
        moObj.fsmName = fsmListObj.fsmName
    }
    
    func convertDTOStateList(stateListObj: StateListDTO, moObj:VaccinationStatesList){
        moObj.stateId = "\(stateListObj.stateId!)"
        moObj.stateName = stateListObj.stateName
    }
    
    func convertDTOShippingAddressList(shippingAddressObj : ShippingAddressDTO, moObj : VaccinationShippingAddress)
    {
        moObj.stateId = NSNumber(value: shippingAddressObj.stateID ?? 0)
        moObj.certId = NSNumber(value: shippingAddressObj.id ?? 0)
        moObj.fssId = NSNumber(value: shippingAddressObj.fssID ?? 0)
        moObj.countryId = NSNumber(value: shippingAddressObj.countryID ?? 0)
        moObj.trainingId = NSNumber(value: shippingAddressObj.trainingID ?? 0)
        moObj.fssName = shippingAddressObj.fssName
        moObj.address1 = shippingAddressObj.address1
        moObj.address2 = shippingAddressObj.address2
        moObj.city = shippingAddressObj.city
        moObj.pincode = shippingAddressObj.pincode
    }
    
    
    func convertDTOCountryList(countryListObj: CountryListDTO, moObj:VaccinationCountryList){
        moObj.countryId = "\(countryListObj.countryId!)"
        moObj.vcountryName = countryListObj.countryNamee
        moObj.regionId =  "\(countryListObj.regionId!)"
    }
    
    
    func convertCustomerMoToVM(moObj:VaccinationCustomers) -> VaccinationCustomersVM{
        let customerObj = VaccinationCustomersVM()
        customerObj.customerId = moObj.id
        customerObj.customerName = moObj.value
        customerObj.userId = moObj.userId
        return customerObj
    }
    
    func convertCustomerSitesMoToVM(moObj:VaccinationCustomerSites)-> VaccinationCustomerSitesVM{
        let customerSiteObj = VaccinationCustomerSitesVM()
        customerSiteObj.customerId = moObj.customerId
        customerSiteObj.siteName = moObj.siteName
        customerSiteObj.siteId = moObj.siteId
        customerSiteObj.userId = moObj.userId
        return customerSiteObj
    }
    
    func convertFSMMoToVM(moObj:VaccinationFSMList)-> VaccinationFSMVM{
        let fsmObj = VaccinationFSMVM()
        fsmObj.fsmId = moObj.fsmId
        fsmObj.fsmName = moObj.fsmName
        return fsmObj
    }
    
    func convertCountryMoToVM(moObj:VaccinationCountryList)-> VaccinationCountry{
        let countryObj = VaccinationCountry()
        countryObj.countryName = moObj.vcountryName
        countryObj.countryId = moObj.countryId
        countryObj.regionId = moObj.regionId
        return countryObj
    }
    
    func convertStateMoToVM(moObj:VaccinationStatesList)-> VaccinationState{
        let stateObj = VaccinationState()
        stateObj.stateName = moObj.stateName
        stateObj.stateId = moObj.stateId
        return stateObj
    }
    
    func insertCustomers(userId:String,customerDTOArr: [CustomerDTO] ){
        do{
            if customerDTOArr.count > 0{
                deleteAllCustomers(userId: userId)
                for obj in customerDTOArr{
                    let customerObj = getVaccineCustomerObj()
                    customerObj.userId = userId
                    convertDTOToMOCustomers(customerObj: obj, moObj: customerObj)
                }
                
                try managedContext.save()
            }
        } catch{
            managedContext.rollback()
            debugPrint("Error while saving Custiomers in \(type(of: self))")
        }
    }
    
    func insertCustomerSites(userId:String,customerDTOArr: [CustomerSitesDTO] ){
        do{
            if customerDTOArr.count>0{
                
                
                deleteAllCustomerSites(userId:userId , customerId: nil)
                for obj in customerDTOArr{
                    let customerObj = getVaccinationCustomerSiteObj()
                    customerObj.userId = userId
                    convertDTOToMOCustomerSites(customerSiteObj: obj, moObj: customerObj)
                }
                try managedContext.save()
            }
        } catch{
            managedContext.rollback()
            debugPrint("Error while saving Started Certifications in \(type(of: self))")
        }
    }
    
    func insertFSMList(userId:String,FSMListDTOArr: [FSMListDTO] ){
        do{
            if FSMListDTOArr.count>0{
                
                
                deleteAllFSMList(user_id: userId)
                for obj in FSMListDTOArr{
                    let fsmListObj = getVaccinationFSMListObj()
                    fsmListObj.userId = userId
                    convertDTOToMOFSMList(fsmListObj: obj, moObj: fsmListObj)
                }
                try managedContext.save()
            }
        } catch{
            managedContext.rollback()
            debugPrint("Error while saving Started Certifications in \(type(of: self))")
        }
    }
    
    func insertStateList(userId:String,StateListDTOArr: [StateListDTO] ){
        do{
            if StateListDTOArr.count>0{
                
                deleteAllStateList(user_id: userId)
                for obj in StateListDTOArr{
                    let stateListObj = getVaccinationStateListObj()
                    convertDTOStateList(stateListObj: obj, moObj: stateListObj)
                }
                try managedContext.save()
            }
        } catch{
            managedContext.rollback()
            debugPrint("Error while saving Started State's List in \(type(of: self))")
        }
    }
    
    func saveShippingInfoInDB(newAssessment:[ShippingAddressDTO]?) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "VaccinationShippingAddress", in: managedContext)
        
        let assessmentObj = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        if newAssessment != nil {
            for result in newAssessment! {
                assessmentObj.setValue(result.id ?? 0, forKey: "certId")
                assessmentObj.setValue(result.stateID, forKey: "stateId")
                assessmentObj.setValue(result.countryID, forKey: "countryId")
                assessmentObj.setValue(result.fssID, forKey: "fssId")
                assessmentObj.setValue(result.trainingID, forKey: "trainingId")
                assessmentObj.setValue(result.fssName, forKey: "fssName")
                assessmentObj.setValue(result.city, forKey: "city")
                assessmentObj.setValue(result.address1, forKey: "address1")
                assessmentObj.setValue(result.address2, forKey: "address2")
                assessmentObj.setValue(result.pincode, forKey: "pincode")
            }
        }


        do {
            try managedContext.save()
        } catch {
            print("Test Body")
        }
        shippingInfo.append(assessmentObj)
    }
    
    func deleteShippingInfoByFssId(_ fssId: Int) {
        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationShippingAddress")
        fetchRequest.returnsObjectsAsFaults = false
        let userID =  UserDefaults.standard.value(forKey:"Id") as? Int ?? 0
        fetchRequest.predicate = NSPredicate(format: "fssId == %d", fssId)
        
        do {
            let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedContext.delete(item)
            }

            try managedContext.save()
            
        } catch {
         
        }
    }
    
    func fetchShippingInfo(fssId:Int , FsrId:Int = 0) -> ShippingAddressDTO? {
        var shippingInfo = ShippingAddressDTO(fssName: "", fssID: 0, trainingID: 0, id: 0, city: "", address2: "", stateID: 0, countryID: 0, address1: "", pincode: "")
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        var fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationShippingAddress")
        if fssId == 0
        {
           
            fetchRequest.predicate = NSPredicate(format: "fssId = %d",FsrId)
        }
        else
        {
             fetchRequest.predicate = NSPredicate(format: "fssId = %d",fssId)
        }
        
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                for result in results {
                    shippingInfo.id =  result.value(forKey: "certId") as? Int ?? 0
                    shippingInfo.stateID =  result.value(forKey: "stateId") as? Int ?? 0
                    shippingInfo.countryID =  result.value(forKey: "countryId") as? Int ?? 0
                    shippingInfo.fssID =  result.value(forKey: "fssId") as? Int
                    shippingInfo.trainingID =  result.value(forKey: "trainingId") as? Int
                    shippingInfo.fssName =  result.value(forKey: "fssName") as? String
                    shippingInfo.city =  result.value(forKey: "city") as? String
                    shippingInfo.address1 =  result.value(forKey: "address1") as? String
                    shippingInfo.address2 =  result.value(forKey: "address2") as? String
                    shippingInfo.pincode =  result.value(forKey: "pincode") as? String
                }
            }
        } catch {
            print("Test Body")
        }
        return shippingInfo
    }
    
    func deleteAllData(_ entity: String) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try! managedContext.fetch(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch let error as NSError {
            print("Test Body")
        }
    }
    
    func fetchShippingInfoByTrainingId(trainingId:Int) -> ShippingAddressDTO? {
        var shippingInfo = ShippingAddressDTO(fssName: "", fssID: 0, trainingID: 0, id: 0, city: "", address2: "", stateID: 0, countryID: 0, address1: "", pincode: "")
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        var fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationShippingAddress")
        fetchRequest.predicate = NSPredicate(format: "trainingId = %d",trainingId)
        
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                
                for result in results {
                    shippingInfo.id =  result.value(forKey: "certId") as? Int ?? 0
                    shippingInfo.stateID =  result.value(forKey: "stateId") as? Int ?? 0
                    shippingInfo.countryID =  result.value(forKey: "countryId") as? Int ?? 0
                    shippingInfo.fssID =  result.value(forKey: "fssId") as? Int
                    shippingInfo.trainingID =  result.value(forKey: "trainingId") as? Int
                    shippingInfo.fssName =  result.value(forKey: "fssName") as? String
                    shippingInfo.city =  result.value(forKey: "city") as? String
                    shippingInfo.address1 =  result.value(forKey: "address1") as? String
                    shippingInfo.address2 =  result.value(forKey: "address2") as? String
                    shippingInfo.pincode =  result.value(forKey: "pincode") as? String
                }
            }
        } catch {
            print("Test Body")
        }
        return shippingInfo
    }
    
    
    func fetchShippingInfoArr(fssId:Int) -> [ShippingAddressDTO] {
        var dataArray = [ShippingAddressDTO]()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VaccinationShippingAddress")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "fssId = %d",fssId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = (results as? [ShippingAddressDTO])!
            } else {

            }
        } catch {
            print("Test Body")
        }
        return dataArray

    }
    
    func insertCountryList(userId:String,CountryListDTOArr: [CountryListDTO] ){
        do{
            if CountryListDTOArr.count>0{
                
                deleteAllCountryList(user_id: userId)
                for obj in CountryListDTOArr{
                    let countryListObj = getVaccinationCountryListObj()
                    convertDTOCountryList(countryListObj: obj, moObj: countryListObj)
                }
                try managedContext.save()
            }
        } catch{
            managedContext.rollback()
            debugPrint("Error while saving Started State's List in \(type(of: self))")
        }
    }
    
    
    
}
