//
//  Extension.swift
//  My Vinaphone
//
//  Created by LuongHV on 12/5/16.
//  Copyright © 2017 My Vinaphone Digital Health, Inc. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import ImageIO

public enum SwapRootVCAnimationType {
    case push
    case pop
    case present
    case dismiss
}

// MARK: - UIDevice
extension UIDevice {
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhoneXR: Bool {
        return UIScreen.main.nativeBounds.height == 1792
    }
    var iPhoneXSMAX: Bool {
        return UIScreen.main.nativeBounds.height == 2688    
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case iPhoneXR = "iPhone XR"
        case iPhoneXsMAX = "iPhoneXs MAX"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        case 1792:
            return .iPhoneXR
        case 2688:
            return .iPhoneXsMAX
        default:
            return .unknown
        }
    }
}

// MARK: - UIColor
extension UIColor {
    
    class var theme: UIColor {
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    class var navibar: UIColor {
        return #colorLiteral(red: 0, green: 0.631372549, blue: 0.8941176471, alpha: 1)
    }
    
    class var text: UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    class var success: UIColor {
        return #colorLiteral(red: 0.1215686275, green: 0.6941176471, blue: 0.5411764706, alpha: 1)
    }
    
    class var warning: UIColor {
        return #colorLiteral(red: 1, green: 0.5254901961, blue: 0, alpha: 1)
    }
    
    class var error: UIColor {
        return #colorLiteral(red: 1, green: 0.3568627451, blue: 0.2549019608, alpha: 1)
    }
    
    class var info: UIColor {
        return #colorLiteral(red: 0.2941176471, green: 0.4196078431, blue: 0.4784313725, alpha: 1)
    }
    class var defaultHeaderTableColor: UIColor {
        
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
}

// MARK: - String
extension String {
    
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
    func validateSpace(string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet.whitespaces) == nil
    }
    
