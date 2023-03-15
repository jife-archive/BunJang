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
    let userinfo = getUserInfo.shared
    var ClickHeart = false
    let giveheart = giveHeart()
    let cancel = cancelHeart()
    @IBAction func GiveHeart(_ sender: Any) {
        let send = SendHeartRequest(userIdx: userinfo.userIdx!)
        let indexPath = IndexPath(item: (sender as AnyObject).tag, section: 0)
        print("Heart button tapped on cell at indexPath: \(indexPath)")
        giveheart.sendHeart(productIdx: indexPath.row, parameters: send ) { SendHeartResult in
            print(SendHeartResult)
            if SendHeartResult.code == 2071
            {
                self.cancel.sendHeart(productIdx: indexPath.row, parameters: send) { CancelResponse in
                    if(CancelResponse.code == 2070) {
                        print(CancelResponse)
                            self.giveheart.sendHeart(productIdx: indexPath.row, parameters: send) { SendHeartResult in
                            
                        }
                        }
                    else{
                        self.HeartBtn.tintColor = .white
                        self.HeartBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    }
                    }
            }else
            {
                self.HeartBtn.tintColor = .red
                self.HeartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
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
