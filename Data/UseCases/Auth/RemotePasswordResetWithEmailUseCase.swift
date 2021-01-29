//
//  RemotePasswordResetWithEmailUseCase.swift
//  Data
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemotePasswordResetWithEmailUseCase: PasswordResetWithEmailUseCase {
    private let service: PasswordResetWithEmailServiceClient
    
    public init(service: PasswordResetWithEmailServiceClient) {
        self.service = service
    }
    
    public func passwordReset(request: PasswordResetViewModel, completion: @escaping (PasswordResetVoidResult) -> Void) {
        
        service.passwordReset(request: request) { [weak self] result in

            guard self != nil else { return }

            switch result {
            case .success: completion(.success)
            case .failure(let error): completion(.failure(error))
            }
        }
        
    }
}
