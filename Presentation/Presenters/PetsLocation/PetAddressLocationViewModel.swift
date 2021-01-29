//
//  PetAddressLocation.swift
//  iOSUI
//
//  Created by Israel Ermel on 31/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct PetAddressLocationViewModel {
    
    let id: String
    let name: String
    let administrativeArea: String
    let locality: String
    let postalCode: String
    let latitude: Double
    let longitude: Double
    
    public init(id:String ,name: String, administrativeArea: String, locality: String,
                postalCode: String, latitude: Double, longitude: Double) {
        
        self.id = id
        self.name = name
        self.administrativeArea = administrativeArea
        self.locality = locality
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
    }
 
    public func fullAddress() -> String {
        return "\(name), \(locality), \(administrativeArea)"
    }
    
    public func addressDescription() -> String {
        return self.name
    }
    
    func toEntity() -> PetCoordinateEntity {
        return PetCoordinateEntity(id: id,
                                address: name,
                                city: locality,
                                state: administrativeArea,
                                latitude: latitude,
                                longitude: longitude)
    }
}
