//
//  AuthRepositoryImpl.swift
//  Infra
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

class SignInRepositoryImpl: SignInRepository {
    private let authServiceClient: AuthServiceClient
    
    public init(authServiceClient: AuthServiceClient) {
        self.authServiceClient = authServiceClient
    }
    
    func signInWithEmail(request: UserSignInAuthRequest, completion: @escaping (SignInRepository.Result) -> Void) {
        self.authServiceClient.authWithEmail(request: request) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .success(let data) :
                if let model = data {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
                
             case .failure(let error) : completion(.failure(error))
                
            }
                        
        }
    }
}

