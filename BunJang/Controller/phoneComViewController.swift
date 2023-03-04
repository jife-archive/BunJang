//
//  phoneComViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import DLRadioButton

protocol ModalViewControllerDelegate {
    func updateUI()
}
class phoneComViewController: UIViewController {
     var delegate: ModalViewControllerDelegate?
    
    @IBOutlet weak var sktBtn: DLRadioButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sktBtn.isSelected  = true      // Do any additional setup after loading the view.
    }
    
    @IBAction func SKT(_ sender: Any) {
             let data = "SKT"
        delegate?.updateUI()
    }
    
    @IBAction func KT(_ sender: Any) {
        print("go")
        let data = "KT"
             dismiss(animated: true, completion: nil)
        print("go")

    }
    
    @IBAction func LGU(_ sender: Any) {
        let data = "LG U+"
             dismiss(animated: true, completion: nil)
        print("go")

    }
    
    @IBAction func SKTA(_ sender: Any) {
        let data = "SKT 알뜰폰"
             dismiss(animated: true, completion: nil)
        print("go")

        
    }
    @IBAction func KTA(_ sender: Any) {
        let data = "KT 알뜰폰"
             dismiss(animated: true, completion: nil)
        print("go")

        
    }
    @IBAction func LGA(_ sender: Any) {
        let data = "LG U+ 알뜰폰"
             dismiss(animated: true, completion: nil)
        print("go")

    }

}
