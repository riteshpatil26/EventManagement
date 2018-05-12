//
//  Network.swift
//  Firebase APP
//
//  Created by Ritesh Patil
//  Copyright © 2016 Ritesh Patil. All rights reserved.
//
import Foundation
import SystemConfiguration

class Network: NSObject {
    
    
    class func iSConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    class func parseJSONData(_ data : Data) ->NSDictionary{
        
        do{
            
            if let JSONDictionary =  try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                
                
                return JSONDictionary
            }
        }catch {
            
        }
        return NSDictionary()
        
    }


}



///http://172.22.31.21:8080/WalkMyMind/api/devices/devicetype?deviceType=fitnit Device : To connect & fetch data from device
