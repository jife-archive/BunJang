//
//  BrandMenuViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit

class BrandMenuViewController: UIViewController {

    @IBOutlet weak var followBtn: UIButton!
    var brandList = ["브랜드이미지1","브랜드이미지2","브랜드이미지3","브랜드이미지4","브랜드이미지5"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandTableViewCell")
    }
    
    @IBAction func folloingClick(_ sender: Any) {
        
    }
       

}
extension BrandMenuViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "BrandTableViewCell", for: indexPath) as? BrandTableViewCell else {return UITableViewCell()}
        
        
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        cell.imgView.image = UIImage(named: self.brandList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
}
