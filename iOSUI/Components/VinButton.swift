//
//  VNAuthButton.swift
//  iOSUI
//
//  Created by Israel Ermel on 10/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

class VinButton: UIButton {
    
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        backgroundColor = Color.primaryAction
        setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        setHeight(height: 44)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func disabled() {
        isEnabled = false
        backgroundColor = Color.primaryActionDisable
    }
    
    public func enabled() {
        isEnabled = true
        backgroundColor = Color.primaryAction
    }
}
