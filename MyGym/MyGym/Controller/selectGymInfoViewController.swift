//
//  selectGymInfoViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class selectGymInfoViewController: UIViewController {
    var selectHealthClub: HealthClub!
    @IBOutlet weak var healthClubTitle: UILabel!
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
