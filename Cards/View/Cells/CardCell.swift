//
//  CardCell.swift
//  Cards
//
//  Created by Bern on 29.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var oracleTextLable: UILabel!

    func setModel(card: Card) {
        oracleTextLable?.text = card.oracleText
        cardImageView?.sd_setImage(with: URL(string: card.imageUrl))
        layoutIfNeeded()
    }

}
