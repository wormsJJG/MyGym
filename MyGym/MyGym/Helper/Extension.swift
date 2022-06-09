//
//  Extension.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/09.
//

import UIKit

public class Extension: UIAlertController{
    // ErrorAlert
    func ErrorAlert(_ title: String, _ message: String){
        let ErrorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default){ (action) in }
        ErrorAlert.addAction(okAction)
        present(ErrorAlert, animated: true)
    }
}
