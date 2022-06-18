//
//  GymListViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MyPageViewController: UIViewController {
//    @IBOutlet weak var accountView: UIView!
//    @IBOutlet weak var btn: UIButton!
    var userUid: String = ""
    var userName: String = ""
    var userHealthClubUid: String = ""
    let db = Database.database().reference().child("users")
    let fireFun = FirebaseFunction()
    var userHealthClub = UserHealthClubData()
    
    @IBOutlet weak var healthClubView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    func setView(){
        fireFun.setViewTitle(userUid, self)
        healthClubView.delegate = self
        healthClubView.dataSource = self
//        UIStyle()
    }
//    func UIStyle(){
//        accountView.layer.cornerRadius = 30
//        btn.clipsToBounds = true
//        btn.layer.cornerRadius = 30
//        btn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//    }
    @IBAction func btnLogOut(_ sender: Any) {
        print(userHealthClubUid)
        print(userHealthClub.name)
        print(userHealthClub.location)
        healthClubView.reloadData()
    }
    @IBAction func dddddd(_ sender: Any) {
        print(userHealthClubUid)
        print(userHealthClub.name)
        print(userHealthClub.location)
        healthClubView.reloadData()
    }
    
}
extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = healthClubView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GymListCollectionViewCell
        cell.gymNameLabel.text = userHealthClub.name
        return cell
    }
}

