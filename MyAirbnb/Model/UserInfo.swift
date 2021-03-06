//
//  UserInfo.swift
//  MyAirbnb
//
//  Created by 행복한 개발자 on 2019/08/05.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

struct UserInfo: Codable {
    let id: Int
    let username: String?
    let email: String?
    let firstName, lastName: String?
    let image: String?
    let description: String?
    let rooms: [Int?]
    var reservations: [[String: Reservation]?]
    var likes: [Int?]
    
    enum CodingKeys: String, CodingKey {
        case id, username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case image
        case description = "description"
        case rooms, reservations
        case likes
    }
}

struct Reservation: Codable {
    let startDate, endDate: String
    let room, id: Int
    let title: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case endDate = "end_date"
        case room, id, title, image
    }
}

