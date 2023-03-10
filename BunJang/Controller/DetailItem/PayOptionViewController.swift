//
//  PayOptionViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/10.
//

import UIKit
import PanModal

class PayOptionViewController: UIViewController {

    @IBOutlet weak var OptionSV: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        OptionSV.layer.borderWidth = 1.0
        OptionSV.layer.borderColor = UIColor.black.cgColor
    }
    

}
extension PayOptionViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }
}
