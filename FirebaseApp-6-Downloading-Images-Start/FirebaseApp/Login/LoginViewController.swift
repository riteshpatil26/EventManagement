//
//  LoginViewController.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController ,VersionLabelAlpha{

    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var wmm_Logo_ImageView: UIImageView!
    @IBOutlet weak var logoContainerView: UIView!
    @IBOutlet weak var wmm_slogan_ImageView: UIImageView!
    @IBOutlet weak var horizontalLine: UIView!
    var signInViewControllerObject :SignInViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         addSlideMenuButton()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        print("viewDidLoad")
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Helvetica Neue", size: 20)!,NSAttributedStringKey.foregroundColor: UIColor.white]
         self.startupAnimation()
        
        self.versionLbl.alpha = 0
    
    
     NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.closeVersionProfileViewMethod), name: NSNotification.Name(rawValue: "closeverisonForSignUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.animationForVersion), name: NSNotification.Name(rawValue: "showverisonForSignUp"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector:  #selector(self.firstTimeSignInClicked), name: NSNotification.Name(rawValue: "firstTimeSign"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
      
    }
    
    @objc func closeVersionProfileViewMethod(){
        
        self.versionLbl.alpha = 0
    }
    
    func versionLabelAlpha(){
        UIView.animate(withDuration: 4.5) {
            self.versionLbl.alpha = 1
        }
        
    }
    func verisonForSignUp()
    {
        self.versionLbl.alpha = 0
        
    }
    
    func firstTimeSignInClicked(){
        
     
        
        
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.horizontalLine.alpha = 0
                self.wmm_slogan_ImageView.alpha = 0
        },
            completion: { finished in
                
                UIView.animate(
                    withDuration: 1.0,
                    animations: {
                        self.logoContainerView.translatesAutoresizingMaskIntoConstraints = true
                        
                        self.logoContainerView.frame = CGRect(x: self.view.frame.width/2 - self.logoContainerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: ViewType.Logo) + Utils.getYPosition(y: -60, error: 0,0,0), width: self.logoContainerView.frame.width, height: self.logoContainerView.frame.height)
                },
                    completion: { finished in
                        
                        
                }
                )
                
        }
        )
    }

    
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
//        print(wmm_Logo_ImageView.frame)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        
        self.versionLbl.text = Utils.getAppVersion()
        
    
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        

