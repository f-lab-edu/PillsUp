//
//  MainViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/2/24.
//

import ModernRIBs
import UIKit
import SnapKit
import Then
import Combine

protocol MainPresentableListener: AnyObject {
    func saveDistance(_ distance: Int)
    func viewLoaded()
}

final class MainViewController: UIViewController, MainPresentable, MainViewControllable {

    weak var listener: MainPresentableListener?
    var currentDistanceSubject = PassthroughSubject<Int, Never>()
    private var currentDistance: Int?
    
    private var cancellable = Set<AnyCancellable>()
    
    private let distanceButton = UIButton(type: .system).then {
        $0.setTitle("500m", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .gray.withAlphaComponent(0.4)
        $0.layer.cornerRadius = 8
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        listener?.viewLoaded()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        addSubViews()
        makeLayout()
        addActions()
        setSubscribe()
    }
    
    func setSubscribe() {
        currentDistanceSubject
            .sink { [weak self] distance in
                self?.distanceButton.setTitle("\(distance)m", for: .normal)
                self?.currentDistance = distance
            }
            .store(in: &cancellable)
    }
}

// MARK: - General Functions
extension MainViewController {
    private func addSubViews() {
        view.addSubview(distanceButton)
    }
    
    private func makeLayout() {
        distanceButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    private func addActions() {
        distanceButton.addAction(UIAction(handler: { [weak self] _ in
            let viewController = DistancePickerViewController()
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.delegate = self
            
            if let currentDistance = self?.currentDistance {
                viewController.currentDistance = currentDistance
            }
            
            self?.present(viewController, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - DistanceDelegate
extension MainViewController: DistanceDelegate {
    func didSelectDistance(_ distance: Int) {
        self.dismiss(animated: false)
        listener?.saveDistance(distance)
    }
}
