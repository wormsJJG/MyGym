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
        getHealthClubList()
    }
    func getHealthClubList(){
        db.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["type"] as? String == "HealthClub"){
                    let healthClub = HealthClub()
                    healthClub.name = item?["name"] as! String
                    healthClub.phoneNumber = item?["phoneNumber"] as! String
                    healthClub.location = item?["location"] as! String
                    healthClub.type = item?["type"] as! String
                    self.healthClubList.append(healthClub)
                    self.collectionView.reloadData()
                }
            }
        })
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
