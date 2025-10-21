//
//  MeasurementCell.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit
import SnapKit

final class MeasurementCell: UITableViewCell {
  static let identifier = "MeasurementCell"
  
  private let timeLabel = UILabel()
  private let stackView = UIStackView()
  
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
    layer.cornerRadius = 8
    
    timeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    timeLabel.textColor = .secondaryLabel
    
    stackView.axis = .vertical
    stackView.spacing = 8
    
    stackView.backgroundColor = .systemGray6
    stackView.layer.borderWidth = 1
    stackView.layer.borderColor = UIColor.systemGray4.cgColor
    stackView.layer.cornerRadius = 8
    
    contentView.addSubview(timeLabel)
    contentView.addSubview(stackView)
    
    timeLabel.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.8)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview()
    }
    
    stackView.snp.makeConstraints {
      $0.width.equalToSuperview().multipliedBy(0.8)
      $0.centerX.equalToSuperview()
      $0.top.equalTo(timeLabel.snp.bottom).offset(12)
      $0.bottom.equalToSuperview().inset(16)
    }
  }
  
  func configure(with item: MeasurementEntry) {
    let timeLabelString = String(item.measureTime.prefix(5))
    timeLabel.text = timeLabelString
    
    // 기존 측정값 뷰들 제거
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    stackView.spacing = 12
    stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    stackView.isLayoutMarginsRelativeArrangement = true
    
    // 측정값들 추가
    for measurement in item.measurements {
      let measurementView = createMeasurementView(for: measurement)
      stackView.addArrangedSubview(measurementView)
    }
  }
  
  private func createMeasurementView(for measurement: MeasurementValue) -> UIView {
    let containerView = UIView()
    
    switch measurement {
    case let single as SingleMeasurement:
      let view = createSingleMeasurementView(single)
      containerView.addSubview(view)
      view.snp.makeConstraints {
        $0.verticalEdges.equalToSuperview()
        $0.horizontalEdges.equalToSuperview()
      }
      
    case let pair as PairMeasurement:
      let view = createPairMeasurementView(pair)
      containerView.addSubview(view)
      view.snp.makeConstraints {
        $0.verticalEdges.equalToSuperview()
        $0.horizontalEdges.equalToSuperview()
      }
    default:
      break
    }
    
    return containerView
  }
  
  private func createSingleMeasurementView(_ single: SingleMeasurement) -> UIView {
    let view = UIView()
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let statusImageView = UIImageView()
    
    titleLabel.text = "\(single.measurementType)"
    titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    titleLabel.textColor = .secondaryLabel

    valueLabel.text = single.measurementType == .third ? "\(Int(single.value))" : "\(single.value)"
    valueLabel.font = .systemFont(ofSize: 16, weight: .bold)
    valueLabel.textColor = .label
    
    let statusImage = UIImage(named: "\(single.status)Mark")
    statusImageView.image = statusImage
    statusImageView.contentMode = .scaleAspectFit
    
    view.addSubview(titleLabel)
    view.addSubview(valueLabel)
    view.addSubview(statusImageView)
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.verticalEdges.equalToSuperview()
    }
    
    valueLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(statusImageView.snp.leading).offset(-12)
    }
    
    statusImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.top.bottom.equalTo(titleLabel)
    }
    
    return view
  }

  private func createPairMeasurementView(_ pair: PairMeasurement) -> UIView {
    let view = UIView()
    let titleLabel = UILabel()
    let leftValueLabel = UILabel()
    let rightValueLabel = UILabel()
    let slashLabel = UILabel()
    let statusImageView = UIImageView()

    titleLabel.text = "\(pair.measurementType)"
    titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
    titleLabel.textColor = .secondaryLabel
    
    leftValueLabel.text = "\(Int(pair.leftValue))"
    leftValueLabel.font = .systemFont(ofSize: 16, weight: .bold)
    leftValueLabel.textColor = .label
    
    slashLabel.text = " / "
    slashLabel.font = .systemFont(ofSize: 16, weight: .bold)
    slashLabel.textColor = .label
    
    rightValueLabel.text = "\(Int(pair.rightValue))"
    rightValueLabel.font = .systemFont(ofSize: 16, weight: .bold)
    rightValueLabel.textColor = .label
    
    let statusImage = UIImage(named: "\(pair.status)Mark")
    statusImageView.image = statusImage
    statusImageView.contentMode = .scaleAspectFit
    
    view.addSubview(titleLabel)
    view.addSubview(leftValueLabel)
    view.addSubview(slashLabel)
    view.addSubview(rightValueLabel)
    view.addSubview(statusImageView)
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.verticalEdges.equalToSuperview()
    }
    
    leftValueLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(slashLabel.snp.leading)
    }
    
    slashLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(rightValueLabel.snp.leading)
    }
    
    rightValueLabel.snp.makeConstraints {
      $0.centerY.equalTo(titleLabel)
      $0.trailing.equalTo(statusImageView.snp.leading).offset(-12)
    }
    
    statusImageView.snp.makeConstraints {
      $0.trailing.equalToSuperview()
      $0.top.bottom.equalTo(titleLabel)
    }
    
    return view
  }
}
