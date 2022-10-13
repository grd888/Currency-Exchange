//
//  ButtonCell.swift
//  Currency Exchange
//
//  Created by Greg Delgado on 10/13/22.
//

import UIKit

class ButtonCell: UITableViewCell {

    @IBOutlet var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        button.layer.cornerRadius = 25.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
