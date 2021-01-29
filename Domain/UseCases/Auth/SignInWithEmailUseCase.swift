//
//  AuthRepository.swift
//  Domain
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol SignInWithEmailUseCase {
    typealias Result = Swift.Result<UserSignInResponse, SignInDomainError>
    func signInWithEmail(request: SignInViewModel, completion: @escaping(Result) -> Void)
}
