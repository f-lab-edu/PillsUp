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
}

protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    private let distanceUseCase: DistanceSettingUseCase
    
    init(
        presenter: MainPresentable,
        distanceUseCase: DistanceSettingUseCase
    ) {
        self.distanceUseCase = distanceUseCase
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
        do {
            try distanceUseCase.save(distance)
            presenter.currentDistanceSubject.send(distanceUseCase.retrieve())
        } catch {
            // TODO: 에러처리
        }
    }
}
