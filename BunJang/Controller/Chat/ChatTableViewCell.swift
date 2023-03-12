//
//  ChatTableViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lastChatLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
