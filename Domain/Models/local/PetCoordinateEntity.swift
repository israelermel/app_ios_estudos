//
//  PetCoordinateMap.swift
//  iOSUI
//
//  Created by Israel Ermel on 03/11/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct PetCoordinateEntity {
    
    public var id: String
    public var address: String
    public var city: String
    public var state: String
    public var latitude: Double
    public var longitude: Double
    
    public init(id: String, address: String, city: String, state: String, latitude: Double, longitude: Double) {
        self.id = id
        self.address = address
        self.city = city
        self.state = state
        self.latitude = latitude
        self.longitude = longitude
    }
}
