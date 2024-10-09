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
    func pushToDetail(_ hpid: String)
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    var fetchPharmacyListener: MainFetchPharmacyListener? { get set }
    var saveDistanceListener: MainSaveDistanceListener? { get set }
    var mainDetailListener: MainDetailListener? { get set }
    var currentDistanceSubject: PassthroughSubject<Int, Never> { get set }
    var pharmacySubject: PassthroughSubject<[Pharmacy], Never> { get }
}

protocol MainListener: AnyObject {
    
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable  {

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
        presenter.fetchPharmacyListener = self
        presenter.saveDistanceListener = self
        presenter.mainDetailListener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension MainInteractor: MainPresentableListener {
    func viewLoaded() {
        presenter.currentDistanceSubject.send(distanceUseCase.retrieve())
    }
}

extension MainInteractor: MainFetchPharmacyListener {
    func fetchPharmacy(_ location: Location) {
        Task {
            let distance = Double(distanceUseCase.retrieve()) / 1000.0
            let pharmacy = try await locateNearbyPharmaciesUseCase.retrieve(location)
            
            let result = pharmacy.items.filter { Double($0.distance) ?? 0 <= distance }
            
            presenter.pharmacySubject.send(pharmacy.items)
        }
    }
}

extension MainInteractor: MainSaveDistanceListener {
    func saveDistance(_ distance: Int) {
        try? distanceUseCase.save(distance)
        presenter.currentDistanceSubject.send(distanceUseCase.retrieve())
    }
}

extension MainInteractor: MainDetailListener {
    func push(hpid: String) {
        router?.pushToDetail(hpid)
    }
}
