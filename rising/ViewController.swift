//
//  ViewController.swift
//  rising
//
//  Created by 최지철 on 2023/02/26.
//

import UIKit
import NaverThirdPartyLogin
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

class ViewController: UIViewController {
    func googleLoginPase() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            let user = signInResult.user
            
            let emailAddress = user.profile?.email
            
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print(emailAddress as Any)
            print(fullName as Any)
            print(givenName as Any)
            print(familyName as Any)
            print(profilePicUrl as Any)

        }
    }
    
    func kakaoLoginPaser() {
        UserApi.shared.me() {(user, error) in
        if let error = error {
            print(error)
        }
        else {
            print("me() success.")
            //do something
            _ = user
           // self.infoLabel.text = user?.kakaoAccount?.profile?.nickname
            print(user?.kakaoAccount?.profile?.nickname as Any)
            if let url = user?.kakaoAccount?.profile?.profileImageUrl,
               let data = try? Data(contentsOf: url) {
             //   self.profileImageView.image = UIImage(data: data)
                print(data)
            }
        }
    }
    
}
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

                        print("네이버 로그인 이름 ",name)
                        print("네이버 로그인 아이디 ",id)
                        print("네이버 로그인 핸드폰 ",phone)
                        print("네이버 로그인 성별 ",gender)
                        print("네이버 로그인 생년 ",birthyear)
                        print("네이버 로그인 생일 ",birthday)
                        print("네이버 로그인 프로필사진 ",profile)
                        print("네이버 로그인 이메일 ",email)
                        print("네이버 로그인 닉네임 ",nickName)
                        
                    } else {
                        // handle failure response
                    }
                }
            } catch {
                // handle error
            }
        }
        }
    @IBAction func KakaoLoginBtn(_ sender: Any) {
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                // 어세스토큰 (서버분들 한테 드릴 토큰)
                let accessToken = oauthToken?.accessToken
                
                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                self.kakaoLoginPaser()
            }
        }
    }
    @IBAction func NaverLoginBtn(_ sender: Any) {
        naverLoginInstance?.requestThirdPartyLogin()
    }
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    override func viewDidLoad() {
        super.viewDidLoad()
        naverLoginInstance?.delegate = self
        let signInButton = GIDSignInButton()
        
    }

    @IBAction func googleLoginBtn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            self.googleLoginPase()
          }
    }
    @IBAction func NaverLogoutBtn(_ sender: Any) {
        naverLoginInstance?.requestDeleteToken()
    }
    
}
extension ViewController: NaverThirdPartyLoginConnectionDelegate {
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

