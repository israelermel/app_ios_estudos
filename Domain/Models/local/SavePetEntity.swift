//
//  SavePet.swift
//  Domain
//
//  Created by Israel Ermel on 13/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation

public struct SavePetEntity {
    
    public var id: String
    public var petDescription: String
    public var petCoordinate: PetCoordinateEntity?
    public var photos = [SavePhotoPetEntity]()
    
    public init(id: String, petDescription: String, petCoordinate: PetCoordinateEntity?, photos: [SavePhotoPetEntity]) {
        self.id = id
        self.petDescription = petDescription
        self.petCoordinate = petCoordinate
        self.photos = photos
    }
}
