//
//  SourceCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/15/22.
//

import RxSwift
import RxCocoa
import UIKit

class SourceCell: UITableViewCell {
  @IBOutlet weak var currencyButton: UIButton!
  @IBOutlet weak var valueTextField: UITextField!

  private var viewModel: SourceCellViewModel?
  private var disposeBag = DisposeBag()

  func configure(with viewModel: SourceCellViewModel) {
    self.viewModel = viewModel
    viewModel.sourceCurrencyObservable
      .bind(to: currencyButton.rx.title(for: .normal))
      .disposed(by: disposeBag)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
}
