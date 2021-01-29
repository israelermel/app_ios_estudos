//
//  TopHeroesViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 26/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import MapKit
import Presentation

public class SavePetLocationViewController: UIViewController {
    
    // MARK: - Properties
    var customView: SavePetLocationView?
    
    var savePetViewModel: SavePetViewModel?
    
    var imagePicker: ImagePicker!
    
    // MARK: - Coordinator
    public var didSendEventClosure: ((SavePetLocationViewController.Event) -> Void)?
    
    // MARK: - UseCase
    public var savePetLocationUseCase: ((SavePetViewModel) -> Void)?
    
    public var fullAddresss : String = "" {
        willSet(address) {
            self.customView?.updateAddressText(address: address)
        }
    }
    
    // MARK: - Lifecycle
        
    public override func loadView() {
        let customView = SavePetLocationView()
        customView.delegate = self
        view = customView
        
        self.customView = {
            return view as! SavePetLocationView
        }()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        largeTitleDisplayModeNever()
        configbackgroundScreen()
        hideKeyboardOnTapScreen()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.savePetViewModel = SavePetViewModel(id: UUID().uuidString)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideTabBarController()
    }        
    
    // MARK: - Handlers
    
    deinit {
        debugPrint("DEBUG: deallocated \(self)")
    }
    
    //TODO: israel removido
    public func updatePetCoordinate(_ petCoordinateViewModel: PetAddressLocationViewModel) {
        self.savePetViewModel?.updatePet(location: petCoordinateViewModel)
        self.customView?.updateAddressText(address: petCoordinateViewModel.addressDescription())
    }
    
    func savePetFromFields() {
        guard let fieldPetDescription = self.customView?.fullnameTextField.text else {
            return
        }
        
        self.savePetViewModel?.updatePet(description: fieldPetDescription)
        
        if var petViewModel = self.savePetViewModel {
            if (petViewModel.isValid()) {
                self.savePetLocationUseCase?(petViewModel)
            }
        }        
    }
    
}

extension SavePetLocationViewController {
    public enum Event {
        case toSavePetLocationMap
    }
}

//MARK: - SavePetLocationViewDelegate
extension SavePetLocationViewController: SavePetLocationViewDelegate {
    func addPet() {
        savePetFromFields()
    }
    
    
    func openMap() {
        didSendEventClosure?(.toSavePetLocationMap)
    }
    
    func openCamera(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func openPhotoLibrary() {
        
    }
}

//MARK: - ImagePickerDelegate
extension SavePetLocationViewController: ImagePickerDelegate {
    
    public func didSelect(image: UIImage?) {
        let base64 = image?.toBase64()
        
        self.savePetViewModel?.addPhoto(data: base64!)        
    }
}

extension SavePetLocationViewController: SaveLocalPetViewDelegate {
    
    public func saveLocalPetSucceeded() {
        print("teste")        
//        self.savePetLocationUseCase?(self.savePetViewModel!)
    }
    
    public func errorSavePet(error: String) {
        print("teste: \(error)")
    }
}
