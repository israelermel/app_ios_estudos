//
//  Utils+Optional.swift
//  iOSUI
//
//  Created by Israel Ermel on 18/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

}


extension Optional where Wrapped: Collection {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

}
