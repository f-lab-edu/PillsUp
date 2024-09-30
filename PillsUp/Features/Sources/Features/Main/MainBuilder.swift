//
//  MainBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import Domain
import UIKit

protocol MainDependency: Dependency {
    var distanceSettingUseCase: DistanceSettingUseCase { get }
    var locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase { get }
    var pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase { get }
}

final class MainComponent: Component<MainDependency> {
    var distanceSettingUseCase: DistanceSettingUseCase {
        return dependency.distanceSettingUseCase
    }
    
    var locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase {
        return dependency.locateNearbyPharmaciesUseCase
    }
    
    var pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase {
        return dependency.pharmacyDetailInfoUseCase
    }
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener, navigation: UINavigationController) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: MainListener,
        navigation: UINavigationController
    ) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(
            presenter: viewController,
            distanceUseCase: dependency.distanceSettingUseCase,
            locateNearbyPharmaciesUseCase: dependency.locateNearbyPharmaciesUseCase
        )
        
        interactor.listener = listener
        
        let detailBuilder = PharmacyDetailBuilder(dependency: component)
        
        return MainRouter(
            interactor: interactor,
            viewController: viewController,
            detailBuilder: detailBuilder,
            navigation: navigation
        )
    }
}
