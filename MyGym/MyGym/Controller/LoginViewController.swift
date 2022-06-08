//
//  LoginViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/07.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var LogoImages: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = Auth.auth().currentUser {
            print("이미 로그인 된 상태입니다.")
        }
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: idTextField.text!, password: passWordTextField.text!) { (user, err) in
            if user != nil {
                print("로그인 성공")
            }else{
                print("로그인 실패")
            }
        }
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    func setView(){
        
    }
}
