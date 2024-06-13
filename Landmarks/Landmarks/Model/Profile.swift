//
//  Profile.swift
//  Landmarks
//
//  Created by Tejas Kashid on 08/04/24.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.autumn
    var goalDate = Date()


    static let `default` = Profile(username: "Kashid")


    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"


        var id: String { rawValue }
    }
}
