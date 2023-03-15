//
//  DetailChatViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

protocol DetailChatViewDelegate: AnyObject{
    func sendData(_chat : Bool, _message : String)
}
class DetailChatViewController: UIViewController, UITextFieldDelegate, EditViewDelegate {
    func sendData(_edit: Bool) {
        print("데이터삭제~")
        self.delegate?.sendData(_chat: true , _message: "")
        self.navigationController?.popViewController(animated: true)
    }
    
    let sendM = sendMessage()
    let userinfo = getUserInfo.shared
    
    weak var delegate: DetailChatViewDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if ChatList.count == 0{
            myNewChat.append(textField.text!)
            userinfo.msg.append(textField.text!)
            tableView.reloadData()
            print( userinfo.msg )
            print(userinfo.msg.count)
            print( myNewChat )
            print( myNewChat.count)
            textField.text = ""
            self.delegate?.sendData(_chat: false, _message: myNewChat[myNewChat.count-1]!)
            return true
        }
        else
        {
            let para = SendChats(message: textField.text!, chatRoomIdx: getChatRoom!)
            sendM.giveMessage(userIdx: userinfo.userIdx!, parameters: para) { SendChatsResponse in
                
            print("메세지 성공!")
                self.myNewChat.append(textField.text!)
                self.textField.text = ""
            self.tableView.reloadData()
                
            }
            return true

        }
    }
    

    @IBOutlet weak var textField: UITextField!
    let chatList = MyChat()
    var ChatList:[DetailChat] = []
    var myNewChat:[String?] = [""]
    var getChatRoom: Int?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatBottomView: UIView!
    var yourrate: Double?
    var yourname: String?
    
    @IBAction func EditClick(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc.delegate = self
        vc.deleteIdx = getChatRoom
        self.presentPanModal(vc)
    }
    
    @IBAction func GoBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "YoutChatTableViewCell", bundle: nil), forCellReuseIdentifier: "YoutChatTableViewCell")
        self.tableView.register(UINib(nibName: "MyChatTableViewCell", bundle: nil), forCellReuseIdentifier: "MyChatTableViewCell")
        print(myNewChat.count)
        print("로드")
        print(myNewChat)
        print(getChatRoom as Any)
        if getChatRoom != 0 {
            chatList.getDetailChat(Chatroom: getChatRoom!) { DetailChat in
                self.ChatList = DetailChat
                print(self.ChatList)
                for i in 0...1 {
                    if(self.ChatList[i].userIdx != self.userinfo.userIdx)
                    {
                        self.yourname = self.ChatList[i].name
                        self.yourrate = self.ChatList[i].avgStar

                    }
                    print("챗내용불러")
                }
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    self.nameLabel.text = self.yourname
                    
                    
                }
            }
        }
        else{
            self.nameLabel.text  = "더미속의 그대"
        }
    }
    
}
extension DetailChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ChatList.count == 0 {
            if userinfo.msg.count != 0 {
                return userinfo.msg.count + 1
            }
            else{
                return myNewChat.count

            }
        }
        else{
            return ChatList.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if ChatList.count == 0 {
            if(indexPath.row != 0) {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as? MyChatTableViewCell else {return UITableViewCell()}
                
                if myNewChat.count == 1 {
                    cell.timeLabel.text = "방금"
                        cell.myChatBtn.setTitle(userinfo.msg[0], for: .normal)

                
                    let background = UIView()
                    
                       background.backgroundColor = .clear
                       cell.selectedBackgroundView = background
                       cell.selectedBackgroundView = background
                    return cell
                    
                }else{
                    cell.timeLabel.text = "방금"
                    print("지역")
                    print(myNewChat[indexPath.row-1] as Any)
                    cell.myChatBtn.setTitle(myNewChat[indexPath.row], for: .normal)
                    let background = UIView()
                       background.backgroundColor = .clear
                       cell.selectedBackgroundView = background
                    return cell
                    
                }
            }
            else
            {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "YoutChatTableViewCell", for: indexPath) as? YoutChatTableViewCell else {return UITableViewCell()}
                cell.timeLabe.text = "2시간전"
                cell.yourChatBtn.setTitle("서버야 열려라~", for: .normal)

                let background = UIView()
                   background.backgroundColor = .clear
                   cell.selectedBackgroundView = background
                return cell
            }
        }
        else{
            if(ChatList[indexPath.row].userIdx == userinfo.userIdx) {
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
    

    
    
}

