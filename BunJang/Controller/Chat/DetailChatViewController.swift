//
//  DetailChatViewController.swift
//  BunJang
//
//  Created by 최지철 on 2023/03/13.
//

import UIKit

protocol DetailChatViewDelegate: AnyObject{
    func sendData(_chat : Bool)
}
class DetailChatViewController: UIViewController, UITextFieldDelegate, EditViewDelegate {
    func sendData(_edit: Bool) {
        print("데이터삭제~")
        self.delegate?.sendData(_chat: true)
        self.navigationController?.popViewController(animated: true)
        
    }
    weak var delegate: DetailChatViewDelegate?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myNewChat.append(textField.text!)
        textField.text = ""
        tableView.reloadData()
        return true
    }
    

    @IBOutlet weak var textField: UITextField!
    let chatList = MyChat()
    var ChatList:[DetailChat] = []
    var myNewChat:[String] = [""]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatBottomView: UIView!
    
    
    @IBAction func EditClick(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        vc.delegate = self
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
        if ChatList.count == 0 {
            return myNewChat.count
        }
        else{
            return ChatList.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if ChatList.count == 0 {
            if(indexPath.row != 0) {
                guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as? MyChatTableViewCell else {return UITableViewCell()}
                cell.timeLabel.text = "방금"
                cell.myChatBtn.setTitle(myNewChat[indexPath.row], for: .normal)
                let background = UIView()
                   background.backgroundColor = .clear
                   cell.selectedBackgroundView = background
                return cell
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
        return UITableViewCell()

    }
    

    
    
}

