//
//  Coordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
// https://medium.com/@dkw5877/flow-coordinators-333ed64f3dd

public protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

public protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
}

public extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for(index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

public enum CoordinatorType {
    case app, login, tab, loading
}
