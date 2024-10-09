//
//  File.swift
//
//
//  Created by Junyoung on 9/5/24.
//

import UIKit
import SnapKit

protocol DistanceDelegate: AnyObject {
    func didSelectDistance(_ distance: Int)
}

final class DistancePickerViewController: UIViewController {

    private let distanceList = [100, 200, 300, 400, 500]
    private var selectedDistance: Int?
    var currentDistance: Int?

    private let pickerView = UIPickerView()
    private let confirmButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 8
    }

    weak var delegate: DistanceDelegate?

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
extension DistancePickerViewController {
    private func configuration() {
        view.backgroundColor = .gray.withAlphaComponent(0.9)

        pickerView.delegate = self
        pickerView.dataSource = self

        if let row = distanceList.firstIndex(where: {$0 == currentDistance}) {
            pickerView.selectRow(row, inComponent: 0, animated: true)
        }

        selectedDistance = currentDistance
    }

    private func addSubViews() {
        view.addSubview(confirmButton)
        view.addSubview(pickerView)
    }

    private func makeLayout() {
        pickerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmButton.snp.top)
        }

        confirmButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }

    private func addActions() {
        confirmButton.addAction(UIAction(handler: { [weak self] _ in
            guard let selectedDistance = self?.selectedDistance else { return }
            self?.delegate?.didSelectDistance(selectedDistance)
        }), for: .touchUpInside)
    }
}

// MARK: - UIPickerView Delegate & DataSource
extension DistancePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        distanceList.count
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        "\(distanceList[row])m"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDistance = distanceList[row]
    }
}
