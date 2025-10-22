//
//  MeasurementType.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import Foundation

enum MeasurementType {
  case firstSecond
  case third
  case fourth
  
  var leftTitle: String {
    switch self {
    case .firstSecond: return "FIRST"
    default: return "NONE"
    }
  }
  
  var rightTitle: String {
    switch self {
    case .firstSecond: return "SECOND"
    default: return "NONE"
    }
  }
  
  var title: String {
    switch self {
    case .firstSecond: return "FIRST/SECOND"
    case .third: return "THIRD"
    case .fourth: return "FOURTH"
    }
  }
}

struct MeasurementConfig {
  let name: String
  let ranges: [ValueRange]
  
  func getStatus(for value: Double) -> Status {
    return ranges.first { range in
      value >= range.min && value < range.max
    }?.status ?? .danger
  }
}

struct ValueRange {
  let min: Double
  let max: Double
  let status: Status
}
