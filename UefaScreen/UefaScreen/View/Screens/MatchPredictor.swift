//
//  MatchPredictor.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 04/06/24.
//

import SwiftUI

struct MatchPredictor: View {
    
    @State private var selectedMatchDay: Int = 1
    @State private var matchDays: [MatchDay] = []
    @State private var isBoosterApplied: Bool = false
    @StateObject var matchPredictorVM = MatchPredictorVM()
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(matchDays){ data in
                                    Button(action: {
                                        selectedMatchDay = data.id ?? 0
                                    })
                                    {
                                        VStack {
                                            Text(data.MatchDayNumber ?? "Matchday")
                                                .foregroundColor(.white)
                                                .padding(.horizontal,10)
                                                .font(.subheadline)
                                                .padding(.top, data.points ?? 0 > 50 ? 20 : 45)
                                                .font(.system(size: 10, weight: .bold))
                                            if data.points ?? 0 > 50 {
                                                Text("\(data.points ?? 0) pts")
                                                    .bold()
                                            }
                                            Rectangle()
                                                .padding(.bottom,-8)
                                                .foregroundColor(selectedMatchDay == data.id ? .yellow : .clear)
                                        }
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.leading,20)
                        }
                        .padding(.top,-10)
                    
                    Divider()
                        .background(Color.white)
                        .opacity(0.8)
                        .frame(height: 2)
                        .padding(.top,-8)
                    
                        HStack {
                            Text("24-27 June 2024")
                                .bold()
                            Spacer()
                            Button (action: {
                                //share button implementation
                            }) {
                                ZStack {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .frame(width: 10, height: 13)
                                        Text("Share")
                                            .font(.footnote)
                                    }
                                    .padding(.vertical,6)
                                    .padding(.horizontal,16)
//                                    .overlay {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .stroke()
//                                }
                                }
                                
                            }
                            
                        }
                        .padding(.horizontal,10)
                    
                    VStack(spacing:0) {
                        ForEach(0..<4) { _ in
                            ZStack {
                                MatchCard(boosterApplied: { boosterOn in
                                    isBoosterApplied = boosterOn
                                })
                                .clipShape(RoundedRectangle(cornerRadius: 15))
//                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(isBoosterApplied ? .yellow : Color.clear)
//                                }
                            
                            }
                            .padding(10)
                        }
                    }
                }
            }
            .foregroundColor(.white)
            .background(Color.darkBlue000D40)
            .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white, points: matchDays.reduce(0){$0 + ($1.points ?? 0)})
            .onAppear{
                matchDays = matchPredictorVM.matchDay.generateRandomMatchDay()
            }
            .navigationTitle("Match Predictor")
        }
    }
    
    //MARK: Functions
    
//    func generateRandomMatchDay() {
//        for i in 1..<4 {
//            let newMatchDay = MatchDay(
//                id: i,
//                MatchDayNumber: "Matchday\(i)",
//                points: Int.random(in: 0..<100)
//            )
//            
//            matchDays.append(newMatchDay)
//        }
//        
//    }
}

#Preview {
    MatchPredictor()
}
