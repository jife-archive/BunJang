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
enum Followstate {
    case followed
    case notFollowed
}
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
    @IBOutlet weak var TextView: UITextView!
    var getIdx: Int = 0
    var checkFollow: Followstate = .notFollowed
    let follo = follow()
    let getApi = HomeItemList()
    var imageSlide: [ImageSource] = []
    var tags:[Tag]?
    let userinfo = getUserInfo.shared
    var anotherItemImg:[String?] = []
    var anotherItem:[String?] = []
    var anotherItemPrice:[String?] = []
    var anotherItemIdx:[Int?] = []
    var anotherItemCount:Int?
    var anotherReview:[String?] = []
    var anotherReviewIdx:[Int?] = []
    var anotherReviewUser:[String?] = []
    var anotherReviewDate:[String?] = []
    var anotherReviewUserImg:[UIImage] = []
    var ImgURl:[ProductImg?] = []
    var followingList:[FollowingResult]?
    @IBOutlet weak var itemNameLabel: UILabel!
    var otherUserIdx: Int?
    @IBOutlet weak var followbtn: UIButton!
    let Follow = following()
    var followerCount: Int?
    @IBAction func GoPay(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionViewController") as! PayOptionViewController
        vc.Productinfo.append(itemNameLabel.text)
        vc.Productinfo.append(priceLabel.text)
        vc.Productinfo.append("img")
        userinfo.PayInfo.append(itemNameLabel.text)
        userinfo.PayInfo.append(priceLabel.text)
        userinfo.PayInfo.append(itemNameLabel.text)

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
        FlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right:10 )
   
        FlowLayout.itemSize = CGSize(width: 70, height: 30)
        self.tagCollectionView.collectionViewLayout = FlowLayout
        let thirdFlowLayout = UICollectionViewFlowLayout()

        thirdFlowLayout.itemSize = CGSize(width: 60, height: 200)
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
    
    @IBAction func FollowClick(_ sender: Any) {
        if checkFollow == .notFollowed
        {
            followbtn.followed()
            let para = FollowingRequest(followerIdx: userinfo.userIdx)
            
            Follow.sendfollow(followingUserIdx: self.otherUserIdx!, parameters: para) { FollowingResponse in
                self.followerCount! += 1
                self.shopFollowerCount.text = String(self.followerCount!)
                self.checkFollow = .followed
        }

        }
        else
        {
            checkFollow = .notFollowed
            followbtn.notFollow()

        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("디테일")
        print(getIdx as Any)
        setCollectionView()
 
        getApi.getDetail(productIdx: getIdx) { response in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: response.result.getProductInfoRes.price))! + "원"
            self.userinfo.price = response.result.getProductInfoRes.price
            if response.result.getProductInfoRes.tags != nil {
                self.tags = response.result.getProductInfoRes.tags
                print("키워드잇음")

            }
            else{
                print("키워드없음")
            }
            self.priceLabel.text = result
            self.TextView.text = response.result.getProductInfoRes.description
            self.reviewCountLabel.text = String(response.result.getShopRes.getShopInfo.reviewCount)
            self.ImgURl = response.result.getProductInfoRes.productImgs
            self.itemImg.setImageInputs(self.imageSlide)
            self.itemImg.pageIndicator = nil
            self.itemImg.contentScaleMode = .scaleAspectFill
            self.itemImg.delegate = self
            self.itemNameLabel.text = response.result.getProductInfoRes.productName
            self.chatCountLabel.text = String(response.result.getProductInfoRes.chatCount)
            print(self.tags as Any)
            if response.result.getProductInfoRes.productImgs != nil{
    
            }else
            {
                
            }
            self.followerCount = response.result.getShopRes.getShopInfo.followerCount
            self.shopNameLabel.text = response.result.getShopRes.getShopInfo.name
            self.shopStar.text = String(response.result.getShopRes.getShopInfo.avgStar)
            self.shopFollowerCount.text = String(response.result.getShopRes.getShopInfo.followerCount)
            self.shopItemCountLabel.text = String(response.result.getShopRes.getShopInfo.productCount)
            self.anotherItemCount = response.result.getShopRes.getShopInfo.productCount
            /*if self.ImgURl.count != 0 {
                for i in 0 ..< self.ImgURl.count{
                    let url = URL(string: (self.ImgURl[i]?.productImgUrl)!)
                    let data = try? Data(contentsOf: url!)
                    self.imageSlide.append(ImageSource(image: UIImage(data:data!)!))
                }
                self.itemImg.setImageInputs(self.imageSlide)
                self.itemImg.contentScaleMode = .scaleAspectFill
                self.imgTotalCount.text = String(self.ImgURl.count)

            }
            else{*/
                let url = URL(string: APIConstants.dummyimg)
                let data = try? Data(contentsOf: url!)
                self.imageSlide.append(ImageSource(image: UIImage(data:data!)!))
                self.itemImg.setImageInputs(self.imageSlide)
                self.itemImg.contentScaleMode = .scaleAspectFill
                self.imgTotalCount.text = "1"

            //}

            print(response.result.getShopRes.products.count)
            for i in response.result.getShopRes.products
            {
                self.otherUserIdx = response.result.getShopRes.getShopInfo.userIdx
                self.anotherItemImg.append(i.productImgUrl ?? APIConstants.dummyimg)
                self.anotherItem.append(i.productName)
                self.anotherItemIdx.append(i.productIdx)
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let result = numberFormatter.string(from: NSNumber(value: i.price))! + "원"
                self.anotherItemPrice.append(result)
            }
            for i in response.result.getShopRes.reviews{
                self.anotherReview.append(i.content)
                self.anotherReviewIdx.append(i.reviewIdx)
                self.anotherReviewDate.append(i.date)
                self.anotherReviewUser.append(i.userName)
            }
            self.shopItemCountLabel.text = String(self.anotherItem.count)
            DispatchQueue.main.async {
 
                self.tagCollectionView.reloadData()
                self.tableView.reloadData()
                self.ShopItemCollectionView.reloadData()
                self.follo.getfollower(userIdx: self.userinfo.userIdx!) { ResponseFollowing in
                    self.followingList = ResponseFollowing.result
                    print(self.followingList as Any)
                    
                    if self.followingList == nil{
                        
                    }
                    else{
                        for i in 0..<self.followingList!.count{
                            
                            if self.followingList![i].userIdx == response.result.getShopRes.getShopInfo.userIdx {
                                print("팔로잉중")
                                self.checkFollow = .followed
                                self.followbtn.followed()
                            }
                            else{
                                print("팔로잉아닌중")

                            }
                        }
                    }
 
                }
            }
            
        }

    }
    


}
extension DetailItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            if self.tags != nil {
                return tags!.count

            }
            else {
                return 0
            }
        }
        if collectionView == ShopItemCollectionView {
            print("나오냥?!")
    
                return anotherItem.count ?? 0
           
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == ShopItemCollectionView {
            if anotherItem.count > 0 {
                guard let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
                if anotherItemImg.count <= indexPath.row {
                    let url = URL(string: APIConstants.dummyimg)
                    cell.ItemImg.kf.indicatorType = .activity
                    cell.ItemImg.kf.setImage(with: url)
                    cell.ItemNameLabel.text = self.anotherItem[indexPath.row]
                    cell.PriceLabel.text = self.anotherItemPrice[indexPath.row]
                }else{
                    let data = self.anotherItemImg[indexPath.row] ?? APIConstants.dummyimg
                    let url = URL(string: data ?? APIConstants.dummyimg )
                    cell.ItemImg.kf.indicatorType = .activity
                    cell.ItemImg.kf.setImage(with: url)
                    cell.ItemNameLabel.text = self.anotherItem[indexPath.row]
                    cell.PriceLabel.text = self.anotherItemPrice[indexPath.row]
                }

                cell.HeartBtn.isHidden = true
                    return cell
            }else {
                guard let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
                    //cell.ItemImg.image = anotherItemImg[indexPath.row]
                    
                
                    return cell
            }
        }
        else if collectionView == tagCollectionView {
            if tags!.count == 0 {
                guard let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemTagCollectionViewCell", for: indexPath) as? ItemTagCollectionViewCell else {return UICollectionViewCell()}
                
                return cell
            }
            else{
                guard let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemTagCollectionViewCell", for: indexPath) as? ItemTagCollectionViewCell else {return UICollectionViewCell()}
                cell.tagNameLabel.text = tags![indexPath.row].tag
                cell.tagNameLabel.sizeToFit()
                return cell
            }
        }
        return UICollectionViewCell()
    }
}
extension DetailItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anotherReviewUser.count
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
extension DetailItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView{
            let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemTagCollectionViewCell", for: indexPath) as? ItemTagCollectionViewCell
            let cellWidth = cell!.tagNameLabel.frame.width + 40
            
            return CGSize(width: cellWidth, height: 40)
        }
        else if collectionView == ShopItemCollectionView {
            let cell = self.ShopItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
              let width = ShopItemCollectionView.frame.width / 3.3
            let height = ShopItemCollectionView.frame.height / 2
              
              // Reduce ItemImg height
              //cell.ItemImg.frame.size.height = 60

            return CGSize(width: width, height: height)

        }
        
        return CGSize.zero
    }
}


