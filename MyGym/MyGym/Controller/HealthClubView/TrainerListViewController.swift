//
//  TrainerListViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/26.
//

import UIKit

class TrainerListViewController: UIViewController {
    @IBOutlet weak var trainerListCollectionView: UICollectionView!
    let fireFun = FirebaseFunction()
    var healthClubUid: String = ""
    var trainerList: [Trainer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        fireFun.getTrainerList(healthClubUid, self)
    }
}
extension TrainerListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trainerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trainerListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrainerListCollectionViewCell
        cell.layer.cornerRadius = 12.0
        cell.trainerName.text = trainerList[indexPath.item].name
        cell.trainerPhoneNumber.text = trainerList[indexPath.item].phoneNumber
        return cell
    }
    
    
}
