//
//  SceneDelegate.swift
//  NewIOSApp
//
//  Created by Bekzod Abdullaev on 11/06/25.
//

import SwiftUI
import FirebaseCore

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    public let coordinator: Coordinator<MainRouter> = .init(startingRoute: .auth(.launch))
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        FirebaseApp.configure()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
        
        
       
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

