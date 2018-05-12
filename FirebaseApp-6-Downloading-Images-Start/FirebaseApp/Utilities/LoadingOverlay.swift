//
//  Created by Ritesh on 21/09/15.
//  Copyright (c) 2018 Ritesh. All rights reserved.
//


import UIKit
import Foundation


public class LoadingOverlay{
    
    var overlayView = UIView()
    var activityIndicatorMD:activityIndicator = activityIndicator()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    
    public func showOverlay(view: UIView!) {
        overlayView = UIView(frame: UIScreen.main.bounds)
       // overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        activityIndicatorMD.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicatorMD.lineWidth = 3.0
        //R:54, G:188, B:176
       //activityIndicator.color = UIColor(red: 54.0/255, green: 188.0/255, blue: 176.0/255, alpha: 1)
        //activityIndicator.color = UIColor.purple
        //UIScreen.main.bounds.width/2 - 10
        
        //CGRect visibleRect = CGRectIntersection(self.frame, superview.bounds);
        //let visibleRect = view.frame.intersection(UIScreen.main.bounds)
        activityIndicatorMD.center = overlayView.center
        overlayView.addSubview(activityIndicatorMD)
        activityIndicatorMD.startLoading()
        self.overlayView.alpha = 0
        view.addSubview(overlayView)
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.overlayView.alpha = 1
        }) { (Bool) in
            
            //self.activityIndicator.stopAnimating()
            //self.overlayView.removeFromSuperview()
        }
}
    
    public func hideOverlayView() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.overlayView.alpha = 0
        }) { (Bool) in
            
            self.activityIndicatorMD.completeLoading(success: true)
            self.overlayView.removeFromSuperview()
        }
    }
    
    
}
