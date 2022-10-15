//
//  SceneDelegate.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    let window = UIWindow(windowScene: windowScene)
    let viewController = CurrencyConverterViewController.instantiate()
    viewController.viewModel = CurrencyConverterViewModel()

    window.rootViewController = UINavigationController(rootViewController: viewController)
    window.makeKeyAndVisible()
    self.window = window
  }
}
