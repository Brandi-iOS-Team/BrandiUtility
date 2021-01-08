//
//  RealmExtensions.swift
//  Brandi
//
//  Created by Joongwon Kim on 2020/08/25.
//  Copyright © 2020 Brandi. All rights reserved.
//

import RealmSwift

public extension Realm {
    static var current: Realm? {
        var config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        config.fileURL = config.fileURL!.deletingLastPathComponent()
            .appendingPathComponent("brandiDatabase.realm")
        return try? Realm(configuration: config)
    }

    static func executeOnMainThread(realm: Realm? = nil, _ execution: @escaping (Realm) -> Void) {
        if let realm = realm {
            if realm.isInWriteTransaction {
                execution(realm)
            } else {
                try? realm.write {
                    execution(realm)
                }
            }
            return
        }

        guard let currentRealm = Realm.current else { return }

        if currentRealm.isInWriteTransaction {
            execution(currentRealm)
        } else {
            try? currentRealm.write {
                execution(currentRealm)
            }
        }
    }
}
