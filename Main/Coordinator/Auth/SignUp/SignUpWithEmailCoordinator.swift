//
//  SignUpWithEmailCoordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

public class SignUpWithEmailCoordinator: Coordinator {
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .login }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let signUpVC = makeSignUpWithEmailController()
        signUpVC.didSendEventClosure = { [weak self] event in
            switch event {
            case .toMain:
                self?.toMain()
            case .toSignIn:
                self?.dismissSignUp()
            }
        }
        
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    fileprivate func dismissSignUp() {
        navigationController.popViewController(animated: true)
    }
    
    fileprivate func toMain() {
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
}

