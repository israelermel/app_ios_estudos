//
//  SavePetLocationVoidResult.swift
//  Domain
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public enum SavePetLocationVoidResult {
    case success
    case failure(SavePetLocationDomainError)
}
