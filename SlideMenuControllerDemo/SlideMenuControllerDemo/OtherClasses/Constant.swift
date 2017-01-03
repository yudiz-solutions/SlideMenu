//
//  Constant.swift
//  AussieFood
//
//  Created by Yudiz Solutions Pvt.Ltd. on 31/08/16.
//  Copyright © 2016 Yudiz Solutions Pvt.Ltd. All rights reserved.
//

import Foundation
import UIKit

let _screenSize         = UIScreen.main.bounds.size
let _appName            = "SlideMenuController Demo"

let _defaultCenter  = NotificationCenter.default
let _userDefault    = UserDefaults.standard
let _appDelegator   = UIApplication.shared.delegate! as! AppDelegate
let _application    = UIApplication.shared


let _heighRatio     = _screenSize.height/736
let _widthRatio     = _screenSize.width/414

// MARK: Important Enums
enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}
// MARK: Global Functions
// Comment in release mode
func jprint(_ items: Any...) {
    for item in items {
        print(item)
    }
}

/**
 Convert any object to Json formate string if any catch then empty string return 
 */
func toJsonString(_ parm : AnyObject) -> String{
    do{
        let jsonData: Data = try JSONSerialization.data(withJSONObject: parm, options: JSONSerialization.WritingOptions.prettyPrinted)
        if let datastring = String(data: jsonData, encoding: String.Encoding.utf8){
            return datastring
        }
    } catch {
        return  ""
    }
    return  ""
}


