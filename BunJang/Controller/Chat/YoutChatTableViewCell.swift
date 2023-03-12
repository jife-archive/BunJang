//
//  YoutChatTableViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class YoutChatTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabe: UILabel!
    @IBOutlet weak var yourChatBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
