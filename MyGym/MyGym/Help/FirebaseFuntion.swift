//
//  FirebaseFuntion.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/15.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
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
                let homeVC = self.storyboard.instantiateViewController(withIdentifier: "HomeVC") as! MyPageViewController
                homeVC.userUid = user?.user.uid ?? "ERROR"
                viewController.navigationController?.pushViewController(homeVC, animated: true)
            }else{
                self.simpleAlert.ErrorAlert("로그인 실패", "아아디 또는 비밀번호가 일치하지않습니다.", viewController)
                print("Error : \(err!)")
            }
        }
    }
    //헬스장 목록 가져오기 함수
    func getHealthClubList(_ collectionView: UICollectionView) -> [HealthClub]{
        var resultList: [HealthClub] = []
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children{
                let dataSnapshot = child as? DataSnapshot
                let item = dataSnapshot?.value as? NSDictionary
                if(item?["type"] as? String == "HealthClub"){
                    var healthClubList: [HealthClub] = []
                    let healthClub = HealthClub()
                    healthClub.name = item?["name"] as! String
                    healthClub.phoneNumber = item?["phoneNumber"] as! String
                    healthClub.location = item?["location"] as! String
                    healthClub.type = item?["type"] as! String
                    healthClubList.append(healthClub)
                    resultList = healthClubList
                }
            }
            
        })
        print(resultList.count)
        return resultList
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
    //헬스장 가져오는 함수
//    func getHealthClubList(){
//        ref.observeSingleEvent(of: .value, with: { snapshot in
//            for child in snapshot.children{
//                let dataSnapshot = child as? DataSnapshot
//                let item = dataSnapshot?.value as? NSDictionary
//                if(item?["type"] as? String == "HealthClub"){
//                    let healthClub = HealthClub()
//                    healthClub.name = item?["name"] as! String
//                    healthClub.phoneNumber = item?["phoneNumber"] as! String
//                    healthClub.location = item?["location"] as! String
//                    healthClub.type = item?["type"] as! String
//                    self.healthClubList.append(healthClub)
//                    self.collectionView.reloadData()
//                }
//            }
//        })
//    }
    // 헬스장 이름 불러오고 타이틀 수정해주는 함수
    func setViewTitle(_ uid: String,_ viewController: UIViewController){
        ref.child(uid).observe(.value, with: {snapShot in
            let value = snapShot.value as? NSDictionary
            let userName = value?["name"] as? String ?? ""
            viewController.navigationItem.title = "\(userName)님 페이지"
        })
    }
}

