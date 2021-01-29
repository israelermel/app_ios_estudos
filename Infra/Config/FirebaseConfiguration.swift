//
//  Service.swift
//  Infra
//
//  Created by Israel Ermel on 08/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseAuth
import Domain
import GoogleSignIn

public class FirebaseConfiguration {
    private let filePath : String?
    
    public init(filePath: String?) {
        self.filePath = filePath
    }
    
    public func configFirebase() {
        guard let fileopts = FirebaseOptions(contentsOfFile: self.filePath!)
        else { assert(false, "Couldn't load config file") }
        
        FirebaseApp.configure(options: fileopts)
    }
    
}
