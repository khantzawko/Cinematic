//
//  Theatre.swift
//  Cinematic
//
//  Created by Khant Zaw Ko on 28/1/18.
//  Copyright © 2018 Khant Zaw Ko. All rights reserved.
//

import UIKit

struct Theatre {
    var key: String?
    var name: String?
    var showtimes: [String]?
    var theatreType: String?
    var startDate: String?
    var weeksInTheatre: Int?
    var cinemaKey: String?
}

struct Cinema {
    var key: String?
    var name: String?
    var location: String?
    var phone: String?
}

struct Movie {
    var key: String!
    var name: String!
    var genre: String!
    var info: String!
    var image: String!
    var duration: Int!
    var rating: Double!
    var trailer: String!
    var startDate: String!
    var endDate: String!
}

struct Receipt {
    var key: String!
    var amount: Int!
    var email: String!
    var purchasedDate: String!
    var receiptCode: String!
    var ticketInfo: String!
    var movieTime: String!
    var movieID: String!
    var cinemaID: String!
}
