//
//  EditSearchViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit
import PanModal

protocol EditSearchViewDelegate: AnyObject {
    func sendData(_ method: String)
}
class EditSearchViewController: UIViewController {
    weak var delegate: EditSearchViewDelegate?
    var method: String = "최신순"
    
    @IBOutlet weak var LBtn: UIButton!
    @IBOutlet weak var nBtn: UIButton!
    @IBOutlet weak var aBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func LowClick(_ sender: Any) {
        LBtn.filterSelected()
        nBtn.filterDeselected()
        aBtn.filterDeselected()
        method = "낮은가격순"
    }
    @IBAction func ActClick(_ sender: Any) {
        LBtn.filterDeselected()
        nBtn.filterDeselected()
        aBtn.filterSelected()
        method = "정확도순"

    }
    @IBAction func NewClcik(_ sender: Any) {
        LBtn.filterDeselected()
        nBtn.filterSelected()
        aBtn.filterDeselected()
        method = "최신순"

    }
    
    @IBAction func CompleteClick(_ sender: Any) {
        self.delegate?.sendData(method)
        self.dismiss(animated: true)
    }
    

}
extension EditSearchViewController: PanModalPresentable {
    var panScrollable: UIScrollView?{
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(500)
    }
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(0)
    }
}
