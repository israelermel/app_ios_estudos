//
//  SignUpWithAppleServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SignUpWithAppleServiceClient {
    func signUpWithApple(request: SignInAppleViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void)
}
