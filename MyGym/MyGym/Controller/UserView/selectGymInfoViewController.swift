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
    @IBOutlet weak var healthClubLocation: UITextView!
    @IBOutlet weak var healthClubPhoneNumber: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        setSelectHealthInfo()
    }
    fileprivate func setSelectHealthInfo(){
        healthClubTitle.text = selectHealthClub.name
        healthClubLocation.text = "주소: \(selectHealthClub.location)"
        healthClubPhoneNumber.text = "전화번호: \(selectHealthClub.phoneNumber)"
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
