//
//  MyShopChangeViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit
protocol MyShopChageViewDelegate: AnyObject {
    func sendData(_info: [String])
}
class MyShopChangeViewController: UIViewController, UINavigationControllerDelegate {
    
    let userinfo = getUserInfo.shared
    weak var delegate: MyShopChageViewDelegate?
    var userInfo:[String] = []
    let edit = Edit()

    @IBAction func ChangeComplete(_ sender: Any) {
        
        NickName = textField.text!
        let para = RequestEdit(profileImgUrl: "", shopDescription: "", name: NickName)

        edit.sendEdit(userIdx: userinfo.userIdx!, parameters: para) { EditResponse in
            print("편집성공")
        }
        self.dismiss(animated: true)

    }
    let imagePicker = UIImagePickerController()

    var NickName = "아무개"
    @IBAction func setImg(_ sender: Any) {
        
    }
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: textField.frame.width, height: 1)
        border3.backgroundColor = UIColor.gray.cgColor
        textField.layer.addSublayer((border3))
        textField.textAlignment = .left
        textField.textColor = UIColor.black
        textField.borderStyle = .none
        textField.text = NickName
        textField.delegate = self
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
    }
    
}
extension MyShopChangeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField.text != nil){
            userInfo[0] = textField.text!
            textField.text = ""
        }
        
        return true
    }
}
extension MyShopChangeViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage

    }

}
