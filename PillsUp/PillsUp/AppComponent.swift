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
    var pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase { get }
}

final class AppComponent: Component<EmptyDependency>, AppDependency {
    let distanceSettingUseCase: DistanceSettingUseCase
    let locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase
    let pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase

    init() {
        self.distanceSettingUseCase = DistanceSetting(
            distanceRepository: DefaultDistanceSettingRepostitory()
        )
        
        self.locateNearbyPharmaciesUseCase = LocateNearbyPharmacies(
            repository: DefaultPharmacyRepository(
                dataSource: DefaultPharmacyDataSource()
            )
        )
        
        self.pharmacyDetailInfoUseCase = PharmacyDetailInfo(
            repository: DefaultPharmacyRepository(
                dataSource: DefaultPharmacyDataSource()
            )
        )

        super.init(dependency: EmptyComponent())
    }
}
