//
//  AuthServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Domain
import Data


public final class SignInWithEmailServiceAdapter: SignInServiceClient {
        
    public init(){}
    
    public func signInWithEmail(request: SignInViewModel, completion: @escaping (Result<UserSignInResponse, SignInDomainError>) -> Void) {
                        
        Auth.auth().signIn(withEmail: request.email, password: request.password) { (result, error) in
            if let _ = error {
                completion(.failure(.accountNotFound))
                return
            }
            
            let userModelResponse = UserSignInResponse(uid: result?.user.uid,
                                                      name: result?.user.displayName,
                                                      email: result?.user.email,
                                                      photoURL: result?.user.photoURL,
                                                      isAnonymous: result?.user.isAnonymous,
                                                      providerID: result?.user.providerID)
            
            completion(.success(userModelResponse))
        }
        
    }
}
