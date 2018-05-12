//
//  SignInViewController.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit
 import Foundation
import Firebase
@objc protocol VersionLabelAlpha {
    
    @objc optional func versionLabelAlpha()
    @objc optional func verisonForSignUp()
    @objc optional func firstTimeSignInClicked()
}
@objc protocol userDetailDelegate {
    @objc optional func usernameonUpdate(username :String,password :String)
    
}

var isFromAdmin :Bool = false

var emailIDprofile: String = String()
var passWordprofile :String = String()
class SignInViewController: UIViewController,UITextFieldDelegate{
    
    
    var checkBox5S = UIButton()
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var touchIdButton: UIButton!
    //StoryBoard References
    @IBOutlet weak var termAndPolicyOImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtCorporateCode: B68UIFloatLabelTextField!
    @IBOutlet weak var viewCorporateCodeLine: UIView!
    @IBOutlet weak var txtUsername: B68UIFloatLabelTextField!
    @IBOutlet weak var viewUsernameLine: UIView!
    @IBOutlet weak var txtPassword: B68UIFloatLabelTextField!
    @IBOutlet weak var viewPasswordLine: UIView!
    @IBOutlet weak var imgFingerPrint: UIImageView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var viewSignupSwitchHolder: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
    var username : String = String()
    var password :String = String()
    
    var isCheckBoxClicked : Bool = false
    
    var globalscrollViewDelegate1 :userDetailDelegate!
    
    var delegateVersion :VersionLabelAlpha!
    
    var isTermofServiceTapped :Bool  = false
    var isPrivacyPolicyTapeed :Bool = false
    
    @IBOutlet weak var termAndComdtionVIEW: UIView!
    @IBOutlet weak var overLayView: UIView!
    //Private Variables
    private var shouldAnimate = false
    private var noFurtherAnimation :Bool = Bool()
    private var animationTime: Double = 0.75
    var nextButton : UIBarButtonItem!
    var previousButton : UIBarButtonItem!
    var btnItemDone :UIBarButtonItem!
    var isSignUpClicked :Bool = false
    //   var privacyhelpVc :PrivacyViewController = PrivacyViewController()
    var isFirstTimeSignUpOptionsShown = false
    var dontAnimateSignInSignUp = false
    var hasFirstTimeButtonClickedAnimationDone = false
    var isToolbarAdded = false
    
    
    var btnprevious : UIButton!
    var btnNext: UIButton!
    let objeOverlay = LoadingOverlay()
    
    @IBOutlet weak var agreeLabel: UILabel!
    //-----MARK:Life Cycle Methods -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
     
        isFirstTimeSignUpOptionsShown = UserDefaults.standard.bool(forKey: HAS_FIRST_SCREEN_BEEN_SHOWN)
        
        if isFirstTimeSignUpOptionsShown {
            //dontAnimateSignInSignUp = true
            hasFirstTimeButtonClickedAnimationDone = true
            self.btnSignIn.setBackgroundImage(UIImage(named: "")   , for: .normal)
            self.btnSignIn.backgroundColor = UIColor.clear
            self.btnSignIn.setTitle("SIGN UP", for: .normal)
            self.btnSignUp.setTitle("SIGN IN", for: .normal)
            self.btnSignIn.backgroundColor = UIColor.clear
            self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
            Utils.borderToLabel(label: self.btnSignUp, color: UIColor.clear.cgColor)
            
        }
        else{
            Utils.borderToLabel(label: btnSignUp, color: UIColor.white.cgColor)
        }
        
        if let  user = Utils.loadObjectInNSUserDefaults(key: "logedInUser") as? User{
            
            if isFirstTimeSignUpOptionsShown {
                dontAnimateSignInSignUp = true
            }
        }
        
        Utils.borderToLabel(label: btnSignIn, color: UIColor.white.cgColor)
        //Utils.borderToLabel(label: btnSignUp, color: UIColor.white.cgColor)
        isSignUpClicked = false
        //"123456"
        overLayView.alpha = 0
        
        termAndComdtionVIEW.alpha = 0
        
