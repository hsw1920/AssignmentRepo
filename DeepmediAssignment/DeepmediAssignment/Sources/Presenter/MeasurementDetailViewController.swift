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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.isNavigationBarHidden = false
  }
  
  private func addViews() {
    
  }
  
  private func configureUI() {
    view.backgroundColor = .systemGray5
  }
  
  private func addConsraints() {
    
  }
}
