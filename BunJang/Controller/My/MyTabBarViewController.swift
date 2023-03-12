//
//  MyTabBarViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit
import Pageboy
import Tabman

class MyTabBarViewController: TabmanViewController {

    @IBOutlet weak var TempView: UIView!
    private var viewControllers: Array<UIViewController> = []

    func setUI(){
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "MySaleViewController") as! MySaleViewController
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "MyReviewViewController") as! MyReviewViewController
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "MyHeartViewController") as! MyHeartViewController
        //배열에 추가
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.backgroundView.style = .blur(style: .regular)
        
        //button custom
        bar.buttons.customize { button in
            button.tintColor = .lightGray
            button.selectedTintColor = .black
        }
        
        //indicator custom
        bar.indicator.tintColor = .black
    
        // Add to view
        addBar(bar, dataSource: self, at: .custom(view: TempView, layout: nil))
           
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    

}
extension MyTabBarViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]

    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil

    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "판매상품")
        case 1:
            return TMBarItem(title: "상점후기")
        case 2:
            return TMBarItem(title: "찜목록")
        default:
            return TMBarItem(title: "오류")
        }
    }
    
    
}

