//
//  DescriptionViewController.swift
//  DoctorHunt
//
//  Created by Ritesh Narayan Patil on 4/25/18.
//  Copyright © 2018 Ritesh Narayan Patil. All rights reserved.
//

import UIKit
import Firebase
class DescriptionViewController: UIViewController,DataprocessDelegate{

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var name:String = String()
    var address:String = String()

    
    var image1 :UIImage = UIImage()
    var phoneNumber:String = String()
    var rating:String = String()
    
    let objeOverlay = LoadingOverlay()

    var service:String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        datadelegate = self
       
        btnSubmit.layer.borderWidth = 1.0
        btnSubmit.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }

    func dataprocess(txtName: String, practicetxt: String, txtAddress: String, image: UIImage, txtDoctordescription: String, txtDoctor: String) {
    
        address = txtAddress
        name = txtName
        phoneNumber = txtDoctordescription
        rating = txtDoctor
        service = practicetxt
        image1 = image
    }
    
    @objc func handleSignUp() {
      
        
                // 1. Upload the profile image to Firebase Storage
                self.objeOverlay.showOverlay(view: self.view)
                self.uploadProfileImage(self.image1) { url in
                    
                   
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = "riteshSsafaf"
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                         
                            if error == nil {
                       
                                
                                print("User display name changed!")
                                
                                self.saveProfile(username: "ritesh", profileImageURL: url!) { success in
                                    
                                    
                                
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
    func resetForm() {
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        setContinueButton(enabled: true)
//        continueButton.setTitle("Continue", for: .normal)
//        activityView.stopAnimating()
    }
    

    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
      
        let timestamp = Date().timeIntervalSince1970
        
       // guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("PHOTOES/myimage\(timestamp).png")
        
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

                let doctorRef = Database.database().reference().child("Doctors").childByAutoId()
                let doctorObject = [
                    "service": [
                        "serviceName": service
                        ],
                    "doctorName":service,
                    
                     "photoURL": profileImageURL.absoluteString
        
                    ] as [String:Any]
        
                doctorRef.setValue(doctorObject, withCompletionBlock: { error, ref in
        
                    if error == nil {
 
                        self.objeOverlay.hideOverlayView()
                        Utils.showToast(message: "Uploaded Succsesfully", view: self.view, image: UIImage(named: errorImageName)!)
 
                    } else {
                        // Handle the error
                    }
                })

    }
    
    
    
    @IBAction func onClickOfSubmit(_ sender: UIButton) {
        
       // self.objeOverlay.showOverlay(view: self.view)

        handleSignUp()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
