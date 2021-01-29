//
//  SignUpWithGoogleUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 13/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol SignUpWithGoogleUseCase {
    typealias Result = Swift.Result<UserSignInResponse, SignUpDomainError>
    func signUpWithGoogle(request: SignInGoogleViewModel, completion: @escaping (Result) -> Void)    
}
