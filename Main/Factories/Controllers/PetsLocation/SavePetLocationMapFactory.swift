//
//  SavePetLocationMapFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import iOSUI
import Presentation

public func makeSavePetLocationController() -> SavePetLocationMapViewController {
    return makeSaveLocalCoordinateControllerWith(useCase: makeLocalPetCoordinateFactory())
}

public func makeSaveLocalCoordinateControllerWith(useCase: PetCoordinateUseCase) -> SavePetLocationMapViewController {
    
    let controller = SavePetLocationMapViewController()

    return controller
}
