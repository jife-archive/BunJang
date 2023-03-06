//
//  MenuViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/06.
//

import UIKit
import Tabman
import Pageboy

class MenuViewController: TabmanViewController {
    private var viewControllers: Array<UIViewController> = []
    
    @IBOutlet weak var naviBar: UINavigationBar!
    @IBOutlet weak var tempView: UIView!
    
    @IBAction func CloseClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        naviBar.shadowImage = UIImage()
        let firstVC = storyboard?.instantiateViewController(withIdentifier: "CategoryMenuViewController") as! CategoryMenuViewController
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "BrandMenuViewController") as! BrandMenuViewController
        let thirdVC = storyboard?.instantiateViewController(withIdentifier: "ServiceMenuViewController") as! ServiceMenuViewController//ServiceMenuViewController

        //배열에 추가
        viewControllers.append(firstVC)
        viewControllers.append(secondVC)
        viewControllers.append(thirdVC)

            
            self.dataSource = self

        // Create bar
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
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil))
           }
    
}
extension MenuViewController: PageboyViewControllerDataSource, TMBarDataSource {
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
            return TMBarItem(title: "카테고리")
        case 1:
            return TMBarItem(title: "브랜드")
        case 2:
            return TMBarItem(title: "서비스")
        default:
            return TMBarItem(title: "오류")
        }
    }
    
    
}


