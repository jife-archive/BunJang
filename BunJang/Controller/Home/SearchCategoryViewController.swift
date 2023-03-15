//
//  SearchCategoryViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class SearchCategoryViewController: UIViewController {

    @IBOutlet weak var ItemCollectionView: UICollectionView!
    @IBOutlet weak var nb: UINavigationBar!
    @IBOutlet weak var GoBack: UIBarButtonItem!
    
    @IBOutlet weak var categotrImg: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var bottomSv: UIStackView!
    @IBOutlet weak var sv3: UIStackView!
    @IBOutlet weak var sv2: UIStackView!
    @IBOutlet weak var sv1: UIStackView!
    
    @IBOutlet weak var subCateSV: UIStackView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var subCategoryMore: UIButton!

    
    @IBAction func GoHome(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func EdidClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSearchViewController") as! EditSearchViewController
        vc.delegate = self
        self.presentPanModal(vc)
    }
    @IBOutlet weak var editCick: UIButton!
    var cateName: String?
    var img: String?
    var category:[String?] = []
    
    @IBAction func moreCategory(_ sender: Any) {
        sv1.isHidden = false
        sv2.isHidden = false
        sv3.isHidden = false
        subCategoryMore.setTitle("셔츠", for: .normal)
        subCategoryMore.image(for: .disabled)
    }
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemCollectionView.delegate = self
        ItemCollectionView.dataSource = self
        ItemCollectionView.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let FlowLayout = UICollectionViewFlowLayout()
        FlowLayout.itemSize = CGSize(width: 60, height: 200)
        FlowLayout.minimumInteritemSpacing = 0
        FlowLayout.minimumLineSpacing = 0
        FlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width = ItemCollectionView.frame.width / 3
        let height = ItemCollectionView.frame.height / 4
        FlowLayout.itemSize = CGSize(width: width, height: height)
        self.ItemCollectionView.collectionViewLayout = FlowLayout
        nb.shadowImage = UIImage()
        categotrImg.image = UIImage(named: img!)
        categoryLabel.text = cateName!
    }
}
extension SearchCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.ItemCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    
}
extension SearchCategoryViewController: EditSearchViewDelegate{
    func sendData(_ method: String) {
        self.editBtn.titleLabel?.text = method

    }
    
    
}
