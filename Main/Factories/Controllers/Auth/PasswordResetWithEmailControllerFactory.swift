//
//  PasswordResetWithEmailControllerFactory.swift
//  Main
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation
import Domain
import iOSUI
import Validation

public func makePasswordResetWithEmailController() -> PasswordResetWithEmailViewController {
    return makePasswordResetWithEmailControllerWith(passwordResetUsecase: makeRemotePasswordResetWithEmailFactory())
}

public func makePasswordResetWithEmailControllerWith(passwordResetUsecase: PasswordResetWithEmailUseCase) -> PasswordResetWithEmailViewController {
    
    let controller = PasswordResetWithEmailViewController()
    
    let validationComposite = ValidationComposite(validations: makePasswordResetWithEmailValidations())
    
    let presenter = PasswordResetWithEmailPresenter(validation: validationComposite, alertView: WeakVarProxy(controller), useCase: passwordResetUsecase, loadingView: WeakVarProxy(controller))
    
    controller.passwordResetUseCase = presenter.passwordReset
    
    return controller
    
}

public func makePasswordResetWithEmailValidations() -> [Validation] {
    return ValidationBuilder.field("email").label("Email").required().validateEmail().build()
}
