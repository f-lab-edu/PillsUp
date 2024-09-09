//
//  RootViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit

public protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    var navigation: UINavigationController
    
    init(
        listener: RootPresentableListener? = nil,
        navigation: UINavigationController
    ) {
        self.listener = listener
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func routeMain(_ viewController: ViewControllable) {
        self.navigation.pushViewController(viewController.uiviewController, animated: true)
    }
}

