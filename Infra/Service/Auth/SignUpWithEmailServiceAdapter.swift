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

public final class SignUpWithEmailServiceAdapter: SignUpWithEmailServiceClient {
    
    public init(){}
    
    public func signUpWithEmail(request: SignUpViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void) {
        
        Auth.auth().createUser(withEmail: request.email, password: request.password) { (result, error) in
            if let _ = error {
                completion(.failure(.unexpected))
            }
            
            guard let uid = result?.user.uid else { return }
            let providerID = "firebase"
            
            let values = ["email": request.email,
                          "fullname": request.fullname,
                          "hasSeenOnboarding": false,
                          "uid": uid] as [String : Any]
            
            let userModelResponse = UserSignInResponse(uid: uid,
                                                       name: request.fullname,
                                                       email: request.email,
                                                       photoURL: nil,
                                                       isAnonymous: false,
                                                       providerID: providerID)
            
            Firestore.firestore().collection("users").document(uid).setData(values) { result in
                completion(.success(userModelResponse))
            }
        }
    }
    
}
