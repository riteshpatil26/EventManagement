//
//  Utils.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2017 Ritesh Patil. All rights reserved.
//

import Foundation
import UIKit

public class Utils {
    
    static func getYPosition(y : Double, error: CGFloat...) -> CGFloat{
        /*
        Note:- 
         error[0] = 5
         error[1] = 6
         error[2] = 6P
        */
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let basicPosition = ((CGFloat(y) * screenHeight) / 568)
        switch(screenHeight){
            case 568.0:
                return basicPosition + ((error[0] * screenHeight) / 568)
            case 667.0:
                return basicPosition + ((error[1] * screenHeight) / 568)
            case 736.0:
                return basicPosition + ((error[2] * screenHeight) / 568)
            default:
                return basicPosition + ((error[0] * screenHeight) / 568)
        }
    }
    
    class func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    class func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    class func changeImageViewColor(theImageView:UIImageView,color :UIColor)
    {
        theImageView.image = theImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        theImageView.tintColor = color
        
    }
    
    class func showWarningAppAlert(message : NSString , delegate: AnyObject!) {
        
        var alert : UIAlertView = UIAlertView()
        alert.title = "MAP_RENAMEunt"
        alert.delegate = delegate
        alert.message = message as String
        alert.addButton(withTitle: "OK")
        alert.show()
    }
    
    
    static func getXPosition(x : Double, error: CGFloat...) -> CGFloat{
        /*
         Note:-
         error[0] = 5
         error[1] = 6
         error[2] = 6P
         */
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let basicPosition = ((CGFloat(x) * screenWidth) / 320)
        switch(screenWidth){
        case 320.0:
            return basicPosition + ((error[0] * screenWidth) / 320)
        case 375.0:
            return basicPosition + ((error[1] * screenWidth) / 320)
        case 414.0:
            return basicPosition + ((error[2] * screenWidth) / 320)
        default:
            return basicPosition + ((error[0] * screenWidth) / 320)
        }
    }
    
