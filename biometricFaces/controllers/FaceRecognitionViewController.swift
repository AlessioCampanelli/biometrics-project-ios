//
//  FaceRecognitionViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 28/01/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import Alamofire

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
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK: - Add image to Library
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        /*if let error = error {
         // we got back an error!
         let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
         } else {
         let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
         ac.addAction(UIAlertAction(title: "OK", style: .default))
         present(ac, animated: true)
         } */
    }
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        //httpServiceHelper = HttpServiceHelper();
        //httpServiceHelper.sendPhoto(myPhoto: (info[UIImagePickerControllerOriginalImage] as? UIImage)!, username: "alessio", count: 4, url: BASE_URL + "doFaceRecognition")
        
        let currentUsername = HttpServiceHelper.sharedInstance.username
        HttpServiceHelper.sharedInstance.sendPhoto(myPhoto: (info[UIImagePickerControllerOriginalImage] as? UIImage)!, username: currentUsername, count: 4, url: BASE_URL + END_POINT_FACE_RECOGNITION) { (response) in
            
            
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
