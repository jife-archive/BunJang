//
//  MyViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit
import Pageboy
import Tabman

class MyViewController: UIViewController {
    let getAPI = MyPage()
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var floatBtn: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    let useinfo = getUserInfo.shared
    @IBAction func ChagneMyShop(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "MyShopChangeViewController") as! MyShopChangeViewController
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.NickName = NameLabel.text!
       // pushVC.delegate = self
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    func fetch(){
        getAPI.getData(userIdx: 3) { MypageResult in
            print("연동성공!!")
            self.rateLabel.text = String(MypageResult.avgStar!)
            self.followerLabel.text = String(MypageResult.followerCount!)
            self.followingLabel.text = String(MypageResult.followingCount!)
            self.NameLabel.text = MypageResult.name!
        }
    }
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    
    func setUI(){
        naviBar.shadowImage = UIImage()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetch()
    }
    

}
