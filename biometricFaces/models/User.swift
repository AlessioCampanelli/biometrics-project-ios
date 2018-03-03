//
//  User.swift
//  biometricFaces
//
//  Created by Me Developer on 03/02/18.
//  Copyright © 2018 Me Developer. All rights reserved.
//

import UIKit
import ObjectMapper

class User: GenericResponse {
    
    //var status: String?
    //var message: String?
    var listDocument: [String]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        listDocument <- map["listDocument"]
    }
}
