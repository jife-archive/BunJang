//
//  FrequencyCollectionViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/07.
//

import UIKit

class FrequencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var idxNum: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 9.0
        self.contentView.layer.borderWidth = 0.5
        // Initialization code
    }

}
