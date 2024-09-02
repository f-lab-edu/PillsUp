//
//  RootInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs

public protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

public final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    public override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    public override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
