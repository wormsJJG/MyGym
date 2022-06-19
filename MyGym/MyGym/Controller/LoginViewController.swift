//
//  LoginViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/07.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController{
    var ref: DatabaseReference = DatabaseReference()
    let fireFun = FirebaseFunction()
    let simpleAlert = SimpleAlert()
    var authResult: Int = 1
    
    @IBOutlet weak var LogoImages: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        text()
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        if idTextField.text?.count ?? 0 < 7{
            simpleAlert.ErrorAlert("아이디를 정확히 입력해주세요", "", self)
            return
        }
        if passWordTextField.text?.count ?? 0 < 8{
            simpleAlert.ErrorAlert("비밀번호를 정확히 입력해주세요.", "", self)
            return
        }
        fireFun.loginUser(idTextField.text!, passWordTextField.text!, self)
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    func setView(){
        idTextField.delegate = self
        passWordTextField.delegate = self
    }
    func text(){
        idTextField.text = "tldn1234@gmail.com"
        passWordTextField.text = "worms1837"
    }
}
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case idTextField:
            passWordTextField.becomeFirstResponder()
        default :
            textField.resignFirstResponder()
        }
        return false
    }
    
}
