//
//  UserResponse.swift
//  Domain
//
//  Created by Israel Ermel on 09/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public struct UserSignInResponse {
    public var name: String?
    public var email: String?
    public var uid: String?
    public var photoURL: URL?
    public var isAnonymous: Bool?
    public var providerID: String?
    
    public init(uid: String?, name: String?,
                email: String?, photoURL: URL?,
                isAnonymous: Bool?, providerID: String?) {
        
        self.uid = uid
        self.name = name
        self.email = email
        self.photoURL = photoURL
        self.isAnonymous = isAnonymous
        self.providerID = providerID
    }
}
