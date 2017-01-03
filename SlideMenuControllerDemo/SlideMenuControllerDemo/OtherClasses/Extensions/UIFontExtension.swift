//
//  UIFontExtension.swift
//  Carepack
//
//  Created by Yudiz Solutions Pvt.Ltd. on 23/02/16.
//  Copyright © 2016 Yudiz Solution Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit


enum FontBook: String {
    //MARK:- Avenir Font
    case Avenir_Book         = "Avenir-Book"
    case Avenir_Black        = "Avenir-Black"
    case Avenir_Medium       = "Avenir-Medium"
    case Avenir_Heavy        = "Avenir-Heavy"
    case Avenir_Light        = "Avenir-Light"
 
    //MARK:- AvenirNext Font
    case AvenirNext_Medium            = "AvenirNext-Medium"
    case AvenirNext_Heavy             = "AvenirNext-Heavy"
    case AvenirNext_UltraLight        = "AvenirNext-UltraLight"
    
    //MARK:- HelveticaNeue Font

    case HelveticaNeue_Light                    = "HelveticaNeue-Light"
    case HelveticaNeue_Regular                  = "HelveticaNeue"
    
    //MARK:- Method

    func of(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}

