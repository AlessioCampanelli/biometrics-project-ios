//
//  DetailDocViewController.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 03/02/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit
import WebKit

class DetailDocViewController: UIViewController {

    var urlToLoad: String!
    
    @IBOutlet weak var detailDocWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var urlTemp = BASE_URL + FOLDER_FILES + urlToLoad
        urlTemp = urlTemp.replacingOccurrences(of: " ", with: "%20")
        
        let urlWebKit = URL.init(string: urlTemp)
        
        if(urlWebKit != nil) {
            let req = URLRequest.init(url: urlWebKit!)
            self.detailDocWebView.load(req)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
