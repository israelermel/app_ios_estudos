//
//  SignInControllerFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import iOSUI
import Presentation
import Validation
import UIKit

public func makeSignInWithEmailController() -> SignInViewController {
    return makeSignInWithEmailControllerWith(signInWithEmailUseCase: makeRemoteSignInFactory(),
                                             signInWithGoogleUseCase: makeRemoteSignUpWithGoogleFactory(),
                                             signInWithAppleUseCase: makeRemoteSignUpWithAppleFactory())
}

public func makeSignInWithEmailControllerWith(signInWithEmailUseCase: SignInWithEmailUseCase,
                                              signInWithGoogleUseCase: SignUpWithGoogleUseCase,
                                              signInWithAppleUseCase: SignUpWithAppleUseCase) -> SignInViewController {
    
    let controller = SignInViewController()
    
    let validationComposite = ValidationComposite(validations: makeSignInValidations())
    
    let presenter = SignInWithEmailPresenter(validation: validationComposite,
                                             alertView: WeakVarProxy(controller),
                                             signInWithEmailUseCase: signInWithEmailUseCase,
                                             loadingView: WeakVarProxy(controller),
                                             signInWithGoogleUseCase: signInWithGoogleUseCase,
                                             signInWithAppleUseCase: signInWithAppleUseCase)
    
    controller.signInWithEmail = presenter.signInWithEmail
    controller.signInWithGoogle = presenter.signInWithGoogleRequest
    controller.signInWithApple = presenter.signInWithAppleRequest
    
    return controller
}

public func makeSignInValidations() -> [Validation] {
    return ValidationBuilder
        .field("email")
        .label("Email")
        .required()
        .validateEmail()
        .build() +
        ValidationBuilder
        .field("password")
        .label("Senha")
        .required()
        .build()
}
