//
//  PharmacyDetailRouter.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import UIKit

protocol PharmacyDetailInteractable: Interactable {
    var router: PharmacyDetailRouting? { get set }
    var listener: PharmacyDetailListener? { get set }
}

protocol PharmacyDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PharmacyDetailRouter: ViewableRouter<PharmacyDetailInteractable, PharmacyDetailViewControllable>, PharmacyDetailRouting {
    
    private let navigation: UINavigationController
    
    init(
        interactor: PharmacyDetailInteractable,
        viewController: PharmacyDetailViewControllable,
        navigation: UINavigationController
    ) {
        self.navigation = navigation
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func pop() {
        detachChild(self)
        navigation.popViewController(animated: true)
    }
}
