//
//  LocalPetCoordinateUseCase.swift
//  Data
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class LocalPetCoordinateUseCase: PetCoordinateUseCase {
    
    private let service: PetCoordinateServiceClient
    
    public init(service: PetCoordinateServiceClient) {
        self.service = service
    }
    
    public func savePetCoordinate(request: PetCoordinateEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        
        self.service.savePetCoordinate(request: request) { [weak self] result in

            guard self != nil else { return }

            switch result {
            case .success: completion(.success)
            case .failure(let error): completion(.failure(error))
            }

        }
    }
    
}
