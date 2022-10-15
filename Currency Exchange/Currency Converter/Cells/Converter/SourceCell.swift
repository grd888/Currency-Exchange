//
//  SourceCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import UIKit

class SourceCell: UITableViewCell {
  @IBOutlet weak var currencyButton: UIButton!
  @IBOutlet weak var valueTextField: UITextField!

  override func awakeFromNib() {
    super.awakeFromNib()
    currencyButton.setTitle("EUR ", for: .normal)
    valueTextField.text = "1000.00"
  }
}
