//
//  PetsLocationServiceClient.swift
//  Data
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol PetsLocationServiceClient {
    func retrieveAllPetsLocation(request: SearchPetsLocationViewModel, completion: @escaping (Result<[PetsLocationResponse], PestLocationDomainError>) -> Void)
}
