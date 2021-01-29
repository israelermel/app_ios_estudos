//
//  SignUpViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct SignUpViewModel: Model {
    public var fullname: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    public init(fullname: String, email: String, password: String, passwordConfirmation: String) {
        self.fullname = fullname
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
