//
//  SignInGoogleRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 14/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SignInGoogleRequest: Model {
    public var idToken: String
    public var accessToken: String
        
    public init(idToken: String, accessToken: String) {
        self.idToken = idToken
        self.accessToken = accessToken
    }
    
    func toModel() -> SignInGoogleViewModel {
        return SignInGoogleViewModel(idToken: self.idToken, accessToken: self.accessToken)
    }
    
}
