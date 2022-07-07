//
//  GymSelectViewController.swift
//  MyGym
//
//  Created by Schro on 2022/06/12.
//

import UIKit
import FirebaseDatabase

class ImageCacheManager{
    static let shared = NSCache<NSString, UIImage>()
    private init (){}
}
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
        getHealthClubList()
    }
    fileprivate func setView(){
        gymListCollectionView.delegate = self
        gymListCollectionView.dataSource = self
        searchBar.delegate = self
    }
    func getHealthClubList(){
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["type"] as? String == "HealthClub"){
                    let healthClub = HealthClub()
                    healthClub.name = item?["name"] as! String
                    healthClub.phoneNumber = item?["phoneNumber"] as! String
                    healthClub.location = item?["location"] as! String
                    healthClub.type = item?["type"] as! String
                    healthClub.profileImageUrl = item?["profileImageUrl"] as? String ?? "nil"
                    self.healthClubList.append(healthClub)
                }
            }
            self.gymListCollectionView.reloadData()
        })
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
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 12.0
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.gymImage.layer.cornerRadius = 12.0
        if searchCount > 0 {
                    if(filterData[indexPath.item].profileImageUrl != "nil"){
                        let url = filterData[indexPath.item].profileImageUrl
                        let cacheKey = NSString(string: url)
                            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey){
                                print("use cached Image")
                                cell.gymImage.image = cachedImage
                            }
                        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, err) in
                                    print("get Image from url")
                                    DispatchQueue.main.async {
                                        if let data = data , let image = UIImage(data: data){
                                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)

                                            cell.gymImage.image = image
                                        }
                          
                                       
                                    }
                                }.resume()
                    }
                    cell.gymTitleLabel.text = filterData[indexPath.item].name
                }else{
                    if(healthClubList[indexPath.item].profileImageUrl != "nil"){
                        let url = healthClubList[indexPath.item].profileImageUrl
                        let cacheKey = NSString(string: url)
                            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey){
                                print("use cached Image")
                                cell.gymImage.image = cachedImage
                            }
                        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, err) in
                                    print("get Image from url")
                                    DispatchQueue.main.async {
                                        if let data = data , let image = UIImage(data: data){
                                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)

                                            cell.gymImage.image = image
                                        }
                          
                                       
                                    }
                                }.resume()
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
