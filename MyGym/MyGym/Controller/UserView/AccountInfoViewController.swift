//
//  AccountInfoViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/19.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class AccountInfoViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var userUid: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
