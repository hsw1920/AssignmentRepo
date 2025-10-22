//
//  MeasurementRangeView.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/22/25.
//

import UIKit
import SnapKit

final class MeasurementRangeView: UIView {
  private let containerView = UIView()
  private let rangeStackView = UIStackView()
  private let currentPinView = UIView()
  private let minValueLabel = UILabel()
  private let maxValueLabel = UILabel()
  
  private var rangeSegmentViews: [UIView] = []
  private var valueLabelViews: [UILabel] = []
  
  private var valueRanges: [ValueRange] = []
  private var totalMinValue: Double = 0
  private var totalMaxValue: Double = 0
  private var currentValue: Double = 0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    minValueLabel.font = .systemFont(ofSize: 12, weight: .medium)
    minValueLabel.textColor = .secondaryLabel
    maxValueLabel.font = .systemFont(ofSize: 12, weight: .medium)
    maxValueLabel.textColor = .secondaryLabel
    
    rangeStackView.layer.cornerRadius = 3
    rangeStackView.clipsToBounds = true
    rangeStackView.axis = .horizontal
    rangeStackView.distribution = .equalSpacing
   
    currentPinView.backgroundColor = .systemBlue
    currentPinView.layer.borderWidth = 3
    currentPinView.layer.borderColor = UIColor.white.cgColor
    currentPinView.layer.cornerRadius = 8

    addSubview(containerView)
    addSubview(currentPinView)
    containerView.addSubview(rangeStackView)
    containerView.addSubview(minValueLabel)
    containerView.addSubview(maxValueLabel)
    
    containerView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    minValueLabel.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview()
    }
    
    maxValueLabel.snp.makeConstraints {
      $0.trailing.bottom.equalToSuperview()
    }
    
    rangeStackView.snp.makeConstraints {
      $0.leading.equalTo(minValueLabel.snp.centerX)
      $0.trailing.equalTo(maxValueLabel.snp.centerX)
      $0.top.equalToSuperview()
      $0.height.equalTo(6)
    }
    
    currentPinView.snp.makeConstraints {
      $0.width.height.equalTo(16)
      $0.centerY.equalTo(rangeStackView.snp.centerY)
      $0.centerX.equalTo(rangeStackView.snp.leading)
    }
  }
  
  public func configure(value: Double, min: Double, max: Double, ranges: [ValueRange]) {
    self.currentValue = value
    self.valueRanges = ranges.sorted { $0.min < $1.min }
    self.totalMaxValue = max
    self.totalMinValue = min
    
    configSegments()
    configValueLabels()
  }
  
  private func configSegments() {
    guard let lastRange = valueRanges.last else { return }
    
    let totalRangeWidth = totalMaxValue - totalMinValue
    var allSegments: [ValueRange] = valueRanges
    allSegments.append(ValueRange(min: lastRange.max, max: totalMaxValue, status: .danger))
    
    for segment in allSegments {
      let segmentView = UIView()
      segmentView.backgroundColor = segment.status.color
      let segmentWidth = segment.max - segment.min
      let widthPercentage = segmentWidth / totalRangeWidth
      rangeSegmentViews.append(segmentView)
      rangeStackView.addArrangedSubview(segmentView)
      segmentView.snp.makeConstraints {
        $0.width.equalTo(rangeStackView.snp.width).multipliedBy(widthPercentage)
      }
    }
  }
  
  private func configValueLabels() {
  }
}
