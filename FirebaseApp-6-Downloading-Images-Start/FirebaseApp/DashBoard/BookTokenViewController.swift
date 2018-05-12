//
//  BookTokenViewController.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
var istokenBooked :Bool = false

var bookingIdFlo :String = String()

class BookTokenViewController: UIViewController {

    var panGesture  = UIPanGestureRecognizer()
    
    @IBOutlet weak var propMainView: UIView!
    @IBOutlet weak var bookingId: UILabel!
    
    @IBOutlet weak var propViewMainToken: UIView!
    @IBOutlet weak var propViewSwipeUpToken: UIView!
    @IBOutlet weak var propViewpan: UIView!
    
    //reassigned in didappear
    var visibleTokenSize:CGFloat = 220.0
    var swipeUpTokenSize:CGFloat = 150.0
    
    var panViewX:CGFloat!
    var panViewY_Default:CGFloat!
    //    var navigationBarHeight:CGFloat = 50.0
    
    //    let leftMargin:CGFloat = 50.0
    var blurImageViewIOS7 : UIImageView?
    var rightButton:UIBarButtonItem?
    var arrTempServicesArray:NSArray = ["Cash Deposit", "Green Channel", "NEFT Upto 2 Lac"]
    
    var alert:UIAlertController!
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureHandler(_:)))
        self.view.isUserInteractionEnabled = true
        self.propViewpan.addGestureRecognizer(panGesture)
        
        propViewpan.translatesAutoresizingMaskIntoConstraints = true
        propViewMainToken.translatesAutoresizingMaskIntoConstraints = true
        propViewSwipeUpToken.translatesAutoresizingMaskIntoConstraints = true
        
        //        propBntReschedule.setTranslatesAutoresizingMaskIntoConstraints(true)
        
        self.propViewpan.center = self.view.center
        self.panViewY_Default = SCREEN_HEIGHT - visibleTokenSize
        self.panViewX = self.propViewpan.frame.origin.x
        
        print(self.propViewSwipeUpToken.frame)
        if istokenBooked == false{
        setupViewsIfValidToken_iPhone6P()
        }else{
            self.bookingId.text  = "Id" + "#" + bookingIdFlo
            setupIfBooked()
            
        }
        
        
    }
    func setupIfBooked(){
        print("Ended")
        
        if self.propViewpan.frame.origin.y > SCREEN_HEIGHT - swipeUpTokenSize - visibleTokenSize {
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //Go back to previous position
                
                self.propViewpan.frame = CGRect(x: self.panViewX, y: SCREEN_HEIGHT - self.visibleTokenSize, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                
            })
            
        }else{
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                
                //Center The token
                if IS_IPHONE_5{
                    
                    self.propViewpan.frame = CGRect(x: self.panViewX, y: -55, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                    
                    
                }else if IS_IPHONE_6{
                    
                    self.propViewpan.frame = CGRect(x: self.panViewX, y: -10, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                    
                }else if IS_IPHONE_6P{
                    
                    self.propViewpan.frame = CGRect(x: self.panViewX, y: -45, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                    
                }else {
                    self.propViewpan.frame = CGRect(x: self.panViewX + 20, y: -62, width: self.propViewpan.frame.size.width - 100 , height: self.propViewpan.frame.size.height - 200)
                    self.propViewpan.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                    
                    
                }
                
                self.propViewSwipeUpToken.frame = CGRect(x: self.propViewSwipeUpToken.frame.origin.x, y: -100, width: self.propViewSwipeUpToken.frame.size.width, height: self.propViewSwipeUpToken.frame.size.height)
                //self.propViewSwipeUpToken.alpha = 0.0
                
                self.propViewpan.isUserInteractionEnabled = false
                
                
                //                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("showAfterSwipe"), userInfo: nil, repeats: false)
                //After Swipe
                //  self.callGetTokenAPI()
                
                // Hide show info button
                //    self.showHideInfoButton(display: false)
                
            })
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                
                self.propViewSwipeUpToken.alpha = 1.0
            })
        }
        
        
    }
    
    func setupViewsIfValidToken_iPhone6P(){
        
        self.setupViews_iPhone6P(animated: true)
        
        
    }
    
    func setupViews_iPhone6P(animated animated:Bool){
        
        
        
        
        
        propViewpan.isUserInteractionEnabled = true
        
        
        
        
        self.propViewpan.center = self.view.center
        self.panViewY_Default = SCREEN_HEIGHT - visibleTokenSize
        self.panViewX = 40
        
        self.propViewpan.frame = CGRect(x: panViewX , y: SCREEN_HEIGHT, width: 335, height: 570)
        
        if animated{
            
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                
                self.propViewpan.frame = CGRect(x: self.panViewX , y: self.panViewY_Default, width: 335, height: 570)
                
            })
        }else{
            
            self.propViewpan.frame = CGRect(x: self.panViewX , y: self.panViewY_Default, width: 335, height: 570)
            
        }
        
        //propViewSwipeUpToken reinitialization
        self.propViewSwipeUpToken.alpha = 1.0
        self.propViewSwipeUpToken.frame = CGRect(x: 0, y: 0, width: propViewpan.frame.size.width, height: 180)
        
        
        //Rescedule
        
        
        //Cancel Ticket
        //  self.propBtnCancel.layer.borderColor = UIColor.AppPrimaryColor(1.0).CGColor
        
        // self.propBtnCancel.layer.backgroundColor = AppColor.AppTertiaryColor(0.5).CGColor
        // self.propBtnCancel.titleLabel?.textColor = AppColor.AppPrimaryColor(1.0)
        
        
        //Other
        
        self.propViewMainToken.frame = CGRect(x: 0.0, y: 180.0, width: self.propViewpan.frame.size.width, height: 390)
        
        
        
        
        
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if IS_IPHONE_6P{
            
            visibleTokenSize = 220.0
            swipeUpTokenSize = 180.0
            
        }else if IS_IPHONE_6{
            
            visibleTokenSize = 210.0
            swipeUpTokenSize = 180.0
            
        }else if IS_IPHONE_5{
            
            visibleTokenSize = 200.0
            swipeUpTokenSize = 150.0
            
        }else{
            
            visibleTokenSize = 100
            swipeUpTokenSize = 75.0
            self.propViewpan.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
            //            self.propCollQueue.transform = CGAffineTransformMakeScale(0.95, 0.95)
            //            self.propViewRescheduleView.transform = CGAffineTransformMakeScale(0.97, 0.97)
            //             self.propViewRescheduleView.frame = CGRect(x: self.propViewRescheduleView.frame.origin.x + 20, y: self.propViewRescheduleView.frame.origin.y , width: self.propViewRescheduleView.frame.size.width, height: ]
        }
        
        
        
        self.title = "Virtual Ticket"
        
        
        
    }
    func booking()
    {
       // self.objeOverlay.showOverlay(view: self.view)
        let randomNum:UInt32 = arc4random_uniform(9999999) // range is 0 to 99
        
        // convert the UInt32 to some other  types
        
        let randomTime:TimeInterval = TimeInterval(randomNum)
        
        let someInt:Int = Int(randomNum)
        
        let someString:String = String(randomNum)
        bookingIdFlo = someString
        let doctorRef = Database.database().reference().child("Bookings").childByAutoId()
        let doctorObject = [
            "doctor": [
                "doctorName": globalDoctorName
            ],
            "bookingId":someString,
            
            
            ] as [String:Any]
        
        doctorRef.setValue(doctorObject, withCompletionBlock: { error, ref in
            
            if error == nil {
                // self.dismiss(animated: true, completion: nil)
                
                //self.objeOverlay.hideOverlayView()
                //                let profileIdStoruboard  = UIStoryboard(name: "AdminViewController", bundle: nil)
                //                let profileVC  = profileIdStoruboard.instantiateViewController(withIdentifier: "AdminViewController")
                
                Utils.showToast(message: "Booking Created Succesfully", view: self.view, image: UIImage(named: errorImageName)!)
                
                istokenBooked = true
                self.bookingId.text = "Id" + "#" + someString
                
                
                // self.navigationController?.pushViewController(profileVC, animated: true)
                
            } else {
                // Handle the error
            }
        })
        
    }
    
    
    @objc func panGestureHandler(_ recognizer: UIPanGestureRecognizer){
        
        
        
        if recognizer.state == UIGestureRecognizerState.began{
            print("began")
        }
        
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            //            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            view.center = CGPoint(x:view.center.x,
                                  y:view.center.y + translation.y)
            
        }
        //recognizer.setTranslation(CGPointZero, in: self.view)
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == UIGestureRecognizerState.ended{
            
            print("Ended")
            
            if self.propViewpan.frame.origin.y > SCREEN_HEIGHT - swipeUpTokenSize - visibleTokenSize {
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    //Go back to previous position
                    
                    self.propViewpan.frame = CGRect(x: self.panViewX, y: SCREEN_HEIGHT - self.visibleTokenSize, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                    
                })
                
            }else{
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    //Center The token
                    if IS_IPHONE_5{
                        
                        self.propViewpan.frame = CGRect(x: self.panViewX, y: -55, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                        
                        
                    }else if IS_IPHONE_6{
                        
                        self.propViewpan.frame = CGRect(x: self.panViewX, y: -10, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                        
                    }else if IS_IPHONE_6P{
                        
                        self.propViewpan.frame = CGRect(x: self.panViewX, y: -45, width: self.propViewpan.frame.size.width, height: self.propViewpan.frame.size.height)
                        
                    }else {
                        self.propViewpan.frame = CGRect(x: self.panViewX + 20, y: -62, width: self.propViewpan.frame.size.width - 100 , height: self.propViewpan.frame.size.height - 200)
                        self.propViewpan.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
                        
                        
                    }
                    
                    self.propViewSwipeUpToken.frame = CGRect(x: self.propViewSwipeUpToken.frame.origin.x, y: -100, width: self.propViewSwipeUpToken.frame.size.width, height: self.propViewSwipeUpToken.frame.size.height)
                    //self.propViewSwipeUpToken.alpha = 0.0
                    
                    self.propViewpan.isUserInteractionEnabled = false
                    
                    
                    //                    NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("showAfterSwipe"), userInfo: nil, repeats: false)
                    //After Swipe
                    //  self.callGetTokenAPI()
                    
                    // Hide show info button
                    //    self.showHideInfoButton(display: false)
                    
                })
                
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    
                    self.propViewSwipeUpToken.alpha = 1.0
                })
            }
            
            booking()
            
        }
        
        if recognizer.state == UIGestureRecognizerState.changed{
            
            
            print("Changed")
            print(propViewpan.frame.origin.y)
            
            
            if self.propViewpan.frame.origin.y >= SCREEN_HEIGHT - swipeUpTokenSize - visibleTokenSize {
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    self.propViewSwipeUpToken.alpha = 1
                    self.propViewSwipeUpToken.frame = CGRect(x: self.propViewSwipeUpToken.frame.origin.x, y: 0, width: self.propViewSwipeUpToken.frame.size.width, height: self.propViewSwipeUpToken.frame.size.height)
                    
                })
                
            }else{
                
                /*
                 UIView.animateWithDuration(0.5, animations: { () -> Void in
                 
                 self.propViewSwipeUpToken.alpha = 0.6
                 self.propViewSwipeUpToken.frame = CGRect(x: self.propViewSwipeUpToken.frame.origin.x, y: -20, width: self.propViewSwipeUpToken.frame.size.width, height: self.propViewSwipeUpToken.frame.size.height)
                 
                 })
                 */
                
                UIView.animate(withDuration: 0.5, animations: { () -> Void in
                    
                    //self.propViewSwipeUpToken.alpha = 0.6
                    self.propViewSwipeUpToken.frame = CGRect(x: self.propViewSwipeUpToken.frame.origin.x, y: -20, width: self.propViewSwipeUpToken.frame.size.width, height: self.propViewSwipeUpToken.frame.size.height)
                    
                })
                
                
                print("Percentage")
                
                let percentage:CGFloat = (self.propViewpan.frame.origin.y) / (SCREEN_HEIGHT - swipeUpTokenSize - visibleTokenSize)
                
                if percentage >= 0 && percentage <= 1.0{
                    
                    self.propViewSwipeUpToken.alpha = percentage - 0.2
                }
                
            }
        }
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
