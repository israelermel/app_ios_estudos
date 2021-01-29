//
//  SaveLocalPetPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 14/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public protocol SaveLocalPetViewDelegate {
    func saveLocalPetSucceeded()
    func errorSavePet(error: String)
}

public final class SaveLocalPetPresenter {
    private let useCase: SavePetUseCase
    private let viewDelegate: SaveLocalPetViewDelegate
    
    public init(useCase: SavePetUseCase, viewDelegate: SaveLocalPetViewDelegate) {
        self.useCase = useCase
        self.viewDelegate = viewDelegate
    }
    
    public func savePet(request: SavePetViewModel) {
        
        useCase.savePet(request: request.toEntity()) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success: self.viewDelegate.saveLocalPetSucceeded()
            case .failure(let error): self.viewDelegate.errorSavePet(error: error.localizedDescription)
            }
            
        }
        
    }
}
