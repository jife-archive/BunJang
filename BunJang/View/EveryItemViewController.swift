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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
 
}
extension EveryItemViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.itemListCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
       
           /* let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
          let result = numberFormatter.string(from: NSNumber(value: (self.ItemList[indexPath.row]?.price)!))! + "원"
            cell.ItemNameLabel.text = self.ItemList[indexPath.row]?.productName
            cell.PriceLabel.text = result
            cell.HeartBtn.isHidden = true*/
    
        
        return cell
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


