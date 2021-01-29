//
//  SavePetLocationMapCoordinator.swift
//  Main
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import iOSUI
import Presentation

public class SavePetLocationMapCoordinator: Coordinator {
    
    public var navigationController: UINavigationController
    weak public var finishDelegate: CoordinatorFinishDelegate?
    public var childCoordinators: [Coordinator] = []
    public var type: CoordinatorType { .tab }
    
    weak var parentCoordinator: SavePetsCoordinator?
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let vc = makeSavePetLocationController()
        vc.navigationItem.title = "Local do Pet"        
        
        vc.didSendEventClosure = {[weak self] event in
            switch event {
            case .toSavePet(let petCoordinate):
                self?.savePetLocation(petCoordinate: petCoordinate)
                break
            case .dismiss:
                self?.didFinish()
                break
            }
        }
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinish() {        
        parentCoordinator?.childDidFinish(self)
        navigationController.popViewController(animated: true)
    }
    
    func savePetLocation(petCoordinate: PetAddressLocationViewModel) {
        parentCoordinator?.savePetLocation(petCoordinateViewModel: petCoordinate)// todo israel remover usado ao salvar pet location
        didFinish()
    }
    
    func savePetLocation() {
        didFinish()
    }
        
}