    static func getAppVersion() -> String{
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "Version "+version
        }
        return ""
    }
    
    class func setMaxLength(string : NSString , length : Int) -> Bool{
        if length < string.length{
            return false
        }
        return true
    }
    
    class func setMinLength(string : NSString , minLength : Int) -> Bool {
        if minLength < string.length{
            return true
        }
        return false
    }

    
    
    // -------------------NSUser Defaults ----------------------------------
    static func saveDataInNSUserDefaults(key : String , obj : AnyObject){
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(obj, forKey: key)
        defaults.synchronize()
    }
    
    static func saveStringInNSUserDefaults(key : String , obj : String){
        let defaults: UserDefaults = UserDefaults.standard
        //defaults.set(obj, forKey: key)
        //defaults.set
        defaults.synchronize()
    }
    static func loadDataFromNSuserDefaults(key : String ) -> AnyObject {
        let defaults: UserDefaults = UserDefaults.standard
        if (defaults.object(forKey: key) == nil){
            return NSNull()
        }else{
            return defaults.object(forKey: key)! as AnyObject
        }
    }
    
    static func saveObjectInNSUserDefaults(key : String , obj : AnyObject){
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: obj)
        let defaults = UserDefaults.standard
        defaults.set(archivedObject, forKey: key)
        defaults.synchronize()
    }
    
    static func loadObjectInNSUserDefaults(key : String) -> AnyObject{
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? NSData {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as AnyObject!
        }
        return NSNull()
    }
    
    static func borderToLabel(label:UIView, color: CGColor){
        
        label.layer.borderWidth = CGFloat(0.4)
        label.layer.borderColor = color//UIColor.white.cgColor
        label.layer.borderWidth = 1
       // label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.clipsToBounds = true
    }
    
    static func borderToImageView(label:UIView, color: CGColor){
        
        label.layer.borderWidth = CGFloat(0.4)
        label.layer.borderColor = color//UIColor.white.cgColor
        label.layer.borderWidth = 2
        // label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.clipsToBounds = true
    }
    
    static func removeDataFromNSUserDefaults(key : String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "http://google.com/")
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        //var response: URLResponse?
        
       // _ = (try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)) as NSData?
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (
            data, response, error) in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response  , error == nil else {
                print("error")
                return
            }
            
            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            
            //print(dataString)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    Status = true
                }
            }

            
        }
        
        task.resume()

        
        
        return Status
    }
    
    class func getCurrentDate() -> String{
    
        let todaydate : Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: todaydate as Date)
    }
    
    static func secondsToHoursMinutesSeconds (hours : Int,minutes :Int ,seconds :Int) -> (Int) {
        print(hours * 3600 + minutes * 60 + seconds)
        return  hours * 3600 + minutes * 60 + seconds
    }
    static func cancelAllScheduleNotification(){
        UIApplication.shared.cancelAllLocalNotifications()
        
    }
    
    
    /*static func sucesssToast(message: String, view: UIView){
        var style = ToastStyle()
        style.messageColor = UIColor.white
        style.backgroundColor = kGREEN_COLOR
        style.cornerRadius = 2.0
        UIApplication.shared.keyWindow!.makeToast(message , duration: 5.0, position: .top, style: style)
        ToastManager.shared.style = style
        ToastManager.shared.tapToDismissEnabled = true
        ToastManager.shared.queueEnabled = false
    }*/
    
    static func showToast(message: String, view: UIView, image: UIImage){
        var style = ToastStyle()
        style.messageColor = UIColor.white
        style.backgroundColor = UIColor.red
        style.cornerRadius = 2.0
        //UIApplication.shared.keyWindow!.makeToast(message , duration: 5.0, position: .center, style: style)
        UIApplication.shared.keyWindow!.makeToast(message, duration: 5.0, position: .center, title: "", image: image  , style: style, completion: nil)
        ToastManager.shared.style = style
        ToastManager.shared.tapToDismissEnabled = true
        ToastManager.shared.queueEnabled = false
        ToastManager.shared.isFromProfile = false
        
    }
    
    static func clearProfilePicfromSystem()
    {
        
        let fileNameToDelete = "profilePic.jpg"
        var filePath = ""
        
        // Fine documents directory on device
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appendingFormat("/" + fileNameToDelete)
            print("Local path = \(filePath)")
            
        } else {
            print("Could not find local directory to store file")
            return
        }
        
        
        do {
            let fileManager = FileManager.default
            
            // Check if file exists
            if fileManager.fileExists(atPath: filePath) {
                // Delete file
                try fileManager.removeItem(atPath: filePath)
            } else {
                print("File does not exist")
            }
            
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }
    }

    
    /*static func showToastWithOverlay(message: String, view: UIView){
        let overlay: UIView = UIView()
        overlay.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        UIApplication.shared.keyWindow!.addSubview(overlay)
        var style = ToastStyle()
        style.messageColor = UIColor.white
        style.backgroundColor = UIColor(red: 192.0/255.0, green: 17.0/255.0, blue: 17.0/255.0, alpha: 1.0)  //kTOAST_COLOR
        style.cornerRadius = 2.0
        UIApplication.shared.keyWindow!.makeToast(message , duration: 3.0, position: .center, style: style)
        ToastManager.shared.style = style
        ToastManager.shared.tapToDismissEnabled = false
        ToastManager.shared.queueEnabled = false
        UIView.animate(
            withDuration: 1.0,
            delay: 4.0,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: {
                overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            },
            completion: { finished in
                overlay.removeFromSuperview()
            }
        )
    }*/
    
    
    
    class func getJSONData(dict :NSDictionary) -> NSData{
        
        //let errors:NSErrorPointer = NSErrorPointer();
        
        
        let parseJSONData : NSData = try! JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions(rawValue: 0)) as NSData
        let ss:NSString = NSString(data: parseJSONData as Data, encoding: String.Encoding.utf8.rawValue)!
        
        print(ss)
        //if errors != nil{
           // getErrorAlert("Error! While parsing data.")
        //}
        
        return parseJSONData
    }
   
    
    class func isLibrrayImageAdded(catoryImageName :String) ->Bool
    {
        
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = documentsURL.appendingPathComponent("\(catoryImageName)").path
        
        
        
        if FileManager.default.fileExists(atPath: filePath) {
             return true
        }
        
        return false
        
    }
    
    
//    class func isWalsCastDownloded(walkCast : Poadcast)-> Bool{
//
//        
//        //let topic = walkCast.poadcastTopic//walkCast["topic"]
//        let id = walkCast.poadcastId!//walkCast["id"]
//        let walkcastFile = "\(id).wmm"
//        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let filePath = documentsURL.appendingPathComponent(walkcastFile).path
//
//        print(filePath)
//
//        if FileManager.default.fileExists(atPath: filePath) {
//            return true
//        }
//        return false
//    }
    
}
