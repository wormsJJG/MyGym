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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var gymListCollectionView: UICollectionView!
    let fireFun = FirebaseFunction()
    var healthClubList:[HealthClub] = []
    var filterData: [HealthClub]!
    var searchCount: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    fileprivate func setView(){
        fireFun.getHealthClubList(self)
        gymListCollectionView.reloadData()
        searchBar.delegate = self
    }
}
extension GymSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchCount > 0{
            return filterData.count
        }else{
            return healthClubList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gymListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! gymListCollectionViewCell
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 12.0
        if searchCount > 0 {
            if(filterData[indexPath.item].profileImageUrl != "nil"){
                let url = URL(string: filterData[indexPath.item].profileImageUrl)
                do{
                    let data = try Data(contentsOf: url!)
                    cell.gymImage.image = UIImage(data: data)
                } catch{
                    
                }
            }
            cell.gymTitleLabel.text = filterData[indexPath.item].name
        }else{
            if(healthClubList[indexPath.item].profileImageUrl != "nil"){
            let url = URL(string: healthClubList[indexPath.item].profileImageUrl)
            do{
                let data = try Data(contentsOf: url!)
                cell.gymImage.image = UIImage(data: data)
            } catch{
                
            }
        }
            cell.gymTitleLabel.text = healthClubList[indexPath.item].name
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectHCVC = storyboard.instantiateViewController(withIdentifier: "selectHCVC") as! selectGymInfoViewController
        if searchCount > 0{
            selectHCVC.selectHealthClub = filterData[indexPath.item]
        }else{
            selectHCVC.selectHealthClub = healthClubList[indexPath.item]
        }
        navigationController?.pushViewController(selectHCVC, animated: true)
    }
}
extension GymSelectViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        searchCount += 1
        if searchText == ""{
            filterData = healthClubList
        }
        for healthClub in healthClubList{
            if healthClub.name.contains(searchText.uppercased()){
                filterData.append(healthClub)
            }
        }
        self.gymListCollectionView.reloadData()
    }
}
