//
//  PetsLocation.swift
//  Domain
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift

public struct PetsLocationResponse: Model, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    
    public var city: String
    public var state: String
    public var latitude: Double
    public var longitude: Double
    public var especie: String

    
    enum CodingKeys: String, CodingKey {
        case city = "cidade"
        case state = "estado"
        case especie = "especie"
        case latitude = "latitude"
        case longitude = "longitude"
    }
}
