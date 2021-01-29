//
//  SavePetFactory.swift
//  Main
//
//  Created by Israel Ermel on 16/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import Presentation
import iOSUI

public func makeSavePetLocalPetController() -> SavePetLocationViewController {
    return makeSavePetLocalControllerWith(useCase: makeSaveLocalPetFactory())
}

public func makeSavePetLocalControllerWith(useCase: SavePetUseCase) -> SavePetLocationViewController {
    
    let controller = SavePetLocationViewController()
    
    let presenter = SaveLocalPetPresenter(useCase: useCase,
                                          viewDelegate: WeakVarProxy(controller))
        
    controller.savePetLocationUseCase = presenter.savePet

    return controller
}
