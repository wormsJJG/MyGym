//
//  FirebaseFuntion.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/15.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import UIKit
class FirebaseFunction{
    var ref = Database.database().reference().child("users")
    let simpleAlert = SimpleAlert()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    	
    //유저 회원가입 함수
    func registerUser(_ email: String, _ password: String, _ name: String,_ viewController: UIViewController) {
        Auth.auth().createUser(withEmail: email, password: password){ (user, err) in
            if user != nil{
                self.ref.child((user?.user.uid)!).setValue(["name": name])
                viewController.navigationController?.popViewController(animated: true)
            }else{
                self.simpleAlert.ErrorAlert("회원가입 실패", "정보들을 다시 확인해주세요", viewController)
                print("Error : \(err!)")
            }
        }
    }
    //유저 로그인 함수
    func loginUser(_ email: String,_ password: String,_ viewController: UIViewController){
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if user != nil {
                let check = self.storyboard.instantiateViewController(withIdentifier: "Check") as! CheckViewController
                check.uid = user?.user.uid ?? "nil"
                viewController.navigationController?.pushViewController(check, animated: true)
            }else{
                self.simpleAlert.ErrorAlert("로그인 실패", "아이디 또는 비밀번호가 일치하지 않습니다.", viewController)
                print("Error : \(err!)")
            }
        }
    }
    //헬스장 목록 가져오기 함수
    func getHealthClubList(_ viewController: GymSelectViewController){
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
                    viewController.healthClubList.append(healthClub)
                }
                viewController.gymListCollectionView.reloadData()
            }
        })
    }

    //헬스장 계정 회원가입 함수
    func registerGym(_ email: String,_ password: String,_ name: String,_ phoneNumber: String,_ location: String,_ viewController: UIViewController){
        Auth.auth().createUser(withEmail: email, password: password){ (HealthClub, err) in
                    if HealthClub != nil{
                        self.ref.child((HealthClub?.user.uid)!).setValue(["name": name, "phoneNumber": phoneNumber, "location": location, "type": "HealthClub"])
                        //pop 2번
                        let viewControllers : [UIViewController] = viewController.navigationController!.viewControllers as [UIViewController]
                        viewController.navigationController?.popToViewController(viewControllers[viewControllers.count - 3 ], animated: true)
                        // --
                    }else{
                        self.simpleAlert.ErrorAlert("회원가입 실패", "정보들을 다시 확인해주세요", viewController)
                        print("Error : \(err!)")
                    }
                }
    }
    //유저의 헬스장 정보 가져오는 함수
    func getUserHealthClubInfo(_ HealthClubuid: String,_ viewController: MyPageViewController){
        ref.child(HealthClubuid).observe(.value, with: { snapShot in
            let value = snapShot.value as? NSDictionary
            let userHealthClubData = UserHealthClubData()
            userHealthClubData.uid = HealthClubuid
            userHealthClubData.name = value?["name"] as? String ?? "nil"
            userHealthClubData.location = value?["location"] as? String ?? "nil"
            userHealthClubData.phoneNumber = value?["phoneNumber"] as? String ?? "nil"
            viewController.userHealthClub = userHealthClubData
            viewController.healthClubView.reloadData()
        })
        
    }
    //유저가 헬스장을 등록하는 함수
    func gymRegistration(_ uid: String,_ healthClubUid: String){
        self.ref.child(uid).updateChildValues(["healthClub":healthClubUid])
    }
    // 헬스장 uid 불러오고 타이틀 수정해주는 함수
    func setViewTitle(_ uid: String,_ viewController: MyPageViewController){
        ref.child(uid).observe(.value, with: {snapShot in
            let value = snapShot.value as? NSDictionary
            let userName = value?["name"] as? String ?? "nil"
            let healthClubUid = value?["healthClub"] as? String ?? "nil"
            viewController.userHealthClubUid = healthClubUid
            viewController.navigationItem.title = "\(userName)님 페이지"
            self.getUserHealthClubInfo(healthClubUid, viewController)
        })
    }
    func getHealthClubUserList(_ uid: String,_ viewController: UserListViewController){
        ref.observeSingleEvent(of: .value, with: { snapShot in
            for child in snapShot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["healthClub"] as? String == uid){
                    let user = Users()
                    user.name = item?["name"] as? String ?? "nil"
                    user.uid = dataSnapshot?.key ?? "nil"
                    viewController.userList.append(user)
                }
                    viewController.userListTableView.reloadData()
            }
        })

    }
    //check
    func check(_ viewController: UIViewController,_ uid: String){
        self.ref.child(uid).observe(.value, with: { snapShot in
            let value = snapShot.value as? NSDictionary
            let type = value?["type"] as? String ?? "nil"
            if(type=="HealthClub"){
                let storyboard = UIStoryboard(name: "HealthClub", bundle: nil)
                let main = storyboard.instantiateViewController(withIdentifier: "main") as! MainViewController
                main.uid = uid
                viewController.navigationController?.pushViewController(main, animated: true)
            }else if(type=="User"){
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let myPageVC = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! MyPageViewController
                myPageVC.userUid = uid
                viewController.navigationController?.pushViewController(myPageVC, animated: true)
            }else{
                let storyboard = UIStoryboard(name: "Trainer", bundle: nil)
                let trainerMainVC = storyboard.instantiateViewController(withIdentifier: "main") as! TrainerMainViewController
                trainerMainVC.uid = uid
                viewController.navigationController?.pushViewController(trainerMainVC, animated: true)
            }
            
        })
    }
}

