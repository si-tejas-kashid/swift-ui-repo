//
//  MatchPredictorViewEnhanced.swift
//  UefaScreen
//
//  Created by Nausheen Khan on 25/06/24.
//

import SwiftUI

struct MatchPredictorViewEnhanced: View {
    @StateObject var viewModel = MatchPredictorVM()
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    MatchPredictorMenuSelectionView(viewModel: viewModel)
                    MatchPredictorShareView(viewModel: viewModel)
                    
                    if let selectedMatchDay = viewModel.allMatchDaysArr.first(where: {$0.matchDayID == viewModel.selectedMatchDay}) {
                        ForEach(selectedMatchDay.matches ?? []) { matchDetails in
                            MatchCardViewEnhanced(matchDetails: matchDetails)
                        }
                    }
                    
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white, points: viewModel.allMatchDaysArr.reduce(0){$0 + ($1.points ?? 0)})
        .foregroundColor(.white)
        .background(Color.darkBlue000D40)
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("Match Predictor")
        .onAppear {
            viewModel.selectedMatchDay = viewModel.allMatchDaysArr.first?.matchDayID
        }
        .environmentObject(viewModel)
    }
}

// MARK: - MATCH PREDICTOR MENU SELECTION VIEW
struct MatchPredictorMenuSelectionView: View {
    @ObservedObject var viewModel: MatchPredictorVM
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.allMatchDaysArr, id: \.matchDayID) { data in
                        Button {
                            viewModel.selectedMatchDay = data.matchDayID
                        } label: {
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
                                    .foregroundColor(viewModel.selectedMatchDay == data.matchDayID ? .yellow : .clear)
                            }
                        }
                    }
                }
                .padding(.leading,20)
            }
            .padding(.top,-10)
            
            Divider()
                .background(Color.white)
                .opacity(0.8)
                .frame(height: 2)
                .padding(.top,-8)
        }
    }
}

// MARK: - MATCH PREDICTOR SHARE VIEW
struct MatchPredictorShareView: View {
    @ObservedObject var viewModel: MatchPredictorVM
    
    var body: some View {
        HStack() {
            Text(viewModel.allMatchDaysArr.first(where: {$0.matchDayID == viewModel.selectedMatchDay})?.dateRange ?? "")
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
    }
}

#Preview {
    MatchPredictorViewEnhanced()
}
