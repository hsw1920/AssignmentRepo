//
//  MeasurementKinds.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import Foundation

protocol MeasurementValue {
  var status: Status { get }
  var measurementType: MeasurementType { get }
}

struct ValueRange {
  let min: Double
  let max: Double
  let status: Status
}


struct SingleMeasurement: MeasurementValue {
  let measurementType: MeasurementType
  let value: Double
  let ranges: [ValueRange]
  
  var status: Status {
    if measurementType == .fourth {
      return value == 0.0 ? .negative : .positive
    }
    
    return ranges.first { range in
      value >= range.min && value < range.max
    }?.status ?? .danger
  }
}

struct PairMeasurement: MeasurementValue {
  let measurementType: MeasurementType
  let leftValue: Double
  let rightValue: Double
  let leftMinValue: Double
  let leftMaxValue: Double
  let rightMinValue: Double
  let rightMaxValue: Double
  let leftRanges: [ValueRange]
  let rightRanges: [ValueRange]
  
  var leftStatus: Status {
    return leftRanges.first { range in
      leftValue >= range.min && leftValue < range.max
    }?.status ?? .danger
  }
  
  var rightStatus: Status {
    return rightRanges.first { range in
      rightValue >= range.min && rightValue < range.max
    }?.status ?? .danger
  }
  
  var status: Status {
    return worse(leftStatus, rightStatus)
  }
  
  private func worse(_ a: Status, _ b: Status) -> Status {
    return rank(a) >= rank(b) ? a : b
  }
  
  private func rank(_ status: Status) -> Int {
    switch status {
    case .normal, .negative: return 0
    case .attention: return 1
    case .warning: return 2
    case .danger, .positive: return 3
    }
  }
}
