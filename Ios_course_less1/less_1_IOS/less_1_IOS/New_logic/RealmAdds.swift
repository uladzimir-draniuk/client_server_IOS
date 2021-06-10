//
//  RealmAdds.swift
//  VKAppClone
//
//  Created by elf on 10.06.2021.
//

import Foundation
import RealmSwift

class RealmAdds {
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    static func save<T: Object>(
        items: [T],
        configuration: Realm.Configuration = deleteIfMigration
    ) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items)
        }
    }
    
    static func get<T: Object>(
        type: T.Type,
        configuration: Realm.Configuration = deleteIfMigration
    ) throws -> Results<T> {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        return realm.objects(T.self)
    }
}
