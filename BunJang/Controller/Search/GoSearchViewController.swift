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
    var Searchtag: String?
    var tagresult:[tagResult]?
    @IBOutlet weak var methodBtn: UIButton!
    let Tag = tagSearch()

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
        
        let encodedTag = Searchtag!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        Tag.SearchTag(tag: encodedTag) { tagResult in
                self.tagresult = tagResult
            print(tagResult)
            self.ItemCollectionView.reloadData()
        }
    }
}
extension GoSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagresult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(tagresult!.count > 0) {
            guard let cell = self.ItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: self.tagresult![indexPath.row].price!))! + "원"
            let data = self.tagresult![indexPath.row].productImgURL
            let url = URL(string: data ?? APIConstants.dummyimg )
            cell.ItemImg.kf.indicatorType = .activity
            cell.ItemImg.kf.setImage(with: url)
            cell.PriceLabel.text = result
            cell.ItemNameLabel.text = self.tagresult![indexPath.row].productName
            return cell
        }else
        {
            guard let cell = self.ItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
            return cell
        }
        
    }
}
