//
//  DetailAddressBottomSheet.swift
//  iOSUI
//
//  Created by Israel Ermel on 28/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

protocol DetailAddressBottomSheetDelegateView: class {
    func saveAddress()
    func closeAction()
}

public class DetailAddressBottomSheetView: UIView {
    
    var delegate: DetailAddressBottomSheetDelegateView?
    
    let loadingIndicator : UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .whiteLarge)
        loadingView.color = Color.primaryAction
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    public let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .white
        return v
    }()
    
    let btnSave : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.title = "Adicionar Endereço"
        button.setHeight(height: 44)
        button.addTarget(self, action: #selector(saveAddressAction), for: .touchUpInside)
        
        return button
    }()
    
    let addressLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        return lb
    }()
    
    private let closeButton: UIButton = {
        let bt = UIButton()
        bt.setHeight(height: 24)
        bt.setWidth(width: 24)
        bt.setImage(UIImage(named: "ic_close"), for: .normal)
        bt.addTarget(self, action: #selector(handleCloseAction), for: .touchUpInside)
        
        return bt
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
        
        addSubview(scrollView)
        scrollView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let stackTop = UIStackView(arrangedSubviews: [closeButton])
        stackTop.axis = .vertical

        scrollView.addSubview(stackTop)
        stackTop.anchor(top: safeTopAnchor, right: safeRightAnchor,
                        paddingTop: 16, paddingRight: 16)
        
        let stack = UIStackView(arrangedSubviews: [addressLabel, btnSave])
        stack.axis = .vertical
        stack.spacing = 8
        
        scrollView.addSubview(stack)
        stack.anchor(top: stackTop.bottomAnchor, left: leftAnchor, bottom: safeBottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 8, paddingRight: 32)
        
        scrollView.addSubview(loadingIndicator)
        loadingIndicator.centerX(inView: scrollView)
        loadingIndicator.anchor(top: addressLabel.topAnchor, paddingTop: 0)
    }
    
    @objc
    func handleCloseAction() {
        delegate?.closeAction()
    }
    
    @objc
    func saveAddressAction() {
        delegate?.saveAddress()
    }
    
    func updateAddressLabel(_ address: String) {
        addressLabel.text = address
    }
    
    func enableSaveButton() {
        btnSave.enabled()
    }
    
    func disableSaveButton() {
        btnSave.disabled()
    }
    
    func startLoadingIndicator() {
        addressLabel.alpha = 0.0
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingIndicator() {
        addressLabel.alpha = 1.0
        loadingIndicator.stopAnimating()
    }
    
    
    func warningMessage() {
        addressLabel.text = "aproxime mais o zoom para conseguirmos pegar o nome da rua"
    }
}
