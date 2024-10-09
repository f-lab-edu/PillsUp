//
//  PharmacyDetailInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import Domain
import Combine

protocol PharmacyDetailRouting: ViewableRouting {
    func pop()
}

protocol PharmacyDetailPresentable: Presentable {
    var listener: PharmacyDetailPresentableListener? { get set }
    var pharmacyDetail: PassthroughSubject<PharmacyDetail, Never> { get set }
    
    func fetchDetailFailure()
}

protocol PharmacyDetailListener: AnyObject { }

final class PharmacyDetailInteractor: PresentableInteractor<PharmacyDetailPresentable>, PharmacyDetailInteractable, PharmacyDetailPresentableListener {

    weak var router: PharmacyDetailRouting?
    weak var listener: PharmacyDetailListener?
    
    private let hpid: String
    private let pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase
    
    init(
        presenter: PharmacyDetailPresentable,
        pharmacyDetailInfoUseCase: PharmacyDetailInfoUseCase,
        hpid: String
    ) {
        self.pharmacyDetailInfoUseCase = pharmacyDetailInfoUseCase
        self.hpid = hpid
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        Task {
            do {
                guard let detail = try await self.pharmacyDetailInfoUseCase.retrieve(self.hpid) else { return }
                self.presenter.pharmacyDetail.send(detail)
            } catch {
                self.presenter.fetchDetailFailure()
            }
        }
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func onTapBack() {
        router?.pop()
    }
}
