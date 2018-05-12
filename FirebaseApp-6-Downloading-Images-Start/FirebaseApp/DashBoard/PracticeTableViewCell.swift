//
//  PracticeTableViewCell.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/27/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {

    @IBOutlet weak var practiceName: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
