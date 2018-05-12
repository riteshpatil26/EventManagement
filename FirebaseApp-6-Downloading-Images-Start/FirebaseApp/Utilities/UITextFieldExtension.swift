//
//  UITextFieldExtension.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    
    
    func modifyClearButtonWithImage(image : UIImage) {
        
        let clearButton : UIButton = self.value(forKey: "_clearButton") as! UIButton
        clearButton.setImage(image, for: .normal)
        clearButton.backgroundColor = UIColor.clear
        clearButton.setImage(image, for: .highlighted)
        clearButton.backgroundColor = UIColor.clear
    }
    
    func setSowPasswordRightButton(image : UIImage){
        
        let purpleImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        purpleImageButton.backgroundColor = UIColor.clear
        purpleImageButton.setImage(image, for: .normal)
        purpleImageButton.setImage(UIImage(named: "hideImage"), for: .selected)
        purpleImageButton.addTarget(self, action: #selector(
            self.showHidePassword(sender:)), for: .touchUpInside)
        self.rightViewMode = UITextFieldViewMode.unlessEditing
        self.rightView = purpleImageButton
        
    }
    
    @objc func showHidePassword(sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !self.isSecureTextEntry
        let content = self.text
        self.text = nil
        self.text = content
    }
    
    func nextPrevDoneToolbar(nextPeve : [UIButton])->[UIButton]{
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        
        let btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btnDone.addTarget(self, action: #selector(self.doneWithKeyboard), for: .touchUpInside)
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        btnDone.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        let btnItemDone = UIBarButtonItem(customView: btnDone)
        //UIControlState.normal)
        
        let nextPrevView = UIView(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        nextPrevView.backgroundColor = UIColor.clear
        let nextButton = UIBarButtonItem(customView: nextPrevView)
        
        var btnNext = nextPeve.last
        btnNext = UIButton(frame: CGRect(x: 55, y: 0, width: 50, height: 50))
        btnNext?.addTarget(self, action: #selector(self.nextSelected), for: .touchUpInside)
        btnNext?.setTitle("Next", for: .normal)
        btnNext?.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
    //commented by ritesh
        //btnNext?.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .normal)
        btnNext?.setTitleColor(UIColor.white, for: .normal)
        
        
        btnNext?.setTitleColor(UIColor.darkGray, for: .disabled)
        nextPrevView.addSubview(btnNext!)
        var btnprevious = nextPeve.first
        
        btnprevious = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btnprevious?.addTarget(self, action: #selector(self.previousSelected), for: .touchUpInside)
        btnprevious?.setTitle("Prev", for: .normal)
        btnprevious?.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
     
        //commented by ritesh
    //  btnprevious?.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .normal)
       btnprevious?.setTitleColor(UIColor.white, for: .normal)
        
        
        btnprevious?.setTitleColor(UIColor.darkGray, for: .disabled)
        nextPrevView.addSubview(btnprevious!)
        nextButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0)], for: UIControlState.normal)
        toolbar.items =  NSArray(objects:nextButton, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
        btnItemDone.tintColor = UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        toolbar.barTintColor = UIColor.black
        toolbar.sizeToFit()
        
        
        toolbar.items =  NSArray(objects:nextButton, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
        btnItemDone.tintColor = UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        self.inputAccessoryView = toolbar
        self.inputAccessoryView = toolbar
        
        return [btnprevious!,btnNext!]
    }
    
    
    func toolBarWithDone(){
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btnDone.addTarget(self, action: #selector(self.doneWithKeyboard), for: .touchUpInside)
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        btnDone.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        let btnItemDone = UIBarButtonItem(customView: btnDone)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, btnItemDone], animated: false)
        
        btnItemDone.tintColor = UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0)
         toolbar.barTintColor = UIColor.black
        self.inputAccessoryView = toolbar
        self.inputAccessoryView = toolbar
        
    }
    
    func toolBarWithDoneAndCamcel() {
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btnDone.addTarget(self, action: #selector(self.doneWithKeyboard), for: .touchUpInside)
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        
        btnDone.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        
        
        
        let btnCancel = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        btnCancel.addTarget(self, action: #selector(self.cancelWithKeyboard), for: .touchUpInside)
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        
        btnDone.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        let btnItemDone = UIBarButtonItem(customView: btnDone)
        let btnItemCancel = UIBarButtonItem(customView: btnCancel)
        
        //toolbar.setItems([btnItemCancel, btnItemDone], animated: false)
        toolbar.items =  NSArray(objects:btnItemCancel, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
        btnItemDone.tintColor = UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0)
        toolbar.barTintColor = UIColor.black
        self.inputAccessoryView = toolbar
        self.inputAccessoryView = toolbar

        
        
    }
    @objc func cancelWithKeyboard(){
        
    }
    @objc func doneWithKeyboard(){
        self.resignFirstResponder()
    }
    
    @objc func nextSelected (){
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "keyboardNextAction"), object: nil)
    }
    @objc func previousSelected(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "keyboardPreviousAction"), object: nil)
    }
}
