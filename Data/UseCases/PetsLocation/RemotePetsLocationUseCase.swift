//
//  RemotePetsLocationUseCase.swift
//  Data
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemotePetsLocationUseCase: PetsLocationUseCase {
    
    private let service: PetsLocationServiceClient
    
    public init(service: PetsLocationServiceClient) {
        self.service = service
    }
    
    public func retrieveAllPetsLocation(request: SearchPetsLocationViewModel, completion: @escaping (PetsLocationUseCase.Result) -> Void) {
        
        self.service.retrieveAllPetsLocation(request: request) { [weak self] result in
            
            
            guard self != nil else { return }
            
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
            
        }
        
    }
    
}
