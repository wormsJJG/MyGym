//
//  GymListViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/09.
//

import UIKit
import FirebaseDatabase

class GymListViewController: UIViewController {
    let type = "HealthClub"
    let db = Database.database().reference().child("users")
    var gymList: [Gym] = []
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    func setView(){
        FetchGymList()
    }
    func FetchGymList(){
        db.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["type"] as? String == self.type){
                    var gym = Gym()
                    gym.name = item?["name"] as! String
                    gym.phoneNumber = item?["phoneNumber"] as! String
                    gym.location = item?["location"] as! String
                    gym.type = item?["type"] as! String
                    self.gymList.append(gym)
                    self.collectionView.reloadData()
                }
                
            }
        })
    }
    
}
extension GymListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gymList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GymListCollectionViewCell
        cell.layer.cornerRadius = 12.0
        cell.gymNameLabel.text = gymList[indexPath.item].name
        cell.detailLabel.text = gymList[indexPath.item].location
        return cell
    }
    
    
    
}
struct Gym: Codable{
    var name: String = ""
    var phoneNumber: String = ""
    var location: String = ""
    var type: String = ""
}
