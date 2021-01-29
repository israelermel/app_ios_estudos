//
//  LocalPetCoordinateFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeLocalPetCoordinateFactory() -> PetCoordinateUseCase {
    return makeLocalPetCoordinateFactoryWith(service: makePetCoordinateDataSourceAdapter())
}

func makeLocalPetCoordinateFactoryWith(service: PetCoordinateServiceClient) -> PetCoordinateUseCase {
    let remote = LocalPetCoordinateUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}

func makeSaveLocalPetFactory() -> SavePetUseCase {
    return makeSaveLocalPetFactoryWith(service: makePetCoordinateDataSourceAdapter())
}

func makeSaveLocalPetFactoryWith(service: PetCoordinateServiceClient) -> SavePetUseCase {
    let remote = LocalSavePetUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}


// Envia para firebase os dados do Pet
func makeRemoteSavePetUseCaseFactory()  -> RemoteSavePetUseCase {
    return makeRemoteSavePetUseCaseFactoryWith(service: makeRemoteSavePetServiceAdapter())
}

func makeRemoteSavePetUseCaseFactoryWith(service: SavePetLocationServiceClient) -> RemoteSavePetUseCase {
    let remote = RemoteSavePetLocationUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}
