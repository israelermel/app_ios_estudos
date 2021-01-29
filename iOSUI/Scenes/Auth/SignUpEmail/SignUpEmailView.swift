//
//  SignUpEmailView.swift
//  iOSUI
//
//  Created by Israel Ermel on 28/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

protocol SignUpEmailViewDelegate {
    func signUpWithEmailEvent(request: SignUpRequest)
    func signIn()
}

class SignUpEmailView: UIView {
        
    var delegate: SignUpEmailViewDelegate?
    
    let iconLogo = UIImageView(image: UIImage(named: "firebase-logo"))
    
    let fullnameTextField = RoundedTextField(placeholder: "Nome completo")
    
    let emailTextField = RoundedTextField(placeholder: "E-mail")
    
    let passwordTextField : VNPasswordTextField = {
        let tf = VNPasswordTextField(placeholder: "Senha")
        return tf
    }()
    
    let passwordConfirmationTextField : VNPasswordTextField = {
        let tf = VNPasswordTextField(placeholder: "Confirma senha")
        return tf
    }()
    
    let loadingIndicator : UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .whiteLarge)
        loadingView.color = Color.primaryAction
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    let signUpButton : VinButton = {
       let button = VinButton(type: .system)
       button.addTarget(self, action: #selector(handleSignUpWithEmail), for: .touchUpInside)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
       button.title = "Cadastrar"
       return button
    }()
    
    let alreadyHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        
        let atts : [NSAttributedString.Key: Any] = [.foregroundColor : Color.primaryTextLight,
                                                    .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Já tem uma conta? ",
                                                        attributes: atts)
        
        let boldAtts : [NSAttributedString.Key: Any] = [.foregroundColor : Color.primaryTextDark,
                                                        .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: "Entrar", attributes: boldAtts))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showSignInController), for: .touchUpInside)
        
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
        configureFields()
        configureLoadingIndicator()
    }
    
    func configureLoadingIndicator() {
        let stack = UIStackView(arrangedSubviews: [loadingIndicator])
        stack.axis = .vertical
        
        self.addSubview(stack)
        stack.anchor(top: signUpButton.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
    }
    
    func configureFields() {
        let stack = UIStackView(arrangedSubviews: [fullnameTextField,
                                                   emailTextField,
                                                   passwordTextField,
                                                   passwordConfirmationTextField,
                                                   signUpButton,
                                                   alreadyHaveAccountButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        self.addSubview(stack)
        stack.anchor(top: iconLogo.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
        
    }
    
    func configureLogo() {
        self.addSubview(iconLogo)
        iconLogo.centerX(inView: self)
        iconLogo.setDimensions(height: 120, width: 120)
        iconLogo.anchor(top: self.safeTopAnchor, paddingTop: 32)
    }
    
    
    //MARK: - Handlers
    @objc func handleSignUpWithEmail() {
        let request = SignUpRequest(fullname: self.fullnameTextField.text,
                                    email: self.emailTextField.text,
                                    password: self.passwordTextField.text,
                                    passwordConfirmation: self.passwordConfirmationTextField.text)
        
        delegate?.signUpWithEmailEvent(request: request)
    }
    
    @objc func showSignInController() {
        delegate?.signIn()
    }
}

