//
//  CoreDataHandler.swift
//  Zoetis -Feathers
//
//  Created by Chandan Kumar on 14/09/16.
//  Copyright © 2016 "". All rights reserved.

import Foundation
import CoreData
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
private func <= <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

class CoreDataHandler: NSObject {

    var managedContext: NSManagedObjectContext! = nil
    var hatcheryVaccinationObject = [NSManagedObject]()
    var settingsSkeletaObject = [NSManagedObject]()
    var settingsCocoii = [NSManagedObject]()
    var settingsGITract = [NSManagedObject]()
    var settingsRespiratory  = [NSManagedObject]()
    var settingsImmune = [NSManagedObject]()
    var routeData = [NSManagedObject]()
    var CustData = [NSManagedObject]()
    var SalesRepData = [NSManagedObject]()
    var VetData = [NSManagedObject]()
    var CocoiiProgram = [NSManagedObject]()
    var BirdSize = [NSManagedObject]()
    var SessionType = [NSManagedObject]()
    var BreedType = [NSManagedObject]()
    var complexNsObJECT = [NSManagedObject]()
    var loginType = [NSManagedObject]()
    var postingSession = [NSManagedObject]()
    var cocciCoccidiosControl = [NSManagedObject]()
    var cocciAlternative = [NSManagedObject]()
    var cocciAntibotic = [NSManagedObject]()
    var cocciMyCoxtinBinders = [NSManagedObject]()
    var FeddProgram = [NSManagedObject]()
    var CustmerRep = [NSManagedObject]()
    var necrpsystep1 = [NSManagedObject]()
    var captureSkeletaObject = [NSManagedObject]()
    var captureBirdWithNotesObject = [NSManagedObject]()
    var capturePhotoObject = [NSManagedObject]()
    var FarmsTypeObject = [NSManagedObject]()

    var custRep = NSArray()
    var dataArray = NSArray()
    var dataSkeletaArray = NSArray()
    var dataCociiaArray = NSArray()
    var dataGiTractArray = NSArray()
    var dataRespiratoryArray = NSArray()
    var dataImmuneArray = NSArray()
    var routeArray = NSArray()
    var custArray = NSArray()
    var SalesRepDataArray = NSArray()
    var BirdSizeArray = NSArray()
    var CocoiiProgramArray = NSArray()
    var SessionTypeArray = NSArray()
    var BreedTypeArray = NSArray()
    var VeterianTypeArray = NSArray()
    var complexArray = NSArray()
    var loginArray = NSArray()
    var postingArray = NSArray()
    var cocciControlArray = NSArray()
    var AlternativeArray = NSArray()
    var AntiboticArray = NSArray()
    var MyCoxtinBindersArray = NSArray()
    var feedprogramArray = NSArray()
    var openExistingArray = NSArray()
    var necropsyStep1Array = NSArray()
    var necropsySArray = NSMutableArray()
    var FieldVaccindataArray = NSArray()
    var captureNecSkeltetonArray = NSArray()
    var obsNameWithPoint = NSMutableArray()
    var fecthPhotoArray = NSArray()
    var fetchBirdNotesArray = NSArray()
    var farmsArrReturn = NSArray()

    var necropsyNIdArray = NSMutableArray()

    override init() {
        super.init()
        self.setupContext()
    }

