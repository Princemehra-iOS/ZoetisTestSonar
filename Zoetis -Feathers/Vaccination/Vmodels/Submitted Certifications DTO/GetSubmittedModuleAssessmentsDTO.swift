import Foundation

class GetSubmittedModuleAssessmentsDTO: Codable {
    var assessment2: JSONNull?
    var types: String?
   // var types: Types?
    var locationPhone: JSONNull?
    var comments: String?
    var sequenceNo: Int?
    var moduleCatID, recordID: Int?
    var assessment: String?
    var answer: Bool?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case assessment2 = "Assessment2"
        case types = "Types"
        case locationPhone = "LocationPhone"
        case comments = "Comments"
        case sequenceNo = "SequenceNo"
        case moduleCatID = "ModuleCatId"
        case recordID = "recordId"
        case assessment = "Assessment"
        case answer = "Answer"
        case id = "Id"
    }

    init(assessment2: JSONNull?, types: String?, locationPhone: JSONNull?, comments: String?, sequenceNo: Int?, moduleCatID: Int?, recordID: Int?, assessment: String?, answer: Bool?, id: Int?) {
        self.assessment2 = assessment2
        self.types = types
        self.locationPhone = locationPhone
        self.comments = comments
        self.sequenceNo = sequenceNo
        self.moduleCatID = moduleCatID
        self.recordID = recordID
        self.assessment = assessment
        self.answer = answer
        self.id = id
    }
}

enum Types: String, Codable {
    case numeric = "Numeric"
    case yesNo = "Yes/No"
}
