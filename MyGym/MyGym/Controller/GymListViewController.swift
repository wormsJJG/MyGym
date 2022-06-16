//
//  GymListViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/09.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class GymListViewController: UIViewController {
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
    }
    
    
}

