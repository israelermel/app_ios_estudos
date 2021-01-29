//
//  RemoteSignInFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteSignInFactory() -> SignInWithEmailUseCase {
    return makeRemoteSignInFactoryWith(service: makeSignInServiceAdapter())
}

func makeRemoteSignInFactoryWith(service: SignInWithEmailServiceClient) -> SignInWithEmailUseCase {
    let remote = RemoteSignInWithEmailUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}
