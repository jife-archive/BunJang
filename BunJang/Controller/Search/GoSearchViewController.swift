//
//  GoSearchViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class GoSearchViewController: UIViewController, EditSearchViewDelegate {
    func sendData(_ method: String) {
        self.methodBtn.titleLabel?.text = method
    
    }
    
    @IBOutlet weak var methodBtn: UIButton!
    
    @IBOutlet weak var ItemCollectionView: UICollectionView!
    
    
    @IBAction func ChangeSetClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSearchViewController") as! EditSearchViewController
        vc.delegate = self
        self.presentPanModal(vc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemCollectionView.delegate = self
        ItemCollectionView.dataSource = self
        ItemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.scrollDirection = .vertical
        secondFlowLayout.minimumInteritemSpacing = 0
        secondFlowLayout.minimumLineSpacing = 0
        secondFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = ItemCollectionView.frame.width / 3
        let height = ItemCollectionView.frame.height / 3.3
        secondFlowLayout.itemSize = CGSize(width: width, height: height)
        ItemCollectionView.collectionViewLayout = secondFlowLayout
    }
}
extension GoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.ItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
}
