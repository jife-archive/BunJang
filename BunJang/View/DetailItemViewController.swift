//
//  DetailItemViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageSlideshow
import Kingfisher

class DetailItemViewController: UIViewController, UISheetPresentationControllerDelegate {
    @IBOutlet weak var currentPageLabel: UILabel!
    // "http://dev.rising-bunjang.store:9000"
    @IBOutlet weak var itemImg: ImageSlideshow!
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
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var shopItemCountLabel: UILabel!
    @IBOutlet weak var shopFollowerCount: UILabel!
    @IBOutlet weak var shopStar: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var imgTotalCount: UILabel!
    
    var getIdx: Int = 0
    
    let getApi = HomeItemList()
    var imageSlide: [ImageSource] = []
    var tags:[String] = []
    
    var anotherItemImg:[UIImage] = []
    var anotherItem:[String?] = []
    var anotherItemPrice:[String?] = []
    var anotherItemIdx:[Int?] = []

    var anotherReview:[String?] = []
    var anotherReviewIdx:[Int?] = []
    var anotherReviewUser:[String?] = []
    var anotherReviewDate:[String?] = []
    var anotherReviewUserImg:[UIImage] = []

    @IBOutlet weak var itemNameLabel: UILabel!
    func fetch(){
        getApi.getDetail(productIdx: getIdx) { response in
            print("1")
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: response.result.getProductInfoRes.price!))! + "원"
            
            self.priceLabel.text = result
            
            self.imgTotalCount.text = String(response.result.getProductInfoRes.productImgs.count)
            
     
            self.itemImg.setImageInputs(self.imageSlide)
            self.itemImg.pageIndicator = nil
            self.itemImg.contentScaleMode = .scaleAspectFill
            self.itemImg.delegate = self
            self.itemNameLabel.text = response.result.getProductInfoRes.productName
            self.chatCountLabel.text = String(response.result.getProductInfoRes.chatCount!)
            
           /* for i in response.result.getProductInfoRes.keywords{
                self.tags.append((i.tag!))
            }*/
            
            self.shopNameLabel.text = response.result.getShopRes.getShopInfo.name
            self.shopStar.text = String(response.result.getShopRes.getShopInfo.avgStar!)
            self.shopFollowerCount.text = String(response.result.getShopRes.getShopInfo.followerCount!)
            self.shopItemCountLabel.text = String(response.result.getShopRes.getShopInfo.productCount!)
            print(response.result.getShopRes.products.count)
            for i in response.result.getShopRes.products{
                if let urlString = i.productImgURL, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                    self.anotherItemImg.append(UIImage(data: data)!)
                } else {
                    // URL 값이 nil인 경우 또는 데이터를 가져오는 데 실패한 경우 처리할 내용
                }
                
