//
//  MatchPredictorVM.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 17/06/24.
//

import Foundation

@MainActor class MatchPredictorVM: ObservableObject {
    @Published var matchDay = MatchDay()
    @Published var matchCardDetail = MatchCard()
    
    // @Published var selectedMatchDay: Int?
    @Published var matchDays: [MatchDay] = []
    @Published var isBoosterApplied: String?
    
    // Ajinkya
    @Published var allMatchDaysArr: [MatchDays] = allMatches
    @Published var selectedMatches: [MatchSelectionData] = [] 
    @Published var selectedMatchDay: Int?
}


struct MatchSelectionData {
    var matchId: String?
    var selectedPrediction: PopularPrediction? = nil
}
