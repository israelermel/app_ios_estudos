//
//  RemoteSignUpWithAppleUseCase.swift
//  Data
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteSignUpWithAppleUseCase: SignUpWithAppleUseCase {
    private let service: SignUpWithAppleServiceClient
    
    public init(service: SignUpWithAppleServiceClient) {
        self.service = service
    }
    
    public func signUpWithApple(request: SignInAppleViewModel, completion: @escaping (SignUpWithAppleUseCase.Result) -> Void) {
        
        service.signUpWithApple(request: request) { [weak self] result in
            
            guard self != nil else { return }
            
            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
            
        }
        
    }
}
