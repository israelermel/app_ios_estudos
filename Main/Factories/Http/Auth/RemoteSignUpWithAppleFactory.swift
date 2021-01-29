//
//  RemoteSignUpWithAppleFactory.swift
//  Main
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Data
import Domain

func makeRemoteSignUpWithAppleFactory() -> SignUpWithAppleUseCase {
    return makeRemoteSignUpWithAppleFactoryWith(service: makeSignUpWithAppleServiceAdapter())
}

func makeRemoteSignUpWithAppleFactoryWith(service: SignUpWithAppleServiceClient) -> SignUpWithAppleUseCase {
    let remote = RemoteSignUpWithAppleUseCase(service: service)
    return MainDispatchQueueDecorator(remote)
}
