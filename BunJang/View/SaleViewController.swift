//
//  SaleViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/08.
//

import UIKit
import Toast_Swift

class SaleViewController: UIViewController, UISheetPresentationControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var ShipPriceCheckBtn: UIButton!
    @IBOutlet weak var WonSIgn: UIImageView!
    @IBOutlet weak var naviBar: NavigationBar!
    let imagePicker = UIImagePickerController()
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
    @IBOutlet weak var SelectImgView: UIView!
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var payWaring: UILabel!
    @IBOutlet weak var payCheckImg: UIImageView!
    @IBOutlet weak var imgCountLabel: UILabel!

    var imgName: [UIImage] = []
    var tags: [String] = []
    var Index1: Int?
    var Index2: Int?
    
    var productImgs:[String] = []
    var productName:String = ""
    var subCategoryIdx = 0
    var price = 0
    var Itemcount = 1
    var productStatus = ""
    var isExchange = ""
    var Itemdescription:String = ""
    @IBOutlet weak var ItemTextField: UITextField!
    
    let sale = SendSale()
    let userinfo = getUserInfo.shared
    
    @IBAction func showOption(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OptionViewController") as! OptionViewController
        vc.delegate = self
         if let sheet = vc.sheetPresentationController {
              sheet.detents = [.medium(), .large()]
              sheet.delegate = self
              sheet.prefersGrabberVisible = true
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
    @objc func tapAlbumView() {
        imagePicker.modalPresentationStyle = .fullScreen
        self.present(imagePicker, animated: true, completion: nil)
    }
    func setImgTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAlbumView))
        self.SelectImgView.addGestureRecognizer(tapGesture)
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
    @objc func tappay() {
        if isPay == true {
            isPay = false
            self.payView.layer.borderColor = UIColor.systemGray3.cgColor
            payCheckImg.tintColor = .lightGray
            payWaring.text = "내 상품에 안전결제 배지가 표시돼요"
            payWaring.textColor = .black
        }
        else{
            isPay = true
            self.payView.layer.borderColor = UIColor.red.cgColor
            payCheckImg.tintColor = .red
            payWaring.text = "⛔︎안전결제를 거부하면 주의 안내가 표시돼요"
            payWaring.textColor = .red
        }
    }
    func setPay() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappay))
        self.payView.addGestureRecognizer(tapGesture)
    }
    var isPay = false
    var isCheck = false
    
    @IBAction func GoBack(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func GoSale(_ sender: Any) {
        if let detailText = DetailTextField.text {
            if Int(PriceTextField.text ?? "") ?? 0 > 500 && detailText.count > 10 {
                Itemdescription = DetailTextField.text ?? ""
                price = Int(PriceTextField.text!)!
                if tags.count == 0{
                    self.view.makeToast("태그를 1개 이상 입력해주세요!",duration:2,position: .center)

                }
                else{
                    
                    
                
                        productName = ItemTextField.text!
                        let saleRequest = SaleRequest(userIdx: userinfo.userIdx! , productImgs: productImgs, productName: productName, subCategoryIdx: 6, tags: tags, price: price, description: Itemdescription, count: 1, productStatus: productStatus, isExchange: isExchange)
                    self.sale.postSale(saleRequest: saleRequest) { SaleResponse in
                        self.dismiss(animated: true)
                        print("판매")
                        
                    }
                
                    
                }
            } else {
                if Int(PriceTextField.text ?? "") ?? 0 < 500{
                    self.view.makeToast("가격은 500원이상부터 설정이 가능합니다!",duration:2,position: .center)
                }else{
                    self.view.makeToast("상세 설명의 글자 수를 10자 이상 설정해주십시오!",duration:2,position: .center)
                }
            }
        } else {
            // DetailTextField.text가 nil인 경우 처리
            print("상세 설명이 입력되지 않았습니다!")
        }

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
    func setItemCollectionView()
    {
        self.imgCollectionView.delegate = self
        self.imgCollectionView.dataSource = self
        self.imgCollectionView.register(UINib(nibName: "SetImgCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SetImgCollectionViewCell")
        
        let thirdFlowLayout = UICollectionViewFlowLayout()
        thirdFlowLayout.scrollDirection = .horizontal
        thirdFlowLayout.minimumInteritemSpacing = 0
        thirdFlowLayout.minimumLineSpacing = 0
        thirdFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0 )
        let width2 = imgCollectionView.frame.width / 5
        let height2 = imgCollectionView.frame.height / 1
        thirdFlowLayout.itemSize = CGSize(width: width2, height: height2)
        self.imgCollectionView.collectionViewLayout = thirdFlowLayout
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar.shadowImage = UIImage()
        setTextField()
        PriceTextField.delegate = self
        DetailTextField.delegate = self
        setTap()
        setTag()
        setImgTap()
        setItemCollectionView()
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.payView.layer.borderColor = UIColor.systemGray3.cgColor
        self.payView.layer.borderWidth = 1
        self.payView.layer.cornerRadius = 8
        payCheckImg.tintColor = .lightGray
        setPay()
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
        if addressLabel.text == "교환불가"
        {
            
        }else
        {
            isExchange = "AVAIL"
        }
        if usedLabel.text == "중고상품"
        {
            productStatus = "SECOND-HAND"
        }
        else
        {
            
        }
    
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
extension SaleViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        guard let imageData = newImage!.jpegData(compressionQuality: 0.8) else {
            return
        }
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("image.jpg")
        do {
            try imageData.write(to: fileURL)
        } catch {
            print(error)
        }
        
        print(fileURL)

        self.imgName.append(newImage!)
        self.imgCollectionView.reloadData()
        print(imgName)
        self.imgCountLabel.text = String(imgName.count)
        self.imagePicker.dismiss(animated: true)

    }
}
extension SaleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.imgCollectionView.dequeueReusableCell(withReuseIdentifier: "SetImgCollectionViewCell", for: indexPath) as? SetImgCollectionViewCell else {return UICollectionViewCell()}
        cell.img.image = imgName[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imgName.remove(at: indexPath.row)
        self.imgCountLabel.text = String(imgName.count)
        imgCollectionView.reloadData()
    }
    
    
}


