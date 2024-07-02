
struct LoginModel : Codable {

    let address : String?
    let age : String?
    let dept : String?
    let dob : String?
    let docs : [LoginDocs]?
    let gender : String?
    let id : String?
    let image : String?
    let name : String?
    let phoneNumber : String?
    let semFiveGrade : String?
    let semFourGrade : String?
    let semOneGrade : String?
    let semSixGrade : String?
    let semThreeGrade : String?
    let semTwoGrade : String?
    let sportsName : String?
    let studentId : String?


    enum CodingKeys: String, CodingKey {
        case address = "address"
        case age = "age"
        case dept = "dept"
        case dob = "dob"
        case docs = "docs"
        case gender = "gender"
        case id = "id"
        case image = "image"
        case name = "name"
        case phoneNumber = "phone_number"
        case semFiveGrade = "sem_five_grade"
        case semFourGrade = "sem_four_grade"
        case semOneGrade = "sem_one_grade"
        case semSixGrade = "sem_six_grade"
        case semThreeGrade = "sem_three_grade"
        case semTwoGrade = "sem_two_grade"
        case sportsName = "sports_name"
        case studentId = "student_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        dept = try values.decodeIfPresent(String.self, forKey: .dept)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        docs = try values.decodeIfPresent([LoginDocs].self, forKey: .docs)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber)
        semFiveGrade = try values.decodeIfPresent(String.self, forKey: .semFiveGrade)
        semFourGrade = try values.decodeIfPresent(String.self, forKey: .semFourGrade)
        semOneGrade = try values.decodeIfPresent(String.self, forKey: .semOneGrade)
        semSixGrade = try values.decodeIfPresent(String.self, forKey: .semSixGrade)
        semThreeGrade = try values.decodeIfPresent(String.self, forKey: .semThreeGrade)
        semTwoGrade = try values.decodeIfPresent(String.self, forKey: .semTwoGrade)
        sportsName = try values.decodeIfPresent(String.self, forKey: .sportsName)
        studentId = try values.decodeIfPresent(String.self, forKey: .studentId)
    }
}
