//
//  SavePetViewModel.swift
//  Presentation
//
//  Created by Israel Ermel on 16/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SavePetViewModel {
    
    private let id: String
    private var petDescription: String? = ""
    private var location: PetAddressLocationViewModel?
    private var photos: [SavePhotoPetViewModel]? = []
    
    public init(id: String) {
        self.id = id
    }
    
    public mutating func addPhoto(data: String) {
        let photo = SavePhotoPetViewModel(id: UUID().uuidString,
                                          photo: data)
        photos?.append(photo)
    }
    
    public mutating func updatePet(description to: String) {
        self.petDescription = to
    }
    
    public mutating func updatePet(location to: PetAddressLocationViewModel) {
        self.location = to
    }
    
    public func toEntity() -> SavePetEntity {
        
        return SavePetEntity(id: id,
                             petDescription: petDescription!,
                             petCoordinate: location?.toEntity(),
                             photos: (photos?.map({ $0.toEntity() }))!
                            )
    }
    
    public mutating func isValid() -> Bool {
        return !self.petDescription.isEmptyOrNil &&
            self.location != nil &&
            !self.photos.isEmptyOrNil
    }
}
