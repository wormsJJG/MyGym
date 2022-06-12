//
//  Model.swift
//  MyGym
//
//  Created by 정재근 on 2022/06/11.
//

import Foundation

class Auth {
    var id: String = ""
    var password: String = ""
    var uid: String = "" //foreign key
}
class Users {
    var uid: String = "" // primary key
    var name: String = ""
    var attendingHealthClub: HealthClub = HealthClub()
    var ptDate: [PtDate] = []
}
//class HealthClub{
//    var uid: String = "" //primary key
//    var clubName: String = ""
//    var clubLocation: String = ""
//    var clubPhoneNumber: String = ""
//    //clubImages
//    var trainerList: [Trainer] = []
//}
class Trainer {
    var uid: String = "" // primary key
    var name: String = ""
    var ptDate: [PtDate] = []
    var workPlace: HealthClub = HealthClub()
}
class PtDate{
    var date: Date = Date()
}

