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
    let fireFun = FirebaseFunction()
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
        fireFun.registerGym(emailTextField.text!, passwordTextField.text!, gymNameTextField.text!, phoneNumberTextField.text!, locationTextField.text!, self)
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
