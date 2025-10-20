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
  private let recordListTableView = UITableView()
  
  private let viewModel: MeasurementListViewModel
  
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
  }
  
  private func addViews() {
    view.addSubview(recordListTableView)
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray3
   
    recordListTableView.backgroundColor = .systemGray6
  }
  
  private func addConsraints() {
    recordListTableView.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }

}
