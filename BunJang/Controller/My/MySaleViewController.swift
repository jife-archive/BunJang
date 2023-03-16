//
//  MySaleViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit

class MySaleViewController: UIViewController {

    var salecount = 0
    let getAPI = MyPage()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var zeroSV: UIStackView!
    @IBOutlet weak var SaleZeroImg: UIImageView!
    @IBOutlet weak var SaleCountLabel: UILabel!
    @IBOutlet weak var btnCollectionView: UICollectionView!
    var itemImg:[String?] = []
    var itemName:[String?] = []
    var itemPrice:[Int?] = []
    var itemIdx:[Int?] = []
    var ItemList:[ProductList?] = []
    let userinfo = getUserInfo.shared
    
    
    @IBAction func GoAll(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "EveryItemViewController") as! EveryItemViewController
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.all = false
        pushVC.modalPresentationStyle = .fullScreen
        self.present(pushVC, animated: false, completion: nil)

    }
    
    
    
    
    override func viewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.itemSize = CGSize(width: 60, height: 120)
          thirdFlowLayout.minimumInteritemSpacing = 0
          thirdFlowLayout.minimumLineSpacing = 0
          thirdFlowLayout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right:0 )
        let width2 = self.collectionView.frame.width / 3.3
          let height2 = self.collectionView.frame.height / 1
          thirdFlowLayout.itemSize = CGSize(width: width2, height: height2)
          self.collectionView.collectionViewLayout = thirdFlowLayout
        
        super.viewDidLoad()
        getAPI.getData(userIdx: userinfo.userIdx!) { MyResponseResult in
            print("연동성공!!")
            self.ItemList = MyResponseResult.productList
           // self.itemList.append(MypageResult)
            self.collectionView.reloadData()

            if MyResponseResult.productList.count == 0 {
                self.zeroSV.isHidden = false
 
            }
            else{
                self.zeroSV.isHidden = true
            }
            self.SaleCountLabel.text = String(MyResponseResult.productList.count) + "개"
        }

        if salecount == 0{
            zeroSV.isHidden = false
        }
    }
    


}
extension MySaleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        if self.ItemList.count != 0 {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: (self.ItemList[indexPath.row]?.price)!))! + "원"
            cell.ItemNameLabel.text = self.ItemList[indexPath.row]?.productName
            cell.PriceLabel.text = result
            cell.HeartBtn.isHidden = true
        }
        
        return cell
    }
    
    
}
