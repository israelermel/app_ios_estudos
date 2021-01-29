//
//  PasswordResetEmailView.swift
//  iOSUI
//
//  Created by Israel Ermel on 28/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

protocol PasswordResetEmailViewDelegate {
    func signIn()
    func sendPasswordReset(request: PasswordResetRequest)
}

class PasswordResetEmailView: UIView {
    
    var delegate: PasswordResetEmailViewDelegate?
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Handlers
    private let iconLogo = UIImageView(image: UIImage(named: "firebase-logo"))
    
    let loadingIndicator : UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .whiteLarge)
        loadingView.color = Color.primaryAction
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    private let backButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        button.setImage(UIImage(named: "left-back"), for: .normal)

        return button
    }()
    
    private let emailTextField = VNEmailTextField()
    
    private let passwordResetButton : VinButton = {
       let button = VinButton(type: .system)
       button.addTarget(self, action: #selector(handlePasswordResetWithEmail), for: .touchUpInside)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
       button.title = "Redefinir senha"
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
        configureLogo()
        configureFormFields()
        configureLoadingIndicator()
    }
    
    func configureLoadingIndicator() {
        let stack = UIStackView(arrangedSubviews: [loadingIndicator])
        stack.axis = .vertical
        
        self.addSubview(stack)
        stack.anchor(top: passwordResetButton.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
    }
    
    private func configureLogo() {
        self.addSubview(iconLogo)
        iconLogo.centerX(inView: self)
        iconLogo.setDimensions(height: 120, width: 120)
        iconLogo.anchor(top: self.safeTopAnchor, paddingTop: 32)
    }
    
    private func configureFormFields() {
        self.addSubview(backButton)
        backButton.anchor(top: self.safeTopAnchor, left: self.leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        // StackView Top
        let stackTop = UIStackView(arrangedSubviews: [emailTextField, passwordResetButton])
        stackTop.axis = .vertical
        stackTop.spacing = 16
        self.addSubview(stackTop)
        
        stackTop.anchor(top: iconLogo.bottomAnchor, left: self.leftAnchor,
                        right: self.rightAnchor, paddingTop: 32,
                        paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
    }
    
    // MARK: - Handlers
    
    @objc func handlePasswordResetWithEmail() {
        let request = PasswordResetRequest(email: self.emailTextField.text)
        delegate?.sendPasswordReset(request: request)
    }
    
    @objc func handleDismissal() {
        delegate?.signIn()
    }

}
