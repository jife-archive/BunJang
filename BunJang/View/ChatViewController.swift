//
//  ChatViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navi: UINavigationBar!
    
    let chatList = MyChat()
    
    var ChatList:[ChatResult] = []
    var ChatRoom:[Int?] = []
    var myIdx:[Int?] = []
    var useidx:[Int?] = []
    var name:[String?] = []
    var date: [String?] = []
    var lastchat: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        navi.shadowImage = UIImage()
        chatList.getChatList(UseIdx: 3) { ChatResult in
            print("챗리스트완!")
                self.ChatList = ChatResult
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {return UITableViewCell()}
        
        cell.UserNameLabel.text = self.ChatList[indexPath.row].name
        cell.dateLabel.text = self.ChatList[indexPath.row].updateDate
        cell.lastChatLabel.text = self.ChatList[indexPath.row].lastMessage
        let background = UIView()
           background.backgroundColor = .clear
           cell.selectedBackgroundView = background
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailChatViewController")
        pushVC!.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(pushVC!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}
