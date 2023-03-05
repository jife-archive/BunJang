//
//  AgreeTableViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit

class AgreeTableViewCell: UITableViewCell {

    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var checktBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
