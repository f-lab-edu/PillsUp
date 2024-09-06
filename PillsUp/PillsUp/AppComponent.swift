//
//  AppComponent.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import Features
import Domain
import Data

protocol AppDependency: Dependency {
    var distanceSettingUseCase: DistanceSettingUseCase { get }
}

final class AppComponent: Component<EmptyDependency>, AppDependency {
    let distanceSettingUseCase: DistanceSettingUseCase

    init() {
        self.distanceSettingUseCase = DistanceSetting(
            appDataRepository: DefaultAppDataRepostitory()
        )

        super.init(dependency: EmptyComponent())
    }
}
