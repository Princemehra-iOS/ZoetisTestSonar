//
//  CoreDataHandlerTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 02/04/18.
//  Copyright © 2018 Alok Yadav. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandlerTurkey: NSObject {

    override init() {
        super.init()
        self.setupContext()
    }

    func setupContext() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedContext = appDelegate.managedObjectContext

    }


    //// Posting Session Turkey Methods ////
    var postingSession = [NSManagedObject]()
    var postingArray = NSArray()
    var postingArrayVetArray = NSMutableArray()
    var managedContext: NSManagedObjectContext! = nil
//
    //// Skelta Turkey Methods ////
    var dataSkeletaArray = NSArray()
    var settingsSkeletaObject = [NSManagedObject]()
     var cocoivacc = [NSManagedObject]()

    //// Cocci Turkey Methods ////
    var dataCociiaArray = NSArray()
    var settingsCocoii = [NSManagedObject]()

    //// Gitract Turkey Methods ////
    var dataGiTractArray = NSArray()
    var settingsGITract = [NSManagedObject]()

    //// Resp Turkey Methods ////
    var dataRespiratoryArray = NSArray()
    var settingsRespiratory  = [NSManagedObject]()

    //// Immune Turkey Methods ////
    var settingsImmune = [NSManagedObject]()
    var dataImmuneArray = NSArray()

     // addvaccination ///
    var hatcheryVaccinationObject = [NSManagedObject]()
    var dataArray = NSArray()
    var FieldVaccindataArray = NSArray()

    /// Sales Rep////
    var SalesRepDataArray = NSArray()
    var SalesRepData = [NSManagedObject]()

    /// Cocci Program Array////

    var CocoiiProgramArray = NSArray()
    var CocoiiProgram = [NSManagedObject]()
    var SessionTypeArray = NSArray()
    var BirdSizeArray = NSArray()
    var necropsyNIdArray = NSMutableArray()
    var complexArray = NSArray()
    var routeData = [NSManagedObject]()
    var  moleCule = [NSManagedObject]()
    var CustData = [NSManagedObject]()
    var VetData = [NSManagedObject]()
    var BirdSize = [NSManagedObject]()
    var SessionType = [NSManagedObject]()
    var BreedType = [NSManagedObject]()
    var complexNsObJECT = [NSManagedObject]()
    var loginType = [NSManagedObject]()
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

    var farmsArrReturn = NSArray()
    var custRep = NSArray()
    var routeArray = NSArray()
    var custArray = NSArray()
    var BreedTypeArray = NSArray()
    var VeterianTypeArray = NSArray()
    var loginArray = NSArray()
    var cocciControlArray = NSArray()
    var AlternativeArray = NSArray()
    var AntiboticArray = NSArray()
    var MyCoxtinBindersArray = NSArray()
    var feedprogramArray = NSArray()
    var openExistingArray = NSArray()
    var necropsyStep1Array = NSArray()
    var necropsySArray = NSMutableArray()
    var captureNecSkeltetonArray = NSArray()
    var obsNameWithPoint = NSMutableArray()
    var fecthPhotoArray = NSArray()
    var fetchBirdNotesArray = NSArray()

    /********* ConvertIng sessiondate *****************/

    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }

    /********* Add Vacination *******************************************/

    func saveHatcheryVacinationInDatabaseTurkey(_ type: String, strain: String, route: String, age: String, index: Int, dbArray: NSArray, postingId: NSNumber, vaciProgram: String, sessionId: NSNumber, isSync: Bool, lngId: NSNumber) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataArray = dbArray
        if dataArray.count > 0 {

            if let objTable: HatcheryVacTurkey = dataArray[index] as? HatcheryVacTurkey {

                objTable.setValue(type, forKey: "type")
                objTable.setValue(strain, forKey: "strain")
                objTable.setValue(route, forKey: "route")
                objTable.setValue(age, forKey: "age")
                objTable.setValue(postingId, forKey: "postingId")
                objTable.setValue(vaciProgram, forKey: "vaciNationProgram")
                objTable.setValue(sessionId, forKey: "loginSessionId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(lngId, forKey: "lngId")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {


            let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(type, forKey: "type")
            person.setValue(strain, forKey: "strain")
            person.setValue(route, forKey: "route")
            person.setValue(age, forKey: "age")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(vaciProgram, forKey: "vaciNationProgram")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            hatcheryVaccinationObject.append(person)
        }
    }


    func fetchAddvacinationDataAllTurkey() -> NSArray {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")

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


    func fetchAddvacinationDataTurkey(_ postnigId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")
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

    func fetchAddvacinationDataWithisSyncTurkey(_ postnigId: NSNumber, isSync: Bool) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND isSync == %@", postnigId, NSNumber(booleanLiteral: isSync))
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

    func fetchAllPostingSessionWithVetIdTurkey(_VetName: String) -> NSMutableArray {


        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "vetanatrionName == %@", _VetName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult != nil {

                for i in 0..<fetchedResult!.count {
                    let objTable: PostingSessionTurkey = (fetchedResult![i] as? PostingSessionTurkey)!
                    let pId =  objTable.postingId
                    if postingArrayVetArray.count > 0 {
                        if postingArrayVetArray.contains(pId ?? 0) == false {
                            postingArrayVetArray.add(pId ?? 0)
                        }
                    } else {
                        postingArrayVetArray.add(pId ?? 0)
                    }
                }
            }
        } catch {
        }

        return postingArrayVetArray
    }
    /********* Add Vacination fIELD Vaccination *******************************************/

    func getHatcheryDataFromServerTurkey(_ dict: NSDictionary) {
        let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

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

    func getHatcheryDataFromServerSingleFromDeviceIdTurkey(_ dict: NSDictionary, postingId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext

        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String
            let str = "hatchery"

            let vacArray1  =  CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId).mutableCopy() as! NSMutableArray
            print(vacArray1)

            if  stringValidate.substring(from: 0, to: 8) != str {
                if  (stringValidate == "fieldStrain1") {
                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("IBDV", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if(stringValidate == "fieldStrain2") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)

                    person.setValue("IBDV", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge2"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if (stringValidate == "fieldStrain3") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("IBV", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge3"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrain4") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("IBV", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge4"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrain5") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("TRT", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge5"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrain6") {
                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("TRT", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge6"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrain7") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("NDV", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge7"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrain8") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("NDV", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldAge8"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if (stringValidate == "fieldStrainST") {
                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("ST", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldSTAge"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "fieldStrainEcoli") {

                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("E.coli", forKey: "type")
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
                    person.setValue(dict.value(forKey: "fieldEcoliAge"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.value(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.value(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if (stringValidate == "fieldStrain9") {



                    let entity = NSEntityDescription.entity(forEntityName: "HatcheryVacTurkey", in: managedContext)

                    let person = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("Other", forKey: "type")
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


                    person.setValue(dict.object(forKey: "fieldStrain9"), forKey: "strain")
                    person.setValue(dict.object(forKey: "fieldAge9"), forKey: "age")

                    person.setValue(postingId, forKey: "postingId")
                    person.setValue(dict.object(forKey: "vaccinationName"), forKey: "vaciNationProgram")
                    person.setValue(dict.object(forKey: "sessionId"), forKey: "loginSessionId")
                    person.setValue(false, forKey: "isSync")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                }
            }
        }

        let vacArray2  =  CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(postingId).mutableCopy() as! NSMutableArray
        print(vacArray2)
    }
    /************************************/

    func getFieldDataFromServerTurkey(_ dict: NSDictionary) {
        let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

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

    func getFieldDataFromServerSingledataTurkey(_ dict: NSDictionary, postingId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext



        let allkeyArr = dict.allKeys as NSArray

        for  j in 0..<allkeyArr.count {

            let stringValidate = allkeyArr.object(at: j) as! String
            let str = "hatchery"


            if  stringValidate.substring(from: 0, to: 8) == str {

                if  (stringValidate == "hatcheryStrain1") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)

                    person.setValue(dict.value(forKey: "hatcheryStrain1"), forKey: "strain")
                    person.setValue("Marek", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if(stringValidate == "hatcheryStrain2") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("IBDV", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if (stringValidate == "hatcheryStrain3") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("IBV", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrain4") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("TRT", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrain5") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("NDV", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrain6") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("POX", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrain7") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("Reo", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrainST") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("ST", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                } else if (stringValidate == "hatcheryStrainEcoli") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("E.coli", forKey: "type")
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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)
                } else if (stringValidate == "hatcheryStrain8") {
                    let entity         = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

                    let person         = NSManagedObject(entity: entity!, insertInto: managedContext)
                    person.setValue("Others", forKey: "type")


                    let d = dict.mutableCopy() as! NSMutableDictionary
                    let s = d.object(forKey: "hatcheryStrain8") as! String
                    person.setValue(s, forKey: "strain")

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
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    hatcheryVaccinationObject.append(person)

                }


            }
            let vacArray1  =  CoreDataHandlerTurkey().fetchFieldAddvacinationDataTurkey(postingId).mutableCopy() as! NSMutableArray
            print(vacArray1)

        }

    }

    /************************/
    func saveFieldVacinationInDatabaseTurkey(_ type: String, strain: String, route: String, index: Int, dbArray: NSArray, postingId: NSNumber, vaciProgram: String, sessionId: NSNumber, isSync: Bool, lngId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        FieldVaccindataArray = dbArray
        if FieldVaccindataArray.count > 0 {

            if let objTable: FieldVaccinationTurkey = FieldVaccindataArray[index] as? FieldVaccinationTurkey {

                objTable.setValue(type, forKey: "type")
                objTable.setValue(strain, forKey: "strain")
                objTable.setValue(route, forKey: "route")
                objTable.setValue(postingId, forKey: "postingId")
                objTable.setValue(vaciProgram, forKey: "vaciNationProgram")
                objTable.setValue(sessionId, forKey: "loginSessionId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(lngId, forKey: "lngId")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {


            let entity = NSEntityDescription.entity(forEntityName: "FieldVaccinationTurkey", in: managedContext)

            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(type, forKey: "type")
            person.setValue(strain, forKey: "strain")
            person.setValue(route, forKey: "route")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(vaciProgram, forKey: "vaciNationProgram")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            hatcheryVaccinationObject.append(person)
        }
    }




    func fetchFieldAddvacinationDataAllTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccinationTurkey")
        fetchRequest.returnsObjectsAsFaults = false

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

    func fetchFieldAddvacinationDataTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccinationTurkey")
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

    func fetchFieldAddvacinationDataWithisSyncTrueTurkey(_ postingId: NSNumber, isSync: Bool) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccinationTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND isSync == %@", postingId, NSNumber(booleanLiteral: isSync))

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

    func updateisSyncValOnFieldAddvacinationDataTurkey(_ postingId: NSNumber, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccinationTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            let fetchArr = fetchedResult! as NSArray
             if fetchArr.count > 0 {
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
    func saveSettingsSkeletaInDatabaseTurkey(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        dataSkeletaArray = dbArray

        if  dataSkeletaArray.count > 0 {

            if let objTable: SkeletaTurkey = dataSkeletaArray[index] as? SkeletaTurkey {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(refId, forKey: "refId")
                objTable.setValue(isSync, forKey: "isSync")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity   = NSEntityDescription.entity(forEntityName: "SkeletaTurkey", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(refId, forKey: "refId")
            do {
                try managedContext.save()
            } catch {
            }

            settingsSkeletaObject.append(person)
        }
    }
    func updateSettingDataSkeltaTurkey (_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "SkeletaTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "refId == %@", refId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: SkeletaTurkey = (fetchedResult![i] as? SkeletaTurkey)!
                    // objTable.setValue(strObservationField, forKey:"observationField")
                    objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                    objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                    objTable.setValue(strInformation, forKey: "information")
                    //                    objTable.setValue(obsId, forKey:"observationId")
                    //                    objTable.setValue(measure, forKey:"measure")
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
    /***************** Fetch data Skleta ************************************************************************/

    func fetchAllSeettingdataTurkey() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "SkeletaTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataSkeletaArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataSkeletaArray

    }

    func fetchAllSeettingdataWithLngIdTurkey(lngId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "SkeletaTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataSkeletaArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataSkeletaArray

    }

    /***************************** Save Setting  Data Cocoii Data ***********************************************/


    func saveSettingsCocoiiInDatabaseTurkey(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataCociiaArray = dbArray

        if  dataCociiaArray.count > 0 {
            if let objTable: CoccidiosisTurkey = dataCociiaArray[index] as? CoccidiosisTurkey {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(refId, forKey: "refId")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {


            let entity  = NSEntityDescription.entity(forEntityName: "CoccidiosisTurkey", in: managedContext)

            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(refId, forKey: "refId")

            do {
                try managedContext.save()
            } catch {
            }

            settingsCocoii.append(person)
        }
    }

    func updateSettingDataCocoiiTurkey (_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "refId == %@", refId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CoccidiosisTurkey = (fetchedResult![i] as? CoccidiosisTurkey)!
                    //objTable.setValue(strObservationField, forKey:"observationField")
                    objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                    objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                    //                    objTable.setValue(strInformation, forKey:"information")
                    //                    objTable.setValue(obsId, forKey:"observationId")
                    //                    objTable.setValue(measure, forKey:"measure")
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
    /***************** Fetch data Skleta ************************************************************************/

    func fetchAllCocoiiDataTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataCociiaArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataCociiaArray

    }

    func fetchAllCocoiiDataUsinglngIdTurkey(lngId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataCociiaArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataCociiaArray

    }

    /******************************* Saving data Of GiTract********************************************/

    func saveSettingsGITractDatabaseTurkey(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataGiTractArray = dbArray

        if  dataGiTractArray.count > 0 {

            if let objTable: GITractTurkey = dataGiTractArray[index] as? GITractTurkey {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(refId, forKey: "refId")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {


            let entity  = NSEntityDescription.entity(forEntityName: "GITractTurkey", in: managedContext)

            let person  = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(refId, forKey: "refId")

            do {
                try managedContext.save()
            } catch {
            }

            settingsGITract.append(person)
        }
    }
    func updateSettingDataGitractTurkey (_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "GITractTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "refId == %@", refId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: GITractTurkey = (fetchedResult![i] as? GITractTurkey)!
                    //  objTable.setValue(strObservationField, forKey:"observationField")
                    objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                    objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                    //objTable.setValue(strInformation, forKey:"information")
                    //  objTable.setValue(obsId, forKey:"observationId")
                    //objTable.setValue(measure, forKey:"measure")
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
    /************** Fetch data Of GiTract* ***************************************/

    func fetchAllGITractDataTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "GITractTurkey")
        fetchRequest.returnsObjectsAsFaults = false


        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataGiTractArray = results as NSArray
            } else {

            }
        } catch {
        }

        return dataGiTractArray

    }

    func fetchAllGITractDataUsingLngIdTurkey(lngId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "GITractTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataGiTractArray = results as NSArray

            } else {

            }
        } catch {
        }

        return dataGiTractArray

    }

    /******************** Saving data Of Respiratory *********************************/

    func saveSettingsRespiratoryDatabaseTurkey(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataRespiratoryArray = dbArray

        if  dataRespiratoryArray.count > 0 {
            if let objTable: RespiratoryTurkey = dataRespiratoryArray[index] as? RespiratoryTurkey {
                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(refId, forKey: "refId")

            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {


            let entity = NSEntityDescription.entity(forEntityName: "RespiratoryTurkey", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(refId, forKey: "refId")

            do {
                try managedContext.save()
            } catch {
            }

            settingsRespiratory.append(person)
        }
    }

    func updateSettingDataRespTurkey (_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "RespiratoryTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "refId == %@", refId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: RespiratoryTurkey = (fetchedResult![i] as? RespiratoryTurkey)!
                    objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                    objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
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
    /************** Fetch data Of Respiratory* ***************************************/

    func fetchAllRespiratoryTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "RespiratoryTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataRespiratoryArray = results as NSArray


            } else {
            }
        } catch {
        }

        return dataRespiratoryArray

    }

    func fetchAllRespiratoryusingLngIdTurkey(lngId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "RespiratoryTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                dataRespiratoryArray = results as NSArray


            } else {
            }
        } catch {
        }

        return dataRespiratoryArray

    }


    /******************************* Saving data Of immune ********************************************/

    func saveSettingsImmuneDatabaseTurkey(_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        dataImmuneArray = dbArray

        if  dataImmuneArray.count > 0 {

            if let objTable: ImmuneTurkey = dataImmuneArray[index] as? ImmuneTurkey {

                objTable.setValue(strObservationField, forKey: "observationField")
                objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                objTable.setValue(strInformation, forKey: "information")
                objTable.setValue(obsId, forKey: "observationId")
                objTable.setValue(measure, forKey: "measure")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(refId, forKey: "refId")


            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "ImmuneTurkey", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(strObservationField, forKey: "observationField")
            person.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
            person.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
            person.setValue(strInformation, forKey: "information")
            person.setValue(obsId, forKey: "observationId")
            person.setValue(measure, forKey: "measure")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(refId, forKey: "refId")

            do {
                try managedContext.save()
            } catch {
            }

            settingsImmune.append(person)
        }
    }

    func updateSettingDataImmuneTurkey (_ strObservationField: String, visibilityCheck: Bool, quicklinks: Bool, strInformation: String, index: Int, dbArray: NSArray, obsId: NSInteger, measure: String, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "ImmuneTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "refId == %@", refId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: ImmuneTurkey = (fetchedResult![i] as? ImmuneTurkey)!
                    objTable.setValue(NSNumber(value: visibilityCheck as Bool), forKey: "visibilityCheck")
                    objTable.setValue(NSNumber(value: quicklinks as Bool), forKey: "quicklinks")
                    objTable.setValue(strInformation, forKey: "information")



                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }


    }

    /************** Fetch data Of immune* ***************************************/

    func fetchAllImmuneTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ImmuneTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult {

                dataImmuneArray = results as NSArray


            } else {

            }
        } catch {
        }

        return dataImmuneArray

    }


    func fetchAllImmuneUsingLngIdTurkey(lngId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ImmuneTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult {

                dataImmuneArray = results as NSArray


            } else {

            }
        } catch {
        }

        return dataImmuneArray

    }
    /**************** SAVING DATA ROUTE ****************************************************************/


    func saveRouteDatabaseTurkey(_ routeId: Int, routeName: String, lngId: Int, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        routeArray = dbArray

        if  routeArray.count > 0 {

            if let objTable: RouteTurkey = routeArray[index] as? RouteTurkey {

                objTable.setValue(routeId, forKey: "routeId")
                objTable.setValue(lngId, forKey: "lngId")
                objTable.setValue(routeName, forKey: "routeName")


            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "RouteTurkey", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(routeId, forKey: "routeId")
            person.setValue(lngId, forKey: "lngId")
            person.setValue(routeName, forKey: "routeName")

            do {
                try managedContext.save()
            } catch {
            }

            routeData.append(person)
        }
    }
    /**************** Fetch ROUTE ****************************************************************/


    func fetchRouteTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "RouteTurkey")
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

    func fetchRouteTurkeyLngId(lngId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "RouteTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

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


    func saveCustmerDatabaseTurkey(_ custId: Int, CustName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        custArray = dbArray

        if  custArray.count > 0 {

            if let objTable: CustmerTurkey = routeArray[index] as? CustmerTurkey {

                objTable.setValue(custId, forKey: "custId")
                objTable.setValue(CustName, forKey: "custName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "CustmerTurkey", in: managedContext)
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


    func fetchCustomerTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CustmerTurkey")
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

    func fetchCustomerWithCustIdTurkey(_ custId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CustmerTurkey")
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
    func SalesRepDataDatabaseTurkey(_ salesReptId: Int, salesRepName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        SalesRepDataArray = dbArray
        if  SalesRepDataArray.count > 0 {
            if let objTable: SalesrepTurkey = SalesRepDataArray[index] as? SalesrepTurkey {

                objTable.setValue(salesReptId, forKey: "salesReptId")
                objTable.setValue(salesRepName, forKey: "salesRepName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "SalesrepTurkey", in: managedContext)
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


    func fetchSalesrepTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SalesrepTurkey")
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

    func VetDataDatabaseTurkey(_ vetarId: Int, vtName: String, complexId: NSNumber, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        VeterianTypeArray = dbArray

        if  VeterianTypeArray.count > 0 {

            if let objTable: VeterationTurkey = VeterianTypeArray[index] as? VeterationTurkey {
                objTable.setValue(vetarId, forKey: "vetarId")
                objTable.setValue(complexId, forKey: "complexId")
                objTable.setValue(vtName, forKey: "vtName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "VeterationTurkey", in: managedContext)
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


    func fetchVetDataTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VeterationTurkey")

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



    func fetchVetDataPrdicateTurkey(_ complexId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "VeterationTurkey")
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


    func CocoiiProgramDatabaseTurkey(_ cocoiiId: Int, cocoiProgram: String, lngId: Int, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        CocoiiProgramArray = dbArray

        if  CocoiiProgramArray.count > 0 {

            if let objTable: CocciProgramPostingTurkey = CocoiiProgramArray[index] as? CocciProgramPostingTurkey {

                objTable.setValue(cocoiiId, forKey: "cocciProgramId")
                objTable.setValue(cocoiProgram, forKey: "cocciProgramName")
                  objTable.setValue(lngId, forKey: "lngId")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "CocciProgramPostingTurkey", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(cocoiiId, forKey: "cocciProgramId")
            person.setValue(cocoiProgram, forKey: "cocciProgramName")
            person.setValue(lngId, forKey: "lngId")


            do {
                try managedContext.save()
            } catch {
            }

            CocoiiProgram.append(person)
        }
    }
    /**************** Fetch Cooci  ****************************************************************/


    func fetchCocoiiProgramTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CocciProgramPostingTurkey")
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

    func fetchCocoiiProgramTurkeyLngId(lngId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CocciProgramPostingTurkey")
        fetchRequest.returnsObjectsAsFaults = false
         fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

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

    func BirdSizeDatabaseTurkey(_ birddId: Int, birdSize: String, scaleType: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        BirdSizeArray = dbArray

        if  BirdSizeArray.count > 0 {
            if let objTable: BirdSizePostingTurkey = BirdSizeArray[index] as? BirdSizePostingTurkey {
                objTable.setValue(birddId, forKey: "birdSizeId")
                objTable.setValue(birdSize, forKey: "birdSize")
                objTable.setValue(scaleType, forKey: "scaleType")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "BirdSizePostingTurkey", in: managedContext)

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


    func fetchBirdSizeTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdSizePostingTurkey")
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

    func SessionTypeDatabaseTurkey(_ sesionId: Int, sesionType: String, lngId: Int, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        SessionTypeArray = dbArray

        if  SessionTypeArray.count > 0 {
            if let objTable: SessiontypeTurkey = SessionTypeArray[index] as? SessiontypeTurkey {
                objTable.setValue(sesionId, forKey: "sesionId")
                objTable.setValue(sesionType, forKey: "sesionType")
                objTable.setValue(lngId, forKey: "lngId")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "SessiontypeTurkey", in: managedContext)
            let person = NSManagedObject(entity: entity!, insertInto: managedContext)
            person.setValue(sesionId, forKey: "sesionId")
            person.setValue(sesionType, forKey: "sesionType")
            person.setValue(lngId, forKey: "lngId")
            do {
                try managedContext.save()
            } catch {
            }

            SessionType.append(person)
        }
    }
    /**************** Fetch  SessionType *******************************************/


    func fetchSessiontypeTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SessiontypeTurkey")
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
    func fetchSessiontypeTurkeyLngId(lngId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SessiontypeTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

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
    func saveMoleCuleTurkey(_ catId: Int, decscMolecule: String, moleculeId: Int, lngId: Int) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "MoleculeFeeedTurkey", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        //  cdcvdvdvdfbvfbfbfbn

        person.setValue(catId, forKey: "catId")
        person.setValue(decscMolecule, forKey: "desc")
        person.setValue(lngId, forKey: "lngId")
        person.setValue(moleculeId, forKey: "moleculeId")

        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        moleCule.append(person)


    }

    func fetchMoleCuleTurkeyLngId(lngId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MoleculeFeeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

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
    ///////////////////   SAVING DATA SessionType   //////////////////////////////

    func BreedTypeDatabaseTurkey(_ breedId: Int, breedType: String, breedName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        BreedTypeArray = dbArray

        if  BreedTypeArray.count > 0 {
            if let objTable: BreedTurkey = BreedTypeArray[index] as? BreedTurkey {
                objTable.setValue(breedId, forKey: "breedId")
                objTable.setValue(breedType, forKey: "breedType")
                objTable.setValue(breedName, forKey: "breedName")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "BreedTurkey", in: managedContext)

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


    func fetchBreedTypeTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BreedTurkey")
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


    func ComplexDatabaseTurkey(_ comlexId: NSNumber, cutmerid: NSNumber, complexName: String, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        complexArray = dbArray

        if  complexArray.count > 0 {

            if let objTable: ComplexPostingTurkey = complexArray[index] as? ComplexPostingTurkey {

                objTable.setValue(comlexId, forKey: "complexId")
                objTable.setValue(complexName, forKey: "complexName")
                objTable.setValue(cutmerid, forKey: "customerId")
            }
            do {
                try managedContext.save()
            } catch {
            }
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "ComplexPostingTurkey", in: managedContext)

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
    func fetchAllPostingExistingSessionwithFullSessionAndComplexTurkey(_ session: NSNumber, complexName: NSString) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

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

    func fetchAllPostingExistingSessionwithFullSessionAndUniqueComplexTurkey(_ complexID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

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


    func fetchCompexTypeTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ComplexPostingTurkey")
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

    func deleteAllDataTurkey(_ entity: String) {
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
    func fetchCompexTypePrdicateTurkey(_ CustomerId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ComplexPostingTurkey")
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
    func LoginDatabaseTurkey(_ userTypeId: NSNumber, userId: NSNumber, userName: String, status: NSNumber, signal: String, loginId: NSNumber, dbArray: NSArray, index: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        loginArray = dbArray

        if  loginArray.count > 0 {

            if let objTable: LoginTurkey = loginArray[index] as? LoginTurkey {
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

            let entity = NSEntityDescription.entity(forEntityName: "LoginTurkey", in: managedContext)
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
    func fetchLoginTypeTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginTurkey")
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

    func fetchLoginTypeWithUserEmailTurkey(email: String) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginTurkey")
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

    func postCustomerRepsTurkey(_ customername: String, userid: Int) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "CustomerReprestativeTurkey", in: managedContext)
        let arr =  fectCustomerRepresenttiveWithCustomernameTurkey(customername)

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
    func fectCustomerRepresenttiveWithCustomernameTurkey ( _ customername: String) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerReprestativeTurkey")
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
    func fectCustomerRepWithCustomernameTurkey ( _ usrid: Int) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CustomerReprestativeTurkey")
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

    func deleteDataWithPostingIdTurkey (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
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

    func deleteDataWithPostingIdStep1dataTurkey (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
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
    func deleteDataWithPostingIdStep2dataCaptureNecViewTurkey (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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
    func deleteDataWithPostingIdStep2NotesBirdTurkey (_ postingId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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

    func deleteDataWithPostingIdStep2CameraIamgeTurkey (_ postingId: NSNumber) {

        let fetchPredicate = NSPredicate(format: "necropsyId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
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

    func deleteDataWithPostingIdHatcheryTurkey (_ postingId: NSNumber) {

        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")
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
    func deleteDataWithPostingIdFieldVacinationWithSingleTurkey (_ postingId: NSNumber) {
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
    func deleteDataWithDeviceSessionIdTurkey (postingId: NSNumber) {

        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchUsers.predicate  = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }
    func deleteHetcharyVacDataWithPostingIdTurkey (_ postingId: NSNumber) {


        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")
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

    func deletefieldVACDataWithPostingIdTurkey (_ postingId: NSNumber) {

        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "FieldVaccinationTurkey")
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
    func deleteDataWithPostingIdFeddProgramTurkey (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgramTurkey")
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
    func deleteDataWithPostingIdFeddProgramCocoiiSinleTurkey (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
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

    func deleteDataWithPostingIdFeddProgramAlternativeSinleTurkey(_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")
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

    func deleteDataWithPostingIdFeddProgramAntiboiticSingleTurkey (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")
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

    func deleteDataWithPostingIdFeddProgramMyCotoxinSingleTurkey (_ postingIdFeed: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "postingId == %@", postingIdFeed)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")
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
    func deleteDataWithPostingIdCaptureStepDataTurkey (_ necId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
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

    func updateisSyncOnHetcharyVacDataWithPostingIdTurkey (_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let fetchPredicate = NSPredicate(format: "postingId == %@", postingId)

        let fetchUsers    = NSFetchRequest<NSFetchRequestResult>(entityName: "HatcheryVacTurkey")
        fetchUsers.predicate                = fetchPredicate

        do {
            let fetchedResult = try managedContext.fetch(fetchUsers) as? [NSManagedObject]
            let fetchArr = fetchedResult as! NSArray
            if fetchArr.count > 0 {
            for i in 0..<fetchedResult!.count {

                    let objTable: HatcheryVacTurkey = (fetchedResult![i] as? HatcheryVacTurkey)!

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

    func autoIncrementidtableTurkey() {
        var auto = self.fetchFromAutoIncrementTurkey()
        auto += 1
        //let auto1 = Int(auto.autoId!) + 1
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "IdTurkey", in: managedContext)
        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue(auto, forKey: "autoId")
        do {
            try managedContext.save()
        } catch {
        }


    }
    func fetchFromAutoIncrementTurkey() -> Int {
        //var auto: NSManagedObject?
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "IdTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        var auto: Int?
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            auto = fetchedResult?.count == 0 ? 0 : 0
            if let results = fetchedResult {
                if results.count > 0 {
                    let ob: IdTurkey = results.last as! IdTurkey
                    auto = Int(ob.autoId!)
                }
            } else {


            }


        } catch {
        }

        return auto!

    }
    ///////////////// ** Posting Session Data Save In Add Vacination Button **///////

    func PostingSessionDbTurkey(_ antobotic: String, birdBreesId: NSNumber, birdbreedName: String, birdBreedType: String, birdSize: String, birdSizeId: NSNumber, cocciProgramId: NSNumber, cociiProgramName: String, complexId: NSNumber, complexName: String, convential: String, customerId: NSNumber, customerName: String, customerRepId: NSNumber, customerRepName: String, imperial: String, metric: String, notes: String, salesRepId: NSNumber, salesRepName: String, sessiondate: String, sessionTypeId: NSNumber, sessionTypeName: String, vetanatrionName: String, veterinarianId: NSNumber, loginSessionId: NSNumber, postingId: NSNumber, mail: String, female: String, finilize: NSNumber, isSync: Bool, timeStamp: String, lngId: NSNumber, birdType: String, birdTypeId: NSNumber, birdbreedId: NSNumber, capNec: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        self.deleteDataWithPostingIdTurkey(postingId)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSessionTurkey", in: managedContext)
        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue(convential, forKey: "convential")
        contact1.setValue(antobotic, forKey: "antiboitic")
        contact1.setValue(birdbreedId, forKey: "birdBreedId")
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
        contact1.setValue(lngId, forKey: "lngId")
        contact1.setValue(capNec, forKey: "catptureNec")
        // contact1.setValue(birdTypeId, forKey:"birdTypeId")




        // contact1.setValue(actualTimeStamp, forKey:"actualTimeStamp")


        do {
            try managedContext.save()
        } catch {
        }

        postingSession.append(contact1)

    }
    /************* Update Posting session *****************/

    func updatePostingSessionForNextButtonTurkey(_ postingId: NSNumber, antobotic: String, birdBreesId: NSNumber, birdbreedName: String, birdBreedType: String, birdSize: String, birdSizeId: NSNumber, cocciProgramId: NSNumber, cociiProgramName: String, complexId: NSNumber, complexName: String, convential: String, customerId: NSNumber, customerName: String, customerRepId: NSNumber, customerRepName: String, imperial: String, metric: String, notes: String, salesRepId: NSNumber, salesRepName: String, sessiondate: String, sessionTypeId: NSNumber, sessionTypeName: String, vetanatrionName: String, veterinarianId: NSNumber, loginSessionId: NSNumber, mail: String, female: String, finilize: NSNumber, isSync: Bool, timeStamp: String, lngId: NSNumber, birdType: String, birdTypeId: NSNumber) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
                objTable.setValue(convential, forKey: "convential")
                objTable.setValue(antobotic, forKey: "antiboitic")
                objTable.setValue(0, forKey: "birdBreedId")
                objTable.setValue(birdbreedName, forKey: "birdBreedName")
                objTable.setValue(birdBreedType, forKey: "birdBreedType")
                objTable.setValue(birdSize, forKey: "birdSize")
                objTable.setValue(birdSizeId, forKey: "birdSizeId")
                objTable.setValue(cocciProgramId, forKey: "cocciProgramId")
                objTable.setValue(cociiProgramName, forKey: "cociiProgramName")
                objTable.setValue(complexId, forKey: "complexId")
                objTable.setValue(complexName, forKey: "complexName")
                objTable.setValue(customerId, forKey: "customerId")
                objTable.setValue(customerName, forKey: "customerName")
                objTable.setValue(customerRepId, forKey: "customerRepId")
                objTable.setValue(customerRepName, forKey: "customerRepName")
                objTable.setValue(imperial, forKey: "imperial")
                objTable.setValue(metric, forKey: "metric")
                objTable.setValue(notes, forKey: "notes")
                objTable.setValue(salesRepId, forKey: "salesRepId")
                objTable.setValue(salesRepName, forKey: "salesRepName")
                objTable.setValue(sessiondate, forKey: "sessiondate")
                objTable.setValue(sessionTypeId, forKey: "sessionTypeId")
                objTable.setValue(sessionTypeName, forKey: "sessionTypeName")
                objTable.setValue(vetanatrionName, forKey: "vetanatrionName")
                objTable.setValue(veterinarianId, forKey: "veterinarianId")
                objTable.setValue(loginSessionId, forKey: "loginSessionId")
                objTable.setValue(postingId, forKey: "postingId")
                objTable.setValue(mail, forKey: "mail")
                objTable.setValue(female, forKey: "female")
                objTable.setValue(finilize, forKey: "finalizeExit")
                objTable.setValue(isSync, forKey: "isSync")
                objTable.setValue(timeStamp, forKey: "timeStamp")
                objTable.setValue(lngId, forKey: "lngId")
              //  objTable.setValue(birdType, forKey:"birdType")
                //objTable.setValue(birdTypeId, forKey:"birdTypeId")

                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }

    /************* Update Posting on DashBoard session *****************/


    func updatePostingSessionOndashBoardTurkey(_ postingId: NSNumber, vetanatrionName: String, veterinarianId: NSNumber, captureNec: NSNumber
        ) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
                objTable.setValue(vetanatrionName, forKey: "vetanatrionName")
                objTable.setValue(veterinarianId, forKey: "veterinarianId")
                objTable.setValue("-Select-", forKey: "cociiProgramName")
                objTable.setValue("", forKey: "customerRepName")
                objTable.setValue("", forKey: "birdBreedName")
                objTable.setValue("", forKey: "birdBreedType")
                objTable.setValue("-Select-", forKey: "birdSize")
                objTable.setValue("", forKey: "convential")
                objTable.setValue("", forKey: "imperial")
                objTable.setValue("", forKey: "salesRepName")
                objTable.setValue("", forKey: "notes")
                objTable.setValue("Male", forKey: "mail")
                objTable.setValue("Female", forKey: "female")
                objTable.setValue(captureNec, forKey: "catptureNec")
                objTable.setValue("Field Visit", forKey: "sessionTypeName")
                //objTable.setValue(true, forKey:"isSync")

                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }

    /*************************** Get Api Method for Postong Session **********************/
    func getPostingDataTurkey(_ dict: NSDictionary) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let postingId = dict.value(forKey: "SessionId") as! Int
        self.deleteDataWithPostingIdTurkey(postingId as NSNumber)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSessionTurkey", in: managedContext)

        let contact1 = NSManagedObject(entity: entity!, insertInto: managedContext)
        contact1.setValue("NA", forKey: "convential")
        contact1.setValue("NA", forKey: "antiboitic")
        contact1.setValue(dict.value(forKey: "BirdTypeId"), forKey: "birdBreedId")
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




        let salesFirstName = dict.value(forKey: "SalesRepFirstName")
        let salesLastname = dict.value(forKey: "SalesRepLastName")
        let salesRepName = "\(salesFirstName!) \(salesLastname!)"

        contact1.setValue(dict.value(forKey: salesRepName), forKey: "salesRepName")


     //   contact1.setValue(dict.value(forKey: "SalesRepFirstName"), forKey:"salesRepName")
        contact1.setValue(dict.value(forKey: "LanguageId"), forKey: "lngId")
        let sessionDa = convertDateFormater(dict.value(forKey: "SessionDate") as! String)
        contact1.setValue(sessionDa, forKey: "sessiondate")
        //contact1.setValue("20/20/2020", forKey:"sessiondate")
        contact1.setValue(dict.value(forKey: "SessionTypeId"), forKey: "sessionTypeId")
        contact1.setValue(dict.value(forKey: "SessionType"), forKey: "sessionTypeName")

        let vetId = dict.value(forKey: "VetUserId") as! Int
        if vetId == 0 {
            contact1.setValue("", forKey: "vetanatrionName")
        } else {
            let vetFirstName = dict.value(forKey: "VetFirstName")
            let vetLastname = dict.value(forKey: "VetLastName")
            let firstLastName = "\(vetFirstName!) \(vetLastname!)"
            contact1.setValue(firstLastName, forKey: "vetanatrionName")
        }
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
    func getPostingDatWithSpecificIdTurkey(_ dict: NSDictionary, postinngId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let postingId = dict.value(forKey: "SessionId") as! Int
        self.deleteDataWithDeviceSessionIdTurkey(postingId: postinngId)
        let entity = NSEntityDescription.entity(forEntityName: "PostingSessionTurkey", in: managedContext)

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

        let salesFirstName = dict.value(forKey: "SalesRepFirstName")
        let salesLastname = dict.value(forKey: "SalesRepLastName")
        let salesRepName = "\(salesFirstName!) \(salesLastname!)"

        contact1.setValue(salesRepName, forKey: "salesRepName")
        let sessionDa = convertDateFormater(dict.value(forKey: "SessionDate") as! String)
        contact1.setValue(sessionDa, forKey: "sessiondate")
        contact1.setValue(dict.value(forKey: "LanguageId"), forKey: "lngId")
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




    func updateFinalizeDataActualTurkey(_ postingId: NSNumber, deviceToken: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
                objTable.setValue(deviceToken, forKey: "actualTimeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }




    func updateFinalizeDataActualNecTurkey(_ necId: NSNumber, deviceToken: String) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyDataTurkey = (fetchedResult![0] as? CaptureNecropsyDataTurkey)!
                objTable.setValue(deviceToken, forKey: "actualTimeStamp")

                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }


    func updateFeddProgramInStep1Turkey(_ necId: NSNumber, feedname: String, feedId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND feedId == %@", necId, feedId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {

                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!
                    //objTable.setValue(deviceToken, forKey:"feedId")
                    objTable.setValue(feedname, forKey: "feedProgram")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                }

            }


        } catch {

        }
    }


    func updateFeddProgramInStep1UsingFarmNameTurkey(_ necId: NSNumber, feedname: String, feedId: NSNumber, formName: String) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necId, formName)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!
                    objTable.setValue(feedname, forKey: "feedProgram")
                    objTable.setValue(feedId, forKey: "feedId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                }

            }


        } catch {

        }


    }

    func updateFinalizeDataTurkey(_ postingId: NSNumber, finalize: NSNumber, isSync: Bool) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
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

    func updatedeviceTokenForPostingIdTurkey(_ postingId: NSNumber, timeStamp: String, actualTimestamp: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
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

    func updatedPostigSessionwithIsFarmSyncPostingIdTurkey(_ postingId: NSNumber, isFarmSync: Bool) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
                objTable.setValue(isFarmSync, forKey: "isfarmSync")


                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }

    func searchTokenForPostingIdTurkey(timeStampId: String) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "timeStamp == %@", timeStampId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!
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

    func updateFinalizeDataWithNecGetApiTurkey(_ postingId: NSNumber, finalizeNec: NSNumber) {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!

                objTable.setValue(finalizeNec, forKey: "catptureNec")
                objTable.setValue(0, forKey: "birdBreedId")
                do {
                    try managedContext.save()
                } catch {
                }

            }
        } catch {

        }

    }

    func updateFinalizeDataWithNecTurkey(_ postingId: NSNumber, finalizeNec: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do { let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!

                objTable.setValue(finalizeNec, forKey: "catptureNec")
                objTable.setValue(finalizeNec, forKey: "birdBreedId")
                do {
                    try managedContext.save()
                } catch {
                }

            }
        } catch {

        }

    }


    func updateFinalizeDataWithNecNotesTurkey(_ postingId: NSNumber, notes: String) { let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!

                objTable.setValue(notes, forKey: "notes")
                objTable.setValue(true, forKey: "isSync")

                do {
                    try managedContext.save()
                } catch {
                }
            }
        } catch {

        }
    }


    func updateisSyncOnPostingSessionTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: PostingSessionTurkey = (fetchedResult![i] as? PostingSessionTurkey)!

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


    func updateisAllSyncFalseOnPostingSessionTurkey(_ isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", NSNumber(booleanLiteral: isSync))

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {

                    let objTable: PostingSessionTurkey = (fetchedResult![i] as? PostingSessionTurkey)!

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

    func updateisSyncTrueOnPostingSessionTurkey(_ postingId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {



                let objTable: PostingSessionTurkey = (fetchedResult![0] as? PostingSessionTurkey)!

                objTable.setValue(true, forKey: "isSync")
                do {
                    try managedContext.save()
                } catch {
                }


            }



        } catch {

        }


    }



    func fetchAllPostingSessionWithNumberTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

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

    func fetchAllPostingSessionTurkey(_ postingid: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

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

    func fetchAllPostingSessionWithisSyncisTrueTurkey(_ isSync: Bool) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", NSNumber(booleanLiteral: isSync))

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

    func fetchAllPostingExistingSessionTurkey() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

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

    func fetchAllPostingExistingSessionwithFullSessionTurkeyCapNic(_ session: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "catptureNec == %@", session)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sessiondate", ascending: false)

                let sortedResults = postingArray.sortedArray(using: [descriptor])

                postingArray = sortedResults as NSArray


            } else {


            }
        } catch {
        }

        return postingArray

    }



    func fetchAllPostingExistingSessionwithFullSessionTurkey(_ session: NSNumber, birdTypeId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "catptureNec == %@ AND birdBreedId == %@", session, birdTypeId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sessiondate", ascending: false)

                let sortedResults = postingArray.sortedArray(using: [descriptor])

                postingArray = sortedResults as NSArray


            } else {


            }
        } catch {
        }

        return postingArray

    }


    func fetchAllWithOutFeddTurkey(capNec: NSNumber, birdTypeId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "catptureNec == %@ AND birdBreedId == %@", capNec, birdTypeId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sessiondate", ascending: false)

                let sortedResults = postingArray.sortedArray(using: [descriptor])

                postingArray = sortedResults as NSArray


            } else {


            }
        } catch {
        }

        return postingArray

    }

    func fetchAllPostingExistingSessionwithFullSessionSessionDateTurkey(_ session: NSNumber, birdTypeId: NSNumber, todate: String, lasatdate: String) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        let datePredicate = NSPredicate(format: "catptureNec == %@ AND birdBreedId == %@ AND sessiondate >=  %@ AND sessiondate  <=  %@", session, birdTypeId, todate, lasatdate )
        fetchRequest.predicate = datePredicate

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                postingArray  = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "sessiondate", ascending: false)

                let sortedResults = postingArray.sortedArray(using: [descriptor])

                postingArray = sortedResults as NSArray


            } else {


            }
        } catch {
        }

        return postingArray

    }

    /********************************* Save data in to CocoiPrgramFeed *************************************/
    func saveCoccoiControlDatabaseTurkey(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, coccidiosisVaccine: String, targetWeight: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber, lngId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        cocciControlArray = dbArray

        if  cocciControlArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if ((fetchedResult?.count)! <= index) {

                        let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeedTurkey", in: managedContext)

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
                        person.setValue(lngId, forKey: "lngId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciCoccidiosControl.append(person)

                    } else {
                        let objTable: CoccidiosisControlFeedTurkey = (fetchedResult![index] as? CoccidiosisControlFeedTurkey)!

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
                        objTable.setValue(lngId, forKey: "lngId")
                        do {
                            try managedContext.save()
                        } catch {
                        }
                    }



                } else {

                    let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeedTurkey", in: managedContext)

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
                    person.setValue(lngId, forKey: "lngId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciCoccidiosControl.append(person)
                }




            } catch {

            }

        } else {

            let entity         = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeedTurkey", in: managedContext)

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
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciCoccidiosControl.append(person)
        }

    }




    /********************** Get data from server forCocoidisControll **********************/


    func getDataFromCocoiiControllTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {


        let entity = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeedTurkey", in: managedContext)
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
    func getDataFromCocoiiControllForSingleDataTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingIdCocoii: NSNumber) {
        let entity = NSEntityDescription.entity(forEntityName: "CoccidiosisControlFeedTurkey", in: managedContext)
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

    func fetchAllCocciControlTurkey(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
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

    func fetchAllCocciControlAllDataTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
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

    func fetchAllCocciControlviaPostingidTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
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

    func fetchAllCocciControlviaIsyncTurkey(_ isSync: NSNumber, postinID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
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

    func updateisSyncOnAllCocciControlviaFeedProgramTurkey(_ postingId: NSNumber, feedId: NSNumber, feedProgram: String) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND feedId == %@", postingId, feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CoccidiosisControlFeedTurkey = (fetchedResult![i] as? CoccidiosisControlFeedTurkey)!
                    objTable.setValue(feedProgram, forKey: "feedProgram")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }


            }


        } catch {


        }

    }


    func updateisSyncOnAllCocciControlviaPostingidTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisControlFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CoccidiosisControlFeedTurkey = (fetchedResult![i] as? CoccidiosisControlFeedTurkey)!
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

    func updateisSyncOnAntiboticViaPostingIdTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: AntiboticFeedTurkey = (fetchedResult![i] as? AntiboticFeedTurkey)!
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


    func updateisSyncOnAntiboticViaFeedProgramTurkey(postingId: NSNumber, feedId: NSNumber, feedProgram: String) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND feedId = %@", postingId, feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: AntiboticFeedTurkey = (fetchedResult![i] as? AntiboticFeedTurkey)!
                    objTable.setValue(feedProgram, forKey: "feedProgram")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }


    }


    func fetchAntiboticViaIsSyncTurkey(_ isSync: Bool, postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", NSNumber(booleanLiteral: isSync), postingID)
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

    func fetchAntiboticViaPostingIdTurkey(_ postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")
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

    func updateisSyncOnAlternativeFeedPostingidTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {

            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: AlternativeFeedTurkey = (fetchedResult![i] as? AlternativeFeedTurkey)!
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


    func updateisSyncOnAlterNativeViaFeedProgramTurkey(postingId: NSNumber, feedId: NSNumber, feedProgram: String) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND feedId = %@", postingId, feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: AlternativeFeedTurkey = (fetchedResult![i] as? AlternativeFeedTurkey)!
                    objTable.setValue(feedProgram, forKey: "feedProgram")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }


    }

    func fetchAlternativeFeedWithIsSyncTurkey(_ isSync: Bool, postingID: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", NSNumber(booleanLiteral: isSync), postingID)

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


    func fetchAlternativeFeedPostingidTurkey(_ postingId: NSNumber) -> NSArray {     let appDelegate    = UIApplication.shared.delegate as! AppDelegate



        let managedContext = appDelegate.managedObjectContext



        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")



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

    func updateisSyncOnMyBindersViaPostingIdTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: MyCotoxinBindersFeedTurkey = (fetchedResult![i] as? MyCotoxinBindersFeedTurkey)!

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

    func updateisSyncOnMyCotxinViaFeedProgramTurkey(postingId: NSNumber, feedId: NSNumber, feedProgram: String) {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND feedId = %@", postingId, feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: MyCotoxinBindersFeedTurkey = (fetchedResult![i] as? MyCotoxinBindersFeedTurkey)!
                    objTable.setValue(feedProgram, forKey: "feedProgram")
                    do {
                        try managedContext.save()
                    } catch {
                    }
                }

            }

        } catch {

        }


    }

    func fetchMyBindersViaPostingIdTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")
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


    func fetchMyBindersViaIsSyncTurkey(_ isSync: Bool, postingID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")

        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == %@", NSNumber(booleanLiteral: isSync), postingID)



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
    func saveAntiboticDatabaseTurkey(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber, lngId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        AntiboticArray = dbArray

        if  AntiboticArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {



                    if ((fetchedResult?.count)! <= index) {


                        let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeedTurkey", in: managedContext)

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
                        person.setValue(lngId, forKey: "lngId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciAntibotic.append(person)


                    } else {
                        let objTable: AntiboticFeedTurkey = (fetchedResult![index] as? AntiboticFeedTurkey)!

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
                        objTable.setValue(lngId, forKey: "lngId")
                        do {
                            try managedContext.save()
                        } catch {
                        }


                    }
                } else {

                    let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeedTurkey", in: managedContext)

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
                    person.setValue(lngId, forKey: "lngId")

                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciAntibotic.append(person)

                }

            } catch {

            }


        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "AntiboticFeedTurkey", in: managedContext)

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
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciAntibotic.append(person)
        }
    }

    /********************************* Get Api from server for antoboitic *************************************/


    func getDataFromAntiboiticTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {


        let entity = NSEntityDescription.entity(forEntityName: "AntiboticFeedTurkey", in: managedContext)
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

    func getDataFromAntiboiticWithSigleDataTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingIdAlterNative: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "AntiboticFeedTurkey", in: managedContext)
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

    func fetchAntiboticTurkey(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")

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

    func fetchAntiboticPostingIdTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")

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

    func fetchAntiboticAlldataTurkey() -> NSArray {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AntiboticFeedTurkey")

        fetchRequest.returnsObjectsAsFaults = false

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

    func saveAlternativeDatabaseTurkey(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber, lngId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        AlternativeArray = dbArray

        if  AlternativeArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if ((fetchedResult?.count)! <= index) {

                        let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeedTurkey", in: managedContext)

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
                        person.setValue(lngId, forKey: "lngId")

                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciAlternative.append(person)
                    } else {



                        let objTable: AlternativeFeedTurkey = (fetchedResult![index] as? AlternativeFeedTurkey)!

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
                        objTable.setValue(lngId, forKey: "lngId")
                        do {
                            try managedContext.save()
                        } catch {
                        }


                    }
                } else {
                    let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeedTurkey", in: managedContext)

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
                    person.setValue(lngId, forKey: "lngId")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciAlternative.append(person)
                }



            } catch {

            }



        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "AlternativeFeedTurkey", in: managedContext)

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
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            cocciAlternative.append(person)
        }
    }
    func saveCocoiiVacTurkey(_ catId: Int, decscMolecule: String, lngId: Int) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "CocoiVaccineTurkey", in: managedContext)
        let person   = NSManagedObject(entity: entity!, insertInto: managedContext)

        //  cdcvdvdvdfbvfbfbfbn

        person.setValue(catId, forKey: "cocvaccId")
        person.setValue(decscMolecule, forKey: "cocoiiVacname")
        person.setValue(lngId, forKey: "lngId")


        do {
            try managedContext.save()
        } catch {
            //print("There is some error.")
        }

        cocoivacc.append(person)


    }
    func fetchCociVacTurkeyLngId(lngId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CocoiVaccineTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "lngId == %@", lngId)

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
    /******************** getApi  AlterNative data from server *****************/


    func getDataFromAlterNativeTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {


        let entity = NSEntityDescription.entity(forEntityName: "AlternativeFeedTurkey", in: managedContext)
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

    func getDataFromAlterNativeForSingleDevTokenTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingAlterNative: NSNumber) {


        let entity = NSEntityDescription.entity(forEntityName: "AlternativeFeedTurkey", in: managedContext)
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

    func fetchAlternativeTurkey(_ feedId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")

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


    func fetchAlternativePostingIdTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")

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


    func fetchAlternativeAlldataTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "AlternativeFeedTurkey")

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


    func saveMyCoxtinDatabaseTurkey(_ loginSessionId: NSNumber, postingId: NSNumber, molecule: String, dosage: String, fromDays: String, toDays: String, index: Int, dbArray: NSArray, feedId: NSNumber, feedProgram: String, formName: String, isSync: Bool, feedType: String, cocoVacId: NSNumber, lngId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        MyCoxtinBindersArray = dbArray

        if  MyCoxtinBindersArray.count > 0 {

            let appDelegate  = UIApplication.shared.delegate as! AppDelegate

            let managedContext = appDelegate.managedObjectContext

            let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")

            fetchRequest.returnsObjectsAsFaults = false
            fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

                if fetchedResult!.count > 0 {

                    if ((fetchedResult?.count)! <= index) {


                        let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeedTurkey", in: managedContext)
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
                        person.setValue(lngId, forKey: "lngId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                        cocciMyCoxtinBinders.append(person)
                    } else {
                        let objTable: MyCotoxinBindersFeedTurkey = (fetchedResult![index] as? MyCotoxinBindersFeedTurkey)!

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
                        objTable.setValue(lngId, forKey: "lngId")
                        do {
                            try managedContext.save()
                        } catch {
                        }

                    }
                } else {
                    let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeedTurkey", in: managedContext)
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
                    person.setValue(lngId, forKey: "lngId")
                    do {
                        try managedContext.save()
                    } catch {
                    }

                    cocciMyCoxtinBinders.append(person)

                }



            } catch {

            }


        } else {

            let entity  = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeedTurkey", in: managedContext)
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
            person.setValue(lngId, forKey: "lngId")
            do {
                try managedContext.save()
            } catch {
            }

            cocciMyCoxtinBinders.append(person)
        }
    }
    /************************** Ge api for MycocxoBinder *********************************/
    func getDataFromMyCocotinBinderTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String) {


        let entity = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeedTurkey", in: managedContext)
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

    func getDataFromMyCocotinBinderWithSingleDataTurkey(_ dict: NSDictionary, feedId: NSNumber, postingId: NSNumber, feedProgramName: String, postingidMycotxin: NSNumber) {


        let entity = NSEntityDescription.entity(forEntityName: "MyCotoxinBindersFeedTurkey", in: managedContext)
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

    func fetchMyBindersTurkey(_ feedId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")

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


    func fetchMyBindersAllDataTurkey() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "MyCotoxinBindersFeedTurkey")

        fetchRequest.returnsObjectsAsFaults = false


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


    func getFeedNameFromGetApiTurkey (_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "FeedProgramTurkey", in: managedContext)

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

    func getFeedNameFromGetApiSingleDeviceTokenTurkey (_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber, postingIdFeed: NSNumber) {

        let entity = NSEntityDescription.entity(forEntityName: "FeedProgramTurkey", in: managedContext)
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
    func SaveFeedProgramTurkey(_ postingId: NSNumber, sessionId: NSNumber, feedProgrameName: String, feedId: NSNumber, dbArray: NSArray, index: Int, formName: String, isSync: Bool, lngId: NSNumber) {

        feedprogramArray = dbArray

        if  feedprogramArray.count > 0 {

            let objTable: FeedProgramTurkey = (feedprogramArray[index] as? FeedProgramTurkey)!

            do {

                if objTable.feedId == feedId {

                    objTable.setValue(feedProgrameName, forKey: "feddProgramNam")
                    objTable.setValue(feedId, forKey: "feedId")
                    objTable.setValue(sessionId, forKey: "loginSessionId")
                    objTable.setValue(postingId, forKey: "postingId")
                    objTable.setValue(formName, forKey: "formName")
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(lngId, forKey: "lngId")

                    do {
                        try managedContext.save()
                    } catch {
                    }
                }
            }
            return
        } else {

            let entity = NSEntityDescription.entity(forEntityName: "FeedProgramTurkey", in: managedContext)

            let person = NSManagedObject(entity: entity!, insertInto: managedContext)

            person.setValue(feedProgrameName, forKey: "feddProgramNam")
            person.setValue(feedId, forKey: "feedId")
            person.setValue(sessionId, forKey: "loginSessionId")
            person.setValue(postingId, forKey: "postingId")
            person.setValue(formName, forKey: "formName")
            person.setValue(isSync, forKey: "isSync")
            person.setValue(lngId, forKey: "lngId")

            do {
                try managedContext.save()
            } catch {
            }

            FeddProgram.append(person)
        }

    }

    func updateFeedProgramTurkey(_ feedId: NSNumber, isSync: Bool, feedProgrameName: String, formName: String) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgramTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "feedId == %@", feedId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                let objTable: FeedProgramTurkey = (fetchedResult![0] as? FeedProgramTurkey)!

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


    func FetchFeedProgramTurkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgramTurkey")

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

    func FetchFeedProgramAllTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FeedProgramTurkey")

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

    func SaveNecropsystep1Turkey(_ postingId: NSNumber, age: String, farmName: String, feedProgram: String, flockId: String, houseNo: String, noOfBirds: String, sick: NSNumber, necId: NSNumber, compexName: String, complexDate: String, complexId: NSNumber, custmerId: NSNumber, feedId: NSNumber, isSync: Bool, timeStamp: String, actualTimeStamp: String, lngId: NSNumber, farmWeight: String, abf: String, breed: String, sex: String, farmId: NSNumber, imageId: NSNumber, count: NSNumber) {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CaptureNecropsyDataTurkey", in: managedContext)

        let contact = CaptureNecropsyDataTurkey(entity: entityDescription!, insertInto: managedContext)
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
        contact.lngId = lngId


        contact.farmWeight = farmWeight
        contact.abf = abf
        contact.breed = breed
        contact.sex = sex
        contact.farmId = farmId

        contact.imageId = imageId
        contact.farmcount = count




        do {
            try managedContext.save()

        } catch {

            fatalError("Failure to save context: \(error)")
        }

        necrpsystep1.append(contact)
    }


    func SaveNecropsystep1SingleDataTurkey(_ postingId: NSNumber, age: String, farmName: String, feedProgram: String, flockId: String, houseNo: String, noOfBirds: String, sick: NSNumber, necId: NSNumber, compexName: String, complexDate: String, complexId: NSNumber, custmerId: NSNumber, feedId: NSNumber, isSync: Bool, timeStamp: String, actualTimeStamp: String, necIdSingle: NSNumber, farmweight: String, abf: String, sex: String, breed: String, farmId: NSNumber, imgId: NSNumber) {

        let entityDescription =
            NSEntityDescription.entity(forEntityName: "CaptureNecropsyDataTurkey", in: managedContext)

        let contact = CaptureNecropsyDataTurkey(entity: entityDescription!, insertInto: managedContext)
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
        contact.sex = sex
        contact.abf = abf
        contact.breed = breed
        contact.farmWeight = farmweight
        contact.feedId = feedId
        contact.isChecked = false
        contact.isSync = isSync as NSNumber
        contact.timeStamp = timeStamp
        contact.actualTimeStamp = actualTimeStamp
        contact.farmId = farmId
        contact.imageId = imgId






        do {
            try managedContext.save()

        } catch {

            fatalError("Failure to save context: \(error)")
        }

        necrpsystep1.append(contact)
    }





    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func FetchNecropsystep1Turkey(_ postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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



    func FetchNecropsystep1AllWithNecIdTurkey(_ necId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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



    func FetchNecropsystep1AllTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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


    func FetchNecropsystep1WithisSyncandPostingIdTurkey(_ isSync: Bool, postingId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND necropsyId == %@", NSNumber(booleanLiteral: isSync), postingId)

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

    func FetchNecropsystep1WithisSyncTurkey(_ isSync: Bool) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
          //fetchRequest.predicate = NSPredicate(format: "isSync == %@", NSNumber(booleanLiteral: isSync))
        fetchRequest.predicate = NSPredicate(format: "isSync == %@ AND postingId == 0", NSNumber(booleanLiteral: isSync))

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

    func FetchNecropsystep1NecIdTurkey(_ necropsyId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necropsyId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult {

                necropsyStep1Array = results as NSArray
                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
                let sortedResults = necropsyStep1Array.sortedArray(using: [descriptor])
                necropsyStep1Array = sortedResults as NSArray

            } else {


            }
        } catch {
        }

        return necropsyStep1Array

    }
    /************** Fetch Farm Name *****************************/
    func FetchNecropsystep1NecIdTurkeyWithFarmName(_ farmName: String, necropsyId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false

        fetchRequest.predicate = NSPredicate(format: "farmName == %@ AND necropsyId == %@", farmName, necropsyId)

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
    func FetchNecropsystep1UpdateFromUnlinkedTurkey(_ postingId: NSNumber) -> NSMutableArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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
    func FetchNecropsystep1neccIdTurkey(_ necId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult {


                necropsyStep1Array = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "farmId", ascending: true)
                let sortedResults = necropsyStep1Array.sortedArray(using: [descriptor])
                necropsyStep1Array = sortedResults as NSArray

            } else {


            }
        } catch {
        }

        return necropsyStep1Array

    }

    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func fetchNecropsystep1neccIdFeedProgramTurkey(_ necId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND feedProgram == %@ ", necId, "")

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




    func FetchNecropsystep1neccIdAllTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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


    func FetchNecropsystep1neccIdWithCheckFarmTurkey(_ necId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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


    func FetchFarmNameOnNecropsystep1neccIdTurkey(_ necId: NSNumber, feedProgramName: String, feedId: NSNumber) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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



    func updateisSyncNecropsystep1neccIdTurkey(_ postingId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!

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


    func updateisSyncNecropsystep1WithneccIdTurkey(_ necId: NSNumber, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!

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

    func updatComplexIdandComplexIDInNecropsystep1neccIdTurkey(_ necId: NSNumber, complexName: String, complexId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyDataTurkey = (fetchedResult![0] as? CaptureNecropsyDataTurkey)!

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

    func FetchNecropsystep1neccIdTrueValTurkey(_ necId: NSNumber, formTrueValue: Bool, feedProgram: String, feedId: NSNumber ) -> NSArray {


        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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



    func updatePostingIdWithNecIdNecropsystep1Turkey(_ necId: NSNumber, postingId: NSNumber ) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!

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

    func updatePostingIdWithNecIdNecropsystep1WithZeroTurkey(_ necId: NSNumber, postingId: NSNumber ) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!

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

    func updateFeedProgramNameoNNecropsystep1neccIdTurkey(_ necId: NSNumber, feedProgramName: String, formName: String, isCheckForm: Bool, feedId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necId, formName, feedProgramName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: CaptureNecropsyDataTurkey = (fetchedResult![0] as? CaptureNecropsyDataTurkey)!

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

    func updateFeedProgramNameoNNecropsystep1neccIdFeddprogramBlankTurkey(_ necId: NSNumber, formName: String, feedId: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necId, formName )

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: CaptureNecropsyDataTurkey = (fetchedResult![0] as? CaptureNecropsyDataTurkey)!

                objTable.setValue("", forKey: "feedProgram")
                objTable.setValue(1200, forKey: "feedId")

                do {
                    try managedContext.save()
                } catch {
                }

            }


        } catch {

        }


    }


    /************************ Fetch Data Of Necropsy data 1 *******************************/
    func FetchNecropsystep1AllNecIdTurkey() -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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

    func FetchNecropsystep1AllNecIdTurkeyWithId(sessiondate: String, newString: String) -> NSArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
    fetchRequest.predicate = NSPredicate(format: "complexDate == %@ AND complexName == %@", sessiondate, newString)

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

    func FetchNecropsystep1AllNecIdWithPostingIDZeroTurkey() -> NSMutableArray {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == 0")

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult {

                for i in 0..<results.count {
                    let c = results[i] as! CaptureNecropsyDataTurkey

                    let nId = c.necropsyId as!  Int

                    necropsyNIdArray.add(c)

                    for j in 0..<necropsyNIdArray.count - 1 {
                        let d = necropsyNIdArray.object(at: j)  as! CaptureNecropsyDataTurkey
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



    func updateBirdNumberInNecropsystep1Turkey(_ postingId: NSNumber, index: Int) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyDataTurkey = (fetchedResult![index] as? CaptureNecropsyDataTurkey)!

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

    func updateBirdNumberInNecropsystep1withNecIdTurkey(_ necId: NSNumber, index: Int, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyDataTurkey = (fetchedResult![index] as? CaptureNecropsyDataTurkey)!

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


    func reduceBirdNumberInNecropsystep1Turkey(_ postingId: NSNumber, index: Int) -> Bool {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            var isBirdAvailable: Bool = true
            let objTable: CaptureNecropsyDataTurkey = (fetchedResult![index] as? CaptureNecropsyDataTurkey)!


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

    func reduceBirdNumberInNecropsystep1WithNecIdTurkey(_ necId: NSNumber, index: Int) -> Bool {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            var isBirdAvailable: Bool = true
            let objTable: CaptureNecropsyDataTurkey = (fetchedResult![index] as? CaptureNecropsyDataTurkey)!


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

    func fecthFrmWithBirdAndObservationTurkey(_ birdnumber: NSNumber, farmname: String, obsId: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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


    func fecthFrmWithBirdAndObservationAllTurkey() -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

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
    func fecthFrmWithCatnameWithBirdAndObservationTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")


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

    func fecthFrmWithCatnameWithBirdAndObservationTurkeyBodyWeight(farmname: String, catName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")


        fetchRequest.predicate = NSPredicate(format: "catName == %@ AND formName == %@ AND necropsyId == %@", catName, farmname, necId)

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


    func fecthFrmWithCatnameTurkey(_ farmname: String, catName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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

    func updateQuickLinkOnCaptureNecTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, necId: NSNumber, quickLink: NSNumber) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID ==%@ AND necropsyId == %@", birdnumber, catName, farmname, Obsid, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![i] as? CaptureNecropsyViewDataTurkey)!

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


    func fecthFrmWithCatnameWithBirdAndObservationIDTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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

    func fecthobsDataWithCatnameAndFarmNameAndBirdNumberTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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

    func fetchObsWithBirdandFarmNameTurkey(_ formName: String, birdNo: NSNumber, necId: NSNumber) -> NSMutableDictionary {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchPredicate = NSPredicate(format: "birdNo == %@  AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        let fetchRequest                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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
                    let captureNecropsyViewData = c.object(at: i) as! CaptureNecropsyViewDataTurkey

                    print(captureNecropsyViewData.obsName ?? "")
                    var trimmedString =
                        captureNecropsyViewData.obsName!.replacingOccurrences(of: "/", with: "")
                    trimmedString =
                        captureNecropsyViewData.obsName!.replacingOccurrences(of: " ", with: "")


                    if trimmedString == "BursaLesions"{
                        trimmedString = "BursaLesionScore"
                    } else if  trimmedString == "MuscularHemorrhages"{
                        trimmedString = "MuscularHemorrhagies"
                    } else if  trimmedString == "RoundHeart"{
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

                    ///

                    else if  trimmedString == "Ceca"{
                        trimmedString = "FoamyCeca"
                    } else if  trimmedString == "Content"{
                        trimmedString = "MucousContent"
                    }
                    //
                    else if  trimmedString == "Bacteria,Motile"{
                        trimmedString = "BacteriaMotile"
                    } else if  trimmedString == "Bacteria,Nonmotile"{
                        trimmedString = "BacteriaNonmotile"
                    } else if  trimmedString == "Cochlosoma"{
                        trimmedString = "ProtozoaCochlosoma"
                    } else if  trimmedString == "Trichomonas"{
                        trimmedString = "ProtozoaTrichomonas"
                    } else if  trimmedString == "Hexamita"{
                        trimmedString = "ProtozoaHexamita"
                    } else if  trimmedString == "Protozoa,Undefined"{
                        trimmedString = "ProtozoaUndefined"
                    }

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

    func deleteCaptureNecropsyViewDataWithObsIDTurkey (_ obsId: NSNumber, necId: NSNumber) {

        //        let appDel  = UIApplication.shared.delegate as! AppDelegate

        let fetchPredicate = NSPredicate(format: "obsID == %@ AND necropsyId == %@", obsId, necId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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

    func deleteCaptureNecropsyViewDataWithFarmnameandBirdsizeTurkey (_ obsId: NSNumber, formName: String, catName: String, birdNo: NSNumber, necId: NSNumber) {



        let fetchPredicate = NSPredicate(format: "birdNo == %@  AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)

        let fetchUsers    = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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

    func saveCaptureSkeletaInDatabaseOnSwithCaseTurkey(catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, obsPoint: NSInteger, index: Int, obsId: NSInteger, measure: String, quickLink: NSNumber, necId: NSNumber, isSync: Bool, lngId: NSNumber, refId: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let entity   = NSEntityDescription.entity(forEntityName: "CaptureNecropsyViewDataTurkey", in: managedContext)

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
        person.setValue(lngId, forKey: "lngId")
        person.setValue(refId, forKey: "refId")

        do {
            try managedContext.save()
        } catch {
        }

        captureSkeletaObject.append(person)


    }

    func saveCaptureSkeletaInDatabaseOnSwithCaseSingleDataTurkey(catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, obsPoint: NSInteger, index: Int, obsId: NSInteger, measure: String, quickLink: NSNumber, necId: NSNumber, isSync: Bool, necIdSingle: NSNumber, lngId: NSNumber, refId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "CaptureNecropsyViewDataTurkey", in: managedContext)


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
        person.setValue(lngId, forKey: "lngId")
        person.setValue(refId, forKey: "refId")

        do {
            try managedContext.save()
        } catch {
        }

        captureSkeletaObject.append(person)


    }

    func deleteDataWithStep2dataTurkey (_ necId: NSNumber) {

        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers            = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchUsers.predicate   = fetchPredicate

        do {
            let results = try managedContext.fetch(fetchUsers)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }

        } catch {
        }

    }



    func updateCaptureSkeletaInDatabaseOnActualClickTurkey(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, actualName: String, index: Int, necId: NSNumber, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdNo, catName, formName, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![index] as? CaptureNecropsyViewDataTurkey)!


            objTable.setValue(actualName, forKey: "actualText")
            objTable.setValue(isSync, forKey: "isSync")


            do {
                try objTable.managedObjectContext!.save()
            } catch {
            }


        } catch {
        }



    }
    /********* Update BodyWeight in immune ************/

    func updateCaptureSkeletaInDatabaseOnActualClickTurkeyBodyWeight(_ catName: String, obsName: String, formName: String, obsPoint: Int, index: Int, necId: NSNumber, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "catName == %@ AND formName == %@ AND necropsyId == %@ AND obsName == %@", catName, formName, necId, obsName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            //let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![index] as? CaptureNecropsyViewDataTurkey)!

        for i in 0..<fetchedResult!.count {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![i] as? CaptureNecropsyViewDataTurkey)!
                objTable.setValue(obsPoint, forKey: "obsPoint")
                objTable.setValue(isSync, forKey: "isSync")


                do {
                    try objTable.managedObjectContext!.save()
                } catch {
                }
            }


        } catch {
        }



    }


    func updateisSyncOnCaptureSkeletaInDatabaseTurkey(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![i] as? CaptureNecropsyViewDataTurkey)!
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

    func updateisSyncOnCaptureInDatabaseTurkey(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!
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

    func updateCaptureSkeletaInDatabaseOnStepperTurkey(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, index: Int, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, catName, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!


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


    func updateObsDataInCaptureSkeletaInDatabaseOnActualTurkey(_ obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, actualName: String, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!


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

    func updateCaptureSkeletaInDatabaseOnSwitchMethodTurkey(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, switchValue: Bool, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, catName, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!


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




    func updateCaptureSkeletaInDatabaseOnSwithCaseTurkey(_ catName: String, obsName: String, formName: String, obsVisibility: Bool, birdNo: NSNumber, camraImage: UIImage, obsPoint: NSInteger, index: Int, obsId: NSInteger, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext


        let imageData = NSData(data: camraImage.jpegData(compressionQuality: 1.0)!) as Data

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND catName == %@ AND formName == %@ AND necropsyId == %@", birdNo, catName, formName, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {

                //print("fetch the HatcheryVacination results \(results)")
                fecthPhotoArray = results as NSArray

                let descriptor: NSSortDescriptor = NSSortDescriptor(key: "obsName", ascending: true)
                let sortedResults = fecthPhotoArray.sortedArray(using: [descriptor])

                let objTable: CaptureNecropsyViewDataTurkey = ((sortedResults as NSArray)[index] as? CaptureNecropsyViewDataTurkey)!

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

    func deleteCaptureNecropsyViewDataTurkey () {


        let fetchUsers = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")


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

    func getSaveImageFromServerTurkey(_ dict: NSDictionary) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext


        let encodedImageData = String(describing: dict.value(forKey: "image")!)
        let imageData = Data(base64Encoded: encodedImageData, options: NSData.Base64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        //let ImageData1 =
        let imageData1 = NSData(data: image!.jpegData(compressionQuality: 1.0)!) as Data
        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCaptureTurkey", in: managedContext)
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

    func getSaveImageFromServerSingledataTurkey(_ dict: NSDictionary, necIdSingle: NSNumber) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext


        let encodedImageData = String(describing: dict.value(forKey: "image")!)
        let imageData = Data(base64Encoded: encodedImageData, options: NSData.Base64DecodingOptions(rawValue: 0))
        let image = UIImage(data: imageData!)
        //let ImageData1 =
        let imageData1 = NSData(data: image!.jpegData(compressionQuality: 1.0)!) as Data
        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCaptureTurkey", in: managedContext)
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

    func deleteImageForSingleTurkey(_ necId: NSNumber) {


        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
        fetchUsers.predicate  = fetchPredicate
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


    func saveCaptureSkeletaImageInDatabaseTurkey(_ catName: String, obsName: String, formName: String, birdNo: NSNumber, camraImage: UIImage, obsId: NSInteger, necropsyId: NSNumber, isSync: Bool ) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext


        let imageData = NSData(data: camraImage.jpegData(compressionQuality: 1.0)!) as Data

        let entity   = NSEntityDescription.entity(forEntityName: "BirdPhotoCaptureTurkey", in: managedContext)

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
    func updateisSyncOnBirdPhotoCaptureDatabaseTurkey(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: BirdPhotoCaptureTurkey = (fetchedResult![i] as? BirdPhotoCaptureTurkey)!
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
    func fecthPhotoWithFormNameTurkey(_ farmname: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
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


    func fecthPhotoWithiSynsTrueTurkey(_ isSync: Bool) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
        fetchRequest.predicate = NSPredicate(format: "isSync == %@", NSNumber(booleanLiteral: isSync))
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


    func fecthPhotoWithCatnameWithBirdAndObservationIDTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, obsName: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
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

    func fecthPhotoWithCatnameWithBirdAndObservationIDandIsyncTurkey(_ birdnumber: NSNumber, farmname: String, catName: String, Obsid: NSNumber, isSync: Bool, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNum == %@ AND catName == %@ AND farmName == %@ AND obsId ==%@ AND isSync ==%@  AND necropsyId ==%@", birdnumber, catName, farmname, Obsid, NSNumber(booleanLiteral: isSync), necId)
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

    func saveNoofBirdWithNotesTurkey(_ catName: String, notes: String, formName: String, birdNo: NSNumber, index: Int, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "NotesBirdTurkey", in: managedContext)
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


    func saveNoofBirdWithNotesSingledataTurkey(_ catName: String, notes: String, formName: String, birdNo: NSNumber, index: Int, necId: NSNumber, isSync: Bool, necIdSingle: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity   = NSEntityDescription.entity(forEntityName: "NotesBirdTurkey", in: managedContext)
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

    func deleteDataBirdNotesWithIdTurkey (_ necId: NSNumber) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@", necId)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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

    func updateisSyncOnNotesBirdDatabaseTurkey(_ necId: NSNumber, isSync: Bool, _ completion: (_ status: Bool) -> Void) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@", necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: NotesBirdTurkey = (fetchedResult![i] as? NotesBirdTurkey)!
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
    func updateNoofBirdWithNotesTurkey(_ catName: String, formName: String, birdNo: NSNumber, notes: String, necId: NSNumber, isSync: Bool) {
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
        fetchRequest.predicate = NSPredicate(format: "noofBirds == %@ AND formName == %@ AND necropsyId == %@", birdNo, formName, necId)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: NotesBirdTurkey = (fetchedResult![0] as? NotesBirdTurkey)!
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

    func stTurkey(_ catName: String, formName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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


    func fetchNoofBirdWithFormTurkey(_ catName: String, formName: String, necId: NSNumber ) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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

    func fetchNotesWithBirdNumandFarmNameTurkey(_ birdNo: NSNumber, formName: String, necId: NSNumber ) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")


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




    func fetchNoofBirdWithNotesTurkey(_ catName: String, formName: String, birdNo: NSNumber, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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



    func deleteNotesBirdWithFarmnameTurkey (_ formName: String, birdNo: NSNumber, necId: NSNumber) {


        let fetchPredicate = NSPredicate(format: "noofBirds == %@  AND formName == %@ AND necropsyId = %@", birdNo, formName, necId)

        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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

    func deleteNotesBirdTurkey () {
        let fetchUsers = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")

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


    func fetchCaptureWithFormNameNecSkeltonDataTurkey(farmName: String, necID: NSNumber) -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

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

    func updateCellIndexTurkey(_ formName: String, necID: NSNumber, cellIndex: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "formName == %@ AND necropsyId == %@", formName, necID)
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {

                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!
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





    func AllCappNecdataTurkey() -> NSArray {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

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




    func updateObsDataInCaptureSkeletaInDatabaseOnStepperTurkey(_ obsName: String, formName: String, birdNo: NSNumber, obsId: NSNumber, index: Int, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!


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


    func updateSwitchDataInCaptureSkeletaInDatabaseOnSwitchTurkey(_ formName: String, birdNo: NSNumber, obsId: NSNumber, obsVisibility: Bool, necId: NSNumber) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext



        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "birdNo == %@ AND formName == %@ AND obsID == %@ AND necropsyId == %@", birdNo, formName, obsId, necId)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![0] as? CaptureNecropsyViewDataTurkey)!


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

    func fetchLastSessionDetailsTurkey(_ postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

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

    func fetch_GI_Tract_AllDataTurkey(_ farmName: NSString, postingId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

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

    func FarmsDataDatabaseTurkey(_ stateName: String, stateId: NSNumber, farmName: String, farmId: NSNumber, countryName: String, countryId: NSNumber, city: String) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "FarmsListTurkey", in: managedContext)
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

    func fetchFarmsDataDatabaseTurkey() -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FarmsListTurkey")
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

    func fetchFarmsDataDatabaseUsingCompexIdTurkey(complexId: NSNumber) -> NSArray {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "FarmsListTurkey")
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


    func removeDuplicatesTurkey(_ array: NSMutableArray) -> NSMutableArray {
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
    func checkPostingSessionHasiSyncTrueTurkey(_ postingID: NSNumber, isSync: NSNumber) -> Bool {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")
        fetchRequest.predicate = NSPredicate(format: "postingId == %@ AND isSync == %@", postingID, NSNumber(booleanLiteral: isSync as! Bool))
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                if results.count>0 {
                    return true
                }

            }
        } catch {
            //print("There is some error.")
        }

        return false
    }
    func checkNecropcySessionHasiSyncTrueTurkey(_ postingID: NSNumber, isSync: NSNumber) -> Bool {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND isSync == %@", postingID, NSNumber(booleanLiteral: isSync as! Bool))
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResult {
                if results.count>0 {
                    return true
                }
            }
        } catch {
            //print("There is some error.")
        }

        return false
    }
    /************** Update FarmName ********************/
    func updateNecropsystep1WithNecIdAndFarmNameTurkey(_ necropsyId: NSNumber, farmName: NSString, newFarmName: NSString, age: String, isSync: Bool, farmWeight: String) {

        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", necropsyId, farmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]

            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyDataTurkey = (fetchedResult![i] as? CaptureNecropsyDataTurkey)!
                    objTable.setValue(newFarmName, forKey: "farmName")
                    objTable.setValue(isSync, forKey: "isSync")
                    objTable.setValue(age, forKey: "age")
                    objTable.setValue(farmWeight, forKey: "farmWeight")

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
    func updateNewFarmAndAgeOnCaptureNecropsyViewDataTurkey(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND formName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: CaptureNecropsyViewDataTurkey = (fetchedResult![i] as? CaptureNecropsyViewDataTurkey)!
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

func updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdPhotoTurkey(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate    = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: BirdPhotoCaptureTurkey = (fetchedResult![i] as? BirdPhotoCaptureTurkey)!
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

    func updateNewFarmAndAgeOnCaptureNecropsyViewDataBirdNotesTurkey(_ necId: NSNumber, oldFarmName: String, newFarmName: String, isSync: Bool) {

        let appDelegate  = UIApplication.shared.delegate as? AppDelegate

        let managedContext = appDelegate!.managedObjectContext

        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
        fetchRequest.predicate = NSPredicate(format: "necropsyId == %@ AND formName == %@ ", necId, oldFarmName)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchedResult!.count > 0 {
                for i in 0..<fetchedResult!.count {
                    let objTable: NotesBirdTurkey = (fetchedResult![i] as? NotesBirdTurkey)!
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

    // MARK: - Methods To get observation names

    func getObservationNameForGITractTurkey(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "GITractTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


                if let results = fetchedResult {
                    if results.count > 0 {

                        let ob: GITractTurkey = results.last as! GITractTurkey
                        nameArray.append(ob.observationField!)
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func getObservationNameForSkelatalTurkey(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "SkeletaTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


                if let results = fetchedResult {
                    if results.count > 0 {

                        let ob: SkeletaTurkey = results.last as! SkeletaTurkey
                        nameArray.append(ob.observationField!)
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func getObservationNameForImmuneTurkey(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "ImmuneTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                if let results = fetchedResult {
                    if results.count > 0 {
                        let ob: ImmuneTurkey = results.last as! ImmuneTurkey
                        nameArray.append(ob.observationField!)
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func getObservationNameForMicroscopy(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                if let results = fetchedResult {
                    if results.count > 0 {
                        let ob: CoccidiosisTurkey = results.last as! CoccidiosisTurkey
                        nameArray.append(ob.observationField!)
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func getObservationNameForRespiratoryTurkey(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "RespiratoryTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


                if let results = fetchedResult {
                    if results.count > 0 {

                        let ob: RespiratoryTurkey = results.last as! RespiratoryTurkey
                        nameArray.append(ob.observationField!)
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func getObservationNameForCoccidiosisTurkey(refID: [Any]) -> [Any] {
        var nameArray = [Any]()
        let appDelegate    = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let fetchRequest  = NSFetchRequest<NSFetchRequestResult>(entityName: "CoccidiosisTurkey")
        let languageID = UserDefaults.standard.integer(forKey: "lngId") as NSNumber

        for item in refID {
            fetchRequest.predicate = NSPredicate(format: "refId == %@ AND lngId == %@", item as! NSNumber, languageID)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


                if let results = fetchedResult {
                    if results.count > 0 {

                        let ob: CoccidiosisTurkey = results.last as! CoccidiosisTurkey
                        if ob.visibilityCheck == true {
                            nameArray.append(ob.observationField!)}
                    }
                }
            } catch {
            }
        }
        return nameArray
    }
    func fetchAllPostingExistingSessionWithId(sessionDate: String, newString: String) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

        fetchRequest.predicate = NSPredicate(format: "sessiondate == %@ AND complexName == %@", sessionDate, newString)

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
    func deleteDataWithPostingIdStep1dataWithfarmNameTurkey (_ postingId: NSNumber, farmName: String) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", postingId, farmName)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyDataTurkey")
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
    func deleteDataWithPostingIdStep2dataCaptureNecViewWithfarmNameTurkey (_ postingId: NSNumber, farmName: String) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@ AND formName == %@", postingId, farmName)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")
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
    func deleteDataWithPostingIdStep2NotesBirdWithFarmNameTurkey (_ postingId: NSNumber, farmName: String) {
        //        let appDel  = UIApplication.shared.delegate as! AppDelegate
        //let context = appDel.managedObjectContext
        let fetchPredicate = NSPredicate(format: "necropsyId == %@ AND formName == %@", postingId, farmName)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "NotesBirdTurkey")
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
    func deleteDataWithPostingIdStep2CameraIamgeWithFarmNameTurkey (_ postingId: NSNumber, farmName: String) {

        let fetchPredicate = NSPredicate(format: "necropsyId == %@ AND farmName == %@", postingId, farmName)
        let fetchUsers                      = NSFetchRequest<NSFetchRequestResult>(entityName: "BirdPhotoCaptureTurkey")
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
    func fecthFrmWithCatnameWithBirdAndObservationWithDeleteTurkey(farmname: String, necId: NSNumber) -> NSArray {
        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "CaptureNecropsyViewDataTurkey")

        // fetchRequest.predicate = NSPredicate(format: "birdNo == %@  AND formName == %@ AND necropsyId == %@", birdnumber,farmname,necId)

        fetchRequest.predicate = NSPredicate(format: "refId != 58 AND necropsyId == %@ AND formName == %@", necId, farmname)

        //fetchRequest.predicate = NSPredicate(format: "formName == %@ AND necropsyId == %@ AND refId != 58", farmname,necId)


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

    func fetchCompletePostingSessionTurkey(_ postingid: NSNumber) -> PostingSessionTurkey {

        let appDelegate    = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext

        let fetchRequest   = NSFetchRequest<NSFetchRequestResult>(entityName: "PostingSessionTurkey")

        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = NSPredicate(format: "postingId == %@", postingid)

        do {
            let fetchedResult = try managedContext.fetch(fetchRequest) as? [NSManagedObject]


            if let results = fetchedResult?[0] {
                return results as! PostingSessionTurkey

            } else {


            }


        } catch {
        }
        return PostingSessionTurkey()
    }
}
