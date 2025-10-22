//
//  MeasurementDetailViewController.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/21/25.
//

import UIKit
import SnapKit

final class MeasurementDetailViewController: UIViewController {
  private let viewModel: MeasurementDetailViewModel
  private let tableView = UITableView(frame: .zero, style: .grouped)
  
  init(viewModel: MeasurementDetailViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addViews()
    configureUI()
    addConsraints()
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.isNavigationBarHidden = false
  }
  
  private func addViews() {
    view.addSubview(tableView)
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray5
    
    tableView.backgroundColor = .systemGray5
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
  }
  
  private func addConsraints() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.8)
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func setupTableView() {
    tableView.register(
      PairMeasurementDetailCell.self,
      forCellReuseIdentifier: PairMeasurementDetailCell.identifier
    )
    tableView.register(
      SingleMeasurementDetailCell.self,
      forCellReuseIdentifier: SingleMeasurementDetailCell.identifier
    )
    
    tableView.dataSource = self
  }
}

extension MeasurementDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.measurementEntry.measurements.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = viewModel.measurementEntry.measurements[indexPath.row]
    
    switch item {
    case let pairMeasureMent as PairMeasurement:
      let cell = PairMeasurementDetailCell()
      cell.configure(with: pairMeasureMent)
      return cell
      
    case let singleMeasurement as SingleMeasurement:
      let cell = SingleMeasurementDetailCell()
      cell.configure(with: singleMeasurement)
      return cell
      
    default:
      return UITableViewCell()
    }
  }
}
