//
//  CurrencyConverterViewController.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class CurrencyConverterViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarBackground()
        tableView.register(BalancesCell.self, forCellReuseIdentifier: BalancesCell.reuseIdentifier)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setNavigationBarBackground()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BalancesCell.reuseIdentifier, for: indexPath) as! BalancesCell
            return cell
        case 1:
            return currencyCell(tableView, indexPath: indexPath)
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier, for: indexPath)
            return cell
        default:
            fatalError()
        }
    }
    
    func currencyCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationCell", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "MY BALANCES"
        case 1:
            return "CURRENCY EXCHANGE"
        default:
            return nil
        }
        
    }
}
