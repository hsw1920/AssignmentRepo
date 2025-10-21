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
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    selectionStyle = .none
    backgroundColor = .systemGray5
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.systemGray4.cgColor
    contentView.layer.cornerRadius = 8
  }
  
  func configure(with item: SingleMeasurement) {
    contentView.backgroundColor = .systemGreen
  }
}
