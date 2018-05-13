//
//  ProfileViewController.swift
//  Firebase App
//
//  Created by Ritesh Patil.
//  Copyright © 2018 Ritesh Patil. All rights reserved.
//

import UIKit
 import Foundation
import Firebase
@objc protocol scrollViewProtocolDelegate {
    @objc optional func scrollViewonUpdate()
    
}
var globalscrollViewDelegate :scrollViewProtocolDelegate!
//private var uploadRequest: Request?


class ProfileViewController: BaseViewController, UIActionSheetDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,scrollViewProtocolDelegate,userDetailDelegate{
    
    //Storyboard References
    @IBOutlet weak var closeProfile: UIImageView!
   
      let objeOverlay = LoadingOverlay()
    
    @IBOutlet var scrollView: UIScrollView!
    //Page1 References
    @IBOutlet var page1: UIView!
    @IBOutlet var imageHolder: UIView!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var personName: UILabel!
    @IBOutlet var horizontalLine: UIView!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var place: UILabel!
    @IBOutlet var separatorLine: UIView!
    @IBOutlet var genderViewContainer: UIView!
    @IBOutlet var genderImageView: UIImageView!
    @IBOutlet var genderTextView: B68UIFloatLabelTextField!
    @IBOutlet weak var genderDropDownImageView: UIImageView!
    @IBOutlet var genderPickButton: UIButton!
    @IBOutlet var genderLine: UIView!
    @IBOutlet var dateOfBirthViewContainer: UIView!
    @IBOutlet var dateOfBirthImage: UIImageView!
    @IBOutlet var dateOfBirthPickerView: UIButton!
    @IBOutlet var dateOfBirth: B68UIFloatLabelTextField!
    @IBOutlet var dateOfBirthLine: UIView!
    @IBOutlet var mobileNumberViewContainer: UIView!
    @IBOutlet var mobileNumberImageView: UIImageView!
    @IBOutlet var mobileNumber: B68UIFloatLabelTextField!
    @IBOutlet var mobileNumberLine: UIView!
    @IBOutlet var nextNavigation: UIButton!
    @IBOutlet weak var overlayGender: UIView!
    @IBOutlet var openPickerView: UIButton!
    @IBOutlet var genderSelectionContainerView: UIView!
    @IBOutlet weak var cancelGenderSelection: UIButton!
    @IBOutlet var selectGenderLabel: UILabel!
    @IBOutlet var maleButton: UIButton!
    @IBOutlet var femalebutton: UIButton!
    
    var timer = Timer()
 
    var userName :String = String()
    var password :String = String()
    
    var count = 0.0
    
    
    
    var isNavigateToDashboard = false
    @IBOutlet var page2: UIView!
    @IBOutlet var page3: UIView!
    
    
    //Private Variable
    private var shouldAnimate = false
    private var noFurtherAnimation = false
    private let animationTime = 0.25
    private var pageNo: Int8 = 1
    private var dateSelected = ""
    private var isKeyboardOpen = false
    var isProfilePicPresent = false
    private var isUserDataLoadedOnce = false
    private var isDateOfBirthClicked = false
    
    var isProfileFromSignup :Bool = false
    //    private var previousPageNumber:Int8 = -1
    
