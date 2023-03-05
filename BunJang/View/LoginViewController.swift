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
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTabbar")
            self.navigationController?.pushViewController(pushVC!, animated: true)
            
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
            if let url = user?.kakaoAccount?.profile?.profileImageUrl,
               let data = try? Data(contentsOf: url) {
             //   self.profileImageView.image = UIImage(data: data)
                print(data)
                let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "mainTabbar")
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
                
                //카카오 로그인을 통해 사용자 토큰을 발급 받은 후 사용자 관리 API 호출
                self.kakaoLoginPaser()
            }
        }
    }
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: [UIImage] = [UIImage(named: "로그인배너1")!, UIImage(named: "로그인배너2")!, UIImage(named: "로그인배너3")!]

    @IBAction func OtherLoginClick(_ sender: Any) {
       /* guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EtcLoginViewController") else {return}*/

      //  vc.modalPresentationStyle = .pageSheet
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EtcLoginViewController") as! EtcLoginViewController
        self.presentPanModal(vc)
      /*  if let sheet = vc.sheetPresentationController {
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
           // present(vc, animated: true, completion: nil)
        }*/
       // self.present(vc, animated: true, completion: nil)
        
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

