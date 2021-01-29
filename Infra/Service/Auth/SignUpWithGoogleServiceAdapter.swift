//
//  SignUpWithGoogleServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 13/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

public final class SignUpWithGoogleServiceAdapter: SignUpWithGoogleServiceClient {
    
    public init(){}
    
    public func signUpWithGoogle(request: SignInGoogleViewModel, completion: @escaping (Result<UserSignInResponse, SignUpDomainError>) -> Void) {
        
        let credential = GoogleAuthProvider.credential(withIDToken: request.idToken, accessToken: request.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let _ = error {
                completion(.failure(.unexpected))
                return
            }

            guard let uid = result?.user.uid else { return }

            let documentRef = Firestore.firestore().collection("users").document(uid)

            documentRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    completion(.failure(.alreadySignUp))
                } else {
                    guard let email = result?.user.email else { return }
                    guard let fullname = result?.user.displayName else { return }
                    let providerID = "google"
                    
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
