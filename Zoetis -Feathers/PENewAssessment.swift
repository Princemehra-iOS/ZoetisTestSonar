//
//  PENewAssessment.swift
//  Zoetis -Feathers
//
//  Created by "" ""on 25/12/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import UIKit

public class PENewAssessment: NSObject {
    var isAllowNA:Bool?
    var rollOut:String?
    var refrigeratorNote:String?
    var isNA:Bool?
    var qSeqNo:Int?
    var updatedDate:Date?
    var serverAssessmentId:String?
    var scheduledDate:Date?
    var userID:Int?
    var firstname:String?
    var username:String?
    var micro:String?
    var residue:String?
    var selectedTSR:String?
    var selectedTSRID:Int?
    var customerId:Int?
    var customerName:String?
    var complexId:Int?
    var complexName:String?
    var sequenceNo:Int?
    var sequenceNoo:Int?
    var draftNumber:Int?
    var draftID:String?
    var dataToSubmitID:String?
    var dataToSubmitNumber:Int?
    var complex:Complex?
    var complexLocalBD : PE_Customer?
    var customer:Customer?
    var siteName:String?
    var siteId:Int?
    var statusType:Int?
    var evaluationDate:String?
    var evaluatorName : String?
    var evaluatorID:Int?
    var visitName : String?
    var visitID:Int?
    var evaluationName : String?
    var evaluationID:Int?
    var qcCount: String?
    var isHandMix: Bool?
    var sanitationValue: Bool?
    var ppmValue: String?
    
    var isChlorineStrip: Int?
    var quarter: String?
    var year: Int?
    
    var ampmValue: String?
    var frequency: String?
    var personName:String?
    
    var approver :  String?
    var rejectionComment: String?
    var notes :  String?
    var hatcheryAntibiotics :Int?
    var hatcheryAntibioticsDoaS :Int?
    var hatcheryAntibioticsDoa :Int?
    var isAutomaticFail: Int?
    
    var hatcheryAntibioticsText:String?
    var hatcheryAntibioticsDoaText:String?
    var hatcheryAntibioticsDoaSText:String?
    var sanitationEmbrex: Int?
    var camera :Int?
    var isFlopSelected :Int?
    var breedOfBird:String?
    var breedOfBirdOther:String?
    var incubation:String?
    var incubationOthers:String?
    var note:String?
    var cID: Int?
    var catID: Int?
    var titleName : String?
    var isOpened = false
    
    var catName: String?
    var catMaxMark: Int?
    var catResultMark: Int?
    var catEvaluationID: Int?
    var catISSelected:Int?
    var assID: Int?
    var assDetail1: String?
    var informationText:String?
    var informationImage:String?
    var assDetail2: String?
    var assMinScore: Int?
    var assMaxScore: Int?
    var assCatType: String?
    var assModuleCatID: Int?
    var assModuleCatName: String?
    var noOfEggs: Int64?
    var manufacturer: String?
    var sig: Int?
    var sig2: Int?
    var sig_Date: String?
    var sig_EmpID: String?
    var sig_EmpID2: String?
    var sig_Name: String?
    var sig_Name2: String?
    var sig_Phone: String?
    var iCS: String?
    var iDT: String?
    var dCS: String?
    var dDT: String?
    var dDCS: String?
    var dDDT: String?
    var FSTSignatureImage : String?
    // PE International Chnages New Addition 
    var countryID:Int?
    var countryName : String?
    var fluid : Bool?
    var basicTransfer : Bool?
    var extndMicro : Bool?
    var clorineId:Int?
    var clorineName : String?
    var IsEMRequested : Bool?
    
    var isPERejected: Bool?
    var isEMRejected: Bool?
    var emRejectedComment : String?
    
    var images:[Int] = []
    var doa:[Int] = []
     var doaS:[Int] = []
    var inovoject:[Int] = []
    var vMixer:[Int] = []
    var assStatus:Int?
    var evalType : EvaluationType?
    var Evaluator : Evaluator?
    var reasonForVisit : VisitType?
    var peCategoriesAssesmentsResponseDraft : PECategoriesAssesmentsResponse?
    var peCategoriesAssesmentsResponseFinalize : PECategoriesAssesmentsResponse?
}


public class PECertificateData: NSObject {
    var id : Int?
    var name: String?
    var certificateDate: String?
    var isCertExpired: Bool?
    var isReCert: Bool?
    var signatureImg: String
    var vacOperatorId: Int?
    var isSigned = false
    var fsrSign = ""
    
    
     
    init(id:Int,name:String,date:String,isCertExpired:Bool,isReCert:Bool,vacOperatorId:Int,signatureImg:String , fsrSign : String) {
        self.id = id
        self.name = name
        self.certificateDate = date
        self.isCertExpired = isCertExpired
        self.isReCert = isReCert
        self.signatureImg = signatureImg
        self.vacOperatorId = vacOperatorId
        self.fsrSign = fsrSign
    }
}


public class InovojectData: NSObject {
    var id:Int?
    var vaccineMan: String?
    var name: String?
    
    var ampuleSize: String?
    var ampulePerBag: String?
    var bagSizeType:String?
    var dosage:String?
    var dilute:String?
    
    var invoHatchAntibiotic:Int = 0
    var invoHatchAntibioticText:String = ""
    var invoProgramName:String = ""
    var doaDilManOther:String = ""
    
    init(id:Int,vaccineMan:String,name:String,ampuleSize:String,ampulePerBag:String,bagSizeType:String,dosage:String,dilute:String, invoHatchAntibiotic:Int? = 0, invoHatchAntibioticText:String? = "", invoProgramName:String? = "",doaDilManOther:String? = ""){
        self.id = id
        self.vaccineMan = vaccineMan
        self.name = name
        self.ampuleSize = ampuleSize
        self.ampulePerBag = ampulePerBag
        self.bagSizeType = bagSizeType
        self.dosage = dosage
        self.dilute = dilute
      
        self.invoHatchAntibiotic = invoHatchAntibiotic ?? 0
        self.invoHatchAntibioticText = invoHatchAntibioticText ?? ""
        self.invoProgramName = invoProgramName ?? ""
        self.doaDilManOther = doaDilManOther  ?? ""
    }
}

public class PE_Refrigators: NSObject {
    var id : NSNumber?
    var labelText: String?
    var rollOut: String?
    var unit: String?
    var value: Double?
    var catID: NSNumber?
    var isCheck: Bool?
    var isNA: Bool?
    var schAssmentId:Int?
   
    init(id:NSNumber,labelText:String,rollOut:String,unit:String,value:Double,catID:NSNumber,isCheck:Bool , isNA : Bool,schAssmentId : Int) {
        self.id = id
        self.labelText = labelText
        self.rollOut = rollOut
        self.unit = unit
        self.value = value
        self.catID = catID
        self.isCheck = isCheck
        self.isNA = isNA
        self.schAssmentId = schAssmentId
    }
}
