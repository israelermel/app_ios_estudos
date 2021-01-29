//
//  SignInView.swift
//  iOSUI
//
//  Created by Israel Ermel on 28/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

protocol SignInViewDelegate {
    func signInEvent(request: SignInRequest)
    func signInGoogleEvent()
    func appleSignInEvent()
    func registrationEvent()
    func forgotPasswordEvent()
}

class SignInView: UIView {
        
    var delegate: SignInViewDelegate?
        
    // MARK: - Components
    private let iconLogo = UIImageView(image: UIImage(named: "firebase-logo"))
    
    private let emailTextField = VNEmailTextField()
    
    private let passwordTextField : VNPasswordTextField = {
        let tf = VNPasswordTextField(placeholder: "Senha")
        return tf
    }()
    
    let loadingIndicator : UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView(style: .whiteLarge)
        loadingView.color = Color.primaryAction
        loadingView.hidesWhenStopped = true
        return loadingView
    }()
    
    private let signInButton : VinButton = {
       let button = VinButton(type: .system)
       button.addTarget(self, action: #selector(handleSignWitEmail), for: .touchUpInside)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
       button.title = "Entrar"
       return button
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        
        let atts : [NSAttributedString.Key: Any] = [.foregroundColor : Color.primaryTextLight,
                                                    .font: UIFont.systemFont(ofSize: 15)]
        let attributedTitle = NSMutableAttributedString(string: "Esqueceu sua senha? ",
                                                        attributes: atts)
        
        let boldAtts : [NSAttributedString.Key: Any] = [.foregroundColor :  Color.primaryTextDark,
                                                        .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "Acesse aqui para ajuda", attributes: boldAtts))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let dividerView = VNDivider()

    private let googleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btn-google-logo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("  Continuar com o Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0, green: 0.4797514677, blue: 0.9984372258, alpha: 1)
        button.setHeight(height: 44)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        return button
    }()
    
    private let appleSignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "btn-apple-logo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("  Continuar com a Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.setHeight(height: 44)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        return button
    }()
    
    private let dontHaveAccountButton : UIButton = {
        let button = UIButton(type: .system)
        
        let atts : [NSAttributedString.Key: Any] = [.foregroundColor : Color.primaryTextLight,
                                                    .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Não tem conta? ",
                                                        attributes: atts)
        
        let boldAtts : [NSAttributedString.Key: Any] = [.foregroundColor : Color.primaryTextDark,
                                                        .font: UIFont.boldSystemFont(ofSize: 16)]
        attributedTitle.append(NSAttributedString(string: "Cadastre-se", attributes: boldAtts))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showRegistrationController), for: .touchUpInside)
        
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
        configureLoadingIndicator()
        configureLogo()
        configureFields()
    }
    
    func configureLoadingIndicator() {
        self.addSubview(loadingIndicator)
        loadingIndicator.centerX(inView: self)
        loadingIndicator.centerY(inView: self)
    }

    func configureLogo() {
        self.addSubview(iconLogo)
        iconLogo.centerX(inView: self)
        iconLogo.setDimensions(height: 120, width: 120)
        iconLogo.anchor(top: self.safeTopAnchor, paddingTop: 32)
    }
    
    func configureFields() {
        let stackTop = UIStackView(arrangedSubviews: [emailTextField,
                                                   passwordTextField,
                                                   signInButton])
        stackTop.axis = .vertical
        stackTop.spacing = 20
        
        self.addSubview(stackTop)
        stackTop.anchor(top: iconLogo.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
        
        var aButtons = [forgotPasswordButton,
                        dividerView,
                        googleSignInButton]
        
        
        if #available(iOS 13.0, *) {
            appleSignInButton.addTarget(self, action: #selector(handleAppleSignIn), for: .touchUpInside)
            aButtons.append(appleSignInButton)
        }
        
        let stackBottom = UIStackView(arrangedSubviews: aButtons)
        stackBottom.axis = .vertical
        stackBottom.spacing = 28
        
        self.addSubview(stackBottom)
        stackBottom.anchor(top: stackTop.bottomAnchor, left: self.leftAnchor,
                           right: self.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingBottom: 32, paddingRight: 32)
        
        
        // Other SubViews
        self.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: self)
        dontHaveAccountButton.anchor(bottom: self.safeBottomAnchor)
        
    }
    
    //MARK: - Handlers
    @objc func handleSignWitEmail() {
        let request = SignInRequest(email: self.emailTextField.text, password: self.passwordTextField.text)
        
        delegate?.signInEvent(request: request)
    }
    
    @objc func handleGoogleSignIn() {
        delegate?.signInGoogleEvent()
    }
        
    @available(iOS 13, *)
    @objc func handleAppleSignIn() {
        delegate?.appleSignInEvent()
    }
    
    @objc func showRegistrationController() {
        delegate?.registrationEvent()
    }
    
    @objc func showForgotPassword() {
        delegate?.forgotPasswordEvent()
    }
}
