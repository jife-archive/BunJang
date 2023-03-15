//
//  ServiceMenuViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit
struct tableData {
    var img: String
    var name: String
}
class ServiceMenuViewController: UIViewController {
    
    var recommandData = [
        tableData(img: "번개케어", name: "번개케어"),
        tableData(img: "내폰시세", name: "내폰시세"),
        tableData(img: "포인트모으기1", name: "포인트모으기"),
        tableData(img: "번개유심", name: "번개유심"),
        tableData(img: "혜택", name: "혜택/이벤트"),
        tableData(img: "친구초대", name: "친구초대")
    ]
    var preData = [
        tableData(img: "찜", name: "찜"),
        tableData(img: "최근본상품", name: "최근본상품"),
        tableData(img: "내피드", name: "내피드"),
        tableData(img: "우리동네", name: "우리동네")

    ]


    @IBOutlet weak var recommandTableView: UITableView!
    
    @IBOutlet weak var preTableView: UITableView!
    
    func setTableview() {
        recommandTableView.delegate = self
        recommandTableView.dataSource = self
        preTableView.delegate = self
        preTableView.dataSource = self
        self.recommandTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        self.preTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableview()
    }
    
}
extension ServiceMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == recommandTableView {
            return 6
        }
        else if tableView == preTableView {
            return 4
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == recommandTableView {
            guard let cell = self.recommandTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {return UITableViewCell()}
            cell.nameLabel.text = recommandData[indexPath.row].name
            
            cell.img.image = UIImage(named: recommandData[indexPath.row].img)
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }
        else if tableView == preTableView {
            guard let cell = self.preTableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {return UITableViewCell()}
            
            cell.nameLabel.text = preData[indexPath.row].name
            
            cell.img.image = UIImage(named: preData[indexPath.row].img)
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }

    
}
