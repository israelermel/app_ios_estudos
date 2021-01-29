//
//  ProfileViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 25/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

public class ProfileViewController: UIViewController {

    // MARK: - User Event
    public var didSendEventClosure: ((ProfileViewController.Event) -> Void)?
    
    let testeLabel : VinButton = {
        let button = VinButton(type: .system)
        button.addTarget(self, action: #selector(handleSignWitEmail), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.title = "Sair"
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(testeLabel)
        testeLabel.centerX(inView: view)
        testeLabel.centerY(inView: view)
       
    }
    
    @objc func handleSignWitEmail() {
        didSendEventClosure?(.logout)
    }

}
extension ProfileViewController {
    public enum Event {
        case logout
    }
}
