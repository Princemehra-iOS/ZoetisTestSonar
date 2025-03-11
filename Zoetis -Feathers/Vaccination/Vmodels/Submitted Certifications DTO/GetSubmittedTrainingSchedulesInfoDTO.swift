import Foundation
class GetSubmittedTrainingSchedulesInfoDTO: Codable {
    var isDeleted: Bool?
    var isMicrobial: JSONNull?
    var trainingStatusID: Int?
    var schDate, peApproverID: JSONNull?
    var operatorCertificate: Bool?
    var peSaveTypeID: JSONNull?
    var certificateTypeID, trainingStatus: Int?
    var evaluationStatus, peStatusID: JSONNull?
    var scheduleDate, hatcheryManagerSignature: String?
    var approverID: Int?
    var quarter: JSONNull?
    var isTshirtPrinted: Bool?
    var approvedRejectedByID: Int?
    var id: Int?
    var hatcheryManagerSignatureBase64, certificateType, fsrSignatureBase64, customerName: String?
    var assignToName: String?
    var assingToID: Int?
    var gpColleagueJobTitle: String?
    var status, existingSite: Bool?
    var score: JSONNull?
    var isAcknowledge: Bool?
    var custShipping: String?
    var customerID: Int?
    var siteName: String?
    var createdBy: Int?
    var gpSupervisorJobTitle: String?
    var siteID: Int?
    var gpSupervisorName: String?
    var createdDate, trainingType, submitedDate: String?
    var sanitationEmbrex: Bool?
    var roleID: Int??
    var fsrSignature: String?
    var pEevaluationTypeID : JSONNull?
    var gpColleagueName : String?
    var hatcheryManagerName, approverName, deviceID: String?
    var comments, peVisitTypeID: JSONNull?
    var certification_Type_Id : Int?
    var approvedRejectedDate: String?
    
    enum CodingKeys: String, CodingKey {
        case isDeleted = "IsDeleted"
        case isMicrobial = "IsMicrobial"
        case trainingStatusID = "TrainingStatusId"
        case schDate = "SchDate"
        case peApproverID = "PEApproverId"
        case operatorCertificate = "OperatorCertificate"
        case peSaveTypeID = "PeSaveTypeId"
        case certificateTypeID = "CertificateTypeId"
        case trainingStatus = "TrainingStatus"
        case evaluationStatus = "EvaluationStatus"
        case peStatusID = "PeStatusId"
        case scheduleDate = "ScheduleDate"
        case hatcheryManagerSignature = "HatcheryManagerSignature"
        case approverID = "ApproverId"
        case quarter = "Quarter"
        case isTshirtPrinted = "IsTshirtPrinted"
        case approvedRejectedByID = "ApprovedRejectedById"
        case id = "Id"
        case hatcheryManagerSignatureBase64 = "HatcheryManagerSignatureBase64"
        case certificateType = "CertificateType"
        case fsrSignatureBase64 = "FSRSignatureBase64"
        case customerName = "CustomerName"
        case assignToName = "AssignToName"
        case assingToID = "AssingToId"
        case gpColleagueJobTitle = "GpColleagueJobTitle"
        case status = "Status"
        case existingSite = "ExistingSite"
        case score = "Score"
        case isAcknowledge = "IsAcknowledge"
        case custShipping = "CustShipping"
        case customerID = "CustomerId"
        case siteName = "SiteName"
        case createdBy = "CreatedBy"
        case gpSupervisorJobTitle = "GpSupervisorJobTitle"
        case siteID = "SiteId"
        case gpSupervisorName = "GpSupervisorName"
        case createdDate = "CreatedDate"
        case trainingType = "TrainingType"
        case submitedDate = "SubmitedDate"
        case sanitationEmbrex = "Sanitation_Embrex"
        case roleID = "RoleId"
        case fsrSignature = "FSRSignature"
        case pEevaluationTypeID = "PEevaluationTypeId"
        case gpColleagueName = "GpColleagueName"
        case hatcheryManagerName = "HatcheryManagerName"
        case approverName = "ApproverName"
        case deviceID = "DeviceId"
        case approvedRejectedDate = "ApprovedRejectedDate"
        case comments = "Comments"
        case peVisitTypeID = "PEVisitTypeId"
        case certification_Type_Id = "Cretification_Type_Id"
    }

