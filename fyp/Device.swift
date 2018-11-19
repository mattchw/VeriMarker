//
//  Device.swift
//  fyp
//
//  Created by Wong Cho Hin on 11/11/2018.
//  Copyright © 2018 IK1603. All rights reserved.
//

import Foundation
import UIKit

struct Device {
    // iDevice detection code
    static let IS_IPAD                      = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE                    = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA                    = UIScreen.main.scale >= 2.0
    
    static let DEVICE                       = UIDevice.current.userInterfaceIdiom
    
    static let SCREEN_WIDTH                 = Float(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT                = Float(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH            = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH            = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS          = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5                  = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6                  = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P                 = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X                  = IS_IPHONE && SCREEN_MAX_LENGTH == 812
    
    static let IPAD_PRO_129_WIDTH           = CGFloat(1024.0)
    static let IPAD_PRO_129_HEIGHT          = CGFloat(1366.0)
    
    static let IPAD_PRO_105_WIDTH           = CGFloat(834.0)
    static let IPAD_PRO_105_HEIGHT          = CGFloat(1112.0)
    
    static let IPAD_PRO_97_WIDTH           = CGFloat(768.0)
    static let IPAD_PRO_97_HEIGHT          = CGFloat(1024.0)
    
//    static let IPHONE_8P_CANVAS_WIDTH       = 
}
