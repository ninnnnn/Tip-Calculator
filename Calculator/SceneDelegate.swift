//
//  SceneDelegate.swift
//  Calculator
//
//  Created by user on 2023/6/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = Calculator.VC()
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
    }
}

