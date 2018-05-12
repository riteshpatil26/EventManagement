//
//  UserService.swift
//  FirebaseApp
//
//  Created by Ritesh Patil.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile:UserProfile?
    static var currentServiceSelected :Services?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let photoURL = dict["photoURL"] as? String,
                let url = URL(string:photoURL) {
                
                userProfile = UserProfile(uid: snapshot.key, username: username, photoURL: url)
            }
            
            completion(userProfile)
        })
    }
    static func observeServiceProfile(_ uid:String, completion: @escaping ((_ userProfile:Services?)->())) {
        let userRef = Database.database().reference().child("services\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:Services?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["serviceName"] as? String
            {
                
              //  userProfile = Services(id: snapshot.key, author: username)
                
               // userProfile = Services(uid: snapshot.key, username: username, photoURL: url)
            }
            
            completion(userProfile)
        })
    }
    
    
    
}
