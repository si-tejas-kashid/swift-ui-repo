//
//  MatchPredictor.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 04/06/24.
//

import SwiftUI

struct MatchPredictorView: View {
    
    var matchdays: [MatchDays]?
    @StateObject var matchPredictorVM = MatchPredictorVM()
//    var allMatches: [MatchDays] {
//        (matchdays ?? []).flatMap{$0}
//    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    ScrollView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(matchdays ?? [], id: \.matchDayID){ data in
                                    Button(action: {
                                        matchPredictorVM.selectedMatchDay = data.matchDayID
//                                        print(data.matchDayID ?? 0)
                                    })
                                    {
                                        VStack {
                                            Text(data.title ?? "Matchday")
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
                                                .foregroundColor(matchPredictorVM.selectedMatchDay == data.matchDayID ? .yellow : .clear)
                                        }
                                        
                                    }
                                }
                                Spacer()
                            }
                            .onAppear{
                                matchPredictorVM.selectedMatchDay = matchdays?.first?.matchDayID
                            }
                            .padding(.leading,20)
                        }
                        .padding(.top,-10)
                        
                        Divider()
                            .background(Color.white)
                            .opacity(0.8)
                            .frame(height: 2)
                            .padding(.top,-8)
                        
                        HStack() {
                            Text("24-27 June 2024")
                                .bold()
                            Spacer()
                            Button (action: {
                                //share button implementation
                            }) {
                                ZStack {
                                    HStack {
                                        RoundedRectangle(cornerRadius: 25.0)
                                            .stroke()
                                            .frame(width: 85, height: 25)
                                    }
                                    
                                    HStack() {
                                        Image(systemName: "square.and.arrow.up")
                                            .resizable()
                                            .frame(width: 10, height: 13)
                                        Text("Share")
                                            .font(.footnote)
                                    }
                                }
                                
                            }
                        }
                        .padding(.horizontal,10)
                        
                        VStack(spacing:0) {
                            ForEach(matchdays?.first?.matches ?? [], id: \.matchid) { match in
                                //                                MatchCardView(boosterApplied: { boosterOn in
                                //                                    matchPredictorVM.isBoosterApplied = boosterOn
                                //                                })
                                MatchCardView(matchCardDetail: match, boosterApplied: { boosterOnMatchId in
                                    matchPredictorVM.isBoosterApplied = boosterOnMatchId
                                })
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .overlay (
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(match.matchid == matchPredictorVM.isBoosterApplied ? .yellow : Color.clear)
                                )
                                .padding(10)
                            }
                        }
                    }
                }
                .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white, points: matchdays?.reduce(0){$0 + ($1.points ?? 0)})
                .onAppear{
                    matchPredictorVM.matchDays = matchPredictorVM.matchDay.generateRandomMatchDay()
                    
//                    matchPredictorVM.selectedMatchDay = matchdays?.first?.id ?? UUID()
                }
                
            }
            .foregroundColor(.white)
            .background(Color.darkBlue000D40)
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Match Predictor")
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MatchPredictorView(matchdays: allMatches)
}
