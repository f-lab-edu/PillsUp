//
//  LoginBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import UIKit

import ModernRIBs

protocol LoginDependency: Dependency {
    
}

final class LoginComponent: Component<LoginDependency> {
    
}

// MARK: - Builder
protocol LoginBuildable: Buildable {
    func build(withListener listener: LoginListener, navigation: UINavigationController) -> LoginRouting
}

final class LoginBuilder: Builder<LoginDependency>, LoginBuildable {

    override init(dependency: LoginDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: LoginListener,
        navigation: UINavigationController
    ) -> LoginRouting {
        let component = LoginComponent(dependency: dependency)
        let viewController = LoginViewController()
        let interactor = LoginInteractor(presenter: viewController)
        interactor.listener = listener
        return LoginRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
