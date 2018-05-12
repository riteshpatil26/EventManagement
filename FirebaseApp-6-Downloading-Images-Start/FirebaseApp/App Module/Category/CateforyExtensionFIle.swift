//
//  CateforyExtensionFIle.swift
//  FirebaseApp
//
//  Created by Ritesh Narayan Patil on 5/12/18.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension CategoryViewController{
    
  
    
    
    func prepareSongAndSession(fileName :String,extensionofmusic :String) {
        do {
            songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: fileName, ofType: extensionofmusic)!))
            songPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
               try audioSession.setCategory(AVAudioSessionCategoryPlayback)
              } catch let sessionError {
                print(sessionError)
            }
         
        } catch let songPlayerError {
            print(songPlayerError)
        }
    }

    
}
