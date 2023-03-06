//
//  HomeViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import ImageSlideshow

class HomeViewController: UIViewController, UIScrollViewDelegate, ImageSlideshowDelegate {
    
    
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
        
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.itemSize = CGSize(width: 60, height: 200)

        thirdFlowLayout.minimumInteritemSpacing = 0
        thirdFlowLayout.minimumLineSpacing = 0
        thirdFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width2 = RecentItemCollectionView.frame.width / 3
        let height2 = RecentItemCollectionView.frame.height / 2
        thirdFlowLayout.itemSize = CGSize(width: width2, height: height2)
        self.RecentItemCollectionView.collectionViewLayout = thirdFlowLayout
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
        self.configureView()
        self.setCollectionView()
        self.setItemCollectionView()
        AdIndicatorView.layer.backgroundColor = (UIColor.black.cgColor).copy(alpha: 0.1)
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
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
