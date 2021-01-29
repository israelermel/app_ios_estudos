//
//  SignUpWithAppleServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

public final class SignUpWithAppleServiceAdapter: SignUpWithAppleServiceClient {
    
    public init(){}
    
    public func signUpWithApple(request: SignInAppleViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void) {
        
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: request.idToken,
                                                  rawNonce: request.nonce)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let uid = result?.user.uid else { return }

            let documentRef = Firestore.firestore().collection("users").document(uid)

            documentRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    completion(.failure(.alreadySignUp))
                } else {
                    guard let email = result?.user.email else { return }
                    let fullname = result?.user.displayName ?? "informe seu nome"
                    let providerID = "apple"
                    
                    let values = ["email": email,
                                  "fullname": fullname,
                                  "hasSeenOnboarding": false,
                                  "providerID": providerID,
                                  "uid": uid] as [String : Any]

                    let userModelResponse = UserSignInResponse(uid: uid,
                                                               name: fullname,
                                                               email: email,
                                                               photoURL: nil,
                                                               isAnonymous: false,
                                                               providerID: providerID)
                    
                    documentRef.setData(values) { error in
                        if let _ = error {
                            completion(.failure(.unexpected))
                        }
                        
                        completion(.success(userModelResponse))
                    }
                }
            }
        }
        
    }
}
