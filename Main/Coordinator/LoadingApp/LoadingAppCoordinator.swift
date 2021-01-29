//
//  LoadingAppCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

public protocol LoadingAppDelegate {
    func loadingAppToMain()
    func loadingAppToLogin()
}

public class LoadingAppCoordinator: Coordinator {
 
    public var navigationController: UINavigationController
    public var delegate: LoadingAppDelegate?
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .loading }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = LoadingAppViewController()
        vc.didSendEventClosure = {[weak self] event in
            switch event {
            case .toMain:
                self?.toMain()
                break
            case .toSignIn:
                self?.toSignIn()
                break
            }
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func toMain() {
        self.delegate?.loadingAppToMain()
    }
    
    fileprivate func toSignIn() {
        self.delegate?.loadingAppToLogin()
    }
}
