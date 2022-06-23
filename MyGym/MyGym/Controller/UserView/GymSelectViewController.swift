//
//  GymSelectViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/12.
//

import UIKit
import FirebaseDatabase
class GymSelectViewController: UIViewController {
    let ref = Database.database().reference().child("users")
    @IBOutlet weak var gymListCollectionView: UICollectionView!
    let fireFun = FirebaseFunction()
    var healthClubList:[HealthClub] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        fireFun.getHealthClubList(self)
    }
}
extension GymSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthClubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gymListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! gymListCollectionViewCell
        cell.gymTitleLabel.text = healthClubList[indexPath.item].name
        cell.backgroundColor = .red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectHCVC = storyboard.instantiateViewController(withIdentifier: "selectHCVC") as! selectGymInfoViewController
        selectHCVC.selectHealthClub = healthClubList[indexPath.item]
        navigationController?.pushViewController(selectHCVC, animated: true)
    }
    
}
