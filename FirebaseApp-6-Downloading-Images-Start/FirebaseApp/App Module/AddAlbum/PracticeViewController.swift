//
//  PracticeViewController.swift
//  DoctorHunt
//
//  Created by Ritesh Narayan Patil on 4/24/18.
//  Copyright © 2018 Ritesh Narayan Patil. All rights reserved.
//

import UIKit
import Foundation
import Firebase
    import QuartzCore
class PracticeViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var txtPratice: B68UIFloatLabelTextField!
    let objeOverlay = LoadingOverlay()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        txtPratice.delegate = self
        self.title = "Add Album"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    toolBarWithDone()
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
     
    }
    
    @IBAction func onClickofProfileButton(_ sender: UIButton) {
  
     openOptionsForProfilePic()
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        print(selectedPhoto.size)
        self.imageView1.contentMode = UIViewContentMode.scaleAspectFit
        self.imageView1.image = selectedPhoto
        //self.isProfilePicPresent = true
        picker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    private func openOptionsForProfilePic(){
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Select Options For Profile Picture", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetControllerIOS8.addAction(cancelActionButton)
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Open Camera", style: .default)
        { action -> Void in
            self.openCamera()
        }
        actionSheetControllerIOS8.addAction(saveActionButton)
        
        let deleteActionButton: UIAlertAction = UIAlertAction(title: "Open Photos", style: .default)
        { action -> Void in
            self.openPhotos()
        }
        actionSheetControllerIOS8.addAction(deleteActionButton)
        self.present(actionSheetControllerIOS8, animated: true, completion: nil)
    }
    private func openPhotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .photoLibrary
        OperationQueue.main.addOperation({ () -> Void in
            
            self.present(imagePicker,
                         animated: true,
                         completion: nil)
            
        })
    }
    private func openCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        imagePicker.sourceType = .camera
        OperationQueue.main.addOperation({ () -> Void in
            
            self.present(imagePicker,
                         animated: true,
                         completion: nil)
            
        })
    }
    
    @objc internal func profileClicked(){
        openOptionsForProfilePic()
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
        self.txtPratice.inputAccessoryView = toolbar
       //self.inputAccessoryView = toolbar
        txtPratice.setPlaceHolderColor(color: kPLACEHOLDER_COLOR_GREYISH_ALPHA_1)
       
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = CGSize.zero
        view1.layer.shadowRadius = 10
        view1.layer.cornerRadius = 12.0
       
        
      
        btnProfile.layer.borderWidth = 1.0
        btnProfile.layer.borderColor = kGREEN_COLOR.cgColor
       // submitButton.backgroundColor = UIColor.clear
        
        submitButton.titleLabel?.textColor = UIColor.white
       submitButton.layer.borderWidth = 1.0
        submitButton.layer.borderColor = UIColor.white.cgColor
      submitButton.backgroundColor = UIColor.clear
    
       
    }
    
    @objc func doneWithKeyboard(){
        txtPratice.resignFirstResponder()
    }
    
    func resetForm() {
        self.objeOverlay.hideOverlayView()
        
        Utils.showToast(message: "Error in Speciality add", view: view, image: UIImage(named: errorImageName)!)
    }
   
    @objc func handleSignUp() {
        
        
        // 1. Upload the profile image to Firebase Storage
        
        self.uploadProfileImage(self.imageView1.image!) { url in
            
            
            if url != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = "riteshSsafaf"
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    
                    if error == nil {
                        
                        
                        print("User display name changed!")
                        
                        self.saveProfile(username: "admin@gmail.com", profileImageURL: url!) { success in
                            
                            
                            
                            if success {
                                self.dismiss(animated: true, completion: nil)
                            } else {
                                self.resetForm()
                            }
                        }
                        
                    } else {
                        print("Error: \(error!.localizedDescription)")
                        
                        
                        self.resetForm()
                    }
                }
            } else {
                self.resetForm()
            }
            
        }
        
        
        // }
    }
    
    
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        
        let timestamp = Date().timeIntervalSince1970
        
        // guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("EventsName/\(txtPratice.text!)\(timestamp).png")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        // let imageData =  UIImagePNGRepresentation(image)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        
        
        storageRef.putData(imageData, metadata: nil) { metaData, error in
            
            
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    
                    
                    
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    func saveProfile(username:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
     
        let serviceRef = Database.database().reference().child("services").childByAutoId()
        
        let serviceObject = [
            
            "serviceName": txtPratice.text!,
            "photoURL": profileImageURL.absoluteString
            
            ] as [String:Any]
        
        serviceRef.setValue(serviceObject, withCompletionBlock: { error, ref in
            if error == nil {
                self.objeOverlay.hideOverlayView()
                
                Utils.showToast(message: "New Events Added", view: self.view, image: UIImage(named: errorImageName)!)
            } else {
                // Handle the error
                self.resetForm()
            }
        })
        
        
        
        
    }
    
    
    
    @IBAction func onClickOfSubmit(_ sender: UIButton) {
      
           //
        if txtPratice.text != "" && imageView1.image != nil{
    self.objeOverlay.showOverlay(view: self.view)
            handleSignUp()
  
        }else{
             Utils.showToast(message: "Please select all", view: view, image: UIImage(named: errorImageName)!)
        }
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 

}
