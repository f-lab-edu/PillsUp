//
//  LoginViewController.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import ModernRIBs
import UIKit

protocol LoginPresentableListener: AnyObject {
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

    weak var listener: LoginPresentableListener?
}
