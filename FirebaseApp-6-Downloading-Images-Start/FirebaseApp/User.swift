//
//  User.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//

import UIKit

class User: NSObject,NSCoding {

    var username : String!
    var password : String!
    var deviceToken : String!
    var profilePicUri : String!
    var userId : NSNumber!
    var firstName : String!
    var lastName : String!
    var corporateName : String!
    var gender:String!
    var authorizationToken : String!
    var location : String!
    var mobileNumber : String!
    var dateOfBirth : String!
    var isProFilePic : Bool
    var fitbitAuthUrl: String!
    var integratedDevice : String!
    
    
    
    
    func loadData(obj : User){
        
        self.username = obj.username
        self.password = obj.password
        self.deviceToken = obj.deviceToken
        self.profilePicUri = obj.profilePicUri
        self.userId = obj.userId
        
        
        self.firstName = obj.firstName
        self.lastName = obj.lastName
        self.corporateName = obj.corporateName
        self.gender = obj.gender
        self.authorizationToken = obj.authorizationToken
        
        
        self.gender = obj.location
        self.mobileNumber = obj.mobileNumber
        self.dateOfBirth = obj.dateOfBirth
        self.isProFilePic = obj.isProFilePic
        self.fitbitAuthUrl = obj.fitbitAuthUrl
        self.integratedDevice = obj.integratedDevice
        
    }
    
    
    
    init(obj : User){
        
        
        self.username = obj.username
        self.password = obj.password
        self.deviceToken = obj.deviceToken
        self.profilePicUri = obj.profilePicUri
        self.userId = obj.userId
        
        
        self.firstName = obj.firstName
        self.lastName = obj.lastName
        self.corporateName = obj.corporateName
        self.gender = obj.gender
        self.authorizationToken = obj.authorizationToken
        
        
        self.gender = obj.location
        self.mobileNumber = obj.mobileNumber
        self.dateOfBirth = obj.dateOfBirth
        self.isProFilePic = obj.isProFilePic
        self.fitbitAuthUrl = obj.fitbitAuthUrl
        self.integratedDevice = obj.integratedDevice
    }
    
    override init()
    {
        
       
        self.username = ""
        self.password = ""
        self.deviceToken = ""
        self.profilePicUri = ""
        self.userId = 0
        
        
        self.firstName = "Patrick"
        self.lastName = "Hogan"
        self.corporateName = "walkMymind"
        self.gender = "Male"
        self.authorizationToken = ""
        
        
        self.gender = "Mumbai"
        self.mobileNumber = ""
        self.dateOfBirth = ""
        self.isProFilePic = false
        self.fitbitAuthUrl = ""
        self.integratedDevice = ""
 
        
    }
    
    
    
