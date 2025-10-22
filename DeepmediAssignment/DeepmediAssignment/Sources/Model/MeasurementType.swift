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

struct ValueRange {
  let min: Double
  let max: Double
  let status: Status
}
