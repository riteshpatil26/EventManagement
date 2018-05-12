////
////  ForgotPasswordViewController.swift
////  WMM
////
////  Created by Ritesh Patil on 11/28/16.
////  Copyright © 2016 Dhaval Gogri. All rights reserved.
////
//
//import UIKit
//import AVFoundation
//class ForgotPasswordViewController: UIViewController,UITextFieldDelegate,ServiceReponseDelegate {
//
//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var wmmLogoImageView: UIImageView!
//    @IBOutlet weak var passcodeTextfield: UITextField!
//    @IBOutlet weak var passCodeLabel: UILabel!
//    @IBOutlet weak var retrivePasswordLabel: UILabel!
//    @IBOutlet weak var emailIDTextField: B68UIFloatLabelTextField!
//    let overlay = LoadingOverlay()
//
//    @IBOutlet weak var signUpSwitchHolder: UIView!
//    @IBOutlet weak var btnVerify: UIButton!
//    var nextButton : UIBarButtonItem!
//    var previousButton : UIBarButtonItem!
//    var btnItemDone :UIBarButtonItem!
//
//    @IBOutlet weak var btnRetrive: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        // Do any additional setup after loading the view.
//
//          Utils.borderToLabel(label: btnVerify, color: UIColor.white.cgColor)
//            Utils.borderToLabel(label: btnRetrive, color: UIColor.white.cgColor)
//
//
//        emailIDTextField.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
//
//
//
//
//        emailIDTextField.placeholder = "Email ID"
//
//        passcodeTextfield.alpha = 0
//        addToolBar()
//        btnVerify.alpha = 0
//
//        btnRetrive.titleLabel?.text = "RETRIVE PASSWORD"
//
//
////        self.title = "Forgot Password"
////        self.navigationController?.navigationBar.topItem?.title = ""
////        self.navigationController?.navigationBar.tintColor = UIColor.white
////        self.navigationController?.navigationBar.backItem?.title = ""
//
//
//        /*passcodeTextfield.attributedPlaceholder = NSAttributedString(string:"Passcode",
//                                                                  attributes:[NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)])*/
//
//
//        /*emailIDTextField.attributedPlaceholder = NSAttributedString(string:"Email ID",
//                                                                    attributes:[NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)])*/
//
//    }
//
//
//    override func viewDidLayoutSubviews() {
//        self.wmmLogoImageView.frame = CGRect(x: self.view.frame.width/2 - self.wmmLogoImageView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .LogoImage), width: self.wmmLogoImageView.frame.width, height: self.wmmLogoImageView.frame.height)
//
//        self.passCodeLabel.frame = CGRect(x: self.view.frame.width/2 - self.passCodeLabel.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .PasscodeMessage), width: self.passCodeLabel.frame.width, height: self.passCodeLabel.frame.height)
//
//        self.containerView.frame = CGRect(x: self.view.frame.width/2 - self.containerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .ContainerView), width: self.containerView.frame.width, height: self.containerView.frame.height)
//
//        self.btnVerify.frame = CGRect(x: self.view.frame.width/2 - self.btnVerify.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .Verify), width: self.btnVerify.frame.width, height: self.btnVerify.frame.height)
//
//        self.btnRetrive.frame = CGRect(x: self.view.frame.width/2 - self.btnRetrive.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .Retrieve), width: self.btnRetrive.frame.width, height: self.btnRetrive.frame.height)
//
//        self.signUpSwitchHolder.frame = CGRect(x: self.view.frame.width/2 - self.signUpSwitchHolder.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .SignUpSwitch), width: self.signUpSwitchHolder.frame.width, height: self.signUpSwitchHolder.frame.height)
//
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        textField.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
//
//        if IS_IPHONE_5 || IS_IPHONE_6{
//
//            viewMoveUp()
//        }
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if IS_IPHONE_5 || IS_IPHONE_6{
//            viewDownMove()
//
//        }
//    }
//
//    func viewMoveUp(){
//        UIView.animate(withDuration: 1.0, animations: { () -> Void in
//            self.view.frame = CGRect(x: 0.0, y: -50.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//        })
//    }
//
//    func viewDownMove(){
//        UIView.animate(withDuration: 1.0, animations: { () -> Void in
//            self.view.frame = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//        })
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        if textField == emailIDTextField{
//            emailIDTextField.resignFirstResponder()
//            passcodeTextfield.becomeFirstResponder()
//        }else if textField == passcodeTextfield{
//           // emailIDTextField.resignFirstResponder()
//            passcodeTextfield.resignFirstResponder()
//        }
//        return true
//    }
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if string == ""{
//            return true
//        }else if textField == self.emailIDTextField{
//            if self.emailIDTextField.text!.utf16.count < 40{
//                return true
//            }else{
//                return false
//            }
//        }else if textField == self.passcodeTextfield{
//            if self.passcodeTextfield.text!.utf16.count < 4 {
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return true
//        }
//
//
//         return true
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//
//        //self.txtConfirmPassworf.setSowPasswordRightButton(image: UIImage(named: "mobile_number")!)
//        self.passcodeTextfield.setSowPasswordRightButton(image: UIImage(named: "show_password_dark")!)
//
//           }
//    func addToolBar(){
//    /*
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
//
//        btnItemDone = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SignInViewController.doneWithKeyboard))
//        btnItemDone.setTitleTextAttributes([NSForegroundColorAttributeName : kWHITE_COLOR], for: UIControlState.normal)
//       // previousButton = UIBarButtonItem(title:"Prev",style: UIBarButtonItemStyle.done, target: self, action: #selector(SignInViewController.previousSelected))
//        toolbar.items =  NSArray(objects:UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
//        btnItemDone.tintColor = kWHITE_COLOR
////        nextButton.tintColor = kGREEN_COLOR
////        previousButton.tintColor = kGREEN_COLOR
////
//
//        toolbar.barTintColor = kBLACK_COLOR
//        toolbar.sizeToFit()
//        emailIDTextField.inputAccessoryView = toolbar
//        passcodeTextfield.inputAccessoryView = toolbar
// */
//        self.emailIDTextField.toolBarWithDone()
//        self.passcodeTextfield.toolBarWithDone()
//    }
//
//    func doneWithKeyboard(){
//        emailIDTextField.resignFirstResponder()
//        passcodeTextfield.resignFirstResponder()
//    }
//    func previousSelected(){
//        if passcodeTextfield.isFirstResponder{
//            passcodeTextfield.resignFirstResponder()
//            emailIDTextField.becomeFirstResponder()
//        }
//    }
//    func nextSelected(){
//        if emailIDTextField.isFirstResponder{
//            emailIDTextField.resignFirstResponder()
//            passcodeTextfield.becomeFirstResponder()
//        }else if passcodeTextfield.isFirstResponder{
//            passcodeTextfield.resignFirstResponder()
//        }
//
//    }
//
//
//
//    func retrivePassword(email : String){
//
//        if Network.iSConnectedToNetwork(){
//        self.overlay.showOverlay(view: self.view)
////        let objLoginService = LoginService()
////        objLoginService.retrivePassword(email: email, delegate: self)
//        }else{
//          //  Utils.showToast(message: "Network Conection Not Available", view: view, image: UIImage(named: errorImageName)!)
//
//        }
//    }
//
//    @IBAction func actRetriveButtonTapped(_ sender: UIButton) {
//
//
//
//
//        if (emailIDTextField.text?.isEmpty)!{
//          //  Utils.showToast(message: "\(kFORGOTP_EMAIL_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//
//        }else if Utils.validateEmail(candidate: emailIDTextField.text!){
//
//
//           self.retrivePassword(email: (emailIDTextField.text)!)
//        //get api call for the button and after sucess please add them in the
//
//
//        }else{
//
//           //  Utils.showToast(message: "\(kFORGOTP_EMAIL_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//        }
//
//    }
//
//    func retrivePasswordSucess(){
//        emailIDTextField.alpha = 0
//        passcodeTextfield.alpha = 1
//        btnRetrive.alpha = 0
//        btnVerify.alpha = 1
//        passCodeLabel.text = "Please enter the passcode sent to your registerd Email ID"
//        passcodeTextfield.isSecureTextEntry = true
//        btnVerify.titleLabel?.text = "VERIFY"
//    }
//    @IBAction func actVerifyButtonTapped(_ sender: UIButton) {
//
//    //http://172.22.31.21:8080/WalkMyMind/api/auth/password/step2?email=john.doe%40wmm.com&passcode=798912
//
//
//        if Network.iSConnectedToNetwork(){
//            self.overlay.showOverlay(view: self.view)
////            let objLoginService = LoginService()
////            //objLoginService.retrivePassword(email: email, delegate: self)
////            objLoginService.verifyOtp(email: self.emailIDTextField.text!, passcode: self.passcodeTextfield.text!, delegate: self)
//        }else{
////            Utils.showToast(message: "Network Conection Not Available", view: view, image: UIImage(named: errorImageName)!)
////
//        }
//    }
//
//
//
//    @IBAction func signInButtonClicked(_ sender: UIButton) {
//
//    self.navigationController?.popToRootViewController(animated: true)
//    }
//
//
//
//     //MARK:--------- Service Responce Delegate --------------
//
////    func didReceivedAPIResults(results: Dictionary<String, Any>) {
////        //
////        self.overlay.hideOverlayView()
////       // print((results["response"] as!Dictionary<String,Any>)["message"])
////        if (results["response"] as! Dictionary<String,Any>)["code"] != nil{
////
////        print(results)
////        if results["serviceDescription"] as! String == "retrivePassword"{
////        if (results["response"] as!Dictionary<String,Any>)["code"] as! Int == 200{
////            self.retrivePasswordSucess()
////        }else{
////            Utils.showToast(message: (results["response"] as!Dictionary<String,Any>)["message"] as! String, view: view, image: UIImage(named: errorImageName)!)
////        }
////        }else  if results["serviceDescription"] as! String == "VerifyOTP"{
////
////            if (results["response"] as!Dictionary<String,Any>)["code"] as! Int == 200{
////
////                if results["Authorization"] as! String != ""{
////                //print(results["Authorization"])
////                self.setNewPassword(authToken: results["Authorization"] as! String)
////                }
////            }else{
////
////                if ((results["response"] as! Dictionary<String,Any>)["code"]) as! Int == 1004{
////
////                    Utils.showToast(message: "Session Expired", view: (UIApplication.shared.keyWindow)!, image: UIImage(named: errorImageName)!)
////                    Utils.clearProfilePicfromSystem()
////
////                    if let audioPlayer =  (UIApplication.shared.delegate as! AppDelegate).onlineAudioPlayer{
////                        //self.onlinePlayer = audioPlayer
////
////                        if audioPlayer.rate == 1{
////
////                            //self.pauseAudioImage.image = UIImage(named: "pause_small")
////                            audioPlayer.pause()
////                            (UIApplication.shared.delegate as! AppDelegate).onlineAudioPlayer = nil
////
////                        }
////                    }
////
////                    if let audioPlayer = (UIApplication.shared.delegate as! AppDelegate).audioPlayer{
////                        if audioPlayer.isPlaying{
////                            audioPlayer.pause()
////                        }
////                    }
////                    self.navigationController?.popToRootViewController(animated: true)
////                }else{
////                    let response = results["response" ]as! Dictionary<String,Any>
////                    print(response)
////                    Utils.showToast(message: response["message"] as! String, view: view, image: UIImage(named: errorImageName)!)
////                }            }
////        }
////
////       // Utils.showToast(message: "Enter Email Id", view: view)
////
////        }else{
////            Utils.showToast(message: "Unable to connect. Please try again later.", view: view, image: UIImage(named: errorImageName)!)
////        }
////
////    }
//    func setNewPassword(authToken : String) {
////        let confirmVC = UIStoryboard(name: "ConfirmStoryboard", bundle: nil)
////        if let confirmViewVC = confirmVC.instantiateViewController(withIdentifier: "conformPassword") as? ConfirmViewController {
////
////            confirmViewVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
////            confirmViewVC.isForgotpassword = true
////            confirmViewVC.email = self.emailIDTextField.text
////            confirmViewVC.authorizationString = authToken
////            self.navigationController?.pushViewController(confirmViewVC, animated: true)
////        }
//
//    }
//    func didReceivedAPIError(errorDetails: Dictionary<String, Any>) {
//        //
//
//         self.overlay.hideOverlayView()
//        print(errorDetails)
//        //Utils.showToast(message: "Enter Email Id", view: view)
//        if let message = errorDetails["error"] as? String{
//            //error
//          //  Utils.showToast(message: message, view: view, image: UIImage(named: errorImageName)!)
//        }else{
//          //  Utils.showToast(message: "Server Error", view: view, image: UIImage(named: errorImageName)!)
//        }
//
//
//    }
//
//
//
//
//    private enum ViewType{
//        case LogoImage
//        case PasscodeMessage
//        case ContainerView
//        case Verify
//        case Retrieve
//        case SignUpSwitch
//    }
//    private func getYPositionValueForAnimation(viewType: ViewType) -> CGFloat {
//        switch viewType {
//        case .LogoImage:
//            return Utils.getYPosition(y: 100, error: 0,0,0)
//        case .PasscodeMessage:
//            return self.wmmLogoImageView.frame.maxY + Utils.getYPosition(y: 40, error: 0,0,0)
//        case .ContainerView:
//            return self.passCodeLabel.frame.maxY + Utils.getYPosition(y: 0, error: -25,0,0)
//        case .Verify:
//            return self.containerView.frame.maxY + Utils.getYPosition(y: 55, error: -25,-10,10)
//        case .Retrieve:
//            return self.containerView.frame.maxY + Utils.getYPosition(y: 55, error: -25,-10,10)
//        case .SignUpSwitch:
//            return self.btnRetrive.frame.maxY + Utils.getYPosition(y: 50, error: -25,-10,-10)
//        }
//    }
//
//
//
//}

