//
//  WeakVarProxy.swift
//  iOSUI
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Presentation
import Domain

final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showErrorMessage(viewModel: AlertViewModel) {
        self.instance?.showErrorMessage(viewModel: viewModel)
    }
    func showSuccess(viewModel: AlertViewModel) {
        self.instance?.showSuccess(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        self.instance?.display(viewModel: viewModel)
    }
}

extension WeakVarProxy: PetsLocationViewDelegate where T: PetsLocationViewDelegate {
    func retrieveAllPetsLocationSucceed(petsLocation: [PetsLocationViewModel]) {
        self.instance?.retrieveAllPetsLocationSucceed(petsLocation: petsLocation)
    }
}

extension WeakVarProxy: SaveLocalPetCoordinateDelegate where T: SaveLocalPetCoordinateDelegate {
    func savePetCoordinateSucceeded() {
        self.instance?.savePetCoordinateSucceeded()
    }
    
    func errorPetCoordinate(error: String) {
        self.instance?.errorPetCoordinate(error: error)
    }
}

extension WeakVarProxy: SaveLocalPetViewDelegate where T: SaveLocalPetViewDelegate {
    func saveLocalPetSucceeded() {
        self.instance?.saveLocalPetSucceeded()
    }
    
    func errorSavePet(error: String) {
        self.instance?.errorSavePet(error: error)
    }
}
