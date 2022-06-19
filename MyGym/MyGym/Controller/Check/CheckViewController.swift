//
//  CheckViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class CheckViewController: UIViewController {
    var uid: String = ""
    let fireFun = FirebaseFunction()
    override func viewDidLoad() {
        super.viewDidLoad()
        fireFun.check(self, uid)
    }
}
