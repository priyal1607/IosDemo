//
//  GalleryDetailsModel.swift
//  KhelSathi
//
//  Created by Gunjan on 28/06/23.
//

import UIKit

class GalleryDetailsModel: NSObject {
    var id:String = ""
    var category_id:String = ""
    var image:String = ""
    var status:String = ""
    var created_at:String = ""
    var created_by:String = ""
    var updated_at:String = ""
    var updated_by:String = ""
    
    
    init(dict:DICTIONARY) {
        id = getString(anything: dict["id"])
        category_id = getString(anything: dict["category_id"])
        image = getString(anything: dict["image"])
        status = getString(anything: dict["status"])
        created_at = getString(anything: dict["created_at"])
        created_by = getString(anything: dict["created_by"])
        updated_at = getString(anything: dict["updated_at"])
        updated_by = getString(anything: dict["updated_by"])
        
    }
        
}
