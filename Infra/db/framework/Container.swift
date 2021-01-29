//
//  Container.swift
//  Infra
//
//  Created by Israel Ermel on 08/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift

public final class Container {

    private let realm: Realm

    public convenience init() throws {
        try self.init(realm: Realm())
    }

    internal init(realm: Realm) {
        self.realm = realm
    }

    public func write(_ block: (WriteTransaction) throws -> Void) throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }

    public func values<T: Persistable> (_ type: T.Type, matching query: T.Query) -> FetchedResults<T> {
        var results = realm.objects(T.ManagedObject.self)

        if let predicate = query.predicate {
            results = results.filter(predicate)
        }

        results = results.sorted(by: query.sortDescriptors)

        return FetchedResults(results: results)
    }
    
    public func values<T: Persistable> (_ type: T.Type) -> FetchedResults<T> {
        let results = realm.objects(T.ManagedObject.self)
        return FetchedResults(results: results)
    }
}
