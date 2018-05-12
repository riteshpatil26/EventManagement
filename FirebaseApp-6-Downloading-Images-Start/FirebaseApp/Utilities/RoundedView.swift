//
//  RoundedLabel.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var isBorder: Bool = true
    @IBInspectable var setBorderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = setBorderColor.cgColor
        }
    }
    @IBInspectable var setBorderWidth: CGFloat = 3.0 {
        didSet {
            self.layer.borderWidth = setBorderWidth;
        }
    }
    
    
    override func layoutSubviews() {
        
        PrintData.printData(data: "RoundedView = \(self.frame.width)  \(self.frame.height)")
        if self.frame.width>0 && self.frame.height>0 {
            if isBorder{
                //self.translatesAutoresizingMaskIntoConstraints = true
                self.clipsToBounds = true
                self.layer.cornerRadius = self.frame.width/2
                //self.translatesAutoresizingMaskIntoConstraints = false
            }
            else{
                //self.translatesAutoresizingMaskIntoConstraints = true
                self.clipsToBounds = true
                self.layer.cornerRadius = self.frame.width/2
                //self.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        
    }
    
}
