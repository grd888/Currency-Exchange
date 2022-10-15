//
//  DestinationCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import UIKit

class DestinationCell: UITableViewCell {
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var currencyButton: UIButton!
  override func awakeFromNib() {
    super.awakeFromNib()
    currencyButton.setTitle("USD ", for: .normal)
    valueLabel.text = "+ 120.40"
  }
}
