//
//  selectGymInfoViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class selectGymInfoViewController: UIViewController {
    var selectHealthClub: HealthClub!
    
    @IBOutlet weak var healthClubImage: UIImageView!
    @IBOutlet weak var healthClubTitle: UILabel!
    @IBOutlet weak var healthClubLocation: UILabel!
    @IBOutlet weak var healthClubPhoneNumber: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        setSelectHealthInfo()
    }
    fileprivate func setSelectHealthInfo(){
        if(selectHealthClub.profileImageUrl != "nil"){
            let url = URL(string: selectHealthClub.profileImageUrl)
            do{
                let data = try Data(contentsOf: url!)
                healthClubImage.image = UIImage(data: data)
            } catch{
                
            }
        }
        healthClubTitle.text = selectHealthClub.name
        healthClubLocation.text = "주소: \(selectHealthClub.location)"
        healthClubPhoneNumber.text = "주소: \(selectHealthClub.phoneNumber)"
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
