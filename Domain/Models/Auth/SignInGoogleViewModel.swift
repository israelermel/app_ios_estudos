//
//  SignInGoogleViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 14/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation


public struct SignInGoogleViewModel: Model {
    public var idToken: String
    public var accessToken: String
        
    public init(idToken: String, accessToken: String) {
        self.idToken = idToken
        self.accessToken = accessToken
    }
}
