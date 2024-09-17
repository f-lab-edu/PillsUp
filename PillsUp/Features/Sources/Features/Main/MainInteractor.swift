//
//  MainInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import Domain
import Combine

protocol MainRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var currentDistanceSubject: PassthroughSubject<Int, Never> { get set }
    var pharmacySubject: PassthroughSubject<[Pharmacy], Never> { get }
}

protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    private let distanceUseCase: DistanceSettingUseCase
    private let locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase
    
    init(
        presenter: MainPresentable,
        distanceUseCase: DistanceSettingUseCase,
        locateNearbyPharmaciesUseCase: LocateNearbyPharmaciesUseCase
    ) {
        self.distanceUseCase = distanceUseCase
        self.locateNearbyPharmaciesUseCase = locateNearbyPharmaciesUseCase
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func viewLoaded() {
        presenter.currentDistanceSubject.send(distanceUseCase.retrieve())
        
        
    }
    
    func saveDistance(_ distance: Int) {
        try! distanceUseCase.save(distance)
        presenter.currentDistanceSubject.send(distanceUseCase.retrieve())
    }
    
    func fetchPharmacy(_ location: Location) {
        Task {
            let distance = Double(distanceUseCase.retrieve()) / 1000.0
            let pharmacy = try await locateNearbyPharmaciesUseCase.retrieve(location)
            
            let result = pharmacy.items.filter { Double($0.distance) ?? 0 <= distance }
            
            presenter.pharmacySubject.send(result)
        }
    }
}
