//
//  PasswordResetWithEmail.swift
//  Domain
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol PasswordResetWithEmailUseCase {
    typealias Result = Swift.Result<UserSignInResponse, SignInDomainError>
    func passwordReset(request: PasswordResetViewModel, completion: @escaping (Result) -> Void)
}


