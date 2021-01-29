//
//  SignInAppleViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct SignInAppleViewModel: Model {
    public var idToken: String
    public var nonce: String
    
    public init(idToken: String, nonce: String) {
        self.idToken = idToken
        self.nonce = nonce
    }
}
