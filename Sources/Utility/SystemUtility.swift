//
//  SystemUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 1. 25..
//  Copyright © 2016년 Brandi. All rights reserved.
//

#if !os(watchOS)
import Foundation
import WebKit

public enum LocaleType: String {
    case eng = "en"
    case kor = "ko"
    case ELSE = "other language"
}

public enum DeviceType: CGFloat {
    case iPhone4 = 567.0
    case iPhone5 = 568.0
    case iPhone6 = 667.0
    case iPhone6P = 736.0
    case iPhoneX = 812.0
    case iPhone12 = 844
    case iPhoneXSM = 896.0  // iPhone Xr has the same logical resolution with iPhone Xs Max
    case iPhone12M = 926
    case notRecognized = 0.0
}

open class SystemUtility {
    // MARK: Variables
    private static var keySet: [NSValue] = []
    private static var titleSet: [NSValue: String?] = [ : ]
    private static var refreshSet: [NSValue: Bool] = [ : ]
    private static var loginRefreshSet: [NSValue: Bool] = [ : ]
    
    // MARK: System Status Functions
    public static func getBuildVersion() -> String {
        var ver: String = "0"
        if let version = Bundle.main.infoDictionary?[String(kCFBundleVersionKey)] as? String {
            ver = version
            Logger.infoLog("\(Bundle.main.displayName) iOS version is: \(ver)")
        } else {
            Logger.infoLog("An Error Occurered within getting app version process")
        }
        return ver
    }
    
    public static func getVersionCode() -> String {
        var ver: String = "0.0.0"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            ver = version
            Logger.infoLog("\(Bundle.main.displayName) iOS version is: \(ver)")
        } else {
            Logger.infoLog("An Error Occurered within getting app version process")
        }
        return ver
    }
    
    public static func getLocale() -> LocaleType {
        guard let language = Locale.preferredLanguages.first else { return LocaleType.kor }
        if language.contains(LocaleType.kor.rawValue) {
            return LocaleType.kor
        } else if language.contains(LocaleType.eng.rawValue) {
            return LocaleType.eng
        } else {
            return LocaleType.ELSE
        }
    }
    
    public static func screenSizeRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    public static func getDeviceType() -> DeviceType {
        let height = UIScreen.main.bounds.height
        if height < DeviceType.iPhone5.rawValue {
            Logger.infoLog("IPHONE_4")
            return .iPhone4
        } else if height == DeviceType.iPhone5.rawValue {
            Logger.infoLog("IPHONE_5")
            return .iPhone5
        } else if height == DeviceType.iPhone6.rawValue {
            Logger.infoLog("IPHONE_6")
            return .iPhone6
        } else if height == DeviceType.iPhone6P.rawValue {
            Logger.infoLog("IPHONE_6P")
            return .iPhone6P
        } else if height == DeviceType.iPhoneX.rawValue {
            Logger.infoLog("IPHONE_X")
            return .iPhoneX
        } else if height == DeviceType.iPhone12.rawValue {
            Logger.infoLog("IPHONE_12")
            return .iPhone12
        } else if height == DeviceType.iPhoneXSM.rawValue {
            Logger.infoLog("IPHONE_XSM")
            return .iPhoneXSM
        } else if height == DeviceType.iPhone12M.rawValue {
            Logger.infoLog("IPHONE_12M")
            return .iPhone12M
        } else {
            Logger.infoLog("IOS_DEVICE_TYPE_NOT_REQUIRED")
            return .notRecognized
        }
    }
    
    public static func getDeviceNameInDetail() -> String {
        var modelName: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
            case "AppleTV5,3":                              return "Apple TV"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
            }
        }
        return modelName
    }
    
    // MARK: System Management Functions
    public static func startDelayedTask(_ duration: Double, taskBlock: @escaping (() -> Void)) {
        let delay = duration * Double(NSEC_PER_SEC)
        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: time,
                       execute: {
                        taskBlock()
            }
        )
    }
    
    public static func setApplicationBadgeNumber(_ number: Int) {
        UIApplication.shared.applicationIconBadgeNumber = number
    }
    
    public static func getTopWindow() -> UIWindow? {
        if let window = UIApplication.shared.delegate?.window {
            return window
        } else {
            return nil
        }
    }
    
    public static func getTopViewController() -> UIViewController? {
        if let baseController = UIApplication.shared.delegate?.window??.visibleViewController {            
            if baseController.isKind(of: UITabBarController.self) {
                // navigationController의 CurrentViewController를 리턴
                let tab = (baseController as! UITabBarController)
                let nav = tab.selectedViewController as? UINavigationController
                if let vc = nav?.presentedViewController {
                    return vc
                }
            } else if baseController.isKind(of: UINavigationController.self) {
                // CurrentViewController 를 리턴
                let nav = baseController as? UINavigationController
                if let vc = nav?.presentedViewController {
                    return vc
                }
            } else if baseController.isKind(of: UIViewController.self) {
                // 리턴
                return baseController
            }
        }
        return nil
    }
    
    public static func killApplicationImmediately() {
        exit(0)
    }
    
    private static var globalWKWebView: WKWebView?

    public static func getGlobalWKWebView(_ frame: CGRect) -> WKWebView {
        self.globalWKWebView?.removeFromSuperview()
        if self.globalWKWebView == nil {
            let config = WKWebViewConfiguration()
            config.allowsInlineMediaPlayback = true
            config.dataDetectorTypes = []
            self.globalWKWebView = WKWebView(frame: frame, configuration: config)
        }
        self.globalWKWebView?.frame = frame
        self.globalWKWebView?.layoutIfNeeded()
        return self.globalWKWebView!
    }

    public static func setGlobalWKWebViewReleased() {
//        self.globalWKWebView = nil
    }

    public static func isGlobalWKWebViewNil() -> Bool {
        return (self.globalWKWebView == nil) ? true : false
    }
}
#endif
