//
//  RecentSearchCollectionViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/07.
//

import UIKit

class RecentSearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var RecentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 9.0
        self.contentView.layer.borderWidth = 2.0
        // Initialization code
    }

}
