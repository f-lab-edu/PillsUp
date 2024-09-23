//
//  PharmacyTableViewCell.swift
//
//
//  Created by Junyoung on 9/23/24.
//

import UIKit
import SnapKit
import Then
import Domain

final class PharmacyTableViewCell: UITableViewCell {
    
    private let emojiLabel = UILabel().then {
        $0.text = "📍"
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
    }
    
    private let distanceLabel = UILabel().then {
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        addSubViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .white
    }
    
    private func addSubViews() {
        contentView.addSubview(emojiLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(distanceLabel)
    }
    
    private func setupLayout() {
        
        emojiLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(emojiLabel.snp.right).offset(4)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(12)
        }
    }
    
    func bind(_ data: Pharmacy) {
        titleLabel.text = data.dutyName
        distanceLabel.text = convertToMeters(from: data.distance)
    }
    
    private func convertToMeters(from distance: String) -> String {
        guard let distance = Double(distance) else { return "거리를 표기할 수 없습니다." }
        let convertMeter = distance * 1000
        
        if convertMeter > 1000 {
            return "\(distance)km"
        } else {
            return "\(Int(convertMeter))m"
        }
    }
}
