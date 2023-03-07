//
//  ItemCollectionViewCell.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/05.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var HeartBtn: UIButton!
    
    @IBOutlet weak var ItemNameLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var PayImg: UIImageView!
    @IBOutlet weak var ItemImg: UIImageView!
    
    var ClickHeart = false
    
    @IBAction func GiveHeart(_ sender: Any) {
        if ClickHeart {
            ClickHeart = false
            self.HeartBtn.tintColor = .white
            self.HeartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        else
        {
            ClickHeart = true
            self.HeartBtn.tintColor = .red
            self.HeartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ItemImg.layer.cornerRadius = 7
        self.HeartBtn.tintColor = .white

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.HeartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        self.HeartBtn.tintColor = .white
    }
}
