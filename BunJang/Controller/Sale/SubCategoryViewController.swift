//
//  SubCategoryViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit

class SubCategoryViewController: UIViewController {
    
    var Index: Int?
    @IBOutlet weak var CategoryLabel: UILabel!
    let categoryData = saleCategorydata()

    @IBAction func GoBack(_ sender: Any) {
        
    }
    @IBOutlet weak var naviBar: UINavigationBar!
 
    
    @IBOutlet weak var CategoryTableView: UITableView!
    @IBOutlet weak var GetCategoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryTableView.delegate = self
        CategoryTableView.dataSource = self
        CategoryTableView.register(UINib(nibName: "SaleCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SaleCategoryTableViewCell")
        CategoryLabel.text = categoryData.saleCate[Index ?? 0].Name
        // Do any additional setup after loading the view.
    }
    


}
extension SubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryData.subCate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.CategoryTableView.dequeueReusableCell(withIdentifier: "SaleCategoryTableViewCell", for: indexPath) as? SaleCategoryTableViewCell else {return UITableViewCell()}
        cell.CategoryLabel.text = categoryData.subCate[indexPath.row]
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rootViewController = navigationController?.viewControllers.first as? SaleViewController else {
            return
        }
        
        rootViewController.Index1 = Index
        rootViewController.Index2 = indexPath.row
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

