//
//  ReusableView.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension UIView: ReusableView {}

