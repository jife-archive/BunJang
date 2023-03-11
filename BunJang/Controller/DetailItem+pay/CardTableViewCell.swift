//
//  CardTableViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardLabel: UILabel!
    
    @IBOutlet weak var cardImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
