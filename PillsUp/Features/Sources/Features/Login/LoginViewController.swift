//
//  LoginViewController.swift
//  PillsUp
//
//  Created by Junyoung on 10/1/24.
//

import AuthenticationServices
import UIKit

import ModernRIBs

protocol LoginPresentableListener: AnyObject {
    func register(_ userId: String)
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {

    weak var listener: LoginPresentableListener?
    
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: "login")
        $0.contentMode = .scaleAspectFit
    }
    
    private let appleLoginButton = UIButton().then {
        $0.setImage(UIImage(named: "appleLogin"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - General Function
extension LoginViewController {
    private func setup() {
        addSubViews()
        setupLayout()
        addAction()
    }
    
    private func addSubViews() {
        view.addSubview(backgroundImage)
        view.addSubview(appleLoginButton)
    }
    
    private func setupLayout() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    private func addAction() {
        appleLoginButton.addAction(UIAction(handler: { [weak self] _ in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }), for: .touchUpInside)
    }
}

// MARK: - ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerDelegate,
                               ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let view = self.view.window else {
            return UIWindow()
        }
        
        return view
    }
    
    //MARK: 로그인 성공
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        listener?.register(credential.user)
        
    }
    
    //MARK: 로그인 실패
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        print("login failed - \(error.localizedDescription)")
    }
}
