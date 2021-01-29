//
//  RemoteOpenSignInWithGoogle.swift
//  Data
//
//  Created by Israel Ermel on 14/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public final class RemoteOpenSignInWithGoogle: OpenSignWithGoogleUseCase {
   
    private let service: SignUpWithGoogleServiceClient
    
    public init(service: SignUpWithGoogleServiceClient) {
        self.service = service
    }
    
    public func openSignInWithGoogle() {
        service.openSignInWithGoogle()
    }
    
}
