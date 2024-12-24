//
//  RootInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import UIKit

import Domain
import ModernRIBs

public protocol RootRouting: ViewableRouting {
    func pushToMain()
    func pushToLogin()
}

public protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }

}

public protocol RootListener: AnyObject {

}

public final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable {

    weak var router: RootRouting?
    weak var listener: RootListener?

    private let authenticationFacade: AuthenticationFacade

    init(
        presenter: RootPresentable,
        authenticationFacade: AuthenticationFacade
    ) {
        self.authenticationFacade = authenticationFacade
        super.init(presenter: presenter)
        presenter.listener = self
    }

    public override func didBecomeActive() {
        super.didBecomeActive()
    }

    public override func willResignActive() {
        super.willResignActive()

    }
}

// MARK: - General Function
extension RootInteractor {
    private func checkAuthentication() {
        Task { [weak self] in
            guard let self else { return }
            do {
                if try await self.authenticationFacade.check() {
                    self.router?.pushToMain()
                } else {
                    self.router?.pushToLogin()
                }
            } catch {
                self.router?.pushToLogin()
            }
        }
    }
}

// MARK: - RootPresentableListener
extension RootInteractor: RootPresentableListener {
    public func willAppear() {
        checkAuthentication()
    }
}
