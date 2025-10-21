//
//  MeasurementFilterView.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit
import SnapKit

struct MeasureFilterItem {
  let status: Status
  let count: Int
  var isSelected: Bool
}

final class MeasurementFilterView: UIView {
  private let collectionView: UICollectionView
  private var filterItems: [MeasureFilterItem] = []
  
  var onFilterTapped: ((MeasureFilterItem) -> Void)?
  
  override init(frame: CGRect) {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumInteritemSpacing = 8
    layout.sectionInset = UIEdgeInsets(top: 12, left: UIScreen.main.bounds.width * 0.1, bottom: 12, right: UIScreen.main.bounds.width * 0.1)
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    backgroundColor = .clear
    
    collectionView.backgroundColor = .clear
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(MeasurementFilterCell.self, forCellWithReuseIdentifier: MeasurementFilterCell.identifier)
    
    addSubview(collectionView)
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  func configure(with filterItems: [MeasureFilterItem]) {
    self.filterItems = filterItems
    collectionView.reloadData()
  }
}
  
extension MeasurementFilterView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filterItems.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MeasurementFilterCell.identifier, for: indexPath) as! MeasurementFilterCell
    let filterItem = filterItems[indexPath.item]
    cell.configure(with: filterItem)
    return cell
  }
}

extension MeasurementFilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let filterItem = filterItems[indexPath.item]
    onFilterTapped?(filterItem)
  }
}
