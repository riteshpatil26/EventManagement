
//
//  Created by Ritesh on 21/09/15.
//  Copyright (c) 2018 Ritesh. All rights reserved.
//
import UIKit
import Firebase
class BaseViewController: UIViewController, SlideMenuDelegate {
    
   var overlayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        
        self.overlayView.removeFromSuperview()
    
        switch(index){
        
        case 0:
            print("Logout")
  
            self.navigationController?.popToRootViewController(animated: true)
            isFromAdmin = false
           
            break
            
        default:
            print("default\n", terminator: "")
        }
    
}

  

    func openViewController(viewController : UIViewController){
        
         let destViewController = viewController
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print(topViewController)
        if (topViewController == destViewController){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
      
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
         btnShowMenu.tintColor = UIColor.white
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        
       
        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
    func addSlideSerachButton(){
        let btnShowMenu = UIButton(type: UIButtonType.system)
        
        
        btnShowMenu.setImage(self.defaultMenuImage(), for: UIControlState())
       
        
        //btnShowMenu.ba = btnShowMenu.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
        
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.navigationItem.rightBarButtonItem = customBarItem;
    }
    

       
    func defaultMenuImage() -> UIImage {
        var defaultMenuImage = UIImage()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 30, height: 22), false, 0.0)
        
       //  UIColor.black.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
        
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
        
        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
       
        return defaultMenuImage;
    }
    
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        
        
        
        
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.overlayView.removeFromSuperview()
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
                }, completion: { (finished) -> Void in
                    viewMenuBack.removeFromSuperview()
                    
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuStoruboard  = UIStoryboard(name: "Menu", bundle: nil)
        let menuVC : MenuViewController = menuStoruboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController

        menuVC.btnMenu = sender
        menuVC.delegate = self
 
        UIApplication.shared.keyWindow?.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        // self.view.addSubview(menuVC.view)
        menuVC.view.layoutIfNeeded()
        menuVC.view.layer.shadowOffset = CGSize(width: 3, height: 3)
        menuVC.view.layer.shadowOpacity = 0.7
        menuVC.view.layer.shadowRadius = 5
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        // UIApplication.sharedApplication().keyWindow?.bringSubviewToFront(menuVC.view)
        
        
        overlayView = UIView(frame: (UIApplication.shared.keyWindow?.frame)!)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.navigationController?.view.addSubview(overlayView)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            
            
            self.overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
           // menuVC.view.frame=CGRect(0, 0, UIScreen.main.bounds.size.width , UIScreen.main.bounds.size.height)
            sender.isEnabled = true
            }, completion:{ Bool in
                
                self.navigationController?.view.bringSubview(toFront: menuVC.view)
                //                self.view.bringSubviewToFront(menuVC.view)
                
        })
  
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
            }, completion:nil)
    }
}
