//
//  SavePetEntity+Persitable.swift
//  Infra
//
//  Created by Israel Ermel on 13/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import RealmSwift

extension SavePetEntity: Persistable {
    public init(managedObject: SavePetObject) {
        self.init(id: managedObject.id,
                  petDescription: managedObject.petDescription,
                  petCoordinate : managedObject.petCoordinate
                    .flatMap(PetCoordinateEntity.init(managedObject:)),
                  photos: managedObject.photos.compactMap(SavePhotoPetEntity.init(managedObject:))
        )
    }
    
    public var identifier: String {
        managedObject().id
    }
    
    public func managedObject() -> SavePetObject {
        let pet = SavePetObject()
        pet.id = id
        pet.petDescription = petDescription
        pet.petCoordinate = petCoordinate?.managedObject()
        
        photos.forEach { entity in
            pet.photos.append(entity.managedObject())
        }
        
        return pet
    }
    
}
