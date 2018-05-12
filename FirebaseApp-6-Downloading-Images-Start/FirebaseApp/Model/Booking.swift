//
//  Booking.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 4/28/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit

class Booking: NSObject {
    var doctor :Doctor!
   
    var bookingId :String!
  
    init(bookingId :String ,doctor :Doctor) {
        self.bookingId = bookingId
        self.doctor = doctor
    }
}
