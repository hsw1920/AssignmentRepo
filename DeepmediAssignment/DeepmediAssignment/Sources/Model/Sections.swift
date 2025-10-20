//
//  Sections.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import Foundation

struct DateSectionItem {
  let measureTime: String
  var items: [MeasurementEntry]
}

struct MeasurementEntry {
  let measureTime: String
  var measurements: [MeasurementValue]
}
