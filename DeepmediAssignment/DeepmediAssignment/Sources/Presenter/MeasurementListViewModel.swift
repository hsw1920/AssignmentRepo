//
//  MeasurementListViewModel.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/20/25.
//

import RxSwift
import RxCocoa

final class MeasurementListViewModel {
  private let manager = MeasurementDataManager()
  private let originSectionItems = BehaviorRelay<[DateSectionItem]>(value: [])
  
  let filteredSectionItems = BehaviorRelay<[DateSectionItem]>(value: [])
  let filterItems = BehaviorRelay<[MeasureFilterItem]>(value: [])
  
  private var disposeBag = DisposeBag()
  
  init() {
    let sectionItems = manager.process(
      first: dummy1,
      second: dummy2,
      third: dummy3,
      fourth: dummy4
    )
    
    originSectionItems.accept(sectionItems)
    
    Observable
      .combineLatest(originSectionItems, filterItems)
      .map { [weak self] sections, filters in
        guard let self else { return sections }
        return self.filterSections(sections, by: filters)
      }
      .bind(to: filteredSectionItems)
      .disposed(by: disposeBag)
    
    originSectionItems
      .map { [weak self] sections in
        guard let self else { return [] }
        return generateFilterItems(from: sections)
      }
      .bind(to: filterItems)
      .disposed(by: disposeBag)
  }
  
  func toggleFilter(_ item: MeasureFilterItem) {
    var filterItems = filterItems.value
    if let index = filterItems.firstIndex(where: { $0.status == item.status }) {
      filterItems[index].isSelected.toggle()
    }
    self.filterItems.accept(filterItems)
  }

  private func filterSections(_ sections: [DateSectionItem], by filters: [MeasureFilterItem]) -> [DateSectionItem] {
    let selectedFilters = Set(filters.filter { $0.isSelected }.map { $0.status })
    
    if selectedFilters.isEmpty { return sections }
    
    return sections.compactMap { section in
      let filteredItems = section.items.compactMap { entry -> MeasurementEntry? in
        let isContained = entry.measurements.contains { selectedFilters.contains($0.status) }
        return isContained ? entry : nil
      }
      
      return filteredItems.isEmpty ? nil : DateSectionItem(measureTime: section.measureTime, items: filteredItems)
    }
  }
  
  private func generateFilterItems(from sections: [DateSectionItem]) -> [MeasureFilterItem] {
    let selectedFilters = Set(filterItems.value.filter { $0.isSelected }.map { $0.status })
    let statusCounts = sections.flatMap { $0.items }
      .flatMap { $0.measurements }
      .map { $0.status }
      .reduce(into: [Status: Int]()) { counts, status in
        counts[status, default: 0] += 1
      }
    
    return Status.allCases.map { status in
      MeasureFilterItem(
        status: status,
        count: statusCounts[status] ?? 0,
        isSelected: selectedFilters.contains(status)
      )
    }
  }
}
