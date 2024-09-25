//
//  PharmacyDetailInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs

protocol PharmacyDetailRouting: ViewableRouting {
    func pop()
}

protocol PharmacyDetailPresentable: Presentable {
    var listener: PharmacyDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol PharmacyDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class PharmacyDetailInteractor: PresentableInteractor<PharmacyDetailPresentable>, PharmacyDetailInteractable, PharmacyDetailPresentableListener {

    weak var router: PharmacyDetailRouting?
    weak var listener: PharmacyDetailListener?
    private let hpid: String
    
    init(
        presenter: PharmacyDetailPresentable,
        hpid: String
    ) {
        self.hpid = hpid
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
    
    func onTapBack() {
        router?.pop()
    }
}
