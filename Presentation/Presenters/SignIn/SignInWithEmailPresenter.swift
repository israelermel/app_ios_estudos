//
//  SignInPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class SignInWithEmailPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let signInWithEmailUseCase: SignInWithEmailUseCase
    private let signInWithGoogleUseCase: SignUpWithGoogleUseCase
    private let signInWithAppleUseCase: SignUpWithAppleUseCase
    private let loadingView: LoadingView
    
    public init(validation: Validation,
                alertView: AlertView,
                signInWithEmailUseCase: SignInWithEmailUseCase,
                loadingView : LoadingView,
                signInWithGoogleUseCase: SignUpWithGoogleUseCase,
                signInWithAppleUseCase: SignUpWithAppleUseCase) {
        
        self.validation = validation
        self.alertView = alertView
        self.signInWithEmailUseCase = signInWithEmailUseCase
        self.loadingView = loadingView
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.signInWithAppleUseCase = signInWithAppleUseCase
    }
    
    public func signInWithAppleRequest(request: SignInAppleRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        
        signInWithAppleUseCase.signUpWithApple(request: request.toModel()) { [weak self] result in
            guard let self = self else { return }
            
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            
            switch result {
            case .success:
                self.alertView.showSuccess(viewModel: AlertViewModel(title: "Sucesso", message: "Login com a Apple efetuado com sucesso"))
                
            case .failure(let error):
                var errorMessage: String!
                
                switch error {
                case .alreadySignUp:
                    self.alertView.showSuccess(viewModel: AlertViewModel(title: "Sucesso", message: "Login com a Apple efetuado com sucesso"))
                    return
                default:
                    errorMessage = "Algo inesperado ocorreu por favor tente novamente"
                }
                
                self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                            
            }
        }
    }
    
    public func signInWithGoogleRequest(request: SignInGoogleRequest) {
        loadingView.display(viewModel: LoadingViewModel(isLoading: true))
        
        signInWithGoogleUseCase.signUpWithGoogle(request: request.toModel()) { [weak self] result in
                    
            guard let self = self else { return }
            
            self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
            
            switch result {
            case .success:
                self.alertView.showSuccess(viewModel: AlertViewModel(title: "Sucesso", message: "Login com o google efetuado com sucesso"))
                
            case .failure(let error):
                var errorMessage: String!
                
                switch error {
                case .alreadySignUp:
                    self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Login com o google efetuado com sucesso"))
                    return
                default:
                    errorMessage = "Algo inesperado ocorreu por favor tente novamente"
                }
                
                self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                            
            }
            
        }
    }
    
    public func signInWithEmail(viewModel: SignInRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showErrorMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            signInWithEmailUseCase.signInWithEmail(request: viewModel.toModel()) { [weak self] result in
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                case .success: self.alertView.showSuccess(viewModel:  AlertViewModel(title: "Sucesso", message: "Login efetuado com sucesso."))
                    
                case .failure(let error):
                    var errorMessage: String!
                    
                    switch error {
                    case .invalidEmail:
                        errorMessage = "Email é inválido"
                    case .operationNotAllowed:
                        errorMessage = "Email e/ou senha inválido(s)"
                    case .accountNotFound:
                        errorMessage = "Email e/ou senha inválido(s)"
                    case .userDisabled:
                        errorMessage = "Usuário desativado"
                    case .wrongPassword:
                        errorMessage = "Senha é inválida"
                    }
                    
                    self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                }
            }
        }
    }
    
}
