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
        print(gymList)
    }
    func FetchGymList(){
            db.observeSingleEvent(of: .value) { snapshot in
                guard let snapData = snapshot.value as? [String: Any] else {return}
                let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
                print(snapData)
                print("\(data)")
//                do{
//                    let decoder = JSONDecoder()
//                    let gymList = try decoder.decode([Gym].self, from: data)
//                    self.gymList = gymList
//                } catch let error{
//                    print("\(error.localizedDescription)")
//                }
        }
    }
    
}
extension GymListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GymListCollectionViewCell
        cell.layer.cornerRadius = 12.0
        return cell
    }
    
    
    
}
struct Gym: Codable{
    var name: String = ""
    var phoneNumber: String = ""
    var location: String = ""
    var type: String = ""
}
