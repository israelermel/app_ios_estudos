//
//  SignUpServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SignUpWithEmailServiceClient {
     func signUpWithEmail(request: SignUpViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void)
}
