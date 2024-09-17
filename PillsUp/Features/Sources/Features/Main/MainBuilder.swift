//
//  MainBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import Domain

protocol MainDependency: Dependency {
    var distanceSettingUseCase: DistanceSettingUseCase { get }
    var locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase { get }
}

final class MainComponent: Component<MainDependency> {
    var distanceSettingUseCase: DistanceSettingUseCase {
        return dependency.distanceSettingUseCase
    }
    
    var locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase {
        return dependency.locateNearbyPharmaciesUseCase
    }
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        
        let viewController = MainViewController()
        let interactor = MainInteractor(
            presenter: viewController,
            distanceUseCase: dependency.distanceSettingUseCase,
            locateNearbyPharmaciesUseCase: dependency.locateNearbyPharmaciesUseCase
        )
        interactor.listener = listener
        
        return MainRouter(interactor: interactor, viewController: viewController)
    }
}
