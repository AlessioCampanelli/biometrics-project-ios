//
//  DocManagerViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 03/02/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import MobileCoreServices
import SwiftyJSON
import ObjectMapper

class DocManagerViewController: UIViewController, UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var user: User!
    var selectedDoc: String!
    
    @IBOutlet weak var tableViewDoc: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.tableViewDoc.tableFooterView = UIView()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.refreshData()
    }

    func refreshData() {
        HttpServiceHelper.sharedInstance.getDocsForUser(username: HttpServiceHelper.sharedInstance.username) { (response) in
            
            self.user = response
            self.tableViewDoc.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Document Picker Delegate
    
    func documentMenu(_ documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        print("urls: \(urls)")
        let path = urls[0].path
        let dataFile = FileManager.default.contents(atPath: path)
        
        print("data local file:" + urls[0].lastPathComponent)
        
        let currentUsername = HttpServiceHelper.sharedInstance.username
        
        HttpServiceHelper.sharedInstance.sendData(myData: dataFile!, username: currentUsername, count: -1, url: BASE_URL + END_POINT_INSERT_USER_DOCS, namingFile: urls[0].lastPathComponent) { (response) in

            let alert = UIAlertController(title: response.status, message: response.message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in

                self.refreshData()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.user != nil) {
            return (self.user.listDocument?.count)! + 1
        }
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == (self.user.listDocument?.count)!) {
            
            let addButtonCell: AddDocButtonTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addDocButtonCell") as! AddDocButtonTableViewCell
            
            addButtonCell.addDocButton.addTarget(self, action: #selector(DocManagerViewController.openFile(sender:)), for: .touchUpInside)
            
            return addButtonCell
        }
        
        let docCell: DocTableViewCell = tableView.dequeueReusableCell(withIdentifier: "docCell") as! DocTableViewCell
        docCell.titleDoc.text = self.user.listDocument![indexPath.row]
        
        return docCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(self.user.listDocument?.isEmpty == false){
            self.selectedDoc = self.user.listDocument![indexPath.row]
            self.performSegue(withIdentifier: "showDetailDoc", sender: self)
        }
    }
    
    @objc func openFile(sender: UIButton) {
        
        let types: NSArray = NSArray(object: "public.item")
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: types as! [String], in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showDetailDoc") {
            
            let detailVC = segue.destination as! DetailDocViewController
            detailVC.urlToLoad = self.selectedDoc
        }
    }
}
