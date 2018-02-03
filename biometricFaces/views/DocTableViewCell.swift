//
//  DocTableViewCell.swift
//  biometricFaces
//
//  Created by Alessio Campanelli on 03/02/18.
//  Copyright © 2018 Alessio Campanelli. All rights reserved.
//

import UIKit

class DocTableViewCell: UITableViewCell {

    @IBOutlet weak var titleDoc: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
