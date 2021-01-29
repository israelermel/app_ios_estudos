//
//  SignInRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SignInRequest: Model {
    public var email: String?
    public var password: String?
    
    public init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }
    
    func toModel() -> SignInViewModel {
        return SignInViewModel(email: self.email!, password: self.password!)
    }
}
