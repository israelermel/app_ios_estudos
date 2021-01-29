//
//  TopHeroesCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 25/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

class ProfileCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    
    weak var coordinator: TabBarCoordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = ProfileViewController()
        vc.didSendEventClosure = { [weak self] event in
            switch event {
            case .logout:
                self?.coordinator?.logout()
            }
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
}

