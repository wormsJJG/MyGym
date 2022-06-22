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
    @IBOutlet weak var healthClubView: UICollectionView!
    var userUid: String = ""
    var userName: String = ""
    var userHealthClubUid: String = ""
    let db = Database.database().reference().child("users")
    let fireFun = FirebaseFunction()
    var userHealthClub = UserHealthClubData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    func setView(){
        fireFun.setViewTitle(userUid, self)
        healthClubView.delegate = self
        healthClubView.dataSource = self
        navigationItem.hidesBackButton = true
//        UIStyle()
    }
//    func UIStyle(){
//        accountView.layer.cornerRadius = 30
//        btn.clipsToBounds = true
//        btn.layer.cornerRadius = 30
//        btn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//    }

    @IBAction func dddddd(_ sender: Any) {
        
    }
    
}
extension MyPageViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = healthClubView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyPageCollectionViewCell
        cell.healthClubTitle.text = userHealthClub.name
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectGymVC = storyboard.instantiateViewController(withIdentifier: "SelectGtmVC") as! GymSelectViewController
        navigationController?.pushViewController(selectGymVC, animated: true)
    }
}

