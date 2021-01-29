//
//  SignUpWithAppleUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol SignUpWithAppleUseCase {
    typealias Result = Swift.Result<UserSignInResponse, SignUpDomainError>
    func signUpWithApple(request: SignInAppleViewModel, completion: @escaping (Result) -> Void)
}
