//
//  SaveLocalPetCoordinatePresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SaveLocalPetCoordinateDelegate {
    func savePetCoordinateSucceeded()
    func errorPetCoordinate(error: String)
}

public final class SaveLocalPetCoordinatePresenter {
    private let useCase: PetCoordinateUseCase
    private let viewDelegate: SaveLocalPetCoordinateDelegate
    
    public init(useCase: PetCoordinateUseCase, viewDelegate: SaveLocalPetCoordinateDelegate) {
        self.useCase = useCase
        self.viewDelegate = viewDelegate
    }
    
    public func savePetCoordinate(request: PetAddressLocationViewModel) {
        
        useCase.savePetCoordinate(request: request.toEntity()) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success: self.viewDelegate.savePetCoordinateSucceeded()
            case .failure(let error): self.viewDelegate.errorPetCoordinate(error: error.localizedDescription)
            }
            
        }
        
    }
}
