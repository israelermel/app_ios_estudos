//
//  SignInViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit
import Presentation
import GoogleSignIn
import CryptoKit
import AuthenticationServices

public class SignInViewController: UIViewController {
        
    var customView: SignInView?
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    // MARK: - ViewModels
    public var signInWithEmail: ((SignInRequest) -> Void)?
    public var signInWithGoogle: ((SignInGoogleRequest) -> Void)?
    public var signInWithApple: ((SignInAppleRequest) -> Void)?
    
    // MARK: - Coordinator    
    public var didSendEventClosure: ((SignInViewController.Event) -> Void)?
         
    // Mark: - Lifecycler
    public override func loadView() {
        let customView = SignInView()
        customView.delegate = self
        view = customView
        
        self.customView = {
            return view as! SignInView
        }()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        configureGoogleSignIn()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUi()
        hideKeyboardOnTapScreen()
                        
    }
    
    deinit {
        print("DEBUG: deallocing \(self)")
    }
    
    func configureGoogleSignIn() {    
        GIDSignIn.sharedInstance()?.clientID = Environment.variableFirebaseAt(.firebaseClientId)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    func configureUi() {
        configbackgroundScreen()
            
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
      
    }
        
}

// MARK: - Handlers
extension SignInViewController: SignInViewDelegate {
    func registrationEvent() {
        didSendEventClosure?(.signUp)
    }
    
    func forgotPasswordEvent() {
        didSendEventClosure?(.passwordReset)
    }
    
    func appleSignInEvent() {
        if #available(iOS 13, *) {
            startSignInWithAppleFlow()
        }
    }
    
    func signInGoogleEvent() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func signInEvent(request: SignInRequest) {
        signInWithEmail?(request)
    }
}


extension SignInViewController: AlertView {
    public func showErrorMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    public func showSuccess(viewModel: AlertViewModel) {
        didSendEventClosure?(.main)
    }
}

extension SignInViewController: LoadingView {
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

// MARK: - SignIn with Google
extension SignInViewController: GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard user != nil else { return }
        guard let authentication = user.authentication else { return }
                
        let request = SignInGoogleRequest(idToken: authentication.idToken, accessToken: authentication.accessToken)
        
        signInWithGoogle?(request)
                        
    }

}

// MARK: - SignIn with Apple Auth
@available(iOS 13.0, *)
extension SignInViewController: ASAuthorizationControllerDelegate {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        debugPrint(error.localizedDescription)
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            
            let request = SignInAppleRequest(idToken: idTokenString, nonce: nonce)
            signInWithApple?(request)
                        
        }
    }
}

// MARK: - SignIn with Apple Hashes
extension SignInViewController {
    @available(iOS 13, *)
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString

    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
}

extension SignInViewController {
   public enum Event {
        case main
        case passwordReset
        case signUp
    }
}
