//
//  PetCoordinateUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation

public protocol PetCoordinateUseCase {
    func savePetCoordinate(request: PetCoordinateEntity, completion: @escaping(SavePetVoidResult) -> Void)
}
