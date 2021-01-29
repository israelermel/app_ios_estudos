//
//  AlertView.swift
//  Presentation
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public protocol AlertView {
    func showErrorMessage(viewModel: AlertViewModel)
    func showSuccess(viewModel: AlertViewModel)
}

public struct AlertViewModel : Equatable{
    public var title: String
    public var message: String    
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
    
    
}

