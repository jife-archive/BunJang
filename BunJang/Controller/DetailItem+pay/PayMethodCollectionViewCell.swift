//
//  PayMethodCollectionViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit

class PayMethodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var CheckBtn: UIButton!
    @IBOutlet weak var methodLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.masksToBounds = true
    }

}
