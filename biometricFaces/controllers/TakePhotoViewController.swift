//
//  TakePhotoViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 26/01/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import Alamofire

class TakePhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePicker: UIImagePickerController!
    @IBOutlet weak var imageTake: UIImageView!
    
    @IBOutlet weak var buttonTakeASelfie: UIButton!
    
    var httpServiceHelper: HttpServiceHelper!
    var count: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.takePhoto(self.buttonTakeASelfie)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
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
        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        
        var endPoint = END_POINT_SEND_PHOTOS
        if(count == 4) {
            endPoint = END_POINT_FACE_RECOGNITION
        }
        
        let currentUsername = HttpServiceHelper.sharedInstance.username
        let myPhoto = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        let imageData =  UIImageJPEGRepresentation(myPhoto, 0.2)!
        
        HttpServiceHelper.sharedInstance.sendData(myData: imageData, username: currentUsername, count: count, url: BASE_URL + endPoint, namingFile:nil) { (response) in
            
            if(self.count == 4) {   //photo for recognition face
                let alert = UIAlertController(title: "Good!", message: "Now your face is registered!!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                return;
            }
            
             let alert = UIAlertController(title: "Configuration", message: "photo n° \(self.count) correctly acquired. \n Take another photo please!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.count = self.count + 1
                self.takePhoto(self.buttonTakeASelfie)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
