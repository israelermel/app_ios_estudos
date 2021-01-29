//
//  AppDelegate.swift
//  Main
//
//  Created by Israel Ermel on 08/09/20.
//  Copyright © 2020 Israel Ermel. All rights reserved.
//

import UIKit
import Infra
import iOSUI
import GoogleSignIn
import Firebase
import FirebaseCore
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let filePath = Environment.variablePlist(.firebaseConfigFile)
        let config = FirebaseConfiguration(filePath: filePath)
        config.configFirebase()
        
        if #available(iOS 13.0, *) {
            return true
        } else {
            
            window = UIWindow.init(frame: UIScreen.main.bounds)
            
            let navigationController: UINavigationController = .init()
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
           
            appCoordinator = AppCoordinator.init(navigationController)
            appCoordinator?.start()
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}
