//
//  PrintData.swift
//  WMM
//
//  Created by Dhaval Gogri on 28/10/16.
//  Copyright © 2016 Dhaval Gogri. All rights reserved.
//

import Foundation
import UIKit



class PrintData{
    
    private static var isPrintData = true
    
    static func printData(data: String){
        if isPrintData{
            print(data)
        }
    }
    
    static func printData(data: CGFloat){
        if isPrintData{
            print(data)
        }
    }
    
    static func printData(data: CGRect){
        if isPrintData{
            print(data)
        }
    }
    
    static func printData(data: Int){
        if isPrintData{
            print(data)
        }
    }
    
    static func printData(data: Double){
        if isPrintData{
            print(data)
        }
    }
}
