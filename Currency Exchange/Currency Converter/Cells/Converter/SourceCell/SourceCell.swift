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

  override func awakeFromNib() {
    super.awakeFromNib()
    valueTextField.keyboardType = .decimalPad
    valueTextField.clearButtonMode = .always
    valueTextField.delegate = self
  }

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

extension SourceCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let inputText = textField.text ?? ""
    guard let inputRange = Range(range, in: inputText) else { return false }
    let updatedText = inputText.replacingCharacters(in: inputRange, with: string)
    return viewModel?.validateInputAmount(updatedText) ?? false
  }
}
