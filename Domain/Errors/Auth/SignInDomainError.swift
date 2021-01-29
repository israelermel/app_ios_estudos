//
//  AuthDomainError.swift
//  Domain
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public enum SignInDomainError: Error {
    case operationNotAllowed
    case userDisabled
    case wrongPassword
    case invalidEmail
    case accountNotFound
}