    func isPasswordValid() -> Bool{
        if !validateSpace(string: self) {
            
//            Toast.showErr("Mật khẩu không được chứa khoảng trống")
            
            return false
            
        }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[a-z]).{8,20}")
        return passwordTest.evaluate(with: self)
    }
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    var convert0to84: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 1 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 1)
        let first = String(self[..<firstIndex])
        if first == "0" {
            let mob = String(String(describing: self.suffix(from: firstIndex)))
            return "84\(mob)"
        }
        return self
        
    }
    var convert84to0: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 2 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 2)
        let first = String(self[..<firstIndex])
        if first == "84" {
            let mob = String(String(describing: self.suffix(from: firstIndex))).removingWhitespaces()
            return "0\(mob)"
        }
        return self
        
    }
    var convert0084to0: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 4 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 4)
        let first = String(self[..<firstIndex])
        if first == "0084" {
            let mob = String(String(describing: self.suffix(from: firstIndex))).removingWhitespaces()
            return "0\(mob)"
        }
        return self
        
    }
    var remove0firt: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 1 {
            
            return self
            
        }
        let firstIndex = self.convert84to0.index((self.startIndex), offsetBy: 1)
        let first = String(self[..<firstIndex])
        return String(String(describing: self.suffix(from: firstIndex))).removingWhitespaces()
        
    }
    var convertMNPto0: String {
        
        if self == "" {
            
            return self
        }
        if self.count < 5 {
            
            return self
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 5)
        let first = String(self[..<firstIndex])
        if first == "84001" || first == "84002" || first == "84004" || first == "84005" || first == "84007" || first == "84008" {
            let mob = String(String(describing: self.suffix(from: firstIndex))).removingWhitespaces()
            print("MNP:\("0\(mob)")")
            return "0\(mob)"
        }
        return self
        
    }
    var convertMNPtoText: String {
        
        if self == "" {
            
            return ""
        }
        if self.count < 5 {
            
            return ""
            
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 5)
        let first = String(self[..<firstIndex])
        switch first {
        case "84001":
            return "Mobifone"
        case "84002":
            return "VinaPhone"
        case "84004":
            return "Viettel"
        case "84005":
            return "Vietnamobile"
        case "84007":
            return "Gtel"
        case "84008":
            return "Indo Tel"
        default:
            return ""
        }
        
        
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func removeSpecialCharsFromStringOnlyNumber() -> String {
        if self == "" {
            
            return self
            
        }
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
    var isPhone84: Bool {
        
        if self == "" {
            
            return false
        }
        let firstIndex = self.index((self.startIndex), offsetBy: 2)
        let first = String(self[..<firstIndex])
        if first == "84" {
            
            return true
            
        }
        return false
        
    }
    /// md5
//    var md5: String? {
//        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
//
//        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
//            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
//            CC_MD5(bytes, CC_LONG(data.count), &hash)
//            return hash
//        }
//
//        return hash.map { String(format: "%02x", $0) }.joined()
//    }
    func deleteTagHtml() -> String {
        if self != "" {
            return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        } else {
            
            return ""
        }
    }
    func replaceUTF8() -> String {
        
        var str = self
        str = str.replacingOccurrences(of:  "&quot;"     , with:  "\"")
        str = str.replacingOccurrences(of:  "&amp;"      , with:  "&")
        str = str.replacingOccurrences(of:  "&apos;"     , with:  "'")
        str = str.replacingOccurrences(of:  "&lt;"       , with:  "<")
        str = str.replacingOccurrences(of:  "&gt;"       , with:  ">")
        str = str.replacingOccurrences(of:  "&nbsp;"     , with:  "\u{00A0}")
        str = str.replacingOccurrences(of:  "&iexcl;"    , with:  "\u{00A1}")
        str = str.replacingOccurrences(of:  "&cent;"     , with:  "\u{00A2}")
        str = str.replacingOccurrences(of:  "&pound;"    , with:  "\u{00A3}")
        str = str.replacingOccurrences(of:  "&curren;"   , with:  "\u{00A4}")
        str = str.replacingOccurrences(of:  "&yen;"      , with:  "\u{00A5}")
        str = str.replacingOccurrences(of:  "&brvbar;"   , with:  "\u{00A6}")
        str = str.replacingOccurrences(of:  "&sect;"     , with:  "\u{00A7}")
        str = str.replacingOccurrences(of:  "&uml;"      , with:  "\u{00A8}")
        str = str.replacingOccurrences(of:  "&copy;"     , with:  "\u{00A9}")
        str = str.replacingOccurrences(of:  "&ordf;"     , with:  "\u{00AA}")
        str = str.replacingOccurrences(of:  "&laquo;"    , with:  "\u{00AB}")
        str = str.replacingOccurrences(of:  "&not;"      , with:  "\u{00AC}")
        str = str.replacingOccurrences(of:  "&shy;"      , with:  "\u{00AD}")
        str = str.replacingOccurrences(of:  "&reg;"      , with:  "\u{00AE}")
        str = str.replacingOccurrences(of:  "&macr;"     , with:  "\u{00AF}")
        str = str.replacingOccurrences(of:  "&deg;"      , with:  "\u{00B0}")
        str = str.replacingOccurrences(of:  "&plusmn;"   , with:  "\u{00B1}")
        str = str.replacingOccurrences(of:  "&sup2;"     , with:  "\u{00B2}")
        str = str.replacingOccurrences(of:  "&sup3;"     , with:  "\u{00B3}")
        str = str.replacingOccurrences(of:  "&acute;"    , with:  "\u{00B4}")
        str = str.replacingOccurrences(of:  "&micro;"    , with:  "\u{00B5}")
        str = str.replacingOccurrences(of:  "&para;"     , with:  "\u{00B6}")
        str = str.replacingOccurrences(of:  "&middot;"   , with:  "\u{00B7}")
        str = str.replacingOccurrences(of:  "&cedil;"    , with:  "\u{00B8}")
        str = str.replacingOccurrences(of:  "&sup1;"     , with:  "\u{00B9}")
        str = str.replacingOccurrences(of:  "&ordm;"     , with:  "\u{00BA}")
        str = str.replacingOccurrences(of:  "&raquo;"    , with:  "\u{00BB}")
        str = str.replacingOccurrences(of:  "&frac14;"   , with:  "\u{00BC}")
        str = str.replacingOccurrences(of:  "&frac12;"   , with:  "\u{00BD}")
        str = str.replacingOccurrences(of:  "&frac34;"   , with:  "\u{00BE}")
        str = str.replacingOccurrences(of:  "&iquest;"   , with:  "\u{00BF}")
        str = str.replacingOccurrences(of:  "&Agrave;"   , with:  "\u{00C0}")
        str = str.replacingOccurrences(of:  "&Aacute;"   , with:  "\u{00C1}")
        str = str.replacingOccurrences(of:  "&Acirc;"    , with:  "\u{00C2}")
        str = str.replacingOccurrences(of:  "&Atilde;"   , with:  "\u{00C3}")
        str = str.replacingOccurrences(of:  "&Auml;"     , with:  "\u{00C4}")
        str = str.replacingOccurrences(of:  "&Aring;"    , with:  "\u{00C5}")
        str = str.replacingOccurrences(of:  "&AElig;"    , with:  "\u{00C6}")
        str = str.replacingOccurrences(of:  "&Ccedil;"   , with:  "\u{00C7}")
        str = str.replacingOccurrences(of:  "&Egrave;"   , with:  "\u{00C8}")
        str = str.replacingOccurrences(of:  "&Eacute;"   , with:  "\u{00C9}")
        str = str.replacingOccurrences(of:  "&Ecirc;"    , with:  "\u{00CA}")
        str = str.replacingOccurrences(of:  "&Euml;"     , with:  "\u{00CB}")
        str = str.replacingOccurrences(of:  "&Igrave;"   , with:  "\u{00CC}")
        str = str.replacingOccurrences(of:  "&Iacute;"   , with:  "\u{00CD}")
        str = str.replacingOccurrences(of:  "&Icirc;"    , with:  "\u{00CE}")
        str = str.replacingOccurrences(of:  "&Iuml;"     , with:  "\u{00CF}")
        str = str.replacingOccurrences(of:  "&ETH;"      , with:  "\u{00D0}")
        str = str.replacingOccurrences(of:  "&Ntilde;"   , with:  "\u{00D1}")
        str = str.replacingOccurrences(of:  "&Ograve;"   , with:  "\u{00D2}")
        str = str.replacingOccurrences(of:  "&Oacute;"   , with:  "\u{00D3}")
        str = str.replacingOccurrences(of:  "&Ocirc;"    , with:  "\u{00D4}")
        str = str.replacingOccurrences(of:  "&Otilde;"   , with:  "\u{00D5}")
        str = str.replacingOccurrences(of:  "&Ouml;"     , with:  "\u{00D6}")
        str = str.replacingOccurrences(of:  "&times;"    , with:  "\u{00D7}")
        str = str.replacingOccurrences(of:  "&Oslash;"   , with:  "\u{00D8}")
        str = str.replacingOccurrences(of:  "&Ugrave;"   , with:  "\u{00D9}")
        str = str.replacingOccurrences(of:  "&Uacute;"   , with:  "\u{00DA}")
        str = str.replacingOccurrences(of:  "&Ucirc;"    , with:  "\u{00DB}")
        str = str.replacingOccurrences(of:  "&Uuml;"     , with:  "\u{00DC}")
        str = str.replacingOccurrences(of:  "&Yacute;"   , with:  "\u{00DD}")
        str = str.replacingOccurrences(of:  "&THORN;"    , with:  "\u{00DE}")
        str = str.replacingOccurrences(of:  "&szlig;"    , with:  "\u{00DF}")
        str = str.replacingOccurrences(of:  "&agrave;"   , with:  "\u{00E0}")
        str = str.replacingOccurrences(of:  "&aacute;"   , with:  "\u{00E1}")
        str = str.replacingOccurrences(of:  "&acirc;"    , with:  "\u{00E2}")
        str = str.replacingOccurrences(of:  "&atilde;"   , with:  "\u{00E3}")
        str = str.replacingOccurrences(of:  "&auml;"     , with:  "\u{00E4}")
        str = str.replacingOccurrences(of:  "&aring;"    , with:  "\u{00E5}")
        str = str.replacingOccurrences(of:  "&aelig;"    , with:  "\u{00E6}")
        str = str.replacingOccurrences(of:  "&ccedil;"   , with:  "\u{00E7}")
        str = str.replacingOccurrences(of:  "&egrave;"   , with:  "\u{00E8}")
        str = str.replacingOccurrences(of:  "&eacute;"   , with:  "\u{00E9}")
        str = str.replacingOccurrences(of:  "&ecirc;"    , with:  "\u{00EA}")
        str = str.replacingOccurrences(of:  "&euml;"     , with:  "\u{00EB}")
        str = str.replacingOccurrences(of:  "&igrave;"   , with:  "\u{00EC}")
        str = str.replacingOccurrences(of:  "&iacute;"   , with:  "\u{00ED}")
        str = str.replacingOccurrences(of:  "&icirc;"    , with:  "\u{00EE}")
        str = str.replacingOccurrences(of:  "&iuml;"     , with:  "\u{00EF}")
        str = str.replacingOccurrences(of:  "&eth;"      , with:  "\u{00F0}")
        str = str.replacingOccurrences(of:  "&ntilde;"   , with:  "\u{00F1}")
        str = str.replacingOccurrences(of:  "&ograve;"   , with:  "\u{00F2}")
        str = str.replacingOccurrences(of:  "&oacute;"   , with:  "\u{00F3}")
        str = str.replacingOccurrences(of:  "&ocirc;"    , with:  "\u{00F4}")
        str = str.replacingOccurrences(of:  "&otilde;"   , with:  "\u{00F5}")
        str = str.replacingOccurrences(of:  "&ouml;"     , with:  "\u{00F6}")
        str = str.replacingOccurrences(of:  "&divide;"   , with:  "\u{00F7}")
        str = str.replacingOccurrences(of:  "&oslash;"   , with:  "\u{00F8}")
        str = str.replacingOccurrences(of:  "&ugrave;"   , with:  "\u{00F9}")
        str = str.replacingOccurrences(of:  "&uacute;"   , with:  "\u{00FA}")
        str = str.replacingOccurrences(of:  "&ucirc;"    , with:  "\u{00FB}")
        str = str.replacingOccurrences(of:  "&uuml;"     , with:  "\u{00FC}")
        str = str.replacingOccurrences(of:  "&yacute;"   , with:  "\u{00FD}")
        str = str.replacingOccurrences(of:  "&thorn;"    , with:  "\u{00FE}")
        str = str.replacingOccurrences(of:  "&yuml;"     , with:  "\u{00FF}")
        str = str.replacingOccurrences(of:  "&OElig;"    , with:  "\u{0152}")
        str = str.replacingOccurrences(of:  "&oelig;"    , with:  "\u{0153}")
        str = str.replacingOccurrences(of:  "&Scaron;"   , with:  "\u{0160}")
        str = str.replacingOccurrences(of:  "&scaron;"   , with:  "\u{0161}")
        str = str.replacingOccurrences(of:  "&Yuml;"     , with:  "\u{0178}")
        str = str.replacingOccurrences(of:  "&fnof;"     , with:  "\u{0192}")
        str = str.replacingOccurrences(of:  "&circ;"     , with:  "\u{02C6}")
        str = str.replacingOccurrences(of:  "&tilde;"    , with:  "\u{02DC}")
        str = str.replacingOccurrences(of:  "&Alpha;"    , with:  "\u{0391}")
        str = str.replacingOccurrences(of:  "&Beta;"     , with:  "\u{0392}")
        str = str.replacingOccurrences(of:  "&Gamma;"    , with:  "\u{0393}")
        str = str.replacingOccurrences(of:  "&Delta;"    , with:  "\u{0394}")
        str = str.replacingOccurrences(of:  "&Epsilon;"  , with:  "\u{0395}")
        str = str.replacingOccurrences(of:  "&Zeta;"     , with:  "\u{0396}")
        str = str.replacingOccurrences(of:  "&Eta;"      , with:  "\u{0397}")
        str = str.replacingOccurrences(of:  "&Theta;"    , with:  "\u{0398}")
        str = str.replacingOccurrences(of:  "&Iota;"     , with:  "\u{0399}")
        str = str.replacingOccurrences(of:  "&Kappa;"    , with:  "\u{039A}")
        str = str.replacingOccurrences(of:  "&Lambda;"   , with:  "\u{039B}")
        str = str.replacingOccurrences(of:  "&Mu;"       , with:  "\u{039C}")
        str = str.replacingOccurrences(of:  "&Nu;"       , with:  "\u{039D}")
        str = str.replacingOccurrences(of:  "&Xi;"       , with:  "\u{039E}")
        str = str.replacingOccurrences(of:  "&Omicron;"  , with:  "\u{039F}")
        str = str.replacingOccurrences(of:  "&Pi;"       , with:  "\u{03A0}")
        str = str.replacingOccurrences(of:  "&Rho;"      , with:  "\u{03A1}")
        str = str.replacingOccurrences(of:  "&Sigma;"    , with:  "\u{03A3}")
        str = str.replacingOccurrences(of:  "&Tau;"      , with:  "\u{03A4}")
        str = str.replacingOccurrences(of:  "&Upsilon;"  , with:  "\u{03A5}")
        str = str.replacingOccurrences(of:  "&Phi;"      , with:  "\u{03A6}")
        str = str.replacingOccurrences(of:  "&Chi;"      , with:  "\u{03A7}")
        str = str.replacingOccurrences(of:  "&Psi;"      , with:  "\u{03A8}")
        str = str.replacingOccurrences(of:  "&Omega;"    , with:  "\u{03A9}")
        str = str.replacingOccurrences(of:  "&alpha;"    , with:  "\u{03B1}")
        str = str.replacingOccurrences(of:  "&beta;"     , with:  "\u{03B2}")
        str = str.replacingOccurrences(of:  "&gamma;"    , with:  "\u{03B3}")
        str = str.replacingOccurrences(of:  "&delta;"    , with:  "\u{03B4}")
        str = str.replacingOccurrences(of:  "&epsilon;"  , with:  "\u{03B5}")
        str = str.replacingOccurrences(of:  "&zeta;"     , with:  "\u{03B6}")
        str = str.replacingOccurrences(of:  "&eta;"      , with:  "\u{03B7}")
        str = str.replacingOccurrences(of:  "&theta;"    , with:  "\u{03B8}")
        str = str.replacingOccurrences(of:  "&iota;"     , with:  "\u{03B9}")
        str = str.replacingOccurrences(of:  "&kappa;"    , with:  "\u{03BA}")
        str = str.replacingOccurrences(of:  "&lambda;"   , with:  "\u{03BB}")
        str = str.replacingOccurrences(of:  "&mu;"       , with:  "\u{03BC}")
        str = str.replacingOccurrences(of:  "&nu;"       , with:  "\u{03BD}")
        str = str.replacingOccurrences(of:  "&xi;"       , with:  "\u{03BE}")
        str = str.replacingOccurrences(of:  "&omicron;"  , with:  "\u{03BF}")
        str = str.replacingOccurrences(of:  "&pi;"       , with:  "\u{03C0}")
        str = str.replacingOccurrences(of:  "&rho;"      , with:  "\u{03C1}")
        str = str.replacingOccurrences(of:  "&sigmaf;"   , with:  "\u{03C2}")
        str = str.replacingOccurrences(of:  "&sigma;"    , with:  "\u{03C3}")
        str = str.replacingOccurrences(of:  "&tau;"      , with:  "\u{03C4}")
        str = str.replacingOccurrences(of:  "&upsilon;"  , with:  "\u{03C5}")
        str = str.replacingOccurrences(of:  "&phi;"      , with:  "\u{03C6}")
        str = str.replacingOccurrences(of:  "&chi;"      , with:  "\u{03C7}")
        str = str.replacingOccurrences(of:  "&psi;"      , with:  "\u{03C8}")
        str = str.replacingOccurrences(of:  "&omega;"    , with:  "\u{03C9}")
        str = str.replacingOccurrences(of:  "&thetasym;" , with:  "\u{03D1}")
        str = str.replacingOccurrences(of:  "&upsih;"    , with:  "\u{03D2}")
        str = str.replacingOccurrences(of:  "&piv;"      , with:  "\u{03D6}")
        str = str.replacingOccurrences(of:  "&ensp;"     , with:  "\u{2002}")
        str = str.replacingOccurrences(of:  "&emsp;"     , with:  "\u{2003}")
        str = str.replacingOccurrences(of:  "&thinsp;"   , with:  "\u{2009}")
        str = str.replacingOccurrences(of:  "&zwnj;"     , with:  "\u{200C}")
        str = str.replacingOccurrences(of:  "&zwj;"      , with:  "\u{200D}")
        str = str.replacingOccurrences(of:  "&lrm;"      , with:  "\u{200E}")
        str = str.replacingOccurrences(of:  "&rlm;"      , with:  "\u{200F}")
        str = str.replacingOccurrences(of:  "&ndash;"    , with:  "\u{2013}")
        str = str.replacingOccurrences(of:  "&mdash;"    , with:  "\u{2014}")
        str = str.replacingOccurrences(of:  "&lsquo;"    , with:  "\u{2018}")
        str = str.replacingOccurrences(of:  "&rsquo;"    , with:  "\u{2019}")
        str = str.replacingOccurrences(of:  "&sbquo;"    , with:  "\u{201A}")
        str = str.replacingOccurrences(of:  "&ldquo;"    , with:  "\u{201C}")
        str = str.replacingOccurrences(of:  "&rdquo;"    , with:  "\u{201D}")
        str = str.replacingOccurrences(of:  "&bdquo;"    , with:  "\u{201E}")
        str = str.replacingOccurrences(of:  "&dagger;"   , with:  "\u{2020}")
        str = str.replacingOccurrences(of:  "&Dagger;"   , with:  "\u{2021}")
        str = str.replacingOccurrences(of:  "&bull;"     , with:  "\u{2022}")
        str = str.replacingOccurrences(of:  "&hellip;"   , with:  "\u{2026}")
        str = str.replacingOccurrences(of:  "&permil;"   , with:  "\u{2030}")
        str = str.replacingOccurrences(of:  "&prime;"    , with:  "\u{2032}")
        str = str.replacingOccurrences(of:  "&Prime;"    , with:  "\u{2033}")
        str = str.replacingOccurrences(of:  "&lsaquo;"   , with:  "\u{2039}")
        str = str.replacingOccurrences(of:  "&rsaquo;"   , with:  "\u{203A}")
        str = str.replacingOccurrences(of:  "&oline;"    , with:  "\u{203E}")
        str = str.replacingOccurrences(of:  "&frasl;"    , with:  "\u{2044}")
        str = str.replacingOccurrences(of:  "&euro;"     , with:  "\u{20AC}")
        str = str.replacingOccurrences(of:  "&image;"    , with:  "\u{2111}")
        str = str.replacingOccurrences(of:  "&weierp;"   , with:  "\u{2118}")
        str = str.replacingOccurrences(of:  "&real;"     , with:  "\u{211C}")
        str = str.replacingOccurrences(of:  "&trade;"    , with:  "\u{2122}")
        str = str.replacingOccurrences(of:  "&alefsym;"  , with:  "\u{2135}")
        str = str.replacingOccurrences(of:  "&larr;"     , with:  "\u{2190}")
        str = str.replacingOccurrences(of:  "&uarr;"     , with:  "\u{2191}")
        str = str.replacingOccurrences(of:  "&rarr;"     , with:  "\u{2192}")
        str = str.replacingOccurrences(of:  "&darr;"     , with:  "\u{2193}")
        str = str.replacingOccurrences(of:  "&harr;"     , with:  "\u{2194}")
        str = str.replacingOccurrences(of:  "&crarr;"    , with:  "\u{21B5}")
        str = str.replacingOccurrences(of:  "&lArr;"     , with:  "\u{21D0}")
        str = str.replacingOccurrences(of:  "&uArr;"     , with:  "\u{21D1}")
        str = str.replacingOccurrences(of:  "&rArr;"     , with:  "\u{21D2}")
        str = str.replacingOccurrences(of:  "&dArr;"     , with:  "\u{21D3}")
        str = str.replacingOccurrences(of:  "&hArr;"     , with:  "\u{21D4}")
        str = str.replacingOccurrences(of:  "&forall;"   , with:  "\u{2200}")
        str = str.replacingOccurrences(of:  "&part;"     , with:  "\u{2202}")
        str = str.replacingOccurrences(of:  "&exist;"    , with:  "\u{2203}")
        str = str.replacingOccurrences(of:  "&empty;"    , with:  "\u{2205}")
        str = str.replacingOccurrences(of:  "&nabla;"    , with:  "\u{2207}")
        str = str.replacingOccurrences(of:  "&isin;"     , with:  "\u{2208}")
        str = str.replacingOccurrences(of:  "&notin;"    , with:  "\u{2209}")
        str = str.replacingOccurrences(of:  "&ni;"       , with:  "\u{220B}")
        str = str.replacingOccurrences(of:  "&prod;"     , with:  "\u{220F}")
        str = str.replacingOccurrences(of:  "&sum;"      , with:  "\u{2211}")
        str = str.replacingOccurrences(of:  "&minus;"    , with:  "\u{2212}")
        str = str.replacingOccurrences(of:  "&lowast;"   , with:  "\u{2217}")
        str = str.replacingOccurrences(of:  "&radic;"    , with:  "\u{221A}")
        str = str.replacingOccurrences(of:  "&prop;"     , with:  "\u{221D}")
        str = str.replacingOccurrences(of:  "&infin;"    , with:  "\u{221E}")
        str = str.replacingOccurrences(of:  "&ang;"      , with:  "\u{2220}")
        str = str.replacingOccurrences(of:  "&and;"      , with:  "\u{2227}")
        str = str.replacingOccurrences(of:  "&or;"       , with:  "\u{2228}")
        str = str.replacingOccurrences(of:  "&cap;"      , with:  "\u{2229}")
        str = str.replacingOccurrences(of:  "&cup;"      , with:  "\u{222A}")
        str = str.replacingOccurrences(of:  "&int;"      , with:  "\u{222B}")
        str = str.replacingOccurrences(of:  "&there4;"   , with:  "\u{2234}")
        str = str.replacingOccurrences(of:  "&sim;"      , with:  "\u{223C}")
        str = str.replacingOccurrences(of:  "&cong;"     , with:  "\u{2245}")
        str = str.replacingOccurrences(of:  "&asymp;"    , with:  "\u{2248}")
        str = str.replacingOccurrences(of:  "&ne;"       , with:  "\u{2260}")
        str = str.replacingOccurrences(of:  "&equiv;"    , with:  "\u{2261}")
        str = str.replacingOccurrences(of:  "&le;"       , with:  "\u{2264}")
        str = str.replacingOccurrences(of:  "&ge;"       , with:  "\u{2265}")
        str = str.replacingOccurrences(of:  "&sub;"      , with:  "\u{2282}")
        str = str.replacingOccurrences(of:  "&sup;"      , with:  "\u{2283}")
        str = str.replacingOccurrences(of:  "&nsub;"     , with:  "\u{2284}")
        str = str.replacingOccurrences(of:  "&sube;"     , with:  "\u{2286}")
        str = str.replacingOccurrences(of:  "&supe;"     , with:  "\u{2287}")
        str = str.replacingOccurrences(of:  "&oplus;"    , with:  "\u{2295}")
        str = str.replacingOccurrences(of:  "&otimes;"   , with:  "\u{2297}")
        str = str.replacingOccurrences(of:  "&perp;"     , with:  "\u{22A5}")
        str = str.replacingOccurrences(of:  "&sdot;"     , with:  "\u{22C5}")
        str = str.replacingOccurrences(of:  "&lceil;"    , with:  "\u{2308}")
        str = str.replacingOccurrences(of:  "&rceil;"    , with:  "\u{2309}")
        str = str.replacingOccurrences(of:  "&lfloor;"   , with:  "\u{230A}")
        str = str.replacingOccurrences(of:  "&rfloor;"   , with:  "\u{230B}")
        str = str.replacingOccurrences(of:  "&lang;"     , with:  "\u{2329}")
        str = str.replacingOccurrences(of:  "&rang;"     , with:  "\u{232A}")
        str = str.replacingOccurrences(of:  "&loz;"      , with:  "\u{25CA}")
        str = str.replacingOccurrences(of:  "&spades;"   , with:  "\u{2660}")
        str = str.replacingOccurrences(of:  "&clubs;"    , with:  "\u{2663}")
        str = str.replacingOccurrences(of:  "&hearts;"   , with:  "\u{2665}")
        str = str.replacingOccurrences(of:  "&diams;"    , with:  "\u{2666}")
        return str
        
    }
    /// trimSpace
    ///
    /// - Returns: String
    func trimSpace () -> String {
        return  self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    //convẻ â - a
    func converCharacter() -> String {
        var str = self
        str = str.replacingOccurrences(of: "â", with: "a")
        str = str.replacingOccurrences(of: "ă", with: "a")
        str = str.replacingOccurrences(of: "ô", with: "o")
        str = str.replacingOccurrences(of: "ơ", with: "o")
        str = str.replacingOccurrences(of: "đ", with: "d")
        str = str.replacingOccurrences(of: "ê", with: "e")
        str = str.replacingOccurrences(of: "ư", with: "u")
        return str
    }
    /// String to Number
    ///
    /// - Returns: NSNumber
    func toNumber() -> NSNumber? {
        let numberFormatter: NumberFormatter = {
            let formattedNumber = NumberFormatter()
            formattedNumber.locale = Locale(identifier: "vi_VN")
            formattedNumber.numberStyle = .decimal
            formattedNumber.maximumFractionDigits = 0
            return formattedNumber
        }()
        if let decimal = numberFormatter.number(from: self) {
            return decimal
        }
        return nil
    }
    
    /// String to Date
    ///
    /// - Returns: Date
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    
    /// String to Date UTC
    ///
    /// - Parameter dateFormat: String
    /// - Returns: Date
    func toDateUTC(dateFormat:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
        
    }
    
    /// String to Date
    ///
    /// - Parameter dateFormat: String
    /// - Returns: Date
    func toDate(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    func toDate2(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    
    /// String to Json
    ///
    /// - Returns: [String: Any]
    func toJson() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let json = json {
                return json
            }
        }
        return nil
    }
    
    /// String to List Json
    ///
    /// - Returns: [[String: Any]]
    func toListJson() -> [[String: Any]]? {
        
        let data = self.data(using: String.Encoding.utf8)
        let   allJson = try?  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        if let lsJs = allJson as? [[String: Any]]{
            
            return lsJs
            
        }
        return nil
        
    }
    
    /// Check valid email
    ///
    /// - Returns: Bool
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Check valid number
    ///
    /// - Returns: Bool
    func isNumber() -> Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    func stringFromHTML() -> NSAttributedString
    {
        do {
            return try NSAttributedString(data: self.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue] , documentAttributes: nil)
        } catch {
            print(error)
        }
        return NSAttributedString()
    }
    func stringFromHTMLWithfont(fontName: String, fontSize: CGFloat) -> NSAttributedString
    {
        do {
            let str = self.replacingOccurrences(of: "<span[^>]*><\\/span[^>]*>", with: "", options: .regularExpression, range: nil)
            let modifiedFont = String(format:"<span style=\"font-family: \(fontName); font-size: \(fontSize)\">%@</span>", str)
            return try NSAttributedString(data: modifiedFont.data(using: String.Encoding.unicode, allowLossyConversion: true)!, options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue] , documentAttributes: nil)
        } catch {
            print(error)
        }
        return NSAttributedString()
    }
    
    func gachnganchu() -> NSMutableAttributedString {
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    func htmlToString() -> String {
        
        let str = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil).utf8
        return String(str)
    }
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substring(with: (index(startIndex, offsetBy: r.lowerBound) ..< index(startIndex, offsetBy: r.upperBound)))
    }
    
}

