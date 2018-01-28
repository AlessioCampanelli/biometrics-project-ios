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
    var httpServiceHelper: HttpServiceHelper!
    var count: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        
        httpServiceHelper = HttpServiceHelper();
        
        var endPoint = END_POINT_SEND_PHOTOS
        if(count == 4) {
            endPoint = END_POINT_FACE_RECOGNITION
        }
        
        //httpServiceHelper.sendPhoto(myPhoto: imageTake.image!, username: "alessio", count: count, url: BASE_URL + endPoint)
        
        httpServiceHelper.sendPhoto(myPhoto: (info[UIImagePickerControllerOriginalImage] as? UIImage)!, username: "alessio", count: count, url: BASE_URL + endPoint) { (response) in
            
            
            self.count = self.count + 1
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
