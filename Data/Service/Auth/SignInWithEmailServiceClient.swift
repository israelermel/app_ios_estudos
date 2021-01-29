//
//  AuthServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SignInWithEmailServiceClient {
     func signInWithEmail(request: SignInViewModel, completion: @escaping (Result<UserSignInResponse, SignInDomainError>) -> Void)
}
