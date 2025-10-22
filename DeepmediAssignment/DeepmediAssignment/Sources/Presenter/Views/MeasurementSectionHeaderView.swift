//
//  MeasurementSectionHeaderView.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit
import SnapKit

final class MeasurementSectionHeaderView: UITableViewHeaderFooterView {
  static let identifier = "MeasurementSectionHeaderView"
  
  private let containerView = UIView()
  private let dayLabel = UILabel()
  private let weekLabel = UILabel()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.backgroundColor = .systemGray5
    
    dayLabel.font = .systemFont(ofSize: 17, weight: .bold)
    weekLabel.font = .systemFont(ofSize: 17, weight: .regular)
    
    contentView.addSubview(containerView)
    containerView.addSubview(dayLabel)
    containerView.addSubview(weekLabel)
    
    containerView.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.8)
      $0.center.equalToSuperview()
    }
    
    dayLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
    
    weekLabel.snp.makeConstraints {
      $0.leading.equalTo(dayLabel.snp.trailing).offset(4)
      $0.centerY.equalToSuperview()
    }
  }
  
  func configure(with dateString: String) {
    let stringArray = dateString.split(separator: " ").map { String($0) }
    guard stringArray.count == 2 else { return }
    
    dayLabel.text = stringArray[0]
    weekLabel.text = stringArray[1]
  }
}