    init(dataDictionary:NSDictionary)
    {
        
        if let name = dataDictionary["firstName"] as? String{
            self.firstName = name
        }
        if let lname = dataDictionary["lastName"] as? String{
            self.lastName = lname
        }
        if let cCode =  dataDictionary["corporateName"] as? String{
            self.corporateName = cCode
        }
        if let gender = dataDictionary["gender"] as? String{
            self.gender = gender
        }
        if let id = dataDictionary["id"] as? NSNumber{
            self.userId = id
        }
        if let location =  dataDictionary["location"] as? String{
            self.location = location
        }
        if let mobile = dataDictionary["mobNo"] as? String{
            self.mobileNumber = mobile
        }
        if let picUrl = dataDictionary["profilePicUri"] as? String{
            self.profilePicUri = picUrl
        }
        if let token = dataDictionary["userDeviceToken"] as? String{
            self.deviceToken = token
        }
        if let dob = dataDictionary["dob"] as? String{
            self.dateOfBirth = dob
        }
        if let isPP = dataDictionary["isProFilePic"] as? Bool{
            self.isProFilePic = isPP
        }else{
            self.isProFilePic = false
        }
        if let fitbitUrl = dataDictionary["fitbitAuthUrl"] as? String{
             self.fitbitAuthUrl = fitbitUrl
        }
        if let integratedDev = dataDictionary["integratedDevice"] as? String{
            self.integratedDevice = integratedDev
        }
       // self.isProFilePic = obj.isProFilePic
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        
        
        if let uName = aDecoder.decodeObject(forKey: "username") as? String{
            self.username = uName
        }
        
        if let name = aDecoder.decodeObject(forKey: "firstName") as? String{
            self.firstName = name
        }
        if let lname = aDecoder.decodeObject(forKey: "lastName") as? String{
            self.lastName = lname
        }
        if let cCode =  aDecoder.decodeObject(forKey: "corporateName") as? String{
            self.corporateName = cCode
        }
        if let gender = aDecoder.decodeObject(forKey: "gender") as? String{
            self.gender = gender
        }
        if let id = aDecoder.decodeObject(forKey: "userId") as? NSNumber{
            self.userId = id
        }
        if let location =  aDecoder.decodeObject(forKey: "location") as? String{
            self.location = location
        }
        if let mobile = aDecoder.decodeObject(forKey: "lastName") as? String{
            self.mobileNumber = mobile
        }
        if let picUrl = aDecoder.decodeObject(forKey: "mobileNumber") as? String{
            self.profilePicUri = picUrl
        }
        if let token = aDecoder.decodeObject(forKey: "deviceToken") as? String{
            self.deviceToken = token
        }
        
        if let mobile = aDecoder.decodeObject(forKey: "mobileNumber") as? String{
            self.mobileNumber = mobile
        }
        
        if let dob = aDecoder.decodeObject(forKey: "dateOfBirth") as? String{
            self.dateOfBirth = dob
        }
        if let token = aDecoder.decodeObject(forKey: "authorizationToken") as? String{
            self.authorizationToken = token
        }
        
        if let pass = aDecoder.decodeObject(forKey: "password") as? String{
            self.password = pass
        }
        if let isPP = aDecoder.decodeObject(forKey: "isProFilePic") as? Bool{
            self.isProFilePic = isPP
        }else{
            self.isProFilePic = false
        }
        //integratedDevice
        if let fitbitUrl = aDecoder.decodeObject(forKey: "fitbitAuthUrl") as? String{
            self.fitbitAuthUrl = fitbitUrl
        }
        
        if let integratedDev = aDecoder.decodeObject(forKey: "integratedDevice") as? String{
            self.integratedDevice = integratedDev
        }
        
        
    }
    func encode(with aCoder: NSCoder){
        
        
        aCoder.encode(username, forKey: "username")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(corporateName, forKey: "corporateName")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(mobileNumber, forKey: "mobileNumber")
        aCoder.encode(profilePicUri, forKey: "profilePicUri")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(deviceToken, forKey: "deviceToken")
        aCoder.encode(dateOfBirth, forKey: "dateOfBirth")
        aCoder.encode(authorizationToken, forKey: "authorizationToken")
        aCoder.encode(isProFilePic, forKey: "isProFilePic")
        aCoder.encode(fitbitAuthUrl, forKey: "fitbitAuthUrl")
        aCoder.encode(integratedDevice, forKey: "integratedDevice")
        
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        
        
        aCoder.encode(username, forKey: "username")
        aCoder.encode(firstName, forKey: "firstName")
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(corporateName, forKey: "corporateName")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(userId, forKey: "userId")
        
        
        aCoder.encode(location, forKey: "location")
        aCoder.encode(mobileNumber, forKey: "mobileNumber")
        aCoder.encode(profilePicUri, forKey: "profilePicUri")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(deviceToken, forKey: "deviceToken")
        aCoder.encode(dateOfBirth, forKey: "dateOfBirth")
        aCoder.encode(authorizationToken, forKey: "authorizationToken")
        aCoder.encode(isProFilePic, forKey: "isProFilePic")
        aCoder.encode(integratedDevice, forKey: "integratedDevice")
        // var authorizationToken : String!
        
    }
    
}
