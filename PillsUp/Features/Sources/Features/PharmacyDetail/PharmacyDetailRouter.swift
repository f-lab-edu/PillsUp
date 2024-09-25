//
//  PharmacyDetailRouter.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs

protocol PharmacyDetailInteractable: Interactable {
    var router: PharmacyDetailRouting? { get set }
    var listener: PharmacyDetailListener? { get set }
}

protocol PharmacyDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PharmacyDetailRouter: ViewableRouter<PharmacyDetailInteractable, PharmacyDetailViewControllable>, PharmacyDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PharmacyDetailInteractable, viewController: PharmacyDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
