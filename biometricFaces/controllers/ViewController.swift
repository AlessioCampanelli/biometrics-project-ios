//
//  ViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 27/12/17.
//  Copyright © 2017 Alessio Campanelli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "faceRecognitionSegue") {
            let faceRecognitionVC :FaceRecognitionViewController = segue.destination as! FaceRecognitionViewController
            faceRecognitionVC.username = usernameTextField.text
        }
    }
}

