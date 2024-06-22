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
    @EnvironmentObject var sharedData: SharedData
    
//    var allMatches: [MatchDays] {
//        (matchdays ?? []).flatMap{$0}
//    }
    
    var body: some View {
            ZStack {
                NavigationView {
                VStack {
                    VStack(spacing: 0) {
                        ScrollView {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(matchdays ?? [], id: \.matchDayID){ data in
                                        Button(action: {
                                            matchPredictorVM.selectedMatchDay = data.matchDayID
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
                                ForEach(matchdays?[matchdays?.firstIndex(where: { Element in Element.matchDayID == matchPredictorVM.selectedMatchDay}) ?? 0].matches ?? [], id: \.matchid)
                                { match in
//                                    MatchCardView(matchCardDetail: match)
//                                    MatchCardView(matchCardDetail: match, showFirstTeamView: { showFirstTeamView in
//                                        isSheetPresented = showFirstTeamView
//                                    })
//                                    MatchCardView(matchCardDetail: match, showFirstTeamView: { showFirstTeamView, team1Name, team2Name, matchID in
//                                        matchPredictorVM.matchDay.isSheetPresented = showFirstTeamView
//                                        matchPredictorVM.matchDay.team1FstTmVw = team1Name
//                                        matchPredictorVM.matchDay.team2FstTmVw = team2Name
//                                    })
                                    MatchCardView(matchCardDetail: match, showFirstTeamView: { showFirstTeamView, team1Name, team2Name, matchID in
                                                                                matchPredictorVM.matchDay.isSheetPresented = showFirstTeamView
                                                                                matchPredictorVM.matchDay.team1FstTmVw = team1Name
                                                                                matchPredictorVM.matchDay.team2FstTmVw = team2Name
                                    }, matchIDFstTmVw: matchPredictorVM.matchDay.matchIDFstTmVw)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(match.matchid == sharedData.isBoosterApplied ? .yellow : Color.clear)
                                    )
                                    .padding(10)
                                }
                            }
                        }
                    }
                    .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white, points: matchdays?.reduce(0){$0 + ($1.points ?? 0)})
                    .onAppear{
                        matchPredictorVM.matchDays = matchPredictorVM.matchDay.generateRandomMatchDay()
                    }
                    
                }
                .foregroundColor(.white)
                .background(Color.darkBlue000D40)
                .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Match Predictor")
                
                
                }
                
                if matchPredictorVM.matchDay.isSheetPresented {
                    Color.black.opacity(0.3) // Background dimming
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer() // Push the bottom sheet to the bottom
//                        FirstTeamToScoreView {
//                            withAnimation(.easeInOut) {
//                                isSheetPresented = false
//                            }
//                        }
                        FirstTeamToScoreView(matchID: matchPredictorVM.matchDay.matchIDFstTmVw, team1: matchPredictorVM.matchDay.team1FstTmVw, team2: matchPredictorVM.matchDay.team2FstTmVw, onDismiss: {
                                matchPredictorVM.matchDay.isSheetPresented = false
                                
                        }, teamSelected: { teamName, matchID in
                            matchPredictorVM.matchCardDetail.firstTeamToScore = teamName
                            matchPredictorVM.matchDay.matchIDFstTmVw = matchID
                        })
                        .cornerRadius(20)
                        .frame(height: UIScreen.main.bounds.height * 0.25) // 25% of the screen height
                        .offset(y: matchPredictorVM.matchDay.isSheetPresented ? 0 : UIScreen.main.bounds.height)
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: matchPredictorVM.matchDay.isSheetPresented)
            }
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    MatchPredictorView(matchdays: allMatches)
        .environmentObject(SharedData())
}
