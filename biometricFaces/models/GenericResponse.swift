//
//  genericResponse.swift
//  biometricFaces
//
//  Created by Me Developer on 03/02/18.
//  Copyright © 2018 Me Developer. All rights reserved.
//

import UIKit
import ObjectMapper

class GenericResponse: Mappable {

    var status: String?
    var message: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
}
