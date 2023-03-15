//
//  ChatViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

class ChatViewController: UIViewController, DetailChatViewDelegate {
    func sendData(_chat: Bool, _message: String) {
        
        if _chat == true {
            self.dummycount = 0
            self.tableView.reloadData()
        }
        else
        {
            if ChatList.count != 0 {
                self.dummycount = 0
                self.tableView.reloadData()
                print("서버용")
            }
            else {
                self.lastchat.append(_message)
                self.newdummy = true
                print("더미용")

                self.tableView.reloadData()

            }
        }

    }
    

    

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navi: UINavigationBar!
    
    var newdummy = false
    let chatList = MyChat()
    let editdelegate = EditViewController()
    var ChatList:[ChatResult] = []
    var ChatRoom:[Int?] = []
    var myIdx:[Int?] = []
    var useidx:[Int?] = []
    var name:[String?] = []
    var date: [String?] = []
    var lastchat: [String?] = []
    var dummycount = 1
    let userinfo = getUserInfo.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        navi.shadowImage = UIImage()
  
    }
    override func viewWillAppear(_ animated: Bool) {
        chatList.getChatList(UseIdx: userinfo.userIdx!) { ChatResult in
            print(ChatResult)
          
                self.ChatList = ChatResult
            
          
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ChatList.count == 0 {
            return dummycount
        }
        else{
            return ChatList.count

        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as? ChatTableViewCell else {return UITableViewCell()}
        
        if ChatList.count == 0 {
            cell.UserNameLabel.text = "더미속의 그대"
            if newdummy == true {
                cell.dateLabel.text = "방금"
                cell.lastChatLabel.text = lastchat[lastchat.count-1]

            }
            else {
                cell.dateLabel.text = "2시간전"
                cell.lastChatLabel.text = "서버야 열려라~"

            }
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
            
        }
        else{
            cell.UserNameLabel.text = self.ChatList[indexPath.row].name
            cell.dateLabel.text = self.ChatList[indexPath.row].updateDate
            cell.lastChatLabel.text = self.ChatList[indexPath.row].lastMessage
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailChatViewController") as! DetailChatViewController
        if ChatList.count == 0 {
            pushVC.getChatRoom = 0
        }
        else
        {
            pushVC.getChatRoom = Int(self.ChatList[indexPath.row].chatRoomIdx)!

        }
        pushVC.hidesBottomBarWhenPushed = true
        pushVC.delegate = self
        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
}
