//
//  VNPasswordTextField.swift
//  iOSUI
//
//  Created by Israel Ermel on 10/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit

class VNPasswordTextField: RoundedTextField {
    
    override init(placeholder: String) {
        super.init(placeholder: placeholder)
        
        isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
