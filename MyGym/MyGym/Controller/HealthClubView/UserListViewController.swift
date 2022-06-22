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
        ref.observeSingleEvent(of: .value, with: { snapShot in
            for child in snapShot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["healthClub"] as? String == self.uid){
                    let user = Users()
                    user.name = item?["name"] as? String ?? "nil"
                    user.uid = dataSnapshot?.key ?? "nil"
                    self.userList.append(user)
                }
                self.userListTableView.reloadData()
            }
        })
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
