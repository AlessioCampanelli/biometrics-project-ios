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
    
    func sendPhoto(myPhoto: UIImage, username: String, count: Int, url: String, onCompletion:@escaping (Any)-> Void) {
        
        let imgData = UIImageJPEGRepresentation(myPhoto, 0.2)!
        
        let parameters = ["username": username]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image",fileName: username + String(count) + ".jpg", mimeType: "image/jpg")  // fileset
            
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
                
                upload.responseJSON { response in
                    print("respooonse: \(response)")  // response.result.value
                    onCompletion(response)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
