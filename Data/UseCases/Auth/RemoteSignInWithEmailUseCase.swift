//
//  AuthRepositoryImpl.swift
//  Infra
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteSignInWithEmailUseCase: SignInWithEmailUseCase {
    private let service: SignInWithEmailServiceClient
    
    public init(service: SignInWithEmailServiceClient) {
        self.service = service
    }
    
    public func signInWithEmail(request: SignInViewModel, completion: @escaping (SignInWithEmailUseCase.Result) -> Void) {
        self.service.signInWithEmail(request: request) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
               case .success(let data) : completion(.success(data))
               case .failure(let error) : completion(.failure(error))
            }
                        
        }
    }
}

