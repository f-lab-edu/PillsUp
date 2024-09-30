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
    
}

protocol PharmacyDetailListener: AnyObject {
    
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
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func onTapBack() {
        router?.pop()
    }
}
