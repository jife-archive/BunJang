//
//  EtcLoginViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire
import PanModal
import FacebookLogin

class EtcLoginViewController: UIViewController,PanModalPresentable {

    let login = sendLogin()

    var panScrollable: UIScrollView?{
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(300)
    }
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(0)
    }
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    let userinfo = getUserInfo.shared

    func naverLoginPaser() {
              guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
              
              if !accessToken {
                return
              }
              
              guard let tokenType = naverLoginInstance?.tokenType else { return }
              guard let accessToken = naverLoginInstance?.accessToken else { return }
                
              let requestUrl = "https://openapi.naver.com/v1/nid/me"
              let url = URL(string: requestUrl)!
              
              let authorization = "\(tokenType) \(accessToken)"
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        req.response { response in
            guard let data = response.data else {
                // handle error
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let body = json as? [String: Any], let resultCode = body["message"] as? String {
                    if resultCode.trimmingCharacters(in: .whitespaces) == "success" {
                        let resultJson = body["response"] as! [String: Any]
                        let name = resultJson["name"] as? String ?? ""
                        let id = resultJson["id"] as? String ?? ""
                        let phone = resultJson["mobile"] as! String
                        let gender = resultJson["gender"] as? String ?? ""
                        let birthyear = resultJson["birthyear"] as? String ?? ""
                        let birthday = resultJson["birthday"] as? String ?? ""
                        let profile = resultJson["profile_image"] as? String ?? ""
                        let email = resultJson["email"] as? String ?? ""
                        let nickName = resultJson["nickname"] as? String ?? ""
                        self.userinfo.userIdx = 3
                        print("네이버 로그인 이름 ",name)
                        print("네이버 로그인 아이디 ",id)
                        print("네이버 로그인 핸드폰 ",phone)
                        print("네이버 로그인 성별 ",gender)
                        print("네이버 로그인 생년 ",birthyear)
                        print("네이버 로그인 생일 ",birthday)
                        print("네이버 로그인 프로필사진 ",profile)
                        print("네이버 로그인 이메일 ",email)
                        print("네이버 로그인 닉네임 ",nickName)
    
                        let loginRequest = LoginRequest(name: "갈릭상점", phoneNo: "01033333333")
                        self.login.sendSelfLogin(parameters: loginRequest) { WelcomeLogin in
                            print("로그인 성공")
                            UserDefaults.standard.set(WelcomeLogin.result.jwt, forKey: "jwt")
                            print(WelcomeLogin.result.jwt)
                            print(WelcomeLogin.result.userIdx)
                            self.userinfo.userIdx = WelcomeLogin.result.userIdx
                            self.userinfo.jwt = WelcomeLogin.result.jwt
                            self.userinfo.Join = false
                            self.userinfo.Join = false
                            self.follo.getfollower(userIdx: WelcomeLogin.result.userIdx) { ResponseFollowing in
                                print(ResponseFollowing)
                                print(self.userinfo.jwt)
                                print(WelcomeLogin.result.jwt)
                                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
                                pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                                self.present(pushVC!, animated: true, completion: nil)
                            }
                            //userinfo.userIdx = 3
  
                        }
                        
                    } else {
                        // handle failure response
                    }
                }
            } catch {
                // handle error
            }
        }
        }

    @IBOutlet weak var selfBtn: UIButton!
    @IBOutlet weak var naverBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    let sale = SendSale()
    let rv = getReview()
    let follo = follow()
    let Tag = tagSearch()
    let category = SearchCategory()
    let lookheart = LookHeart()
    let giveheart = giveHeart()
    let cancel = cancelHeart()
    let edit = Edit()
    let sendfollow = following()
    @IBAction func facebookClick(_ sender: Any) {
      //  naverLoginInstance?.requestDeleteToken()
        
   
        let loginRequest = LoginRequest(name: "갈릭상점", phoneNo: "01033333333")
        self.login.sendSelfLogin(parameters: loginRequest) { WelcomeLogin in
             print("로그인 성공")
             UserDefaults.standard.set(WelcomeLogin.result.jwt, forKey: "jwt")
             print(WelcomeLogin.result.jwt)
             print(WelcomeLogin.result.userIdx)
             self.userinfo.userIdx = WelcomeLogin.result.userIdx
             self.userinfo.jwt = WelcomeLogin.result.jwt
             self.userinfo.Join = false
             self.userinfo.Join = false
             self.follo.getfollower(userIdx: WelcomeLogin.result.userIdx) { ResponseFollowing in

             }
             //userinfo.userIdx = 3
             let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
             pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
             self.present(pushVC!, animated: true, completion: nil)
         }


    }
    @IBAction func selfClick(_ sender: Any) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "SelfLoginViewController")
        pushVC!.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(pushVC!, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookBtn.contentHorizontalAlignment = .left
        naverBtn.contentHorizontalAlignment = .left
        selfBtn.contentHorizontalAlignment = .left
        naverLoginInstance?.delegate = self
       // naverLoginInstance?.requestDeleteToken()

    }
    

    @IBAction func naverLoginClick(_ sender: Any) {
        naverLoginInstance?.requestThirdPartyLogin()

        
    }
    

}
extension EtcLoginViewController: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("네이버 로그인 성공")
        self.naverLoginPaser()

    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("네이버 토큰\(String(describing: naverLoginInstance?.accessToken))")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러 = \(error.localizedDescription)")

    }
    
    
}
