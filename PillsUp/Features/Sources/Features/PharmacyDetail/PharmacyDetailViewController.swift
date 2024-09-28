//
//  PharmacyDetailViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import ModernRIBs
import UIKit
import Combine
import Domain

protocol PharmacyDetailPresentableListener: AnyObject {
    func onTapBack()
}

final class PharmacyDetailViewController: UIViewController, PharmacyDetailPresentable, PharmacyDetailViewControllable {
    
    var pharmacyDetail = PassthroughSubject<Domain.PharmacyDetail, Never>()
    weak var listener: PharmacyDetailPresentableListener?
    private var cancellable = Set<AnyCancellable>()
    
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
        setSubscribe()
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
    
    private func setSubscribe() {
        pharmacyDetail
            .sink { detail in
                print(detail)
            }
            .store(in: &cancellable)
    }
}
