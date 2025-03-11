//
//  CoreDataHandlerPVE.swift
//  Zoetis -Feathers
//
//  Created by NITIN KUMAR KANOJIA on 29/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON



class CoreDataHandlerPVE: NSObject {
    
    
    private var managedContext  = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType) //: NSManagedObjectContext! = nil

    private var CustData = [NSManagedObject]()
    private var ageOfBirdsData = [NSManagedObject]()
    private var breedOfBirdsData = [NSManagedObject]()
    private var siteIDData = [NSManagedObject]()
    private var evaluatorData = [NSManagedObject]()
    private var assignUserData = [NSManagedObject]()
    private var housingData = [NSManagedObject]()

    private var assessmentCat = [NSManagedObject]()
    private var assessmentQ = [NSManagedObject]()

    private var pve_Sync = [NSManagedObject]()

    private var routeArray = NSArray()
   // var custArray = NSArray()

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
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "Customer_PVE", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(custId, forKey: "customerId")
        person.setValue(CustName, forKey: "customerName")
        do {
            try managedContext.save()
        } catch {
        }

        CustData.append(person)

    }
    
    func fetchCustomerWithCustId(_ custId: NSNumber) -> NSArray {

        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Complex_PVE")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customerId == %@", custId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataArray

    }

    func fetchDetailsFor(entityName:String) -> NSArray {

        var dataArray = NSArray()

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataArray

    }


    func saveComplexDetailsInDB(_ custId: NSNumber, userId: NSNumber, complexId: NSNumber, complexName: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "Complex_PVE", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(complexName, forKey: "complexName")
        person.setValue(complexId, forKey: "complexId")
        person.setValue(custId, forKey: "customerId")
        person.setValue(userId, forKey: "userId")
        do {
            try managedContext.save()
        } catch {
        }

        CustData.append(person)

    }
    
    func saveEvaluationTypeInDB(_ evaluationId: NSNumber, evaluationName: String, isDeletd: Bool, module_Id:NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_EvaluationType", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(evaluationId, forKey: "evaluationId")
        person.setValue(evaluationName, forKey: "evaluationName")
        person.setValue(isDeletd, forKey: "isDeletd")
        person.setValue(module_Id, forKey: "module_Id")
        do {
            try managedContext.save()
        } catch {
        }

        breedOfBirdsData.append(person)

    }

    func saveEvaluationForInDB(_ id: NSNumber, name: String, isDeletd: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_EvaluationFor", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(name, forKey: "name")
        person.setValue(isDeletd, forKey: "isDeletd")
        do {
            try managedContext.save()
        } catch {
        }

        breedOfBirdsData.append(person)

    }

    
    func saveAgeOfBirdsDetailsInDB(_ id: NSNumber, bird_Id: NSNumber, age: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_AgeOfBirds", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(bird_Id, forKey: "bird_Id")
        person.setValue(age, forKey: "age")
        do {
            try managedContext.save()
        } catch {
        }

        ageOfBirdsData.append(person)

    }

    func saveBreedOfBirdsDetailsInDB(_ id: NSNumber, name: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_BreedOfBirds", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(name, forKey: "name")
        do {
            try managedContext.save()
        } catch {
        }

        breedOfBirdsData.append(person)

    }
    
    func saveSiteIDNameDetailsInDB(_ id: NSNumber, siteId: NSNumber, siteName:String, complex_Id:NSNumber, customerId:NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_SiteIDName", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(siteId, forKey: "site_Id")
        person.setValue(siteName, forKey: "site_Name")
        person.setValue(complex_Id, forKey: "complex_Id")
        person.setValue(customerId, forKey: "customer_Id")
        do {
            try managedContext.save()
        } catch {
        }

        siteIDData.append(person)

    }
    
    func fetchSiteNameAsPercustomerId(_ customerId: NSNumber) -> NSArray {

        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_SiteIDName")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customer_Id == %@", customerId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataArray

    }

    func saveEvaluatorDetailsInDB(_ id: NSNumber, firstName: String, lastName: String, fullName:String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_Evaluator", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(firstName, forKey: "firstName")
        person.setValue(lastName, forKey: "lastName")
        person.setValue(fullName, forKey: "fullName")
        do {
            try managedContext.save()
        } catch {
        }

        evaluatorData.append(person)

    }
    
    func saveAssignUserDetailsInDB(_ id: NSNumber, firstName: String, lastName: String, fullName:String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_AssignUserDetails", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "id")
        person.setValue(firstName, forKey: "firstName")
        person.setValue(lastName, forKey: "lastName")
        person.setValue(fullName, forKey: "fullName")
        do {
            try managedContext.save()
        } catch {
        }

        assignUserData.append(person)

    }

    func saveHousingDetailsInDB(_ id: NSNumber, housingName: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_Housing", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(id, forKey: "housingId")
        person.setValue(housingName, forKey: "housingName")
        do {
            try managedContext.save()
        } catch {
        }

        housingData.append(person)

    }


    func saveAssessmentCategoriesDetailsInDB(_ json:PVEAssessmentCategoriesDetailsRes) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
       // custArray = dbArray
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_AssessmentCategoriesDetails", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(json.id, forKey: "id")
        person.setValue(json.evaluation_Type_Id, forKey: "evaluation_Type_Id")
        person.setValue(json.hatchery_Module_Id, forKey: "hatchery_Module_Id")
        person.setValue(json.max_Mark, forKey: "max_Mark")
        person.setValue(json.seq_Number, forKey: "seq_Number")
        person.setValue(json.category_Name, forKey: "category_Name")
        
       // let encodedArray : NSData = NSKeyedArchiver.archivedData(withRootObject: json.assessmentQuestion) as NSData
        person.setValue(json.assessmentQuestion as NSObject, forKey: "assessmentQuestion")
        
        //saveAssessmentQuestionInDB(json.assessmentQuestion as! [[String : AnyObject]])

        do {
            try managedContext.save()
        } catch {
        }

        assessmentCat.append(person)

    }
    
    func saveAssessmentQuestionInDB(_ dict: [String  :Any], json:PVEAssessmentCategoriesDetailsRes) {
        
        print("dict-------\(dict)")
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_AssessmentQuestion", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        // let questionArr = json["AssessmentQuestion"].arrayObject
        
        person.setValue(dict["Id"] ?? 0, forKey: "id")
        person.setValue(dict["Assessment"] ?? "", forKey: "assessment")
        person.setValue(dict["Assessment2"] ?? "", forKey: "assessment2")
        person.setValue(dict["Min_Score"] ?? 0, forKey: "min_Score")
        person.setValue(dict["Mid_Score"] ?? 0, forKey: "mid_Score")
        person.setValue(dict["Max_Score"] ?? 0, forKey: "max_Score")
        person.setValue(dict["Types"] ?? "", forKey: "types")
        person.setValue(dict["PVE_Vacc_Type"] ?? "", forKey: "pVE_Vacc_Type")
        person.setValue(dict["Module_Cat_Id"] ?? 0, forKey: "module_Cat_Id")
        
        //// Related to category
        person.setValue(false, forKey: "isSelected")
        person.setValue(json.evaluation_Type_Id, forKey: "evaluation_Type_Id")
        person.setValue(json.hatchery_Module_Id, forKey: "hatchery_Module_Id")
        person.setValue(json.max_Mark, forKey: "max_Mark")
        person.setValue(json.seq_Number, forKey: "seq_Number")
        
        do {
            try managedContext.save()
        } catch {
        }
        
        assessmentQ.append(person)
    }
    
    
    func fetchAssessmentQuestion(_ seq_Number: NSNumber) -> NSArray {

        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "seq_Number == %@", seq_Number)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataArray

    }
    
    func fetchSumOfSelectedMarks(_ seqNo: NSNumber) -> String {

        var isSelected = Bool()
        isSelected = true
        var sumMarks = Int()
        var maxMarks = Int()
        var dataArray = NSArray()
       // var scoredArr = NSArray()
        
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "seq_Number == %@ AND isSelected == %@", argumentArray: [seqNo, isSelected])
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
                let max_ScoreArr = dataArray.value(forKey: "max_Score") as? [Int]
                for (_, obj) in max_ScoreArr!.enumerated() {
                    sumMarks = sumMarks + obj
                }
                

                fetchRequest.predicate = NSPredicate(format: "seq_Number == %@", argumentArray: [seqNo])
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                if let results = fetchedResult {
                    dataArray = results as NSArray
                    let max_MarksArr = dataArray.value(forKey: "max_Mark") as? [Int]
                    if max_MarksArr!.count > 0{
                    maxMarks = max_MarksArr![0]
                }
              }
            }
        } catch {
        }

        return "\(sumMarks)/\(maxMarks)"
    }

    func fetchScoredArr(_ seqNoArr: NSArray) -> (scoreArr:NSArray, max_MarksArr:NSArray){

        print("seqNoArr---\(seqNoArr)")
        
        var scoreArr = [Int]()
        var max_MarksArr = [Int]()
        
        for (_, seqNo) in seqNoArr.enumerated() {

        var isSelected = Bool()
        isSelected = true
        var dataArray = NSArray()
            var sumMarks = Int()

       // var scoredArr = NSArray()
        
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "seq_Number == %@ AND isSelected == %@", argumentArray: [seqNo, isSelected])
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
                
                let max_ScoreArr = dataArray.value(forKey: "max_Score") as? [Int]
                for (_, obj) in max_ScoreArr!.enumerated() {
                    sumMarks = sumMarks + obj
                }
                scoreArr.append(sumMarks)
                
                var arr = [Int]()
                arr = dataArray.value(forKey: "max_Mark") as? [Int] ?? []
                max_MarksArr.append(arr[0])
            }
        } catch {
        }

            }

        return (scoreArr: scoreArr as NSArray, max_MarksArr:max_MarksArr as NSArray)
    }

    
    
    func updateAssementDetails(_ seqNo: Int, id:Int, isSel:Bool) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "seq_Number == %@ AND id == %@", argumentArray: [seqNo, id])
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results![0].setValue(isSel, forKey: "isSelected")
            }
        } catch {
            print("Fetch Failed: \(error)")
            NotificationCenter.default.post(name: NSNotification.Name("reloadSNATblViewNoti"), object: nil, userInfo: nil)
        }

        do {
            try managedContext.save()
            NotificationCenter.default.post(name: NSNotification.Name("reloadSNATblViewNoti"), object: nil, userInfo: nil)
           }
        catch {
            print("Saving Core Data Failed: \(error)")
            NotificationCenter.default.post(name: NSNotification.Name("reloadSNATblViewNoti"), object: nil, userInfo: nil)
        }
        
      // print("QQQQQQ---\( fetchDetailsFor(entityName: "PVE_AssessmentQuestion"))")
    }

    
    ///// to unselect aLL Questions
    func updateQuestionstoDeselect() {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSelected == %@", argumentArray: [true])
        // let questionArr = json["AssessmentQuestion"].arrayObject
        
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                for (indx, _
                    ) in results!.enumerated() {
                    results![indx].setValue(false, forKey: "isSelected")
                }
            }
            } catch {
                print("Fetch Failed: \(error)")
            }

            do {
                try managedContext.save()
               }
            catch {
                print("Saving Core Data Failed: \(error)")
            }
    }

    
    
    
    func checkAtLeastOneSelectionInCategory(_ seq_Number: NSNumber) -> NSArray {

        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_AssessmentQuestion")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "seq_Number == %@", seq_Number)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataArray

    }

    
    
    func saveStartNewAsessmentFormDetailsInDB() {

        CoreDataHandler().deleteAllData("PVE_Session")
        CoreDataHandlerPVE().updateQuestionstoDeselect()
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_Session", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue("", forKey: "customer")
        person.setValue("", forKey: "evaluationDate")
        person.setValue("", forKey: "evaluationType")
        person.setValue("", forKey: "evaluationFor")
        person.setValue("", forKey: "serveyNo")
        person.setValue("", forKey: "siteName")
        person.setValue(1, forKey: "sessionId")
        person.setValue("", forKey: "accountManager")
        person.setValue("", forKey: "evaluator")
        person.setValue("", forKey: "breedOfBirds")
        person.setValue("", forKey: "ageOfBirds")
        person.setValue("", forKey: "housing")
    
        person.setValue("false", forKey: "cameraEnabled")
        
        person.setValue(0, forKey: "xSelectedCategoryIndex")
        person.setValue(false, forKey: "xIsSessionInProgress")
        //person.setValue("", forKey: "housing")


        do {
            try managedContext.save()
        } catch {
        }

        assessmentCat.append(person)

    }

    
    
    func updateStartNewAsessmentFormDetails(_ sessionId: Int, text: Any, forAttribute:String ) {
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_Session")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %@", argumentArray: [sessionId])
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                results![0].setValue(text, forKey: forAttribute)
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try managedContext.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
      // print("QQQQQQ---\( fetchDetailsFor(entityName: "PVE_AssessmentQuestion"))")
    }
    
    func saveDratDetailsInDB() {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PVE_Draft", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(0, forKey: "draftCount")
        person.setValue(1, forKey: "sessionId")

        do {
            try managedContext.save()
        } catch {
        }
        assessmentCat.append(person)
    }

    
    
    func updateDraft(_ assessmentId: Int, text: Any, forAttribute:String ) {
        
        var dataArray = NSArray()
        
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_Draft")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "sessionId == %@", argumentArray: [assessmentId])
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            
            if let results = results {
                dataArray = results as NSArray
                let draftCountArr = dataArray.value(forKey: "draftCount") as? [Int]
                var currentCount = draftCountArr?[0]
                currentCount = (currentCount ?? 0) + 1
                results[0].setValue(currentCount, forKey: forAttribute)
            }
            
        } catch {
            print("Fetch Failed: \(error)")
        }
        
        do {
            try managedContext.save()
        }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
        // print("QQQQQQ---\( fetchDetailsFor(entityName: "PVE_AssessmentQuestion"))")
    }

    
    //PVE_Session
    
    
    func saveSyncDetailsInDB(maxScoreArray:NSArray, scoreArray:NSArray, categoryArray:NSArray, dateCreated:String, syncId:String, complex:String, customer:String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "PVE_Sync", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(maxScoreArray as NSObject, forKey: "maxScoreArray")
        person.setValue(scoreArray as NSObject, forKey: "scoreArray")
        person.setValue(categoryArray as NSObject, forKey: "categoryArray")
        person.setValue(dateCreated, forKey: "dateCreated")
        person.setValue(syncId, forKey: "syncId")
        person.setValue(complex, forKey: "siteName")
        person.setValue(customer, forKey: "customer")

        do {
            try managedContext.save()
        } catch {
        }
        pve_Sync.append(person)
    }

    
    func getDetailsForAssessmentDate(_ assessmentDate: String) -> NSArray {

        var dataArray = NSArray()
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PVE_Sync")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "dateCreated == %@", assessmentDate)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataArray

    }


    
    
    func saveLoginResponseInDB(_ dict:NSDictionary) {
        
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PVE_LoginRespone", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        let acessToken = dict.value(forKey: "access_token") ?? ""
//        let countryId = dict.value(forKey: "CountryId") ?? 0
//        let birdTypeId = dict.value(forKey: "BirdTypeId") ?? 0
//        let complexTypeId = dict.value(forKey: "ComplexTypeId") ?? 0
        let firstName = dict.value(forKey: "FirstName") ?? ""
//        let id = dict.value(forKey: "Id") ?? 0
//        let roleId = dict.value(forKey: "RoleId") ?? 0
//        let userTypeId = dict.value(forKey: "UserTypeId") ?? 0

        person.setValue(acessToken, forKey: "access_token")
//        person.setValue(birdTypeId, forKey: "birdTypeId")
//        person.setValue(complexTypeId, forKey: "complexTypeId")
//        person.setValue(countryId, forKey: "countryId")
        person.setValue(firstName, forKey: "firstName")
//        person.setValue(id, forKey: "id")
//        person.setValue(roleId, forKey: "roleId")
//        person.setValue(acessToken, forKey: "token_type")
//        person.setValue(userTypeId, forKey: "userTypeId")
        
        do {
            try managedContext.save()
        } catch {
        }
        
        assessmentCat.append(person)
        
    }

}

