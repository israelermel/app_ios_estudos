//
//  RoundedTextField.swift
//  iOSUI
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import UIKit

public class RoundedTextField: UITextField {
    
    init(placeholder : String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .roundedRect
        textColor = Color.primaryTextDark
        
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(height: 50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : Color.primaryTextLight])
        
    }
    
    func disableEdit() {
        self.isEnabled = false
        self.isOpaque = true
    }
    
    func enableEdit() {
        self.isEnabled = true
        self.isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
