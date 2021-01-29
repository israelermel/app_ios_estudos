//
//  SavePetUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 14/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation

public protocol SavePetUseCase {
    func savePet(request: SavePetEntity, completion: @escaping(SavePetVoidResult) -> Void)
}
