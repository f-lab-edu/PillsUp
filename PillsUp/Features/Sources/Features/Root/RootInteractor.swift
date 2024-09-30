//
//  RootInteractor.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs

public protocol RootRouting: ViewableRouting {
    
}

public protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    
}

public protocol RootListener: AnyObject {
    
}

public final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?
    
    override init(presenter: RootPresentable) {
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
