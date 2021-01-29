//
//  TabBarCoordinator.swift
//  iOSUI
//
//  Created by Israel Ermel on 24/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI

enum TabBarPage {
    case map
    case AddPet
    case chat
    case registerPet
    case profile
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .map
        case 1:
            self = .AddPet
        case 2:
            self = .chat
        case 3:
            self = .registerPet
        case 4:
            self = .profile
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .map:
            return "Pets perto"
        case .AddPet:
            return "Cadastrar Pets"
        case .chat:
            return "Mensagens"
        case .registerPet:
            return "Cadastro"
        case .profile:
            return "Perfil"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .map:
            return 0
        case .AddPet:
            return 1
        case .chat:
            return 2
        case .registerPet:
            return 3
        case .profile:
            return 4
        }
    }
    
    func pageIcon() -> UIImage {
        switch self {
        case .map:
            return UIImage(named: "favorite")!
        case .AddPet:
            return UIImage(named: "search")!
        case .chat:
            return UIImage(named: "favorite")!
        case .registerPet:
            return UIImage(named: "favorite")!
        case .profile:
            return UIImage(named: "favorite")!
        }
    }
    
    // Add tab icon selected / deselected color
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}


public class TabBarCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var tabBarController: UITabBarController
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    public func start() {
        
        let pages: [TabBarPage] = [.map, .chat, .registerPet, .AddPet, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
                
        prepareTabBarController(withTabControllers: controllers)
        
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
    
        tabBarController.delegate = self
        /// Assign page's controllers
        tabBarController.setViewControllers(tabControllers, animated: true)
        /// Let set index
        tabBarController.selectedIndex = TabBarPage.map.pageOrderNumber()
        /// Styling
        tabBarController.tabBar.isTranslucent = false
        
        /// In this step, we attach tabBarController to navigation controller associated with this coordanator
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.pageIcon(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .map:
            let coordinator = PetsMapsCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .AddPet:
            if #available(iOS 11.0, *) {
                navController.navigationBar.prefersLargeTitles = true
            }
            let coordinator = IntroSavePetsCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .chat:
            let coordinator = ChatCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .registerPet:
            let coordinator = RegisterPetCoordinator(navigationController: navController)
            coordinator.start()
            childCoordinators.append(coordinator)
        case .profile:
            let coordinator = ProfileCoordinator(navigationController: navController)
            coordinator.coordinator = self
            coordinator.start()
            childCoordinators.append(coordinator)
        }
        
        return navController
        
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
}

extension TabBarCoordinator {
    func logout() {
        self.finish()
//        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarCoordinator: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
      //some implementation
    }
    
}
