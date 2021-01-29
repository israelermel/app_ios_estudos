//
//  UIViewControllerExtensions.swift
//  Main
//
//  Created by Israel Ermel on 08/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

extension UIViewController {
 
    func configbackgroundScreen() {
        self.view.backgroundColor = .white
    }
    
    func translucentBlurNavigationBar() {
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame =  (self.navigationController?.navigationBar.bounds.insetBy(dx: 0, dy: -10).offsetBy(dx: 0, dy: -10))!
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubviewToBack(visualEffectView)
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)        
    }
    
    func hideKeyboardOnTapScreen() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    func hideTabBarController() {
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBarController() {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    public func largeTitleDisplayModeAlways() {
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .always
        }
    }
    
    public func largeTitleDisplayModeNever() {
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
}
