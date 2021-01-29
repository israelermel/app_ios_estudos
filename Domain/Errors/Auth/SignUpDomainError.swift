//
//  SignUpDomainError.swift
//  Domain
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public enum SignUpDomainError: Error {
    case unexpected
    case invalidEmail
    case emailAlreadyInUse
    case weakPassword
    case alreadySignUp
}
