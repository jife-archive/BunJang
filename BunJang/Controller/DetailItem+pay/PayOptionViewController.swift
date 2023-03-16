//
//  PayOptionViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit
import PanModal
protocol PayOptionViewDelegate: AnyObject{
    func sendInfo(_ data:[String?])
}
class PayOptionViewController: UIViewController {

    weak var delegate:PayOptionViewDelegate?
    @IBOutlet weak var DeliveryTradeBtn: UIButton!
    @IBOutlet weak var OptionSV: UIStackView!
    @IBOutlet weak var OptionBtn: UIButton!
    @IBOutlet weak var MeetTradeBtn: UIButton!
    var GetOption = false
    @IBOutlet weak var priceLabel: UILabel!
    
    var Productinfo: [String?] = []
    @IBAction func GoPay(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "PayViewNavigationController") as! PayViewNavigationController
        pushVC.Productinfo = self.Productinfo
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
        self.delegate?.sendInfo(Productinfo)

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
        if( self.Productinfo.count < 4){
            self.Productinfo.append("직거래")
        }else{
            self.Productinfo[3] = "직거래"
        }
        setSV()
        self.panModalSetNeedsLayoutUpdate()
    }
    @IBAction func DeliveryGo(_ sender: Any) {
        GetOption = true
        DeliveryTradeBtn.isHidden = true
        MeetTradeBtn.isHidden = true
        OptionBtn.setTitle("택배거래", for: .normal)
        if( self.Productinfo.count < 4){
            self.Productinfo.append("택배거래")
        }else{
            self.Productinfo[3] = "택배거래"
        }


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
        print(Productinfo)
        priceLabel.text = Productinfo[1]
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
