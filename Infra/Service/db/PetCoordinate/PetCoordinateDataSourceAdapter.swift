//
//  PetsLocationDataSourceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 09/01/21.
//  Copyright © 2021 Israel Ermel. All rights reserved.
//

import Foundation
import Domain
import Data
import RealmSwift

public final class PetCoordinateDataSourceAdapter: PetCoordinateServiceClient {
    
    public init(){}
    
    public func savePetCoordinate(request: PetCoordinateEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        
        clearPetCoordinateTable()
        
        let container = try! Container()
        try! container.write { transaction in
            transaction.add(request, update: true)
        }
    
        completion(.success)
        
    }
    
    public func savePet(request: SavePetEntity, completion: @escaping (SavePetVoidResult) -> Void) {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        clearSavePetTable()
        clearPetCoordinateTable()
        
        let container = try! Container()
        try! container.write { transaction in
            transaction.add(request, update: true)
        }
    
        completion(.success)
    }
    
    fileprivate func clearSavePetTable() {
        let container = try! Container()
        
        let result = container.values(
            SavePetEntity.self
        )
        
        if(result.count == 0) {
            return
        }
        
        try! container.write { transaction in
            transaction.deleteById(result.value(at: 0))
        }
    }
    
    fileprivate func clearPetCoordinateTable() {
        let container = try! Container()
        
        let result = container.values(
            PetCoordinateEntity.self
        )
        
        if(result.count == 0) {
            return
        }        
        
        try! container.write { transaction in
            transaction.deleteById(result.value(at: 0))
        }
    }
    
    
}
