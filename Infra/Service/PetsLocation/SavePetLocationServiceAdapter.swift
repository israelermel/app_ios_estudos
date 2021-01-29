//
//  SavePetLocationServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import Data

public final class SavePetLocationServiceAdapter: SavePetLocationServiceClient {
    public func savePetLocation(request: SavePetEntity, completion: @escaping (SavePetLocationVoidResult) -> Void) {
        print("israel: \(request)")
    }
    
    
    public init() {}
    
//    public func savePetLocation(request: SavePetLocationViewModel, completion: @escaping (SavePetLocationVoidResult) -> Void) {
//
//        // todo implementar firestore
//        // todo: israel
//    }
}
