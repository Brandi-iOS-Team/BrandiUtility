//
//  Bundle+Extension.swift
//  Brandi
//
//  Created by Joo Hee Kim on 21. 01. 04..
//  Copyright © 2021 Brandi. All rights reserved.
//

import Foundation

public extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var displayName: String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
    
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
    
    func isUpdateAvailable(_ appID: String) -> Bool {
        guard
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?id=\(appID)"),
            let data = try? Data(contentsOf: url),
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let results = json["results"] as? [[String: Any]],
            results.count > 0,
            let appStoreVersion = results.first?["version"] as? String
        else { return false }
        if !(version == appStoreVersion) { return true }
        else { return false }
    }
    
}
