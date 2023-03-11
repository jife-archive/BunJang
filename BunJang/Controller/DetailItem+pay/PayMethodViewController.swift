//
//  PayMethodViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit
enum Method: String{
    case Creidt = "신용체크카드"
    case KakaoPay = "카카오페이"
    case NaverPay = "네이버페이"
    case Mu = "무통장(가상계좌)"
    case Convenience = "편의점결제"
    case Toss = "토스페이"
    case Phone = "휴대폰 결제"
    case Payco = "페이코"
}

protocol PayMethodViewDelegate: AnyObject {
    func sendMethod(_ data : [String] )
}
class PayMethodViewController: UIViewController {
    
    var Agree = false
    
    weak var delegate: PayMethodViewDelegate?
    var sendData:[String] = ["",""]
    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var cardChocieVtn: UIButton!
    @IBOutlet weak var CardImg: UIImageView!
    @IBOutlet weak var muAgree: UIImageView!
    @IBOutlet weak var phoneAgree: UIImageView!
    @IBOutlet weak var MuMethodView: UIView!
    @IBOutlet weak var PaycoAgree: UIImageView!
    @IBOutlet weak var TossAgree: UIImageView!
    @IBOutlet weak var ConAgree: UIImageView!
    @IBOutlet weak var NaverAgree: UIImageView!
    @IBOutlet weak var KakaoAgree: UIImageView!
    @IBOutlet weak var CreditAgree: UIImageView!
    @IBOutlet weak var CardSelectView: UIView!
    @IBOutlet weak var MethodCollectionView: UICollectionView!

    @IBOutlet weak var BankBtn: UIButton!
    var paymethod = ["신용/체크카드","네이버페이","토스페이","편의점결제","카카오페이","페이코","휴대폰결제","무통장(가상계좌)"]
    
    var choice: Method = .Creidt
    var selectedIndex = 0
    
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    @IBAction func ChoiceComplete(_ sender: Any) {
        
        switch choice{
            
        case .Creidt:
            self.delegate?.sendMethod(sendData)
        case .KakaoPay:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)

        case .NaverPay:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)
        case .Mu:
            self.delegate?.sendMethod(sendData)
        case .Convenience:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)
        case .Toss:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)
        case .Phone:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)
        case .Payco:
            sendData[0] = choice.rawValue
            self.delegate?.sendMethod(sendData)
        }
        self.dismiss(animated: false)

    }
    
    @IBAction func ChocieCard(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardChoiceViewController") as! CardChoiceViewController
        vc.delegate = self
        self.presentPanModal(vc)

        
    }
    @IBAction func ChoiceBank(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BankChoiceViewController") as! BankChoiceViewController
        vc.delegate = self
        self.presentPanModal(vc)
    }
    
    func setCollectionView(){
        MethodCollectionView.delegate = self
        MethodCollectionView.dataSource = self
        MethodCollectionView.register(UINib(nibName: "PayMethodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PayMethodCollectionViewCell")
        
        let secondFlowLayout = UICollectionViewFlowLayout()
        secondFlowLayout.scrollDirection = .horizontal
        secondFlowLayout.minimumInteritemSpacing = 0
        secondFlowLayout.minimumLineSpacing = 5
        secondFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        let width = MethodCollectionView.frame.width / 2.1
        let height = MethodCollectionView.frame.height / 4.5
        secondFlowLayout.itemSize = CGSize(width: width, height: height)
        MethodCollectionView.collectionViewLayout = secondFlowLayout
        CardSelectView.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
}
extension PayMethodViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymethod.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.MethodCollectionView.dequeueReusableCell(withReuseIdentifier: "PayMethodCollectionViewCell", for: indexPath) as? PayMethodCollectionViewCell else {return UICollectionViewCell()}
        cell.methodLabel.text = paymethod[indexPath.row]
        if indexPath.row == selectedIndex {
            cell.CheckBtn.tintColor = UIColor.red
            cell.contentView.layer.borderColor = UIColor.red.cgColor
        }
        else
        {
            cell.CheckBtn.tintColor = UIColor.lightGray
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedIndex = indexPath.row
        if indexPath.row == 0 {
            choice = .Creidt
            CreditAgree.isHidden = false
            CardSelectView.isHidden = false
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 1 {
            choice = .NaverPay

            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = false
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 2 {
            choice = .Toss
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = false
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 3 {
            choice = .Convenience
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = false
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 4 {
            choice = .KakaoPay
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = false
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 5 {
            choice = .Payco
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = false
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 6 {
            choice = .Phone
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = false
            muAgree.isHidden = true
            MuMethodView.isHidden = true
        }
        else if indexPath.row == 7 {
            choice = .Mu
            CreditAgree.isHidden = true
            CardSelectView.isHidden = true
            NaverAgree.isHidden = true
            KakaoAgree.isHidden = true
            PaycoAgree.isHidden = true
            ConAgree.isHidden = true
            TossAgree.isHidden = true
            NaverAgree.isHidden = true
            phoneAgree.isHidden = true
            muAgree.isHidden = false
            MuMethodView.isHidden = false
        }
        MethodCollectionView.reloadData()
        
    }
    
}
extension PayMethodViewController: CardChoiceViewDelegate, BankChoiceViewDelegate {
    func sendBank(_ bank: [String]) {
        self.bankImg.image = UIImage(named: bank[1])
        self.BankBtn.setTitle("          " + bank[0], for: .normal)
        sendData[0] = "               " + bank[0]
        sendData[1] = bank[1]
    }
    
    func sendCard(_ card: [String]) {
        self.CardImg.image = UIImage(named: card[1])
        self.cardChocieVtn.setTitle("          " + card[0], for: .normal)
        sendData[0] = ("               " + card[0])
        sendData[1] = card[1]
    }
    
    
    
}
