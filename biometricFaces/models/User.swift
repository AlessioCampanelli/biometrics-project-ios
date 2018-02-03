//
//  User.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 03/02/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    
    var status: String?
    var message: String?
    var listDocument: [String]?
    
    required init?(map: Map) {

    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        listDocument <- map["listDocument"]
    }
}
