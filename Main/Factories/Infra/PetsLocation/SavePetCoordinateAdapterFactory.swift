//
//  SavePetCoordinateAdapterFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Infra

func makePetCoordinateDataSourceAdapter() -> PetCoordinateDataSourceAdapter {
    return PetCoordinateDataSourceAdapter()
}

func makeRemoteSavePetServiceAdapter() -> SavePetLocationServiceAdapter {
    return SavePetLocationServiceAdapter()
}


