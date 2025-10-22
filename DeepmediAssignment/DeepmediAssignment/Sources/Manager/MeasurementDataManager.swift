//
//  MeasurementDataManager.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/20/25.
//

import Foundation

final class MeasurementDataManager {
  /// 주어진 dummy 형식대로 처리하기
  
  func process(with dummys: [[String: [TargetItem]]]) -> [DateSectionItem] {
    
    let sortedDates = getAllSortedDates(with: dummys)
    let timeDicts = getTimeDict(with: dummys)
    
    return sortedDates.compactMap { getDateSectionItem(for: $0, using: timeDicts) }
  }
  
  private func getAllSortedDates(with dummys: [[String: [TargetItem]]]) -> [String] {
    let allDates = Set(dummys[0].keys)
      .union(dummys[1].keys)
      .union(dummys[2].keys)
      .union(dummys[3].keys)
    
    return allDates.sorted {
      let day1 = Int($0.split(separator: " ").first ?? "") ?? 0
      let day2 = Int($1.split(separator: " ").first ?? "") ?? 0
      return day1 > day2
    }
  }
  
  private func getDateSectionItem(
    for date: String,
    using timeDicts: [[String: [String: Double]]]
  ) -> DateSectionItem? {
    let dict1 = timeDicts[0]
    let dict2 = timeDicts[1]

    let pairTimes = Set(dict1[date, default: [:]].keys)
      .intersection(dict2[date, default: [:]].keys)
    
    let entries = pairTimes.sorted(by: >).compactMap { time in
      getMeasurementEntry(
        for: time,
        on: date,
        using: timeDicts
      )
    }
    
    return DateSectionItem(measureTime: date, items: entries)
  }
  
  private func getMeasurementEntry(
    for time: String,
    on date: String,
    using timeDicts: [[String: [String: Double]]]
  ) -> MeasurementEntry? {
    guard let v1 = timeDicts[0][date, default: [:]][time],
          let v2 = timeDicts[1][date, default: [:]][time]
    else { return nil }
    
    var measurements: [MeasurementValue] = [
      createPairMeasurement(leftValue: v1, rightValue: v2)
    ]
    
    // 3번 데이터 추가
    if let v3 = timeDicts[2][date, default: [:]][time] {
      measurements.append(createThirdMeasurement(value: v3))
    }
    
    // 4번 데이터 추가
    if let v4 = timeDicts[3][date, default: [:]][time] {
      measurements.append(createFourthMeasurement(value: v4))
    }
    
    return MeasurementEntry(measureTime: time, measurements: measurements)
  }
  
  private func getTimeDict(with dummys: [[String: [TargetItem]]]) -> [[String: [String: Double]]] {
    return [timeDict(dummys[0]), timeDict(dummys[1]), timeDict(dummys[2]), timeDict(dummys[3])]
  }
  
  private func timeDict(_ dict: [String: [TargetItem]]) -> [String: [String: Double]] {
    var result = [String: [String: Double]]()
    for (date, items) in dict {
      var timeMap: [String: Double] = [:]
      for item in items {
        timeMap[item.measureTime] = item.value
      }
      result[date] = timeMap
    }
    
    return result
  }
}

// MARK: - Measurement Creation

extension MeasurementDataManager {
  private func createPairMeasurement(leftValue: Double, rightValue: Double) -> PairMeasurement {
    return PairMeasurement(
      measurementType: .firstSecond,
      leftValue: leftValue,
      rightValue: rightValue,
      leftMinValue: 100,
      leftMaxValue: 150,
      rightMinValue: 60,
      rightMaxValue: 110,
      leftRanges: [
        ValueRange(min: 100, max: 120, status: .normal),
        ValueRange(min: 120, max: 125, status: .attention),
        ValueRange(min: 126, max: 135, status: .warning),
      ],
      rightRanges: [
        ValueRange(min: 60, max: 75, status: .normal),
        ValueRange(min: 75, max: 90, status: .attention),
        ValueRange(min: 91, max: 100, status: .warning),
      ]
    )
  }
  
  private func createThirdMeasurement(value: Double) -> SingleMeasurement {
    return SingleMeasurement(
      measurementType: .third,
      value: value,
      ranges: [
        ValueRange(min: 20, max: 35, status: .normal),
        ValueRange(min: 36, max: 45, status: .attention),
        ValueRange(min: 46, max: 50, status: .warning),
      ]
    )
  }
  
  private func createFourthMeasurement(value: Double) -> SingleMeasurement {
    return SingleMeasurement(
      measurementType: .fourth,
      value: value,
      ranges: [
        ValueRange(min: 0.0, max: 0.0, status: .positive),
      ]
    )
  }
}
