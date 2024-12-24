//
//  PharmacyDetailBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import UIKit
import Domain

protocol PharmacyDetailDependency: Dependency {
    var pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase { get }
}

final class PharmacyDetailComponent: Component<PharmacyDetailDependency> {
    var pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase {
        return dependency.pharmacyDetailInfoUseCase
    }
}

// MARK: - Builder

protocol PharmacyDetailBuildable: Buildable {
    func build(
        withListener listener: PharmacyDetailListener,
        navigation: UINavigationController,
        hpid: String
    ) -> PharmacyDetailRouting
}

final class PharmacyDetailBuilder: Builder<PharmacyDetailDependency>, PharmacyDetailBuildable {

    override init(dependency: PharmacyDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: PharmacyDetailListener,
        navigation: UINavigationController,
        hpid: String
    ) -> PharmacyDetailRouting {
        let component = PharmacyDetailComponent(dependency: dependency)
        let viewController = PharmacyDetailViewController()

        let interactor = PharmacyDetailInteractor(
            presenter: viewController,
            pharmacyDetailInfoUseCase: component.pharmacyDetailInfoUseCase,
            hpid: hpid
        )

        interactor.listener = listener

        return PharmacyDetailRouter(
            interactor: interactor,
            viewController: viewController,
            navigation: navigation
        )
    }
}
