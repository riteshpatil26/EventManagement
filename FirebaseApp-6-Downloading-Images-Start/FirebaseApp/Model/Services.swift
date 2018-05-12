//
//  Services.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

class Services: NSObject {

    var id:String
    
    var serviceName:String
var photoURL : String!
 
    
    init(author:String,photoUrl:String) {
      self.id = "10"
        self.serviceName = author
        self.photoURL = photoUrl
    }
    
}
