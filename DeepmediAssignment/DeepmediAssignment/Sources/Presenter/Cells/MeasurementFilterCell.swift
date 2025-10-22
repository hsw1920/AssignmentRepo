//
//  MeasurementFilterCell.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit
import SnapKit

final class MeasurementFilterCell: UICollectionViewCell {
  static let identifier = "MeasurementFilterCell"
  
  private let containerView = UIView()
  private let titleLabel = UILabel()
  private let countLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    countLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    
    containerView.layer.cornerRadius = 15
    containerView.backgroundColor = .systemGray5
    
    contentView.addSubview(containerView)
    containerView.addSubview(titleLabel)
    containerView.addSubview(countLabel)
    
    containerView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.height.equalTo(30)
      $0.horizontalEdges.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints {
      $0.verticalEdges.equalToSuperview()
      $0.leading.equalToSuperview().inset(12)
    }
    
    countLabel.snp.makeConstraints {
      $0.verticalEdges.equalToSuperview()
      $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
      $0.trailing.equalToSuperview().inset(12)
    }
  }
  
  func configure(with filterItem: MeasureFilterItem) {
    titleLabel.text = switch filterItem.status {
    case .normal: "정상"
    case .attention: "관심"
    case .warning: "경고"
    case .danger: "위험"
    case .negative: "음성"
    case .positive: "양성"
    }
    countLabel.text = "\(filterItem.count)"
    
    if filterItem.isSelected {
      containerView.backgroundColor = .black
      titleLabel.textColor = .white
      countLabel.textColor = .white
    } else {
      containerView.backgroundColor = .systemGray4
      titleLabel.textColor = .secondaryLabel
      countLabel.textColor = .secondaryLabel
    }
  }
}
