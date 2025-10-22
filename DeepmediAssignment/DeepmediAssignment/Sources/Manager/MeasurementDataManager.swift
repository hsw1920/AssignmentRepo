//
//  MeasurementDataManager.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/20/25.
//

import Foundation

final class MeasurementDataManager {
  /// 주어진 dummy 형식대로 처리하기
  func process(
    first: [String: [TargetItem]],
    second: [String: [TargetItem]],
    third: [String: [TargetItem]],
    fourth: [String: [TargetItem]],
  ) -> [DateSectionItem] {
    let allDate = Set(first.keys)
      .union(second.keys)
      .union(third.keys)
      .union(fourth.keys)
    
    // 날짜 최신순 정렬
    let sortedAllDate = allDate.sorted {
      Int($0.split(separator: " ").first ?? "") ?? 0 > Int($1.split(separator: " ").first ?? "") ?? 0
    }
    
    let dict1 = timeDict(first)
    let dict2 = timeDict(second)
    let dict3 = timeDict(third)
    let dict4 = timeDict(fourth)
    
    var dateSectionItems: [DateSectionItem] = []
    
    for date in sortedAllDate {
      /// 1, 2번 데이터는 항상 쌍을 이뤄야함.
      let pairDatas = Set(dict1[date, default: [:]].keys)
        .intersection(dict2[date, default: [:]].keys)
      
      var entries: [MeasurementEntry] = []
      
      // 시간 최신순 정렬
      for time in pairDatas.sorted(by: >) {
        guard let v1 = dict1[date, default: [:]][time],
              let v2 = dict2[date, default: [:]][time]
        else { continue }

        let pairData = PairMeasurement(
          measurementType: .firstSecond,
          leftValue: v1,
          rightValue: v2,
          leftMinValue: 100, // 요구 사항 X 임의 지정
          leftMaxValue: 150, // 요구 사항 X 임의 지정
          rightMinValue: 60, // 요구 사항 X 임의 지정
          rightMaxValue: 110, // 요구 사항 X 임의 지정
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
        var entry = MeasurementEntry(measureTime: time, measurements: [pairData])
        
        if let v3 = dict3[date, default: [:]][time] {
          let singleData = SingleMeasurement(
            measurementType: .third,
            value: v3,
            ranges: [
              ValueRange(min: 20, max: 35, status: .normal),
              ValueRange(min: 36, max: 45, status: .attention),
              ValueRange(min: 46, max: 50, status: .warning),
            ]
          )
          entry.measurements.append(singleData)
        }
        
        if let v4 = dict4[date, default: [:]][time] {
          let singleData = SingleMeasurement(
            measurementType: .fourth,
            value: v4,
            ranges: [
              ValueRange(min: 0.0, max: 0.0, status: .positive),
            ]
          )
          entry.measurements.append(singleData)
        }
        
        entries.append(entry)
      }
      
      let dateSectionItem = DateSectionItem(measureTime: date, items: entries)
      dateSectionItems.append(dateSectionItem)
    }
    
    return dateSectionItems
  }
  
  // [날짜: [시간: 값]] ex. ["4 금요일": ["21:25:22.054+0900": 120, "19:03:32.702+0900": 119, ... ], ...]
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
