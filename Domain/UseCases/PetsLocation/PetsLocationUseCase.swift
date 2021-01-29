//
//  PetsLocationUseCase.swift
//  Domain
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol PetsLocationUseCase {
    typealias Result = Swift.Result<[PetsLocationResponse], PestLocationDomainError>
    func retrieveAllPetsLocation(request: SearchPetsLocationViewModel, completion: @escaping(Result) -> Void)
}
