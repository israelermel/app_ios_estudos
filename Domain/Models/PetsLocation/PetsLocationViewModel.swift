//
//  PetsLocationViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct SearchPetsLocationViewModel: Model {
    public var city: String?
    public var state: String?
    public var latitude: Double?
    public var longitude: Double?
    
    public init(city: String? = nil, state: String? = nil, latitude: Double? = 0.0, longitude: Double? = 0.0) {
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
    }
}