    func setupContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.managedObjectContext

    }

    /********* Add Vacination *******************************************/

    func saveHatcheryVacinationInDatabase(_ type: String, strain: String, route: String, age: String, index: Int, dbArray: NSArray, postingId: NSNumber, vaciProgram: String, sessionId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataArray = dbArray
        if dataArray.count > 0 {

            if let objTable: HatcheryVac = dataArray[index] as? HatcheryVac {

                objTable.setValue(type, forKey: "type")
                objTable.setValue(strain, forKey: "strain")
                objTable.setValue(route, forKey: "route")
                objTable.setValue(age, forKey: "age")
                objTable.setValue(postingId, forKey: "postingId")
                objTable.setValue(vaciProgram, forKey: "vaciNationProgram")
                objTable.setValue(sessionId, forKey: "loginSessionId")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "HatcheryVac", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(type, forKey: "type")
            person.setValue(strain, forKey: "strain")
            person.setValue(route, forKey: "route")
            person.setValue(age, forKey: "age")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(vaciProgram, forKey: "vaciNationProgram")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            hatcheryVaccinationObject.append(person)
        }
    }

    func fetchAddvacinationDataAll() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")

        fetchRequest.returnsObjectsAsFaults = false

        //fetchRequest.predicate = NSPredicate(format: "postingId == %@", postnigId)
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

    func fetchAddvacinationData(_ postnigId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postnigId)

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

    func fetchAddvacinationDataWithisSync(_ postnigId: NSNumber, isSync: Bool) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND isSync == %@", postnigId, isSync as CVarArg)
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

    /********* Add Vacination fIELD Vaccination *******************************************/

    func getHatcheryDataFromServer(_ dict: NSDictionary) {
        let entity = NSEntityDescription.entity(forEntityName: "HatcheryVac", in: managedContext)

        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String

            if  (stringValidate == "fieldStrain1") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain1"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute1Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if(stringValidate == "fieldStrain2") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain2"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute2Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrain3") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain3"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute3Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain4") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain4"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute4Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain5") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain5"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute5Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain6") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain6"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute6Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain7") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain7"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute7Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain8") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain8"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute8Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrainST") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrainST"), forKey: "strain")
                switch dict.value(forKey: "fieldSTRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrainEcoli") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrainEcoli"), forKey: "strain")
                switch dict.value(forKey: "fieldEcoliRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrain9") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain9"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute9Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            }

        }

        do {
            try managedContext.save()
        } catch {
        }

        hatcheryVaccinationObject.append(person)
    }

    func getHatcheryDataFromServerSingleFromDeviceId(_ dict: NSDictionary, postingId: NSNumber) {
        let entity = NSEntityDescription.entity(forEntityName: "HatcheryVac", in: managedContext)

        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String

            if  (stringValidate == "fieldStrain1") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain1"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute1Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if(stringValidate == "fieldStrain2") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain2"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute2Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrain3") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain3"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute3Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

              person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain4") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain4"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute4Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain5") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain5"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute5Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

               person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain6") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain6"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute6Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain7") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain7"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute7Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrain8") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain8"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute8Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrainST") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrainST"), forKey: "strain")
                switch dict.value(forKey: "fieldSTRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

               person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "fieldStrainEcoli") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrainEcoli"), forKey: "strain")
                switch dict.value(forKey: "fieldEcoliRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

             person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "fieldStrain9") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "fieldStrain9"), forKey: "strain")
                switch dict.value(forKey: "fieldRoute9Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "fieldAge1"), forKey: "age")

              person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            }

        }

        do {
            try managedContext.save()
        } catch {
        }

        hatcheryVaccinationObject.append(person)
    }

    /************************************/

    func getFieldDataFromServer(_ dict: NSDictionary) {
        let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccination", in: managedContext)

        let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String

            if  (stringValidate == "hatcheryStrain1") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain1"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute1Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if(stringValidate == "hatcheryStrain2") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain2"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute2Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "hatcheryStrain3") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain3"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute3Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain4") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain4"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute4Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain5") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain5"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute5Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain6") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain6"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute6Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain7") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain7"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute7Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrainST") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrainST"), forKey: "strain")
                switch dict.value(forKey: "hatcherySTRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "hatcheryStrainEcoli") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrainEcoli"), forKey: "strain")
                switch dict.value(forKey: "hatcheryEcoliRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain8") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain8"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute8Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(dict.value(forKey: "sessionId"), forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            }

        }

        do {
            try managedContext.save()
        } catch {
        }

        hatcheryVaccinationObject.append(person)
    }

    func getFieldDataFromServerSingledata(_ dict: NSDictionary, postingId: NSNumber) {
        let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccination", in: managedContext)

        let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String

            if  (stringValidate == "hatcheryStrain1") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain1"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute1Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if(stringValidate == "hatcheryStrain2") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain2"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute2Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "hatcheryStrain3") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain3"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute3Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain4") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain4"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute4Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain5") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain5"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute5Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain6") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain6"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute6Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain7") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain7"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute7Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
               person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrainST") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrainST"), forKey: "strain")
                switch dict.value(forKey: "hatcherySTRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            } else if (stringValidate == "hatcheryStrainEcoli") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrainEcoli"), forKey: "strain")
                switch dict.value(forKey: "hatcheryEcoliRouteId") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")
            } else if (stringValidate == "hatcheryStrain8") {
                person.setValue("", forKey: "type")
                person.setValue(dict.value(forKey: "hatcheryStrain8"), forKey: "strain")
                switch dict.value(forKey: "hatcheryRoute8Id") as! Int {
                case 1:
                    person.setValue("Wing-Web", forKey: "route")
                case 2:
                    person.setValue("Drinking Water", forKey: "route")
                case 3:
                    person.setValue("Spray", forKey: "route")
                case 4:
                    person.setValue("In Ovo", forKey: "route")
                case 5:
                    person.setValue("Subcutaneous", forKey: "route")
                case 6:
                    person.setValue("Intramuscular", forKey: "route")
                case 7:
                    person.setValue("Eye Drop", forKey: "route")
                default:
                    person.setValue(" ", forKey: "route")
                }
                 person.setValue(postingId, forKey: "postingId")
                person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                person.setValue(false, forKey: "isSync")

            }

        }

        do {
            try managedContext.save()
        } catch {
        }

        hatcheryVaccinationObject.append(person)
    }

    /************************/
    func saveFieldVacinationInDatabase(_ type: String, strain: String, route: String, index: Int, dbArray: NSArray, postingId: NSNumber, vaciProgram: String, sessionId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        FieldVaccindataArray = dbArray
        if FieldVaccindataArray.count > 0 {

            if let objTable: FieldVaccination = FieldVaccindataArray[index] as? FieldVaccination {

                objTable.setValue(type, forKey: "type")
                objTable.setValue(strain, forKey: "strain")
                objTable.setValue(route, forKey: "route")
                objTable.setValue(postingId, forKey: "postingId")
                objTable.setValue(vaciProgram, forKey: "vaciNationProgram")
                objTable.setValue(sessionId, forKey: "loginSessionId")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccination", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(type, forKey: "type")
            person.setValue(strain, forKey: "strain")
            person.setValue(route, forKey: "route")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(vaciProgram, forKey: "vaciNationProgram")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            hatcheryVaccinationObject.append(person)
        }
    }

    func fetchFieldAddvacinationDataAll() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")
        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                FieldVaccindataArray = results as NSArray

            } else {

            }

        } catch {
        }

        return FieldVaccindataArray

    }

    func fetchFieldAddvacinationData(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                FieldVaccindataArray = results as NSArray

            } else {

            }

        } catch {
        }

        return FieldVaccindataArray

    }

    func fetchFieldAddvacinationDataWithisSyncTrue(_ postingId: NSNumber, isSync: Bool) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND isSync == %@", postingId, isSync as CVarArg)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                FieldVaccindataArray = results as NSArray

            } else {

            }

        } catch {
        }

        return FieldVaccindataArray

    }

    func updateisSyncValOnFieldAddvacinationData(_ postingId: NSNumber, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult?.count>0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: FieldVaccination = (fetchedResult![i] as? FieldVaccination)!

                    objTable.setValue(isSync, forKey: "isSync")

                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {
        }

    }

    /*******************************  Setting data Base ********************************************************/
    /***************** save data Skleta ************************************************************************/
    func saveSettingsSkeletaInDatabase(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataSkeletaArray = dbArray

        if  dataSkeletaArray.count > 0 {

            if let objTable: Skeleta = dataSkeletaArray[index] as? Skeleta {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()

            } catch {
            }
        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "Skeleta", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            settingsSkeletaObject.append(person)
        }
    }

    /***************** Fetch data Skleta ************************************************************************/

    func fetchAllSeettingdata() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "Skeleta")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataSkeletaArray = results as NSArray
                //                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "observationField", ascending: true)
                //                let sortedResults: NSArray = dataSkeletaArray.sortedArrayUsingDescriptors([descriptor])
                //
                //                dataSkeletaArray = sortedResults
            } else {

            }
        } catch {
        }

        return dataSkeletaArray

    }

    /***************************** Save Setting  Data Cocoii Data ***********************************************/

    func saveSettingsCocoiiInDatabase(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataCociiaArray = dbArray

        if  dataCociiaArray.count > 0 {
            if let objTable: Coccidiosis = dataCociiaArray[index] as? Coccidiosis {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "Coccidiosis", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            settingsCocoii.append(person)
        }
    }

    /***************** Fetch data Skleta ************************************************************************/

    func fetchAllCocoiiData() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "Coccidiosis")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                dataCociiaArray = results as NSArray
                //                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "observationField", ascending: true)
                //                let sortedResults: NSArray = dataCociiaArray.sortedArrayUsingDescriptors([descriptor])

                // dataCociiaArray = sortedResults

            } else {

            }
        } catch {
        }

        return dataCociiaArray

    }

    /******************************* Saving data Of GiTract********************************************/

    func saveSettingsGITractDatabase(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataGiTractArray = dbArray

        if  dataGiTractArray.count > 0 {

            if let objTable: GITract = dataGiTractArray[index] as? GITract {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "GITract", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            settingsGITract.append(person)
        }
    }

    /************** Fetch data Of GiTract* ***************************************/

    func fetchAllGITractData() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "GITract")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                dataGiTractArray = results as NSArray
                //                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "observationField", ascending: true)
                //                let sortedResults: NSArray = dataGiTractArray.sortedArrayUsingDescriptors([descriptor])
                //
                //                dataGiTractArray = sortedResults
            } else {

            }
        } catch {
        }

        return dataGiTractArray

    }

    /******************** Saving data Of Respiratory *********************************/

    func saveSettingsRespiratoryDatabase(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataRespiratoryArray = dbArray

        if  dataRespiratoryArray.count > 0 {
            if let objTable: Respiratory = dataRespiratoryArray[index] as? Respiratory {
                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "Respiratory", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            settingsRespiratory.append(person)
        }
    }

    /************** Fetch data Of Respiratory* ***************************************/

    func fetchAllRespiratory() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "Respiratory")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataRespiratoryArray = results as NSArray

                //                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "observationField", ascending: true)
                //                let sortedResults: NSArray = dataRespiratoryArray.sortedArrayUsingDescriptors([descriptor])
                //
                //                dataRespiratoryArray = sortedResults

            } else {
            }
        } catch {
        }

        return dataRespiratoryArray

    }

    /******************************* Saving data Of immune ********************************************/

    func saveSettingsImmuneDatabase(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataImmuneArray = dbArray

        if  dataImmuneArray.count > 0 {

            if let objTable: Immune = dataImmuneArray[index] as? Immune {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Immune", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            settingsImmune.append(person)
        }
    }

    /************** Fetch data Of immune* ***************************************/

    func fetchAllImmune() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Immune")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                dataImmuneArray = results as NSArray
                //                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "observationField", ascending: true)
                //                let sortedResults: NSArray = dataImmuneArray.sortedArrayUsingDescriptors([descriptor])
                //
                //                dataImmuneArray = sortedResults

            } else {

            }
        } catch {
        }

        return dataImmuneArray

    }

    /**************** SAVING DATA ROUTE ****************************************************************/

    func saveRouteDatabase(_ routeId: Int, routeName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        routeArray = dbArray

        if  routeArray.count > 0 {

            if let objTable: Route = routeArray[index] as? Route {

                objTable.setValue(routeId, forKey: "routeId")
                objTable.setValue(routeName, forKey: "routeName")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Route", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(routeId, forKey: "routeId")
            person.setValue(routeName, forKey: "routeName")

            do {
                try managedContext.save()
            } catch {
            }

            routeData.append(person)
        }
    }
    /**************** Fetch ROUTE ****************************************************************/

    func fetchRoute() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Route")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                routeArray = results as NSArray
            } else {

            }
        } catch {
        }

        return routeArray

    }

    /**************** SAVING DATA ROUTE ****************************************************************/

    func saveCustmerDatabase(_ custId: Int, CustName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        custArray = dbArray

        if  custArray.count > 0 {

            if let objTable: Custmer = routeArray[index] as? Custmer {

                objTable.setValue(custId, forKey: "custId")
                objTable.setValue(CustName, forKey: "custName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Custmer", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(custId, forKey: "custId")
            person.setValue(CustName, forKey: "custName")
            do {
                try managedContext.save()
            } catch {
            }

            CustData.append(person)
        }
    }
    /**************** Fetch ROUTE ****************************************************************/

    func fetchCustomer() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Custmer")
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

    func fetchCustomerWithCustId(_ custId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Custmer")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "custId == %@", custId)
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

    /****************  Saving Data  SalesRepData Posting    **********************************************/
    func SalesRepDataDatabase(_ salesReptId: Int, salesRepName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        SalesRepDataArray = dbArray
        if  SalesRepDataArray.count > 0 {
            if let objTable: Salesrep = SalesRepDataArray[index] as? Salesrep {

                objTable.setValue(salesReptId, forKey: "salesReptId")
                objTable.setValue(salesRepName, forKey: "salesRepName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Salesrep", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(salesReptId, forKey: "salesReptId")
            person.setValue(salesRepName, forKey: "salesRepName")
            do {
                try managedContext.save()
            } catch {
            }

            SalesRepData.append(person)
        }
    }
    /**************** Fetch ROUTE ****************************************************************/

    func fetchSalesrep() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Salesrep")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                SalesRepDataArray = results as NSArray

            } else {

            }
        } catch {
        }

        return SalesRepDataArray

    }

    /////////////////////////////SAVING DATA VetData  /////////////////////////////////////

    func VetDataDatabase(_ vetarId: Int, vtName: String, complexId: NSNumber, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        VeterianTypeArray = dbArray

        if  VeterianTypeArray.count > 0 {

            if let objTable: Veteration = VeterianTypeArray[index] as? Veteration {
                objTable.setValue(vetarId, forKey: "vetarId")
                objTable.setValue(complexId, forKey: "complexId")
                objTable.setValue(vtName, forKey: "vtName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Veteration", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(vetarId, forKey: "vetarId")
            person.setValue(complexId, forKey: "complexId")
            person.setValue(vtName, forKey: "vtName")

            do {
                try managedContext.save()
            } catch {
            }

            VetData.append(person)
        }
    }
    /**************** Fetch ROUTE ****************************************************************/

    func fetchVetData() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Veteration")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                VeterianTypeArray = results as NSArray
            } else {

            }
        } catch {
        }

        return VeterianTypeArray

    }

    func fetchVetDataPrdicate(_ complexId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Veteration")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "complexId == %@", complexId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                VeterianTypeArray = results as NSArray

            } else {

            }
        } catch {
        }

        return VeterianTypeArray

    }

    ///////////////////   SAVING DATA Cocci Program   //////////////////////////////

    func CocoiiProgramDatabase(_ cocoiiId: Int, cocoiProgram: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        CocoiiProgramArray = dbArray

        if  CocoiiProgramArray.count > 0 {

            if let objTable: CocciProgramPosting = CocoiiProgramArray[index] as? CocciProgramPosting {

                objTable.setValue(cocoiiId, forKey: "cocciProgramId")
                objTable.setValue(cocoiProgram, forKey: "cocciProgramName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "CocciProgramPosting", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(cocoiiId, forKey: "cocciProgramId")
            person.setValue(cocoiProgram, forKey: "cocciProgramName")

            do {
                try managedContext.save()
            } catch {
            }

            CocoiiProgram.append(person)
        }
    }
    /**************** Fetch Cooci  ****************************************************************/

    func fetchCocoiiProgram() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CocciProgramPosting")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                CocoiiProgramArray = results as NSArray

            } else {
            }
        } catch {
        }

        return CocoiiProgramArray

    }

    ///////////////////   SAVING DATA BirdSize   //////////////////////////////

    func BirdSizeDatabase(_ birddId: Int, birdSize: String, scaleType: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        BirdSizeArray = dbArray

        if  BirdSizeArray.count > 0 {
            if let objTable: BirdSizePosting = BirdSizeArray[index] as? BirdSizePosting {
                objTable.setValue(birddId, forKey: "birdSizeId")
                objTable.setValue(birdSize, forKey: "birdSize")
                objTable.setValue(scaleType, forKey: "scaleType")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "BirdSizePosting", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(birddId, forKey: "birdSizeId")
            person.setValue(birdSize, forKey: "birdSize")
            person.setValue(scaleType, forKey: "scaleType")
            do {
                try managedContext.save()
            } catch {
            }

            BirdSize.append(person)
        }
    }
    /**************** Fetch  BirdSize *******************************************/

    func fetchBirdSize() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdSizePosting")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                BirdSizeArray = results as NSArray
            } else {

            }
        } catch {
        }

        return BirdSizeArray

    }

    ///////////////////   SAVING DATA SessionType   //////////////////////////////

    func SessionTypeDatabase(_ sesionId: Int, sesionType: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        SessionTypeArray = dbArray

        if  SessionTypeArray.count > 0 {
            if let objTable: Sessiontype = SessionTypeArray[index] as? Sessiontype {
                objTable.setValue(sesionId, forKey: "sesionId")
                objTable.setValue(sesionType, forKey: "sesionType")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Sessiontype", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(sesionId, forKey: "sesionId")
            person.setValue(sesionType, forKey: "sesionType")
            do {
                try managedContext.save()
            } catch {
            }

            SessionType.append(person)
        }
    }
    /**************** Fetch  SessionType *******************************************/

    func fetchSessiontype() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Sessiontype")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                SessionTypeArray = results as NSArray
            } else {
            }
        } catch {
        }

        return SessionTypeArray

    }

    ///////////////////   SAVING DATA SessionType   //////////////////////////////

    func BreedTypeDatabase(_ breedId: Int, breedType: String, breedName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        BreedTypeArray = dbArray

        if  BreedTypeArray.count > 0 {
            if let objTable: Breed = BreedTypeArray[index] as? Breed {
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(breedType, forKey: "breedType")
                objTable.setValue(breedName, forKey: "breedName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Breed", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(breedId, forKey: "breedId")
            person.setValue(breedType, forKey: "breedType")
            person.setValue(breedName, forKey: "breedName")

            do {
                try managedContext.save()
            } catch {
            }

            BreedType.append(person)
        }
    }

    /**************** Fetch  breed *******************************************/

    func fetchBreedType() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Breed")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                BreedTypeArray = results as NSArray
            } else {

            }
        } catch {
        }

        return BreedTypeArray

    }

    //////////////////////// compex //////////////////////////////////

    func ComplexDatabase(_ comlexId: NSNumber, cutmerid: NSNumber, complexName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        complexArray = dbArray

        if  complexArray.count > 0 {

            if let objTable: ComplexPosting = complexArray[index] as? ComplexPosting {

                objTable.setValue(comlexId, forKey: "complexId")
                objTable.setValue(complexName, forKey: "complexName")
                objTable.setValue(cutmerid, forKey: "customerId")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "ComplexPosting", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(comlexId, forKey: "complexId")
            person.setValue(complexName, forKey: "complexName")
            person.setValue(cutmerid, forKey: "customerId")

            do {
                try managedContext.save()
            } catch {
            }

            complexNsObJECT.append(person)
        }
    }
    func fetchAllPostingExistingSessionwithFullSessionAndComplex(_ session: NSNumber, complexName: NSString) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "catptureNec == %@ AND complexName == %@", session, complexName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray

            } else {

            }
        } catch {
        }

        return postingArray

    }

    func fetchAllPostingExistingSessionwithFullSessionAndUniqueComplex(_ complexID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "complexId == %@", complexID)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray

            } else {

            }
        } catch {
        }

        return postingArray

    }
    /**************** Fetch  complex posting *******************************************/

    func fetchCompexType() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ComplexPosting")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                complexArray = results as NSArray
            } else {
            }
        } catch {
        }

        return complexArray

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

            }

        } catch let error as NSError {

            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")

        }
    }
    func fetchCompexTypePrdicate(_ CustomerId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ComplexPosting")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customerId == %@", CustomerId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                complexArray = results as NSArray

            } else {

            }
        } catch {
        }

        return complexArray

    }

    /******************* Login *******************************************************/
    //////////////////////// compex //////////////////////////////////
    func LoginDatabase(_ userTypeId: NSNumber, userId: NSNumber, userName: String, status: NSNumber, signal: String, loginId: NSNumber, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        loginArray = dbArray

        if  loginArray.count > 0 {

            if let objTable: Login = loginArray[index] as? Login {
                objTable.setValue(userTypeId, forKey: "userTypeId")
                objTable.setValue(userId, forKey: "userId")
                objTable.setValue(status, forKey: "status")
                objTable.setValue(userName, forKey: "username")
                objTable.setValue(signal, forKey: "signal")
                objTable.setValue(loginId, forKey: "loginId")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "Login", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(userTypeId, forKey: "userTypeId")
            person.setValue(userId, forKey: "userId")
            person.setValue(status, forKey: "status")
            person.setValue(userName, forKey: "username")
            person.setValue(signal, forKey: "signal")
            person.setValue(loginId, forKey: "loginId")

            do {
                try managedContext.save()
            } catch {
            }

            loginType.append(person)
        }
    }

    /**************** Fetch  complex posting *******************************************/
    func fetchLoginType() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                loginArray = results as NSArray

            } else {

            }
        } catch {
        }

        return loginArray

    }

    func fetchLoginTypeWithUserEmail(email: String) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
        fetchRequest.returnsObjectsAsFaults = false
          fetchRequest.predicate = NSPredicate(format: "username == %@", email)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                loginArray = results as NSArray

            } else {

            }
        } catch {
        }

        return loginArray

    }

    ///////////////// ** Posting Customer representative Data Save In Add Vacination Button **///////

    func postCustomerReps(_ customername: String, userid: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "CustomerReprestative", in: managedContext)
        let arr =  fectCustomerRepresenttiveWithCustomername(customername)

        if arr.count > 0 {
            return
        }

        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(customername, forKey: "customername")
        person.setValue(userid, forKey: "userid")
        do {
            try managedContext.save()
        } catch {
        }

        CustmerRep.append(person)
    }

    ///////////////// ** Fetch Cstomer repsentative Data Save In Add Vacination Button **///////
    func fectCustomerRepresenttiveWithCustomername ( _ customername: String) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerReprestative")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "customername == %@ ", customername)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                custRep  = results as NSArray
            } else {

            }

        } catch {
        }

        return custRep

    }

    ///////////////// ** Fetch Cstomer repsentative Data Save In Add Vacination Button **///////
    func fectCustomerRepWithCustomername ( _ usrid: Int) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerReprestative")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "userid == %d ", usrid)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                custRep  = results as NSArray

            } else {

            }

        } catch {
        }

        return custRep

    }

    /************ Delete object from posting seesion ***************************************/

    func deleteDataWithPostingId (_ postingId: NSNumber) {
//        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithPostingIdHatchery (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithPostingIdFieldVacinationWithSingle (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithDeviceSessionId (postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteHetcharyVacDataWithPostingId (_ postingId: NSNumber) {

//        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")
        fetchUsers.predicate                = fetchPredicate
        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func deletefieldVACDataWithPostingId (_ postingId: NSNumber) {

//        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccination")
        fetchUsers.predicate                = fetchPredicate
        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithPostingIdFeddProgram (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgram")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithPostingIdFeddProgramCocoiiSinle (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func deleteDataWithPostingIdFeddProgramAlternativeSinle (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func deleteDataWithPostingIdFeddProgramAntiboiticSingle (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func deleteDataWithPostingIdFeddProgramMyCotoxinSingle (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteDataWithPostingIdCaptureStepData (_ necId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func updateisSyncOnHetcharyVacDataWithPostingId (_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVac")
        fetchUsers.predicate                = fetchPredicate

        do {
            let fetchedResult = try managedContext.fetch(fetchUsers) as? [NSManagedObject]

            if fetchedResult?.count>0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: HatcheryVac = (fetchedResult![i] as? HatcheryVac)!

                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                }
                completion(true)

            } else {
                completion(true)
            }
        } catch {
        }

    }
    ///////////////// ** Posting Session Data Save In Add Vacination Button **///////

    func PostingSessionDb(_ antobotic: String, birdBreesId: NSNumber, birdbreedName: String, birdBreedType: String, birdSize: String, birdSizeId: NSNumber, cocciProgramId: NSNumber, cociiProgramName: String, complexId: NSNumber, complexName: String, convential: String, customerId: NSNumber, customerName: String, customerRepId: NSNumber, customerRepName: String, imperial: String, metric: String, notes: String, salesRepId: NSNumber, salesRepName: String, sessiondate: String, sessionTypeId: NSNumber, sessionTypeName: String, vetanatrionName: String, veterinarianId: NSNumber, loginSessionId: NSNumber, postingId: NSNumber, mail: String, female: String, finilize: NSNumber, isSync: Bool, timeStamp: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        self.deleteDataWithPostingId(postingId)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSession", in: managedContext)
        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue(convential, forKey: "convential")
        contact1.setValue(antobotic, forKey: "antiboitic")
        contact1.setValue(birdBreesId, forKey: "birdBreedId")
        contact1.setValue(birdbreedName, forKey: "birdBreedName")
        contact1.setValue(birdBreedType, forKey: "birdBreedType")
        contact1.setValue(birdSize, forKey: "birdSize")
        contact1.setValue(birdSizeId, forKey: "birdSizeId")
        contact1.setValue(cocciProgramId, forKey: "cocciProgramId")
        contact1.setValue(cociiProgramName, forKey: "cociiProgramName")
        contact1.setValue(complexId, forKey: "complexId")
        contact1.setValue(complexName, forKey: "complexName")
        contact1.setValue(customerId, forKey: "customerId")
        contact1.setValue(customerName, forKey: "customerName")
        contact1.setValue(customerRepId, forKey: "customerRepId")
        contact1.setValue(customerRepName, forKey: "customerRepName")
        contact1.setValue(imperial, forKey: "imperial")
        contact1.setValue(metric, forKey: "metric")
        contact1.setValue(notes, forKey: "notes")
        contact1.setValue(salesRepId, forKey: "salesRepId")
        contact1.setValue(salesRepName, forKey: "salesRepName")
        contact1.setValue(sessiondate, forKey: "sessiondate")
        contact1.setValue(sessionTypeId, forKey: "sessionTypeId")
        contact1.setValue(sessionTypeName, forKey: "sessionTypeName")
        contact1.setValue(vetanatrionName, forKey: "vetanatrionName")
        contact1.setValue(veterinarianId, forKey: "veterinarianId")
        contact1.setValue(loginSessionId, forKey: "loginSessionId")
        contact1.setValue(postingId, forKey: "postingId")
        contact1.setValue(mail, forKey: "mail")
        contact1.setValue(female, forKey: "female")
        contact1.setValue(finilize, forKey: "finalizeExit")
        contact1.setValue(isSync, forKey: "isSync")
        contact1.setValue(timeStamp, forKey: "timeStamp")
        // contact1.setValue(actualTimeStamp, forKey:"actualTimeStamp")

        do {
            try managedContext.save()
        } catch {
        }

        postingSession.append(contact1)

    }

    /*************************** Get Api Method for Postong Session **********************/
    func getPostingData(_ dict: NSDictionary) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let postingId = dict.value(forKey: "SessionId") as! Int
        self.deleteDataWithPostingId(postingId as NSNumber)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSession", in: managedContext)

        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue("NA", forKey: "convential")
        contact1.setValue("NA", forKey: "antiboitic")
        contact1.setValue(1, forKey: "birdBreedId")
        contact1.setValue("NA", forKey: "birdBreedName")
        contact1.setValue("NA", forKey: "birdBreedType")
        contact1.setValue(dict.value(forKey: "BirdSize"), forKey: "birdSize")
        contact1.setValue(1, forKey: "birdSizeId")
        contact1.setValue(dict.value(forKey: "CocciProgramId"), forKey: "cocciProgramId")
        contact1.setValue(dict.value(forKey: "CocciProgram"), forKey: "cociiProgramName")
        contact1.setValue(dict.value(forKey: "ComplexId"), forKey: "complexId")
        contact1.setValue(dict.value(forKey: "ComplexName"), forKey: "complexName")
        contact1.setValue(dict.value(forKey: "CustomerId"), forKey: "customerId")
        contact1.setValue(dict.value(forKey: "CustomerName"), forKey: "customerName")
        contact1.setValue(dict.value(forKey: "SessionId"), forKey: "customerRepId")
        contact1.setValue(dict.value(forKey: "CustomerRep"), forKey: "customerRepName")
        contact1.setValue("", forKey: "imperial")
        contact1.setValue("Scale", forKey: "metric")
        contact1.setValue(dict.value(forKey: "Notes"), forKey: "notes")
        contact1.setValue(dict.value(forKey: "SalesUserId"), forKey: "salesRepId")
        contact1.setValue(dict.value(forKey: "SalesRepFirstName"), forKey: "salesRepName")
        let sessionDa = convertDateFormater(dict.value(forKey: "SessionDate") as! String)
        contact1.setValue(sessionDa, forKey: "sessiondate")
        //contact1.setValue("20/20/2020", forKey:"sessiondate")
        contact1.setValue(dict.value(forKey: "SessionTypeId"), forKey: "sessionTypeId")
        contact1.setValue(dict.value(forKey: "SessionType"), forKey: "sessionTypeName")

        let vetFirstName = dict.value(forKey: "VetFirstName")
        let vetLastname = dict.value(forKey: "VetLastName")
        let firstLastName = "\(vetFirstName!) \(vetLastname!)"
        contact1.setValue(firstLastName, forKey: "vetanatrionName")
        contact1.setValue(dict.value(forKey: "VetUserId"), forKey: "veterinarianId")
        contact1.setValue(dict.value(forKey: "SessionId"), forKey: "loginSessionId")
        contact1.setValue(dict.value(forKey: "SessionId"), forKey: "postingId")
        contact1.setValue(dict.value(forKey: "MaleBreedName"), forKey: "mail")
        contact1.setValue(dict.value(forKey: "FemaleBreedName"), forKey: "female")
        contact1.setValue(dict.value(forKey: "Finalized"), forKey: "finalizeExit")
        contact1.setValue(false, forKey: "isSync")
        contact1.setValue(dict.value(forKey: "DeviceSessionId"), forKey: "timeStamp")
        contact1.setValue(dict.value(forKey: "DeviceSessionId"), forKey: "actualTimeStamp")
        UserDefaults.standard.set(dict.value(forKey: "DeviceSessionId"), forKey: "devTimeStamp")
        UserDefaults.standard.synchronize()
        //contact1.setValue(1, forKey:"catptureNec")
        do {
            try managedContext.save()
        } catch {
        }

        postingSession.append(contact1)

    }
    func getPostingDatWithSpecificId(_ dict: NSDictionary, postinngId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let postingId = dict.value(forKey: "SessionId") as! Int
        self.deleteDataWithDeviceSessionId(postingId: postinngId)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSession", in: managedContext)

        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue("NA", forKey: "convential")
        contact1.setValue("NA", forKey: "antiboitic")
        contact1.setValue(1, forKey: "birdBreedId")
        contact1.setValue("NA", forKey: "birdBreedName")
        contact1.setValue("NA", forKey: "birdBreedType")
        contact1.setValue(dict.value(forKey: "BirdSize"), forKey: "birdSize")
        contact1.setValue(1, forKey: "birdSizeId")
        contact1.setValue(dict.value(forKey: "CocciProgramId"), forKey: "cocciProgramId")
        contact1.setValue(dict.value(forKey: "CocciProgram"), forKey: "cociiProgramName")
        contact1.setValue(dict.value(forKey: "ComplexId"), forKey: "complexId")
        contact1.setValue(dict.value(forKey: "ComplexName"), forKey: "complexName")
        contact1.setValue(dict.value(forKey: "CustomerId"), forKey: "customerId")
        contact1.setValue(dict.value(forKey: "CustomerName"), forKey: "customerName")
        contact1.setValue(dict.value(forKey: "SessionId"), forKey: "customerRepId")
        contact1.setValue(dict.value(forKey: "CustomerRep"), forKey: "customerRepName")
        contact1.setValue("", forKey: "imperial")
        contact1.setValue("Scale", forKey: "metric")
        contact1.setValue(dict.value(forKey: "Notes"), forKey: "notes")
        contact1.setValue(dict.value(forKey: "SalesUserId"), forKey: "salesRepId")
        contact1.setValue(dict.value(forKey: "SalesRepFirstName"), forKey: "salesRepName")
        let sessionDa = convertDateFormater(dict.value(forKey: "SessionDate") as! String)
        contact1.setValue(sessionDa, forKey: "sessiondate")
        //contact1.setValue("20/20/2020", forKey:"sessiondate")
        contact1.setValue(dict.value(forKey: "SessionTypeId"), forKey: "sessionTypeId")
        contact1.setValue(dict.value(forKey: "SessionType"), forKey: "sessionTypeName")

        let vetFirstName = dict.value(forKey: "VetFirstName")
        let vetLastname = dict.value(forKey: "VetLastName")
        let firstLastName = "\(vetFirstName!) \(vetLastname!)"
        contact1.setValue(firstLastName, forKey: "vetanatrionName")
        contact1.setValue(dict.value(forKey: "VetUserId"), forKey: "veterinarianId")
        contact1.setValue(dict.value(forKey: "SessionId"), forKey: "loginSessionId")
        contact1.setValue(postinngId, forKey: "postingId")
        contact1.setValue(dict.value(forKey: "MaleBreedName"), forKey: "mail")
        contact1.setValue(dict.value(forKey: "FemaleBreedName"), forKey: "female")
        contact1.setValue(dict.value(forKey: "Finalized"), forKey: "finalizeExit")
        contact1.setValue(false, forKey: "isSync")
        contact1.setValue(dict.value(forKey: "DeviceSessionId"), forKey: "timeStamp")
        contact1.setValue(dict.value(forKey: "DeviceSessionId"), forKey: "actualTimeStamp")
        UserDefaults.standard.set(dict.value(forKey: "DeviceSessionId"), forKey: "devTimeStamp")
        UserDefaults.standard.synchronize()
        contact1.setValue(1, forKey: "catptureNec")
        do {
            try managedContext.save()
        } catch {
        }

        postingSession.append(contact1)

    }
    /********* ConvertIng sessiondate *****************/

    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        //  dateFormatter.timeZone = NSTimeZone(name: "UTC")

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "MM/dd/yyyy"
        //dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    /********************************************************************************************/
    /***************************/

    func updateFinalizeDataActual(_ postingId: NSNumber, deviceToken: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!
                objTable.setValue(deviceToken, forKey: "actualTimeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func updateFinalizeDataActualNec(_ necId: NSNumber, deviceToken: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyData = (fetchedResult![0] as? CaptureNecropsyData)!
                objTable.setValue(deviceToken, forKey: "actualTimeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func updateFinalizeData(_ postingId: NSNumber, finalize: NSNumber, isSync: Bool) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!
                objTable.setValue(finalize, forKey: "finalizeExit")
                objTable.setValue(isSync, forKey: "isSync")
                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func updatedeviceTokenForPostingId(_ postingId: NSNumber, timeStamp: String, actualTimestamp: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!
                objTable.setValue(timeStamp, forKey: "actualTimeStamp")
                objTable.setValue(actualTimestamp, forKey: "timeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func searchTokenForPostingId(timeStampId: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "timeStamp == %@", timeStampId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!
//                objTable.setValue(timeStamp, forKey:"finalizeExit")
//                objTable.setValue(actualTimestamp, forKey:"timeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func updateFinalizeDataWithNec(_ postingId: NSNumber, finalizeNec: NSNumber) { let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!

                objTable.setValue(finalizeNec, forKey: "catptureNec")
                do {
                    try managedContext.save()
                } catch {
                }

            }
        } catch {

        }

    }

    func updateFinalizeDataWithNecNotes(_ postingId: NSNumber, notes: String) { let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!

                objTable.setValue(notes, forKey: "notes")
                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func updateisSyncOnPostingSession(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: PostingSession = (fetchedResult![i] as? PostingSession)!

                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                }
                completion(true)
            } else {
                completion(true)
            }

        } catch {

        }

    }

    func updateisAllSyncFalseOnPostingSession(_ isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", isSync as CVarArg)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: PostingSession = (fetchedResult![i] as? PostingSession)!

                    objTable.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                }

                completion(true)
            } else {
                completion(true)
            }

        } catch {

        }

    }

    func updateisSyncTrueOnPostingSession(_ postingId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: PostingSession = (fetchedResult![0] as? PostingSession)!

                objTable.setValue(true, forKey: "isSync")
                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func fetchAllPostingSessionWithNumber() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                postingArray  = results as NSArray

            } else {

            }
        } catch {
        }

        return postingArray

    }

    func fetchAllPostingSession(_ postingid: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingid)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                postingArray  = results as NSArray

            } else {

            }

        } catch {
        }

        return postingArray

    }

    func fetchAllPostingSessionWithisSyncisTrue(_ isSync: Bool) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", isSync as CVarArg)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                postingArray  = results as NSArray

            } else {

            }

        } catch {
        }

        return postingArray

    }

    func fetchAllPostingExistingSession() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                postingArray  = results as NSArray

            } else {

            }
        } catch {
        }

        return postingArray

    }

    func fetchAllPostingExistingSessionwithFullSession(_ session: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "catptureNec == %@", session)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "postingId", ascending: false)

                let sortedResults = postingArray.sortedArray(using: [descriptor])

                postingArray = sortedResults as NSArray

            } else {

            }
        } catch {
        }

        return postingArray

    }
    /********************************* Save data in to CocoiPrgramFeed *************************************/
    func saveCoccoiControlDatabase(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, coccidiosisVaccine: String, targetWeight: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        cocciControlArray = dbArray

        if  cocciControlArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if (fetchedResult?.count <= index) {

                        let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeed", in: managedContext)

                        let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                        person.setValue(loginSessionId, forKey: "loginSessionId")
                        person.setValue( postingId, forKey: "postingId")
                        person.setValue( molecule, forKey: "molecule")
                        person.setValue(dosage, forKey: "dosage")
                        person.setValue(fromDays, forKey: "fromDays")
                        person.setValue(toDays, forKey: "toDays")
                        person.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")
                        person.setValue(targetWeight, forKey: "targetWeight")
                        person.setValue(feedId, forKey: "feedId")
                        person.setValue(feedProgram, forKey: "feedProgram")
                        person.setValue(isSync, forKey: "isSync")
                        person.setValue(feedType, forKey: "feedType")
                        person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciCoccidiosControl.append(person)

                    } else {
                        let objTable: CoccidiosisControlFeed = (fetchedResult![index] as? CoccidiosisControlFeed)!

                        objTable.setValue(loginSessionId, forKey: "loginSessionId")
                        objTable.setValue( postingId, forKey: "postingId")
                        objTable.setValue( molecule, forKey: "molecule")
                        objTable.setValue(dosage, forKey: "dosage")
                        objTable.setValue(fromDays, forKey: "fromDays")
                        objTable.setValue(toDays, forKey: "toDays")
                        objTable.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")
                        objTable.setValue(targetWeight, forKey: "targetWeight")
                        objTable.setValue(feedId, forKey: "feedId")
                        objTable.setValue(feedProgram, forKey: "feedProgram")
                        objTable.setValue(formName, forKey: "formName")
                        objTable.setValue(isSync, forKey: "isSync")
                        objTable.setValue(feedType, forKey: "feedType")
                        objTable.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                        do {
                            try managedContext.save()
                        } catch {
                        }
                    }

                } else {

                    let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeed", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue(loginSessionId, forKey: "loginSessionId")
                    person.setValue( postingId, forKey: "postingId")
                    person.setValue( molecule, forKey: "molecule")
                    person.setValue(dosage, forKey: "dosage")
                    person.setValue(fromDays, forKey: "fromDays")
                    person.setValue(toDays, forKey: "toDays")
                    person.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")
                    person.setValue(targetWeight, forKey: "targetWeight")
                    person.setValue(feedId, forKey: "feedId")
                    person.setValue(feedProgram, forKey: "feedProgram")
                    person.setValue(isSync, forKey: "isSync")
                    person.setValue(feedType, forKey: "feedType")
                    person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciCoccidiosControl.append(person)
                }

            } catch {

            }

        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeed", in: managedContext)

            let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(loginSessionId, forKey: "loginSessionId")
            person.setValue( postingId, forKey: "postingId")
            person.setValue( molecule, forKey: "molecule")
            person.setValue(dosage, forKey: "dosage")
            person.setValue(fromDays, forKey: "fromDays")
            person.setValue(toDays, forKey: "toDays")
            person.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")
            person.setValue(targetWeight, forKey: "targetWeight")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(feedProgram, forKey: "feedProgram")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(feedType, forKey: "feedType")
            person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciCoccidiosControl.append(person)
        }

    }

    /********************** Get data from server forCocoidisControll **********************/

    func getDataFromCocoiiControll(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {

        let entity = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingId, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(dict.value(forKey: "cocciVaccineName"), forKey: "coccidiosisVaccine")
        person.setValue("", forKey: "targetWeight")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciCoccidiosControl.append(person)
    }
    func getDataFromCocoiiControllForSingleData(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingIdCocoii: NSNumber) {
        let entity = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingIdCocoii, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(dict.value(forKey: "cocciVaccineName"), forKey: "coccidiosisVaccine")
        person.setValue("", forKey: "targetWeight")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciCoccidiosControl.append(person)
    }
    /***************** Fetch data Skleta ************************************************************************/

    func fetchAllCocciControl(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                cocciControlArray = results as NSArray

            } else {

            }
        } catch {
        }

        return cocciControlArray

    }

    func fetchAllCocciControlAllData() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                cocciControlArray = results as NSArray

            } else {

            }
        } catch {
        }

        return cocciControlArray

    }

    ///////////fETCH FEED PROGRAM VIA POSTING ID////////////

    func fetchAllCocciControlviaPostingid(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                cocciControlArray = results as NSArray

            } else {
            }

        } catch {
        }

        return cocciControlArray

    }

    func fetchAllCocciControlviaIsync(_ isSync: NSNumber, postinID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", isSync, postinID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                cocciControlArray = results as NSArray
            } else {
            }

        } catch {

        }
        return cocciControlArray

    }

    func updateisSyncOnAllCocciControlviaPostingid(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CoccidiosisControlFeed = (fetchedResult![i] as? CoccidiosisControlFeed)!
                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

                completion(true)
            } else {
                completion(true)
            }

        } catch {

        }

    }

    func updateisSyncOnAntiboticViaPostingId(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: AntiboticFeed = (fetchedResult![i] as? AntiboticFeed)!
                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }
                completion(true)
            } else {
                completion(true)
            }
        } catch {

        }

    }

    func fetchAntiboticViaIsSync(_ isSync: Bool, postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", isSync as CVarArg, postingID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                AntiboticArray = results as NSArray
            } else {
            }

        } catch {

        }
        return AntiboticArray

    }

    func fetchAntiboticViaPostingId(_ postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                AntiboticArray = results as NSArray
            } else {

            }

        } catch {

        }

        return AntiboticArray

    }
    ///////Fetch alternative via postingId //////

    func updateisSyncOnAlternativeFeedPostingid(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: AlternativeFeed = (fetchedResult![i] as? AlternativeFeed)!
                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

                completion(true)
            } else {
                 completion(true)
            }
        } catch {

        }

    }

    func fetchAlternativeFeedWithIsSync(_ isSync: Bool, postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")
        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", isSync as CVarArg, postingID)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                AlternativeArray = results as NSArray

            } else {
            }

        } catch {

        }

        return AlternativeArray

    }

    func fetchAlternativeFeedPostingid(_ postingId: NSNumber) -> NSArray {     let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")

        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AlternativeArray = results as NSArray

            } else {

            }

        } catch {

        }

        return AlternativeArray

    }

    func updateisSyncOnMyBindersViaPostingId(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
              for i in 0..<fetchedResult!.count {
                    let objTable: MyCotoxinBindersFeed = (fetchedResult![i] as? MyCotoxinBindersFeed)!

                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    completion(true)
                }
            } else {
                 completion(true)
            }
        } catch {

        }

    }

    func fetchMyBindersViaPostingId(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")

        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                MyCoxtinBindersArray = results as NSArray

            } else {

            }

        } catch {

        }

        return MyCoxtinBindersArray

    }

    func fetchMyBindersViaIsSync(_ isSync: Bool, postingID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")

        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", isSync as CVarArg, postingID)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                MyCoxtinBindersArray = results as NSArray

            } else {

            }

        } catch {

        }

        return MyCoxtinBindersArray

    }

    /********************************* Save data in to AntiboticArray *************************************/
    func saveAntiboticDatabase(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        AntiboticArray = dbArray

        if  AntiboticArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if (fetchedResult?.count <= index) {

                        let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeed", in: managedContext)

                        let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

                        person.setValue(loginSessionId, forKey: "loginSessionId")
                        person.setValue( postingId, forKey: "postingId")
                        person.setValue( molecule, forKey: "molecule")
                        person.setValue(dosage, forKey: "dosage")
                        person.setValue(fromDays, forKey: "fromDays")
                        person.setValue(toDays, forKey: "toDays")
                        person.setValue(feedId, forKey: "feedId")
                        person.setValue(feedProgram, forKey: "feedProgram")
                        person.setValue(isSync, forKey: "isSync")
                        person.setValue(feedType, forKey: "feedType")
                        person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciAntibotic.append(person)

                    } else {
                        let objTable: AntiboticFeed = (fetchedResult![index] as? AntiboticFeed)!

                        objTable.setValue(loginSessionId, forKey: "loginSessionId")
                        objTable.setValue( postingId, forKey: "postingId")
                        objTable.setValue( molecule, forKey: "molecule")
                        objTable.setValue(dosage, forKey: "dosage")
                        objTable.setValue(fromDays, forKey: "fromDays")
                        objTable.setValue(toDays, forKey: "toDays")
                        objTable.setValue(feedId, forKey: "feedId")
                        objTable.setValue(feedProgram, forKey: "feedProgram")
                        objTable.setValue(formName, forKey: "formName")
                        objTable.setValue(isSync, forKey: "isSync")
                        objTable.setValue(feedType, forKey: "feedType")
                        objTable.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                    }
                } else {

                    let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeed", in: managedContext)

                    let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

                    person.setValue(loginSessionId, forKey: "loginSessionId")
                    person.setValue( postingId, forKey: "postingId")
                    person.setValue( molecule, forKey: "molecule")
                    person.setValue(dosage, forKey: "dosage")
                    person.setValue(fromDays, forKey: "fromDays")
                    person.setValue(toDays, forKey: "toDays")
                    person.setValue(feedId, forKey: "feedId")
                    person.setValue(feedProgram, forKey: "feedProgram")
                    person.setValue(isSync, forKey: "isSync")
                    person.setValue(feedType, forKey: "feedType")
                    person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciAntibotic.append(person)

                }

            } catch {

            }

        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeed", in: managedContext)

            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(loginSessionId, forKey: "loginSessionId")
            person.setValue( postingId, forKey: "postingId")
            person.setValue( molecule, forKey: "molecule")
            person.setValue(dosage, forKey: "dosage")
            person.setValue(fromDays, forKey: "fromDays")
            person.setValue(toDays, forKey: "toDays")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(feedProgram, forKey: "feedProgram")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(feedType, forKey: "feedType")
            person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciAntibotic.append(person)
        }
    }

    /********************************* Get Api from server for antoboitic *************************************/

    func getDataFromAntiboitic(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {

        let entity = NSEntityDescription.entity(forEntityName: "AntiboticFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingId, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciAntibotic.append(person)
    }

    func getDataFromAntiboiticWithSigleData(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingIdAlterNative: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "AntiboticFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingIdAlterNative, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciAntibotic.append(person)
    }

    /***************** Fetch data Skleta ************************************************************************/

    func fetchAntibotic(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AntiboticArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AntiboticArray

    }

    func fetchAntiboticPostingId(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AntiboticArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AntiboticArray

    }

    func fetchAntiboticAlldata() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeed")

        fetchRequest.returnsObjectsAsFaults = false
        //  fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AntiboticArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AntiboticArray

    }

    func saveAlternativeDatabase(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        AlternativeArray = dbArray

        if  AlternativeArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if (fetchedResult?.count <= index) {

                        let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeed", in: managedContext)

                        let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

                        person.setValue(loginSessionId, forKey: "loginSessionId")
                        person.setValue( postingId, forKey: "postingId")
                        person.setValue( molecule, forKey: "molecule")
                        person.setValue(dosage, forKey: "dosage")
                        person.setValue(fromDays, forKey: "fromDays")
                        person.setValue(toDays, forKey: "toDays")
                        person.setValue(feedId, forKey: "feedId")
                        person.setValue(feedProgram, forKey: "feedProgram")
                        person.setValue(isSync, forKey: "isSync")
                        person.setValue(feedType, forKey: "feedType")
                        person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciAlternative.append(person)
                    } else {

                        let objTable: AlternativeFeed = (fetchedResult![index] as? AlternativeFeed)!

                        objTable.setValue(loginSessionId, forKey: "loginSessionId")
                        objTable.setValue( postingId, forKey: "postingId")
                        objTable.setValue( molecule, forKey: "molecule")
                        objTable.setValue(dosage, forKey: "dosage")
                        objTable.setValue(fromDays, forKey: "fromDays")
                        objTable.setValue(toDays, forKey: "toDays")
                        objTable.setValue(feedId, forKey: "feedId")
                        objTable.setValue(feedProgram, forKey: "feedProgram")
                        objTable.setValue(formName, forKey: "formName")
                        objTable.setValue(isSync, forKey: "isSync")
                        objTable.setValue(feedType, forKey: "feedType")
                        objTable.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                    }
                } else {
                    let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeed", in: managedContext)

                    let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

                    person.setValue(loginSessionId, forKey: "loginSessionId")
                    person.setValue( postingId, forKey: "postingId")
                    person.setValue( molecule, forKey: "molecule")
                    person.setValue(dosage, forKey: "dosage")
                    person.setValue(fromDays, forKey: "fromDays")
                    person.setValue(toDays, forKey: "toDays")
                    person.setValue(feedId, forKey: "feedId")
                    person.setValue(feedProgram, forKey: "feedProgram")
                    person.setValue(isSync, forKey: "isSync")
                    person.setValue(feedType, forKey: "feedType")
                    person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciAlternative.append(person)
                }

            } catch {

            }

        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeed", in: managedContext)

            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(loginSessionId, forKey: "loginSessionId")
            person.setValue( postingId, forKey: "postingId")
            person.setValue( molecule, forKey: "molecule")
            person.setValue(dosage, forKey: "dosage")
            person.setValue(fromDays, forKey: "fromDays")
            person.setValue(toDays, forKey: "toDays")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(feedProgram, forKey: "feedProgram")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(feedType, forKey: "feedType")
            person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciAlternative.append(person)
        }
    }

    /******************** getApi  AlterNative data from server *****************/

    func getDataFromAlterNative(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {

        let entity = NSEntityDescription.entity(forEntityName: "AlternativeFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingId, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciAlternative.append(person)
    }

    func getDataFromAlterNativeForSingleDevToken(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingAlterNative: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "AlternativeFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingAlterNative, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciAlternative.append(person)
    }

    /***************** Fetch data Skleta ************************************************************************/

    func fetchAlternative(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AlternativeArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AlternativeArray

    }

    func fetchAlternativePostingId(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AlternativeArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AlternativeArray

    }

    func fetchAlternativeAlldata() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeed")

        fetchRequest.returnsObjectsAsFaults = false
        // fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                AlternativeArray = results as NSArray

            } else {

            }
        } catch {
        }

        return AlternativeArray

    }

    /////////////

    func saveMyCoxtinDatabase(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        MyCoxtinBindersArray = dbArray

        if  MyCoxtinBindersArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if (fetchedResult?.count <= index) {

                        let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeed", in: managedContext)
                        let person  = NSManagedObject(entity: entity!, insertInto: managedContext)
                        person.setValue(loginSessionId, forKey: "loginSessionId")
                        person.setValue( postingId, forKey: "postingId")
                        person.setValue( molecule, forKey: "molecule")
                        person.setValue(dosage, forKey: "dosage")
                        person.setValue(fromDays, forKey: "fromDays")
                        person.setValue(toDays, forKey: "toDays")
                        person.setValue(feedId, forKey: "feedId")
                        person.setValue(feedProgram, forKey: "feedProgram")
                        person.setValue(isSync, forKey: "isSync")
                        person.setValue(feedType, forKey: "feedType")
                        person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciMyCoxtinBinders.append(person)
                    } else {
                        let objTable: MyCotoxinBindersFeed = (fetchedResult![index] as? MyCotoxinBindersFeed)!

                        objTable.setValue(loginSessionId, forKey: "loginSessionId")
                        objTable.setValue( postingId, forKey: "postingId")
                        objTable.setValue( molecule, forKey: "molecule")
                        objTable.setValue(dosage, forKey: "dosage")
                        objTable.setValue(fromDays, forKey: "fromDays")
                        objTable.setValue(toDays, forKey: "toDays")
                        objTable.setValue(feedId, forKey: "feedId")
                        objTable.setValue(feedProgram, forKey: "feedProgram")
                        objTable.setValue(formName, forKey: "formName")
                        objTable.setValue(isSync, forKey: "isSync")
                        objTable.setValue(feedType, forKey: "feedType")
                        objTable.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                    }
                } else {
                    let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeed", in: managedContext)
                    let person  = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue(loginSessionId, forKey: "loginSessionId")
                    person.setValue( postingId, forKey: "postingId")
                    person.setValue( molecule, forKey: "molecule")
                    person.setValue(dosage, forKey: "dosage")
                    person.setValue(fromDays, forKey: "fromDays")
                    person.setValue(toDays, forKey: "toDays")
                    person.setValue(feedId, forKey: "feedId")
                    person.setValue(feedProgram, forKey: "feedProgram")
                    person.setValue(isSync, forKey: "isSync")
                    person.setValue(feedType, forKey: "feedType")
                    person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciMyCoxtinBinders.append(person)

                }

            } catch {

            }

        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeed", in: managedContext)
            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(loginSessionId, forKey: "loginSessionId")
            person.setValue( postingId, forKey: "postingId")
            person.setValue( molecule, forKey: "molecule")
            person.setValue(dosage, forKey: "dosage")
            person.setValue(fromDays, forKey: "fromDays")
            person.setValue(toDays, forKey: "toDays")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(feedProgram, forKey: "feedProgram")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(feedType, forKey: "feedType")
            person.setValue(cocoVacId, forKey: "coccidiosisVaccineId")
            do {
                try managedContext.save()
            } catch {
            }

            cocciMyCoxtinBinders.append(person)
        }
    }
    /************************** Ge api for MycocxoBinder *********************************/
    func getDataFromMyCocotinBinder(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {

        let entity = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingId, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciMyCoxtinBinders.append(person)
    }

    func getDataFromMyCocotinBinderWithSingleData(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingidMycotxin: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeed", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(postingId, forKey: "loginSessionId")
        person.setValue( postingidMycotxin, forKey: "postingId")
        person.setValue( dict.value(forKey: "molecule"), forKey: "molecule")
        person.setValue((dict.value(forKey: "dose") as AnyObject).stringValue, forKey: "dosage")
        person.setValue((dict.value(forKey: "durationFrom") as AnyObject).stringValue, forKey: "fromDays")
        person.setValue((dict.value(forKey: "durationTo") as AnyObject).stringValue, forKey: "toDays")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(feedProgramName, forKey: "feedProgram")
        person.setValue(false, forKey: "isSync")
        person.setValue(dict.value(forKey: "feedType"), forKey: "feedType")
        person.setValue(dict.value(forKey: "cocciVaccineId"), forKey: "coccidiosisVaccineId")

        do {
            try managedContext.save()
        } catch {
        }

        cocciMyCoxtinBinders.append(person)
    }

    /***************** Fetch data Skleta ************************************************************************/

    func fetchMyBinders(_ feedId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                MyCoxtinBindersArray = results as NSArray

            } else {
            }
        } catch {
        }

        return MyCoxtinBindersArray
    }

    func fetchMyBindersAllData() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeed")

        fetchRequest.returnsObjectsAsFaults = false
        // fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                MyCoxtinBindersArray = results as NSArray

            } else {
            }
        } catch {
        }

        return MyCoxtinBindersArray
    }

    func getFeedNameFromGetApi (_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "FeedProgram", in: managedContext)

        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(feedProgrameName, forKey: "feddProgramNam")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(sessionId, forKey: "loginSessionId")
        person.setValue(postingId, forKey: "postingId")
        person.setValue("", forKey: "formName")
        person.setValue(false, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
        }

        FeddProgram.append(person)
    }

    func getFeedNameFromGetApiSingleDeviceToken (_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber, postingIdFeed: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "FeedProgram", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(feedProgrameName, forKey: "feddProgramNam")
        person.setValue(feedId, forKey: "feedId")
        person.setValue(sessionId, forKey: "loginSessionId")
        person.setValue(postingIdFeed, forKey: "postingId")
        person.setValue("", forKey: "formName")
        person.setValue(false, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
        }

        FeddProgram.append(person)
    }

    /************************** Feed Program *******************************************************/
    func SaveFeedProgram(_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber, dbArray: NSArray, index: Int, formName: String, isSync: Bool) {

        feedprogramArray = dbArray

        if  feedprogramArray.count > 0 {

            let objTable: FeedProgram = (feedprogramArray[index] as? FeedProgram)!

            do {

                if objTable.feedId == feedId {

                    objTable.setValue(feedProgrameName, forKey: "feddProgramNam")
                    objTable.setValue(feedId, forKey: "feedId")
                    objTable.setValue(sessionId, forKey: "loginSessionId")
                    objTable.setValue(postingId, forKey: "postingId")
                    objTable.setValue(formName, forKey: "formName")
                    objTable.setValue(isSync, forKey: "isSync")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                }
            }

            return
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "FeedProgram", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(feedProgrameName, forKey: "feddProgramNam")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(formName, forKey: "formName")
            person.setValue(isSync, forKey: "isSync")

            do {
                try managedContext.save()
            } catch {
            }

            FeddProgram.append(person)
        }

    }

    func updateFeedProgram(_ feedId: NSNumber, isSync: Bool, feedProgrameName: String, formName: String) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgram")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                let objTable: FeedProgram = (fetchedResult![0] as? FeedProgram)!

                objTable.setValue(feedProgrameName, forKey: "feddProgramNam")
                objTable.setValue(formName, forKey: "formName")
                objTable.setValue(isSync, forKey: "isSync")

                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }
    /**************** Fetch complex posting *******************************************/

    func FetchFeedProgram(_ postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgram")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                feedprogramArray = results as NSArray

            } else {

            }
        } catch {
        }

        return feedprogramArray

    }

    /***************************************************/

    func FetchFeedProgramAll() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgram")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                feedprogramArray = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "feedId", ascending: true)
                let sortedResults = feedprogramArray.sortedArray(using: [descriptor])
                feedprogramArray = sortedResults as NSArray

            } else {

            }
        } catch {
        }

        return feedprogramArray

    }

    /*************** Create database capture necropsy step 1 *************************************/

    func SaveNecropsystep1(_ postingId: NSNumber, age: String, farmName: String, feedProgram: String, flockId: String, houseNo: String, noOfBirds: String, sick: NSNumber, necId: NSNumber, compexName: String, complexDate: String, complexId: NSNumber, custmerId: NSNumber, feedId: NSNumber, isSync: Bool, timeStamp: String, actualTimeStamp: String) {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CaptureNecropsyData", in: managedContext)

        let contact = CaptureNecropsyData(entity: entityDescription!, insertInto: managedContext)
        contact.age = age
        contact.farmName = farmName
        contact.feedProgram = feedProgram
        contact.flockId = flockId
        contact.sick = sick
        contact.houseNo = houseNo
        contact.noOfBirds = noOfBirds
        contact.postingId = postingId
        contact.necropsyId = necId
        contact.complexName = compexName
        contact.complexDate = complexDate
        contact.complexId = complexId
        contact.custmerId = custmerId
        contact.feedId = feedId
        contact.isChecked = false
        contact.isSync = isSync as NSNumber
        contact.timeStamp = timeStamp
        contact.actualTimeStamp = actualTimeStamp

        do {
            try managedContext.save()

        } catch {

            fatalError("Failure to save context: \(error)")
        }

        necrpsystep1.append(contact)
    }

    func SaveNecropsystep1SingleData(_ postingId: NSNumber, age: String, farmName: String, feedProgram: String, flockId: String, houseNo: String, noOfBirds: String, sick: NSNumber, necId: NSNumber, compexName: String, complexDate: String, complexId: NSNumber, custmerId: NSNumber, feedId: NSNumber, isSync: Bool, timeStamp: String, actualTimeStamp: String, necIdSingle: NSNumber) {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CaptureNecropsyData", in: managedContext)

        let contact = CaptureNecropsyData(entity: entityDescription!, insertInto: managedContext)
        contact.age = age
        contact.farmName = farmName
        contact.feedProgram = feedProgram
        contact.flockId = flockId
        contact.sick = sick
        contact.houseNo = houseNo
        contact.noOfBirds = noOfBirds
        contact.postingId = necIdSingle
        contact.necropsyId = necIdSingle
        contact.complexName = compexName
        contact.complexDate = complexDate
        contact.complexId = complexId
        contact.custmerId = custmerId
        contact.feedId = feedId
        contact.isChecked = false
        contact.isSync = isSync as NSNumber
        contact.timeStamp = timeStamp
        contact.actualTimeStamp = actualTimeStamp

        do {
            try managedContext.save()

        } catch {

            fatalError("Failure to save context: \(error)")
        }

        necrpsystep1.append(contact)
    }

    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func FetchNecropsystep1(_ postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1AllWithNecId(_ necId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        // fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1All() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        // fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1WithisSyncandPostingId(_ isSync: Bool, postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND necropsyId == %@", isSync as CVarArg, postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1WithisSync(_ isSync: Bool) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == 0", isSync as CVarArg)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }
    /********************************************************************/

    func FetchNecropsystep1NecId(_ necropsyId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necropsyId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }
    /***************************************************************************/
    func FetchNecropsystep1UpdateFromUnlinked(_ postingId: NSNumber) -> NSMutableArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                for captureNecropsyData in results {
                    let necId = captureNecropsyData.value(forKey: "necropsyId") as! NSNumber

                    for c in necropsySArray {
                        let n = (c as AnyObject).value(forKey: "necropsyId") as! NSNumber

                        if n == necId {
                            necropsySArray.remove(c)
                        }

                    }
                    necropsySArray.add(captureNecropsyData)

                }
            } else {

            }
        } catch {
        }

        return necropsySArray

    }

    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func FetchNecropsystep1neccId(_ necId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1neccIdAll() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1neccIdWithCheckFarm(_ necId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND isChecked == 0", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchFarmNameOnNecropsystep1neccId(_ necId: NSNumber, feedProgramName: String, feedId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@  AND isChecked == 1 AND feedId == %@", necId, feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func updateisSyncNecropsystep1neccId(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!

                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

                completion(true)
            } else {
                completion(true)
            }

        } catch {

        }

    }

    ///******>>>>///

    /****/

    func updateisSyncNecropsystep1WithneccId(_ necId: NSNumber, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!

                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {

                    }
                }
            }
        } catch {

        }
    }

    func updatComplexIdandComplexIDInNecropsystep1neccId(_ necId: NSNumber, complexName: String, complexId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyData = (fetchedResult![0] as? CaptureNecropsyData)!

                objTable.setValue(complexName, forKey: "complexName")
                objTable.setValue(complexId, forKey: "complexId")
                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    func FetchNecropsystep1neccIdTrueVal(_ necId: NSNumber, formTrueValue: Bool, feedProgram: String, feedId: NSNumber ) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false

        if formTrueValue == true {
            fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND isChecked == 1 AND feedId == %@", necId, feedId)
        } else {
            fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND isChecked == 0 AND feedId == %@", necId, feedId)
        }

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func updatePostingIdWithNecIdNecropsystep1(_ necId: NSNumber, postingId: NSNumber ) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!

                    objTable.setValue(postingId, forKey: "postingId")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }

    }

    func updatePostingIdWithNecIdNecropsystep1WithZero(_ necId: NSNumber, postingId: NSNumber ) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!

                    objTable.setValue(postingId, forKey: "postingId")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }

    }

    func updateFeedProgramNameoNNecropsystep1neccId(_ necId: NSNumber, feedProgramName: String, formName: String, isCheckForm: Bool, feedId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necId, formName, feedProgramName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: CaptureNecropsyData = (fetchedResult![0] as? CaptureNecropsyData)!

                objTable.setValue(feedProgramName, forKey: "feedProgram")
                objTable.setValue(feedId, forKey: "feedId")
                objTable.setValue(NSNumber(value: isCheckForm as Bool), forKey: "isChecked")
                do {
                    try managedContext.save()
                } catch {
                }

            }

        } catch {

        }

    }

    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func FetchNecropsystep1AllNecId() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray

            } else {

            }
        } catch {
        }

        return necropsyStep1Array

    }

    func FetchNecropsystep1AllNecIdWithPostingIDZero() -> NSMutableArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == 0")

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                for i in 0..<results.count {
                    let c = results[i] as! CaptureNecropsyData

                    let nId = c.necropsyId as!  Int

                    necropsyNIdArray.add(c)

                    for j in 0..<necropsyNIdArray.count - 1 {
                        let d = necropsyNIdArray.object(at: j)  as! CaptureNecropsyData
                        let n = d.necropsyId as!  Int

                        if n == nId {
                            necropsyNIdArray.remove(c)
                        }

                    }

                }

            } else {

            }
        } catch {
        }

        return necropsyNIdArray

    }

    /************************ Fetch Data Of Necropsy data 1 *******************************/

    func updateBirdNumberInNecropsystep1(_ postingId: NSNumber, index: Int) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyData = (fetchedResult![index] as? CaptureNecropsyData)!

            let noof: String = objTable.noOfBirds!
            let i: Int = Int(noof)!

            if i < 11 {
                let insertNumOfBirds: String = String(i + 1)

                objTable.setValue(insertNumOfBirds, forKey: "noOfBirds")
                do {
                    try managedContext.save()
                } catch {
                }
            }

        } catch {
        }

    }

    func updateBirdNumberInNecropsystep1withNecId(_ necId: NSNumber, index: Int, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyData = (fetchedResult![index] as? CaptureNecropsyData)!

            let noof: String = objTable.noOfBirds!
            let i: Int = Int(noof)!

            if i < 11 {
                let insertNumOfBirds: String = String(i + 1)

                objTable.setValue(insertNumOfBirds, forKey: "noOfBirds")
                objTable.setValue(isSync, forKey: "isSync")
                do {
                    try managedContext.save()
                } catch {
                }
            }

        } catch {
        }

    }

    func reduceBirdNumberInNecropsystep1(_ postingId: NSNumber, index: Int) -> Bool {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            var isBirdAvailable: Bool = true
            let objTable: CaptureNecropsyData = (fetchedResult![index] as? CaptureNecropsyData)!

            let noof: String = objTable.noOfBirds!
            let i: Int = Int(noof)!

            if i > 1 {
                let deleteNumOfBirds: String = String(i - 1)
                objTable.setValue(deleteNumOfBirds, forKey: "noOfBirds")
                do {
                    try managedContext.save()
                    isBirdAvailable = true
                    return isBirdAvailable
                } catch {
                    isBirdAvailable = false
                    return isBirdAvailable
                }
            } else {
                isBirdAvailable = false
                return isBirdAvailable
            }
        } catch {
        }
        return false
    }

    /******************** Delete Bird Using NecId *****************************************/

    func reduceBirdNumberInNecropsystep1WithNecId(_ necId: NSNumber, index: Int) -> Bool {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            var isBirdAvailable: Bool = true
            let objTable: CaptureNecropsyData = (fetchedResult![index] as? CaptureNecropsyData)!

            let noof: String = objTable.noOfBirds!
            let i: Int = Int(noof)!

            if i > 1 {
                let deleteNumOfBirds: String = String(i - 1)
                objTable.setValue(deleteNumOfBirds, forKey: "noOfBirds")
                do {
                    try managedContext.save()
                    isBirdAvailable = true
                    return isBirdAvailable
                } catch {
                    isBirdAvailable = false
                    return isBirdAvailable
                }
            } else {
                isBirdAvailable = false
                return isBirdAvailable
            }
        } catch {
        }
        return false
    }

    func fecthFrmWithBirdAndObservation(_ birdnumber: NSNumber, farmname: String, obsId: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND obsID == %@ AND formName == %@ AND necropsyId == %@", birdnumber, obsId, farmname, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    /******************************************************************/

    func fecthFrmWithBirdAndObservationAll() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        //fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND obsID == %@ AND formName == %@ AND necropsyId == %@", birdnumber,obsId,farmname , necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                captureNecSkeltetonArray = results as NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    /****************************************************************************/
    func fecthFrmWithCatnameWithBirdAndObservation(_ birdnumber: NSNumber, farmname: String, catName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdnumber, catName, farmname, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = captureNecSkeltetonArray.sortedArray(using: [descriptor])

                return sortedResults as  NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    func fecthFrmWithCatname(_ farmname: String, catName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "catName == %@ AND formName == %@ AND birdNo == %@ AND necropsyId == %@ ", catName, farmname, birdNo, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = captureNecSkeltetonArray.sortedArray(using: [descriptor])

                return sortedResults as NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    func updateQuickLinkOnCaptureNec(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, necId: NSNumber, quickLink: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID ==%@ AND necropsyId == %@", birdnumber, catName, farmname, Obsid, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewData = (fetchedResult![i] as? CaptureNecropsyViewData)!

                    objTable.setValue(quickLink, forKey: "quickLink")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }

    }

    func fecthFrmWithCatnameWithBirdAndObservationID(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID ==%@ AND necropsyId == %@", birdnumber, catName, farmname, Obsid, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = captureNecSkeltetonArray.sortedArray(using: [descriptor])

                return sortedResults as NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    func fecthobsDataWithCatnameAndFarmNameAndBirdNumber(_ birdnumber: NSNumber, farmname: String, catName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdnumber, catName, farmname, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = captureNecSkeltetonArray.sortedArray(using: [descriptor])

                return sortedResults as NSArray

            } else {

            }
        } catch {
        }

        return captureNecSkeltetonArray
    }

    func fetchObsWithBirdandFarmName(_ formName: String, birdNo: NSNumber, necId: NSNumber) -> NSMutableDictionary {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchPredicate = NSPredicate(format: "birdNo == %@  AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        let fetchRequest                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate                = fetchPredicate

        fetchRequest.returnsObjectsAsFaults = false
        let d  =  NSMutableDictionary()
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                captureNecSkeltetonArray = results as NSArray
                let c = results as NSArray
                print(c)

                for i in 0..<c.count {
                    let captureNecropsyViewData = c.object(at: i) as! CaptureNecropsyViewData

                    print(captureNecropsyViewData.obsName ?? "")
                   var trimmedString =
                        captureNecropsyViewData.obsName!.replacingOccurrences(of: "/", with: "")
                    trimmedString =
                        captureNecropsyViewData.obsName!.replacingOccurrences(of: " ", with: "")

                    if trimmedString == "BursaLesions"{
                        trimmedString = "BursaLesionScore"
                    } else if  trimmedString == "MuscularHemorrhages"{
                        trimmedString = "MuscularHemorrhagies"
                    } else if  trimmedString == "Cardiovascular/Hydropericardium"{
                        trimmedString = "CardiovascularHydropericardium"
                    } else if  trimmedString == "TBD1"{
                        trimmedString = "WoodyBreast"
                    } else if  trimmedString == "TBD2"{
                        trimmedString = "Pigmentation"
                    } else if  trimmedString == "TBD3"{
                        trimmedString = "IntestinalContents"
                    } else if  trimmedString == "TBD4"{
                        trimmedString = "ThickenedIntestine"
                    } else if  trimmedString == "TBD5"{
                        trimmedString = "ThinIntestine"
                    } else if  trimmedString == "TBD6"{
                        trimmedString = "Dehydrated"
                    } else if  trimmedString == "TBD7"{
                        trimmedString = "ThymusAtrophy"
                    } else if  trimmedString == "FemoralHeadSeparation(FHS)"{
                        trimmedString = "FemoralHeadSeparationFHS"
                    } else if  trimmedString == "EimeriaTenellaMicro"{
                        trimmedString = "TenellaMicro"
                    }

                    //d.setValue(captureNecropsyViewData.birdNo!, forKey: "BirdId")

                    if captureNecropsyViewData.measure == "Y,N" {
                        if captureNecropsyViewData.objsVisibilty != nil {

                            d.setValue(captureNecropsyViewData.objsVisibilty!, forKey: trimmedString)
                        }

                    } else if captureNecropsyViewData.measure == "Actual" {

                        if captureNecropsyViewData.actualText?.isEmpty == false {

                            d.setValue(captureNecropsyViewData.actualText!, forKey: trimmedString)

                        }

                    } else {
                        if captureNecropsyViewData.obsPoint != nil {

                            d.setValue(captureNecropsyViewData.obsPoint!, forKey: trimmedString)

                        }

                    }

                }

            } else {

            }
        } catch {
        }
        return d

    }

    func deleteCaptureNecropsyViewDataWithObsID (_ obsId: NSNumber) {

//        let appDel  = UIApplication.shared.delegate as! AppDelegate

        let fetchPredicate = NSPredicate(format: "obsID == %@", obsId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func deleteCaptureNecropsyViewDataWithFarmnameandBirdsize (_ obsId: NSNumber, formName: String, catName: String, birdNo: NSNumber, necId: NSNumber) {

//        let appDel  = UIApplication.shared.delegate as! AppDelegate

        let fetchPredicate = NSPredicate(format: "birdNo == %@  AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch {
            //print("There is some error.")
        }

    }

    /*******************************  Capture  data Base ********************************************************/
    /***************** save data Skleta ************************************************************************/

    func saveCaptureSkeletaInDatabaseOnSwithCase(catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, obsPoint: NSInteger, index: Int, obsId: NSInteger, measure: String, quickLink: NSNumber, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let entity   = NSEntityDescription.entity(forEntityName: "CaptureNecropsyViewData", in: managedContext)

        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(catName, forKey: "catName")
        person.setValue(birdNo, forKey: "birdNo")
        person.setValue(formName, forKey: "formName")
        person.setValue(obsId, forKey: "obsID")
        person.setValue(obsName, forKey: "obsName")
        person.setValue(obsPoint, forKey: "obsPoint")
        person.setValue(NSNumber(value: obsVisibility as Bool), forKey: "objsVisibilty")
        person.setValue(measure, forKey: "measure")
        person.setValue(quickLink, forKey: "quickLink")
        person.setValue(necId, forKey: "necropsyId")
        person.setValue(isSync, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
        }

        captureSkeletaObject.append(person)

    }

    func saveCaptureSkeletaInDatabaseOnSwithCaseSingleData(catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, obsPoint: NSInteger, index: Int, obsId: NSInteger, measure: String, quickLink: NSNumber, necId: NSNumber, isSync: Bool, necIdSingle: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "CaptureNecropsyViewData", in: managedContext)

        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(catName, forKey: "catName")
        person.setValue(birdNo, forKey: "birdNo")
        person.setValue(formName, forKey: "formName")
        person.setValue(obsId, forKey: "obsID")
        person.setValue(obsName, forKey: "obsName")
        person.setValue(obsPoint, forKey: "obsPoint")
        person.setValue(NSNumber(value: obsVisibility as Bool), forKey: "objsVisibilty")
        person.setValue(measure, forKey: "measure")
        person.setValue(quickLink, forKey: "quickLink")
        person.setValue(necIdSingle, forKey: "necropsyId")
        person.setValue(isSync, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
        }

        captureSkeletaObject.append(person)

    }

    func deleteDataWithStep2data (_ necId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func updateCaptureSkeletaInDatabaseOnActualClick(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, actualName: String, index: Int, necId: NSNumber, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdNo, catName, formName, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyViewData = (fetchedResult![index] as? CaptureNecropsyViewData)!

            objTable.setValue(actualName, forKey: "actualText")
            objTable.setValue(isSync, forKey: "isSync")

            do {
                try objTable.managedObjectContext!.save()
            } catch {
            }

        } catch {
        }

    }

    func updateisSyncOnCaptureSkeletaInDatabase(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewData = (fetchedResult![i] as? CaptureNecropsyViewData)!
                    objTable.setValue(isSync, forKey: "isSync")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

                completion(true)

            } else {
                completion(true)
            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateisSyncOnCaptureInDatabase(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!
                    objTable.setValue(isSync, forKey: "isSync")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

                completion(true)

            } else {
                completion(true)
            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateCaptureSkeletaInDatabaseOnStepper(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, index: Int, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, catName, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!

                objTable.setValue(index, forKey: "obsPoint")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateObsDataInCaptureSkeletaInDatabaseOnActual(_ obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, actualName: String, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!

                objTable.setValue(actualName, forKey: "actualText")
                objTable.setValue(true, forKey: "isSync")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    // MARK: - Update Swich Method //

    func updateCaptureSkeletaInDatabaseOnSwitchMethod(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, switchValue: Bool, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, catName, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!

                objTable.setValue(switchValue, forKey: "objsVisibilty")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateCaptureSkeletaInDatabaseOnSwithCase(_ catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, camraImage: UIImage, obsPoint: NSInteger, index: Int, obsId: NSInteger, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let imageData = NSData(data: UIImageJPEGRepresentation(camraImage, 1.0)!) as Data

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdNo, catName, formName, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = fecthPhotoArray.sortedArray(using: [descriptor])

                let objTable: CaptureNecropsyViewData = ((sortedResults as NSArray)[index] as? CaptureNecropsyViewData)!

                objTable.setValue(NSNumber(value: obsVisibility as Bool), forKey: "objsVisibilty")
                objTable.setValue(imageData, forKey: "cameraImage")
                objTable.setValue(obsPoint, forKey: "obsPoint")
                objTable.setValue(birdNo, forKey: "birdNo")
                objTable.setValue(formName, forKey: "formName")
                objTable.setValue(isSync, forKey: "isSync")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    /***************** Fetch data Skleta ************************************************************************/

    /****************************************************************************/

    /***************** Fetch data of qiuckLink basis of form ************************************************************************/

    func deleteCaptureNecropsyViewData () {

//        let appDel  = UIApplication.shared.delegate as! AppDelegate
//        let context = appDel.managedObjectContext
        let fetchUsers = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        //fetchUsers.returnsObjectsAsFaults   = false

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
            //print("There is some error.")
        }

    }

    // MARK: Bird Photo

    func getSaveImageFromServer(_ dict: NSDictionary) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext

        let encodedImageData = String(describing: dict.value(forKey: "image")!)
        let imageData = Data(base64Encoded: encodedImageData, options: NSData.Base64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        //let ImageData1 =
        let imageData1 = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!) as Data
        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCapture", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(dict.value(forKey: "farmName"), forKey: "farmName")
        person.setValue(dict.value(forKey: "categoryName"), forKey: "catName")
        person.setValue(dict.value(forKey: "birdNumber"), forKey: "birdNum")
         person.setValue(dict.value(forKey: "observationName"), forKey: "obsName")
        //person.setValue(" ", forKey:"obsName")
        person.setValue(dict.value(forKey: "observationId"), forKey: "obsId")
        person.setValue(imageData1, forKey: "photo")
        person.setValue(dict.value(forKey: "sessionId"), forKey: "necropsyId")
        person.setValue(false, forKey: "isSync")
        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        capturePhotoObject.append(person)

    }

    func getSaveImageFromServerSingledata(_ dict: NSDictionary, necIdSingle: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext

        let encodedImageData = String(describing: dict.value(forKey: "image")!)
        let imageData = Data(base64Encoded: encodedImageData, options: NSData.Base64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        //let ImageData1 =
        let imageData1 = NSData(data: UIImageJPEGRepresentation(image!, 1.0)!) as Data
        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCapture", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(dict.value(forKey: "farmName"), forKey: "farmName")
        person.setValue(dict.value(forKey: "categoryName"), forKey: "catName")
        person.setValue(dict.value(forKey: "birdNumber"), forKey: "birdNum")
         person.setValue(dict.value(forKey: "observationName"), forKey: "obsName")
       // person.setValue(" ", forKey:"obsName")
        person.setValue(dict.value(forKey: "observationId"), forKey: "obsId")
        person.setValue(imageData1, forKey: "photo")
        person.setValue(necIdSingle, forKey: "necropsyId")
        person.setValue(false, forKey: "isSync")
        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        capturePhotoObject.append(person)

    }

    func deleteImageForSingle (_ necId: NSNumber) {

        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchUsers.predicate                = fetchPredicate
        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    /************************** Get Api for Save Image from server **************************************/

    func saveCaptureSkeletaImageInDatabase(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, camraImage: UIImage, obsId: NSInteger, necropsyId: NSNumber, isSync: Bool ) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let imageData = NSData(data: UIImageJPEGRepresentation(camraImage, 1.0)!) as Data

        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCapture", in: managedContext)

        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(formName, forKey: "farmName")
        person.setValue(catName, forKey: "catName")
        person.setValue(birdNo, forKey: "birdNum")
        person.setValue(obsName, forKey: "obsName")
        person.setValue(obsId, forKey: "obsId")
        person.setValue(imageData, forKey: "photo")
        person.setValue(necropsyId, forKey: "necropsyId")
        person.setValue(isSync, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        capturePhotoObject.append(person)

    }
    /******************************************************************/
    func updateisSyncOnBirdPhotoCaptureDatabase(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: BirdPhotoCapture = (fetchedResult![i] as? BirdPhotoCapture)!
                    objTable.setValue(isSync, forKey: "isSync")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

                completion(true)

            } else {
                completion(true)
            }

        } catch {
            //print("There is some error.")
        }

    }
    func fecthPhotoWithFormName(_ farmname: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "farmName == %@ AND necropsyId == %@", farmname, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {
                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = fecthPhotoArray.sortedArray(using: [descriptor])

                return sortedResults as NSArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }

    func fecthPhotoWithiSynsTrue(_ isSync: Bool) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", isSync as CVarArg)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray
            } else {
                //print("Could not fetch result")
            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }

    func fecthPhotoWithCatnameWithBirdAndObservationID(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, obsName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "birdNum == %@ AND catName == %@ AND farmName == %@ AND obsId ==%@ AND obsName ==%@  AND necropsyId ==%@", birdnumber, catName, farmname, Obsid, obsName, necId)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = fecthPhotoArray.sortedArray(using: [descriptor])
                return sortedResults as NSArray
            } else {
                //print("Could not fetch result")
            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }

    func fecthPhotoWithCatnameWithBirdAndObservationIDandIsync(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, isSync: Bool, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "birdNum == %@ AND catName == %@ AND farmName == %@ AND obsId ==%@ AND isSync ==%@  AND necropsyId ==%@", birdnumber, catName, farmname, Obsid, isSync as CVarArg, necId)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {//print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = fecthPhotoArray.sortedArray(using: [descriptor])
                return sortedResults as NSArray
            } else {
                //print("Could not fetch result")
            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }

    func saveNoofBirdWithNotes(_ catName: String, notes: String, formName: String, birdNo: NSNumber, index: Int, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "NotesBird", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(formName, forKey: "formName")
        person.setValue(catName, forKey: "catName")
        person.setValue(notes, forKey: "notes")
        person.setValue(birdNo, forKey: "noofBirds")
        person.setValue(necId, forKey: "necropsyId")
        person.setValue(isSync, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        captureBirdWithNotesObject.append(person)

    }

    func saveNoofBirdWithNotesSingledata(_ catName: String, notes: String, formName: String, birdNo: NSNumber, index: Int, necId: NSNumber, isSync: Bool, necIdSingle: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "NotesBird", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        person.setValue(formName, forKey: "formName")
        person.setValue(catName, forKey: "catName")
        person.setValue(notes, forKey: "notes")
        person.setValue(birdNo, forKey: "noofBirds")
        person.setValue(necIdSingle, forKey: "necropsyId")
        person.setValue(isSync, forKey: "isSync")

        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        captureBirdWithNotesObject.append(person)

    }

    func deleteDataBirdNotesWithId (_ necId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchUsers.predicate                = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }

    func updateisSyncOnNotesBirdDatabase(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: NotesBird = (fetchedResult![i] as? NotesBird)!
                    objTable.setValue(isSync, forKey: "isSync")
                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

                completion(true)

            } else {
                completion(true)
            }

        } catch {
            //print("There is some error.")
        }

    }
    func updateNoofBirdWithNotes(_ catName: String, formName: String, birdNo: NSNumber, notes: String, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "noofBirds == %@ AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: NotesBird = (fetchedResult![0] as? NotesBird)!
                objTable.setValue(notes, forKey: "notes")
                objTable.setValue(isSync, forKey: "isSync")
                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    func st(_ catName: String, formName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "noofBirds == %@ AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fetchBirdNotesArray = results as NSArray

                return fetchBirdNotesArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return fetchBirdNotesArray
    }

    func fetchNoofBirdWithForm(_ catName: String, formName: String, necId: NSNumber ) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "catName == %@ AND formName == %@ AND necropsyId = %@", catName, formName, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fetchBirdNotesArray = results as NSArray

                return fetchBirdNotesArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return fetchBirdNotesArray
    }

    func fetchNotesWithBirdNumandFarmName(_ birdNo: NSNumber, formName: String, necId: NSNumber ) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")

        fetchRequest.predicate = NSPredicate(format: "formName == %@ AND noofBirds == %@ AND necropsyId == %@", formName, birdNo, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fetchBirdNotesArray = results as NSArray

                return fetchBirdNotesArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return fetchBirdNotesArray
    }

    func fetchNoofBirdWithNotes(_ catName: String, formName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "noofBirds == %@ AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fetchBirdNotesArray = results as NSArray

                return fetchBirdNotesArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return fetchBirdNotesArray
    }

    func deleteNotesBirdWithFarmname (_ formName: String, birdNo: NSNumber, necId: NSNumber) {

        //let appDel  = UIApplication.sharedApplication().delegate as! AppDelegate

        let fetchPredicate = NSPredicate(format: "noofBirds == %@  AND formName == %@ AND necropsyId = %@", birdNo, formName, necId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchUsers.predicate                = fetchPredicate
        //fetchUsers.returnsObjectsAsFaults   = false

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
            //print("There is some error.")
        }

    }

    func deleteNotesBird () {
//        
//        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //  let context = appDel.managedObjectContext
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")

        //fetchUsers.returnsObjectsAsFaults   = false

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
            //print("There is some error.")
        }

    }

    func fetchCaptureWithFormNameNecSkeltonData(farmName: String, necID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "formName == %@ AND necropsyId == %@", farmName, necID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                captureNecSkeltetonArray = results as NSArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return captureNecSkeltetonArray

    }

    func updateCellIndex(_ formName: String, necID: NSNumber, cellIndex: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "formName == %@ AND necropsyId == %@", formName, necID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!
                objTable.setValue(cellIndex, forKey: "cellIndex")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    /****************************************************************/

    func AllCappNecdata() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.predicate = NSPredicate(format: "formName == %@ AND necropsyId == %@", formName,necID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                captureNecSkeltetonArray = results as NSArray

            } else {
                //print("Could not fetch result")

            }
        } catch {
            //print("There is some error.")
        }

        return captureNecSkeltetonArray

    }

    /**************************  Quick Link Methods ****************************************/

    func updateObsDataInCaptureSkeletaInDatabaseOnStepper(_ obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, index: Int, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!

                objTable.setValue(index, forKey: "obsPoint")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }

    }

    /******************************* Switch Methods *************************************************/

    func updateSwitchDataInCaptureSkeletaInDatabaseOnSwitch(_ formName: String, birdNo: NSNumber, obsId: NSNumber, obsVisibility: Bool, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewData = (fetchedResult![0] as? CaptureNecropsyViewData)!

                objTable.setValue(NSNumber(value: obsVisibility as Bool), forKey: "objsVisibilty")

                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }

        } catch {
            //print("There is some error.")
        }
    }

    ////////**************Fetch Report Screen Data***************/////////////

    func fetchLastSessionDetails(_ postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false

        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)

        fetchRequest.predicate = fetchPredicate

        // fetchRequest.propertiesToFetch = ["observationField"]

        //fetchRequest.resultType = .DictionaryResultType

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                return results as NSArray

            } else {
                //print("Could not fetch result")

            }

        } catch {
            //print("There is some error.")
        }

        return dataArray
    }

    func fetch_GI_Tract_AllData(_ farmName: NSString, postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")

        fetchRequest.returnsObjectsAsFaults = false

        let fetchPredicate = NSPredicate(format: "necropsyId == %@ AND formName == %@", postingId, farmName)

        fetchRequest.predicate = fetchPredicate

        // fetchRequest.propertiesToFetch = ["observationField"]

        //fetchRequest.resultType = .DictionaryResultType

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                return results as NSArray

            } else {
                //print("Could not fetch result")

            }

        } catch {
            //print("There is some error.")
        }

        return dataArray
    }

    /********************** ***************************/

    func FarmsDataDatabase(_ stateName: String, stateId: NSNumber, farmName: String, farmId: NSNumber, countryName: String, countryId: NSNumber, city: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "FarmsList", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        person.setValue(city, forKey: "City")

        person.setValue(countryId, forKey: "CountryId")
        person.setValue(countryName, forKey: "CountryName")
        person.setValue(farmId, forKey: "FarmId")
        person.setValue(farmName, forKey: "FarmName")
        person.setValue(stateId, forKey: "StateId")
        person.setValue(stateName, forKey: "StateName")

        do {

            try managedContext.save()

        } catch {

        }

        FarmsTypeObject.append(person)

    }

    func fetchFarmsDataDatabase() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FarmsList")
        fetchRequest.returnsDistinctResults = true
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                farmsArrReturn = results as NSArray

            } else {

            }

        } catch {

        }
              return farmsArrReturn
          }

    /********** Fetch farm using ComlexId **********************/

    func fetchFarmsDataDatabaseUsingCompexId(complexId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FarmsList")
        fetchRequest.returnsDistinctResults = true
        fetchRequest.returnsObjectsAsFaults = false
        let fetchPredicate  = NSPredicate(format: "countryId == %@", complexId)
         fetchRequest.predicate = fetchPredicate

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                farmsArrReturn = results as NSArray

            } else {

            }

        } catch {

        }
        return farmsArrReturn
    }

    func removeDuplicates(_ array: NSMutableArray) -> NSMutableArray {
        var encountered = Set<String>()
        let result = NSMutableArray()
        for value in array {
            if encountered.contains(value as! String) {
                // Do not add a duplicate element.
            } else {
                // Add value to the set.
                encountered.insert(value as! String)
                // ... Append the value.
                result.add(value as! String)
            }
        }

        return result
    }
    // MARK: sync available
    func checkPostingSessionHasiSyncTrue(_ postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSession")
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingID as NSNumber)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                //print("fetch the HatcheryVacination results \(results)")

                fecthPhotoArray = results as NSArray
                (fecthPhotoArray[0] as! Dictionary).removeValue(forKey: "isSync").boo
            } else {
                //print("Could not fetch result")
            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }
    func checkNecropcySessionHasiSyncTrue(_ postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "postingid == %@", postingID as NSNumber)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray
            } else {
                //print("Could not fetch result")
            }
        } catch {
            //print("There is some error.")
        }

        return fecthPhotoArray
    }
    /************** Update FarmName ********************/
    func updateNecropsystep1WithNecIdAndFarmName(_ necropsyId: NSNumber, farmName: NSString, newFarmName: NSString, age: String, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyData")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necropsyId, farmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyData = (fetchedResult![i] as? CaptureNecropsyData)!
                    objTable.setValue(newFarmName, forKey: "farmName")
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(age, forKey: "age")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }
            }

        } catch {
        }

    }
    /******* Update Farm Name In Step ! ****************/
    func updateNewFarmAndAgeOnCaptureNecropsyViewData(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewData")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND formName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewData = (fetchedResult![i] as? CaptureNecropsyViewData)!
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(newFarmName, forKey: "formName")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdPhoto(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCapture")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: BirdPhotoCapture = (fetchedResult![i] as? BirdPhotoCapture)!
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(newFarmName, forKey: "farmName")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

            }

        } catch {
            //print("There is some error.")
        }

    }

    func updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdNotes(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBird")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND formName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: NotesBird = (fetchedResult![i] as? NotesBird)!
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(newFarmName, forKey: "formName")

                    do {
                        try objTable.managedObjectContext!.save()
                    } catch {
                    }
                }

            }

        } catch {
            //print("There is some error.")
        }

    }

}
