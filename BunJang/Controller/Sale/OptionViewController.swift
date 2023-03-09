//
//  OptionViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit
import PanModal

protocol OptionViewDelegate:AnyObject {
    func SendOption(_ data:[String])
}
class OptionViewController: UIViewController {
    weak var delegate:OptionViewDelegate?
    @IBOutlet weak var UsedBtn: UIButton!
    @IBOutlet weak var PossibleBtn: UIButton!
    @IBOutlet weak var ImpossibleBtn: UIButton!
    @IBOutlet weak var NewBtn: UIButton!
    
    
    @IBOutlet weak var searchAddressBtn: UIButton!
    var optionData: [String] = ["새상품","교환불가","지역선택 없음"]
    
    var new = false
    var exchange = false
    var Count = 1
    
    @IBAction func NewClick(_ sender: Any) {
        new = true
        optionData[0] = "새상품"
        NewBtn.optionSelected()
        UsedBtn.optionDeselected()
    }
    @IBAction func UsedClick(_ sender: Any) {
        new = false
        optionData[0] = "중고상푸"
        NewBtn.optionDeselected()
        UsedBtn.optionSelected()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func NoExchagneClick(_ sender: Any) {
        exchange = false
        optionData[1] = "교환불가"

        ImpossibleBtn.optionSelected()
        PossibleBtn.optionDeselected()
    }
    
    @IBAction func YesExchagneClick(_ sender: Any) {
        exchange = true
        optionData[1] = "교환가능"
        ImpossibleBtn.optionDeselected()
        PossibleBtn.optionSelected()
    }
    @IBAction func GoMap(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        pushVC.delegate = self
        pushVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC, animated: false, completion: nil)
    }
    @IBAction func SetComplete(_ sender: Any) {
        self.delegate?.SendOption(optionData)
        self.dismiss(animated: true)
    }
    
}
extension OptionViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}
extension OptionViewController: MapViewDelegate{
    func sendMap(_ map: String?) {
        self.searchAddressBtn.setTitle(map, for: .normal)
        optionData[2] = map!
    }
}
