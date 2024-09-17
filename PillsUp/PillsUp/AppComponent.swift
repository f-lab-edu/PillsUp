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
    var locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase { get }
}

final class AppComponent: Component<EmptyDependency>, AppDependency {
    let distanceSettingUseCase: DistanceSettingUseCase
    let locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase

    init() {
        self.distanceSettingUseCase = DistanceSetting(
            distanceRepository: DefaultDistanceSettingRepostitory()
        )
        
        self.locateNearbyPharmaciesUseCase = LocateNearbyPharmacies(
            repository: DefaultPharmacyRepository(
                dataSource: DefaultPharmacyDataSource()
            )
        )

        super.init(dependency: EmptyComponent())
    }
}
