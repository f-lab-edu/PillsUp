//
//  PharmacyDetailViewController.swift
//  PillsUp
//
//  Created by Junyoung on 9/25/24.
//

import Combine
import UIKit

import ModernRIBs
import SnapKit
import Then

import Domain

protocol PharmacyDetailPresentableListener: AnyObject {
    func onTapBack()
}

final class PharmacyDetailViewController: UIViewController, PharmacyDetailPresentable, PharmacyDetailViewControllable {

    var pharmacyDetail = PassthroughSubject<Domain.PharmacyDetail, Never>()
    weak var listener: PharmacyDetailPresentableListener?
    private var cancellable = Set<AnyCancellable>()

    private let headerView = UIView()
    private let contentView = UIView()

    private let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .gray
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .left
    }

    private let locationLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    private let phoneNumberLabel = UILabel().then {
        $0.textColor = .black
    }

    let openingHoursStackView = UIStackView().then {
        $0.axis = .vertical
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
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)

        view.addSubview(contentView)
        contentView.addSubview(locationLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(openingHoursStackView)
    }

    private func makeLayout() {

        // Header
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        backButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.left.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(8)
            make.right.equalToSuperview()
            make.centerY.equalTo(backButton.snp.centerY)
        }

        // Content
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        phoneNumberLabel.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        openingHoursStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
    }

    private func addActions() {
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.listener?.onTapBack()
        }), for: .touchUpInside)
    }

    private func setSubscribe() {
        pharmacyDetail
            .sink { [weak self] detail in
                self?.bind(detail)
            }
            .store(in: &cancellable)
    }

    private func bind(_ data: PharmacyDetail) {
        DispatchQueue.main.async {
            self.titleLabel.text = data.dutyName
            self.locationLabel.text = "📍 위치 : \(data.dutyAddr)"
            self.phoneNumberLabel.text = "☎️ 전화번호 : \(data.dutyTel)"

            data.dutyTimes.forEach { dutyTime in
                let dutyView = UIView()
                let titleLabel = UILabel().then {
                    $0.textColor = .black
                }
                let dutyTimeLabel = UILabel().then {
                    $0.textColor = .black
                }

                dutyView.addSubview(titleLabel)
                dutyView.addSubview(dutyTimeLabel)

                dutyView.snp.makeConstraints { make in
                    make.height.equalTo(50)
                }

                titleLabel.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().offset(16)
                }

                dutyTimeLabel.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.right.equalToSuperview().inset(16)
                }

                titleLabel.text = dutyTime.weekDay.toString
                dutyTimeLabel.text = dutyTime.displayTime()

                self.openingHoursStackView.addArrangedSubview(dutyView)
            }
        }
    }

    func fetchDetailFailure() {
        DispatchQueue.main.async {
            self.titleLabel.text = "알 수 없음"
        }
    }
}
