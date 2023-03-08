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
    
    @IBOutlet weak var TagView: UIView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var DetailBG: UIImageView!
    @IBOutlet weak var DetailTextField: UITextField!
    @IBOutlet weak var ShipPriceSV: UIStackView!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var PhotoCountLabel: UILabel!
    let categoryData = saleCategorydata()

    var Index1: Int?
    var Index2: Int?

    @IBAction func showOption(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionViewController") as! OptionViewController
        self.presentPanModal(vc)

    }
    let navController = UINavigationController()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Index1 != nil {
            CategoryLabel.text = categoryData.saleCate[Index1!].Name + " > " + categoryData.subCate[Index2!]
        }
        
    }
    @objc func tapCategoryView() {
        print("!")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCategoryView))
        self.categoryView.addGestureRecognizer(tapGesture)
    }
    @objc func tapTagView() {
        print("!")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func setTag() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapTagView))
        self.TagView.addGestureRecognizer(tapGesture)
    }
    
    var isCheck = false
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
        setTap()
        setTag()
    }
    

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
