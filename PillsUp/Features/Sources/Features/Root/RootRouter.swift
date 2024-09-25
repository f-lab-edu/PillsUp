//
//  RootRouter.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable { }

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    private let mainBuilder: MainBuildable
    private var mainRouting: ViewableRouting?
    private let navigation: UINavigationController
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuilder: MainBuildable,
        navigation: UINavigationController
    ) {
        self.mainBuilder = mainBuilder
        self.navigation = navigation
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        let main = mainBuilder.build(withListener: interactor, navigation: navigation)
        self.mainRouting = main
        attachChild(main)
        
        navigation.pushViewController(main.viewControllable.uiviewController, animated: true)
    }
    
}

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController {
        return self
    }
    
    convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}
