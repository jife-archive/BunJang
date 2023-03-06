//
//  phoneComViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import DLRadioButton
import PanModal

enum com: String {
    case SKT = "SKT"
    case KT = "KT"
    case LG = "LG U+"
    case SKTA = "SKT 알뜰폰"
    case KTA = "KT 알뜰폰"
    case LGA = "LG U+ 알뜰폰"
}

protocol ModalViewControllerDelegate {
    func updateUI(_ data: com)
}
class phoneComViewController: UIViewController {
     var delegate: ModalViewControllerDelegate?
    var Com: com = .SKT
    @IBOutlet weak var sktBtn: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sktBtn.isSelected  = true      // Do any additional setup after loading the view.
    }
    
    @IBAction func SKT(_ sender: Any) {
        self.Com = .SKT
        delegate?.updateUI(self.Com)
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func KT(_ sender: Any) {
        self.Com = .KT
        delegate?.updateUI(self.Com)

        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func LGU(_ sender: Any) {
        self.Com = .LG
        delegate?.updateUI(self.Com)

        dismiss(animated: true, completion: nil)
        print("go")

    }
    
    @IBAction func SKTA(_ sender: Any) {
        self.Com = .SKTA
        delegate?.updateUI(self.Com)

     dismiss(animated: true, completion: nil)
        print("go")

        
    }
    @IBAction func KTA(_ sender: Any) {
        self.Com = .KTA
        delegate?.updateUI(self.Com)

     dismiss(animated: true, completion: nil)
        print("go")

        
    }
    @IBAction func LGA(_ sender: Any) {
        self.Com = .LGA
        delegate?.updateUI(self.Com)

       dismiss(animated: true, completion: nil)
        print("go")

    }

}
extension phoneComViewController: PanModalPresentable {
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
