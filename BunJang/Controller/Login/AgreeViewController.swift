//
//  AgreeViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit
import PanModal
import Toast_Swift

struct Agree {
    var check: Bool
    var label: String
}


class AgreeViewController: UIViewController, PanModalPresentable {
    
    let userinfo = getUserInfo.shared
    let login = sendLogin()

    var JoinDate: [String] = []
    let join = Join()
    var agree = [
        Agree(check: false, label: "번개장터 이용약관 (필수)"),
        Agree(check: false, label: "개인정보 수집 이용 동의 (필수)"),
        Agree(check: false, label: "휴대폰 본인확인서비스 (필수)"),
        Agree(check: false, label: "휴먼 개인정보 분리보관 동의 (필수)"),
        Agree(check: false, label: "위치정보 이용약관 동의 (필수)"),
        Agree(check: false, label: "개인정보 수집 이용 동의 (선택)"),
        Agree(check: false, label: "마케팅 수신 동의 (선택)"),
        Agree(check: false, label: "개인정보 광고활용 동의 (선택)")
    ]
    
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(400)
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var AllagreeBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var isCheck = false
    
    @IBAction func ClickAllagree(_ sender: Any) {
        self.nextBtn.backgroundColor = UIColor(red: 215/255, green: 169/255, blue: 171/255, alpha: 1.0)
        if isCheck {
            isCheck = false
            self.AllagreeBtn.tintColor = .lightGray
            
            for i in 0 ..< self.agree.count {
                self.agree[i].check = false
            }
            
            self.nextBtn.backgroundColor = UIColor(red: 215/255, green: 169/255, blue: 171/255, alpha: 1.0)
            
        } else {
            isCheck = true
            self.AllagreeBtn.tintColor = .red
            
            for i in 0 ..< self.agree.count {
                self.agree[i].check = true
            }
            
            self.nextBtn.backgroundColor = .red
        }
        
        self.tableView.reloadData()
        let joginRequest = JoinRequest(name: JoinDate[0], phoneNo:JoinDate[2], birthday:JoinDate[1])
        self.join.postJoin(parameters: joginRequest, onCompletion: { welcome in
            print("회원가입 요청완료")
            self.userinfo.userIdx = welcome.result?.userIdx
            self.userinfo.Join = true
            self.userinfo.jwt = welcome.result?.jwt
            
           //UserDefaults.standard.set(welcome.result?.jwt, forKey: "jwt")

            if welcome.isSuccess == true{
                print("이제 홈가요")
                UserDefaults.standard.set(welcome.result?.jwt, forKey: "jwt")
                DispatchQueue.main.async {
                    
                    let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
                    pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                    self.present(pushVC!, animated: true, completion: nil)
                    
                }
            }else{
                print(welcome.isSuccess)
                print(welcome.code)
                print(welcome.message)
                let loginRequest = LoginRequest(name: self.JoinDate[0], phoneNo: self.JoinDate[2])
                    self.login.sendSelfLogin(parameters: loginRequest) { WelcomeLogin in
                        self.userinfo.userIdx = WelcomeLogin.result.userIdx
                        self.userinfo.Join = false
                        UserDefaults.standard.set(WelcomeLogin.result.jwt, forKey: "jwt")
                        print("로그인 완료")
                        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
                        pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                        self.present(pushVC!, animated: true, completion: nil)
                }
            }
            


        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "AgreeTableViewCell", bundle: nil), forCellReuseIdentifier: "AgreeTableViewCell")
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
extension AgreeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "AgreeTableViewCell", for: indexPath) as? AgreeTableViewCell else {return UITableViewCell()}
        
        cell.agreeLabel.text = agree[indexPath.row].label
        if agree[indexPath.row].check {
            cell.checktBtn.tintColor = .red
        } else {
            cell.checktBtn.tintColor = .lightGray
        }
        return cell
    }

}

