//
//  PasswordResetWithEmailPresenter.swift
//  Presentation
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class PasswordResetWithEmailPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let useCase: PasswordResetWithEmailUseCase
    private let loadingView: LoadingView
    
    public init(validation: Validation, alertView: AlertView, useCase: PasswordResetWithEmailUseCase, loadingView: LoadingView) {
        self.validation = validation
        self.alertView = alertView
        self.useCase = useCase
        self.loadingView = loadingView
    }
    
    public func passwordReset(request: PasswordResetRequest) {
        if let message = validation.validate(data: request.toJson()) {
            alertView.showErrorMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.display(viewModel: LoadingViewModel(isLoading: true))
            
            useCase.passwordReset(request: request.toModel()) { [weak self] result in
                
                guard let self = self else { return }
                
                self.loadingView.display(viewModel: LoadingViewModel(isLoading: false))
                
                switch result {
                case .success : self.alertView.showSuccess(viewModel: AlertViewModel(title: "Sucesso", message: "Verifique seu email para redefinir sua senha"))
                    
                case .failure(let error):
                    var errorMessage: String!
                    
                    switch error {
                    case .emailNotFound:
                        errorMessage = "Não encontramos seu email. Por favor tente outro"
                        
                        self.alertView.showErrorMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                    }
                }
            }
        }
    }
}
