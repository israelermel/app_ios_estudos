//
//  SavePetLocationPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SavePetLocationViewDelegate {
    func savePetLocationSucceeded()
    func errorPetLocationSucceeded(error: SavePetLocationDomainError)
}

public final class SavePetLocationPresenter {
    private let useCase: RemoteSavePetUseCase
    private let viewDelegate: SavePetLocationViewDelegate
    
    public init(useCase: RemoteSavePetUseCase, viewDelegate: SavePetLocationViewDelegate) {
        self.useCase = useCase
        self.viewDelegate = viewDelegate
    }
    
    public func savePetLocation(request: SavePetViewModel) {
        
        useCase.savePetLocation(request: request.toEntity()) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success: self.viewDelegate.savePetLocationSucceeded()
            case .failure(let error): self.viewDelegate.errorPetLocationSucceeded(error: error)
            }
            
        }
    }
}
