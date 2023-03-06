//
//  SearchViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit

class SearchViewController: UIViewController {
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

            configureSearchBar()
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
        
        //서치 탭에 들어왔을 때 자동으로 focus 되도록
        searchBar.becomeFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchViewController: UISearchBarDelegate {
    
}
