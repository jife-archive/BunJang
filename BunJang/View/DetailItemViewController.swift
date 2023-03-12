//
//  DetailItemViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailItemViewController: UIViewController, UISheetPresentationControllerDelegate {
// "http://dev.rising-bunjang.store:9000"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ShopItemCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locataionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var shopImg: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var chatCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var heartCountLabel: UILabel!
    
    let getApi = HomeItemList()

    @IBOutlet weak var itemNameLabel: UILabel!
    func fetch(){
        getApi.getDetail(productIdx: 10) { response in
            print("1")
            self.priceLabel.text = String(response.result.getProductInfoRes.price) + "원"
        }
    }
   
    
    @IBAction func GoPay(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionViewController") as! PayOptionViewController
        if let sheet = vc.sheetPresentationController {
             //지원할 크기 지정
             sheet.detents = [.medium(), .large()]
             //크기 변하는거 감지
             sheet.delegate = self
            
             //시트 상단에 그래버 표시 (기본 값은 false)
             sheet.prefersGrabberVisible = true
             
             //처음 크기 지정 (기본 값은 가장 작은 크기)
             //sheet.selectedDetentIdentifier = .large
             
             //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
             //sheet.largestUndimmedDetentIdentifier = .medium
              present(vc, animated: true, completion: nil)
         }
        
    }
    
    
    func setCollectionView() {
        ShopItemCollectionView.dataSource = self
        ShopItemCollectionView.delegate = self
        ShopItemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.minimumInteritemSpacing = 0
        thirdFlowLayout.minimumLineSpacing = 0
        thirdFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width2 = ShopItemCollectionView.frame.width / 3
        let height2 = ShopItemCollectionView.frame.height / 2
        thirdFlowLayout.itemSize = CGSize(width: width2, height: height2)
        self.ShopItemCollectionView.collectionViewLayout = thirdFlowLayout
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetch()
    }
    


}
extension DetailItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
}
extension DetailItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