        UITextField.appearance().tintColor = kWHITE_COLOR
        
        
        txtUsername.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
        txtPassword.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
        self.txtPassword.setSowPasswordRightButton(image: UIImage(named: "show_password_dark")!)
        self.txtPassword.text = ""
        self.txtUsername.text = ""
        
    }
    
    func timedelayToOpenApp(){
        let profileIdStoruboard  = UIStoryboard(name: "DashBoard", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "test123")
        self.navigationController?.pushViewController(profileVC, animated: false)
        
        
    }
    
    private func userIsLoggedInSoNoAnimation(){
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.txtPassword.text = ""
        //self.txtUsername.
    }
    override func viewWillAppear(_ animated: Bool) {
        btnSignIn.setTitle("SIGN IN", for: .normal)
        btnSignUp.setTitle("SIGN UP", for: .normal)
        
        
        self.viewDidLayoutSubviews()
        
        //txtUsername.text = "apsuser2@gmail.com" //"abc@xyz.com"
        // txtPassword.text = "222222"
        
        PrintData.printData(data: "\(isSignUpClicked)")
        
        
        
        txtUsername.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
        txtPassword.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
        txtPassword.setSowPasswordRightButton(image: UIImage(named: "show_password_dark")!)
        
        if let  user = Utils.loadObjectInNSUserDefaults(key: "userForTouchId") as? User{
            self.txtUsername.text = user.username  
        }
        self.txtPassword.text = ""
        self.txtUsername.text = "ritesh.patil26@gmail.com"
        self.txtPassword.text = "riteshnarayanpatil"
        
        //globalisSignupDelegate = self
        
        //  self.imgFingerPrint.alpha = 1
        self.btnForgotPassword.alpha = 1
        //self.viewSignupSwitchHolder.alpha = 1
        self.btnSignIn.setTitle(kSIGNIN_BUTTON_LABEL, for: UIControlState.normal)
        if !self.noFurtherAnimation{
            self.noFurtherAnimation = false
        }
        termAndComdtionVIEW.alpha = 0
        
        if isSignUpClicked == false{
            self.txtPassword.placeholder = "Password"
        }
        
        //isTermofServiceTapped = false
        
        isSignUpClicked = false
        
        if let isTouchId = Utils.loadDataFromNSuserDefaults(key: "TouchId") as? Bool{
            
            if isTouchId{
                
                self.imgFingerPrint.alpha = 1
                self.touchIdButton.alpha = 1
            }else{
                self.imgFingerPrint.alpha = 0
                self.touchIdButton.alpha = 0
            }
        }else{
            self.imgFingerPrint.alpha = 0
            self.touchIdButton.alpha = 0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        termAndPolicyOImageView.isUserInteractionEnabled = false
        
        if isSignUpClicked == true{
            // termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
            
        }else{
            
            isCheckBoxClicked = false
            termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
        }
        
    }
    
    func closeAction(){
        isPrivacyPolicyTapeed = false
        
        
        isTermofServiceTapped = false
        
        // self.customModelForPresentationRemovalAnimation(viewcontroller: self, view: privacyhelpVc.view)
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func toucIdAuthentication(){
        
        if let  user = Utils.loadObjectInNSUserDefaults(key: "logedInUser") as? User{
            
            
            self.txtUsername.text = user.username
            
            print(self.txtUsername.text)
            
            print(user.password)
        }
        
    }
    
    
    
    @IBAction func touchIdAction(_ sender: UIButton) {
        
        
        
        //self.toucIdAuthentication()
    }
    override func viewDidLayoutSubviews() {
        
        self.termAndPolicyOImageView.layoutIfNeeded()
        print(isFirstTimeSignUpOptionsShown)
        
        print(shouldAnimate)
        print(noFurtherAnimation)
        print(isSignUpClicked)
        
        self.txtPassword.keyboardType = UIKeyboardType.default
        if isFirstTimeSignUpOptionsShown{
            
            
            
            if shouldAnimate && !noFurtherAnimation && !isSignUpClicked{
                
                
                
                noFurtherAnimation = true
                resetViewPosition()
                
                txtCorporateCode.alpha = 0
                viewCorporateCodeLine.alpha = 0
                
                self.btnSignIn.setTitle(kSIGNIN_BUTTON_LABEL, for: UIControlState.normal)
                //PrintData.printData(data: self.btnSignIn.currentTitle!)
                Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(SignInViewController.animationTranslateCorporateCodeAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SignInViewController.animationTranslateUsernameAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(SignInViewController.animationTranslatePasswordAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(SignInViewController.animationTranslateFingerprint), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(SignInViewController.animationTranslateSignIn), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SignInViewController.animationScaleForgotPasswordAndSignUpViewHolder), userInfo: nil, repeats: false)
                
                
                
                if Utils.loadObjectInNSUserDefaults(key: "logedInUser") is User{
                }else {
                    
                    self.btnSignUp.setTitle("SIGN UP", for: UIControlState.normal)
                    //  self.delegateVersion.versionLabelAlpha!()
                }
                
                
                addToolBar()
                
            }
            else if shouldAnimate && !noFurtherAnimation && isSignUpClicked{
                noFurtherAnimation = true
                animateUsernameCorpoatareCodePassword()
                addToolBar()
            }
            else{
                shouldAnimate = true
                addToolBar()
            }
            
        }
        else if !isFirstTimeSignUpOptionsShown{
            
            if shouldAnimate && !noFurtherAnimation && !isSignUpClicked{
                noFurtherAnimation = true
                
                resetViewPosition()
                self.btnSignIn.setTitle(kSIGNIN_BUTTON_LABEL, for: UIControlState.normal)
                //PrintData.printData(data: self.btnSignIn.currentTitle!)
                
                
                txtCorporateCode.alpha = 0
                viewCorporateCodeLine.alpha = 0
                txtUsername.alpha = 0
                viewUsernameLine.alpha = 0
                txtPassword.alpha = 0
                viewPasswordLine.alpha = 0
                imgFingerPrint.alpha = 0
                btnSignIn.alpha = 1
                btnForgotPassword.alpha = 0
                viewSignupSwitchHolder.alpha = 1
                btnSignUp.alpha = 1
                
                Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: #selector(SignInViewController.animationTranslateCorporateCodeAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(SignInViewController.animationTranslateUsernameAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.10, target: self, selector: #selector(SignInViewController.animationTranslatePasswordAndLine), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(SignInViewController.animationTranslateFingerprint), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(SignInViewController.animationTranslateSignIn), userInfo: nil, repeats: false)
                
                Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(SignInViewController.animationScaleForgotPasswordAndSignUpViewHolder), userInfo: nil, repeats: false)
                
                addToolBar()
                
            }
            else{
                shouldAnimate = true
            }
            
            
        }
        
    }
    //------------MARK:Utilities Methods ------------------------
    public func animateUsernameCorpoatareCodePassword(){
        
        
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(SignInViewController.animationTranslateCorporateCodeAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SignInViewController.animationTranslateUsernameAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(SignInViewController.animationTranslatePasswordAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(SignInViewController.animationTranslateFingerprint), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(SignInViewController.animationTranslateSignIn), userInfo: nil, repeats: false)
        
        self.termAndComdtionVIEW.alpha = 0
        
        if IS_IPHONE_6{
            self.termAndComdtionVIEW.translatesAutoresizingMaskIntoConstraints = true
            self.termAndComdtionVIEW.frame = CGRect(x:10 ,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 45, error: 0,0,0),width: self.termAndComdtionVIEW.frame.width,height: self.termAndComdtionVIEW.frame.height)
            
        }else  if IS_IPHONE_6P{
            
            self.termAndComdtionVIEW.translatesAutoresizingMaskIntoConstraints = true
            self.termAndComdtionVIEW.frame = CGRect(x:10 ,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 45, error: 0,0,0),width: self.termAndComdtionVIEW.frame.width,height: self.termAndComdtionVIEW.frame.height)
            
        }else if IS_IPHONE_5{
            
            
            self.termAndComdtionVIEW.translatesAutoresizingMaskIntoConstraints = true
            self.termAndComdtionVIEW.frame = CGRect(x:0 ,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 45, error: 0,0,0),width: self.termAndComdtionVIEW.frame.width,height: self.termAndComdtionVIEW.frame.height)
            
        }
        self.termAndComdtionVIEW.translatesAutoresizingMaskIntoConstraints = true
        self.termAndComdtionVIEW.frame = CGRect(x:self.containerView.frame.width/2 - self.termAndComdtionVIEW.frame.width/2,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 45, error: 0,0,0),width: self.termAndComdtionVIEW.frame.width,height: self.termAndComdtionVIEW.frame.height)
        
        if IS_IPHONE_5{
            
            
            checkBox5S.frame = CGRect(
                x: (self.view.superview?.subviews[1].frame.minX)! + termAndComdtionVIEW.frame.minX,
                y: termAndComdtionVIEW.frame.minY + 10,
                width: 80,
                height: termAndComdtionVIEW.frame.height
            )
            
            self.view.superview?.addSubview(checkBox5S)
            checkBox5S.alpha = 1
            checkBox5S.addTarget(self, action: #selector(SignInViewController.tickImageTapped5S(sender:)), for: .touchUpInside)
            checkBoxButton.isUserInteractionEnabled = false
        }
        
        
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(SignInViewController.animationTermsAndCondition), userInfo: nil, repeats: false)
        
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SignInViewController.animationScaleForgotPasswordAndSignUpViewHolder), userInfo: nil, repeats: false)
        
        self.imgFingerPrint.alpha = 0
        self.btnForgotPassword.alpha = 0
        //self.btnSignUp.alpha = 0
        self.viewSignupSwitchHolder.alpha = 1
        //self.switchCorporate.alpha = 0
        self.touchIdButton.alpha = 0
        self.btnSignIn.setTitle(kSIGNUP_BUTTON_LABEL, for: UIControlState.normal)
        self.btnSignUp.setTitle("SIGN IN", for: UIControlState.normal)
        
        
        self.txtPassword.placeholder = "Password"
        
        self.txtPassword.text = ""
        
        self.txtPassword.keyboardType = UIKeyboardType.numberPad
        self.txtPassword.text = ""
        
    }
    
    func passwordtextfieldResign(){
        
        if !(txtUsername.text?.isEmpty)!{
            
            self.txtPassword.becomeFirstResponder()
        }
        
        
    }
    
    private func resetViewPosition(){
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        _ = screenSize.height
        
        txtCorporateCode.alpha = 0
        viewCorporateCodeLine.alpha = 0
        txtUsername.alpha = 0
        viewUsernameLine.alpha = 0
        txtPassword.alpha = 0
        viewPasswordLine.alpha = 0
        imgFingerPrint.alpha = 0
        termAndComdtionVIEW.alpha = 0
        //btnSignIn.alpha = 0
        btnForgotPassword.alpha = 0
        //viewSignupSwitchHolder.alpha = 0
        
        
        
        if isFirstTimeSignUpOptionsShown && !dontAnimateSignInSignUp{
            btnSignIn.alpha = 0
            viewSignupSwitchHolder.alpha = 0
        }
        
        PrintData.printData(data: "SIGNUPFRAME = \(viewSignupSwitchHolder.frame)   \(btnSignUp.frame)")
        
        
        txtCorporateCode.layoutIfNeeded()
        viewCorporateCodeLine.layoutIfNeeded()
        txtUsername.layoutIfNeeded()
        viewUsernameLine.layoutIfNeeded()
        txtPassword.layoutIfNeeded()
        viewPasswordLine.layoutIfNeeded()
        imgFingerPrint.layoutIfNeeded()
        btnSignIn.layoutIfNeeded()
        btnForgotPassword.layoutIfNeeded()
        viewSignupSwitchHolder.layoutIfNeeded()
        
        
        self.txtCorporateCode.translatesAutoresizingMaskIntoConstraints = true
        self.txtCorporateCode.frame = CGRect(x:self.containerView.frame.width/2 - self.txtCorporateCode.frame.width/2,y: self.view.frame.height,width: self.txtCorporateCode.frame.width,height: self.txtCorporateCode.frame.height)
        
        self.viewCorporateCodeLine.translatesAutoresizingMaskIntoConstraints = true
        self.viewCorporateCodeLine.frame = CGRect(x:self.containerView.frame.width/2 - self.viewCorporateCodeLine.frame.width/2,y: self.view.frame.height + self.txtCorporateCode.frame.height,width: self.viewCorporateCodeLine.frame.width,height: self.viewCorporateCodeLine.frame.height)
        
        
        self.txtUsername.translatesAutoresizingMaskIntoConstraints = true
        self.txtUsername.frame = CGRect(x:self.containerView.frame.width/2 - self.txtUsername.frame.width/2,y: Utils.getYPosition(y: 190, error: 0,0,0) + Utils.getYPosition(y: 10, error: 0,0,0),width: self.txtUsername.frame.width,height: self.txtUsername.frame.height)
        
        self.viewUsernameLine.translatesAutoresizingMaskIntoConstraints = true
        self.viewUsernameLine.frame = CGRect(x:self.containerView.frame.width/2 - self.viewUsernameLine.frame.width/2,y: Utils.getYPosition(y: 190, error: 0,0,0) + self.txtUsername.frame.height + Utils.getYPosition(y: 20, error: 0,0,0),width: self.viewUsernameLine.frame.width,height: self.viewUsernameLine.frame.height)
        
        
        
        
        self.txtPassword.translatesAutoresizingMaskIntoConstraints = true
        self.txtPassword.frame = CGRect(x:self.containerView.frame.width/2 - self.txtPassword.frame.width/2,y: self.txtUsername.frame.maxY + Utils.getYPosition(y: 40, error: 0,0,0),width: self.txtPassword.frame.width,height: self.txtPassword.frame.height)
        
        self.viewPasswordLine.translatesAutoresizingMaskIntoConstraints = true
        self.viewPasswordLine.frame = CGRect(x:self.containerView.frame.width/2 - self.viewPasswordLine.frame.width/2,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 20, error: 0,0,0),width: self.viewPasswordLine.frame.width,height: self.viewPasswordLine.frame.height)
        
        
        
        
        self.imgFingerPrint.translatesAutoresizingMaskIntoConstraints = true
        self.imgFingerPrint.frame = CGRect(x:self.containerView.frame.width/2 - self.imgFingerPrint.frame.width/2,y: self.txtPassword.frame.maxY + Utils.getYPosition(y: 25, error: 0,0,0),width: self.imgFingerPrint.frame.width,height: self.imgFingerPrint.frame.height)
        
        
        
        
        
        PrintData.printData(data: "SIGNIN FRAME = IMG\(imgFingerPrint.frame)   \(termAndComdtionVIEW.frame) \n")
        
        if !dontAnimateSignInSignUp && !isFirstTimeSignUpOptionsShown{
            self.btnSignIn.translatesAutoresizingMaskIntoConstraints = true
            self.btnSignIn.frame = CGRect(x:self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.view.frame.height,width: self.btnSignIn.frame.width,height: self.btnSignIn.frame.height)
        }
        else if dontAnimateSignInSignUp && isFirstTimeSignUpOptionsShown{
            self.btnSignIn.translatesAutoresizingMaskIntoConstraints = true
            self.btnSignIn.frame = CGRect(x: self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignIn) - Utils.getYPosition(y: 10, error: 0,0,0),width:  self.btnSignIn.frame.width,height:  self.btnSignIn.frame.height)
        }
        else{
            
            
            
            
            self.btnSignIn.translatesAutoresizingMaskIntoConstraints = true
            self.btnSignIn.frame = CGRect(x: self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignIn) - Utils.getYPosition(y: 10, error: 0,0,0),width:  self.btnSignIn.frame.width,height:  self.btnSignIn.frame.height)
        }
        PrintData.printData(data: "SIGNIN FRAME = \(btnSignIn.frame)")
        
        
        
        
        
        
        
        
        
        
        
        self.btnForgotPassword.translatesAutoresizingMaskIntoConstraints = true
        self.btnForgotPassword.frame = CGRect(x:self.containerView.frame.width/2 - self.btnForgotPassword.frame.width/2,y: self.view.frame.height,width: self.btnForgotPassword.frame.width,height: self.btnForgotPassword.frame.height)
        
        if !dontAnimateSignInSignUp && !isFirstTimeSignUpOptionsShown{
            self.viewSignupSwitchHolder.translatesAutoresizingMaskIntoConstraints = true
            self.viewSignupSwitchHolder.frame = CGRect(x:self.containerView.frame.width/2 - self.viewSignupSwitchHolder.frame.width/2,y: self.view.frame.height,width: self.viewSignupSwitchHolder.frame.width,height: self.viewSignupSwitchHolder.frame.height)
        }
        else if dontAnimateSignInSignUp && isFirstTimeSignUpOptionsShown{
            
        }
        else{
            
            if Utils.loadObjectInNSUserDefaults(key: "logedInUser") is User{
                
                
                
            }
            else{
                self.viewSignupSwitchHolder.translatesAutoresizingMaskIntoConstraints = true
                self.viewSignupSwitchHolder.frame = CGRect(x: self.containerView.frame.width/2 - self.viewSignupSwitchHolder.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignUpAndSwitch) + Utils.getYPosition(y: 5, error: 0,0,0),width:  self.viewSignupSwitchHolder.frame.width,height:  self.viewSignupSwitchHolder.frame.height)
            }
        }
        
    }
    @objc internal func animationTranslateCorporateCodeAndLine(){
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                PrintData.printData(data: "animationTranslateCorporateCodeAndLine \(self.txtCorporateCode.frame.minX)")
                PrintData.printData(data: "animationTranslateCorporateCodeAndLine \(self.txtCorporateCode.frame.minY)")
                
                self.txtCorporateCode.translatesAutoresizingMaskIntoConstraints = true
                self.txtCorporateCode.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .CorporateCode),width:  self.txtCorporateCode.frame.width,height:  self.txtCorporateCode.frame.height)
                
                self.viewCorporateCodeLine.translatesAutoresizingMaskIntoConstraints = true
                self.viewCorporateCodeLine.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .CorporateCodeLine),width:  self.viewCorporateCodeLine.frame.width,height:  self.viewCorporateCodeLine.frame.height)
                
        },
            completion: { finished in
                
        }
        )
    }
    
    
    @objc internal func animationTranslateUsernameAndLine(){
        txtUsername.alpha = 0
        viewUsernameLine.alpha = 0
        
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                if self.isFirstTimeSignUpOptionsShown{
                    self.txtUsername.alpha = 1
                    self.viewUsernameLine.alpha = 1
                }
                
                self.txtUsername.translatesAutoresizingMaskIntoConstraints = true
                self.txtUsername.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .Username),width:  self.txtUsername.frame.width,height:  self.txtUsername.frame.height)
                
                self.viewUsernameLine.translatesAutoresizingMaskIntoConstraints = true
                self.viewUsernameLine.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .UsernameLine),width:  self.viewUsernameLine.frame.width,height:  self.viewUsernameLine.frame.height)
                
        },
            completion: { finished in
                
        }
        )
        
    }
    
    
    @objc internal func animationTranslatePasswordAndLine(){
        self.txtPassword.alpha = 0
        self.viewPasswordLine.alpha = 0
        
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                if self.isFirstTimeSignUpOptionsShown{
                    self.txtPassword.alpha = 1
                    self.viewPasswordLine.alpha = 1
                }
                
                self.txtPassword.translatesAutoresizingMaskIntoConstraints = true
                self.txtPassword.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .Password),width:  self.txtPassword.frame.width,height:  self.txtPassword.frame.height)
                
                self.viewPasswordLine.translatesAutoresizingMaskIntoConstraints = true
                self.viewPasswordLine.frame = CGRect(x: 0,y: self.getYPositionValueForAnimation(viewType: .PasswordLine),width:  self.viewPasswordLine.frame.width,height:  self.viewPasswordLine.frame.height)
        },
            completion: { finished in
                
        }
        )
    }
    
    @objc internal func animationTranslateFingerprint(){
        self.imgFingerPrint.alpha = 0
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                if let isTouchId = Utils.loadDataFromNSuserDefaults(key: "TouchId") as? Bool{
                    if self.isFirstTimeSignUpOptionsShown && !self.isSignUpClicked && isTouchId{
                        self.imgFingerPrint.alpha = 1
                    }
                }
                
                self.imgFingerPrint.frame = CGRect(x: self.containerView.frame.width/2 - self.imgFingerPrint.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .FingerPrintImage),width:  self.imgFingerPrint.frame.width,height:  self.imgFingerPrint.frame.height)
        },
            completion: { finished in
                
        }
        )
    }
    
    
    
    @objc internal func animationTranslateSignIn(){
        
        if isFirstTimeSignUpOptionsShown && !dontAnimateSignInSignUp{
            self.btnSignIn.alpha = 0
            self.btnSignIn.frame = CGRect(x: self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignIn),width:  self.btnSignIn.frame.width,height:  self.btnSignIn.frame.height)
            PrintData.printData(data: "GETALLDATA = \(btnSignIn.frame)")
            UIView.animate(
                withDuration: self.animationTime,
                delay: 0.0,
                options: UIViewAnimationOptions.allowAnimatedContent,
                animations: {
                    
                    
                    self.btnSignIn.alpha = 1
                    
                    PrintData.printData(data: "signInAnimation \(self.btnSignIn.frame)")
            },
                completion: { finished in
                    
            }
            )
        }
        else if !dontAnimateSignInSignUp && !isFirstTimeSignUpOptionsShown{
            UIView.animate(
                withDuration: self.animationTime,
                delay: 0.0,
                options: UIViewAnimationOptions.allowAnimatedContent,
                animations: {
                    
                    
                    self.btnSignIn.frame = CGRect(x: self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignIn),width:  self.btnSignIn.frame.width,height:  self.btnSignIn.frame.height)
                    
                    PrintData.printData(data: "signInAnimation \(self.btnSignIn.frame)")
            },
                completion: { finished in
                    
            }
            )
        }
        else{
            
            //dontAnimateSignInSignUp = false
            
            self.btnSignIn.frame = CGRect(x: self.containerView.frame.width/2 - self.btnSignIn.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignIn),width:  self.btnSignIn.frame.width,height:  self.btnSignIn.frame.height)
            
            PrintData.printData(data: "signInAnimation \(self.btnSignIn.frame)")
        }
    }
    
    
    
    @objc internal func animationScaleForgotPasswordAndSignUpViewHolder(){
        self.btnForgotPassword.alpha = 0
        
        let forgotHeight = self.btnForgotPassword.frame.height
        let switchs = self.viewSignupSwitchHolder.frame.height
        
        
        self.btnForgotPassword.translatesAutoresizingMaskIntoConstraints = true
        self.btnForgotPassword.frame = CGRect(x:self.containerView.frame.width - self.btnForgotPassword.frame.width,y: self.getYPositionValueForAnimation(viewType: .ForgotPassword) - Utils.getYPosition(y: 5, error: 0,0,0),width: self.btnForgotPassword.frame.width,height: self.btnForgotPassword.frame.height)
        
        
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.transitionFlipFromTop,
            animations: {
                
                if self.isFirstTimeSignUpOptionsShown && !self.isSignUpClicked{
                    self.btnForgotPassword.alpha = 1
                }
                
                self.btnForgotPassword.frame = CGRect(x: self.containerView.frame.width - self.btnForgotPassword.frame.width,y: self.getYPositionValueForAnimation(viewType: .ForgotPassword),width:  self.btnForgotPassword.frame.width,height:  forgotHeight)
                
                
        },
            completion: { finished in
                
        }
        )
        
        
        
        
        if isFirstTimeSignUpOptionsShown && !dontAnimateSignInSignUp{
            self.viewSignupSwitchHolder.alpha = 0
            self.viewSignupSwitchHolder.frame = CGRect(x: self.containerView.frame.width/2 - self.viewSignupSwitchHolder.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignUpAndSwitch),width:  self.viewSignupSwitchHolder.frame.width,height:  self.viewSignupSwitchHolder.frame.height)
            
            UIView.animate(
                withDuration: self.animationTime,
                delay: 0.0,
                options: UIViewAnimationOptions.allowAnimatedContent,
                animations: {
                    
                    
                    self.viewSignupSwitchHolder.alpha = 1
                    
                    PrintData.printData(data: "signInAnimation \(self.btnSignIn.frame)")
            },
                completion: { finished in
                    
            }
            )
        }
            
            
            
        else if !dontAnimateSignInSignUp && !isFirstTimeSignUpOptionsShown{
            
            UIView.animate(
                withDuration: self.animationTime,
                delay: 0.0,
                options: UIViewAnimationOptions.allowAnimatedContent,
                animations: {
                    
                    
                    self.viewSignupSwitchHolder.frame = CGRect(x: self.containerView.frame.width/2 - self.viewSignupSwitchHolder.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignUpAndSwitch),width:  self.viewSignupSwitchHolder.frame.width,height:  self.viewSignupSwitchHolder.frame.height)
                    
                    PrintData.printData(data: "SignInViewController = \(self.viewSignupSwitchHolder.frame)")
                    
            },
                completion: { finished in
                    
            }
            )
        }
        else{
            
            
            
            
            self.viewSignupSwitchHolder.translatesAutoresizingMaskIntoConstraints = true
            
            self.viewSignupSwitchHolder.frame = CGRect(x: self.containerView.frame.width/2 - self.viewSignupSwitchHolder.frame.width/2,y: self.getYPositionValueForAnimation(viewType: .SignUpAndSwitch),width:  self.viewSignupSwitchHolder.frame.width,height:  self.viewSignupSwitchHolder.frame.height)
            dontAnimateSignInSignUp = false
            PrintData.printData(data: "SignInViewController = FR\(self.viewSignupSwitchHolder.frame)")
        }
        
    }
    
    
    @objc internal func animationTermsAndCondition(){
        
        UIView.animate(
            withDuration: self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                if self.isFirstTimeSignUpOptionsShown && self.isSignUpClicked{
                    self.termAndComdtionVIEW.alpha = 0
                }
                self.termAndComdtionVIEW.frame = CGRect(x: self.termAndComdtionVIEW.frame.minX,y: self.getYPositionValueForAnimation(viewType: .TermsAndCondition),width:  self.termAndComdtionVIEW.frame.width,height:  self.termAndComdtionVIEW.frame.height)
                
                PrintData.printData(data: "signInAnimation \(self.termAndComdtionVIEW.frame)")
        },
            completion: { finished in
                
        }
        )
    }
    
    func isSignupClicked(){
        
        isSignUpClicked = false
    }
    
    
    private enum ViewType{
        case CorporateCode
        case CorporateCodeLine
        case Username
        case UsernameLine
        case Password
        case PasswordLine
        case FingerPrintImage
        case SignIn
        case ForgotPassword
        case SignUpAndSwitch
        case TermsAndCondition
    }
    private func getYPositionValueForAnimation(viewType: ViewType) -> CGFloat {
        switch viewType {
            
            
            
        case .CorporateCode:
            if isSignUpClicked{
                return Utils.getYPosition(y: 190, error: 0,0,0)
            }
            else{
                return Utils.getYPosition(y: 190, error: 0,0,0)
            }
        case .CorporateCodeLine:
            return self.txtCorporateCode.frame.maxY
        case .Username:
            //return self.txtCorporateCode.frame.maxY + Utils.getYPosition(y: 10, error: 0,0,0)
            if isSignUpClicked{
                return Utils.getYPosition(y: 190, error: 0,0,0)
            }
            else{
                return Utils.getYPosition(y: 190, error: 0,0,0)
            }
        case .UsernameLine:
            return self.txtUsername.frame.maxY
        case .Password:
            return self.txtUsername.frame.maxY + Utils.getYPosition(y: 30, error: 0,0,0)
        case .PasswordLine:
            return self.txtPassword.frame.maxY
        case .FingerPrintImage:
            return self.txtPassword.frame.maxY + Utils.getYPosition(y: 35, error: 0,0,0)
        case .SignIn:
            if isSignUpClicked{
                //    return self.termAndComdtionVIEW.frame.maxY + Utils.getYPosition(y: 1, error: -4,0,3)
                return self.imgFingerPrint.frame.maxY + Utils.getYPosition(y: 25, error: 0,0,0)
            }
            else{
                return self.imgFingerPrint.frame.maxY + Utils.getYPosition(y: 25, error: 0,0,0)
            }
        case .ForgotPassword:
            return self.btnSignIn.frame.maxY + Utils.getYPosition(y: 5, error: 0,0,0)
        case .SignUpAndSwitch:
            return self.btnForgotPassword.frame.maxY + Utils.getYPosition(y: 5, error: -15,0,0)
        case .TermsAndCondition:
            return self.txtPassword.frame.maxY + Utils.getYPosition(y: 55, error: 0,0,0)
        }
    }
    
    //------------MARK:IBOutlet Properties-----------------------
    
    
    
    @objc func tickImageTapped5S(sender:UIButton!){
        
        
        /*
         if sender.isSelected{
         
         sender.isSelected = false
         termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
         }else{
         sender.isSelected = true
         termAndPolicyOImageView.image = UIImage(named: "checkBoxSelected")
         }
         print("tickimageViewclciked")
         */
        
        
        
        if isCheckBoxClicked == false{
            isCheckBoxClicked = false
            termAndPolicyOImageView.image = UIImage(named: "checkBoxSelected")
            
        }else{
            
            isCheckBoxClicked = false
            termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
        }
        
        
        
    }
    
    @IBAction func tickImageTapped(_ sender: UIButton) {
        
        
        print("\(isCheckBoxClicked)")
        
        
        
        if isCheckBoxClicked == false{
            isCheckBoxClicked = false
            termAndPolicyOImageView.image = UIImage(named: "checkBoxSelected")
            
        }else{
            
            isCheckBoxClicked = false
            termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
        }
    }
    
    func backTosignIn(){
        
        
        isCheckBoxClicked = false
        termAndPolicyOImageView.image = UIImage(named: "uncheckSelected")
        
        
        self.btnSignIn.setTitle(kSIGNIN_BUTTON_LABEL, for: UIControlState.normal)
        self.btnSignUp.setTitle("SIGN UP", for: UIControlState.normal)
        //PrintData.printData(data: self.btnSignIn.currentTitle!)
        self.txtPassword.text = ""
        
        self.btnForgotPassword.alpha = 1
        self.txtPassword.placeholder = "Password"
        self.txtPassword.keyboardType = UIKeyboardType.default
        
        self.termAndComdtionVIEW.alpha = 0
        
        
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(SignInViewController.animationTranslateCorporateCodeAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SignInViewController.animationTranslateUsernameAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(SignInViewController.animationTranslatePasswordAndLine), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(SignInViewController.animationTranslateFingerprint), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(SignInViewController.animationTranslateSignIn), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SignInViewController.animationScaleForgotPasswordAndSignUpViewHolder), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(SignInViewController.animationNotificationForVersion), userInfo: nil, repeats: false)
        
        if Utils.loadObjectInNSUserDefaults(key: "logedInUser") is User{
            
            
            
        }else {
            
        }
        
        
        
        
    }
    @objc func animationNotificationForVersion(){
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showverisonForSignUp"), object: nil)
        
    }
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        
        
        if isFirstTimeSignUpOptionsShown {
            
            if isSignUpClicked == true{
                
                checkBox5S.alpha = 0
                UIView.animate(withDuration: 1.0, animations: {
                    self.view.alpha = 1
                    
                }) { (Bool) in
                    
                    self.isSignUpClicked = false
                    self.resetViewPosition()
                    self.view.alpha = 1
                    
                    
                    self.backTosignIn()
                    
                    
                    
                }
                
            }else{
                checkBox5S.alpha = 1
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeverisonForSignUp"), object: nil)
                
                //showverisonForSignUp
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.view.alpha = 1
                    
                }) { (Bool) in
                    
                    self.isSignUpClicked = true
                    self.resetViewPosition()
                    self.view.alpha = 1
                    self.animateUsernameCorpoatareCodePassword()
                    
                }
                
            }
        }
        else{
            isSignUpClicked = true
            checkBox5S.alpha = 1
            isFirstTimeSignUpOptionsShown = true
            dontAnimateSignInSignUp = true
            //shouldAnimate = false
            noFurtherAnimation = false
            //  self.delegateVersion.firstTimeSdasdasdignInClicked!()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "firstTimeSign"), object: nil)
            
            self.showSignInAnimationFirstTime()
            
        }
        
        
    }
    
    
    //MARK:------ Login Action -----------------------//
    func validation(){
        
        
        
        
        if (self.txtUsername.text?.isEmpty)!{
            
            Utils.showToast(message: "\(kSIGNUP_EMAIL_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            
        } else if !Utils.validateEmail(candidate: txtUsername.text!){
            
            
            Utils.showToast(message: "\(kSIGNUP_EMAIL_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            print("Enter valid Email id")
            
        }else if (self.txtPassword.text?.isEmpty)! {
            if isSignUpClicked == true{
                Utils.showToast(message: "\(kSIGNUP_PASSCODE_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            }
            else{
                Utils.showToast(message: "\(kLOGIN_PASSWORD_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            }
        }
        else if (self.txtPassword.text?.utf8.count)! < kMIN_PASSWORD_LENGTH && !isSignUpClicked {
            Utils.showToast(message: "\(kLOGIN_PASSWORD_ERROR)", view: view, image: UIImage(named: errorImageName)!)
        }
        else if (self.txtPassword.text?.utf8.count)! < kMIN_PASSWORD_LENGTH  && isSignUpClicked {
            Utils.showToast(message: "\(kSIGNUP_PASSCODE_ERROR)", view: view, image: UIImage(named: errorImageName)!)
            
        }else if Utils.validateEmail(candidate: txtUsername.text!){
            
            if isSignUpClicked == true{
                
                
                print("validation for terms and service")
                
                if isCheckBoxClicked == false{
                    if Network.iSConnectedToNetwork(){
                        
                        // next To profileViewController
                    
                      
                      //  globalscrollViewDelegate1.usernameonUpdate!(username: txtUsername.text!, password: txtPassword.text!)
                        emailIDprofile =  txtUsername.text!
                        passWordprofile = txtPassword.text!
                        
                        
                        let profileIdStoruboard  = UIStoryboard(name: "Profile", bundle: nil)
                        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "profileId")
                        
                        
                   
                        
                        self.navigationController?.pushViewController(profileVC, animated: true)
                        
                        
                        
                        
                        
                        
                    }else{
                        
                        Utils.showToast(message: "Network Connection is not available", view: view, image: UIImage(named: errorImageName)!)
                    }
                }
                else{
                    Utils.showToast(message: "\(kSIGNUP_TERMS_CONDITION_ERROR)", view: view, image: UIImage(named: errorImageName)!)
                }
                
                
            }
            else{
                
                if Network.iSConnectedToNetwork(){
                    
                    
                    if txtUsername.text == "admin@gmail.com" && txtPassword.text == "ritesh12"{
                        
                        isFromAdmin = true
                        
                        let profileIdStoruboard  = UIStoryboard(name: "AdminViewController", bundle: nil)
                        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "AdminViewController")
                        self.navigationController?.pushViewController(profileVC, animated: true)
                        
                        //Post data to Firebase App
                    }else{
                       // self.loginSucess()
                        
                        handleSignIn()
                        
                        //Post data to Firebase App
                    }
                    
                }else{
                    
                    Utils.showToast(message: "Network Connection is not avaleble", view: view, image: UIImage(named: errorImageName)!)
                    
                }
            }
            
            
            
            
        }else {
            
        }
        
    }
    
    func signUpSucess(){
        
        self.txtPassword.keyboardType = UIKeyboardType.default
        self.txtPassword.placeholder = "Password"
        
    }
    
    
    
    @IBAction func forgotPasswordClicked(_ sender: UIButton) {
        
    }
    @objc func handleSignIn() {
        guard let email = txtUsername.text else { return }
        guard let pass = txtPassword.text else { return }
        
        
      self.objeOverlay.showOverlay(view: self.view)
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.loginSucess()
                
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                
                self.resetForm()
            }
        }
    }
    
    func resetForm() {
        self.objeOverlay.hideOverlayView()
        
        Utils.showToast(message: "\(kPROFILE_SIGN_UN_SUCCESSFULL)", view: view, image: UIImage(named: errorImageName)!)
   
    }

    
    func navigateToDashboard(){

        isFromAdmin = false
        let profileIdStoruboard  = UIStoryboard(name: "Category", bundle: nil)
        let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "CategoryViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
        
        self.overLayView.hideToastActivity()
        self.objeOverlay.hideOverlayView()
    }
    func loginSucess(){
        noFurtherAnimation = true
        dontAnimateSignInSignUp = false
        UserDefaults.standard.set(true, forKey: HAS_FIRST_SCREEN_BEEN_SHOWN)
        navigateToDashboard()
 
    }
    
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        
        if isFirstTimeSignUpOptionsShown {
            validation()
            
            
            
        }
        else{
            isFirstTimeSignUpOptionsShown = true
            dontAnimateSignInSignUp = true
            //shouldAnimate = false
            noFurtherAnimation = false
            
           
            
            
            PrintData.printData(data: "SIGNUPFRAME = SignIN \(viewSignupSwitchHolder.frame)")
            if let  user = Utils.loadObjectInNSUserDefaults(key: "logedInUser") as? User{
                //   self.delegateVersion.firstTimeSignInCdasdasdasdlicked!()
              
                
                
                
            }else{
       
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "firstTimeSign"), object: nil)
                
            }

            PrintData.printData(data: "SIGNUPFRAME = SignIN \(viewSignupSwitchHolder.frame)")
            self.showSignInAnimationFirstTime()
        }
        
        
        
    }
    
    internal func showSignInAnimationFirstTime() {
        
        self.btnSignIn.setBackgroundImage(UIImage(named: "")   , for: .normal)
        self.btnSignIn.backgroundColor = UIColor.white
        self.btnSignIn.setTitle("SIGN UP", for: .normal)
        self.btnSignUp.setTitle("SIGN IN", for: .normal)
        
        
        UIView.animate(
            withDuration: 1.0,//self.animationTime,
            delay: 0.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                
                
                
                
                self.btnSignIn.backgroundColor = UIColor.clear
                self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
                Utils.borderToLabel(label: self.btnSignUp, color: UIColor.clear.cgColor)
                
        },
            completion: { finished in
                
                
                PrintData.printData(data: "SIGNUPFRAME = SignIN END \(self.viewSignupSwitchHolder.frame)")
                self.btnSignIn.setTitleColor(UIColor.white, for: .normal)
                //Utils.borderToLabel(label: btnSignUp, color: UIColor.clear.cgColor)
                // self.view.setNeedsLayout()
        }
        )
        
        
        
    }
    
    //-------MARK:TextField Delegates -----------------------------
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.modifyClearButtonWithImage(image: UIImage(named: "clear")!)
        if IS_IPHONE_5{
            viewMoveUp()
            
        }

        if textField == txtUsername {
            btnprevious.isEnabled = false
            // let preve = (((textField.inputAccessoryView?.subviews)!.first)?.subviews)!.last as! UIButton
            // preve.isEnabled = false
            btnNext.isEnabled = true
            
        }else if textField == txtPassword{
            // previousButton.isEnabled = true
            //let preve = (((textField.inputAccessoryView?.subviews)!.first)?.subviews)!.last as! UIButton
            btnprevious.isEnabled = true
            btnNext.isEnabled = false
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if IS_IPHONE_5{
            viewDownMove()
            
        }

    }
 
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            return true
        }else if textField == self.txtUsername{
            if self.txtUsername.text!.utf16.count < 40{
                return true
            }else{
                return false
            }
        }else if textField == self.txtPassword{
            
            if self.isSignUpClicked == true{
                
                if self.txtPassword.text!.utf16.count < kMAX_PASSWORD_LENGTH  {
                    return true
                }else{
                    return false
                }
            }else {
                
                if self.txtPassword.text!.utf16.count < kMAX_PASSWORD_LENGTH {
                    return true
                }else{
                    return false
                }
                
            }
            
            
        }else if textField == self.txtCorporateCode{

            if self.txtCorporateCode.text!.utf16.count < 10{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if textField == self.txtUsername{
            
            self.txtUsername.resignFirstResponder()
            self.txtPassword.becomeFirstResponder()
            
        }else if textField == self.txtPassword{
            
            //self.txtUsername.resignFirstResponder()
            self.txtPassword.resignFirstResponder()
        }
        
        return true
        
        
        
    }
    
    
    
    //-------MARK:Added Toolbar Methods
    func addToolBar(){
        if !isToolbarAdded{
            isToolbarAdded = true
            NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.nextSelected), name: NSNotification.Name(rawValue: "keyboardNextAction"), object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.previousSelected), name: NSNotification.Name(rawValue: "keyboardPreviousAction"), object: nil)
            btnprevious = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            btnNext = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            btnprevious = txtUsername.nextPrevDoneToolbar(nextPeve: [btnprevious,btnNext]).first
            btnNext = txtPassword.nextPrevDoneToolbar(nextPeve: [btnprevious,btnNext]).last
        }
        
    }
    
    func doneWithKeyboard(){
        
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        
    }
    @objc func previousSelected(){
        if txtPassword.isFirstResponder{
            //txtPassword.resignFirstResponder()
            txtUsername.becomeFirstResponder()
        }
    }
    @objc func nextSelected(){
        if txtUsername.isFirstResponder{
            //txtUsername.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }else if txtPassword.isFirstResponder{
            txtPassword.resignFirstResponder()
        }
    }
    func customViewModelForPresentationAnimation(viewcontroller:UIViewController,view :UIView){
        self.overLayView.alpha = 0.0
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            view.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height )
        }, completion: {(Bool) -> Void in
            self.view.isUserInteractionEnabled = true
        })
        
        
        
    }
    
    func customModelForPresentationRemovalAnimation(viewcontroller:UIViewController,view :UIView){
        
        self.overLayView.alpha = 0.0
        
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            
        }) { (Bool) -> Void in
            UIView.animate(withDuration: 0.4, animations: { () -> Void in
                
                
                view.frame = CGRect(x: 0.0, y:  UIScreen.main.bounds.size.height + 20 , width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                
                
            }) { (Bool) -> Void in
                
                
            }
        }
    }
    
    
    func viewMoveUp(){
        
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.view.frame = CGRect(x: 0.0, y: -60.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    func viewDownMove(){
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.view.frame = CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })
    }
    
    
    
    
}
