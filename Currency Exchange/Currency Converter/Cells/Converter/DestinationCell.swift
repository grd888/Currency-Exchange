//
//  DestinationCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import UIKit

protocol DestinationCellDelegate: AnyObject {
  func didTapCurrencyChange(_ cell: DestinationCell)
}
class DestinationCell: UITableViewCell {
  @IBOutlet weak var valueLabel: UILabel!
  @IBOutlet weak var currencyButton: UIButton!

  weak var delegate: DestinationCellDelegate?

  private var disposeBag = DisposeBag()

  @IBAction func buttonTapped(_ sender: Any) {
    delegate?.didTapCurrencyChange(self)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
}
