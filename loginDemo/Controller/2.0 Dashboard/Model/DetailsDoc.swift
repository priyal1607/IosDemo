//
//	DetailsDoc.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class DetailsDoc : NSObject{

	var docImg : String!
	var docName : String!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		docImg = dictionary["doc_img"] as? String
		docName = dictionary["doc_name"] as? String
	}
}
