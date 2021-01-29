//
//  RemoteSignUpWithGoogleFactory.swift
//  Main
//
//  Created by Israel Ermel on 13/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteSignUpWithGoogleFactory() -> SignUpWithGoogleUseCase {
    return makeRemoteSignUpWithGoogleFactoryWith(service: makeSignUpWithGoogleServiceAdapter())
}

func makeRemoteSignUpWithGoogleFactoryWith(service: SignUpWithGoogleServiceClient) -> SignUpWithGoogleUseCase {
    let remote = RemoteSignUpWithGoogleUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}

