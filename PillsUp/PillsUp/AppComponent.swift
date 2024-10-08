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
    var authenticationFacade: AuthenticationFacade { get }
}

final class AppComponent: Component<EmptyDependency>, AppDependency {
    let distanceSettingUseCase: DistanceSettingUseCase
    let locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase
    let pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase
    let authenticationFacade: AuthenticationFacade

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
        
        let authenticationManagerRepository = AppleLoginAthenticationRepository()
        
        self.authenticationFacade = AppleAuthentication(
            checkUseCase: CheckAppleAuthenticationUseCase(repository: authenticationManagerRepository),
            registerUseCase: RegisterAppleAuthentication(repository: authenticationManagerRepository),
            removeUseCase: RemoveAppleAuthentication(repository: authenticationManagerRepository)
        )

        super.init(dependency: EmptyComponent())
    }
}
