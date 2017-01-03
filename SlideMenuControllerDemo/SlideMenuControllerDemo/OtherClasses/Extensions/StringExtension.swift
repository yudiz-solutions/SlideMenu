//
//  StringExtension.swift
//  Carepack
//
//  Created by Yudiz Solutions Pvt.Ltd. on 23/02/16.
//  Copyright © 2016 Yudiz Solution Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Registration Validation
extension String {
    static func isValidString(_ str:String?) -> Bool{
        var strNew = ""
        if str != nil{
            strNew = str!.trimWhiteSpace(true)
        }
        if str == nil || strNew == "" || strNew.characters.count == 0  {  return true  }
        else  {  return false  }
    }
    
    static func isValidPassword(_ str:String?) -> Bool{
        if str == nil || str == "" || str!.characters.count < 6  {  return true  }
        else  {  return false  }
    }
    func isValidEmailAddress() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let temp = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
        return temp
    }
    func isValidUsername() -> Bool {
        let usernameRegex = "[A-Z0-9a-z_]{3,15}"
        let temp = NSPredicate(format: "SELF MATCHES %@", usernameRegex).evaluate(with: self)
        return temp
    }
    func isValidContact() -> Bool
    {
        /*
         This reg. Ex. for allow contact number with country code & range of contact 6 to 14
         "^((\\+)|(00))[0-9]{6,14}$"
         This reg. Ex. for allow only Mobile number & range of number 10 to 14
         "^[0-9]{10,14}$"
         */
        let contactRegEx = "^[0-9]{6,14}$"
        let temp = NSPredicate(format: "SELF MATCHES %@", contactRegEx).evaluate(with: self)
        return temp
    }
    
    func isValidNumber() -> Bool
    {
        let contactRegEx = "^[0-9]{0,14}$"
        let temp = NSPredicate(format: "SELF MATCHES %@", contactRegEx).evaluate(with: self)
        return temp
    }
    
}

// MARK: - Character check
extension String {
    
    func trimmedString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find, options: NSString.CompareOptions.caseInsensitive) != nil
    }
    
    func trimWhiteSpace(_ newline: Bool = false) -> String {
        if newline {
            return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        } else {
            return self.trimmingCharacters(in: CharacterSet.whitespaces)
        }
    }
    func encodeEmoji()-> String{
        //        let emojiData = self.dataUsingEncoding(NSUTF8StringEncoding)
        //        var message  = self
        //        if let data = emojiData{
        //            let strEncode = String(data: data, encoding: NSNonLossyASCIIStringEncoding)
        //            if let msgStr  = strEncode {
        //                message = msgStr
        //            }
        //        }
        //        return message
        return self
    }
    func decodeEmoji()-> String{
        //        let emojiData = self.dataUsingEncoding(NSNonLossyASCIIStringEncoding)
        //        var message  = self
        //        if let data = emojiData{
        //            let strEncode = String(data: data, encoding: NSUTF8StringEncoding)
        //            if let msgStr  = strEncode {
        //                message = msgStr
        //            }
        //        }
        //        return message
        return self
    }
}

extension Integer {
    func ordinalString() -> String {
        switch self % 10 {
        case 1...3 where 11...13 ~= self % 100: return "\(self)" + "th"
        case 1:    return "\(self)" + "st"
        case 2:    return "\(self)" + "nd"
        case 3:    return "\(self)" + "rd"
        default:   return "\(self)" + "th"
        }
    }
}
// MARK: - Layout
extension String {
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
    
    func WidthWithNoConstrainedHeight(_ font: UIFont) -> CGFloat {
        let width = CGFloat(999)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: options, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.width
    }
    
    func getAttributeString(_ font:UIFont,color:UIColor) ->  NSMutableAttributedString {
        let mutatingAttributedString = NSMutableAttributedString(string: self)
        mutatingAttributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, self.characters.count))
        mutatingAttributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, self.characters.count))
        return mutatingAttributedString
    }
}

extension NSAttributedString {
    
    func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}

// MARK: - Attributed
extension NSAttributedString {
    
    // This will give combined string with respective attributes
    func attributedText(_ texts: [String], attributes: [[String : AnyObject]]) -> NSAttributedString {
        let attbStr = NSMutableAttributedString()
        for (index,element) in texts.enumerated() {
            attbStr.append(NSAttributedString(string: element, attributes: attributes[index]))
        }
        return attbStr
    }
    
    
}

extension UILabel {
    
    func animateLabelAlpha( _ fromValue: NSNumber, toValue: NSNumber, duration: CFTimeInterval) {
        let titleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        titleAnimation.duration = duration
        titleAnimation.fromValue = fromValue
        titleAnimation.toValue = toValue
        titleAnimation.isRemovedOnCompletion = true
        layer.add(titleAnimation, forKey: "opacity")
    }
    
    func setAttributedText(_ text: String, font: UIFont, color: UIColor) {
        let mutatingAttributedString = NSMutableAttributedString(string: text)
        mutatingAttributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, text.characters.count))
        mutatingAttributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, text.characters.count))
        attributedText = mutatingAttributedString
    }
    
    // This will give combined string with respective attributes
    func setAttributedText(_ texts: [String], attributes: [[String : AnyObject]]) {
        let attbStr = NSMutableAttributedString()
        for (index,element) in texts.enumerated() {
            attbStr.append(NSAttributedString(string: element, attributes: attributes[index]))
        }
        attributedText = attbStr
    }
    
    func setAttributedText1(_ attributes: [NSMutableAttributedString]) {
        let attbStr = NSMutableAttributedString()
        for attri in attributes{
            attbStr.append(attri)
        }
        attributedText = attbStr
    }
    
    func addCharactersSpacing(_ spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing * _widthRatio, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
    
}

