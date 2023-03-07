//
//  SearchViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var RecentSearch: UICollectionView!
    @IBOutlet weak var freSearch: UICollectionView!
    @IBOutlet weak var CategoryCollectionVIew: UICollectionView!
    let CategoryData = habbitCategorydata()

    //   var recentSearchList: [String] = []
    
    let searchList = reascherData()
    let freData = fresearchdata()
    
    @IBAction func GoHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func GoBack(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
        //let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        //self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    // 다른곳에서는 쓸 일이 없으므로 private
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }

    let searchBar = UISearchBar()

    func setCollectionView()
    {
        self.RecentSearch.delegate = self
        self.RecentSearch.dataSource = self
        self.RecentSearch.register(UINib(nibName: "RecentSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecentSearchCollectionViewCell")

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        self.RecentSearch.collectionViewLayout = flowLayout
        
        
        self.CategoryCollectionVIew.delegate = self
        self.CategoryCollectionVIew.dataSource = self
        CategoryCollectionVIew.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        CategoryCollectionVIew.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        CategoryCollectionVIew.indicatorStyle = .black
        self.CategoryCollectionVIew.register(UINib(nibName: "HomeCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCategoryCollectionViewCell")
        
        self.freSearch.delegate = self
        self.freSearch.dataSource = self
        self.freSearch.register(UINib(nibName: "FrequencyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FrequencyCollectionViewCell")

        
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.scrollDirection = .horizontal
        secondFlowLayout.minimumInteritemSpacing = 0
        secondFlowLayout.minimumLineSpacing = 0
        secondFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        CategoryCollectionVIew.collectionViewLayout = secondFlowLayout
        
        let third = UICollectionViewFlowLayout()
        third.scrollDirection = .horizontal
        third.minimumInteritemSpacing = 10
        third.minimumLineSpacing = 10
        freSearch.collectionViewLayout = third
        
    }
    
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            setCollectionView()
            configureSearchBar()
           setupHideKeyboardOnTap()
        }
    
    private func configureSearchBar() {
        self.searchBar.delegate = self
        
        //navigation bar - add search bar
        searchBar.placeholder = "검색어를 입력해 주세요"
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = UIColor(red: 250/255, green: 249/255, blue: 250/255, alpha: 1.0)
        searchBar.searchTextField.font = .systemFont(ofSize: 15, weight: .semibold)
        searchBar.searchTextField.tintColor =  UIColor(red: 203/255, green: 204/255, blue: 203/255, alpha: 1.0)
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    

}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = self.searchBar.text else {return}
        reascherData.shared.recentSearchList.append(searchText)
        print( reascherData.shared.recentSearchList)
        RecentSearch.reloadData()
        self.searchBar.text = ""
        print("!")
        dismissKeyboard()
    }
    
    
}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == RecentSearch{
            return  reascherData.shared.recentSearchList.count

        }
        else if collectionView == CategoryCollectionVIew {
            return 12
        }
        else if collectionView == freSearch {
            return 10
        }
        return 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == RecentSearch {
            guard let cell = self.RecentSearch.dequeueReusableCell(withReuseIdentifier: "RecentSearchCollectionViewCell", for: indexPath) as? RecentSearchCollectionViewCell else {return UICollectionViewCell()}
            
            cell.RecentLabel.text =  reascherData.shared.recentSearchList[indexPath.row]

            return cell
        }
        else if collectionView == CategoryCollectionVIew {
            guard let cell = self.CategoryCollectionVIew.dequeueReusableCell(withReuseIdentifier: "HomeCategoryCollectionViewCell", for: indexPath) as? HomeCategoryCollectionViewCell else {return UICollectionViewCell()}
            cell.img.image = UIImage(named: CategoryData.habbitCategory[indexPath.row].imgName)
            cell.label.text = CategoryData.habbitCategory[indexPath.row].Name
            return cell
        }
        else if collectionView == freSearch {
            guard let cell = self.freSearch.dequeueReusableCell(withReuseIdentifier: "FrequencyCollectionViewCell", for: indexPath) as? FrequencyCollectionViewCell else {return UICollectionViewCell()}
            cell.idxNum.text = String(indexPath.row + 1)
            cell.nameLabel.text = reascherData.shared.fresearchData[indexPath.item].Name
            return cell
        }
        
        return UICollectionViewCell()
        
    }

}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == RecentSearch{
            let label = UILabel(frame: CGRect.zero)
            label.text =  reascherData.shared.recentSearchList[indexPath.item]
            label.sizeToFit()
        

            let cellWidth = label.frame.width + 40
            
            return CGSize(width: cellWidth, height: 40)
            
        }
       else if collectionView == CategoryCollectionVIew {
           
           let width = CategoryCollectionVIew.frame.width / 4
           let height = CategoryCollectionVIew.frame.height / 3
           
           return CGSize(width: width, height: height)
       }
       else if collectionView == freSearch {
           
           let label = UILabel(frame: CGRect.zero)
           label.text =  reascherData.shared.fresearchData[indexPath.item].Name
           label.sizeToFit()
       

           let cellWidth = label.frame.width + 50

          // let width = freSearch.frame.width/3

           return CGSize(width: cellWidth, height: 50)
           
       }
        return CGSize.zero
        
    }
    
    
}
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            dismissKeyboard()
        }
    }
}
