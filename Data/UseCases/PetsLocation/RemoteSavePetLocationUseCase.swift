//
//  RemoteSavePetLocationUseCase.swift
//  Data
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteSavePetLocationUseCase: RemoteSavePetUseCase {
    private let service: SavePetLocationServiceClient
    
    public init(service: SavePetLocationServiceClient) {
        self.service = service
    }
    
    public func savePetLocation(request: SavePetEntity, completion: @escaping (SavePetLocationVoidResult) -> Void) {
        
        self.service.savePetLocation(request: request) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case .success: completion(.success)
            case .failure(let error): completion(.failure(error))
            }
            
        }
    }    
}
