//
//  OptionViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit
import PanModal
class OptionViewController: UIViewController {
    
    @IBOutlet weak var UsedBtn: UIButton!
    @IBOutlet weak var PossibleBtn: UIButton!
    @IBOutlet weak var ImpossibleBtn: UIButton!
    @IBOutlet weak var NewBtn: UIButton!
    
    var new = false
    
    @IBAction func NewClick(_ sender: Any) {
        new = true
    }
    @IBAction func UsedClick(_ sender: Any) {
        new = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