// MARK: - Date
extension Date {
    
    func toString(formater: String) -> String {
        let  dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = formater
        return dateFormatter.string(from: self)
    }
    
    func addedBy(second:Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: second, to: self)!
    }
}

// MARK: - UIImage
extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x:0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public class func gifImageWithData(data: NSData) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data, nil) else {
            print("image doesn't exist")
            return nil
        }
        
        return UIImage.animatedImageWithSource(source: source)
    }
    
    public class func gifImageWithURL(gifUrl:String) -> UIImage? {
        guard let bundleURL = NSURL(string: gifUrl)
            else {
                print("image named \"\(gifUrl)\" doesn't exist")
                return nil
        }
        guard let imageData = NSData(contentsOf: bundleURL as URL) else {
            print("image named \"\(gifUrl)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    public class func gifImageWithName(name: String) -> UIImage? {
        guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
                print("SwiftGif: This image named \"\(name)\" does not exist")
                return nil
        }
        
        guard let imageData = NSData(contentsOf: bundleURL) else {
            print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
            return nil
        }
        
        return gifImageWithData(data: imageData)
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource!) -> Double {
        var delay = 0.1
        
        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(CFDictionaryGetValue(cfProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()), to: CFDictionary.self)
        
        var delayObject: AnyObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()), to: AnyObject.self)
        
        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties, Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
        }
        
        delay = delayObject as! Double
        
        if delay < 0.1 {
            delay = 0.1
        }
        
        return delay
    }
    
    class func gcdForPair(a: Int?, _ b: Int?) -> Int {
        var a = a
        var b = b
        if b == nil || a == nil {
            if b != nil {
                return b!
            } else if a != nil {
                return a!
            } else {
                return 0
            }
        }
        
        if a! < b! {
            let c = a!
            a = b!
            b = c
        }
        
        var rest: Int
        while true {
            rest = a! % b!
            
            if rest == 0 {
                return b!
            } else {
                a = b!
                b = rest
            }
        }
    }
    
    class func gcdForArray(array: Array<Int>) -> Int {
        if array.isEmpty {
            return 1
        }
        
        var gcd = array[0]
        
        for val in array {
            gcd = UIImage.gcdForPair(a: val, gcd)
        }
        
        return gcd
    }
    
    class func animatedImageWithSource(source: CGImageSource) -> UIImage? {
        let count = CGImageSourceGetCount(source)
        var images = [CGImage]()
        var delays = [Int]()
        
        for i in 0..<count {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(image)
            }
            
            let delaySeconds = UIImage.delayForImageAtIndex(index: Int(i), source: source)
            delays.append(Int(delaySeconds * 1000.0)) // Seconds to ms
        }
        
        let duration: Int = {
            var sum = 0
            
            for val: Int in delays {
                sum += val
            }
            
            return sum
        }()
        
        let gcd = gcdForArray(array: delays)
        var frames = [UIImage]()
        
        var frame: UIImage
        var frameCount: Int
        for i in 0..<count {
            frame = UIImage(cgImage: images[Int(i)])
            frameCount = Int(delays[Int(i)] / gcd)
            
            for _ in 0..<frameCount {
                frames.append(frame)
            }
        }
        
        let animation = UIImage.animatedImage(with: frames, duration: Double(duration) / 1000.0)
        
        return animation
    }
}


