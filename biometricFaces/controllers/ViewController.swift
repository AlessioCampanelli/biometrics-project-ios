//
//  ViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 27/12/17.
//  Copyright © 2017 Alessio Campanelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        HttpServiceHelper.sharedInstance.username = self.usernameTextField.text!
        
        if(segue.identifier == "faceRecognitionSegue") {
            let faceRecognitionVC :FaceRecognitionViewController = segue.destination as! FaceRecognitionViewController
            faceRecognitionVC.username = usernameTextField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.resignFirstResponder()
        return true
    }
}

