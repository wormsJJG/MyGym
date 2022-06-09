//
//  RegisterViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/08.

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController{
    var ref: DatabaseReference!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passWordConfirmedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    @IBAction func registerButton(_ sender: Any) {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, err) in
                if user != nil{
                    print("회원가입 완료")
                    self.ref.child("users").child((user?.user.uid)!).setValue(["name": self.nameTextField.text!])
                }else{
                    print("회원가입 실패")
                }
        }
    }
    func setView(){
        ref = Database.database().reference()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }
}
extension RegisterViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case nameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
