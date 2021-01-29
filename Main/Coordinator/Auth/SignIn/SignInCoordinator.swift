//
//  SignInCoordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

public class SignInCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .login }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let signInVC = makeSignInWithEmailController()          
        signInVC.didSendEventClosure = { [weak self] event in
            switch event {
            case .main:
                self?.toMain()
            case .passwordReset:
                self?.coordinateToPasswordReset()
            case .signUp:
                self?.coordinateToSignUpWithEmail()
            }            
        }
        
        navigationController.pushViewController(signInVC, animated: true)
    }
    
    // MARK: - Flow Methods
    
    fileprivate func coordinateToPasswordReset() {
        let coordinator = PasswordResetCoordinator(navigationController: navigationController)
        coordinator.finishDelegate = finishDelegate
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    fileprivate func coordinateToSignUpWithEmail() {
        let coordinator = SignUpWithEmailCoordinator(navigationController: navigationController)
        coordinator.finishDelegate = finishDelegate
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    fileprivate func toMain() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }

}

