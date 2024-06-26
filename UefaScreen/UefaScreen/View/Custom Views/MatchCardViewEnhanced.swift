//
//  MatchCardViewEnhanced.swift
//  UefaScreen
//
//  Created by Nausheen Khan on 25/06/24.
//

import SwiftUI

struct MatchCardViewEnhanced: View {
    var matchDetails: Match?
    @EnvironmentObject var viewModel: MatchPredictorVM
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                // MARK: - MATCH TOP DETAILS VIEW
                if let matchDetails = matchDetails {
                    MatchCardTopDetailDisplayView(matchDetails: matchDetails)
                }
                
                // MARK: - Team Data
                HStack(spacing:0){
                    MatchCardTeamFlagDisplayView(teamName: matchDetails?.team1Name?.lowercased() ?? "")
                    Spacer()
                    MatchCardTeamFlagDisplayView(teamName: matchDetails?.team2Name?.lowercased() ?? "")
                }
                
                // MARK: - POPULAR PREDICTIONS VIEW
                if let matchDetails = matchDetails {
                    MatchCardPopularPredictionsView(matchDetails: matchDetails)
                }
            }
            .padding(.all, 15)
            .background(Color.blue0D1E62)
        }
    }
}

// MARK: - TOP DETAIL DISPLAY VIEW
struct MatchCardTopDetailDisplayView: View {
    var matchDetails: Match
    var body: some View {
        HStack {
            Spacer()
            
            Text(matchDetails.matchDate ?? "")
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chart.bar.xaxis")
                .resizable()
                .accentColor(.white)
                .opacity(0.5)
                .frame(width: 17, height: 15)
        }
    }
}

// MARK: - TEAM FLAG DISPLAY VIEW
struct MatchCardTeamFlagDisplayView: View {
    let teamName: String
    var body: some View {
        VStack{
            Image(teamName.lowercased())
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(lineWidth: 2)
                        .background(Color.clear)
                        .foregroundColor(Color.greyB2C0C3)
                )
            Text(teamName)
                .lineLimit(2)
                .font(.system(size: 15, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top,5)
        }
    }
}

// MARK: - POPULAR PERCENTAGE PREDICTIONS VIEW
struct MatchCardPopularPredictionsView: View {
    var matchDetails: Match
    var body: some View {
        HStack(spacing: 15) {
            ForEach(matchDetails.popularPredictions ?? []) { predictionValues in
                VStack(spacing: 10) {
                    Button {
                        
                    } label: {
                        Text("\(predictionValues.team1Prediction ?? "") - \(predictionValues.team2Prediction ?? "")")
                            .padding(.all, 8)
                            .foregroundColor(Color.yellow)
                            .background(Color.clear)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.yellow, lineWidth: 1.5))
                    Text("\(predictionValues.predictionPercentage ?? "")%")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    MatchCardViewEnhanced(matchDetails: allMatches.first?.matches?.first)
        .previewLayout(.sizeThatFits)
}
