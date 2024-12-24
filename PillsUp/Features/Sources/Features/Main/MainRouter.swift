//
//  MainRouter.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit

protocol MainInteractable: Interactable, PharmacyDetailListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable { }

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {

    private let detailBuilder: PharmacyDetailBuildable
    private var detailRouting: ViewableRouting?
    private let navigation: UINavigationController

    init(
        interactor: MainInteractable,
        viewController: MainViewControllable,
        detailBuilder: PharmacyDetailBuildable,
        navigation: UINavigationController
    ) {
        self.detailBuilder = detailBuilder
        self.navigation = navigation
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func pushToDetail(_ hpid: String) {
        let detail = detailBuilder.build(
            withListener: interactor,
            navigation: navigation,
            hpid: hpid
        )
        self.detailRouting = detail

        attachChild(detail)
        pushViewController(detail)
    }

    private func pushViewController(_ routing: PharmacyDetailRouting) {
        DispatchQueue.main.async { [weak self] in
            self?.navigation.pushViewController(routing.viewControllable.uiviewController, animated: true)
        }
    }
}
