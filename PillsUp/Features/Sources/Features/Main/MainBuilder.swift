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
}

final class MainComponent: Component<MainDependency> {
    var distanceSettingUseCase: DistanceSettingUseCase {
        return dependency.distanceSettingUseCase
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
//        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(
            presenter: viewController,
            distanceUseCase: dependency.distanceSettingUseCase
        )
        interactor.listener = listener
        
        return MainRouter(interactor: interactor, viewController: viewController)
    }
}