    init(isDeleted: Bool?, isMicrobial: JSONNull?, trainingStatusID: Int?, schDate: JSONNull?, peApproverID: JSONNull?, operatorCertificate: Bool?, peSaveTypeID: JSONNull?, certificateTypeID: Int?, trainingStatus: Int?, evaluationStatus: JSONNull?, peStatusID: JSONNull?, scheduleDate: String?, hatcheryManagerSignature: String?, approverID: Int?, quarter: JSONNull?, isTshirtPrinted: Bool?, approvedRejectedByID: Int?, id: Int?, hatcheryManagerSignatureBase64: String?, certificateType: String?, fsrSignatureBase64: String?, customerName: String?, assignToName: String?, assingToID: Int?, gpColleagueJobTitle: String?, status: Bool?, existingSite: Bool?, score: JSONNull?, isAcknowledge: Bool?, custShipping: String?, customerID: Int?, siteName: String?, createdBy: Int?, gpSupervisorJobTitle: String?, siteID: Int?, gpSupervisorName: String?, createdDate: String?, trainingType: String?, submitedDate: String?, sanitationEmbrex: Bool?, roleID: Int?, fsrSignature: String?, pEevaluationTypeID: JSONNull?, gpColleagueName: String?, hatcheryManagerName: String?, approverName: String?, deviceID: String?, approvedRejectedDate: String?, comments: JSONNull?, peVisitTypeID: JSONNull?, certification_Type_Id : Int?) {
        self.isDeleted = isDeleted
        self.isMicrobial = isMicrobial
        self.trainingStatusID = trainingStatusID
        self.schDate = schDate
        self.peApproverID = peApproverID
        self.operatorCertificate = operatorCertificate
        self.peSaveTypeID = peSaveTypeID
        self.certificateTypeID = certificateTypeID
        self.trainingStatus = trainingStatus
        self.evaluationStatus = evaluationStatus
        self.peStatusID = peStatusID
        self.scheduleDate = scheduleDate
        self.hatcheryManagerSignature = hatcheryManagerSignature
        self.approverID = approverID
        self.quarter = quarter
        self.isTshirtPrinted = isTshirtPrinted
        self.approvedRejectedByID = approvedRejectedByID
        self.id = id
        self.hatcheryManagerSignatureBase64 = hatcheryManagerSignatureBase64
        self.certificateType = certificateType
        self.fsrSignatureBase64 = fsrSignatureBase64
        self.customerName = customerName
        self.assignToName = assignToName
        self.assingToID = assingToID
        self.gpColleagueJobTitle = gpColleagueJobTitle
        self.status = status
        self.existingSite = existingSite
        self.score = score
        self.isAcknowledge = isAcknowledge
        self.custShipping = custShipping
        self.customerID = customerID
        self.siteName = siteName
        self.createdBy = createdBy
        self.gpSupervisorJobTitle = gpSupervisorJobTitle
        self.siteID = siteID
        self.gpSupervisorName = gpSupervisorName
        self.createdDate = createdDate
        self.trainingType = trainingType
        self.submitedDate = submitedDate
        self.sanitationEmbrex = sanitationEmbrex
        self.roleID = roleID
        self.fsrSignature = fsrSignature
        self.pEevaluationTypeID = pEevaluationTypeID
        self.gpColleagueName = gpColleagueName
        self.hatcheryManagerName = hatcheryManagerName
        self.approverName = approverName
        self.deviceID = deviceID
        self.approvedRejectedDate = approvedRejectedDate
        self.comments = comments
        self.peVisitTypeID = peVisitTypeID
        self.certification_Type_Id = certification_Type_Id
    }
}
