//
//  PayOptionViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit
import PanModal

class PayOptionViewController: UIViewController {

    @IBOutlet weak var DeliveryTradeBtn: UIButton!
    @IBOutlet weak var OptionSV: UIStackView!
    @IBOutlet weak var OptionBtn: UIButton!
    @IBOutlet weak var MeetTradeBtn: UIButton!
    var GetOption = false

    @IBAction func GoPay(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "PayViewController") as! PayViewController
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
    }
    @IBAction func ChooseOpt(_ sender: Any) {
        GetOption = false
        DeliveryTradeBtn.isHidden = false
        MeetTradeBtn.isHidden = false
        OptionBtn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        setSV()
    }
    @IBAction func MeetGo(_ sender: Any) {
        GetOption = true
        DeliveryTradeBtn.isHidden = true
        MeetTradeBtn.isHidden = true
        OptionBtn.setTitle("직거래", for: .normal)
        setSV()
        self.panModalSetNeedsLayoutUpdate()
    }
    @IBAction func DeliveryGo(_ sender: Any) {
        GetOption = true
        DeliveryTradeBtn.isHidden = true
        MeetTradeBtn.isHidden = true
        OptionBtn.setTitle("택배거래", for: .normal)
        setSV()
    }
    func setSV() {
        if GetOption == false {
            OptionSV.layer.borderWidth = 1.0
            OptionSV.layer.borderColor = UIColor.black.cgColor
        }
        else {
            OptionBtn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            OptionSV.layer.borderWidth = 1.0
            OptionSV.layer.borderColor = UIColor.systemGray3.cgColor
        }
        OptionSV.layer.cornerRadius = 10.0
        OptionSV.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSV()
    }
    

}
extension PayOptionViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        if GetOption == true {}
            return .contentHeight(350)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}
