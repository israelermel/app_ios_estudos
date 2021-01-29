//
//  VNEmailTextField.swift
//  iOSUI
//
//  Created by Israel Ermel on 17/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

class VNEmailTextField: RoundedTextField {
    
    init() {
        super.init(placeholder: "Email")
        keyboardType = .emailAddress
        autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
