//
//  UserListViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/20.
//

import UIKit
import FirebaseDatabase

class UserListViewController: UIViewController {
    @IBOutlet weak var userListTableView: UITableView!
    let ref = Database.database().reference().child("users")
    var uid: String = ""
    var userList: [Users] = []
    let fireFun = FirebaseFunction()
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        userListTableView.delegate = self
        userListTableView.dataSource = self
        fireFun.getHealthClubUserList(uid, self)
    }
}
extension UserListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserListTableViewCell
        cell.userNameLabel.text = userList[indexPath.row].name
        return cell
    }
    
    
}
