//
//  PetsMapsCoordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 25/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

class PetsMapsCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    
    private var petsMapsVC: PetsMapsViewController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.petsMapsVC = makePetsLocationController()
    }
    
    public func start() {
        
        petsMapsVC.didSendEventClosure = { [weak self] event in
            switch event {
            case .dismiss:
                self?.finish()
            }
        }
        navigationController.pushViewController(self.petsMapsVC, animated: true)
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
}


