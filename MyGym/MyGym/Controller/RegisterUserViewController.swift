//
//  RegisterUserViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/08.

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterUserViewController: UIViewController{
    var ref: DatabaseReference!
    
    
        @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passWordConfirmedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()

//            }
//        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if nameTextField.text?.count ?? 0 < 2{
            ErrorAlert("이름을 정확히 입력해주세요.", "")
            return
        }
        if emailTextField.text?.count ?? 0 < 9{
            ErrorAlert("이메일을 정확히 입력해주세요.", "")
            return
        }
        if passwordTextField.text?.count ?? 0 < 8{
            ErrorAlert("비밀번호를 정확히 입력해주세요.", "비밀번호는 8자리 이상으로 입력해주세요.")
            return
        }
        if passwordTextField.text! != confirmTextField.text!{
            ErrorAlert("비밀번호가 같지 않습니다.", "")
            return
        }
        
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
        setDelegate()
    }
    func ErrorAlert(_ title: String, _ message: String){
        let ErrorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default){ (action) in }
        ErrorAlert.addAction(okAction)
        present(ErrorAlert, animated: true)
    }
    func setDelegate(){
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
    }
}
extension RegisterUserViewController: UITextFieldDelegate{
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
