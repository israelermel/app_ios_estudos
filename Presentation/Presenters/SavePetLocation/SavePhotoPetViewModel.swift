//
//  SavePhotoPetViewModel.swift
//  Presentation
//
//  Created by Israel Ermel on 19/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain

public struct SavePhotoPetViewModel {
    
    let id: String
    let photo: String
    
    public init(id: String, photo: String) {
        self.id = id
        self.photo = photo
    }
    
    func toEntity() -> SavePhotoPetEntity {
        return SavePhotoPetEntity(id: id, photo: photo)
    }
    
}