                self.anotherItem.append(i.productName)
                self.anotherItemIdx.append(i.productIdx)
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let result = numberFormatter.string(from: NSNumber(value: i.price!))! + "원"
                self.anotherItemPrice.append(result)
            }
            for i in response.result.getShopRes.reviews{
                self.anotherReview.append(i.content)
                self.anotherReviewIdx.append(i.reviewIdx)
                self.anotherReviewDate.append(i.date)
                self.anotherReviewUser.append(i.userName)
            }

            DispatchQueue.main.async {
 
                self.tagCollectionView.reloadData()
                self.tableView.reloadData()
                self.ShopItemCollectionView.reloadData()
            }
            
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
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        tagCollectionView.register(UINib(nibName: "ItemTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemTagCollectionViewCell")
        
        ShopItemCollectionView.dataSource = self
        ShopItemCollectionView.delegate = self
        ShopItemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let FlowLayout = UICollectionViewFlowLayout()
        FlowLayout.minimumInteritemSpacing = 0
       // FlowLayout.scrollDirection = .horizontal
        FlowLayout.minimumLineSpacing = 0
        FlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width = ShopItemCollectionView.frame.width / 3
        let height = ShopItemCollectionView.frame.height / 2
        FlowLayout.itemSize = CGSize(width: width, height: height)
        self.tagCollectionView.collectionViewLayout = FlowLayout
        
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
        print("디테일")
        print(getIdx as Any)
        setCollectionView()
      
        getApi.getDetail(productIdx: getIdx) { response in
            print("1")
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: response.result.getProductInfoRes.price!))! + "원"
            
            self.priceLabel.text = result
            
            self.imgTotalCount.text = String(response.result.getProductInfoRes.productImgs.count)
            
     
            self.itemImg.setImageInputs(self.imageSlide)
            self.itemImg.pageIndicator = nil
            self.itemImg.contentScaleMode = .scaleAspectFill
            self.itemImg.delegate = self
            self.itemNameLabel.text = response.result.getProductInfoRes.productName
            self.chatCountLabel.text = String(response.result.getProductInfoRes.chatCount!)
            
            /*for i in response.result.getProductInfoRes.keywords{
                self.tags.append((i.tag!))
            }*/
            
            self.shopNameLabel.text = response.result.getShopRes.getShopInfo.name
            self.shopStar.text = String(response.result.getShopRes.getShopInfo.avgStar!)
            self.shopFollowerCount.text = String(response.result.getShopRes.getShopInfo.followerCount!)
            self.shopItemCountLabel.text = String(response.result.getShopRes.getShopInfo.productCount!)
            print(response.result.getShopRes.products.count)
            for i in response.result.getShopRes.products{
                if let urlString = i.productImgURL, let url = URL(string: urlString), let data = try? Data(contentsOf: url) {
                    self.anotherItemImg.append(UIImage(data: data)!)
                } else {
                    // URL 값이 nil인 경우 또는 데이터를 가져오는 데 실패한 경우 처리할 내용
                }
                
                self.anotherItem.append(i.productName)
                self.anotherItemIdx.append(i.productIdx)
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let result = numberFormatter.string(from: NSNumber(value: i.price!))! + "원"
                self.anotherItemPrice.append(result)
            }
            for i in response.result.getShopRes.reviews{
                self.anotherReview.append(i.content)
                self.anotherReviewIdx.append(i.reviewIdx)
                self.anotherReviewDate.append(i.date)
                self.anotherReviewUser.append(i.userName)
            }

            DispatchQueue.main.async {
 
                self.tagCollectionView.reloadData()
                self.tableView.reloadData()
                self.ShopItemCollectionView.reloadData()
            }
            
        }

    }
    


}
extension DetailItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return tags.count
        }
        if collectionView == ShopItemCollectionView {
    
            return anotherItem.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ShopItemCollectionView {
            if anotherItem.count != 0{
                guard let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
                //cell.ItemImg.image = anotherItemImg[indexPath.row]
                cell.ItemNameLabel.text = anotherItem[indexPath.row]
                cell.PriceLabel.text = anotherItemPrice[indexPath.row]
                return cell
            }
            else
            {
                guard let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
                
                return cell
            }

        }
        else if collectionView == tagCollectionView {
            if tags.count != 0 {
                guard let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemTagCollectionViewCell", for: indexPath) as? ItemTagCollectionViewCell else {return UICollectionViewCell()}
                cell.tagNameLabel.text = tags[indexPath.row]
                return cell
            }
            else{
                guard let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemTagCollectionViewCell", for: indexPath) as? ItemTagCollectionViewCell else {return UICollectionViewCell()}
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
extension DetailItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if anotherReview.count != 0{
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            cell.UserNameLabel.text = anotherReviewUser[indexPath.row]
            cell.reviewContentLabel.text = anotherReview[indexPath.row]
            cell.timeLabel.text = anotherReviewDate[indexPath.row]
            return cell
        }
        else{
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as? ReviewTableViewCell else {return UITableViewCell()}
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
extension DetailItemViewController: ImageSlideshowDelegate {

    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        //이미지가 변경될 때마다 배너 page label 변경
        self.currentPageLabel.text = "\(page+1)"
    }

}


