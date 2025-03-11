//
//  SingleSyncDataTurkey.swift
//  Zoetis -Feathers
//
//  Created by Manish Behl on 23/05/18.
//  Copyright © 2018 . All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import Reachability
import SystemConfiguration
import CoreData


// MARK: - PROTOCOLS
protocol SyncApiDataTurkey{
    func failWithErrorSyncdata(statusCode:Int)
    func failWithErrorInternalSyncdata()
    func didFinishApiSyncdata()
    func failWithInternetConnectionSyncdata()
}

class SingleSyncDataTurkey: NSObject {
    
    // MARK: - VARIABLES
    var reachability: Reachability!
    var delegeteSyncApiData : SyncApiDataTurkey!
    var postingIdArr = NSMutableArray()
    var postingArrWithAllData = NSMutableArray()
    var strdateTimeStamp = String()
    var accestoken = String()
    var networkStatus : Reachability.Connection!
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return Session(configuration: configuration)
    }()
    
    // MARK: - METHODS AND FUNCTIONS
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ApiSyncTurkey.networkStatusChanged(_:)),
                                               name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification),
                                               object: nil)
        Reach().monitorReachabilityChanges()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(ReachabilityStatusChangedNotification)
    }
    
    func networkStatusChanged(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value  = userInfo.values.first {
                switch value as! String {
                case "Online (WiFi)":
                    print(value)
                case "Online (WWAN)":
                    print(value)
                    
                default: break
                }
            }
        }
    }
    // MARK: - Get All Session's Array
    func allSessionArr(postinId:NSNumber) ->NSMutableArray{
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postinId).mutableCopy() as! NSMutableArray
        let cNecArr =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postinId)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId
                {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        
        let allPostingSessionArr = NSMutableArray()
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            allPostingSessionArr.add(sessionId)
        }
        
        for i in 0..<necArrWithoutPosting.count {
            let nIdSession = necArrWithoutPosting.object(at: i) as! CaptureNecropsyDataTurkey
            sessionId = nIdSession.necropsyId!
            allPostingSessionArr.add(sessionId)
        }
        return allPostingSessionArr
    }
    
    // MARK: - Resize the Image
    func resizeImage(_ image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // MARK: - Convert image to Base 64
    func imageToNSString(_ image: UIImage) -> String {
        let data = image.pngData()
        return data!.base64EncodedString(options: .lineLength64Characters)
    }
    /********************* Save Feed Program data On Server *****************************************************************************************************/
    // MARK: - Get Feed Program with Posting ID
    func feedprogram(postingId:NSNumber)  {
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId).mutableCopy() as! NSMutableArray
        let cNecArr =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
        let necArrWithoutPosting = NSMutableArray()
        var timestamp = String()
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData =  cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c =  necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId
                {
                    necArrWithoutPosting.remove(c)
                }
            }
        }
        self.postingIdArr.removeAllObjects()
        let tempArrTime = NSMutableArray()
        let actualTmestamp = NSMutableArray()
        var sessionId = NSNumber()
        for i in 0..<postingArrWithAllData.count
        {
            let pSession =  postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            timestamp = pSession.timeStamp!
            var actualTimestampStr =  pSession.actualTimeStamp
            if actualTimestampStr == nil {
                actualTimestampStr = ""
            }
            self.postingIdArr.add(sessionId)
            tempArrTime.add(timestamp)
            actualTmestamp.add(actualTimestampStr!)
        }
        
        let sessionArray = NSMutableArray()
        var sessionDict = NSMutableDictionary()
        var sessionDictMain = NSMutableDictionary()
        
        for i in 0..<self.postingIdArr.count {
            
            let mainDict = NSMutableDictionary()
            var FinalArray1 = NSMutableArray()
            let allCocciControl =  CoreDataHandlerTurkey().fetchAllCocciControlviaPostingidTurkey(self.postingIdArr[i] as! NSNumber)
            var dataSet = Int()
            var  index = Int()
            let mainFeeds = NSMutableArray()
            var feeds = NSMutableDictionary()
            for i in 0..<allCocciControl.count {
                dataSet+=1
                
                let mainDict = NSMutableDictionary()
                let cocciControl =  allCocciControl.object(at: i) as! CoccidiosisControlFeedTurkey
                let coccidiosisVaccine = cocciControl.coccidiosisVaccine
                let dosage = cocciControl.dosage
                let fromDays = cocciControl.fromDays
                let molecule = cocciControl.molecule
                let toDays = cocciControl.toDays
                let moleculeId = cocciControl.dosemoleculeId
                let cocoId = cocciControl.coccidiosisVaccineId
                let feedType = cocciControl.feedType
                let startDate =  cocciControl.feedDate
                mainDict.setValue(startDate, forKey: "startDate")
                mainDict.setValue(coccidiosisVaccine, forKey: "coccidiosisVaccine")
                mainDict.setValue(dosage, forKey: "dose")
                mainDict.setValue(fromDays, forKey: "durationFrom")
                mainDict.setValue(molecule, forKey: "molecule")
                mainDict.setValue(toDays, forKey: "durationTo")
                mainDict.setValue(5, forKey: "feedProgramCategoryId")
                mainDict.setValue(moleculeId, forKey: "moleculeId")
                mainDict.setValue(cocoId, forKey: "cocciVaccineId")
                mainDict.setValue(feedType, forKey: "feedType")
                FinalArray1.add(mainDict)
                
                if dataSet == 7 {
                    dataSet = 0
                    
                    let feedId = cocciControl.feedId as! Int
                    let feedProgram = cocciControl.feedProgram
                    
                    feeds = ["feedName" : feedProgram!, "feedId" : feedId, "startDate" : startDate ?? "","feedProgramDetails" : FinalArray1]
                    FinalArray1 = NSMutableArray()
                    mainFeeds.add(feeds)
                    feeds = NSMutableDictionary()
                }
            }
            
            let fetchAntibotic = CoreDataHandlerTurkey().fetchAntiboticViaPostingIdTurkey(self.postingIdArr[i] as! NSNumber)
            
            
            for i in 0..<fetchAntibotic.count {
                
                dataSet+=1
                let mainDict = NSMutableDictionary()
                let antiboticFeed = fetchAntibotic.object(at: i) as! AntiboticFeedTurkey
                let dosage = antiboticFeed.dosage
                let feedId = antiboticFeed.feedId as! Int
                let feedProgram = antiboticFeed.feedProgram
                let fromDays = antiboticFeed.fromDays
                let molecule = antiboticFeed.molecule
                let toDays = antiboticFeed.toDays
                let feedType = antiboticFeed.feedType
                let startDate =  antiboticFeed.feedDate
                mainDict.setValue(dosage, forKey: "dose")
                mainDict.setValue(feedId, forKey: "feedId")
                mainDict.setValue(feedProgram, forKey: "feedName")
                mainDict.setValue(fromDays, forKey: "durationFrom")
                mainDict.setValue(molecule, forKey: "molecule")
                mainDict.setValue(toDays, forKey: "durationTo")
                mainDict.setValue(12, forKey: "feedProgramCategoryId")
                mainDict.setValue(0, forKey: "moleculeId")
                mainDict.setValue(feedType, forKey: "feedType")
                FinalArray1.add(mainDict)
                
                if dataSet == 6 {
                    dataSet = 0
                    
                    let tempArray = (mainFeeds.object(at: index) as AnyObject).value(forKey: "feedProgramDetails") as! NSMutableArray
                    if (tempArray.count > 0) {
                        tempArray.addObjects(from: FinalArray1 as [AnyObject])
                        feeds = ["feedName" : feedProgram!, "feedId" : feedId, "startDate" : startDate ?? "","feedProgramDetails" : tempArray]
                    }
                    mainFeeds.replaceObject(at: index, with: feeds)
                    index+=1
                    FinalArray1 = NSMutableArray()
                    feeds = NSMutableDictionary()
                }
            }
            
            let fetchAlternative = CoreDataHandlerTurkey().fetchAlternativeFeedPostingidTurkey(self.postingIdArr[i] as! NSNumber)
            
            index = 0
            for i in 0..<fetchAlternative.count {
                
                dataSet+=1
                let mainDict = NSMutableDictionary()
                let antiboticFeed = fetchAlternative.object(at: i) as! AlternativeFeedTurkey
                let dosage = antiboticFeed.dosage
                let feedId = antiboticFeed.feedId as! Int
                let feedProgram = antiboticFeed.feedProgram
                let fromDays = antiboticFeed.fromDays
                let molecule = antiboticFeed.molecule
                let startDate = antiboticFeed.feedDate
                let toDays = antiboticFeed.toDays
                let feedType = antiboticFeed.feedType
                mainDict.setValue(dosage, forKey: "dose")
                mainDict.setValue(feedId, forKey: "feedId")
                mainDict.setValue(feedProgram, forKey: "feedName")
                mainDict.setValue(fromDays, forKey: "durationFrom")
                mainDict.setValue(molecule, forKey: "molecule")
                mainDict.setValue(toDays, forKey: "durationTo")
                mainDict.setValue(6, forKey: "feedProgramCategoryId")
                mainDict.setValue(0, forKey: "moleculeId")
                mainDict.setValue(feedType, forKey: "feedType")
                
                FinalArray1.add(mainDict)
                
                if dataSet == 6 {
                    dataSet = 0
                    
                    if mainFeeds.count>0 {
                        
                        let tempArray = (mainFeeds.object(at: index) as AnyObject).value(forKey: "feedProgramDetails") as! NSMutableArray
                        if tempArray.count > 0 {
                            tempArray.addObjects(from: FinalArray1 as [AnyObject])
                            feeds = ["feedName" : feedProgram!, "feedId" : feedId, "startDate" : startDate ?? "","feedProgramDetails" : tempArray]
                        }
                        mainFeeds.replaceObject(at: index, with: feeds)
                        index+=1
                        FinalArray1 = NSMutableArray()
                        feeds = NSMutableDictionary()
                    }
                }
            }
            
            let fetchMyBinde = CoreDataHandlerTurkey().fetchMyBindersViaPostingIdTurkey(self.postingIdArr[i] as! NSNumber)
            
            index = 0
            for i in 0..<fetchMyBinde.count {
                
                dataSet+=1
                let mainDict = NSMutableDictionary()
                let antiboticFeed = fetchMyBinde.object(at: i) as! MyCotoxinBindersFeedTurkey
                let dosage = antiboticFeed.dosage
                let feedId = antiboticFeed.feedId as! Int
                let feedProgram = antiboticFeed.feedProgram
                let fromDays = antiboticFeed.fromDays
                let molecule = antiboticFeed.molecule
                let toDays = antiboticFeed.toDays
                let feedType = antiboticFeed.feedType
                let startDate = antiboticFeed.feedDate
                mainDict.setValue(dosage, forKey: "dose")
                mainDict.setValue(feedId, forKey: "feedId")
                mainDict.setValue(feedProgram, forKey: "feedName")
                mainDict.setValue(fromDays, forKey: "durationFrom")
                mainDict.setValue(molecule, forKey: "molecule")
                mainDict.setValue(toDays, forKey: "durationTo")
                mainDict.setValue(18, forKey: "feedProgramCategoryId")
                mainDict.setValue(0, forKey: "moleculeId")
                mainDict.setValue(feedType, forKey: "feedType")
                
                FinalArray1.add(mainDict)
                
                if dataSet == 6 {
                    dataSet = 0
                    if mainFeeds.count>0 {
                        let tempArray = (mainFeeds.object(at: index) as AnyObject).value(forKey: "feedProgramDetails") as! NSMutableArray
                        if tempArray.count > 0 {
                            tempArray.addObjects(from: FinalArray1 as [AnyObject])
                            feeds = ["feedName" : feedProgram!, "feedId" : feedId, "startDate" : startDate ?? "","feedProgramDetails" : tempArray]
                        }
                        mainFeeds.replaceObject(at: index, with: feeds)
                        index+=1
                        FinalArray1 = NSMutableArray()
                        feeds = NSMutableDictionary()
                    }
                }
            }
            
            if ( allCocciControl.count > 0 || fetchAntibotic.count > 0 || fetchAlternative.count > 0 || fetchMyBinde.count > 0){
                
                mainDict.setValue(sessionId, forKey: "sessionId")
                let data = postingArrWithAllData.object(at: 0) as! PostingSessionTurkey
                let acttimeStamp = data.timeStamp
                
                var fullData  = String()
                fullData = acttimeStamp!
                mainDict.setValue(fullData, forKey: "deviceSessionId")
                
                let id = UserDefaults.standard.integer(forKey: "Id")
                mainDict.setValue(id, forKey: "UserId")
                mainDict.setValue(false, forKey: "finalized")
                sessionDict = ["deviceSessionId" : fullData,"sessionId" : postingIdArr[i] as! NSNumber, "userId" : id,"feeds" : mainFeeds]
                sessionArray.add(sessionDict)
                sessionDict = NSMutableDictionary()
                sessionDictMain = ["Sessions" : sessionArray]
            }
        }
        do {
            
            let jsonData = try! JSONSerialization.data(withJSONObject: sessionDictMain, options: JSONSerialization.WritingOptions.prettyPrinted)
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            
            
            if WebClass.sharedInstance.connected() {
                
                let Url = "PostingSession/SaveMultipleFeedsSyncData"
                accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
              //  accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
                let headerDict = ["Authorization":accestoken]
                
                let urlString: String = WebClass.sharedInstance.webUrl + Url
                var request = URLRequest(url: URL(string: urlString)! )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headerDict
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: sessionDictMain, options: [])
                
                sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                    let statusCode =  response.response?.statusCode
                    
                    if statusCode == 401  {
                        self.loginMethod(postingId: postingId)
                    }
                    else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                        self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                    }
                    
                    switch response.result {
                        
                    case .success(let responseObject):
                        // internet works.
                        self.addVaccination(postingId:postingId )
                        
                    case .failure(let encodingError):
                        
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            if let s = statusCode {
                                self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: s)
                                
                            }  else {
                                self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: - ******************* Save Add Vacination data On Server ***************************/
    /**************************************************************************/
    func addVaccination(postingId:NSNumber)  {
        
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId).mutableCopy() as! NSMutableArray
        let cNecArr =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
        let necArrWithoutPosting = NSMutableArray()
        
        for j in 0..<cNecArr.count
        {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            necArrWithoutPosting.add(captureNecropsyData)
            for w in 0..<necArrWithoutPosting.count - 1
            {
                let c = necArrWithoutPosting.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
                    necArrWithoutPosting.remove(c)
                }
                
            }
            
        }
        self.postingIdArr.removeAllObjects()
        var sessionId = NSNumber()
        var timeStamp = String()
        var actualTime = String()
        let tempArrTime = NSMutableArray()
        let actualTemp  = NSMutableArray()
        var vaccinationName = String ()
        
        for i in 0..<postingArrWithAllData.count {
            let pSession = postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            sessionId = pSession.postingId!
            timeStamp = pSession.timeStamp!
            var actualtimeStr = pSession.actualTimeStamp
            if actualtimeStr == nil{
                actualtimeStr = ""
            }
            actualTemp.add(actualtimeStr!)
            tempArrTime.add(timeStamp)
            self.postingIdArr.add(sessionId)
        }
        
        let sessionArr = NSMutableArray()
        let sessionDictWithVac = NSMutableDictionary()
        
        for i in 0..<self.postingIdArr.count {
            
            let pId = self.postingIdArr.object(at: i) as! NSNumber
            let addVacinationAll = CoreDataHandlerTurkey().fetchFieldAddvacinationDataTurkey(pId)
            
            let vaccinationDetail = NSMutableDictionary()
            for i in 0..<addVacinationAll.count {
                let pSession = addVacinationAll.object(at: i) as! FieldVaccinationTurkey
                if i == 0{
                    vaccinationName = pSession.vaciNationProgram!
                }
                
                let routeName = pSession.route
                var routeId = NSNumber()
                if routeName == "Drinking Water" {
                    routeId = 2
                } else if routeName == "Wing-Web" {
                    routeId = 1
                } else if routeName == "Spray" {
                    routeId = 3
                } else if routeName == "In Ovo" {
                    routeId = 4
                } else if routeName == "Subcutaneous" {
                    routeId = 5
                } else if routeName == "Intramuscular" {
                    routeId = 6
                } else  if  routeName == "Eye Drop"{
                    routeId = 7
                }
                else{
                    routeId = 0
                }
                var strain = String()
                strain = pSession.strain!
                let strainKey = "hatcheryStrain\(i + 1)"
                let routeKey = "hatcheryRoute\(i+1)Id"
                
                vaccinationDetail .setObject(strain, forKey: strainKey as NSCopying)
                vaccinationDetail .setObject(routeId, forKey: routeKey as NSCopying)
            }
            
            let FieldVacinationAll = CoreDataHandlerTurkey().fetchAddvacinationDataTurkey(pId)
            for i in 0..<FieldVacinationAll.count
            {
                let pSession = FieldVacinationAll.object(at: i) as! HatcheryVacTurkey
                var strain = String()
                let routeName = pSession.route
                
                var fieldStrain1 = String()
                var routeId = NSNumber()
                if routeName == "Drinking Water" {
                    routeId = 2
                }
                else if routeName == "Wing-Web" {
                    routeId = 1
                }
                else if routeName == "Spray" {
                    routeId = 3
                }
                else if routeName == "In Ovo" {
                    routeId = 4
                }
                else if routeName == "Subcutaneous" {
                    routeId = 5
                }
                else if routeName == "Intramuscular" {
                    routeId = 6
                }
                else  if  routeName == "Eye Drop"{
                    routeId = 7
                }
                else{
                    routeId = 0
                }
                let age = pSession.age
                fieldStrain1 = pSession.route!
                strain = pSession.strain!
                let fieldStrainKey = "fieldStrain\(i + 1)"
                let fieldrouteKey = "fieldRoute\(i+1)Id"
                let fieldAgeKey = "fieldAge\(i + 1)"
                
                vaccinationDetail .setObject(strain, forKey: fieldStrainKey as NSCopying)
                vaccinationDetail .setObject(routeId, forKey: fieldrouteKey as NSCopying)
                vaccinationDetail .setObject(age!, forKey: fieldAgeKey as NSCopying)
            }
            
            if FieldVacinationAll.count > 0 || addVacinationAll.count > 0
            {
                let vaccinationArray = NSMutableArray()
                vaccinationArray .add(vaccinationDetail)
                let mainDict = NSMutableDictionary()
                mainDict .setObject(vaccinationArray, forKey: "vaccinationDetail" as NSCopying)
                let id = UserDefaults.standard.integer(forKey: "Id")
                mainDict.setValue(id, forKey: "UserId")
                mainDict.setValue(pId, forKey: "sessionId")
                mainDict.setValue(pId, forKey: "vaccinationId")
                mainDict.setValue(vaccinationName, forKey: "vaccinationName")
                
                let data = postingArrWithAllData.object(at: 0) as! PostingSessionTurkey
                let acttimeStamp = data.timeStamp
                var  fullData  = String()
                fullData = acttimeStamp!
                mainDict.setValue(fullData, forKey: "deviceSessionId")
                sessionArr.add(mainDict)
            }
        }
        sessionDictWithVac.setValue(sessionArr, forKey: "Vaccinations")
        
        do {
            
            let jsonData = try! JSONSerialization.data(withJSONObject: sessionDictWithVac, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            
            if WebClass.sharedInstance.connected() {
                let Url = "/PostingSession/SaveMultipleVaccinationsSyncData"
                accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
               // accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
                let headerDict = ["Authorization":accestoken]
                let urlString: String = WebClass.sharedInstance.webUrl + Url
                var request = URLRequest(url: URL(string: urlString)! )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headerDict
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: sessionDictWithVac, options: [])
                
                sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                    let statusCode =  response.response?.statusCode
                    
                    if statusCode == 401  {
                        self.loginMethod(postingId: postingId)
                    }
                    else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                        self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                    }
                    
                    switch response.result {
                        
                    case .success(let responseObject):
                        self.savePostingDataOnServer(postingId: postingId)
                        
                    case .failure(let encodingError):
                        
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            
                            if let s = statusCode {
                                self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: s)
                            } else {
                                self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: - ********************* Save Posting data On Server ***************************/
    
    func savePostingDataOnServer(postingId :NSNumber){
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId).mutableCopy() as! NSMutableArray
        
        self.postingIdArr.removeAllObjects()
        let postingServerArray = NSMutableArray()
        let  postingDictOnServer = NSMutableDictionary()
        
        for i in 0..<postingArrWithAllData.count {
            let postingDataDict = NSMutableDictionary()
            let pSession = postingArrWithAllData.object(at: i) as! PostingSessionTurkey
            let sessionDate = pSession.sessiondate
            var sessionTypeId  = Int ()
            let sessiontype = pSession.sessionTypeName
            if sessiontype == "Farm Visit" {
                sessionTypeId = 2
            } else if sessiontype == "Posting Visit" {
                sessionTypeId = 1
            }
            else {
                sessionTypeId = 0
            }
            let customerId = pSession.customerId
            let complexId = pSession.complexId
            let customerRep = pSession.customerRepName
            let vetUserId = pSession.veterinarianId
            let salesUserId = pSession.salesRepId
            let cocciProgramId = pSession.cocciProgramId
            let breedName = pSession.birdBreedName
            let notes = pSession.notes
            let maleBreedName = pSession.mail
            let femaleBreedName = pSession.female
            let birdSize = pSession.birdSize
            let catptureNec = pSession.catptureNec
            let cociiProgramName = pSession.cociiProgramName
            let sessionId = pSession.postingId
            let finalize = pSession.finalizeExit
            let timestamp = pSession.timeStamp
            let actualTimeStamp = pSession.actualTimeStamp
            
            let avgAGe = pSession.avgAge
            let avgWght = pSession.avgWeight
            let outTime = pSession.outTime
            let fcr = pSession.fcr
            let livability = pSession.livability
            let mortality = pSession.dayMortality
            
            self.postingIdArr.add(sessionId!)
            var fullData = String()
            var udid = String()
            udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
            
            fullData =  pSession.timeStamp!
            let udid1 = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
            postingDataDict.setValue(finalize, forKey: "finalized")
            postingDataDict.setValue(sessionDate, forKey: "sessionDate")
            postingDataDict.setValue(sessionTypeId, forKey: "sessionTypeId")
            postingDataDict.setValue(lngId, forKey: "LanguageId")
            postingDataDict.setValue(customerId, forKey: "customerId")
            postingDataDict.setValue(complexId, forKey: "complexId")
            postingDataDict.setValue(fullData, forKey: "deviceSessionId")
            postingDataDict.setValue(customerRep, forKey: "customerRep")
            postingDataDict.setValue(vetUserId, forKey: "vetUserId")
            postingDataDict.setValue(salesUserId, forKey: "salesUserId")
            postingDataDict.setValue(cocciProgramId, forKey: "cocciProgramId")
            postingDataDict.setValue(breedName, forKey: "breedName")
            postingDataDict.setValue(1, forKey: "birdTypeId")
            postingDataDict.setValue(notes, forKey: "notes")
            postingDataDict.setValue(maleBreedName, forKey: "maleBreedName")
            postingDataDict.setValue(femaleBreedName, forKey: "femaleBreedName")
            postingDataDict.setValue(birdSize, forKey: "birdSize")
            postingDataDict.setValue(catptureNec, forKey: "catptureNec")
            postingDataDict.setValue(cociiProgramName, forKey: "cociiProgramName")
            postingDataDict.setValue(sessionId, forKey: "sessionId")
            let id = UserDefaults.standard.integer(forKey: "Id")
            postingDataDict.setValue(id, forKey: "UserId")
            postingDataDict.setValue(udid1, forKey: "udid")
            postingDataDict.setValue(fcr, forKey: "FCR")
            postingDataDict.setValue(avgWght, forKey: "AvgWeight")
            postingDataDict.setValue(avgAGe, forKey: "AvgAge")
            postingDataDict.setValue(outTime, forKey: "AvgOutTime")
            postingDataDict.setValue(livability, forKey: "Livability")
            postingDataDict.setValue(mortality, forKey: "Avg7DayMortality")
            postingServerArray.add(postingDataDict)
        }
        
        postingDictOnServer.setValue(postingServerArray, forKey: "PostingSessions")
        
        do {
            
            let jsonData = try! JSONSerialization.data(withJSONObject: postingDictOnServer, options: JSONSerialization.WritingOptions.prettyPrinted)
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            
            if WebClass.sharedInstance.connected() {
                let Url = "PostingSession/T_SaveMultiplePostingsSyncData"
               // accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
                accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
                let headerDict = ["Authorization":accestoken]
                let urlString: String = WebClass.sharedInstance.webUrl + Url
                var request = URLRequest(url: URL(string: urlString)! )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headerDict
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: postingDictOnServer, options: [])
                sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                    let statusCode =  response.response?.statusCode
                    
                    if statusCode == 401  {
                        self.loginMethod(postingId: postingId)
                    }
                    else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                        self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                    }
                    
                    switch response.result {
                        
                    case .success(let responseObject):
                        self.saveNecropsyDataOnServer(postingId: postingId)
                        
                    case .failure(let encodingError):
                        
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            
                            if let s = statusCode {
                                self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: s)
                            }
                            else {
                                self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: - ********************* Save Farms  data On Server **************/
    /************************************/
    
    func saveNecropsyDataOnServer(postingId: NSNumber){
        var complexId = Int()
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let cNecArr = CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
        let a = NSMutableArray()
        
        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            a.add(captureNecropsyData)
            for w in 0..<a.count - 1
            {
                let c = a.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId {
                    a.remove(c)
                }
            }
        }
        
        let sessionWithAllforms = NSMutableDictionary()
        let sessionArr = NSMutableArray()
        for i in 0..<a.count
        {
            let allArray = NSMutableArray()
            let captureNecropsyData = a.object(at: i)  as! CaptureNecropsyDataTurkey
            let nId = captureNecropsyData.necropsyId!
            complexId = Int(captureNecropsyData.complexId!)
            
            let cNec =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
            let formWithcatNameWithBirdAndAllObs1 = NSMutableDictionary()
            for x in 0..<cNec.count
            {
                let birdArry = NSMutableArray()
                let cNData = cNec.object(at: x) as! CaptureNecropsyDataTurkey
                let farmName = cNData.farmName
                let noOfBird = Int(cNData.noOfBirds!)
                let houseNo = cNData.houseNo
                let feedProgram = cNData.feedProgram
                if let value = cNData.feedId {
                    var feedId = value
                }
                let age = cNData.age
                let flock = cNData.flockId
                let sick = cNData.sick
                let imgId = cNData.imageId
                complexId = cNData.complexId as! Int
                let timestamp = cNData.timeStamp
                let customerId = cNData.custmerId
                let customerName = cNData.complexName
                let complexdate = cNData.complexDate
                var abf = cNData.abf
                let farmWeight = cNData.farmWeight
                let breedString = cNData.breed
                let sex = cNData.sex
                let farmId = cNData.farmId
                let genName = cNData.generName
                let genId = cNData.generID
                let formWithcatNameWithBirdAndAllObs = NSMutableDictionary()
                
                for j in 0..<noOfBird!
                {
                    let obsNameWithValue =   CoreDataHandlerTurkey().fetchObsWithBirdandFarmNameTurkey(farmName!, birdNo: (j + 1) as NSNumber, necId: cNData.necropsyId!)
                    let notesWithFarm = CoreDataHandlerTurkey().fetchNotesWithBirdNumandFarmNameTurkey((j + 1) as NSNumber, formName: farmName!, necId: cNData.necropsyId!)
                    if notesWithFarm.count > 0
                    {
                        let n = notesWithFarm.object(at: 0) as! NotesBirdTurkey
                        let notes = n.notes
                        obsNameWithValue.setValue(j + 1, forKey: "BirdId")
                        obsNameWithValue.setValue(notes, forKey: "birdNotes")
                    } else {
                        obsNameWithValue.setValue(j + 1, forKey: "BirdId")
                        obsNameWithValue.setValue("", forKey: "birdNotes")
                    }
                    birdArry.add(obsNameWithValue)
                }
                
                formWithcatNameWithBirdAndAllObs.setValue(birdArry, forKey: "BirdDetails")
                formWithcatNameWithBirdAndAllObs.setValue(farmName, forKey: "farmName")
                formWithcatNameWithBirdAndAllObs.setValue(houseNo, forKey: "houseNo")
                formWithcatNameWithBirdAndAllObs.setValue(noOfBird!, forKey: "birds")
                formWithcatNameWithBirdAndAllObs.setValue(farmId, forKey: "SortId")
                formWithcatNameWithBirdAndAllObs.setValue(imgId, forKey: "ImgId")
                formWithcatNameWithBirdAndAllObs.setValue(feedProgram, forKey: "feedProgram")
                formWithcatNameWithBirdAndAllObs.setValue(feedId, forKey: "DeviceFeedId")
                formWithcatNameWithBirdAndAllObs.setValue(age, forKey: "age")
                formWithcatNameWithBirdAndAllObs.setValue(customerId, forKey: "customerId")
                formWithcatNameWithBirdAndAllObs.setValue(customerName, forKey: "customerName")
                formWithcatNameWithBirdAndAllObs.setValue(sick, forKey: "sick")
                formWithcatNameWithBirdAndAllObs.setValue(flock, forKey: "flockId")
                formWithcatNameWithBirdAndAllObs.setValue(complexdate, forKey: "ComplexDate")
                formWithcatNameWithBirdAndAllObs.setValue(abf, forKey: "ABF")
                formWithcatNameWithBirdAndAllObs.setValue(farmWeight, forKey: "Farm_Weight")
                formWithcatNameWithBirdAndAllObs.setValue(breedString, forKey: "Breed")
                formWithcatNameWithBirdAndAllObs.setValue(sex, forKey: "Sex")
                
                formWithcatNameWithBirdAndAllObs.setValue(genName, forKey: "GenerationName")
                formWithcatNameWithBirdAndAllObs.setValue(genId, forKey: "GenerationId")
                allArray.add(formWithcatNameWithBirdAndAllObs)
            }
            var fullData = String()
            
            fullData = captureNecropsyData.timeStamp!
            formWithcatNameWithBirdAndAllObs1.setValue(captureNecropsyData.necropsyId!, forKey: "SessionId")
            formWithcatNameWithBirdAndAllObs1.setValue(lngId, forKey: "LanguageId")
            formWithcatNameWithBirdAndAllObs1.setValue(fullData, forKey: "deviceSessionId")
            if complexId > 0{
                formWithcatNameWithBirdAndAllObs1.setValue(complexId, forKey: "ComplexId")
            }
            
            formWithcatNameWithBirdAndAllObs1.setValue(captureNecropsyData.complexDate!, forKey: "sessionDate")
            formWithcatNameWithBirdAndAllObs1.setValue(allArray, forKey: "farmDetails")
            let Id = UserDefaults.standard.integer(forKey: "Id")
            formWithcatNameWithBirdAndAllObs1.setValue(Id, forKey: "UserId")
            
            sessionArr.add(formWithcatNameWithBirdAndAllObs1)
        }
        postingArrWithAllData.removeAllObjects()
        postingArrWithAllData = CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId).mutableCopy() as! NSMutableArray
        
        for i in 0..<postingArrWithAllData.count {
            
            let allArray = NSMutableArray()
            let captureNecropsyData = postingArrWithAllData.object(at: i)  as! PostingSessionTurkey
            let nId = captureNecropsyData.postingId!
            let cid = captureNecropsyData.complexId!
            let cNec =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
            
            let formWithcatNameWithBirdAndAllObs1 = NSMutableDictionary()
            
            for x in 0..<cNec.count {
                
                let birdArry = NSMutableArray()
                let cNData = cNec.object(at: x) as! CaptureNecropsyDataTurkey
                let farmName = cNData.farmName
                let noOfBird = Int(cNData.noOfBirds!)
                let houseNo = cNData.houseNo
                let feedProgram = cNData.feedProgram
                if let value =  (cNData.feedId  as? Int){
                    feedId = value
                }
                let age = cNData.age
                complexId = cNData.complexId as! Int
                let timestamp = cNData.timeStamp
                let flock = cNData.flockId
                let imgId = cNData.imageId
                let farmId = cNData.farmId
                let sick = cNData.sick
                let customerId = cNData.custmerId
                let customerName = cNData.complexName
                let complexDate = cNData.complexDate
                let formWithcatNameWithBirdAndAllObs = NSMutableDictionary()
                var abf = cNData.abf
                let farmWeight = cNData.farmWeight
                let breedString = cNData.breed
                let sex = cNData.sex
                let genName = cNData.generName
                let genId = cNData.generID
                
                for j in 0..<noOfBird! {
                    
                    let obsNameWithValue =   CoreDataHandlerTurkey().fetchObsWithBirdandFarmNameTurkey(farmName!, birdNo: (j + 1) as NSNumber, necId: cNData.necropsyId!)
                    let notesWithFarm = CoreDataHandlerTurkey().fetchNotesWithBirdNumandFarmNameTurkey((j + 1) as NSNumber, formName: farmName!, necId: cNData.necropsyId!)
                    
                    if notesWithFarm.count > 0 {
                        let n = notesWithFarm.object(at: 0) as! NotesBirdTurkey
                        let notes = n.notes
                        obsNameWithValue.setValue(j + 1, forKey: "BirdId")
                        obsNameWithValue.setValue(notes, forKey: "birdNotes")
                    }  else  {
                        obsNameWithValue.setValue(j + 1, forKey: "BirdId")
                        obsNameWithValue.setValue("", forKey: "birdNotes")
                    }
                    birdArry.add(obsNameWithValue)
                }
                
                formWithcatNameWithBirdAndAllObs.setValue(abf, forKey: "ABF")
                formWithcatNameWithBirdAndAllObs.setValue(farmWeight, forKey: "Farm_Weight")
                formWithcatNameWithBirdAndAllObs.setValue(breedString, forKey: "Breed")
                formWithcatNameWithBirdAndAllObs.setValue(sex, forKey: "Sex")
                formWithcatNameWithBirdAndAllObs.setValue(farmId, forKey: "SortId")
                formWithcatNameWithBirdAndAllObs.setValue(imgId, forKey: "ImgId")
                formWithcatNameWithBirdAndAllObs.setValue(birdArry, forKey: "BirdDetails")
                formWithcatNameWithBirdAndAllObs.setValue(farmName, forKey: "farmName")
                formWithcatNameWithBirdAndAllObs.setValue(houseNo, forKey: "houseNo")
                formWithcatNameWithBirdAndAllObs.setValue(noOfBird!, forKey: "birds")
                formWithcatNameWithBirdAndAllObs.setValue(feedProgram, forKey: "feedProgram")
                formWithcatNameWithBirdAndAllObs.setValue(feedId, forKey: "DeviceFeedId")
                formWithcatNameWithBirdAndAllObs.setValue(age, forKey: "age")
                formWithcatNameWithBirdAndAllObs.setValue(customerId, forKey: "customerId")
                formWithcatNameWithBirdAndAllObs.setValue(customerName, forKey: "customerName")
                formWithcatNameWithBirdAndAllObs.setValue(sick, forKey: "sick")
                formWithcatNameWithBirdAndAllObs.setValue(flock, forKey: "flockId")
                formWithcatNameWithBirdAndAllObs.setValue(complexDate, forKey: "ComplexDate")
                formWithcatNameWithBirdAndAllObs.setValue(genName, forKey: "GenerationName")
                formWithcatNameWithBirdAndAllObs.setValue(genId, forKey: "GenerationId")
                allArray.add(formWithcatNameWithBirdAndAllObs)
                
            }
            
            var fullData = String()
            fullData = captureNecropsyData.timeStamp!
            formWithcatNameWithBirdAndAllObs1.setValue(captureNecropsyData.postingId!, forKey: "SessionId")
            formWithcatNameWithBirdAndAllObs1.setValue(fullData, forKey: "deviceSessionId")
            formWithcatNameWithBirdAndAllObs1.setValue(lngId, forKey: "LanguageId")
            formWithcatNameWithBirdAndAllObs1.setValue(cid, forKey: "ComplexId")
            formWithcatNameWithBirdAndAllObs1.setValue(captureNecropsyData.sessiondate!, forKey: "sessionDate")
            formWithcatNameWithBirdAndAllObs1.setValue(allArray, forKey: "farmDetails")
            let Id = UserDefaults.standard.integer(forKey: "Id")
            formWithcatNameWithBirdAndAllObs1.setValue(Id, forKey: "UserId")
            sessionArr.add(formWithcatNameWithBirdAndAllObs1)
        }
        
        sessionWithAllforms.setValue(sessionArr, forKey: "Session")
        
        do {
            
            let jsonData = try! JSONSerialization.data(withJSONObject: sessionWithAllforms, options: JSONSerialization.WritingOptions.prettyPrinted)
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            debugPrint(jsonString)
            if WebClass.sharedInstance.connected() {
                accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
               // accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
                let headerDict = ["Authorization":accestoken]
                let Url = "PostingSession/T_SaveMultipleNecropsySyncData"
                let urlString: String = WebClass.sharedInstance.webUrl + Url
                var request = URLRequest(url: URL(string: urlString)! )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headerDict
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try! JSONSerialization.data(withJSONObject: sessionWithAllforms, options: [])
                
                sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                    let statusCode =  response.response?.statusCode
                    
                    if statusCode == 401  {
                        self.loginMethod(postingId:postingId)
                    }
                    else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                        self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                    }
                    
                    switch response.result {
                        
                    case .success(let responseObject):
                        self.saveObservationImageOnServer(postingId: postingId)
                        
                    case .failure(let encodingError):
                        
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            
                            if let s = statusCode {
                                self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: s)
                                
                            } else  {
                                self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: -********************* Save Image  On Server ***************************/
    /**************************************************************************/
    
    func  saveObservationImageOnServer (postingId:NSNumber){
        
        let imageArrWithIsyncIsTrue = CoreDataHandlerTurkey().fecthPhotoWithiSynsTrueTurkey(true)
        let sessionDict = NSMutableDictionary()
        let sessionArr = NSMutableArray()
        let cNecArr =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
        let totalSession = NSMutableArray()
        
        for j in 0..<cNecArr.count {
            let captureNecropsyData = cNecArr.object(at: j)  as! CaptureNecropsyDataTurkey
            totalSession.add(captureNecropsyData)
            for w in 0..<totalSession.count - 1
            {
                let c = totalSession.object(at: w)  as! CaptureNecropsyDataTurkey
                if c.necropsyId == captureNecropsyData.necropsyId
                {
                    totalSession.remove(c)
                }
            }
        }
        
        postingArrWithAllData.removeAllObjects()
        postingArrWithAllData =  CoreDataHandlerTurkey().fetchAllPostingSessionTurkey(postingId).mutableCopy() as! NSMutableArray
        
        if imageArrWithIsyncIsTrue.count > 0
        {
            for i in 0..<totalSession.count
            {
                let sessionDetails = NSMutableDictionary()
                let captureNecropsyData = totalSession.object(at: i)  as! CaptureNecropsyDataTurkey
                let nId = captureNecropsyData.necropsyId!
                let timestamp = captureNecropsyData.timeStamp
                let cNec =  CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
                let obsWithImageArr = NSMutableArray()
                for x in 0..<cNec.count
                {
                    let cNData = cNec.object(at: x) as! CaptureNecropsyDataTurkey
                    let farmName = cNData.farmName
                    let noOfBird = Int(cNData.noOfBirds!)
                    let necId = Int(cNData.necropsyId!)
                    for j in 0..<noOfBird!
                    {
                        let catArr = ["skeltaMuscular","Coccidiosis","GITract","Resp","Immune"] as NSArray
                        for w in 0..<catArr.count
                        {
                            let obsArr = CoreDataHandlerTurkey().fecthobsDataWithCatnameAndFarmNameAndBirdNumberTurkey((j + 1) as NSNumber, farmname: farmName!, catName: catArr.object(at: w) as! String, necId: necId as NSNumber)
                            
                            for y in 0..<obsArr.count
                            {
                                let obsWithAllImageDataDict = NSMutableDictionary()
                                let cData = obsArr.object(at: y) as! CaptureNecropsyViewDataTurkey
                                let photoArr = CoreDataHandlerTurkey().fecthPhotoWithCatnameWithBirdAndObservationIDandIsyncTurkey( (j + 1) as NSNumber, farmname: farmName!, catName: catArr.object(at: w) as! String, Obsid: cData.obsID!, isSync: true,necId: necId as NSNumber)
                                obsWithAllImageDataDict.setValue(farmName!, forKey: "farmName")
                                obsWithAllImageDataDict.setValue(j + 1, forKey: "birdNumber")
                                
                                var catName1 = catArr.object(at: w) as! String
                                if catName1 == "Coccidiosis"{
                                    catName1 = "Microscopy"
                                }
                                
                                obsWithAllImageDataDict.setValue(catName1, forKey: "categoryName")
                                obsWithAllImageDataDict.setValue(cData.obsID!, forKey: "observationId")
                                
                                let photoValArr = NSMutableArray()
                                var yImage =  UIImage()
                                for z in 0..<photoArr.count
                                {
                                    let objBirdPhotoCapture = photoArr.object(at: z) as! BirdPhotoCaptureTurkey
                                    var image : UIImage = UIImage(data: objBirdPhotoCapture.photo! as Data)!
                                    var data: Data = image.pngData()!
                                    
                                    if let imageData = image.jpeg(.lowest) {
                                        image = UIImage(data: imageData)!
                                    }
                                    
                                    let w : CGFloat = image.size.width / 7
                                    yImage = self.resizeImage(image, newWidth: w)!
                                    data = yImage.pngData()!
                                    let imageDict =  NSMutableDictionary()
                                    imageDict.setValue(self.imageToNSString(yImage), forKey: "Image")
                                    photoValArr.add(imageDict)
                                }
                                obsWithAllImageDataDict.setValue(photoValArr, forKey: "images")
                                obsWithImageArr.add(obsWithAllImageDataDict)
                            }
                        }
                    }
                }
                
                var fullData = String()
                fullData = captureNecropsyData.timeStamp!
                sessionDetails.setValue(obsWithImageArr, forKey: "ImageDetails")
                let id = UserDefaults.standard.integer(forKey: "Id")
                sessionDetails.setValue(id, forKey: "UserId")
                sessionDetails.setValue(fullData, forKey: "deviceSessionId")
                sessionArr.add(sessionDetails)
            }
            
            for i in 0..<postingArrWithAllData.count {
                let sessionDetails = NSMutableDictionary()
                let captureNecropsyData = postingArrWithAllData.object(at: i)  as! PostingSessionTurkey
                let nId = captureNecropsyData.postingId!
                _ = captureNecropsyData.timeStamp
                
                let cNec = CoreDataHandlerTurkey().FetchNecropsystep1NecIdTurkey(postingId)
                let obsWithImageArr = NSMutableArray()
                for x in 0..<cNec.count
                {
                    let cNData = cNec.object(at: x) as! CaptureNecropsyDataTurkey
                    let farmName = cNData.farmName
                    let noOfBird = Int(cNData.noOfBirds!)
                    let necId = Int(cNData.necropsyId!)
                    for j in 0..<noOfBird!
                    {
                        let catArr = ["skeltaMuscular","Coccidiosis","GITract","Resp","Immune"] as NSArray
                        
                        for w in 0..<catArr.count
                        {
                            let obsArr = CoreDataHandlerTurkey().fecthobsDataWithCatnameAndFarmNameAndBirdNumberTurkey((j + 1) as NSNumber, farmname: farmName!, catName: catArr.object(at: w) as! String, necId: necId as NSNumber)
                            
                            for y in 0..<obsArr.count
                            {
                                let obsWithAllImageDataDict = NSMutableDictionary()
                                let cData = obsArr.object(at: y) as! CaptureNecropsyViewDataTurkey
                                let photoArr = CoreDataHandlerTurkey().fecthPhotoWithCatnameWithBirdAndObservationIDandIsyncTurkey((j + 1) as NSNumber, farmname: farmName!, catName: catArr.object(at: w) as! String, Obsid: cData.obsID!, isSync: true,necId: necId as NSNumber)
                                obsWithAllImageDataDict.setValue(farmName!, forKey: "farmName")
                                obsWithAllImageDataDict.setValue(j + 1, forKey: "birdNumber")
                                var catName = catArr.object(at: w) as! String
                                if catName == "Coccidiosis"{
                                    catName = "Microscopy"
                                }
                                
                                obsWithAllImageDataDict.setValue(catName, forKey: "categoryName")
                                obsWithAllImageDataDict.setValue(cData.obsID!, forKey: "observationId")
                                
                                let photoValArr = NSMutableArray()
                                var yImage =  UIImage()
                                for z in 0..<photoArr.count
                                {
                                    let objBirdPhotoCapture = photoArr.object(at: z) as! BirdPhotoCaptureTurkey
                                    
                                    var image : UIImage = UIImage(data: objBirdPhotoCapture.photo! as Data)!
                                    var data: Data = image.pngData()!
                                    
                                    if let imageData = image.jpeg(.lowest) {
                                        
                                        image = UIImage(data: imageData)!
                                    }
                                    let w : CGFloat = image.size.width / 7
                                    yImage = self.resizeImage(image, newWidth: w)!
                                    data = yImage.pngData()!
                                    let imageDict =  NSMutableDictionary()
                                    imageDict.setValue(self.imageToNSString(yImage), forKey: "Image")
                                    photoValArr.add(imageDict)
                                    
                                }
                                obsWithAllImageDataDict.setValue(photoValArr, forKey: "images")
                                obsWithImageArr.add(obsWithAllImageDataDict)
                            }
                        }
                    }
                }
                
                _ = Int()
                var fullData = String()
                fullData = captureNecropsyData.timeStamp!
                sessionDetails.setValue(obsWithImageArr, forKey: "ImageDetails")
                let id = UserDefaults.standard.integer(forKey: "Id")
                sessionDetails.setValue(id, forKey: "UserId")
                sessionDetails.setValue(fullData, forKey: "deviceSessionId")
                sessionArr.add(sessionDetails)
                
            }
        }
        sessionDict.setValue(sessionArr, forKey: "Sessions")
        
        do {
            let jsonData = try! JSONSerialization.data(withJSONObject: sessionDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
            
            if WebClass.sharedInstance.connected() {
                accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
               // accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
                let headerDict = ["Authorization":accestoken]
                let Url = "PostingSession/SaveBirdImageSyncData"
                let urlString: String = WebClass.sharedInstance.webUrl + Url
                var request = URLRequest(url: URL(string: urlString)! )
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headerDict
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.httpBody = try! JSONSerialization.data(withJSONObject: sessionDict, options: [])
                
                sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                    let statusCode =  response.response?.statusCode
                    
                    if statusCode == 401  {
                        self.loginMethod(postingId: postingId)
                    }
                    else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                        self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                    }
                    
                    switch response.result {
                        
                    case .success(let responseObject):
                        Constants.isFromPsotingTurkey = false
                        UserDefaults.standard.removeObject(forKey: "postingTurkey")
                        CoreDataHandlerTurkey().updateisSyncOnBirdPhotoCaptureDatabaseTurkey(postingId , isSync: false, { (success) in
                            
                            if success == true{
                                
                                CoreDataHandlerTurkey().updateisSyncOnMyBindersViaPostingIdTurkey(postingId, isSync: false, { (success) in
                                    
                                    if success == true{
                                        
                                        CoreDataHandlerTurkey().updateisSyncOnAlternativeFeedPostingidTurkey(postingId , isSync: false, { (success) in
                                            
                                            if success == true{
                                                
                                                CoreDataHandlerTurkey().updateisSyncOnAntiboticViaPostingIdTurkey(postingId , isSync: false, { (success) in
                                                    
                                                    if success == true{
                                                        
                                                        CoreDataHandlerTurkey().updateisSyncOnAllCocciControlviaPostingidTurkey(postingId , isSync: false, { (success) in
                                                            
                                                            if success == true{
                                                                
                                                                CoreDataHandlerTurkey().updateisSyncOnHetcharyVacDataWithPostingIdTurkey(postingId , isSync: false, { (success) in
                                                                    
                                                                    if success == true{
                                                                        
                                                                        CoreDataHandlerTurkey().updateisSyncOnPostingSessionTurkey(postingId , isSync: false, { (success) in
                                                                            
                                                                            if success == true{
                                                                                
                                                                                CoreDataHandlerTurkey().updateisSyncOnBirdPhotoCaptureDatabaseTurkey(postingId , isSync: false, { (success) in
                                                                                    
                                                                                    if success == true{
                                                                                        CoreDataHandlerTurkey().updateisSyncOnNotesBirdDatabaseTurkey(postingId , isSync: false, { (success) in
                                                                                            
                                                                                            if success == true{
                                                                                                CoreDataHandlerTurkey().updateisSyncNecropsystep1neccIdTurkey(postingId , isSync: false, { (success) in
                                                                                                    if success == true{
                                                                                                        CoreDataHandlerTurkey().updateisSyncOnCaptureSkeletaInDatabaseTurkey(postingId , isSync: false, { (success) in
                                                                                                            if success == true{
                                                                                                                
                                                                                                                CoreDataHandlerTurkey().updateisSyncOnBirdPhotoCaptureDatabaseTurkey(postingId , isSync: false, { (success) in
                                                                                                                    if success == true{
                                                                                                                        self.delegeteSyncApiData.didFinishApiSyncdata()
                                                                                                                    }
                                                                                                                })
                                                                                                            }
                                                                                                        })
                                                                                                    }
                                                                                                })
                                                                                            }
                                                                                        })
                                                                                    }
                                                                                })
                                                                            }
                                                                        })
                                                                    }
                                                                })
                                                            }
                                                        })
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                        
                    case .failure(let encodingError):
                        
                        if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                            
                            if let s = statusCode {
                                self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: s)
                            }  else  {
                                self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                            }
                        }
                    }
                }
            }
        }
    }
    // MARK: -********************* Save User Setting   On Server ***************************/
    /**************************************************************************/
    func saveDatOnServerAllSeting() {
        
        let lngId = UserDefaults.standard.integer(forKey: "lngId")
        let outerDict = NSMutableDictionary()
        let arr1 = NSMutableArray()
        let Id = UserDefaults.standard.integer(forKey: "Id")
        outerDict.setValue(Id, forKey: "UserId")
        
        let cocoii = CoreDataHandlerTurkey().fetchAllCocoiiDataTurkey().mutableCopy() as! NSMutableArray
        let gitract = CoreDataHandlerTurkey().fetchAllGITractDataTurkey().mutableCopy() as! NSMutableArray
        let resp = CoreDataHandlerTurkey().fetchAllRespiratoryTurkey().mutableCopy() as! NSMutableArray
        let immu = CoreDataHandlerTurkey().fetchAllImmuneTurkey().mutableCopy() as! NSMutableArray
        let skeletenArr = CoreDataHandlerTurkey().fetchAllSeettingdataTurkey().mutableCopy() as! NSMutableArray
        
        for i in 0..<skeletenArr.count{
            let obsId = (skeletenArr.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (skeletenArr.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (skeletenArr.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let quicklinkIndex = (skeletenArr.object(at: i) as AnyObject).value(forKey: "quicklinkIndex")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            Internaldict.setValue(quicklinkIndex, forKey: "SequenceId")
            arr1.add(Internaldict)
        }
        
        for i in 0..<cocoii.count{
            let obsId = (cocoii.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (cocoii.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (cocoii.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let quicklinkIndex = (cocoii.object(at: i) as AnyObject).value(forKey: "quicklinkIndex")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            Internaldict.setValue(quicklinkIndex, forKey: "SequenceId")
            arr1.add(Internaldict)
        }
        
        for i in 0..<gitract.count{
            let obsId = (gitract.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (gitract.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (gitract.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let quicklinkIndex = (gitract.object(at: i) as AnyObject).value(forKey: "quicklinkIndex")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            Internaldict.setValue(quicklinkIndex, forKey: "SequenceId")
            arr1.add(Internaldict)
        }
        for i in 0..<resp.count{
            let obsId = (resp.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (resp.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (resp.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let quicklinkIndex = (resp.object(at: i) as AnyObject).value(forKey: "quicklinkIndex")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            Internaldict.setValue(quicklinkIndex, forKey: "SequenceId")
            arr1.add(Internaldict)
        }
        for i in 0..<immu.count{
            let obsId = (immu.object(at: i) as AnyObject).value(forKey: "observationId")
            let visbility = (immu.object(at: i) as AnyObject).value(forKey: "visibilityCheck")
            let quickLink = (immu.object(at: i) as AnyObject).value(forKey: "quicklinks")
            let quicklinkIndex = (immu.object(at: i) as AnyObject).value(forKey: "quicklinkIndex")
            let Internaldict = NSMutableDictionary()
            Internaldict.setValue(obsId, forKey: "ObservationId")
            Internaldict.setValue(quickLink, forKey: "QuickLink")
            Internaldict.setValue(visbility, forKey: "Visibility")
            Internaldict.setValue(lngId, forKey: "LanguageId")
            Internaldict.setValue(quicklinkIndex, forKey: "SequenceId")
            arr1.add(Internaldict)
        }
        
        outerDict.setValue(arr1, forKey: "ObservationUserDetails")
        let jsonData = try! JSONSerialization.data(withJSONObject: outerDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        var jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        jsonString = jsonString.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if WebClass.sharedInstance.connected() {
            
            let Url = "Setting/SaveUserSetting"
            accestoken = AccessTokenHelper().getFromKeychain(keyed: "aceesTokentype")!
          //  accestoken = (UserDefaults.standard.value(forKey: "aceesTokentype") as? String)!
            let headerDict = ["Authorization":accestoken]
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            var request = URLRequest(url: URL(string: urlString)! )
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headerDict
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: outerDict, options: [])
            
            sessionManager.request(request as URLRequestConvertible).responseJSON { response in
                let statusCode =  response.response?.statusCode
                
                if statusCode == 401  {
                }
                else if statusCode == 500 || statusCode == 503 ||  statusCode == 403 ||  statusCode==501 || statusCode == 502 || statusCode == 400 || statusCode == 504 || statusCode == 404 || statusCode == 408{
                    self.delegeteSyncApiData.failWithErrorSyncdata(statusCode: statusCode!)
                }
                
                switch response.result {
                    
                case .success(let responseObject):
                    debugPrint(responseObject)
                case .failure(let encodingError):
                    
                    if let err = encodingError as? URLError, err.code == .notConnectedToInternet {
                        self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                    } else if let data = response.data, let responseString = String(data: data, encoding: String.Encoding.utf8) {
                        debugPrint (encodingError)
                        debugPrint (responseString)
                        if let s = statusCode {
                        }
                        else
                        {
                            self.delegeteSyncApiData.failWithErrorInternalSyncdata()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: -*************** Login Method call Again  ***************************************************/
    
    func loginMethod(postingId:NSNumber){
        
        if WebClass.sharedInstance.connected() {
            let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")!
            let userName =  PasswordService.shared.getUsername()
            let pass =  PasswordService.shared.getPassword()
            
            let Url = "Token"
            let urlString: String = WebClass.sharedInstance.webUrl + Url
            let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
            let parameters:[String:String] = ["grant_type": "password","UserName" : CryptoHelper.encrypt(input: userName) as! String, "Password" : CryptoHelper.encrypt(input: pass) as! String, "LoginType": "Web", "DeviceId":udid as! String]
            sessionManager.request(urlString, method: .post, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case let .success(value):
                    let statusCode = response.response?.statusCode
                    let dict : NSDictionary = value as! NSDictionary
                    if statusCode == 400{
                        _ = dict["error_description"]
                    }
                    
                    else if statusCode == 401{
                        _ = dict["error_description"]
                    }
                    else{
                        let acessToken = (dict.value(forKey: "access_token") as? String)!
                        let tokenType = (dict.value(forKey: "token_type") as? String)!
                        let aceesTokentype: String = tokenType + " " + acessToken
                        _ = dict.value(forKey: "HasAccess")! as AnyObject
                        let keychainHelper = AccessTokenHelper()
                        keychainHelper.saveToKeychain(valued: aceesTokentype, keyed: "aceesTokentype")
//                        UserDefaults.standard.set(aceesTokentype,forKey: "aceesTokentype")
//                        UserDefaults.standard.synchronize()
                        self.feedprogram(postingId: postingId)
                    }
                    break
                case let .failure(error):
                    debugPrint(error.localizedDescription)
                    break
                }
            }
        }
    }
    // MARK: - Update Data on Data Base
    func updadateDataOnCoreData(pId: NSNumber, _ completion: @escaping (_ status: Bool) -> Void){
        CoreDataHandlerTurkey().updateisSyncOnMyBindersViaPostingIdTurkey(pId, isSync: false, { (success) in
            if success == true{
                CoreDataHandlerTurkey().updateisSyncOnAlternativeFeedPostingidTurkey(pId , isSync: false, { (success) in
                    if success == true{
                        
                        CoreDataHandlerTurkey().updateisSyncOnAntiboticViaPostingIdTurkey(pId , isSync: false, { (success) in
                            if success == true{
                                
                                CoreDataHandlerTurkey().updateisSyncOnAllCocciControlviaPostingidTurkey(pId , isSync: false, { (success) in
                                    if success == true{
                                        
                                        CoreDataHandlerTurkey().updateisSyncOnHetcharyVacDataWithPostingIdTurkey(pId , isSync: false, { (success) in
                                            if success == true
                                            {
                                                CoreDataHandlerTurkey().updateisSyncOnPostingSessionTurkey(pId , isSync: false, { (success) in
                                                    if success == true{
                                                        self.updadateNacDataOnCoreData(nId: pId, { (success) in
                                                            if success == true{
                                                                completion(success)
                                                                self.delegeteSyncApiData.didFinishApiSyncdata()
                                                            }
                                                        })
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    }
    // MARK: - Update Necropsy Data on Core DB
    func updadateNacDataOnCoreData(nId: NSNumber, _ completion: (_ status: Bool) -> Void){
        
        CoreDataHandlerTurkey().updateisSyncOnCaptureSkeletaInDatabaseTurkey(nId , isSync: false, { (success) in
            if success == true{
                
                CoreDataHandlerTurkey().updateisSyncNecropsystep1neccIdTurkey(nId , isSync: false, { (success) in
                    if success == true{
                        
                        CoreDataHandlerTurkey().updateisSyncOnCaptureInDatabaseTurkey(nId , isSync: false, { (success) in
                            if success == true{
                                
                                CoreDataHandlerTurkey().updateisSyncOnBirdPhotoCaptureDatabaseTurkey(nId , isSync: false, { (success) in
                                    if success == true{
                                        CoreDataHandlerTurkey().updateisSyncOnNotesBirdDatabaseTurkey(nId , isSync: false, { (success) in
                                            if success == true{
                                                completion(success)
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        })
    }
}
