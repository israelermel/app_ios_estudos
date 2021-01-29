//
//  Enviroment.swift
//  Main
//
//  Created by Israel Ermel on 08/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import Foundation

public final class Environment {
    
    public enum EnvironmentVariables :String {
        case firebaseConfigFile = "FIREBASE_CONFIG_FILE"
        case firebaseClientId = "CLIENT_ID"
        
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
    
    public static func variablePlist(_ key: EnvironmentVariables) -> String {
        return Bundle.main.path(forResource: variable(key), ofType: "plist")!
    }
    
    public static func variableFirebaseAt(_ key: EnvironmentVariables) -> String {
        var nsDictionary: NSDictionary?
        
        if let path = Bundle.main.path(forResource: variable(.firebaseConfigFile), ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
            
            return nsDictionary?.value(forKey: key.rawValue) as! String
        }
        
        return ""
    }
}
