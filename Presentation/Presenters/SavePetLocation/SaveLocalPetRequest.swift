//
//  SaveLocalPetRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 14/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SaveLocalPetRequest: Model {
    public var id: String
    public var petDescription: String
    
    public init(id: String,
                petDescription: String) {
        self.id = id
        self.petDescription = petDescription
    }
}
