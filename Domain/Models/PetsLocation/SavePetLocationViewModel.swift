//
//  SavePetLocationViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
//import FirebaseFirestore

public struct SavePetLocationViewModel: Model, Identifiable {
    @DocumentID public var id: String? = UUID().uuidString
    
    public var city: String
    public var state: String
    public var latitude: Double
    public var longitude: Double
    public var especie: String
//    public var lastUpdated: Timestamp = Timestamp(date: Date())
    
    enum CodingKeys: String, CodingKey {
        case city = "cidade"
        case state = "estado"
        case especie = "especie"
        case latitude = "latitude"
        case longitude = "longitude"
//        case lastUpdated = "ultimaAtualizacao"
    }
    
    
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
}

