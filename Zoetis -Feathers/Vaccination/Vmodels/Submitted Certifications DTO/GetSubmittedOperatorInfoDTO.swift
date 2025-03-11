import Foundation

class GetSubmittedOperatorInfoDTO: Codable {
    var customerName: JSONNull?
    var languageName: String?
    var roles: [GetSubmittedRolesDTO]?
    var middleName: String?
    var certificateTypeList: [JSONAny]?
    var tshirtSize: String?
    var tshirtSizeID: Int?
    var certificateDate: JSONNull?
    var languageID, siteID: Int?
    var isSelected: Bool?
    var firstName, lastName: String?
    var hatcheryName: JSONNull?
    var categoriesList: String?
    var fromDate: String?
    var signatureBase64, operatorUniqueID: String?
    var customerID: Int?
    var signatureFilePath: String?
    var certificateName: JSONNull?
    var id: Int?
    var isRemoved: Bool?
    var signatureFileName: String?
    var toDate: JSONNull?

    enum CodingKeys: String, CodingKey {
        case customerName = "CustomerName"
        case languageName = "LanguageName"
        case roles = "Roles"
        case middleName = "MiddleName"
        case certificateTypeList = "CertificateTypeList"
        case tshirtSize = "TshirtSize"
        case tshirtSizeID = "TshirtSizeId"
        case certificateDate = "CertificateDate"
        case languageID = "LanguageId"
        case siteID = "SiteId"
        case isSelected = "IsSelected"
        case firstName = "FirstName"
        case lastName = "LastName"
        case hatcheryName = "HatcheryName"
        case categoriesList = "CategoriesList"
        case fromDate = "FromDate"
        case signatureBase64 = "SignatureBase64"
        case operatorUniqueID = "OperatorUniqueId"
        case customerID = "CustomerId"
        case signatureFilePath = "SignatureFilePath"
        case certificateName = "CertificateName"
        case id = "Id"
        case isRemoved = "IsRemoved"
        case signatureFileName = "SignatureFileName"
        case toDate = "ToDate"
    }

    init(customerName: JSONNull?, languageName: String?, roles: [GetSubmittedRolesDTO]?, middleName: String?, certificateTypeList: [JSONAny]?, tshirtSize: String?, tshirtSizeID: Int?, certificateDate: JSONNull?, languageID: Int?, siteID: Int?, isSelected: Bool?, firstName: String?, lastName: String?, hatcheryName: JSONNull?, categoriesList: String?, fromDate: String?, signatureBase64: String?, operatorUniqueID: String?, customerID: Int?, signatureFilePath: String?, certificateName: JSONNull?, id: Int?, isRemoved: Bool?, signatureFileName: String?, toDate: JSONNull?) {
        self.customerName = customerName
        self.languageName = languageName
        self.roles = roles
        self.middleName = middleName
        self.certificateTypeList = certificateTypeList
        self.tshirtSize = tshirtSize
        self.tshirtSizeID = tshirtSizeID
        self.certificateDate = certificateDate
        self.languageID = languageID
        self.siteID = siteID
        self.isSelected = isSelected
        self.firstName = firstName
        self.lastName = lastName
        self.hatcheryName = hatcheryName
        self.categoriesList = categoriesList
        self.fromDate = fromDate
        self.signatureBase64 = signatureBase64
        self.operatorUniqueID = operatorUniqueID
        self.customerID = customerID
        self.signatureFilePath = signatureFilePath
        self.certificateName = certificateName
        self.id = id
        self.isRemoved = isRemoved
        self.signatureFileName = signatureFileName
        self.toDate = toDate
    }
}
