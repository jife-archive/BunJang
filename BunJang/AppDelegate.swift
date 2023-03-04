//
//  AppDelegate.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
                //네이버 앱으로 인증하는 방식 활성화
                instance?.isNaverAppOauthEnable = true
                //SafariViewController에서 인증하는 방식 활성화
                instance?.isInAppOauthEnable = true
                //인증 화면을 아이폰의 세로모드에서만 적용
                instance?.isOnlyPortraitSupportedInIphone()
                
                instance?.serviceUrlScheme = "naverlogin"
                instance?.consumerKey = "qKkNxsymAfgEFZlJFY0t"
                instance?.consumerSecret = "CiJ3Ho9U6j"
                instance?.appName = "rising"
        
        KakaoSDK.initSDK(appKey: "f1e1d77c066b35bc584bd86059cad666")
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                return AuthController.handleOpenUrl(url: url)
            }
        return true
}
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

