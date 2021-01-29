//
//  MainDispatchQueueDecorator.swift
//  Main
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class MainDispatchQueueDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainDispatchQueueDecorator: SignInWithEmailUseCase where T: SignInWithEmailUseCase {
    public func signInWithEmail(request: SignInViewModel, completion: @escaping (SignInWithEmailUseCase.Result) -> Void) {
        instance.signInWithEmail(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: PetCoordinateUseCase where T: PetCoordinateUseCase {
    public func savePetCoordinate(request: PetCoordinateEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        instance.savePetCoordinate(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: SignUpWithEmailUseCase where T: SignUpWithEmailUseCase {
    public func signUpWithEmail(request: SignUpViewModel, completion: @escaping (SignUpWithEmailUseCase.Result) -> Void) {
        instance.signUpWithEmail(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: SignUpWithGoogleUseCase where T: SignUpWithGoogleUseCase {
    public func signUpWithGoogle(request: SignInGoogleViewModel, completion: @escaping (SignUpWithGoogleUseCase.Result) -> Void) {
    
        instance.signUpWithGoogle(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: PasswordResetWithEmailUseCase where T: PasswordResetWithEmailUseCase {
    
    public func passwordReset(request: PasswordResetViewModel, completion: @escaping (PasswordResetVoidResult) -> Void) {
    
        instance.passwordReset(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
        
    }
}

extension MainDispatchQueueDecorator: SignUpWithAppleUseCase where T: SignUpWithAppleUseCase {
    public func signUpWithApple(request: SignInAppleViewModel, completion: @escaping (SignUpWithAppleUseCase.Result) -> Void) {
    
        instance.signUpWithApple(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: PetsLocationUseCase where T: PetsLocationUseCase {
    public func retrieveAllPetsLocation(request: SearchPetsLocationViewModel, completion: @escaping (PetsLocationUseCase.Result) -> Void) {
        instance.retrieveAllPetsLocation(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: SavePetUseCase where T: SavePetUseCase {
    public func savePet(request: SavePetEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        instance.savePet(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator: RemoteSavePetUseCase where T: RemoteSavePetUseCase {    
    public func savePetLocation(request: SavePetEntity, completion: @escaping (SavePetLocationVoidResult) -> Void) {
        instance.savePetLocation(request: request) { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}

