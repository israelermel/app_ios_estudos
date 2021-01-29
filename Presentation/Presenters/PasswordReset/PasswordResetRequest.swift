//
//  PasswordResetRequest.swift
//  Presentation
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct PasswordResetRequest: Model {
    public var email: String?
    
    public init(email: String? = nil) {
        self.email = email
    }
    
    func toModel() -> PasswordResetViewModel {
        return PasswordResetViewModel(email: self.email!)
    }
}
