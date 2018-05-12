//
//  Doctor.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/24/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

class Doctor: NSObject {

    var id:String!
     var service :Services!
    var doctorName:String!
   
     var doctorAddress:String!
     var doctorPhoneNumber:String!
    var doctorRating:String!
    var doctorDescription :String!
    var photoURL : String!
    
    init(id:String, doctorName:String, doctorAddress : String,doctorPhoneNumber :String,service : Services,doctorRating:String,doctorDescription :String,photoUrl : String) {
        self.id = id
        self.doctorName = doctorName
        self.doctorAddress = doctorAddress
        self.doctorPhoneNumber = doctorPhoneNumber
        self.service = service
        self.doctorRating = doctorRating
        self.doctorDescription = doctorDescription
        self.photoURL = photoUrl
       // self.photoURL = photoUrl
        
    }
    
    
    
    
}
