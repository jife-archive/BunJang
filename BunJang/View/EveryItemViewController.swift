//
//  EveryItemViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/15.
//

import UIKit

class EveryItemViewController: UIViewController {

    @IBOutlet weak var navi: UINavigationBar!
    @IBOutlet weak var itemListCollectionView: UICollectionView!
    let getApi = HomeItemList()
    let getMy = MyPage()
    var itemList: [ItemListResult] = []
    var HeartList: [LookHeartResult] = []
    let lookHeart = LookHeart()
    var MyItemList:[ProductList?] = []

    @IBAction func BackClick(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBOutlet weak var GoBack: UIBarButtonItem!
    var all = true
    let userinfo = getUserInfo.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        navi.shadowImage = UIImage()
        itemListCollectionView.dataSource = self
        itemListCollectionView.delegate = self
        itemListCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.itemSize = CGSize(width: self.itemListCollectionView.frame.width / 3, height: 210)
          thirdFlowLayout.minimumInteritemSpacing = 0
          thirdFlowLayout.minimumLineSpacing = 0
          thirdFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
          self.itemListCollectionView.collectionViewLayout = thirdFlowLayout
        self.lookHeart.SearchTag(userIdx: self.userinfo.userIdx!) { LookHeartResult in
            self.HeartList = LookHeartResult

            
        }
        if all == true {
            self.navi.isHidden = true
            getApi.getData { ItemListResult in
                self.itemList = ItemListResult
 
                
                DispatchQueue.main.async {
                    self.itemListCollectionView.reloadData()

                }
            }
        }
        else {
            self.navi.isHidden = false

            getMy.getData(userIdx: userinfo.userIdx!) { MypageResult in
                self.MyItemList = MypageResult.productList

                DispatchQueue.main.async {
                    self.itemListCollectionView.reloadData()
                    print("마이상품불러오기완료")
                }
            }
        }
    }
        
    }
    

extension EveryItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if all == true {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailItemViewController") as? DetailItemViewController else {return}
            vc.getIdx = Int((self.itemList[indexPath.row].productIdx))
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailItemViewController") as? DetailItemViewController else {return}
         //   vc.getIdx = Int((self.MyItemList[indexPath.row]?.productIdx!)!)
            vc.hidesBottomBarWhenPushed = true
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if all == true {
            return itemList.count

        }
        else {
            return MyItemList.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let cell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        if all == false {
            if self.MyItemList.count != 0 {
                let result = numberFormatter.string(from: NSNumber(value: (self.MyItemList[indexPath.row]?.price)!))! + "원"
                cell.ItemNameLabel.text = self.MyItemList[indexPath.row]?.productName
               
                let data = self.MyItemList[indexPath.row]?.productImgURL
                let url = URL(string: data ?? APIConstants.dummyimg )
                cell.ItemImg.kf.indicatorType = .activity
                
                cell.ItemImg.kf.setImage(with: url)

                cell.HeartBtn.isHidden = true
                cell.PriceLabel.text = result
            }
            return cell

        }
        else{
            guard let cell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
            if self.itemList.count != 0 {
                let result = numberFormatter.string(from: NSNumber(value: self.itemList[indexPath.row].price))! + "원"
                cell.ItemNameLabel.text = self.itemList[indexPath.row].productName
                if HeartList.count > 0 {
                    for i in 0...HeartList.count-1 {
                        if self.itemList[indexPath.row].productIdx == HeartList[i].productIdx {
                            cell.HeartBtn.Heart()
                        }
                    }
                }
                let data = self.itemList[indexPath.row].productImgURL
                let url = URL(string: data ?? APIConstants.dummyimg )
                cell.ItemImg.kf.indicatorType = .activity
                
                cell.ItemImg.kf.setImage(with: url)

                //cell.HeartBtn
                cell.HeartBtn.tag = self.itemList[indexPath.row].productIdx
                cell.PriceLabel.text = result
            }
            return cell
        }

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          if kind == UICollectionView.elementKindSectionHeader {
              let footer = itemListCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Typesomethingheader", for: indexPath)
              return footer
          }else{ //필수
              return UICollectionReusableView()
              
          } // end else
      }
 }


