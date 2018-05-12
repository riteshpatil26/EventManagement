//
//  LoginHelper.swift
//  WMM
//
//  Created by Prem Ranjan on 25/11/16.
//  Copyright © 2016 Dhaval Gogri. All rights reserved.
//

import UIKit

class LoginHelper: NSObject {
    
    
    class func getObjectFromDictionary(dataDictionary : Dictionary<String,Any>) -> User{
        
       
        print(dataDictionary)
        let objUser : User = User()
        
        if let uName = dataDictionary["userName"] as? String{
            objUser.username = uName
        }
        if let name = dataDictionary["firstName"] as? String{
            objUser.firstName = name
        }else{
            objUser.firstName = ""
        }
        if let lname = dataDictionary["lastName"] as? String{
            objUser.lastName = lname
        }
        if let cCode =  dataDictionary["corporateName"] as? String{
            objUser.corporateName = cCode
        }
        if let gender = dataDictionary["gender"] as? String{
            objUser.gender = gender
        }else{
            objUser.gender = ""
        }
        if let id = dataDictionary["id"] as? NSNumber{
            objUser.userId = id as NSNumber!
            
            
            print(id)
            
            print(objUser.userId)
        }
        if let location =  dataDictionary["location"] as? String{
            objUser.location = location
        }else{
            objUser.location = ""
        }
        if let mobile = dataDictionary["mobNo"] as? String{
            objUser.mobileNumber = mobile
        }else{
            objUser.mobileNumber = ""
        }
        if let picUrl = dataDictionary["profilePicUri"] as? String{
            objUser.profilePicUri = picUrl
        }
        if let token = dataDictionary["userDeviceToken"] as? String{
            objUser.deviceToken = token
        }
        if let dob = dataDictionary["dob"] as? String{
            objUser.dateOfBirth = dob
        }
        
        if let fitbitUrl = dataDictionary["fitbitAuthUrl"] as? String{
            objUser.fitbitAuthUrl = fitbitUrl
        }
        
       
        
        
        //print(dataDictionary["integratedDevice"] as! String)
        
        
        if let integratedDev = dataDictionary["integratedDevice"] as? String{
            objUser.integratedDevice = integratedDev
            print(dataDictionary["integratedDevice"] as! String)
        }
        return objUser
    }
    
    class func getDictionaryFromObject(objUser : User)-> Dictionary<String,Any>{
    var dataDictionary : Dictionary<String,Any> = Dictionary()
        
        
        if let gender = objUser.gender {
             dataDictionary["gender"] = gender
        }
        
    if let mobile = objUser.mobileNumber{
             dataDictionary["mobNo"] = mobile
        }
        if let dob = objUser.dateOfBirth {
            dataDictionary["dob"] = dob
        }

        return dataDictionary
    }
   class func getJSONData(_ dict :NSDictionary) -> Data{
        
        let errors:NSErrorPointer? = nil;
        
        
        let parseJSONData : Data = try! JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions(rawValue: 0))
        let ss:NSString = NSString(data: parseJSONData, encoding: String.Encoding.utf8.rawValue)!
        
        print(ss)
        if errors != nil{
            print("Error! While parsing data.")
        }
        
        return parseJSONData
    }

    class func dateFormate(dateInString : String, fromDateFormate : String,ToDateFromate : String)->String{
        
        
        print(dateInString)
        let dateString = "11/30/1998" //dateInString
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormate //"yyyy/MM/DD" //"EEE, dd MMM yyy hh:mm:ss +zzzz"
        //        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        //dateFormatter.locale =  NSLocale(localeIdentifier: "en_IN") as Locale!
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+5:30") as TimeZone!
        if let dateObj = dateFormatter.date(from: dateString){
        
        print(dateObj)
        dateFormatter.dateFormat = ToDateFromate//"MM-dd-yyyy"
        print("Dateobj: \(dateFormatter.string(from: dateObj))")
            return dateFormatter.string(from: dateObj)
        }else{
            return ""
        }
    }
    
}
