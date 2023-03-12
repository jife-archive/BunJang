//
//  HomeViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController, UIScrollViewDelegate, ImageSlideshowDelegate {
    
    
    let DetailView = DetailItemViewController()
    
    let getApi = HomeItemList()
    var itemList: [ItemListResult] = []
    
    @IBAction func GoSearch(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")
        pushVC?.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    @IBAction func GoCategory(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
        pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC!, animated: true, completion: nil)
    }
    
    func fetchData(){
        getApi.getData { response in
            self.itemList = response
            print("서버온!!!")
            print(self.itemList.count)

            DispatchQueue.main.async {
                self.RecentItemCollectionView.reloadData()
            }
        }
    }
    
    
    @IBOutlet weak var bellBar: UIBarButtonItem!
    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var AdIndicatorView: UIView!
    @IBOutlet weak var AdCountLabel: UILabel!
    @IBOutlet weak var HomeCategoryCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UIBarButtonItem!
    @IBOutlet weak var RecentItemCollectionView: UICollectionView!
    @IBOutlet weak var bannerAd: ImageSlideshow!
    
    @IBOutlet weak var RecommandCollectionView: UICollectionView!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    let homeCatregoryData = homeCategorydata()
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        self.AdCountLabel.text = "\(page+1)"
    }
    func setItemCollectionView()
    {
        self.RecentItemCollectionView.delegate = self
        self.RecentItemCollectionView.dataSource = self
        self.RecentItemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        self.RecommandCollectionView.delegate = self
        self.RecommandCollectionView.dataSource = self
        self.RecommandCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.itemSize = CGSize(width: 60, height: 200)
        thirdFlowLayout.minimumInteritemSpacing = 0
        thirdFlowLayout.minimumLineSpacing = 0
        thirdFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width2 = RecentItemCollectionView.frame.width / 3
        let height2 = RecentItemCollectionView.frame.height / 2
        thirdFlowLayout.itemSize = CGSize(width: width2, height: height2)
        self.RecentItemCollectionView.collectionViewLayout = thirdFlowLayout
        
        let FlowLayout = UICollectionViewFlowLayout()
        FlowLayout.itemSize = CGSize(width: 60, height: 200)
        FlowLayout.minimumInteritemSpacing = 0
        FlowLayout.minimumLineSpacing = 0
        FlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width = RecommandCollectionView.frame.width / 3
        let height = RecommandCollectionView.frame.height / 3
        FlowLayout.itemSize = CGSize(width: width, height: height)
        self.RecommandCollectionView.collectionViewLayout = FlowLayout
    }
    private func setCollectionView() {
        self.HomeCategoryCollectionView.delegate = self
        self.HomeCategoryCollectionView.dataSource = self
        HomeCategoryCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        HomeCategoryCollectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        HomeCategoryCollectionView.indicatorStyle = .black
        self.HomeCategoryCollectionView.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.scrollDirection = .horizontal
        secondFlowLayout.minimumInteritemSpacing = 0
        secondFlowLayout.minimumLineSpacing = 0
        secondFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = HomeCategoryCollectionView.frame.width / 4.6
        let height = HomeCategoryCollectionView.frame.height / 2
        secondFlowLayout.itemSize = CGSize(width: width, height: height)
        HomeCategoryCollectionView.collectionViewLayout = secondFlowLayout
    
    }
    private func configureView() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        backgroundScrollView.contentInsetAdjustmentBehavior = .never
        
        self.bannerAd.pageIndicator = nil
        self.bannerAd.setImageInputs(bannerImages)
        self.bannerAd.contentScaleMode = .scaleAspectFill
        self.bannerAd.slideshowInterval = 5
        self.bannerAd.delegate = self
        
        self.backgroundScrollView.delegate = self
        
    //    self.bannerPageView.layer.cornerRadius = 5
    }
    var bannerImages = [ImageSource(image: UIImage(named: "광고배너1")!), ImageSource(image: UIImage(named: "광고배너2")!), ImageSource(image: UIImage(named: "광고배너3")!), ImageSource(image: UIImage(named: "광고배너4")!), ImageSource(image: UIImage(named: "광고배너9")!), ImageSource(image: UIImage(named: "광고배너5")!), ImageSource(image: UIImage(named: "광고배너6")!), ImageSource(image: UIImage(named: "광고배너7")!), ImageSource(image: UIImage(named: "광고배너8")!)]

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if backgroundScrollView.contentOffset.y <= 0 {
            self.menuBar.tintColor = .white
            self.bellBar.tintColor = .white
            self.searchBar.tintColor = .white

        }
        else if backgroundScrollView.contentOffset.y > 0 {
            self.menuBar.tintColor = .black
            self.bellBar.tintColor = .black
            self.searchBar.tintColor = .black
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.tabBarController?.delegate = self
        self.configureView()
        self.setCollectionView()
        self.setItemCollectionView()
        AdIndicatorView.layer.backgroundColor = (UIColor.black.cgColor).copy(alpha: 0.1)
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == HomeCategoryCollectionView {
            return 14
        }
        else if collectionView == RecentItemCollectionView {
            return 6
        }
        else if collectionView == RecommandCollectionView {
            if self.itemList.count != 0 {
                return self.itemList.count
            }
            return 0
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == HomeCategoryCollectionView {
            guard let cell = self.HomeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
            
            cell.img.image = UIImage(named: homeCatregoryData.homeCategory[indexPath.row].imgName)
            cell.label.text = homeCatregoryData.homeCategory[indexPath.row].Name
            return cell
        }
        else if collectionView == RecentItemCollectionView {
            guard let cell = self.RecentItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
            
            if self.itemList.count != 0 {
                cell.ItemNameLabel.text = self.itemList[indexPath.row].productName
                cell.PriceLabel.text = String(self.itemList[indexPath.row].price)
            }
            return cell
        }
        else if collectionView == RecommandCollectionView{
            guard let cell = self.RecommandCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
            if self.itemList.count != 0 {
                cell.ItemNameLabel.text = self.itemList[indexPath.row].productName
                cell.PriceLabel.text = String(self.itemList[indexPath.row].price)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView ==  RecentItemCollectionView {
            if self.itemList.count != 0 {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailItemViewController") as? DetailItemViewController else {return}
                vc.getIdx = Int(self.itemList[indexPath.row].productIdx)
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailItemViewController") as? DetailItemViewController else {return}
                vc.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
extension HomeViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.title == "검색"{
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController")
            pushVC?.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(pushVC!, animated: true)
            return false
            
        }
        else if viewController.tabBarItem.title == "등록"{
            let pushVC =  self.storyboard?.instantiateViewController(withIdentifier: "SaleNavigationController") as! SaleNavigationController
            pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(pushVC, animated: true, completion: nil)

            return false
            
        }
        return true
    }
}
