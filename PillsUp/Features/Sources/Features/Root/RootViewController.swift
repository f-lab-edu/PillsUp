//
//  RootViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import UIKit

import ModernRIBs
import Then
import SnapKit

public protocol RootPresentableListener: AnyObject {
    func willAppear()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    private let labelStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "내 근처 약국 찾기 서비스"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .medium)
    }
    
    private let appNameLabel = UILabel().then {
        $0.text = "Pills Up"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 40, weight: .bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.willAppear()
    }
}

extension RootViewController {
    private func setup() {
        configuration()
        addSubViews()
        setupLayout()
    }
    
    private func configuration() {
        view.backgroundColor = UIColor(
            cgColor: .init(
                red: 83/255,
                green: 142/255,
                blue: 204/255,
                alpha: 0.9
            )
        )
    }
    
    private func addSubViews() {
        view.addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(appNameLabel)
    }
    
    private func setupLayout() {
        labelStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
