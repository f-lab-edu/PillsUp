//
//  RootRouter.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit

protocol RootInteractable: Interactable, MainListener, LoginListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable { }

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainBuilder: MainBuildable
    private var mainRouting: ViewableRouting?

    private let loginBuilder: LoginBuildable
    private var loginRouting: ViewableRouting?

    private let navigation: UINavigationController

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuilder: MainBuildable,
        loginBuilder: LoginBuildable,
        navigation: UINavigationController
    ) {
        self.mainBuilder = mainBuilder
        self.loginBuilder = loginBuilder
        self.navigation = navigation
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self

        pushRootVC()
    }

    func pushToMain() {
        let main = mainBuilder.build(withListener: interactor, navigation: navigation)
        self.mainRouting = main
        attach(main)
    }

    func pushToLogin() {
        let login = loginBuilder.build(withListener: interactor, navigation: navigation)
        self.loginRouting = login
        attach(login)
    }

    private func attach(_ routing: ViewableRouting) {
        attachChild(routing)
        pushViewController(routing)

    }

    private func pushRootVC() {
        DispatchQueue.main.async {
            self.navigation.pushViewController(self.viewController.uiviewController, animated: false)
        }
    }

    private func pushViewController(_ routing: ViewableRouting) {
        DispatchQueue.main.async {
            self.navigation.pushViewController(routing.viewControllable.uiviewController, animated: false)
        }
    }

}

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController {
        return self
    }

    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
