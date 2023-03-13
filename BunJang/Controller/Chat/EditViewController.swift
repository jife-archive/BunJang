//
//  EditViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit
import PanModal
protocol EditViewDelegate: AnyObject {
    func sendData(_edit : Bool)
    
}
class EditViewController: UIViewController {

    weak var delegate: EditViewDelegate?
    let chatList = MyChat()

    var delete = false
    var deleteIdx: Int?
    @IBAction func GoDelete(_ sender: Any) {
        delete = true
        chatList.deleteChat(chatRoomIdx: deleteIdx!) { DeleteChat in
            self.delegate?.sendData(_edit: self.delete)
            self.dismiss(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
extension EditViewController: PanModalPresentable {
    var panScrollable: UIScrollView?{
        return nil
    }
    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
    var longFormHeight: PanModalHeight{
        return .maxHeightWithTopInset(0)
    }
}

