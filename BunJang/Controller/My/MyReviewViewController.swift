//
//  MyReviewViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/12.
//

import UIKit

class MyReviewViewController: UIViewController {
    let getAPI = getReview()
    @IBOutlet weak var ReviewCount: UILabel!
    var reviewlist:[GetReviewsList?] = []
    var reviewCount: Int?
    let userinfo = getUserInfo.shared
    @IBOutlet weak var CrySV: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getAPI.Review(userIdx: userinfo.userIdx!) { ReviewResult in
            self.reviewCount = ReviewResult.reviewCount
            self.reviewlist = ReviewResult.getReviewsList!
            print("리뷰리스트연동완!")
            if self.reviewCount == 0 {
                self.CrySV.isHidden = false
            }
            else {
                self.CrySV.isHidden = true
            }
        }
    }

    

   

}
