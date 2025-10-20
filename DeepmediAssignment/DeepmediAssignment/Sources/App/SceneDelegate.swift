//
//  SceneDelegate.swift
//  DeepmediAssignment
//
//  Created by 홍승완 on 10/20/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    let measurementListViewModel = MeasurementListViewModel()
    let rootViewController = MeasurementListViewController(viewModel: measurementListViewModel)
    let navigationController = UINavigationController(rootViewController: rootViewController)
    
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
}

