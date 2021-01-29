//
//  PetCoordinateEntity+Persitable.swift
//  Infra
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

extension PetCoordinateEntity: Persistable {
    
    public var identifier: String {
        managedObject().id
    }
    
    public init(managedObject: PetCoordinateObject) {
        self.init(id: managedObject.id,
                  address: managedObject.address,
                  city: managedObject.city,
                  state: managedObject.state,
                  latitude: managedObject.latitude,
                  longitude: managedObject.longitude)
    }
    
    public func managedObject() -> PetCoordinateObject {
        let petCoordinate = PetCoordinateObject()
        petCoordinate.id = id
        petCoordinate.address = address
        petCoordinate.city = city
        petCoordinate.state = state
        petCoordinate.latitude = latitude
        petCoordinate.longitude = longitude
        return petCoordinate
    }
}


extension PetCoordinateEntity {

    public enum PropertyValue: PropertyValueType {
        case identifier(String)

        public var propertyValuePair: PropertyValuePair {
            switch self {
            case .identifier(let id):
                return ("id", id)
            }
        }
    }
}

extension PetCoordinateEntity {

    public enum Query: QueryType {
        case petCoordinateIdentifier(String)

        public var predicate: NSPredicate? {
            switch self {
            case .petCoordinateIdentifier(let value):
                return NSPredicate(format: "id == %@", value)
            }
        }

        public var sortDescriptors: [SortDescriptor] {
            return [
                SortDescriptor(stringLiteral: "state")
            ]
        }
              
    }
}
