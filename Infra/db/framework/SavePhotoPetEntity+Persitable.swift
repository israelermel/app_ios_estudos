//
//  SavePhotoPetEntity+Persitable.swift
//  Infra
//
//  Created by Israel Ermel on 19/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

extension SavePhotoPetEntity: Persistable {
        
    public init(managedObject: SavePhotoPetObject) {
        self.init(id: managedObject.id,
                  photo: managedObject.photo)
    }
    
    public var identifier: String {
        managedObject().id
    }
    
    public func managedObject() -> SavePhotoPetObject {
        let data = SavePhotoPetObject()
        data.id = id
        data.photo = photo
        return data
    }
    
}
