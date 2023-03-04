//
//  NavigationBar.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/04.
//

import UIKit

class NavigationBar: UINavigationBar {
    var isTransparent: Bool {
        get {
            return false
        } set {
            self.isTranslucent = newValue
            self.setBackgroundImage(newValue ? UIImage() : nil, for: .default)
            self.shadowImage = newValue ? UIImage() : nil
            self.backgroundColor = newValue ? .clear : nil
        }
    }

}
