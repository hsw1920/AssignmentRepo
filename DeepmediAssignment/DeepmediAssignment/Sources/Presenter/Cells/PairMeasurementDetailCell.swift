//
//  PairMeasurementDetailCell.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/22/25.
//

import UIKit
import SnapKit

final class PairMeasurementDetailCell: UITableViewCell {
  static let identifier = "PairMeasurementDetailCell"
  
  private let containerView = UIView()
  private let statusMarkImageView = UIImageView()
  private let statusImageView = UIImageView()
  private let leftValueTitleLabel = UILabel()
  private let leftValueLabel = UILabel()
  private let leftRangesContainerView = MeasurementRangeView()
  private let rightValueTitleLabel = UILabel()
  private let rightValueLabel = UILabel()
  private let rightRangesContainerView = MeasurementRangeView()
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
    containerView.addSubview(leftValueTitleLabel)
    containerView.addSubview(leftValueLabel)
    containerView.addSubview(statusImageView)
    containerView.addSubview(leftRangesContainerView)
    containerView.addSubview(rightValueTitleLabel)
    containerView.addSubview(rightValueLabel)
    containerView.addSubview(rightRangesContainerView)
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
    
    statusMarkImageView.contentMode = .scaleAspectFit
    leftValueTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    leftValueLabel.font = .systemFont(ofSize: 24, weight: .bold)
    statusImageView.contentMode = .scaleAspectFit
    rightValueTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    rightValueLabel.font = .systemFont(ofSize: 24, weight: .bold)

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
    
    leftValueTitleLabel.snp.makeConstraints {
      $0.top.equalTo(statusMarkImageView.snp.bottom).offset(12)
      $0.leading.equalToSuperview().inset(12)
    }
    
    leftValueLabel.snp.makeConstraints {
      $0.top.equalTo(leftValueTitleLabel.snp.bottom).offset(12)
      $0.leading.equalToSuperview().inset(12)
    }
    
    statusImageView.snp.makeConstraints {
      $0.centerY.equalTo(leftValueLabel.snp.centerY)
      $0.width.equalTo(50)
      $0.trailing.equalToSuperview().inset(12)
    }
    
    leftRangesContainerView.snp.makeConstraints {
      $0.top.equalTo(leftValueLabel.snp.bottom).offset(36)
      $0.horizontalEdges.equalToSuperview().inset(12)
      $0.height.equalTo(100)
    }
    
    rightValueTitleLabel.snp.makeConstraints {
      $0.top.equalTo(leftRangesContainerView.snp.bottom).offset(36)
      $0.leading.equalToSuperview().inset(12)
    }
    
    rightValueLabel.snp.makeConstraints {
      $0.top.equalTo(rightValueTitleLabel.snp.bottom).offset(12)
      $0.leading.equalToSuperview().inset(12)
    }
    
    rightRangesContainerView.snp.makeConstraints {
      $0.top.equalTo(rightValueLabel.snp.bottom).offset(36)
      $0.horizontalEdges.equalToSuperview().inset(12)
      $0.height.equalTo(100)
    }
    
    statusDescriptionContainerView.snp.makeConstraints {
      $0.top.equalTo(rightRangesContainerView.snp.bottom).offset(36)
      $0.horizontalEdges.equalToSuperview().inset(12)
      $0.bottom.equalToSuperview().inset(24)
    }
    
    statusDescriptionLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(12)
    }
  }
  
  func configure(with item: PairMeasurement) {
    let statusMarkImage = UIImage(named: "\(item.status)Mark")
    let statusImage = UIImage(named: "\(item.status)")
    
    statusMarkImageView.image = statusMarkImage
    statusImageView.image = statusImage
    
    leftValueTitleLabel.text = "\(item.measurementType.leftTitle)"
    leftValueLabel.text = "\(Int(item.leftValue))"
    leftRangesContainerView.configure(value: item.leftValue, min: item.leftMinValue, max: item.leftMaxValue ,ranges: item.leftRanges)
    
    rightValueTitleLabel.text = "\(item.measurementType.rightTitle)"
    rightValueLabel.text = "\(Int(item.rightValue))"
    rightRangesContainerView.configure(value: item.rightValue, min: item.rightMinValue, max: item.rightMaxValue ,ranges: item.rightRanges)
    
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
