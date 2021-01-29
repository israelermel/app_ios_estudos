//
//  SignUpWithGoogleServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 13/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SignUpWithGoogleServiceClient {
    func signUpWithGoogle(request: SignInGoogleViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void)    
}
