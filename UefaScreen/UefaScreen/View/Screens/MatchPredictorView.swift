//
//  MatchPredictor.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 04/06/24.
//

import SwiftUI

struct MatchPredictorView: View {
    
    var matchdays: [MatchDays]?
    @StateObject var viewModel = MatchPredictorVM()
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            Spacer(minLength: sharedData.orientation.isLandscape ? 50 : 0)
                            ScrollViewReader { proxy in
                                ScrollView {
                                    LazyVStack(pinnedViews: [.sectionHeaders]) {
                                        Section(header: matchPredictorHeaderView) {
                                            
                                            HStack() {
                                                Text(matchdays?[matchdays?.firstIndex(where: { Element in Element.matchDayID == viewModel.selectedMatchDay}) ?? 0].dateRange ?? "")
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
                                                ForEach(matchdays?[matchdays?.firstIndex(where: { element in element.matchDayID == viewModel.selectedMatchDay}) ?? 0].matches ?? [], id: \.matchid)
                                                { match in
                                                    MatchCardView(matchCardDetail: match)
                                                        .id(match.matchid)
                                                        .onTapGesture {
                                                            withAnimation {
                                                                proxy.scrollTo(match.matchid, anchor: .center)
                                                            }
                                                        }
                                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                                        .overlay (
                                                            RoundedRectangle(cornerRadius: 15)
                                                                .stroke(lineWidth: 2)
                                                                .foregroundColor(match.matchid == viewModel.boosterAppliedMatchID ? .yellow : Color.clear)
                                                        )
                                                        .padding(10)
                                                }
                                            }
                                        }
                                        .id("top")
                                    }
                                    .onChange(of: viewModel.selectedMatchDay) { _ in
                                        withAnimation() {
                                            proxy.scrollTo("top")
                                        }
                                    }
                                }
                                
                            }
                            Spacer(minLength: sharedData.orientation.isLandscape ? 50 : 0)
                        }
                        .navigationBarStyle(backgroundImage: "QSDKNavigationBG", titleColor: .white, points: matchdays?.reduce(0){$0 + ($1.points ?? 0)})
                    }
                }
                .foregroundColor(.white)
                .background(Color.darkBlue000D40)
                .ignoresSafeArea(edges: .bottom)
                .ignoresSafeArea(edges: .horizontal)
                .navigationTitle("Match Predictor")
            }
            
                        if viewModel.showFirstTeamView || viewModel.showLastFiveMatchView {
                            Color.black.opacity(0.3)
                                .edgesIgnoringSafeArea(.all)
            
                            VStack {
                                Spacer()
                                if let matchCardDetail = viewModel.selectedMatchCardDetail,
                                   viewModel.showLastFiveMatchView {
                                    VStack {
                                        Spacer()
                                        LastFiveMatchesView(match: matchCardDetail)
                                            .cornerRadius(20, corners: [.topLeft, .topRight])
                                        .animation(.easeInOut, value: viewModel.showLastFiveMatchView)
                                    }
                                }
            
                                if let matchCardDetail = viewModel.selectedMatchCardDetail,
                                   viewModel.showFirstTeamView{
                                    VStack {
                                        Spacer()
                                        FirstTeamToScoreView(match: matchCardDetail,
                                            teamSelected: { teamName in
                                            viewModel.storeData(matchid: matchCardDetail.matchid ?? String(), firstTeamSelected: teamName)
                                        })
                                        .cornerRadius(20, corners: [.topLeft, .topRight])
            //                            .cornerRadius(20)
            
                                    }
                                }
                            }
                            .edgesIgnoringSafeArea(.bottom)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: viewModel.showFirstTeamView)
                        }
            
        }
        .background(Color.darkBlue000D40)
        .navigationViewStyle(.stack)
        .environmentObject(viewModel)
    }
    
    //MARK: Header View
    
    var matchPredictorHeaderView: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(matchdays ?? [], id: \.matchDayID){ data in
                        Button(action: {
                            viewModel.selectedMatchDay = data.matchDayID
                        })
                        {
                            VStack {
                                Text(data.title ?? "Matchday")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,10)
                                    .font(.footnote)
                                    .font(.system(size: 50))
                                    .padding(.top, 10)
                                Text("\(data.points ?? 0) pts")
                                    .bold()
                                Rectangle()
                                    .padding(.bottom, -1)
                                    .frame(height: 2)
                                    .foregroundColor(viewModel.selectedMatchDay == data.matchDayID ? .yellow : .clear)
                            }
                        }
                    }
                    Spacer()
                }
                .onAppear{
                    viewModel.selectedMatchDay = matchdays?.first?.matchDayID
                }
                .padding(.leading,20)
            }
            
            Divider()
                .background(Color.white)
                .padding(.top, 1)
        }
        .background(Color.darkBlue000D40)
    }
}

//#Preview {
//    MatchPredictorView(matchdays: allMatches)
//        .environmentObject(SharedData())
//}
