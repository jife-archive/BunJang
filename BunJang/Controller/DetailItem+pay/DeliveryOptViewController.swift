//
//  DeliveryOptViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit
import PanModal

protocol DeliveryOptDelegate: AnyObject{
    func sendOpt(_ opt: String)
}
class DeliveryOptViewController: UIViewController {
    
    weak var delegate: DeliveryOptDelegate?

    var opt: String = ""
    
    
    @IBAction func door(_ sender: Any) {
        opt = "문앞"
        self.delegate?.sendOpt(opt)
        self.dismiss(animated: true)

    }
    
    @IBAction func door2(_ sender: Any) {
        opt = "직접받고 부재 시 문앞"
        self.delegate?.sendOpt(opt)
        self.dismiss(animated: true)

    }
    
    @IBAction func geongbi(_ sender: Any) {
        opt = "경비실"
        self.delegate?.sendOpt(opt)
        self.dismiss(animated: true)

    }
    
    @IBAction func postbox(_ sender: Any) {
        opt = "우편함"
        self.delegate?.sendOpt(opt)
        self.dismiss(animated: true)
    }
    
    @IBAction func `self`(_ sender: Any) {
        opt = "직접입력"
        self.delegate?.sendOpt(opt)
        self.dismiss(animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
extension DeliveryOptViewController: PanModalPresentable{
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
