//
//  TopHeroesCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 25/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

class IntroSavePetsCoordinator: Coordinator {
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = IntroSavePetsViewController()
        vc.navigationItem.title = "Escolha"
        
        vc.didSendEventClosure = {[weak self] event in
            switch event {
            case .toSavePetOnStreet:
                self?.coordinateToSavePetOnStreet()
            case .toSaveLost:
                self?.coordinateToSavePetLost()
            }
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func coordinateToSavePetOnStreet() {
        let coordinator = SavePetsCoordinator(navigationController: navigationController)
        coordinator.finishDelegate = finishDelegate
        coordinator.parentCoordinator = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    fileprivate func coordinateToSavePetLost() {
        print("teste")
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
}

extension IntroSavePetsCoordinator {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
