//
//  User.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
   
    
    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        
    }
}


