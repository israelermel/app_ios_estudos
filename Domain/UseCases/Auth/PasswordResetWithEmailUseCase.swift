//
//  PasswordResetWithEmail.swift
//  Domain
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol PasswordResetWithEmailUseCase {
    func passwordReset(request: PasswordResetViewModel, completion: @escaping (PasswordResetVoidResult) -> Void)
}


