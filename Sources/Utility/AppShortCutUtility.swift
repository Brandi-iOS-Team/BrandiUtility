//
//  AppShortCutUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 4. 19..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation

public enum AppShortCutType: String {
    case none
    case actionSearch = "BRApplicationShortCutSearchAction"
    case actionOrders = "BRApplicationShortCutOrdersAction"
    case actionBookmarks = "BRApplicationShortCutBookmarksAction"
    case actionMyReviewsPhoto = "BRApplicationShortCutMyReviewsPhoto"
    case actionMyReviewsText = "BRApplicationShortCutMyReviewsText"
}

open class AppShortCutUtility {
    
    private static var shortCutAction: AppShortCutType = .none
    
    public init() {}
    
    // MARK: UIApplicationShortcut Related Functions
    public static func setAppShortCut(_ type: AppShortCutType) {
        self.shortCutAction = type
    }
    
    public static func getAppShortCut() -> AppShortCutType {
        return self.shortCutAction
    }
    
    public static func appShortCutActivated() {
        self.shortCutAction = .none
    }
}
