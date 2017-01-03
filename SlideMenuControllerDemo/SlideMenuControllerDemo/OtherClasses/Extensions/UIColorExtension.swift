//
//  UIColorExtension.swift
//  Carepack
//
//  Created by Yudiz Solutions Pvt.Ltd. on 23/02/16.
//  Copyright © 2016 Yudiz Solution Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func colorWithGray(_ gray: Int) -> UIColor {
        return UIColor(red: CGFloat(gray) / 255.0, green: CGFloat(gray) / 255.0, blue: CGFloat(gray) / 255.0, alpha: 1.0)
    }
    class func colorWithRGB(r: Int, g: Int, b: Int) -> UIColor {
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    // Color of Validation Fail/Success
    class func popupFailColor() -> UIColor {
        return UIColor(red: 248.0 / 255.0, green: 73.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
    }
    class func popupWarningColor() -> UIColor {
        return UIColor(red: 255.0 / 255.0, green: 165.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    class func popupSuccessColor() -> UIColor {
        return UIColor(red: 103.0 / 255.0, green: 193.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
   
    class func randomColor() -> UIColor {
        let r = CGFloat.random()
        let g = CGFloat.random()
        let b = CGFloat.random()
        
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
