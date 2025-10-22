//
//  Status.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit

enum Status: String, CaseIterable {
  case normal
  case attention
  case warning
  case danger
  case negative
  case positive
}

extension Status {
  var color: UIColor {
    switch self {
    case .normal:
      return .systemBlue
    case .attention:
      return .systemGreen
    case .warning:
      return .systemYellow
    case .danger:
      return .systemRed
    case .positive, .negative:
      return .systemGray
    }
  }
}
