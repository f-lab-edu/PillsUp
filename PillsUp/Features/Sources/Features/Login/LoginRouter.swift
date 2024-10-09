//
//  LoginRouter.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import UIKit

import ModernRIBs

protocol LoginInteractable: Interactable {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {

    private let navigation: UINavigationController

    init(
        interactor: LoginInteractable,
        viewController: LoginViewControllable,
        navigation: UINavigationController
    ) {
        self.navigation = navigation
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func loginSuccess() {
        detachChild(self)
        DispatchQueue.main.async {
            self.navigation.popViewController(animated: false)
        }
    }

}
