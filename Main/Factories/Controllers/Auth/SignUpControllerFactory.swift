//
//  SignUpControllerFactory.swift
//  Main
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation
import Domain
import iOSUI
import Validation

public func makeSignUpWithEmailController() -> SignUpWithEmailViewController {
    return makeSignUpWithEmailControllerWith(signUpUseCase: makeRemoteSignUpFactory())
}

public func makeSignUpWithEmailControllerWith(signUpUseCase: SignUpWithEmailUseCase) -> SignUpWithEmailViewController {
    
    let controller = SignUpWithEmailViewController()
    
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    
    let presenter = SignUpWithEmailPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), useCase: signUpUseCase, loadingView: WeakVarProxy(controller))
    
    controller.singUpUseCase = presenter.signUpWithEmail
    
    return controller
}

public func makeSignUpValidations() -> [Validation] {
    return ValidationBuilder.field("fullname").label("Nome Completo").required().build() +
        ValidationBuilder.field("email").label("Email").required().validateEmail().build() +
        ValidationBuilder.field("password").label("Senha").required().build() +
        ValidationBuilder.field("passwordConfirmation").label("Confirma Senha").sameAs("password").build()
}
