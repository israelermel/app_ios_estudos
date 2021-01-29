//
//  SignInServiceAdapterFactory.swift
//  Main
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Infra

func makeSignInServiceAdapter() -> SignInWithEmailServiceAdapter {
    return SignInWithEmailServiceAdapter()
}
