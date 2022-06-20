//
//  Model.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/11.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class Users{
    var uid: String = "" // primary key
    var name: String = ""
    var trainerUid: String = ""
}

class HealthClub{
    var uid: String = "" //primary key
    var name: String = ""
    var location: String = ""
    var phoneNumber: String = ""
    var type: String = ""
    var userList: [Users] = []
    var trainerList: [Trainer] = []
}
class UserHealthClubData{
    var uid: String = ""
    var name: String = ""
    var location: String = ""
    var phoneNumber: String = ""
}
class Trainer {
    var uid: String = "" // primary key
    var name: String = ""
    var ptDate: [PtDate] = []
    var workPlace: HealthClub = HealthClub()
}
class PtDate{
    var date: Date = Date()
}

