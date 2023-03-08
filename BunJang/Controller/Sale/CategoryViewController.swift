//
//  CategoryViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit


class CategoryViewController: UIViewController {
    
    
    let categoryData = saleCategorydata()
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        self.categoryTableView.register(UINib(nibName: "SaleCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SaleCategoryTableViewCell")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SubCategoryViewController {
            if let index = sender as? Int {
                vc.Index = index
            }
        }
    }
}
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryData.saleCate.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.categoryTableView.dequeueReusableCell(withIdentifier: "SaleCategoryTableViewCell", for: indexPath) as? SaleCategoryTableViewCell else {return UITableViewCell()}
        cell.CategoryLabel.text = categoryData.saleCate[indexPath.row].Name
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryViewController") as! SubCategoryViewController
        vc.Index = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
