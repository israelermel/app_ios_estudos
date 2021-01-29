//
//  PasswordResetWithEmailViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 16/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Presentation

public class PasswordResetWithEmailViewController: UIViewController {
    
    var customView: PasswordResetEmailView?
    
    // MARK: - ViewModels
    public var passwordResetUseCase: ((PasswordResetRequest) -> Void)?
    
    public var didSendEventClosure: ((PasswordResetWithEmailViewController.Event) -> Void)?
        
    
    // MARK: - Lifecycle
    
    public override func loadView() {
        let customView = PasswordResetEmailView()
        customView.delegate = self
        view = customView
        
        self.customView = {
            return view as! PasswordResetEmailView
        }()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configbackgroundScreen()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
                
        hideKeyboardOnTapScreen()

    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
    
}

extension PasswordResetWithEmailViewController: AlertView {
    public func showErrorMessage(viewModel: AlertViewModel) {
        
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    public func showSuccess(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default,handler: { uiAlertView in
            self.didSendEventClosure?(.toSignIn)
        }))
        
        present(alert, animated: true)
    }
}

extension PasswordResetWithEmailViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            self.customView?.loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            self.customView?.loadingIndicator.stopAnimating()
        }
    }
}


extension PasswordResetWithEmailViewController {
    public enum Event {        
        case toSignIn
    }
}


extension PasswordResetWithEmailViewController: PasswordResetEmailViewDelegate {
    func signIn() {
        didSendEventClosure?(.toSignIn)
    }
    
    func sendPasswordReset(request: PasswordResetRequest) {
        passwordResetUseCase?(request)
    }
}

