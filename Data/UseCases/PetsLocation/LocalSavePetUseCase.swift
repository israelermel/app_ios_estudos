//
//  LocalSavePetUseCase.swift
//  Data
//
//  Created by Israel Ermel on 14/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class LocalSavePetUseCase: SavePetUseCase {
    
    private let service: PetCoordinateServiceClient
    
    public init(service: PetCoordinateServiceClient) {
        self.service = service
    }
    
    public func savePet(request: SavePetEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        
        self.service.savePet(request: request) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case .success: completion(.success)
            case .failure(let error): completion(.failure(error))
            }
            
        }
        
    }
    
}
