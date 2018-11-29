//
//  CardCell.swift
//  Cards
//
//  Created by Bern on 29.11.2018.
//  Copyright © 2018 Bern. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var oracleTextLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setModel(card: Card) {
        oracleTextLable?.text = card.oracleText
        cardImageView?.sd_setImage(with: URL(string: card.imageUrl))
        layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