//        print(logoContainerView.frame.size)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
//        print(wmm_Logo_ImageView.frame)
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")
//        print(wmm_Logo_ImageView.frame)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func startupAnimation(){
        //logoAlphaAnimation()
        
        
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(LoginViewController.animationForVersion), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(LoginViewController.logoAlphaAnimation), userInfo: nil, repeats: false)
    }
    
    @objc func animationForVersion()  {
        
        
        UIView.animate(withDuration: 0.5) {
            self.versionLbl.alpha = 1
        }

        
        
    }
    
    @objc func logoAlphaAnimation(){
        self.translateLogoAnimation()
    }
    
    private func translateLogoAnimation(){
        
        if let  user = Utils.loadObjectInNSUserDefaults(key: "logedInUser") as? User{
            
           
            
            self.loadSingInView()
            
        }else{
            
            let isFirstTimeSignUpOptionsShown = UserDefaults.standard.bool(forKey: HAS_FIRST_SCREEN_BEEN_SHOWN)
            
            if isFirstTimeSignUpOptionsShown{
                
                
                UIView.animate(
                    withDuration: 1.0,
                    animations: {
                        self.horizontalLine.alpha = 0
                        self.wmm_slogan_ImageView.alpha = 0
                },
                    completion: { finished in
                        
                        UIView.animate(
                            withDuration: 1.0,
                            animations: {
                              
                                
                                self.logoContainerView.translatesAutoresizingMaskIntoConstraints = true
                                
                                self.logoContainerView.frame = CGRect(x: self.view.frame.width/2 - self.logoContainerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: ViewType.Logo) + Utils.getYPosition(y: -60, error: 0,0,0), width: self.logoContainerView.frame.width, height: self.logoContainerView.frame.height)
                                
                        },
                            completion: { finished in
                                
                                let signInVC = UIStoryboard(name: "Login", bundle: nil)
                                if #available(iOS 10.0, *) {
                                   
                                    
                                    
                                    
                                    if let signInController = signInVC.instantiateViewController(withIdentifier: "SignIn") as? SignInViewController {
                                        //signInController.view.frame = CGRect(x: 0, y: self.logoContainerView.frame.maxY + Utils.getYPosition(y: -20, error: 0,0,0), width: self.view.frame.width, height: self.view.frame.height)
                                        self.signInViewControllerObject = signInController
                                        signInController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                                        signInController.delegateVersion = self
                                        self.addChildViewController(signInController)
                                        self.view.addSubview(signInController.view)
                                        self.view.bringSubview(toFront: signInController.view)
                                        //self.present(signInController, animated: true, completion: nil)
                                    }
                                } else {
                                    // Fallback on earlier versions
                                    
                                  
                                    
                                    if let signInController = signInVC.instantiateViewController(withIdentifier: "SignIn") as? SignInViewController {
                                        //signInController.view.frame = CGRect(x: 0, y: self.logoContainerView.frame.maxY + Utils.getYPosition(y: -20, error: 0,0,0), width: self.view.frame.width, height: self.view.frame.height)
                                        self.signInViewControllerObject = signInController
                                        signInController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                                        signInController.delegateVersion = self
                                        self.addChildViewController(signInController)
                                        self.view.addSubview(signInController.view)
                                        self.view.bringSubview(toFront: signInController.view)
                                        //self.present(signInController, animated: true, completion: nil)
                                    }
                                    
                                }
                                
                        }
                        )
                        
                }
                )
                
                
                
            }
            else{
                
                
                UIView.animate(
                    withDuration: 1.0,
                    animations: {
                        self.logoContainerView.translatesAutoresizingMaskIntoConstraints = true
                        
                            self.logoContainerView.frame = CGRect(x: self.view.frame.width/2 - self.logoContainerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: ViewType.Logo) , width: self.logoContainerView.frame.width, height: self.logoContainerView.frame.height)
                },
                    completion: { finished in
                        
                        let signInVC = UIStoryboard(name: "Login", bundle: nil)
                        if #available(iOS 10.0, *) {
                            if let signInController = signInVC.instantiateViewController(withIdentifier: "SignIn") as? SignInViewController {
                                //signInController.view.frame = CGRect(x: 0, y: self.logoContainerView.frame.maxY + Utils.getYPosition(y: -20, error: 0,0,0), width: self.view.frame.width, height: self.view.frame.height)
                                self.signInViewControllerObject = signInController
                                signInController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                                signInController.delegateVersion = self
                                self.addChildViewController(signInController)
                                self.view.addSubview(signInController.view)
                                self.view.bringSubview(toFront: signInController.view)
                                //self.present(signInController, animated: true, completion: nil)
                            }
                        } else {
                            // Fallback on earlier versions
                            
                            if let signInController = signInVC.instantiateViewController(withIdentifier: "SignIn") as? SignInViewController {
                                //signInController.view.frame = CGRect(x: 0, y: self.logoContainerView.frame.maxY + Utils.getYPosition(y: -20, error: 0,0,0), width: self.view.frame.width, height: self.view.frame.height)
                                self.signInViewControllerObject = signInController
                                signInController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                                signInController.delegateVersion = self
                                self.addChildViewController(signInController)
                                self.view.addSubview(signInController.view)
                                self.view.bringSubview(toFront: signInController.view)
                                //self.present(signInController, animated: true, completion: nil)
                            }
                            
                        }
                        
                }
                )
                
                
            }
        }
    }
    
    
    
    func loadSingInView(){
        
        self.logoContainerView.translatesAutoresizingMaskIntoConstraints = true
        self.logoContainerView.frame = CGRect(x: self.view.frame.width/2 - self.logoContainerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: ViewType.Logo) + Utils.getYPosition(y: -60, error: 0,0,0), width: self.logoContainerView.frame.width, height: self.logoContainerView.frame.height)
        
        self.horizontalLine.alpha = 0
        self.wmm_slogan_ImageView.alpha = 0
        
        let signInVC = UIStoryboard(name: "Login", bundle: nil)
        if let signInController = signInVC.instantiateViewController(withIdentifier: "SignIn") as? SignInViewController {
            //signInController.view.frame = CGRect(x: 0, y: self.logoContainerView.frame.maxY + Utils.getYPosition(y: -20, error: 0,0,0), width: self.view.frame.width, height: self.view.frame.height)
            self.signInViewControllerObject = signInController
            signInController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.addChildViewController(signInController)
            self.view.addSubview(signInController.view)
            self.view.bringSubview(toFront: signInController.view)
            
             /*self.logoContainerView.frame = CGRect(x: self.view.frame.width/2 - self.logoContainerView.frame.width/2, y: self.getYPositionValueForAnimation(viewType: ViewType.Logo), width: self.logoContainerView.frame.width, height: self.logoContainerView.frame.height)*/
            
            
            
            
    }
    
    }
    
    //Variables for Animation
    private enum ViewType{
        case Logo
        case Username
        case WhiteSeparator
        case Password
        case SignIn
        case ForgotPassword
        case SignUp
    }
    
    private func getYPositionValueForAnimation(viewType: ViewType) -> CGFloat {
        switch viewType {
        case .Logo:
            //return topView.frame.maxY - wmmLogo.frame.height - Utils.getYPosition(2.5)
            return Utils.getYPosition(y: 160, error: 0,0,0)
        case .Username:
//            return Utils.getYPosition(61)
            return 0
        case .WhiteSeparator:
//            return self.username.frame.origin.y + username.frame.height + Utils.getYPosition(9)
            return 0
        case .Password:
//            return self.whiteSeparator.frame.origin.y + whiteSeparator.frame.height + Utils.getYPosition(9)
            return 0
        case .SignIn:
//            return self.password.frame.origin.y + password.frame.height + Utils.getYPosition(61)
            return 0
        case .ForgotPassword:
//            return self.signIn.frame.origin.y + signIn.frame.height + Utils.getYPosition(23)
            return 0
        case .SignUp:
            return 0
        }
    }
    
}
