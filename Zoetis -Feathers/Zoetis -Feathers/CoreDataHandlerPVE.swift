//
//  CoreDataHandlerPVE.swift
//  Zoetis -Feathers
//
//  Created by NITIN KUMAR KANOJIA on 29/12/19.
//  Copyright © 2019 Alok Yadav. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandlerPVE: NSObject {
    
    var managedContext  = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType) //: NSManagedObjectContext! = nil

    var CustData = [NSManagedObject]()
    
    var routeArray = NSArray()
    var custArray = NSArray()

    override init() {
        super.init()
        self.setupContext()
    }

    func setupContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.managedObjectContext

    }
    
//    func saveCustomerDetailsInDB(_ custId: Int, CustName: String, dbArray: NSArray, index: Int) {
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

        

//        if  custArray.count > 0 {
//
//            if let objTable: Custmer = routeArray[index] as? Custmer {
//
//                objTable.setValue(custId, forKey: "customerId")
//                objTable.setValue(CustName, forKey: "customerName")
//            }
//            do {
//                try managedContext.save()
//            } catch {
//            }
//        } else {
//
//            let entity = NSEntityDescription.entity(forEntityName: "Customer_PVE", in: managedContext)
//            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
//            person.setValue(custId, forKey: "customerId")
//            person.setValue(CustName, forKey: "customerId")
//            do {
//                try managedContext.save()
//            } catch {
//            }
//
//            CustData.append(person)
//        }
    }
    
    func fetchCustomerWithCustId(_ custId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Complex_PVE")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customerId == %@", custId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                custArray = results as NSArray
            } else {

            }
        } catch {
        }

        return custArray

    }

    func fetchDetailsFor(entityName:String) -> NSArray {

        var custArray = NSArray()

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                custArray = results as NSArray

            } else {

            }
        } catch {
        }

        return custArray

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
    
    
}
