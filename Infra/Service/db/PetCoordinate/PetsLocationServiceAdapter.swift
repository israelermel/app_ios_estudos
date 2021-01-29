//
//  PetsLocationServiceAdapter.swift
//  Infra
//
//  Created by Israel Ermel on 12/10/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Domain
import Data

public final class PetsLocationServiceAdapter: PetsLocationServiceClient {
    
    public init(){}

    public func retrieveAllPetsLocation(request: SearchPetsLocationViewModel, completion: @escaping (Result<[PetsLocationResponse], PestLocationDomainError>) -> Void) {
        
        let ref = Firestore.firestore().collection("petslocation")
        ref.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("error")
                return
            }                        
            
            let petsLocations = documents.compactMap { (querySnapshot) -> PetsLocationResponse? in
                return try? querySnapshot.data(as: PetsLocationResponse.self)                
            }
        
            completion(.success(petsLocations))

        }
        
    }
    
}
