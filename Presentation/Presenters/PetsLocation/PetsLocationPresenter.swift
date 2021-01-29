//
//  PetsLocationPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol PetsLocationViewDelegate {
    func retrieveAllPetsLocationSucceed(petsLocation: [PetsLocationViewModel])
}

public final class PetsLocationPresenter {
    private let useCase: PetsLocationUseCase
    private let viewDelegate: PetsLocationViewDelegate
    
    public init(userCase: PetsLocationUseCase, viewDelegate: PetsLocationViewDelegate) {
        self.useCase = userCase
        self.viewDelegate = viewDelegate
    }
    
    public func retrieveAllPestLocation(request: PetsLocationRequest) {
        
        useCase.retrieveAllPetsLocation(request: request.toModel()) { [weak self] result in
            
            guard let self = self else { return }
                      
            switch result {
            case .success(let data) :
                let mapped = data.map { response -> PetsLocationViewModel in
                    return PetsLocationViewModel(petsLocationResponse: response)
                }
                
                self.viewDelegate.retrieveAllPetsLocationSucceed(petsLocation: mapped)
            case .failure: break
            }
                        
        }
        
    }
}
