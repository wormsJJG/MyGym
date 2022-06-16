//
//  GymListViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/09.
//

import UIKit
import FirebaseDatabase

class GymListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let db = Database.database().reference().child("users")
    let fireFun = FirebaseFunction()
    var healthClubList: [HealthClub] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    func setView(){
//        getHealthClubList()
    }
    
    
}
extension GymListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return healthClubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GymListCollectionViewCell
        cell.layer.cornerRadius = 12.0
        cell.gymNameLabel.text = healthClubList[indexPath.item].name
        cell.detailLabel.text = healthClubList[indexPath.item].location
        return cell
    }
}
