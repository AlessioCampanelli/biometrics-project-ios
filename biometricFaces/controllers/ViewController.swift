//
//  ViewController.swift
//  biometricFaces
//
//  Created by Me Developer on 27/12/17.
//  Copyright © 2017 Me Developer. All rights reserved.
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
        
        HttpServiceHelper.sharedInstance.username = self.usernameTextField.text!.lowercased()
        
        if(segue.identifier == "faceRecognitionSegue") {
            let faceRecognitionVC :FaceRecognitionViewController = segue.destination as! FaceRecognitionViewController
            faceRecognitionVC.username = usernameTextField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.usernameTextField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func doLoginAction(_ sender: Any) {
        
        if(!(self.usernameTextField.text?.isEmpty)! && self.usernameTextField.text != nil){
            self.performSegue(withIdentifier: "faceRecognitionSegue", sender: nil)
        }else{
            let alert = UIAlertController(title: "Ops!", message: "enter username before logging", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func configFaceAction(_ sender: Any) {
        if(!(self.usernameTextField.text?.isEmpty)! && self.usernameTextField.text != nil){
            self.performSegue(withIdentifier: "registerFaceSegue", sender: nil)
        }else {
            let alert = UIAlertController(title: "Ops!", message: "Choose username befor registering", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

