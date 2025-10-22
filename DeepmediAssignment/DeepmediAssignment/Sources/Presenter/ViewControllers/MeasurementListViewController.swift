//
//  MeasurementListViewController.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/20/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class MeasurementListViewController: UIViewController {
  private let filterView = MeasurementFilterView()
  private let measurementListTableView = UITableView(frame: .zero, style: .grouped)
  
  private let viewModel: MeasurementListViewModel
  
  private var sections: [DateSectionItem] = []
  
  private var disposeBag = DisposeBag()
  
  init(viewModel: MeasurementListViewModel) {
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
    bind()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.isNavigationBarHidden = true
  }
  
  private func addViews() {
    view.addSubview(measurementListTableView)
    view.addSubview(filterView)
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray5
   
    measurementListTableView.backgroundColor = .systemGray5
    measurementListTableView.separatorStyle = .none
    measurementListTableView.showsVerticalScrollIndicator = false
    
    filterView.onFilterTapped = { [weak self] status in
      self?.viewModel.toggleFilter(status)
    }
  }
  
  private func addConsraints() {
    filterView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(54)
    }
    
    measurementListTableView.snp.makeConstraints {
      $0.top.equalTo(filterView.snp.bottom)
      $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
    }
    
  }

  private func setupTableView() {
    measurementListTableView.register(
      MeasurementCell.self,
      forCellReuseIdentifier: MeasurementCell.identifier
    )
    measurementListTableView.register(
      MeasurementSectionHeaderView.self,
      forHeaderFooterViewReuseIdentifier: MeasurementSectionHeaderView.identifier
    )
    
    measurementListTableView.delegate = self
    measurementListTableView.dataSource = self
  }
  
  private func bind() {
    viewModel.filteredSectionItems
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onNext: { [weak self] sections in
          self?.sections = sections
          self?.measurementListTableView.reloadData()
        }
      )
      .disposed(by: disposeBag)
    
    viewModel.filterItems
      .observe(on: MainScheduler.asyncInstance)
      .subscribe(
        onNext: { [weak self] items in
          self?.filterView.configure(with: items)
          self?.measurementListTableView.reloadData()
        }
      )
      .disposed(by: disposeBag)
  }
}

extension MeasurementListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: MeasurementCell.identifier,
      for: indexPath
    ) as? MeasurementCell
    else { return UITableViewCell() }
    
    let item = sections[indexPath.section].items[indexPath.row]
    cell.configure(with: item)
    
    return cell
  }
}

extension MeasurementListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let header = tableView.dequeueReusableHeaderFooterView(
      withIdentifier: MeasurementSectionHeaderView.identifier
    ) as? MeasurementSectionHeaderView
    else { return nil }
    
    let item = sections[section].measureTime
    header.configure(with: item)
    
    return header
  }
  
  // TODO: - Navigation Push
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = sections[indexPath.section].items[indexPath.row]
    let measurementDetailViewModel = MeasurementDetailViewModel(measurementEntry: item)
    let measurementDetailViewController = MeasurementDetailViewController(viewModel: measurementDetailViewModel)
    navigationController?.pushViewController(measurementDetailViewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
}
