//
//  PetCoordinateObject.swift
//  Infra
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift

public final class PetCoordinateObject: Object {
    @objc dynamic var id : String = "1"
    @objc dynamic var address: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}

