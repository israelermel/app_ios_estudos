//
//  SavePetLocationRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SavePetLocationRequest: Model {
    public var city: String
    public var state: String
    public var latitude: Double
    public var longitude: Double
    public var especie: String
    
    public init(city: String,
                state: String,
                latitude: Double,
                longitude: Double,
                especie: String)
    {
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
        self.especie = especie
    }
    
    func toModel() -> SavePetLocationViewModel {
        return SavePetLocationViewModel(city: self.city,
                                        state: self.state,
                                        latitude: self.latitude,
                                        longitude: self.longitude,
                                        especie: self.especie)
    }
}
