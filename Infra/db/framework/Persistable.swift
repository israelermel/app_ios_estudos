//
//  Persistable.swift
//  Infra
//
//  Created by Israel Ermel on 08/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift


/// Represents a type that can be persisted using Realm.
public protocol Persistable {

    associatedtype ManagedObject: Object
    associatedtype PropertyValue: PropertyValueType = DefaultPropertyValue
    associatedtype Query: QueryType = DefaultQuery

    init(managedObject: ManagedObject)

    func managedObject() -> ManagedObject
    
    var identifier: String { get }
}

public typealias PropertyValuePair = (name: String, value: Any)

/// Represents a property value
public protocol PropertyValueType {
    var propertyValuePair: PropertyValuePair { get }
}

public enum DefaultPropertyValue: PropertyValueType {

    public var propertyValuePair: PropertyValuePair {
        return ("", 0)
    }
}

/// Represents a Query
public protocol QueryType {
    var predicate: NSPredicate? { get }
    var sortDescriptors: [SortDescriptor] { get }
}

public enum DefaultQuery: QueryType {

    public var predicate: NSPredicate? {
        return nil
    }

    public var sortDescriptors: [SortDescriptor] {
        return []
    }
}
