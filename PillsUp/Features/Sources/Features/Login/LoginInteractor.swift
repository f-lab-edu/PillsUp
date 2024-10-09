//
//  LoginInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import Domain
import ModernRIBs

protocol LoginRouting: ViewableRouting {
    func loginSuccess()
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
}

protocol LoginListener: AnyObject { }

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable {

    weak var router: LoginRouting?
    weak var listener: LoginListener?

    private let authenticationFacade: AuthenticationFacade

    init(
        presenter: LoginPresentable,
        authenticationFacade: AuthenticationFacade
    ) {
        self.authenticationFacade = authenticationFacade
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

extension LoginInteractor: LoginPresentableListener {
    func register(_ userId: String) {
        Task { [weak self] in
            try await self?.authenticationFacade.register(data: userId)
            self?.router?.loginSuccess()
        }
    }
}
