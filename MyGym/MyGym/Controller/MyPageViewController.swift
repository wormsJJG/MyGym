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
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var btn: UIButton!
    var userUid: String = ""
    var userName: String = ""
    let db = Database.database().reference().child("users")
    let fireFun = FirebaseFunction()
    var healthClubList: [HealthClub] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    func setView(){
        fireFun.setViewTitle(userUid, self)
        UIStyle()
    }
    func UIStyle(){
        accountView.layer.cornerRadius = 30
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 30
        btn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
}

