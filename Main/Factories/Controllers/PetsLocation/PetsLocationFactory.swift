//
//  PetsLocationFactory.swift
//  Main
//
//  Created by Israel Ermel on 13/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import iOSUI
import Presentation
import UIKit

public func makePetsLocationController() -> PetsMapsViewController {
    return makePetsLocationControllerWith(useCase: makeRemotePestLocationFactory())
}

public func makePetsLocationControllerWith(useCase: PetsLocationUseCase) -> PetsMapsViewController {
    let controller = PetsMapsViewController()
    
    let presenter = PetsLocationPresenter(userCase: useCase,
                                          viewDelegate: WeakVarProxy(controller))
    
    controller.petsLocationUseCase = presenter.retrieveAllPestLocation
    
    return controller
}

