//
//  UIViewController+NavigationBarCustomization.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

extension UIViewController {
    func setNavigationBarBackground() {
        guard let navigationController = navigationController,
              let gradientImage = CAGradientLayer.primaryGradient(on: navigationController.navigationBar) else {
            return
        }
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(patternImage: gradientImage)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.preferredFont(forTextStyle: .subheadline)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension CAGradientLayer {
    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let leftColor = UIColor(named: "ColorGradientBlueLeft")!
        let rightColor = UIColor(named: "ColorGradientBlueRight")!
        
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        var bounds = view.bounds
        bounds.size.height += statusBarHeight
        gradient.frame = view.bounds
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

