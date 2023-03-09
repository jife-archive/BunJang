//
//  SaleViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit

class SaleViewController: UIViewController, UISheetPresentationControllerDelegate {

    @IBOutlet weak var ShipPriceCheckBtn: UIButton!
    @IBOutlet weak var WonSIgn: UIImageView!
    @IBOutlet weak var naviBar: NavigationBar!
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagImg: UIImageView!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var TagView: UIView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var DetailBG: UIImageView!
    @IBOutlet weak var DetailTextField: UITextField!
    @IBOutlet weak var ShipPriceSV: UIStackView!
    @IBOutlet weak var PriceTextField: UITextField!
    @IBOutlet weak var PhotoCountLabel: UILabel!
    let categoryData = saleCategorydata()
    var tags: [String] = []
    var Index1: Int?
    var Index2: Int?

    @IBAction func showOption(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionViewController") as! OptionViewController
        vc.delegate = self
         if let sheet = vc.sheetPresentationController {
              //지원할 크기 지정
              sheet.detents = [.medium(), .large()]
              //크기 변하는거 감지
              sheet.delegate = self
             
              //시트 상단에 그래버 표시 (기본 값은 false)
              sheet.prefersGrabberVisible = true
              
              //처음 크기 지정 (기본 값은 가장 작은 크기)
              //sheet.selectedDetentIdentifier = .large
              
              //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
              //sheet.largestUndimmedDetentIdentifier = .medium
               present(vc, animated: true, completion: nil)
          }

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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
        vc.delegate = self
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
extension SaleViewController: TagViewDelegate, OptionViewDelegate {
    func SendOption(_ data: [String]) {
        print("옵션받음")
        usedLabel.text = data[0]
        exchangeLabel.text = data[1]
        addressLabel.text = data[2]
    }
    
    func sendTags(_ tags: [String]) {
        print("태그받음")
        tagImg.isHidden = true
        self.tags = tags
        var tagList = ""
        for i in 0..<tags.count {
            if i == tags.count - 1 {
                tagList = tagList + "# \(tags[i])"
            } else {
                tagList = tagList + "# \(tags[i]) | "
            }
        }
        self.tagLabel.text = tagList
        self.tagLabel.textColor = .black
    }

    }

