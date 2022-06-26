//
//  MainViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var menuListCollectionView: UICollectionView!
    var uid: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        navigationItem.hidesBackButton = true
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuListCollectionViewCell
        setLabel(indexPath.item, cell)
        cell.layer.cornerRadius = 12.0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HealthClub", bundle: nil)
        switch indexPath.item{
        case 0 :
            let userListVC = storyboard.instantiateViewController(withIdentifier: "userListVC") as! UserListViewController
            userListVC.uid = self.uid
            navigationController?.pushViewController(userListVC, animated: true)
        case 1 :
            let trainerListVC = storyboard.instantiateViewController(withIdentifier: "trainerListVC") as! TrainerListViewController
            trainerListVC.healthClubUid = self.uid
            navigationController?.pushViewController(trainerListVC, animated: true)
        default :
            print("Error")
        }
    }
    fileprivate func setLabel(_ index: Int,_ cell: MenuListCollectionViewCell){
        switch index{
        case 0 :
            cell.menuNameLabel.text = "회원목록/관리"
        case 1 :
            cell.menuNameLabel.text = "트레이너 목록/관리"
        case 2 :
            cell.menuNameLabel.text = "헬스장 정보 수정"
        case 3 :
            cell.menuNameLabel.text = "계정관리"
        default:
            cell.menuNameLabel.text = "Error"
        }
    }
}
