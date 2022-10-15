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

    let userAccount = UserAccount(initialBalance: [.EUR: 1000])
    let viewModel = CurrencyConverterViewModel(userAccount: userAccount)
    let viewController = CurrencyConverterViewController(viewModel: viewModel)

    window.rootViewController = UINavigationController(rootViewController: viewController)
    window.makeKeyAndVisible()
    self.window = window
  }
}
