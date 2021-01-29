//
//  SavePetLocationUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol RemoteSavePetUseCase {
    func savePetLocation(request: SavePetEntity, completion: @escaping(SavePetLocationVoidResult) -> Void)
}
