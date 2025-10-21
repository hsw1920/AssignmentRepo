//
//  SingleMeasurementDetailCell.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/22/25.
//

import UIKit
import SnapKit

final class SingleMeasurementDetailCell: UITableViewCell {
  static let identifier = "SingleMeasurementDetailCell"
  
  private let containerView = UIView()
  private let statusMarkImageView = UIImageView()
  private let valueTitleLabel = UILabel()
  private let valueLabel = UILabel()
  private let statusImageView = UIImageView()
  private let statusDescriptionContainerView = UIView()
  private let statusDescriptionLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addViews()
    configureUI()
    addConsraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addViews() {
    contentView.addSubview(containerView)
    
    containerView.addSubview(statusMarkImageView)
    containerView.addSubview(valueTitleLabel)
    containerView.addSubview(valueLabel)
    containerView.addSubview(statusImageView)
    containerView.addSubview(statusDescriptionContainerView)
    
    statusDescriptionContainerView.addSubview(statusDescriptionLabel)
  }
  
  private func configureUI() {
    selectionStyle = .none
    backgroundColor = .systemGray5
    containerView.backgroundColor = .systemGray6
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.systemGray4.cgColor
    containerView.layer.cornerRadius = 8
    
    statusImageView.contentMode = .scaleAspectFit
    valueTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    valueLabel.font = .systemFont(ofSize: 24, weight: .bold)
    statusMarkImageView.contentMode = .scaleAspectFit
    statusDescriptionLabel.font = .systemFont(ofSize: 14, weight: .medium)
    statusDescriptionLabel.textColor = .darkGray
    statusDescriptionLabel.textAlignment = .center
    statusDescriptionContainerView.backgroundColor = .systemCyan
    statusDescriptionContainerView.layer.cornerRadius = 8
  }
  
  private func addConsraints() {
    containerView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(24)
      $0.horizontalEdges.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-36)
    }
    
    statusMarkImageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().inset(12)
      $0.height.equalTo(50)
    }
    
    valueTitleLabel.snp.makeConstraints {
      $0.top.equalTo(statusMarkImageView.snp.bottom).offset(12)
      $0.leading.equalToSuperview().inset(12)
    }
    
    valueLabel.snp.makeConstraints {
      $0.top.equalTo(valueTitleLabel.snp.bottom).offset(12)
      $0.leading.equalToSuperview().inset(12)
    }
    
    statusImageView.snp.makeConstraints {
      $0.centerY.equalTo(valueLabel.snp.centerY)
      $0.width.equalTo(50)
      $0.trailing.equalToSuperview().inset(12)
    }
    
    statusDescriptionContainerView.snp.makeConstraints {
      $0.top.equalTo(valueLabel.snp.bottom).offset(36)
      $0.horizontalEdges.equalToSuperview().inset(12)
      $0.bottom.equalToSuperview().inset(24)
    }
    
    statusDescriptionLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(12)
    }
  }
  
  func configure(with item: SingleMeasurement) {
    let statusMarkImage = UIImage(named: "\(item.status)Mark")
    statusMarkImageView.image = statusMarkImage
    
    valueTitleLabel.text = "\(item.measurementType)"

    if item.measurementType == .fourth {
      valueLabel.text = "\(item.value)"
    } else {
      valueLabel.text = "\(Int(item.value))"
    }
    
    let statusImage = UIImage(named: "\(item.status)")
    statusImageView.image = statusImage
    
    statusDescriptionLabel.text = switch item.status {
    case .normal: "정상 범위 입니다."
    case .attention: "관심 범위 입니다."
    case .warning: "경고 범위 입니다."
    case .danger: "위험 범위입니다."
    case .negative: "음성 범위 입니다."
    case .positive: "양성 범위입니다."
    }
  }
}
