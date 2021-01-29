//
//  PetsLocationViewModel.swift
//  Presentation
//
//  Created by Israel Ermel on 13/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct PetsLocationViewModel: Model {
    public var city: String?
    public var state: String?
    public var latitude: Double?
    public var longitude: Double?
    public var especie: String?
    
    public init(petsLocationResponse: PetsLocationResponse) {
        self.city = petsLocationResponse.city
        self.state = petsLocationResponse.state
        self.especie = petsLocationResponse.especie
        self.latitude = petsLocationResponse.latitude
        self.longitude = petsLocationResponse.longitude    
    }
}