    var signupViewController :SignInViewController = SignInViewController()
    var overlay = LoadingOverlay()
    
    
    @IBAction func canceTapped(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeProfileView"), object: nil)
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextField.appearance().tintColor = kGREEN_COLOR
        
        print(isProfileFromSignup )
        
        if isProfileFromSignup == true{
            closeProfile.alpha = 1
            
        }else{
            closeProfile.alpha = 0
        }
        
        addSlideMenuButton()
        self.navigationController?.navigationBar.tintColor = UIColor.white
 
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewDidLayoutSubviews() {
        self.page1Initialization()
    }
    
    internal func closeProfileView(){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = "Profile"
    }
    override func viewWillLayoutSubviews() {
        PrintData.printData(data: "ProfileViewController")
    }
    
    
    
    private var isDoneOnce = false
    private func page1Initialization(){
  
        if !isDoneOnce {
            
            isDoneOnce = true
            
            self.page1.layoutIfNeeded()
            self.genderSelectionContainerView.layoutIfNeeded()
            self.genderSelectionContainerView.translatesAutoresizingMaskIntoConstraints = true
            PrintData.printData(data: "ProfileViewController = \(self.genderSelectionContainerView.frame.width)")
            PrintData.printData(data: "ProfileViewController = \(self.page1.frame.width)")
            self.genderSelectionContainerView.frame = CGRect(
                x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                width: self.genderSelectionContainerView.frame.width,
                height: self.genderSelectionContainerView.frame.height
            )
            PrintData.printData(data: "ProfileViewController = \(self.genderSelectionContainerView.frame)")
            self.nextNavigation.layoutIfNeeded()
            Utils.borderToLabel(label: nextNavigation, color: kGREEN_COLOR.cgColor)
            PrintData.printData(data: "Data = \(self.view.frame.height + self.genderSelectionContainerView.frame.height)")
            mobileNumber.delegate = self
            
            
            
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
            self.mobileNumber.toolBarWithDone()
            let profileTapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(ProfileViewController.profileClicked)
            )
            imageHolder.addGestureRecognizer(profileTapGestureRecognizer)
            
            
            
            let overlayTapGestureRecognizer = UITapGestureRecognizer(
                target: self, action: #selector(ProfileViewController.overLayClicked)
            )
            overlayGender.addGestureRecognizer(overlayTapGestureRecognizer)
            
            
            genderTextView.setPlaceHolderColor(color: kWHITE_COLOR)
            dateOfBirth.setPlaceHolderColor(color: kWHITE_COLOR)
            mobileNumber.setPlaceHolderColor(color: kWHITE_COLOR)
            
        }
        
    }
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    @objc internal func overLayClicked(){
        
        isDateOfBirthClicked = false
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
        },
            completion: { finished in
                
                UIView.animate(withDuration: 0.3) {
                    self.overlayGender.alpha = 0
                    
                }
                
                
                //self.overlayGender.alpha = 0
        }
        )
        dateOfBirth.resignFirstResponder()
        mobileNumber.resignFirstResponder()
        
        
    }
    
    func userSubmit(username :String,password :String){
        self.userName = username
        self.password = password
        
    }
    
    @objc func handleSignUp() {

        self.objeOverlay.showOverlay(view: self.view)
       
        
        Auth.auth().createUser(withEmail:emailIDprofile, password:passWordprofile) { user, error in
            
            
            if error == nil && user != nil {
             
                
                print("User created!")
                
                
                // 1. Upload the profile image to Firebase Storage
                
                self.uploadProfileImage(self.profilePic.image!) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = "R"
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(username: "Ritesh", profileImageURL: url!) { success in
                                    if success {
                                         self.objeOverlay.hideOverlayView()
                                        self.dismiss(animated: true, completion: nil)
                                        
                                        isFromAdmin = false

                                        let profileIdStoruboard  = UIStoryboard(name: "Category", bundle: nil)
                                        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "CategoryViewController")
                                        self.navigationController?.pushViewController(profileVC, animated: true)
                                        
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
                
            } else {
                self.resetForm()
            }
        }
    }
    
    func resetForm() {
            self.objeOverlay.hideOverlayView()
        
           Utils.showToast(message: "\(kPROFILE_UPDATION_UN_SUCCESSFULL)", view: view, image: UIImage(named: errorImageName)!)
        
        
        
       
    }
    @IBAction func updateClicked(_ sender: UIButton) {
        if(isDataValidated()){
            //globalscrollViewDelegate.scrollViewonUpdate!()
            if profilePic.image != nil{
            self.handleSignUp()
            }else {
                 Utils.showToast(message: "Please take profile picture", view: view, image: UIImage(named: errorImageName)!)
                
            }
            print(self.userName)
            print(self.password)
            
            print("Data is update")
          
        }
    }
    
    
    
    private func isDataValidated() -> Bool{
        if genderTextView.text == ""{
            Utils.showToast(message: "\(kPROFILE_GENDER_VALIDATION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            return false
        }
        else if dateOfBirth.text == ""{
            Utils.showToast(message: "\(kPROFILE_BIRTHDATE_VALIDATION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            return false
        }
        else if mobileNumber.text! == "" || (mobileNumber.text?.utf8.count)!<14{
            Utils.showToast(message: "\(kPROFILE_NUMBER_VALIDATION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            return false
        }
        return true
    }
    
    
    @IBAction func openGenderBottomSheetOptions(_ sender: UIButton) {
        mobileNumber.resignFirstResponder()
        dateOfBirth.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            self.overlayGender.alpha = 1
        }
        
        
        
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.translatesAutoresizingMaskIntoConstraints = true
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height - self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
                PrintData.printData(data: "Data =1 \(self.view.frame.height)")
                PrintData.printData(data: "Data =2 \(self.genderSelectionContainerView.frame.height)")
        },
            completion: { finished in
                PrintData.printData(data: "ProfileViewController G = \(self.genderSelectionContainerView.frame)")
        }
        )
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
    
    @objc internal func profileClicked(){
        openOptionsForProfilePic()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
        },
            completion: { finished in
                
                UIView.animate(withDuration: 0.3) {
                    self.overlayGender.alpha = 0
                    
                }
                
                
                //self.overlayGender.alpha = 0
        }
        )
        
        //print("ritesh anar")
    }
    
    
    @IBAction func openPickerViewForDate(_ sender: UIButton) {
        mobileNumber.resignFirstResponder()
        isDateOfBirthClicked = true
        /*UIView.animate(
         withDuration: 0.5,
         delay: 0.0,
         options: UIViewAnimationOptions.allowAnimatedContent,
         animations: {
         self.genderSelectionContainerView.frame = CGRect(
         x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
         y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
         width: self.genderSelectionContainerView.frame.width,
         height: self.genderSelectionContainerView.frame.height
         )
         },
         completion: { finished in
         UIView.animate(withDuration: 0.3, animations: {
         self.overlayGender.alpha = 0
         })
         
         
         }
         )*/
        //self.overlayGender.alpha = 1
        
        
        let myDatePicker: UIDatePicker = UIDatePicker()
        
        myDatePicker.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 200)
        
        myDatePicker.datePickerMode = .date
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.backgroundColor = UIColor.white
        myDatePicker.layer.cornerRadius = 5.0
        //myDatePicker.layer.shadowOpacity = 0.5
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var comps = DateComponents()
        //comps.year = -18
        //var maxDate = calendar.date(byAddingComponents: comps, toDate: currentDate, options: [])!
        let maxDate = calendar.date(byAdding: comps, to: currentDate)
        comps.year = -1000
        //var minDate = calendar.date(byAddingComponents: comps, toDate: currentDate, options: [])!
        let minDate = calendar.date(byAdding: comps, to: currentDate)
        myDatePicker.maximumDate = maxDate
        myDatePicker.minimumDate = minDate
        
        if dateSelected.utf8.count > 0 {
            let dateFormatter = DateFormatter()
            // dateFormatter.dateFormat =  "MM/dd/yyyy"
            dateFormatter.dateFormat =  "MMMM dd, yyyy"
            let date = dateFormatter.date(from: dateSelected)
            myDatePicker.date = date!
        }
        else{
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            dateSelected = dateFormatter.string(from: maxDate!)
        }
        
        //        let dateFormatter: DateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "MM/dd/yyyy"
        //        dateSelected = dateFormatter.string(from: maxDate!)
        
        
        // self.view.addSubview(myDatePicker)
        myDatePicker.addTarget(self, action: #selector(ProfileViewController.dataPickerChanged(datePicker:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let btnDone = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btnDone.addTarget(self, action: #selector(ProfileViewController.donePicker), for: .touchUpInside)
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(UIColor.white, for: .normal)
        
        btnDone.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        let btnItemDone = UIBarButtonItem(customView: btnDone)
        
        let btnCancel = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        btnCancel.addTarget(self, action: #selector(ProfileViewController.cancelPicker), for: .touchUpInside)
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.white, for: .normal)
        
        btnCancel.setTitleColor(UIColor(red: 62.0/255.0, green: 189.0/255.0, blue: 178.0/255.0, alpha: 1.0), for: .highlighted)
        
        
        let btnItemCancel = UIBarButtonItem(customView: btnCancel)
        
        toolBar.items =  NSArray(objects:btnItemCancel, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
        toolBar.isUserInteractionEnabled = true
        self.dateOfBirth.inputAccessoryView = toolBar
        self.dateOfBirth.inputView = myDatePicker
        
        
        self.dateOfBirth.becomeFirstResponder()
        
    }
    
    
    @objc func showOverLayView(){
        
        overlay.showOverlay(view: self.view)
    }
    
    
    
    @objc func dataPickerChanged(datePicker: UIDatePicker){
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        // Apply date format
        
        
        let selectedDate: String = dateFormatter.string(from: datePicker.date)
        //        let fullDateArr = selectedDate.characters.split{$0 == " "}.map(String.init)
        //        selectedDate = fullDateArr[0] + " " + fullDateArr[1] + " " + fullDateArr[2]
        //dateOfBirth.text = selectedDate
        dateSelected = selectedDate
    }
    
    @objc func donePicker(){
        dateOfBirth.text = dateSelected
        self.dateOfBirth.resignFirstResponder()
        isDateOfBirthClicked = false
        self.overlayGender.alpha = 0
    }
    
    @objc func cancelPicker(){
        //dateSelected = ""
        self.dateOfBirth.resignFirstResponder()
        //dateOfBirth.text = dateSelected
        dateSelected = dateOfBirth.text!
        isDateOfBirthClicked = false
        self.overlayGender.alpha = 0
    }
    
    
    @IBAction func cancelGenderClicked(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
        },
            completion: { finished in
                
                UIView.animate(withDuration: 0.3) {
                    self.overlayGender.alpha = 0
                }
        }
        )
        
    }
    
    
    @IBAction func maleSelected(_ sender: UIButton) {
        if(isProfilePicPresent){
            
        }
        else{
            profilePic.image = UIImage(named: "user_default")
        }
        genderTextView.text = "Male"
        maleButton.setTitleColor(kGREEN_COLOR, for: .normal)
        femalebutton.setTitleColor(UIColor.black, for: .normal)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
        },
            completion: { finished in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.overlayGender.alpha = 0
                })
                
                
                
                
        }
        )
        
    }
    
    @IBAction func femaleSelected(_ sender: UIButton) {
        genderTextView.text = "Female"
        if(isProfilePicPresent){
            
        }
        else{
            profilePic.image = UIImage(named: "user_default_female")
        }
        
        maleButton.setTitleColor(UIColor.black, for: .normal)
        femalebutton.setTitleColor(kGREEN_COLOR, for: .normal)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                self.genderSelectionContainerView.frame = CGRect(
                    x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                    y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                    width: self.genderSelectionContainerView.frame.width,
                    height: self.genderSelectionContainerView.frame.height
                )
        },
            completion: { finished in
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.overlayGender.alpha = 0
                })
                
                
                
        }
        )
    }
    
    
    
    
    //Below Functions For Page2 Implementation
    
    private func page2Initialization(){
        
    }
    
    
    
    //Below Functions For Page3 Implementation
    
    private func page3Initialization(){
        
    }
    
    
    //Other Methods
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if !isKeyboardOpen {
                isKeyboardOpen = true
                /*UIView.animate(
                 withDuration: 0.5,
                 delay: 0.0,
                 options: UIViewAnimationOptions.allowAnimatedContent,
                 animations: {
                 self.genderSelectionContainerView.frame = CGRect(
                 x: self.page1.frame.width/2 - self.genderSelectionContainerView.frame.width/2,
                 y: self.page1.frame.height + self.genderSelectionContainerView.frame.height,
                 width: self.genderSelectionContainerView.frame.width,
                 height: self.genderSelectionContainerView.frame.height
                 )
                 },
                 completion: { finished in
                 
                 UIView.animate(withDuration: 0.3) {
                 self.overlayGender.alpha = 0
                 }
                 
                 
                 
                 }
                 )*/
                if self.isDateOfBirthClicked{
                    self.overlayGender.alpha = 1
                }
                
                self.view.frame.origin.y = self.view.frame.origin.y - 226.0
                PrintData.printData(data: "Data = \(keyboardSize.height)")
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if isKeyboardOpen {
                isKeyboardOpen = false
               // self.view.frame.origin.y += keyboardSize.height
                 self.view.frame.origin.y = self.view.frame.origin.y + 226.0
                
            }
        }
    }
    
    
    
    //Delegate Methods - UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mobileNumber {
            mobileNumber.resignFirstResponder()
            return true
        }
        return true
    }
    
    private var mobileNumberTextCount = 0
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        mobileNumberTextCount = (textField.text! as NSString).length//(textField.text?.utf8.count)!
        PrintData.printData(data: "ProfileViewController = \(mobileNumberTextCount)  \(string)  \(range.location)")
        if string == "" {
            textField.text = self.convertToFormat(text: textField.text!, newString: string, backspace: true, range: range)
            self.setTextViewPointerPosition(textField: textField, range: range, backSpace: true)
        }
        else{
            textField.text = self.convertToFormat(text: textField.text!, newString: string, backspace: false, range: range)
            self.setTextViewPointerPosition(textField: textField, range: range, backSpace: false)
        }
        return false
    }
    
    private func convertToFormat(text: String, newString: String, backspace: Bool, range: NSRange) -> String{
        var s = ""
        
        if(backspace){
            
            s = "\((text as NSString).substring(to: range.location))\((text as NSString).substring(with: NSRange(location: range.location+1, length: text.utf8.count - range.location-1)))"
            
            let x = (text as NSString).substring(with: NSRange(location: range.location, length: 1))
            
            s = (s as NSString).replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
            
            if (x == " " || x == ")"){
                if(s.utf8.count == 3){
                    s = (s as NSString).substring(to: 2)
                }
                else if(s.utf8.count > 3){
                    s = "\((s as NSString).substring(to: 2))\((s as NSString).substring(with: NSRange(location: 3, length: s.utf8.count-3)))"
                }
            }
            
        }
        else{
            if(text.utf8.count==14){
                return text
            }
            s = "\((text as NSString).substring(to: range.location))\(newString)\((text as NSString).substring(with: NSRange(location: range.location, length: text.utf8.count - range.location)))"
            
            s = (s as NSString).replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
            
        }
        if(s.utf8.count<3){
            return s
        }
        else if(s.utf8.count<7){
            
            var returnString = ""
            returnString = "(\((s as NSString).substring(to: 3))) "
            returnString = "\(returnString)\((s as NSString).substring(from: 3))"
            return returnString
        }
        else if(s.utf8.count<=10){
            var returnString = ""
            returnString = "(\((s as NSString).substring(to: 3))) "
            returnString = "\(returnString)\((s as NSString).substring(with: NSRange(location: 3, length: 3)))-"
            returnString = "\(returnString)\((s as NSString).substring(with: NSRange(location: 6, length: s.utf8.count-6)))"
            return returnString
        }
        else{
            return text
        }
        
    }
    
    func setTextViewPointerPosition(textField: UITextField, range: NSRange, backSpace: Bool){
        var startPosition: UITextPosition = textField.position(from: textField.beginningOfDocument, offset: 0)!
        if !backSpace{
            switch range.location{
            case 0:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 1:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 2:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+4)!
                break;
            case 3:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+3)!
                break;
            case 4:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+2)!
                break;
            case 5:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 6:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 7:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 8:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 9:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+2)!
                break;
            case 10:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 11:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 12:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 13:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location+1)!
                break;
            case 14:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            default:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            }
        }
        else{
            switch range.location{
            case 0:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 1:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 2:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 3:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location-1)!
                break;
            case 4:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 5:
                if textField.text?.characters.count == 2{
                    startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location-3)!
                }
                else{
                    startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location-2)!
                }
                break;
            case 6:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location-2)!
                break;
            case 7:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 8:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 9:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 10:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location-1)!
                break;
            case 11:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 12:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 13:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            case 14:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            default:
                startPosition = textField.position(from: textField.beginningOfDocument, offset: range.location)!
                break;
            }
        }
        textField.selectedTextRange = textField.textRange(from: startPosition, to: startPosition)
    }
    
    func keyboardDoneClicked(){
        mobileNumber.resignFirstResponder()
        self.overlayGender.alpha = 0
    }
    //MARK:------Camera
    
    func openCamera(){
        
        
//        let photoVcStrrybord = UIStoryboard(name: "CapturePhoto", bundle: nil)
//        if #available(iOS 10.0, *) {
//            if let photoConroller = photoVcStrrybord.instantiateViewController(withIdentifier: "capturePhotoId") as? CapturePhotoViewController {
//
//                photoConroller.delegate = self
//                photoConroller.isFrontCamera = true
//                photoConroller.cameraMessage = "Tap anywhere on the screen to scan your bill"
//                //photoConroller.overlayImageName = "no image"
//                //photoConroller.previewImaveName = "no imgae"
//                self.present(photoConroller, animated: true, completion: nil)
//                //self
//
//            }
//        } else {
//            // Fallback on earlier versions
//
//        }
    }
    func didFinishCapturePhoto(photo: UIImage) {
  
   
        
        
    }
    func didCloseCapturePhoto() {
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
    
}

extension ProfileViewController{
    
    
    func image(with image: UIImage, scaledTo newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedimage:UIImage = UIImage(cgImage:imageRef)
        return croppedimage
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        print(selectedPhoto.size)
        self.profilePic.contentMode = UIViewContentMode.scaleAspectFill
        self.profilePic.image = selectedPhoto
        self.isProfilePicPresent = true
        picker.dismiss(animated: true, completion: nil)
        
  
    }

    
    func mergedImageWith(frontImage:UIImage?, backgroundImage: UIImage?) -> UIImage{
        
        if (backgroundImage == nil) {
            return frontImage!
        }
        
        let size = backgroundImage?.size//self.profilePic.frame.size
        UIGraphicsBeginImageContextWithOptions(size!, false, 0.0)
        
        backgroundImage?.draw(in: CGRect.init(x: 0, y: 0, width: (size?.width)!, height: (size?.height)!))
        frontImage?.draw(in: CGRect.init(x: 0, y: 0, width: (size?.width)!, height: (size?.height)!).insetBy(dx: (size?.width)! * 0.1, dy: (size?.height)! * 0.1))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    


}
extension String {
    func isEqualToString(find: String) -> Bool {
        return String(format: self) == find
    }
    public func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    
}
