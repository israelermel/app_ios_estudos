//
//  SavePetsCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI
import Presentation

class SavePetsCoordinator: Coordinator {
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    weak var parentCoordinator: IntroSavePetsCoordinator?
    
    private var savePetLocationVC: SavePetLocationViewController?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = makeSavePetLocalPetController()
        vc.navigationItem.title = "Salvar Pet"
        
        self.savePetLocationVC = vc
        
        vc.didSendEventClosure = {[weak self] event in
            switch event {
            case .toSavePetLocationMap:
                self?.coordinateToSavePetLocationMap()
            default:
                break
            }
            
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    fileprivate func coordinateToSavePetLocationMap() {
        let coordinator = SavePetLocationMapCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.finishDelegate = finishDelegate
        coordinator.start()
        childCoordinators.append(coordinator)
    }
    
    fileprivate func updatePetLocation(petCoordinateViewModel: PetAddressLocationViewModel) {        
        self.savePetLocationVC?.fullAddresss = petCoordinateViewModel.fullAddress()
        self.savePetLocationVC?.updatePetCoordinate(petCoordinateViewModel)
    }
    
}

extension SavePetsCoordinator {
    func savePetLocation(petCoordinateViewModel: PetAddressLocationViewModel) {
        updatePetLocation(petCoordinateViewModel: petCoordinateViewModel)
    }
    
    func dismiss() {
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
        
}
