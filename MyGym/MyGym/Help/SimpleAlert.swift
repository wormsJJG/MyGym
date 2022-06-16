//
//  SimpleAlert.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/15.
//

import Foundation
import UIKit

class SimpleAlert: UIAlertController{
    func ErrorAlert(_ title: String, _ message: String,_ viewController: UIViewController){
        let ErrorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default){ (action) in }
        ErrorAlert.addAction(okAction)
        viewController.present(ErrorAlert, animated: true)
    }
}
