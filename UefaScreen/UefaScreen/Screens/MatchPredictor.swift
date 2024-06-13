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
    
    private struct MatchDay: Identifiable {
        var id: Int
        var MatchDayNumber: String
        var points: Int
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(matchDays){ data in
                            Button(action: {
                                selectedMatchDay = data.id
                            })
                            {
                                VStack {
                                    Text(data.MatchDayNumber)
                                        .foregroundStyle(.white)
                                        .padding(.horizontal,10)
                                        .font(.subheadline)
                                        .padding(.top, data.points > 50 ? 30 : 55)
                                        .bold(selectedMatchDay == data.id && !(data.points > 50))
                                    if data.points > 50 {
                                        Text("\(data.points) pts")
                                            .bold()
                                    }
                                    Rectangle()
                                        .padding(.bottom,-8)
                                        .foregroundStyle(selectedMatchDay == data.id ? .yellow : .clear)
                                }
                                
                            }
                        }
                    }
                    .padding(.leading,20)
                }
                .padding(.top,-10)
                .scrollIndicators(.never)
                
                Divider()
                    .background(.white)
                    .opacity(0.8)
                    .frame(height: 2)
                    .padding(.top,-8)
                
                HStack {
                    Text("24-27 June 2024")
                        .bold()
                        .padding([.leading,.top],10)
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .background(Color("darkBlue000D40"))
            .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white)
            .onAppear{
                generateRandomMatchDay()
            }
            .navigationTitle("Match Predictor")
        }
        
    }
    
    //MARK: Functions
    
    func generateRandomMatchDay() {
        for i in 1..<4 {
            let newMatchDay = MatchDay(
                id: i,
                MatchDayNumber: "Matchday\(i)",
                points: Int.random(in: 0..<500)
            )
            
            matchDays.append(newMatchDay)
        }
        
    }
}

#Preview {
    MatchPredictor()
}
