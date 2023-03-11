//
//  BankChoiceViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit
import PanModal

protocol BankChoiceViewDelegate: AnyObject{
    func sendBank(_ bank: [String])
}
class BankChoiceViewController: UIViewController {
    
    weak var delegate: BankChoiceViewDelegate?
    var sendData:[String] = ["",""]
    var cardlist = ["KB국민은행","신한은행","NH농협은행","하나은행","우리은행","씨티은행","카카오뱅크","IBK기업은행"]
    var cardImg = ["국민","신한","농협","하나","우리","시티","카카오뱅크","IBK"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
    }
    


}
extension BankChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as? CardTableViewCell else {return UITableViewCell()}
        cell.cardLabel.text = cardlist[indexPath.row]
        cell.cardImg.image = UIImage(named: cardImg[indexPath.row])
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendData[0] = cardlist[indexPath.row]
        sendData[1] = cardImg[indexPath.row]
        self.delegate?.sendBank(self.sendData)

        self.dismiss(animated: true)
    }
}
extension BankChoiceViewController: PanModalPresentable{
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
            return .contentHeight(335)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    
    
}
