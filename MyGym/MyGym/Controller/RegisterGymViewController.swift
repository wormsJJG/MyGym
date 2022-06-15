//
//  RegisterGymViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/15.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterGymViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var gymNameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    @IBAction func addButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (HealthClub, err) in
                    if HealthClub != nil{
                        self.ref.child((HealthClub?.user.uid)!).setValue(["name": self.gymNameTextField.text!, "phoneNumber": self.phoneNumberTextField.text!, "location": self.locationTextField.text!, "type": "HealthClub"])
                        print("헬스장 등록 완료")
                    }else{
                        print("헬스장 등록 실패")
                    }
                }
    }
    func setView(){
        ref = Database.database().reference().child("users")
        setDelegate()
    }
    func setDelegate(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordCheckTextField.delegate = self
        gymNameTextField.delegate = self
        locationTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
}

extension RegisterGymViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordCheckTextField.becomeFirstResponder()
        case passwordCheckTextField:
            gymNameTextField.becomeFirstResponder()
        case gymNameTextField: locationTextField.becomeFirstResponder()
        case locationTextField:
            phoneNumberTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return false
    }
}
