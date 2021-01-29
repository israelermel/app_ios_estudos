//
//  LoadingAppViewController.swift
//  iOSUI
//
//  Created by Israel Ermel on 17/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

public class LoadingAppViewController: UIViewController {

    // MARK: - Coordinator
    public var didSendEventClosure: ((LoadingAppViewController.Event) -> Void)?
    
    let loadingText : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Carregando....aguarde"
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configbackgroundScreen()
        
        view.addSubview(loadingText)
        loadingText.centerX(inView: view)
        loadingText.centerY(inView: view)
        
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //MARK: - Animation Start App
//        UIView.animate(withDuration: 3.0) {
            self.didSendEventClosure?(.toMain)
//        }
        
    }

}

extension LoadingAppViewController {
    public enum Event {
        case toMain
        case toSignIn
    }
}
