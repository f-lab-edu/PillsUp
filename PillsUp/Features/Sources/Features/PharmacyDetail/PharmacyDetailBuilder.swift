//
//  PharmacyDetailBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs

protocol PharmacyDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class PharmacyDetailComponent: Component<PharmacyDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol PharmacyDetailBuildable: Buildable {
    func build(withListener listener: PharmacyDetailListener) -> PharmacyDetailRouting
}

final class PharmacyDetailBuilder: Builder<PharmacyDetailDependency>, PharmacyDetailBuildable {

    override init(dependency: PharmacyDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PharmacyDetailListener) -> PharmacyDetailRouting {
        let component = PharmacyDetailComponent(dependency: dependency)
        let viewController = PharmacyDetailViewController()
        let interactor = PharmacyDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return PharmacyDetailRouter(interactor: interactor, viewController: viewController)
    }
}
