//
//  FaceRecognitionViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 28/01/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FaceRecognitionViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePicker: UIImagePickerController!
    var httpServiceHelper: HttpServiceHelper!
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takePhoto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Take image
    func takePhoto() {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        let currentUsername = HttpServiceHelper.sharedInstance.username
        let myPhoto = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        let imageData =  UIImageJPEGRepresentation(myPhoto, 0.2)!
        
        HttpServiceHelper.sharedInstance.sendData(myData: imageData , username: currentUsername, count: 4, url: BASE_URL + END_POINT_FACE_RECOGNITION, namingFile:nil) { (response) in
            
            if(response.status == SUCCESS_RESPONSE) {
                self.performSegue(withIdentifier: "showDocumentSegue", sender: self)
            }else{
                let alert = UIAlertController(title: "Ops!", message: response.message, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.takePhoto()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
