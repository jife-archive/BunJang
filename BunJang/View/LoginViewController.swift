//
//  LoginViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import Alamofire

class LoginViewController: UIViewController, UIScrollViewDelegate, UISheetPresentationControllerDelegate, ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    let login = sendLogin()
    let follo = follow()

    let kakao = LoginKakao()
    let userinfo = getUserInfo.shared

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
            // 계정 정보 가져오기
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
                
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
        default:
            break
        }
    }
        
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
    @IBAction func appleLoginClick(_ sender: Any) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
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
            print(user?.kakaoAccount?.profile?.profileImageUrl as Any)

            if let url = user?.kakaoAccount?.profile?.profileImageUrl,
               let data = try? Data(contentsOf: url) {
             //   self.profileImageView.image = UIImage(data: data)
                print(data)
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
                self.navigationController?.pushViewController(pushVC!, animated: true)
                
                
            }
        }
    }
    
}

    @IBAction func KakaoLoginClick(_ sender: Any) {
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
                // accessToken
   
                self.kakao.sendKakao(code: accessToken!) { WelecomeKakaoLogin in
                    print("카카오로그인성공~!")
                    //self.userinfo.userIdx = 3

                }
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
                         print(self.userinfo.jwt)

                     }
                     //userinfo.userIdx = 3
                     let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBar_ViewController")
                     pushVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                     self.present(pushVC!, animated: true, completion: nil)
                 }
                print(accessToken as Any)
                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                self.kakaoLoginPaser()
            }
        }
    }
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = [UIImage(named: "로그인배너1")!, UIImage(named: "로그인배너2")!, UIImage(named: "로그인배너3")!]

    @IBAction func OtherLoginClick(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EtcLoginViewController") as! EtcLoginViewController
        self.presentPanModal(vc)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            imageView.image = images[i]
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        pageControl.numberOfPages = images.count

        // Do any additional setup after loading the view.
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
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

