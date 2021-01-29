//
//  RemoteSignUpWithGoogleUseCase.swift
//  Data
//
//  Created by Israel Ermel on 13/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteSignUpWithGoogleUseCase: SignUpWithGoogleUseCase {
    private let service: SignUpWithGoogleServiceClient
    
    public init(service: SignUpWithGoogleServiceClient) {
        self.service = service
    }
    
    public func signUpWithGoogle(request: SignInGoogleViewModel, completion: @escaping (SignUpWithGoogleUseCase.Result) -> Void) {
        
        service.signUpWithGoogle(request: request) { [weak self] result in
            guard self != nil else { return }

            switch result {
            case .success(let data): completion(.success(data))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
