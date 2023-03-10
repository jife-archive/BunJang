//
//  DetailItemViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit

class DetailItemViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ShopItemCollectionView: UICollectionView!
    
    
    @IBAction func GoPay(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PayOptionViewController") as! PayOptionViewController
        self.presentPanModal(vc)
        
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
