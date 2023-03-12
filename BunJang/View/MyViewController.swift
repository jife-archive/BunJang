//
//  MyViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit
import Pageboy
import Tabman

class MyViewController: UIViewController {

    @IBOutlet weak var floatBtn: UIButton!
    
    
    @IBOutlet weak var naviBar: UINavigationBar!
    
    
    func setUI(){
        naviBar.shadowImage = UIImage()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
    }
    

}
