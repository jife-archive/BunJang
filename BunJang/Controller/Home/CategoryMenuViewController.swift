//
//  CategoryMenuViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit

class CategoryMenuViewController: UIViewController {

    let CategoryData = habbitCategorydata()
    let category = SearchCategory()

    private func setCollectionView() {
        self.habbitCategoryCollectionView.delegate = self
        self.habbitCategoryCollectionView.dataSource = self
        habbitCategoryCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        habbitCategoryCollectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        habbitCategoryCollectionView.indicatorStyle = .black
        self.habbitCategoryCollectionView.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.scrollDirection = .horizontal
        secondFlowLayout.minimumInteritemSpacing = 0
        secondFlowLayout.minimumLineSpacing = 0
        secondFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = habbitCategoryCollectionView.frame.width / 4
        let height = habbitCategoryCollectionView.frame.height / 3
        secondFlowLayout.itemSize = CGSize(width: width, height: height)
        habbitCategoryCollectionView.collectionViewLayout = secondFlowLayout
        
        self.tradeCategoryCollectionView.delegate = self
        self.tradeCategoryCollectionView.dataSource = self
        tradeCategoryCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tradeCategoryCollectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tradeCategoryCollectionView.indicatorStyle = .black
        self.tradeCategoryCollectionView.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        let tradeFlowLayout = UICollectionViewFlowLayout()
        tradeFlowLayout.scrollDirection = .horizontal
        tradeFlowLayout.minimumInteritemSpacing = 0
        tradeFlowLayout.minimumLineSpacing = 0
        tradeFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let tradewidth = tradeCategoryCollectionView.frame.width / 4
        let tradeheight = tradeCategoryCollectionView.frame.height / 6
        tradeFlowLayout.itemSize = CGSize(width: tradewidth, height: tradeheight)
        tradeCategoryCollectionView.collectionViewLayout = tradeFlowLayout
        
        self.lifeCategoryCollectionView.delegate = self
        self.lifeCategoryCollectionView.dataSource = self
        lifeCategoryCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        lifeCategoryCollectionView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        lifeCategoryCollectionView.indicatorStyle = .black
        self.lifeCategoryCollectionView.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        let lifeFlowLayout = UICollectionViewFlowLayout()
        lifeFlowLayout.scrollDirection = .horizontal
        lifeFlowLayout.minimumInteritemSpacing = 0
        lifeFlowLayout.minimumLineSpacing = 0
        lifeFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let lifewidth = lifeCategoryCollectionView.frame.width / 4
        let lifeheight = lifeCategoryCollectionView.frame.height / 1
        lifeFlowLayout.itemSize = CGSize(width: lifewidth, height: lifeheight)
        lifeCategoryCollectionView.collectionViewLayout = lifeFlowLayout
    }
    
    @IBOutlet weak var tradeCategoryCollectionView: UICollectionView!
    @IBOutlet weak var lifeCategoryCollectionView: UICollectionView!
    @IBOutlet weak var habbitCategoryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
}
extension CategoryMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == habbitCategoryCollectionView {
            return 12
        }
        else if collectionView == tradeCategoryCollectionView {
            return 24
        }
        else if collectionView == lifeCategoryCollectionView {
            return 4
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == habbitCategoryCollectionView {
            guard let cell = self.habbitCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
            
            cell.img.image = UIImage(named: CategoryData.habbitCategory[indexPath.row].imgName)
            cell.label.text = CategoryData.habbitCategory[indexPath.row].Name
            return cell
        }
        else if collectionView == tradeCategoryCollectionView {
            guard let cell = self.tradeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
            
            cell.img.image = UIImage(named: CategoryData.tradeCategory[indexPath.row].imgName)
            cell.label.text = CategoryData.tradeCategory[indexPath.row].Name
            return cell
        }
        else if collectionView == lifeCategoryCollectionView {
            guard let cell = self.lifeCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
            
            cell.img.image = UIImage(named: CategoryData.lifeCategory[indexPath.row].imgName)
            cell.label.text = CategoryData.lifeCategory[indexPath.row].Name
            return cell
            
        }
        return UICollectionViewCell()

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
        if collectionView == lifeCategoryCollectionView {
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchCategoryViewController") as! SearchCategoryViewController
            pushVC.img = CategoryData.lifeCategory[indexPath.row].imgName
            pushVC.cateName = CategoryData.lifeCategory[indexPath.row].Name
            pushVC.cateIdx = 3
            pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(pushVC, animated: false, completion: nil)
        }
        else if collectionView == habbitCategoryCollectionView {
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchCategoryViewController") as! SearchCategoryViewController
            pushVC.img = CategoryData.habbitCategory[indexPath.row].imgName
            pushVC.cateName = CategoryData.habbitCategory[indexPath.row].Name
            pushVC.cateIdx = 3
            pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(pushVC, animated: false, completion: nil)
        }
        else if collectionView == tradeCategoryCollectionView {
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchCategoryViewController") as! SearchCategoryViewController
            pushVC.img = CategoryData.tradeCategory[indexPath.row].imgName
            pushVC.cateName = CategoryData.tradeCategory[indexPath.row].Name
            pushVC.cateIdx = 3
            pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            self.present(pushVC, animated: false, completion: nil)
        }

    }
    
    
}
