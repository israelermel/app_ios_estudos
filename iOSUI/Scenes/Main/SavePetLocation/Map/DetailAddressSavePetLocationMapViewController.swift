//
//  DetailAddressSavePetLocationMapViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 27/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

protocol DetailAddressBottomSheetDelegate: class {
    func saveAddress(petAddressLocationView: PetAddressLocationViewModel?)
    func closeAction()
}

class DetailAddressSavePetLocationMapViewController: UIViewController {

    var customView: DetailAddressBottomSheetView?
    var delegate: DetailAddressBottomSheetDelegate?
    var petAddressLocationView: PetAddressLocationViewModel?
    
    public override func loadView() {
        let customView = DetailAddressBottomSheetView()
        customView.delegate = self
        view = customView
        
        self.customView = {
            return view as! DetailAddressBottomSheetView
        }()
    }
    
    public func updateAddress(_ petAddressLocationView: PetAddressLocationViewModel) {
        customView?.enableSaveButton()
        self.petAddressLocationView = petAddressLocationView
        customView?.updateAddressLabel(petAddressLocationView.fullAddress())
    }
    
    public func altitudeBiggerThanAllowed() {
        stopLoadingState()
        customView?.disableSaveButton()
        customView?.warningMessage()
    }
          
    public func getSelectedLocation() -> PetAddressLocationViewModel? {
        return petAddressLocationView
    }
    
    public func startLoadingState() {
        customView?.startLoadingIndicator()
    }
    
    public func stopLoadingState() {
        customView?.stopLoadingIndicator()
    }
    
    
}

extension DetailAddressSavePetLocationMapViewController: DetailAddressBottomSheetDelegateView {
    func saveAddress() {        
        delegate?.saveAddress(petAddressLocationView: self.getSelectedLocation())
    }
    
    func closeAction() {
        delegate?.closeAction()
    }
}
