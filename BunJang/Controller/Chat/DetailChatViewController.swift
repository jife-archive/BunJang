//
//  DetailChatViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class DetailChatViewController: UIViewController {

    let chatList = MyChat()
    var ChatList:[DetailChat] = []

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatBottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "YoutChatTableViewCell", bundle: nil), forCellReuseIdentifier: "YoutChatTableViewCell")
        self.tableView.register(UINib(nibName: "MyChatTableViewCell", bundle: nil), forCellReuseIdentifier: "MyChatTableViewCell")
        chatList.getDetailChat(Chatroom: 2) { DetailChat in
            print("!!성공!")
            self.ChatList = DetailChat
            print(self.ChatList)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }
    
}
extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(ChatList[indexPath.row].userIdx == 3) {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as? MyChatTableViewCell else {return UITableViewCell()}
            cell.timeLabel.text = ChatList[indexPath.row].updateAt
            cell.myChatBtn.setTitle(ChatList[indexPath.row].message, for: .normal)
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }
        else
        {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "YoutChatTableViewCell", for: indexPath) as? YoutChatTableViewCell else {return UITableViewCell()}
            cell.timeLabe.text = ChatList[indexPath.row].updateAt
            cell.yourChatBtn.setTitle(ChatList[indexPath.row].message, for: .normal)

            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }
    }
    

    
    
}

