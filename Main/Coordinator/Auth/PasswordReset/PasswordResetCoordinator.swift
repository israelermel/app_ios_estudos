//
//  PasswordResetCoordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

public class PasswordResetCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .login }
    
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let passwordResetVC = makePasswordResetWithEmailController()
        passwordResetVC.didSendEventClosure = { [weak self] event in
            switch event {            
            case .toSignIn:
                self?.dismissPasswordReset()
            }
        }
             
        navigationController.pushViewController(passwordResetVC, animated: true)
        
    }
    
    fileprivate func dismissPasswordReset() {
        navigationController.popViewController(animated: true)
    }
}
