//
//  CardChoiceViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit
import PanModal
protocol CardChoiceViewDelegate: AnyObject{
    func sendCard(_ card: [String])
}
class CardChoiceViewController: UIViewController {
    
    weak var delegate: CardChoiceViewDelegate?
    var sendData:[String] = ["",""]
var cardlist = ["KB국민카드","신한카드","BC카드(페이북)","현대카드(무이자)","삼성카드","롯데카드","NH카드","하나카드","우리카드","씨티카드","카카오뱅크","IBK기업카드"]
var cardImg = ["국민","신한","BC","현대","삼성","롯데","농협","하나","우리","시티","카카오뱅크","IBK"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
    }
    


}
extension CardChoiceViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.delegate?.sendCard(self.sendData)

        self.dismiss(animated: true)
    }
    
    
}
extension CardChoiceViewController: PanModalPresentable{
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
            return .contentHeight(620)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
    
    
}
