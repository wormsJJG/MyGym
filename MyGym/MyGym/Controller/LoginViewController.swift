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
    @IBOutlet weak var LogoImages: UIImageView!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        if idTextField.text?.count ?? 0 < 7{
            ErrorAlert("아이디를 정확히 입력해주세요", "")
            return
        }
        if passWordTextField.text?.count ?? 0 < 8{
            ErrorAlert("비밀번호를 정확히 입력해주세요.", "")
            return
        }
            Auth.auth().signIn(withEmail: idTextField.text!, password: passWordTextField.text!) { (user, err) in
                if user != nil {
                    print("로그인 성공")
                }else{
                    self.ErrorAlert("로그인 실패", "아아디 또는 비밀번호가 일치하지않습니다.")
                }
            }
    }
    @IBAction func registerButton(_ sender: Any) {
    }
    func setView(){
//        if let user = Auth.auth().currentUser {
//            print("이미 로그인 된 상태입니다.")
//        }
        
        idTextField.delegate = self
        passWordTextField.delegate = self
    }
    func ErrorAlert(_ title: String, _ message: String){
        let ErrorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default){ (action) in }
        ErrorAlert.addAction(okAction)
        present(ErrorAlert, animated: true)
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
