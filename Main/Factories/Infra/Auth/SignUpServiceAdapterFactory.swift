//
//  SignUpServiceAdapterFactory.swift
//  Main
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Infra

func makeSignUpServiceAdapter() -> SignUpWithEmailServiceAdapter {
    return SignUpWithEmailServiceAdapter()
}
