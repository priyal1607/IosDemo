//
//  LoginDocs.swift
//  loginDemo
//
//  Created by Chelsi on 17/05/23.
//


import Foundation

struct LoginDocs : Codable {

    let docImg : String?
    let docName : String?


    enum CodingKeys: String, CodingKey {
        case docImg = "doc_img"
        case docName = "doc_name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docImg = try values.decodeIfPresent(String.self, forKey: .docImg)
        docName = try values.decodeIfPresent(String.self, forKey: .docName)
    }

}
