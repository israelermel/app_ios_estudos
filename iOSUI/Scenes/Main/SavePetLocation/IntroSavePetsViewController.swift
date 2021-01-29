//
//  IntroSavePetsViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

public class IntroSavePetsViewController: UIViewController {

    // MARK: - Coordinator
    public var didSendEventClosure: ((IntroSavePetsViewController.Event) -> Void)?
    
    
    // MARK: - Properties
    
    let savePetOnStreet : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.title = "Adicionar Pet de rua"
        button.setHeight(height: 44)
        button.addTarget(self, action: #selector(handleSavePetOnStreet), for: .touchUpInside)
        return button
    }()
    
    let savePetLost : VinButton = {
        let button = VinButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.title = "Adicionar Pet perdido"
        button.setHeight(height: 44)
        button.addTarget(self, action: #selector(handleSavePetLost), for: .touchUpInside)
        return button
    }()
        
    // MARK: - Life cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        largeTitleDisplayModeAlways()
        configbackgroundScreen()
        
        configUi()
    }    

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBarController()
    }
    
    func configUi() {
        let stack = UIStackView(arrangedSubviews: [savePetOnStreet,
                                                   savePetLost])
        
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: view.safeTopAnchor,
                     left: view.safeLeftAnchor,
                     right: view.safeRightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
    }
    
    //MARK: - Handlers
    
    @objc func handleSavePetOnStreet() {
        didSendEventClosure?(.toSavePetOnStreet)
    }
    
    @objc func handleSavePetLost() {
        didSendEventClosure?(.toSaveLost)
    }

}

extension IntroSavePetsViewController {
    public enum Event {
        case toSavePetOnStreet
        case toSaveLost
    }
}
