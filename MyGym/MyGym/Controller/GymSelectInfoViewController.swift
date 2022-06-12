//
//  GymSelectInfoViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/12.
//

import UIKit

class GymSelectInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func addButtonClick(_ sender: Any) {
    }
    func addAlert(_ title: String, _ message: String){
        let addAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default){ (action) in }
        addAlert.addAction(okAction)
        present(addAlert, animated: true)
    }
}
