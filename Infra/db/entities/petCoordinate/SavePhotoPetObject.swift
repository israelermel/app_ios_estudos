//
//  SavePhotoPetObject.swift
//  Infra
//
//  Created by Israel Ermel on 19/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import RealmSwift

public final class SavePhotoPetObject: Object {
    
    @objc dynamic var id : String = ""
    @objc dynamic var photo: String = ""
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}
