//
//  MatchCard.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 17/06/24.
//

import Foundation

struct MatchDay: Identifiable {
    var id: Int?
    var MatchDayNumber: String?
    var points: Int?
    
    func generateRandomMatchDay() -> [MatchDay] {
        var matchDays: [MatchDay] = []
        for i in 1..<4 {
            let newMatchDay = MatchDay(
                id: i,
                MatchDayNumber: "Matchday\(i)",
                points: Int.random(in: 0..<100)
            )
            
            matchDays.append(newMatchDay)
        }
        
        return matchDays
    }
}
