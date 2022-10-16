//
//  SourceCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import UIKit

protocol SourceCellDelegate: AnyObject {
  func didTapCurrencyChange(_ cell: SourceCell)
}
class SourceCell: UITableViewCell {
  @IBOutlet weak var currencyButton: UIButton!
  @IBOutlet weak var valueTextField: UITextField!

  weak var delegate: SourceCellDelegate?

  private var viewModel: SourceCellViewModel?
  private var disposeBag = DisposeBag()

  func configure(with viewModel: SourceCellViewModel) {
    self.viewModel = viewModel
    viewModel.sourceCurrencyObservable
      .bind(to: currencyButton.rx.title(for: .normal))
      .disposed(by: disposeBag)
    viewModel.sourceCurrencyAmountObservable
      .bind(to: valueTextField.rx.text)
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
