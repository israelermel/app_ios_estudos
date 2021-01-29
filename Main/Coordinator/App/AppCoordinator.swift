//
//  AppCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
    func showLoadingApp()
}

public class AppCoordinator: AppCoordinatorProtocol {
    
    var isLoggedIn: Bool = false
    
    weak public var finishDelegate: CoordinatorFinishDelegate? = nil
    
    public var navigationController: UINavigationController
    
    public var childCoordinators = [Coordinator]()
        
    public var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    public func start() {                                
        showLoadingApp()
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
    func showLoadingApp() {
        let coordinator = LoadingAppCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    func showLoginFlow() {
        let loginCoordinator = SignInCoordinator(navigationController: navigationController)
        loginCoordinator.finishDelegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showMainFlow() {        
        let tabCoordinator = TabBarCoordinator(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}


extension AppCoordinator: CoordinatorFinishDelegate {
   public func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()

            showLoginFlow()
        case .login:
            navigationController.viewControllers.removeAll()

            showMainFlow()
        default:            
            break
        }
    }
}

extension AppCoordinator: LoadingAppDelegate {
    public func loadingAppToLogin() {
        showLoginFlow()
    }
    
    public func loadingAppToMain() {
        showMainFlow()
    }
}
