//
//  SavePhotoPetEntity.swift
//  Domain
//
//  Created by Israel Ermel on 19/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation

public struct SavePhotoPetEntity {
    
    public var id: String
    public var photo: String
    
    public init(id: String, photo: String) {
        self.id = id
        self.photo = photo
    }
}
