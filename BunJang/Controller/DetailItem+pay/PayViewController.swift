//
//  PayViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/11.
//

import UIKit
import DLRadioButton

class PayViewController: UIViewController, PayOptionViewDelegate {
    func sendInfo(_ data: [String?]) {
        self.Productinfo = data
        self.NameLabel.text = data[0]
        self.priceLabel.text = data[1]
        self.methodLabel.text = data[3]
        self.firstPriceLabel.text = data[1]
    }
    @IBAction func usePoint(_ sender: Any) {
        
        
    }
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var lastPriceLabel: UILabel!
    @IBOutlet weak var firstPriceLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    let useinfo = getUserInfo.shared
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var DelivertMethodBtn: UIButton!
    @IBOutlet weak var methodImg: UIImageView!
    @IBOutlet weak var MethodAddBtn: UIButton!
    @IBOutlet weak var AgreeBtn: UIButton!
    @IBOutlet weak var PayRegister: UIButton!
    @IBOutlet weak var ChangeBtn: UIButton!
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var AddressView: UIView!
    var Agree = false
    let getAPI = MyPage()
    let paydelegate = PayOptionViewController()
    var Productinfo: [String?] = []

    
    @IBAction func payCompleteClick(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    @IBAction func GoBackClick(_ sender: Any) {
        self.dismiss(animated: false)
    }
    @IBAction func AgreeClick(_ sender: Any) {
        
        if Agree == true {
            Agree = false
            AgreeBtn.tintColor = .lightGray
        }else
        {
            Agree = true
            AgreeBtn.tintColor = .red
        }
        
    }
    
    @IBAction func DeliveryMethod(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryOptViewController") as! DeliveryOptViewController
        vc.delegate = self
        self.presentPanModal(vc)

        
    }
    @IBAction func GoMethod(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "PayMethodViewController") as! PayMethodViewController
        pushVC.delegate = self
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
    }
    @IBAction func PayMethodClick(_ sender: Any) {
        self.methodImg.image = UIImage(named: "")
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "PayMethodViewController") as! PayMethodViewController
        pushVC.delegate = self
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
    }
    
    
    
    func setUI(){
        naviBar.shadowImage = UIImage()
        let attributedString = NSMutableAttributedString(string: "변경")
        let attributedString2 = NSMutableAttributedString(string: "등록")

        let range = NSRange(location: 0, length: attributedString.length)

        let fontSize: CGFloat = 12.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)

        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString.addAttribute(.underlineColor, value: UIColor.systemGreen, range: range)
        attributedString.addAttribute(.font, value: font, range: range)
        self.ChangeBtn.setAttributedTitle(attributedString, for: .normal)
        attributedString2.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString2.addAttribute(.underlineColor, value: UIColor.systemGreen, range: range)
        attributedString2.addAttribute(.font, value: font, range: range)
        self.PayRegister.setAttributedTitle(attributedString2, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.priceLabel.text = useinfo.PayInfo[1]
        self.NameLabel.text = useinfo.PayInfo[0]
        self.firstPriceLabel.text = useinfo.PayInfo[1]
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: useinfo.price! + 1234))! + "원"
        self.lastPriceLabel.text = result
     
    }
}
extension PayViewController: PayMethodViewDelegate, DeliveryOptDelegate {
    func sendOpt(_ opt: String) {
        self.DelivertMethodBtn.setTitle(opt, for: .normal)
        if (opt == "문앞"){
            TextField.isHidden = false
        }else{
            TextField.isHidden = true

        }
    }
    
    func sendMethod(_ data: [String]) {
        print("1")
        self.MethodAddBtn.setTitle( data[0], for: .normal)
        if data[1] == "" {
            
        }
        else {
            self.methodImg.image = UIImage(named: data[1])

        }
        let attributedString2 = NSMutableAttributedString(string: "변경")

        let range = NSRange(location: 0, length: attributedString2.length)

        let fontSize: CGFloat = 12.0
        let font = UIFont.boldSystemFont(ofSize: fontSize)

     
        attributedString2.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        attributedString2.addAttribute(.underlineColor, value: UIColor.systemGreen, range: range)
        attributedString2.addAttribute(.font, value: font, range: range)
        self.PayRegister.setAttributedTitle(attributedString2, for: .normal)

    }
    
    
}
