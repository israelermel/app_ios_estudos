//
//  WriteTransaction.swift
//  Infra
//
//  Created by Israel Ermel on 08/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift

public final class WriteTransaction {
    
    private let realm: Realm
    
    internal init(realm: Realm) {
        self.realm = realm
    }
    
    public func add<T: Persistable>(_ value: T, update: Bool = false) {
        
        let updatePolicy = getUpdatePolicyEnum(from: update)
        
        realm.add(value.managedObject(), update: updatePolicy)
    }
    
    public func add<T: Sequence>(_ values: T, update: Bool = false) where T.Iterator.Element: Persistable {
        values.forEach { add($0, update: update) }
    }
    
    public func delete<T: Persistable>(_ value: T) {
        realm.delete(value.managedObject())
    }
    
    public func delete<T: Sequence>(_ values: T) where T.Iterator.Element: Persistable {
       realm.delete(values.map { $0.managedObject() })
    }
    
    public func delete<T: Persistable>(_ value: T, filter: NSPredicate) {
        let filterResult = realm.objects(T.ManagedObject.self).filter(filter)
        realm.delete(filterResult)
    }
    
    public func deleteById<T: Persistable>(_ value: T) {
        let filter = NSPredicate(format: "id == %@", value.identifier)
        delete(value, filter: filter)
    }

    public func update<T: Persistable>(_ type: T.Type, values: [T.PropertyValue]) {
        var dictionary: [String: Any] = [:]
        
        values.forEach {
            let pair = $0.propertyValuePair
            dictionary[pair.name] = pair.value
        }
        
        let updatePolicy = getUpdatePolicyEnum(from: true)
        
        realm.create(T.ManagedObject.self, value: dictionary, update: updatePolicy)
    }
    
    private func getUpdatePolicyEnum(from isUpdate: Bool) -> Realm.UpdatePolicy {
        return isUpdate ? Realm.UpdatePolicy.modified : Realm.UpdatePolicy.error
    }
}

