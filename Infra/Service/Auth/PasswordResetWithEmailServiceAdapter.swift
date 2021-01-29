//
//  PasswordResetWithEmailServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain
import FirebaseAuth
import FirebaseFirestore

public final class PasswordResetWithEmailServiceAdapter: PasswordResetWithEmailServiceClient {
    
    public init() {}
    
    public func passwordReset(request: PasswordResetViewModel, completion: @escaping (PasswordResetVoidResult) -> Void) {
        
        Auth.auth().sendPasswordReset(withEmail: request.email) { error in
            if let _ = error {
                completion(.failure(.emailNotFound))
                return
            }

            completion(.success)
        }
        
    }
}
