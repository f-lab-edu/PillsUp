//
//  SceneDelegate.swift
//  PillsUp
//
//  Created by Junyoung on 8/26/24.
//

import UIKit
import ModernRIBs
import Features

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true

        let launchRouter = RootBuilder(dependency: AppComponent()).build(navigationController)
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)

        window.rootViewController = navigationController
        self.window = window
    }
}
