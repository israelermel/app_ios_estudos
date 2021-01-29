//
//  RemotePasswordResetWithEmailFactory.swift
//  Main
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemotePasswordResetWithEmailFactory() -> PasswordResetWithEmailUseCase {
    return makeRemotePasswordResetWithEmailFactoryWith(service: makePasswordResetWithEmailServiceAdapter())
}

func makeRemotePasswordResetWithEmailFactoryWith(service: PasswordResetWithEmailServiceClient) -> PasswordResetWithEmailUseCase {
    
    let remote = RemotePasswordResetWithEmailUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}

