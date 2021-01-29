//
//  PasswordResetViewModel.swift
//  Domain
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct PasswordResetViewModel: Model {
    public var email: String
        
    public init(email: String) {
        self.email = email
    }
   
}
