//
//  SelfLoginViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit


enum Text{
    case name
    case birth
    case phone
}
class SelfLoginViewController: UIViewController, UITextFieldDelegate, UISheetPresentationControllerDelegate, ModalViewControllerDelegate {
    var state: Text = .name
    let modalViewController = phoneComViewController()

    @IBOutlet weak var nametextfield: UITextField!
    
    @IBOutlet weak var phoneComBtb: UIButton!
    @IBOutlet weak var phoneSV: UIStackView!
    @IBOutlet weak var comSV: UIStackView!
    @IBOutlet weak var birthSV: UIStackView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birth2: UITextField!
    @IBOutlet weak var birth1: UITextField!
    func setTextfield() {
        nametextfield.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: nametextfield.frame.size.height-1, width: nametextfield.frame.width, height: 1)
        border.backgroundColor = UIColor.gray.cgColor
        nametextfield.layer.addSublayer((border))
        nametextfield.textAlignment = .left
        nametextfield.textColor = UIColor.black
        
        birth1.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: birth1.frame.size.height-1, width: birth1.frame.width, height: 1)
        border2.backgroundColor = UIColor.gray.cgColor
        birth1.layer.addSublayer((border2))
        birth1.textAlignment = .left
        birth1.textColor = UIColor.black
        
        birth2.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: birth2.frame.size.height-1, width: birth2.frame.width, height: 1)
        border3.backgroundColor = UIColor.gray.cgColor
        birth2.layer.addSublayer((border3))
        birth2.textAlignment = .left
        birth2.textColor = UIColor.black
        birth2.borderStyle = .none
        
        let border4 = CALayer()
        border4.frame = CGRect(x: 0, y: phone.frame.size.height-1, width: phone.frame.width, height: 1)
        border4.backgroundColor = UIColor.gray.cgColor
        phone.layer.addSublayer((border4))
        phone.textAlignment = .left
        phone.textColor = UIColor.black
        phone.borderStyle = .none

    }
    @IBAction func PhoneCom_Click(_ sender: Any) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "phoneComViewController") else {return}

    
      //  vc.modalPresentationStyle = .pageSheet

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
        //self.present(vc, animated: true, completion: nil)
    }
    func updateUI() {
        // 전달받은 데이터를 사용하여 UI 업데이트
        self.phoneComBtb.setTitle("SKT                                                   ", for: .normal)
        print("update")
        self.modalViewController.dismiss(animated: true, completion: nil)

    }
    @IBAction func birthChange(_ sender: Any) {
        comSV.isHidden = false
        
        modalViewController.delegate = self

        self.phoneComBtb.setTitle("SKT                                                       ", for: .normal)
        state = .phone
        phoneSV.isHidden = false
    }
    @IBAction func NextClick(_ sender: Any) {
        
        switch state {
        case .name:
            birthSV.isHidden = false
        case .birth:
            comSV.isHidden = false
        case .phone:
            phoneSV.isHidden = false
        }
    }
    @IBAction func ChangeName(_ sender: Any) {
        nextBtn.alpha = 1.0
        nextBtn.isEnabled = true
    }
    @IBAction func nameChanged(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextfield()
        birthSV.isHidden = true
        comSV.isHidden = true
        phoneSV.isHidden = true
 
        nextBtn.alpha = 0.5
        nextBtn.isEnabled = false
        state = .name
    }
    
    @IBAction func BackClick(_ sender: Any) {
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            rootViewController.dismiss(animated: true, completion: nil)
            
        }
    }
    

}
