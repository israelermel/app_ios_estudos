//
//  PetsLocationFactory.swift
//  Main
//
//  Created by Israel Ermel on 13/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemotePestLocationFactory() -> PetsLocationUseCase {
    return makeRemotePestLocationFactoryWith(service: makePetsLocationServiceAdapter())
}

func makeRemotePestLocationFactoryWith(service: PetsLocationServiceClient) -> PetsLocationUseCase {
    let remote = RemotePetsLocationUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}
