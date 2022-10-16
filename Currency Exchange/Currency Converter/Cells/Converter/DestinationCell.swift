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

  private var viewModel: DestinationCellViewModel?
  private var disposeBag = DisposeBag()

  func configure(with viewModel: DestinationCellViewModel) {
    self.viewModel = viewModel
    viewModel.destinationCurrencyObservable
      .bind(to: currencyButton.rx.title(for: .normal))
      .disposed(by: disposeBag)
    viewModel.destinationCurrencyAmountObservable
      .bind(to: valueLabel.rx.text)
      .disposed(by: disposeBag)
  }

  @IBAction func buttonTapped(_ sender: Any) {
    delegate?.didTapCurrencyChange(self)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
}
