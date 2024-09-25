//
//  PharmacyDetailViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import UIKit

protocol PharmacyDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class PharmacyDetailViewController: UIViewController, PharmacyDetailPresentable, PharmacyDetailViewControllable {

    weak var listener: PharmacyDetailPresentableListener?
}
