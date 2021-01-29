//
//  SavePetObject.swift
//  Infra
//
//  Created by Israel Ermel on 13/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift

public final class SavePetObject: Object {
    
    @objc dynamic var id : String = ""
    @objc dynamic var petDescription: String = ""
    @objc dynamic var petCoordinate: PetCoordinateObject?
    let photos = List<SavePhotoPetObject>()
        
    public override static func primaryKey() -> String? {
        return "id"
    }
}
