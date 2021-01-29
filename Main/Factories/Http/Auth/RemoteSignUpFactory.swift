//
//  RemoteSignUpFactory.swift
//  Main
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteSignUpFactory() -> SignUpWithEmailUseCase {
    return makeRemoteSignUpFactoryWith(service: makeSignUpServiceAdapter())
}

func makeRemoteSignUpFactoryWith(service: SignUpWithEmailServiceClient) -> SignUpWithEmailUseCase {
    let remote = RemoteSignUpWithEmailUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}
