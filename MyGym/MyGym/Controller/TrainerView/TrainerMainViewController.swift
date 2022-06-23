//
//  TrainerMainViewController.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/19.
//

import UIKit

class TrainerMainViewController: UIViewController {
    @IBOutlet weak var menuListCollectionView: UICollectionView!
    var uid: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
    }
    fileprivate func setView(){
        menuListCollectionView.delegate = self
        menuListCollectionView.dataSource = self
    }
}
extension TrainerMainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TMenuListCollectionViewCell
        setLabel(indexPath.item, cell)
        cell.layer.cornerRadius = 12.0
        return cell
    }
    
    fileprivate func setLabel(_ index: Int,_ cell: TMenuListCollectionViewCell){
        switch index{
        case 0 :
            cell.menuTitleLabel.text = "담당회원목록/관리"
        case 1 :
            cell.menuTitleLabel.text = "피티일정/관리"
        case 2 :
            cell.menuTitleLabel.text = "채팅"
        case 3 :
            cell.menuTitleLabel.text = "계정관리"
        default:
            cell.menuTitleLabel.text = "Error"
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
