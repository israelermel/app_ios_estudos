//
//  SignUpWithEmailPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class SignUpWithEmailPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let useCase: SignUpWithEmailUseCase
    private let loadingView: LoadingView
    
    public init(validation: Validation, alertView: AlertView, useCase: SignUpWithEmailUseCase, loadingView: LoadingView) {
        self.validation = validation
        self.alertView = alertView
        self.useCase = useCase
        self.loadingView = loadingView
    }
    
    
    public func signUpWithEmail(request: SignUpRequest) {
        if let message = validation.validate(data: request.toJson()) {
            alertView.showErrorMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            useCase.signUpWithEmail(request: request.toModel()) { [weak self] result in
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                case .success: self.alertView.showSuccess(viewModel: AlertViewModel(title: "Sucesso", message: "Cadastro efetuado com sucesso"))
                    
                case .failure(let error):
                    var errorMessage: String!
                    
                    switch error {
                    case .emailAlreadyInUse:
                        errorMessage = "Email já associado a outra conta"
                    case .invalidEmail:
                        errorMessage = "Email é inválido"
                    case .unexpected:
                        errorMessage = "Algo inesperado acontenceu. por favor tente novamente"
                    case .weakPassword:
                        errorMessage = "Escolha uma senha complexa"
                    default:
                        errorMessage = "Algo inesperado acontenceu. por favor tente novamente"
                    }
                
                    
                 self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                }
            }
        }
    }
}
