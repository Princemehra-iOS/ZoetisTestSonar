
import Foundation
class OperatorInfoDTO : Codable {
	var Id : Int64?
	var FirstName : String?
	var MiddleName : String?
	var LastName : String?
	var Roles : [RolesTransferDTO]?
	var CustomerId : Int64?
	var SiteId : Int64?
    var FromDate:String?
    var CreatedBy:Int64?
    var LanguageId:Int64?
    var TshirtSizeId:Int64?
    var OperatorSignature:String?
    var OperatorUniqueId:String?
}

class ShippingAddressDTO: Codable {
    var fssName: String?
    var fssID, trainingID, id: Int?
    var city, address2: String?
    var stateID, countryID: Int?
    var address1, pincode: String?

    enum CodingKeys: String, CodingKey {
        case fssName = "FSSName"
        case fssID = "FSSId"
        case trainingID = "TrainingId"
        case id = "Id"
        case city = "City"
        case address2 = "Address2"
        case stateID = "StateId"
        case countryID = "CountryId"
        case address1 = "Address1"
        case pincode = "Pincode"
    }

    init(fssName: String?, fssID: Int?, trainingID: Int?, id: Int?, city: String?, address2: String?, stateID: Int?, countryID: Int?, address1: String?, pincode: String?) {
        self.fssName = fssName
        self.fssID = fssID
        self.trainingID = trainingID
        self.id = id
        self.city = city
        self.address2 = address2
        self.stateID = stateID
        self.countryID = countryID
        self.address1 = address1
        self.pincode = pincode
    }
}