//mark: get image và lưu cache ảnh.
enum DateFormat: String {
    case HHmmDDMMYYYY = "HH:mm dd/MM/yyyy"
    case DDMMYYYY = "dd/MM/yyyy"
    case YYYYMMDD = "yyyy-MM-dd"
    case HH_mm_DD_MM_YYYY = "HH_mm_dd_MM_yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case HHmm = "HH:mm"
    case HHmma = "HH:mm a"
    case hhmma = "hh:mm a"
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmssSSSz = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddHHmmss = "yyyyMMddHHmmss"
    case MMddyyyyHHmm = "MM-dd-yyyy HH:mm"
    case MMMddyyyyHHmm = "MMM-dd-yyyy HH:mm"
    case yyyyMMddHHmmssSSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyyMMddTHHmma = "yyyy-MM-dd hh:mm a"
    case MMM_dd = "MMM-dd"
    case dd = "dd"
    case ddMM = "dd/MM"
    case yyyyMMddhhmm = "yyyy-HH-dd hh:mm"
    case ddMMyyyhhmmss = "dd/MM/yyyy hh:mm:ss"
    case HIS_MMyyyy = "MMyyyy"
    case HIS_ddMMyyy = "ddMMyyyy"
    case MM = "MM"
    case MMYYYY = "MM/yyyy"
    case ddMMyyyyHH24MISS = "dd/MM/yyyy HH:mm:ss"
    
    
}
extension Date {
    func toString(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toLocalTimeString(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    func localTimeFormat(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
        
    }
    
    
    func setTime(hour: Int, min: Int,sec: Int, nanosec: Int = 000 , timeZoneAbbrev: String = "UTC") -> Date? {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        component.hour = hour
        component.minute = min
        component.second = sec
        component.nanosecond = nanosec
        return cal.date(from: component)
    }
    func addDay(day: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: "UTC")
        component.day = component.day! + day
        return cal.date(from: component)!
    }
    func addDayLocal(day: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        component.day = component.day! + day
        return cal.date(from: component)!
    }
    func addMonthLocal(month: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        component.month = component.month! + month
        return cal.date(from: component)!
    }
    func setDate(date: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.day = date
        return cal.date(from: component)!
    }
    func setDate(date: Int, month: Int, year: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: "UTC")
        component.day = date
        component.month = month
        component.year = year
        return cal.date(from: component)!
    }
    func setDateLocal(date: Int, month: Int, year: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = NSTimeZone.local
        component.day = date
        component.month = month
        component.year = year
        return cal.date(from: component)!
    }
    func getDay() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        return component.day!
    }
    func getMonth() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        return component.month!
    }
    func getYear() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.year!
    }
    func setDateUTC() -> Date? {
        
        let x: Set<Calendar.Component> = [.year, .month, . day, . hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.date(from: component)
    }
    func setDateUTCDefault() -> Date? {
        
        let x: Set<Calendar.Component> = [.year, .month, . day, . hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.hour = component.hour!
        return cal.date(from: component)
    }
    func toInt() -> Int64 {
        
        let interval = self.timeIntervalSince1970
        return Int64(interval * 1000)
        
    }
    func startOfWeek(weekday: Int?) -> Date {
        var cal = Calendar.current
        var component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        component.timeZone = TimeZone(abbreviation: "GMT")
        component.to12am()
        cal.firstWeekday = weekday ?? 1
        return cal.date(from: component)!
    }
    func getDayInWeek(day: Int?) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        comps.timeZone = TimeZone(abbreviation: "GMT")
        comps.weekday = day ?? 1 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
    
    func endOfWeek(weekday: Int) -> Date {
        let cal = Calendar.current
        var component = DateComponents()
        component.weekOfYear = 1
        component.day = -1
        return cal.date(byAdding: component, to: startOfWeek(weekday: weekday))!
    }
    func setTime(hour: Int, min: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        var dateComponents = DateComponents()
        dateComponents.year = component.year
        dateComponents.month = component.month
        dateComponents.day = component.day
        dateComponents.timeZone = TimeZone(secondsFromGMT: 7)
        dateComponents.hour = hour
        dateComponents.minute = min
        let someDateTime = cal.date(from: dateComponents)
        return someDateTime!
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    func lastOfMonth() -> Date {
        
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
}
internal extension DateComponents {
    mutating func to12am() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}
extension NSNumber {
    func toDecimalString(_ isShow: Bool? = false) -> String {
        
        var string = ""
        var number = self
        if isShow == true && number.int64Value >= 1000000 {
            string = "M"
            number = NSNumber(value: Int64(number.int64Value/1000000))
        }
        
        let numberFormatter: NumberFormatter = {
            let formattedNumber = NumberFormatter()
            formattedNumber.locale = Locale(identifier: "vi_VN")
            formattedNumber.numberStyle = .decimal
            formattedNumber.maximumFractionDigits = 0
            return formattedNumber
        }()
        if let decimal = numberFormatter.string(from: number) {
            return "\(decimal)\(string)"
        }
        return ""
    }
}

//mark: NotificationName.
extension Notification.Name {
    static let addOder = Notification.Name("addOder")
}

//import SVPullToRefresh
//import DZNEmptyDataSet
//extension UIScrollView {
//    func infiniteScroll(_ actionHandler: @escaping ()->Swift.Void) {
//        self.emptyDataSetSource = self
//        self.emptyDataSetDelegate = self
//        self.addInfiniteScrolling {
//            actionHandler()
//        }
//    }
//    
//    func stopAnimating() {
//        if let infiniteScrollingView = self.infiniteScrollingView {
//            infiniteScrollingView.stopAnimating()
//        }
//        if let pullToRefreshView = self.pullToRefreshView {
//            pullToRefreshView.stopAnimating()
//        }
//    }
//    
//    func pullToRefresh(_ actionHandler: @escaping ()->Swift.Void) {
//        self.emptyDataSetSource = self
//        self.emptyDataSetDelegate = self
//        self.addPullToRefresh(actionHandler: {
//            actionHandler()
//        })
//        //        self.pullToRefreshView.activityIndicatorView().color = UIColor.navibar
//        self.pullToRefreshView.arrowColor = UIColor.navibar
//        self.pullToRefreshView.textColor = UIColor.text
//        self.pullToRefreshView.setTitle("Kéo để làm mới...".localized(), forState: 0)
//        self.pullToRefreshView.setTitle("Thả để làm mới...".localized(), forState: 1)
//        self.pullToRefreshView.setTitle("Đang tải...", forState: 2)
//        self.triggerPullToRefresh()
//    }
//}

//extension UIScrollView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
//
//    //    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//    //        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
//    //
//    //        let partOne = NSMutableAttributedString(string: "", attributes: attributes)
//    //        return partOne
//    //    }
//    //
//    //    public func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//    //        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.text]
//    //        let partOne = NSMutableAttributedString(string: "Không có dữ liệu", attributes: attributes)
//    //        return partOne
//    //    }
//
//    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//
//    public func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
//        return false
//    }
//    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
//
//        return #imageLiteral(resourceName: "no_data")
//
//    }
//}

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(vc: self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}
extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
extension Int64 {
    
    func toStringDate(dateFormat: DateFormat) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        
        return  date.toString(dateFormat: dateFormat)!
    }
    func toDate() -> Date {
        
        
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        
        return  date
    }
    func toDate2() -> Date {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        return date
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone.current
        //        dateFormatter.locale = NSLocale.current
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        //        let strDate = dateFormatter
        
    }
}
extension BaseMappable {
    
    func toData() -> Data {
        
        let data = try! JSONSerialization.data(withJSONObject: self.toJSON() , options: JSONSerialization.WritingOptions.prettyPrinted)
        return data
    }
    
}
extension UITableView {
    
    func tableViewHeight() -> CGFloat {
        self.layoutIfNeeded()
        self.setNeedsLayout()
        self.updateConstraints()
        return self.contentSize.height
    }
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
extension UICollectionView {
    
    func reloadData(completion: @escaping ()->()) {
       
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                completion()
            })
            
            
        }
    }
}
//extension UIView {
//
//    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
//        let animation = CABasicAnimation(keyPath: "transform.rotation")
//
//        animation.toValue = toValue
//        animation.duration = duration
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = CAMediaTimingFillMode.forwards
//
//        self.layer.add(animation, forKey: nil)
//    }
//    func applyGradient(colours: [UIColor]) -> Void {
//        self.applyGradient(colours: colours, locations: nil)
//    }
//
//    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors = colours.map { $0.cgColor }
//        gradient.locations = locations
//        self.layer.insertSublayer(gradient, at: 0)
//    }
//    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        self.layer.mask = mask
//    }
//}
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
extension UIWindow {
    public func swapRootViewControllerWithAnimation(newViewController:UIViewController, animationType:SwapRootVCAnimationType, completion: (() -> ())? = nil)
    {
        guard let currentViewController = rootViewController else {
            return
        }
        
        let width = currentViewController.view.frame.size.width;
        let height = currentViewController.view.frame.size.height;
        
        var newVCStartAnimationFrame: CGRect?
        var currentVCEndAnimationFrame:CGRect?
        
        var newVCAnimated = true
        
        switch animationType
        {
        case .push:
            newVCStartAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            currentVCEndAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
        case .pop:
            currentVCEndAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
            newVCStartAnimationFrame = CGRect(x: 0 - width/4, y: 0, width: width, height: height)
            newVCAnimated = false
        case .present:
            newVCStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
        case .dismiss:
            currentVCEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
            newVCAnimated = false
        }
        
        newViewController.view.frame = newVCStartAnimationFrame ?? CGRect(x: 0, y: 0, width: width, height: height)
        
        addSubview(newViewController.view)
        
        if !newVCAnimated {
            bringSubviewToFront(currentViewController.view)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            if let currentVCEndAnimationFrame = currentVCEndAnimationFrame {
                currentViewController.view.frame = currentVCEndAnimationFrame
            }
            
            newViewController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        }, completion: { finish in
            self.rootViewController = newViewController
            completion?()
        })
        
        makeKeyAndVisible()
    }
}

