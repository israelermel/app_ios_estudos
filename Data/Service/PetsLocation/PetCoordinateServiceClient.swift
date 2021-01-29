//
//  PetCoordinateServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol PetCoordinateServiceClient {
    func savePetCoordinate(request: PetCoordinateEntity, completion: @escaping (SavePetVoidResult) -> Void)
    func savePet(request: SavePetEntity, completion: @escaping (SavePetVoidResult) -> Void)    
}
