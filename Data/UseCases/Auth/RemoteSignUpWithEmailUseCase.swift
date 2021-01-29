//
//  AuthRepositoryImpl.swift
//  Infra
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteSignUpWithEmailUseCase: SignUpWithEmailUseCase {
    private let service: SignUpWithEmailServiceClient
    
    public init(service: SignUpWithEmailServiceClient) {
        self.service = service
    }
    
    public func signUpWithEmail(request: SignUpViewModel, completion: @escaping (SignUpWithEmailUseCase.Result) -> Void) {
        self.service.signUpWithEmail(request: request) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
               case .success(let data) : completion(.success(data))
               case .failure(let error) : completion(.failure(error))
            }
                        
        }
    }
}

