//
//  HttpServiceHelper.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 26/01/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import Alamofire

class HttpServiceHelper: NSObject {
    
    var username: String = ""
    static let sharedInstance = HttpServiceHelper()
    
    func sendData(myData: Data, username: String, count: Int, url: String, namingFile: String!, onCompletion:@escaping (GenericResponse)-> Void) {
        
        let parameters = ["username": username]
        var nameFile = "image"
        var typeFile = "image/jpg"
        var currFileName = username + String(count) + ".jpg"
        
        if(count == -1) {   //send file pdf/doc...
            nameFile = "doc"
            typeFile = "application/pdf"
            currFileName = namingFile
        }
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(myData, withName: nameFile,fileName: currFileName, mimeType: typeFile)
            
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to: url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseString { response in
                    print("respooonse: \(response)")
                    
                    let genericResponse = GenericResponse(JSONString: response.result.value!)
                    /*guard let genericResponse = GenericResponse(JSONString: response.result.value!) else {
                        
                        //throw Error.i
                    } */
                    
                    onCompletion(genericResponse!)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
    
    func getDocsForUser(username: String, onCompletion:@escaping (User)-> Void) {
        
        let parameters: Parameters = ["username": username]
        
        Alamofire.request(BASE_URL + END_POINT_GET_USER_DOCS, method: .get, parameters: parameters, encoding: URLEncoding.default).responseString { (response) in
            
            let user = User(JSONString: response.result.value!)
            
            onCompletion(user!)
        }
    }
}
