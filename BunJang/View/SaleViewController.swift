//
//  SaleViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit

class SaleViewController: UIViewController {

    @IBOutlet weak var ShipPriceCheckBtn: UIButton!
    @IBOutlet weak var WonSIgn: UIImageView!
    @IBOutlet weak var naviBar: NavigationBar!
    
    @IBOutlet weak var DetailBG: UIImageView!
    @IBOutlet weak var DetailTextField: UITextField!
    @IBOutlet weak var ShipPriceSV: UIStackView!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var PhotoCountLabel: UILabel!
    @objc func dismissKeyboard() {
        DetailTextField.resignFirstResponder()
        PriceTextField.resignFirstResponder()

      }
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    var isCheck = false
    
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func GoSale(_ sender: Any) {
        
    }
    
    @IBAction func ShipPriceClick(_ sender: Any) {
        if isCheck == false {
            print("배송비 ㅇㅇ")
            self.ShipPriceCheckBtn.tintColor = .red
            isCheck = true
        }
        else
        {
            print("배송비 ㄴㄴ")
            self.ShipPriceCheckBtn.tintColor = .lightGray
 
            isCheck = false

        }
        


    }
    
    func setTextField() {
        PriceTextField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: PriceTextField.frame.size.height-1, width: PriceTextField.frame.width, height: 2)
        border.backgroundColor = UIColor.systemGray5.cgColor
        PriceTextField.layer.addSublayer((border))
        PriceTextField.textAlignment = .left
        PriceTextField.textColor = UIColor.black
        PriceTextField.leftView = WonSIgn
        PriceTextField.leftViewMode = .always
        PriceTextField.rightView = ShipPriceSV
        PriceTextField.rightViewMode = .always
        DetailTextField.borderStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar.shadowImage = UIImage()
        setTextField()
        PriceTextField.delegate = self
        DetailTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SaleViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == PriceTextField{
            WonSIgn.tintColor = .black
            let border = CALayer()
            border.frame = CGRect(x: 0, y: PriceTextField.frame.size.height-1, width: PriceTextField.frame.width, height: 2)
            border.backgroundColor = UIColor.black.cgColor
            PriceTextField.layer.addSublayer((border))
            PriceTextField.textAlignment = .left
            PriceTextField.textColor = UIColor.black
            PriceTextField.leftView = WonSIgn
            PriceTextField.leftViewMode = .always
            PriceTextField.keyboardType = .numberPad
        }
        else if textField == DetailTextField {

        }
 
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        DetailBG.isHidden = true
    }
}
