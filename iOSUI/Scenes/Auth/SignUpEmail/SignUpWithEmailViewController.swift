//
//  SignUpWithEmailViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 11/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit
import Presentation

public class SignUpWithEmailViewController: UIViewController {

    var customView: SignUpEmailView?
    
    // MARK: - UseCase
    public var singUpUseCase: ((SignUpRequest) -> Void)?
    
    // MARK: - Coordinator
    public var didSendEventClosure: ((SignUpWithEmailViewController.Event) -> Void)?
               
    // MARK: - Lifecycle
    
    public override func loadView() {
        let customView = SignUpEmailView()
        customView.delegate = self
        view = customView
        
        self.customView = {
            return view as! SignUpEmailView
        }()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUi()
    }
        
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
    func configureUi() {
        configbackgroundScreen()
        hideKeyboardOnTapScreen()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .blackTranslucent
          
    }
    
}

// MARK: - Handlers

extension SignUpWithEmailViewController: SignUpEmailViewDelegate {
    func signIn() {
        didSendEventClosure?(.toSignIn)
    }
    
    func signUpWithEmailEvent(request: SignUpRequest) {
        singUpUseCase?(request)
    }
}

extension SignUpWithEmailViewController: AlertView {
    public func showErrorMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    public func showSuccess(viewModel: AlertViewModel) {
        didSendEventClosure?(.toMain)
    }
}

extension SignUpWithEmailViewController: LoadingView {
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


extension SignUpWithEmailViewController {
    public enum Event {
        case toMain
        case toSignIn
    }
}

