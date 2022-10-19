//
//  BalancesCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import RxSwift
import UIKit

class BalancesCell: UITableViewCell {
  private let itemHeight = 44.0
  private var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(CurrencyBalanceCell.self, forCellWithReuseIdentifier: CurrencyBalanceCell.reuseIdentifier)
    return collectionView
  }()
  private var viewModel: BalancesCellViewModel?
  private var disposeBag = DisposeBag()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    customInit()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with viewModel: BalancesCellViewModel) {
    self.viewModel = viewModel
    // swiftlint:disable trailing_closure
    viewModel.currentBalance.subscribe(onNext: { [weak self] _ in
      self?.collectionView.reloadData()
    })
    .disposed(by: disposeBag)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }
}

extension BalancesCell {
  private func customInit() {
    contentView.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: itemHeight)
    ])
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}

extension BalancesCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel?.numberOfItems() ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: CurrencyBalanceCell.reuseIdentifier,
      // swiftlint:disable:next force_cast
      for: indexPath) as! CurrencyBalanceCell
    cell.title = viewModel?.item(forIndex: indexPath.item)
    return cell
  }
}

extension BalancesCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let text = viewModel?.item(forIndex: indexPath.item) ?? ""
    let size = text.size(withAttributes: CurrencyBalanceCell.textAttributes)
    return CGSize(width: size.width + 16, height: itemHeight)
  }
}
