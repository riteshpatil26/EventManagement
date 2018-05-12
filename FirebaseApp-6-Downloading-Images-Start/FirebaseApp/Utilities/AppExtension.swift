//  
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

var SCREEN_WIDTH  = UIScreen.main.bounds.width
var SCREEN_HEIGHT  = UIScreen.main.bounds.height
var SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)

var IS_IPHONE_4_OR_LESS = (SCREEN_MAX_LENGTH < 568.0) ? true : false
var IS_IPHONE_5 = (SCREEN_MAX_LENGTH == 568.0) ? true : false
var IS_IPHONE_6 =  (SCREEN_MAX_LENGTH == 667.0) ? true : false
var IS_IPHONE_6P =  (SCREEN_MAX_LENGTH == 736.0) ? true : false


///*************************** Extension for viewController *********************************

// MARK: Adjust UILabel font size according to device screen size Extention

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
    
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
        
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }

    
   
    
    
    
}






extension UILabel {
    /// This method set Font size according to phone model
    ///
    /// - AppHelper.swift

    @IBInspectable var adjustFontSize: Bool{
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                
                if IS_IPHONE_4_OR_LESS {
                    sizeScale = 0.8 //not Tested yet
                }
                else if IS_IPHONE_5 {
                    sizeScale = 1.0
                }
                else if IS_IPHONE_6 {
                    sizeScale = 1.25
                }
                else if IS_IPHONE_6P {
                    sizeScale = 1.35
                }
                
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }        }
        
        get {
            return false
        }
    }
    
    
    
}

extension UIButton {
    /// This method set Font size according to phone model
    ///
    /// - AppHelper.swift
    
    @IBInspectable var adjustFontSize: Bool{
        set {
            if newValue {
                let currentFont = self.titleLabel?.font
                var sizeScale: CGFloat = 1
                
                if IS_IPHONE_4_OR_LESS {
                    sizeScale = 0.8 //not Tested yet
                }
                else if IS_IPHONE_5 {
                    sizeScale = 1.0
                }
                else if IS_IPHONE_6 {
                    sizeScale = 1.25
                }
                else if IS_IPHONE_6P {
                    sizeScale = 1.35
                }
                
                self.titleLabel?.font = (currentFont?.withSize((currentFont?.pointSize)! * sizeScale))!
            }        }
        
        get {
            return false
        }
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    override open func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        self.isHighlighted = false
        super.touchesCancelled(touches!, with: event)
    }
    
    
}



//MARK: Adjust UITextView Font size according to device screen size Extension
extension UITextView {
    /// This method set Font size according to phone model
    ///
    /// - AppHelper.swift
    
    @IBInspectable var adjustFontSize: Bool{
        set {
            if newValue {
                var currentFont = self.font
                var sizeScale: CGFloat = 1
                
                if IS_IPHONE_4_OR_LESS {
                    sizeScale = 0.8 //not Tested yet
                }
                else if IS_IPHONE_5 {
                    sizeScale = 1.0
                }
                else if IS_IPHONE_6 {
                    sizeScale = 1.25
                }
                else if IS_IPHONE_6P {
                    sizeScale = 1.35
                }
                
                self.font = currentFont!.withSize(currentFont!.pointSize * sizeScale)
            }        }
        
        get {
            return false
        }
    }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
        UIMenuController.shared.isMenuVisible = false
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
}



// MARK: Adjust UITextField font size according to device screen size Extention

extension UITextField {

    /// This method set Font size according to phone model
    ///
    /// - AppHelper.swift
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        //UIMenuController.shared.isMenuVisible = false
        return false
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    @IBInspectable var adjustFontSize: Bool{
        set {
            if newValue {
                var currentFont = self.font
                var sizeScale: CGFloat = 1
                
                if IS_IPHONE_4_OR_LESS {
                    sizeScale = 0.8 //not Tested yet
                }
                else if IS_IPHONE_5 {
                    sizeScale = 1.0
                }
                else if IS_IPHONE_6 {
                    sizeScale = 1.25
                }
                else if IS_IPHONE_6P {
                    sizeScale = 1.35
                }

                self.font = currentFont!.withSize(currentFont!.pointSize * sizeScale)
            }
        }
    
        get {
            return false
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor{
        set{
            self.attributedPlaceholder = NSAttributedString(string:"Enter", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        }
        get{
            return UIColor.white
        }
    }
}




