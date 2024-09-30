//
//  PharmacyDetailViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import UIKit

protocol PharmacyDetailPresentableListener: AnyObject {
    func onTapBack()
}

final class PharmacyDetailViewController: UIViewController, PharmacyDetailPresentable, PharmacyDetailViewControllable {

    weak var listener: PharmacyDetailPresentableListener?
    
    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .gray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configuration()
        addSubViews()
        makeLayout()
        addActions()
    }
}

// MARK: - General Functions
extension PharmacyDetailViewController {
    private func configuration() {
        view.backgroundColor = .white
    }
    
    private func addSubViews() {
        view.addSubview(backButton)
    }
    
    private func makeLayout() {
        backButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.left.equalToSuperview().inset(16)
        }
    }
    
    private func addActions() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.listener?.onTapBack()
        }), for: .touchUpInside)
    }
}
