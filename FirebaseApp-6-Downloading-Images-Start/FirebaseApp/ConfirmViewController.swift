////
////  ConfirmViewController.swift
////  WMM
////
////  Created by Ritesh Patil on 11/8/16.
////  Copyright © 2016 Dhaval Gogri. All rights reserved.
////
//
//import UIKit
//protocol scrollToMainViewDelegate {
//    func scrollToMainViewMethod()
//}
//
//protocol IssignUpDelegate {
//    func isSignupClicked()
//}
//
//
//
//var globalisSignupDelegate :IssignUpDelegate!
//
//var globalscrollDeleaget : scrollToMainViewDelegate!
//class ConfirmViewController:UIAlertViewDelegate ,UITextFieldDelegate,
//    private var shouldAnimate = false
//
//
//    @IBOutlet weak var logoImageVIew: UIImageView!
//    @IBOutlet weak var containerView: UIView!
//    @IBOutlet weak var newPasswordLine: UIView!
//    @IBOutlet weak var userNameLine: UIView!
//    @IBOutlet weak var txtConfirmPassworf: B68UIFloatLabelTextField!
//    @IBOutlet weak var setPasswordLabel: UILabel!
//    @IBOutlet weak var btnSetPassword: UIButton!
//    @IBOutlet weak var txtNewPassword: B68UIFloatLabelTextField!
//    var nextButton : UIBarButtonItem!
//    var previousButton : UIBarButtonItem!
//    var btnItemDone :UIBarButtonItem!
//     var intialScrollView:IntialScrollViewController = IntialScrollViewController()
//    var authorizationString = ""
//    var isForgotpassword = false
//    var email : String!
//     let objeOverlay = LoadingOverlay()
//
//    var btnprevious : UIButton!
//    var btnNext: UIButton!
//
//    //----------MARK:Life Cycle of App --------------------------
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        Utils.borderToLabel(label: btnSetPassword, color: UIColor.white.cgColor)
//        addToolBar()
//
//         NotificationCenter.default.addObserver(self, selector: #selector(ConfirmViewController.closeProfileViewMethod), name: NSNotification.Name(rawValue: "closeProfileView"), object: nil)
//
//        txtNewPassword.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
//        txtConfirmPassworf.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
////
////        self.userNameLine.alpha = 1
////        self.newPasswordLine.alpha = 1
////        self.setPasswordLabel.alpha = 1
////        self.txtNewPassword.alpha  = 1
////        self.txtConfirmPassworf.alpha = 1
////       self.logoImageVIew.alpha = 1
//        //print(self.authorizationString)
//        self.navigationController?.isNavigationBarHidden = true
//
//
//        /*txtNewPassword.attributedPlaceholder = NSAttributedString(string:"New Password",
//                                                               attributes:[NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)])*/
//
//        /*txtConfirmPassworf.attributedPlaceholder = NSAttributedString(string:"Confirm Password",
//                                                                  attributes:[NSForegroundColorAttributeName: UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)])*/
//
//        self.txtNewPassword.setSowPasswordRightButton(image: UIImage(named: "show_password_dark")!)
//        self.txtConfirmPassworf.setSowPasswordRightButton(image: UIImage(named: "show_password_dark")!)
//
//        if isForgotpassword {
//            self.btnSetPassword.setTitle("RESET PASSWORD", for: .normal)
//            self.btnSetPassword.setTitle("RESET PASSWORD", for: .highlighted)
//        }else{
//            self.btnSetPassword.setTitle("SET PASSWORD", for: .normal)
//            self.btnSetPassword.setTitle("SET PASSWORD", for: .highlighted)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool)
//    {
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func closeProfileViewMethod(notification :NSNotification){
//        self.customModelForPresentationRemovalAnimation(viewcontroller: self, view: intialScrollView.view)
//
//    }
//
//    override func viewDidLayoutSubviews() {
//
//        if shouldAnimate {
//            //PrintData.printData(data: "ConfirmViewController = \(self.logoImageVIew.frame)")
//
//            self.logoImageVIew.frame = CGRect(x: self.view.frame.width/2 - self.logoImageVIew.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .LogoImage), width: self.logoImageVIew.frame.width, height: self.logoImageVIew.frame.height)
//
//            self.containerView.frame = CGRect(x: self.view.frame.width/2 - self.containerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .ContainerView), width: self.containerView.frame.width, height: self.containerView.frame.height)
//
//            self.btnSetPassword.frame = CGRect(x: self.view.frame.width/2 - self.btnSetPassword.frame.width/2, y: self.getYPositionValueForAnimation(viewType: .SetPassword), width: self.btnSetPassword.frame.width, height: self.btnSetPassword.frame.height)
//
//
//            let privacyStrrybord = UIStoryboard(name: "Login", bundle: nil)
//            intialScrollView = privacyStrrybord.instantiateViewController(withIdentifier: "scrollViewProfile") as! IntialScrollViewController
//            intialScrollView.view.frame = CGRect(x: 0.0, y:self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
//
//            self.addChildViewController(intialScrollView)
//            self.view.addSubview(intialScrollView.view)
//
//
//        }
//        else{
//            shouldAnimate = true
//        }
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//   //----------MARK:TextField Delegate --------------------------
//    func textFieldDidEndEditing(_ textField: UITextField) {
//         viewDownMove()
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        textField.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
//        viewMoveUp()
//
//        if textField == self.txtNewPassword{
//
//            self.btnprevious.isEnabled = false
//            self.btnNext.isEnabled = true
//        }else if textField == self.txtConfirmPassworf{
//            self.btnprevious.isEnabled = true
//            self.btnNext.isEnabled = false
//        }
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        if textField == self.txtNewPassword{
//            txtNewPassword.resignFirstResponder()
//            txtConfirmPassworf.becomeFirstResponder()
//        }else if textField == self.txtConfirmPassworf{
//            self.txtConfirmPassworf.resignFirstResponder()
//        }
//
//
//
//        return true
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        if string == ""{
//            return true
//        }else if textField == self.txtNewPassword{
//            if self.txtNewPassword.text!.utf16.count < kMAX_PASSWORD_LENGTH{
//                return true
//            }else{
//                return false
//            }
//        }else if textField == self.txtConfirmPassworf{
//            if self.txtConfirmPassworf.text!.utf16.count < kMAX_PASSWORD_LENGTH {
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return true
//        }
//
//}
//
//
//
//
//
//    @IBAction func setPasswordButtonAction(_ sender: UIButton) {
//
//
//
//        if (txtNewPassword.text?.isEmpty)!{
//            Utils.showToast(message: "\(kSIGNUP_PASSWORD_VALIDATION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//
//        }else if (txtNewPassword.text?.utf8.count)! < kMIN_PASSWORD_LENGTH{
//            Utils.showToast(message: "\(kSIGNUP_PASSWORD_VALIDATION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//        }
//
//
//
//        else if (txtConfirmPassworf.text?.isEmpty)!{
//
//            Utils.showToast(message: "\(kSIGNUP_PASSWORD_MATCH_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//        }
//
//        else if (txtConfirmPassworf.text?.utf8.count)! < kMIN_PASSWORD_LENGTH{
//            Utils.showToast(message: "\(kSIGNUP_PASSWORD_MATCH_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//        }
//        else if txtNewPassword.text == txtConfirmPassworf.text{
//
//            self.setPassowrdAction()
//
//
//        }else {
//
//            Utils.showToast(message: "\(kSIGNUP_PASSWORD_MATCH_ERROR)", view: view, image: UIImage(named: errorImageName)!)
//
//        }
//
//    }
//
//    func setPassowrdAction(){
//
//        if Network.iSConnectedToNetwork(){
//            let objLoginService = LoginService()
//            self.objeOverlay.showOverlay(view: self.view)
//
//            if !self.isForgotpassword{
//            let objUser : User = (UIApplication.shared.delegate as! AppDelegate).loggedInUser
//
//
//                print(objUser.username)
//
//                 objUser.password = txtNewPassword.text
//
//                print(objUser.password)
//
//                Utils.saveObjectInNSUserDefaults(key: "userForTouchId", obj: objUser)
//
//                objLoginService.setPasswordAtSignUp(user: objUser, newPassword: txtNewPassword.text!, delegate: self)
//            }else{
//                let objLoginService = LoginService()
//                objLoginService.setPasswordForForgotPassword(email: self.email, password: txtNewPassword.text!, authToken: self.authorizationString, delegate: self)
//            }
//
//
//        }else{
//
//            Utils.showToast(message: "Network Connection is not avaleble", view: view, image: UIImage(named: errorImageName)!)
//
//        }
//    }
//
//    func setPasswordSucess() {
//        self.customViewModelForPresentationAnimation(viewcontroller: self, view: intialScrollView.view)
//
//
//
//        self.userNameLine.alpha = 0
//        self.newPasswordLine.alpha = 0
//        self.btnSetPassword.alpha = 0
//        self.txtNewPassword.alpha  = 0
//        self.txtConfirmPassworf.alpha = 0
//
//        self.logoImageVIew.alpha = 0
//
//
//
//       // Utils.saveDataInNSUserDefaults(key: "TouchId", obj: true as AnyObject)
//    }
//    //-------MARK:Added Toolbar Methods
//    func addToolBar(){
//
//   /*
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
//
//        btnItemDone = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(SignInViewController.doneWithKeyboard))
//        nextButton = UIBarButtonItem(title:"Next", style: UIBarButtonItemStyle.done, target: self, action: #selector(SignInViewController.nextSelected))
//        btnItemDone.setTitleTextAttributes([NSForegroundColorAttributeName : kWHITE_COLOR], for: UIControlState.normal)
//        previousButton = UIBarButtonItem(title:"Prev",style: UIBarButtonItemStyle.done, target: self, action: #selector(SignInViewController.previousSelected))
//
//
//        nextButton.setTitleTextAttributes([NSForegroundColorAttributeName : kGREEN_COLOR], for: UIControlState.normal)
//        previousButton.setTitleTextAttributes([NSForegroundColorAttributeName : kGREEN_COLOR], for: UIControlState.normal)
//        toolbar.items =  NSArray(objects:previousButton,nextButton, UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target:nil, action:nil),btnItemDone) as? [UIBarButtonItem];
//        btnItemDone.tintColor = kWHITE_COLOR
//        nextButton.tintColor = kGREEN_COLOR
//        previousButton.tintColor = kGREEN_COLOR
//        toolbar.barTintColor = kBLACK_COLOR
//        toolbar.sizeToFit()
//        txtConfirmPassworf.inputAccessoryView = toolbar
//        txtNewPassword.inputAccessoryView = toolbar
//
// */
//
//        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.nextSelected), name: NSNotification.Name(rawValue: "keyboardNextAction"), object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.previousSelected), name: NSNotification.Name(rawValue: "keyboardPreviousAction"), object: nil)
//        btnprevious = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//        btnNext = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//
//        btnprevious = txtNewPassword.nextPrevDoneToolbar(nextPeve: [btnprevious,btnNext]).first
//        btnNext = txtConfirmPassworf.nextPrevDoneToolbar(nextPeve: [btnprevious,btnNext]).last
//
//    }
//
//    func doneWithKeyboard(){
//        txtNewPassword.resignFirstResponder()
//        txtConfirmPassworf.resignFirstResponder()
//    }
//    func previousSelected(){
//        if txtConfirmPassworf.isFirstResponder{
//            txtConfirmPassworf.resignFirstResponder()
//            txtNewPassword.becomeFirstResponder()
//        }
//    }
//    func nextSelected(){
//        if txtNewPassword.isFirstResponder{
//            txtNewPassword.resignFirstResponder()
//            txtConfirmPassworf.becomeFirstResponder()
//        }else if txtConfirmPassworf.isFirstResponder{
//            txtConfirmPassworf.resignFirstResponder()
//        }
//
//    }
//    func viewMoveUp(){
//        UIView.animate(withDuration: 1.0, animations: { () -> Void in
//            self.view.frame = CGRect(x: 0.0, y: -100.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//        })
//    }
//
//    func viewDownMove(){
//        UIView.animate(withDuration: 1.0, animations: { () -> Void in
//            self.view.frame = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
//        })
//    }
//
//    func customViewModelForPresentationAnimation(viewcontroller:UIViewController,view :UIView){
//
//
//
//        /*UIView.animate(withDuration: 0.4, animations: { () -> Void in
//            view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
//
//            }, completion: {(Bool) -> Void in
//                self.view.isUserInteractionEnabled = true
//        })*/
//        view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height)
//
//
//    }
//
//    func customModelForPresentationRemovalAnimation(viewcontroller:UIViewController,view :UIView){
//
//
//
////        UIView.animate(withDuration: 0.4, animations: { () -> Void in
////
////        }) { (Bool) -> Void in
////            UIView.animate(withDuration: 0.1, animations: { () -> Void in
////                //view.frame = CGRectMake(0 ,UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width , UIScreen.main.bounds.size.height);
////
////                view.frame = CGRect(x: 0.0, y:  UIScreen.main.bounds.size.height + 20 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
////
////
////            }) { (Bool) -> Void in
////
////               // globalscrollDeleaget.scrollToMainViewMethod()
////                viewcontroller.removeFromParentViewController()
////
////
////            }
////        }
//
//
//        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
//        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "test123")
//        self.navigationController?.pushViewController(profileVC, animated: true)
//
//
//        globalisSignupDelegate.isSignupClicked()
//
//
//    }
//
//
////    func getObjectFromDictionary(dataDictionary : Dictionary<String,Any>) -> User{
////
////        let objUser : User = User()
////        if let name = dataDictionary["firstName"] as? String{
////            objUser.firstName = name
////        }
////        if let lname = dataDictionary["lastName"] as? String{
////        objUser.lastName = lname
////        }
////        if let cCode =  dataDictionary["corporateName"] as? String{
////        objUser.corporateName = cCode
////        }
////        if let gender = dataDictionary["gender"] as? String{
////        objUser.gender = gender
////        }
////        if let id = dataDictionary["id"] as? Double{
////        objUser.userId = id
////        }
////        if let location =  dataDictionary["location"] as? String{
////        objUser.location = location
////        }
////        if let mobile = dataDictionary["mobNo"] as? String{
////        objUser.mobileNumber = mobile
////        }
////        if let picUrl = dataDictionary["profilePicUri"] as? String{
////        objUser.profilePicUri = picUrl
////        }
////        if let token = dataDictionary["userDeviceToken"] as? String{
////        objUser.deviceToken = token
////        }
////
////        return objUser
////    }
//
//   //MARK:--------- Service Delegate method ------------//
//    func didReceivedAPIResults(results: Dictionary<String, Any>) {
//        //
//
//       // print(results)
//        //setPasswordForForgotPassword
//         self.objeOverlay.hideOverlayView()
//        //print((results["response"] as! Dictionary<String,Any>)["code"])
//       // print(results["serviceDescription"])
//        //print(results["Authorization"])
//
//       // Utils.showToast(message: "Unable to connect. Please try again later.", view: self.view, image: UIImage(named: errorImageName)!)
//     if (results["response"] as! Dictionary<String,Any>)["code"] != nil{
//        if results["serviceDescription"] as! String == "setPassword"{
//        if (results["response"] as! Dictionary<String,Any>)["code"] as! Int == 200{
//
//            if results["Authorization"] as! String != ""{
//
//                let response = results["response"]as! Dictionary<String,Any>
//                let user = LoginHelper.getObjectFromDictionary(dataDictionary: (response["response"]as! Dictionary<String,Any>))
//                user.authorizationToken = results["Authorization"] as! String
//
//                print(user.firstName)
//                (UIApplication.shared.delegate as! AppDelegate).loggedInUser = user
//                self.setPasswordSucess()
//            }else{
//                if ((results["response"] as! Dictionary<String,Any>)["code"]) as! Int == 1004{
//
//                    Utils.showToast(message: "Session Expired", view: (UIApplication.shared.keyWindow)!, image: UIImage(named: errorImageName)!)
//                    Utils.clearProfilePicfromSystem()
//
//                    if let audioPlayer =  (UIApplication.shared.delegate as! AppDelegate).onlineAudioPlayer{
//                        //self.onlinePlayer = audioPlayer
//
//                        if audioPlayer.rate == 1{
//
//                            //self.pauseAudioImage.image = UIImage(named: "pause_small")
//                            audioPlayer.pause()
//                            (UIApplication.shared.delegate as! AppDelegate).onlineAudioPlayer = nil
//
//                        }
//                    }
//
//                    if let audioPlayer = (UIApplication.shared.delegate as! AppDelegate).audioPlayer{
//                        if audioPlayer.isPlaying{
//                            audioPlayer.pause()
//                        }
//                    }
//                    self.navigationController?.popToRootViewController(animated: true)
//                }else{
//                    let response = results["response" ]as! Dictionary<String,Any>
//                    print(response)
//                    Utils.showToast(message: response["message"] as! String, view: view, image: UIImage(named: errorImageName)!)
//                }
//            }
//
//        }
//        }else if results["serviceDescription"] as! String == "setPasswordForForgotPassword"{
//
//            if results["Authorization"] as! String != ""{
//
//                 let response = results["response"]as! Dictionary<String,Any>
//                let user = LoginHelper.getObjectFromDictionary(dataDictionary: (response["response"]as! Dictionary<String,Any>))
//                user.authorizationToken = results["Authorization"] as! String
//                user.password = self.txtNewPassword.text
//
//
//                PrintData.printData(data: "User = \(user.firstName)")
//                (UIApplication.shared.delegate as! AppDelegate).loggedInUser = user
//                Utils.saveObjectInNSUserDefaults(key: "logedInUser", obj: user)
//                if let isTouchId = Utils.loadDataFromNSuserDefaults(key: "TouchId") as? Bool{
//
//                    if isTouchId{
//                        Utils.saveObjectInNSUserDefaults(key: "userForTouchId", obj: user)
//                    }
//                }
//                self.setPasswordForForgotpasswordSucess()
//
//
//            }else{
//
//                //if results["Authorization"] as! String !=
//                if ((results["response"] as! Dictionary<String,Any>)["code"]) as! Int == 1004{
//
//                    Utils.showToast(message: "Session Expired", view: (UIApplication.shared.keyWindow)!, image: UIImage(named: errorImageName)!)
//                    Utils.clearProfilePicfromSystem()
//                    self.navigationController?.popToRootViewController(animated: true)
//                }else{
//                    let response = results["response" ]as! Dictionary<String,Any>
//                    print(response)
//                    Utils.showToast(message: response["message"] as! String, view: view, image: UIImage(named: errorImageName)!)
//                }
//            }
//        }
//     }else{
//            Utils.showToast(message: "Unable to connect. Please try again later.", view: self.view, image: UIImage(named: errorImageName)!)
//        }
//
//}
//    func setPasswordForForgotpasswordSucess(){
//        //
//
//        self.navigationController?.popToRootViewController(animated: true)
//
//
//
////        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
////        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "test123")
////        self.navigationController?.pushViewController(profileVC, animated: true)
//
//    }
//    func didReceivedAPIError(errorDetails: Dictionary<String, Any>) {
//        //
//
//        //setPasswordForForgotPassword
//         self.objeOverlay.hideOverlayView()
//        print(errorDetails)
//        if let message = errorDetails["error"] as? String{
//            //error
//            Utils.showToast(message: message, view: view, image: UIImage(named: errorImageName)!)
//        }else{
//            Utils.showToast(message: "Server Error", view: view, image: UIImage(named: errorImageName)!)
//        }
//    }
//
//
//    private enum ViewType{
//        case LogoImage
//        case ContainerView
//        case SetPassword
//    }
//    private func getYPositionValueForAnimation(viewType: ViewType) -> CGFloat {
//        switch viewType {
//        case .LogoImage:
//            return Utils.getYPosition(y: 100, error: 0,0,0)
//        case .ContainerView:
//            return self.logoImageVIew.frame.maxY + Utils.getYPosition(y: 50, error: 0,0,0)
//        case .SetPassword:
//            return self.containerView.frame.maxY + Utils.getYPosition(y: 135, error: 0,0,0)
//        }
//    }
//
//}

