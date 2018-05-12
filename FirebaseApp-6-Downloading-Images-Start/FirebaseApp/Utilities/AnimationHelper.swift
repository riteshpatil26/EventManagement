//
//  AnimationHelper.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

class AnimationHelper: NSObject {
    
    static func translateLogoAnimation(view: UIView, duration: Double, delay: Double, options: UIViewAnimationOptions, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, nextAnimation:(_ sampleParameter: String) -> Void){
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: options,
            animations: {
                view.translatesAutoresizingMaskIntoConstraints = true
                view.frame = CGRect(x: x, y: y, width: width, height: height)
            },
            completion: { finished in
                
            }
        )
    }

}
