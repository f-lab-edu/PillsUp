//
//  RootBuilder.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit

public protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol RootBuildable: Buildable {
    func build(_ navigationController: UINavigationController) -> LaunchRouting
}

public final class RootBuilder: Builder<RootDependency>, RootBuildable {

    public override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    public func build(_ navigationController: UINavigationController) -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController(navigation: navigationController)
        let interactor = RootInteractor(presenter: viewController)
        
        let mainBuilder = MainBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuilder: mainBuilder
        )
    }
}
