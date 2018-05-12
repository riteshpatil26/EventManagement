//
//  RoundedImage.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        if self.frame.width>0 && self.frame.height>0 {
            //self.translatesAutoresizingMaskIntoConstraints = true
            self.clipsToBounds = true
            self.layer.cornerRadius = self.frame.width/2
            //self.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
