//
//  NavigationController.swift
//  iOSUI
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    
    private var currentViewController: UIViewController?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    private func setup() {
//        navigationBar.barTintColor = Color.primaryDark
//        navigationBar.tintColor = UIColor.white
//        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navigationBar.isTranslucent = false
//        navigationBar.barStyle = .black
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }

    
    public func pushViewController(_ viewController: UIViewController) {        
        pushViewController(viewController, animated: true)
        currentViewController = viewController
        hideBackButtonText()    
    }

    public func hideBackButtonText() {
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}
