//
//  SignUpWithEmailUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol SignUpWithEmailUseCase {
    typealias Result = Swift.Result<UserSignInResponse, SignUpDomainError>
    func signUpWithEmail(request: SignUpViewModel, completion: @escaping(Result) -> Void)
}
