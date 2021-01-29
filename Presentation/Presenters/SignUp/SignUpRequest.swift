//
//  SignUpRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SignUpRequest: Model {
    public var fullname: String?
    public var email: String?
    public var password: String?
    public var passwordConfirmation: String?
    
    public init(fullname: String? = nil, email: String? = nil, password: String? = nil, passwordConfirmation: String? = nil) {
        self.fullname = fullname
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
    
    func toModel() -> SignUpViewModel {
        return SignUpViewModel(fullname: self.fullname!, email: self.email!, password: self.password!, passwordConfirmation: self.passwordConfirmation!)
    }
}
