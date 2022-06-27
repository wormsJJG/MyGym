//
//  UserMenuViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/27.
//

import UIKit

class UserMenuViewController: UIViewController {
    @IBOutlet weak var myGymView: UIView!
    @IBOutlet weak var myPageView: UILabel!
    var userUid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
    }
    func viewSetUp(){
        setGesture()
    }
    func setGesture(){
        let myGymGesture = UITapGestureRecognizer(target: self, action:  #selector(self.myGymClick))
        self.myGymView.addGestureRecognizer(myGymGesture)
        let myPageGesture = UITapGestureRecognizer(target: self, action: #selector(self.myPageClick))
        self.myPageView.addGestureRecognizer(myPageGesture)
    }
    @objc func myGymClick(sender : UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let testVC = storyboard.instantiateViewController(withIdentifier: "TestVC") as! MyPageViewController
        testVC.userUid = self.userUid
        self.navigationController?.pushViewController(testVC, animated: true)
        
    }
    @objc func myPageClick(sender : UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userInfoVC = storyboard.instantiateViewController(withIdentifier: "UserInfoVC") as! AccountInfoViewController
        userInfoVC.userUid = self.userUid
        self.navigationController?.pushViewController(userInfoVC, animated: true)
    }
}
