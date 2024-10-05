//
//  LoginBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import UIKit

import Domain
import ModernRIBs

protocol LoginDependency: Dependency {
    var authenticationFacade: AuthenticationFacade { get }
}

final class LoginComponent: Component<LoginDependency> {
    var authenticationFacade: AuthenticationFacade {
        return dependency.authenticationFacade
    }
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
        var viewController: LoginViewController!
        
        DispatchQueue.main.sync {
            viewController = LoginViewController()
        }
        
        let interactor = LoginInteractor(
            presenter: viewController,
            authenticationFacade: component.authenticationFacade
        )
        interactor.listener = listener
        return LoginRouter(
            interactor: interactor,
            viewController: viewController,
            navigation: navigation
        )
    }
}
