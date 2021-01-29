//
//  SavePetLocationView.swift
//  iOSUI
//
//  Created by Israel Ermel on 15/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

protocol SavePetLocationViewDelegate {
    func openMap()
    func openCamera(_ sender: UIButton)
    func openPhotoLibrary()
    func addPet()
}

class SavePetLocationView: UIView {
    
    var delegate: SavePetLocationViewDelegate?
    
    // MARK: - Components
    let fullnameTextField = RoundedTextField(placeholder: "Nome(apelido)")
    
    let fullAddressTextField : RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Endereço")
        textField.disableEdit()
        return textField
    }()
    
    let addLocalizationButton : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleOpenMapToSavePet), for: .touchUpInside)
        button.title = "Abrir Mapa"
        return button
    }()
    
    let addPhotoButton : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        button.title = "Adicionar Photo"
        return button
    }()
    
    let addPetButton : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(addPet), for: .touchUpInside)
        button.title = "Adicionar Pet"
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubviews()
    }
    
    //MARK: - Config Views
    func createSubviews() {
        configureFormFields()
    }
        
    private func configureFormFields() {

        let stack = UIStackView(arrangedSubviews: [
            fullnameTextField,
            fullAddressTextField,
            addLocalizationButton,
            addPhotoButton,
            addPetButton
        ])
        
        stack.axis = .vertical
        stack.spacing = 20
                
        self.addSubview(stack)
        stack.anchor(top: safeTopAnchor, left: safeLeftAnchor, right: safeRightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
                
    }
    
    @objc func handleOpenMapToSavePet() {
        delegate?.openMap()
    }
    
    @objc func handleAddPhoto(_ sender: UIButton) {
        delegate?.openCamera(sender)
    }
    
    @objc func addPet(_ sender: UIButton) {
        delegate?.addPet()
    }
    
    public func updateAddressText(address : String) {
        fullAddressTextField.enableEdit()
        fullAddressTextField.text = address
        fullAddressTextField.disableEdit()
    }
}
