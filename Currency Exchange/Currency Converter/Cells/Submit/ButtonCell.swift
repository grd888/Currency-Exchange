//
//  ButtonCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import RxSwift
import UIKit

class ButtonCell: UITableViewCell {
  @IBOutlet var button: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()
    button.layer.cornerRadius = 22.0
  }

  private var disposeBag = DisposeBag()
  private var viewModel: ButtonCellViewModel?

  func configure(with viewModel: ButtonCellViewModel) {
    self.viewModel = viewModel
    viewModel.enableButtonObservable
      .bind(to: button.rx.isEnabled)
      .disposed(by: disposeBag)
    viewModel.enableButtonObservable
      .subscribe(onNext: updateButtonAppearance)
      .disposed(by: disposeBag)
    button.rx.tap
      .bind(to: viewModel.buttonTapSubject)
      .disposed(by: disposeBag)
  }

  private func updateButtonAppearance(_ enabled: Bool) {
    let backgroundColor = enabled ? UIColor(named: "ColorGradientBlueLeft") : UIColor(named: "ColorDisabled")
    button.backgroundColor = backgroundColor
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
}
