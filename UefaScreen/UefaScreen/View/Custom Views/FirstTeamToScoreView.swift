//
//  FirstTeamToScoreView.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 10/06/24.
//

import SwiftUI

struct FirstTeamToScoreView: View {
    var team1: String? = "GER"
    var team2: String? = "ITA"
    @State private var isSelected: String? = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Spacer(minLength: 45)
                
                VStack {
                    Text("First team to score")
                        .font(.system(size: 12, weight: .bold))
                    HStack {
                        Text("Guess right to score")
                        Text("+2 points")
                            .padding(.leading,-5)
                            .font(.system(size: 12, weight: .bold))
                    }
                    .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top,20)
                
                Button(action: {
                    
                }) {
                    Image(systemName: "xmark")
                        .accentColor(.white)
                        .opacity(0.6)
                }
                .padding(.trailing,15)
                .padding(.top,15)
            }
            
            Spacer()
            
            HStack {
                VStack {
                    Button (action: {
                        isSelected = team1
                    }) {
                        VStack {
                            ZStack(alignment: .bottomTrailing){
                                Image("GER")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: isSelected == team1 ? "checkmark.circle.fill" : "circle")
                                    .background(Color.blue0D1E62)
                                    .foregroundColor(isSelected == team1 ? .yellow : .white.opacity(0.8))
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                }
                        }
                    }
                    Text("Germany")
                        .font(.headline)
                }
                
                Spacer()
                
                VStack {
                    Button (action: {
                        isSelected = nil
                    }) {
                        VStack {
                            ZStack(alignment: .bottomTrailing){
                                Text("0 - 0")
                                    .bold()
                                    .font(.system(size: 20))
                                    .frame(width: 60, height: 60)
//                                    .overlay {
                                        Circle()
                                            .stroke(lineWidth: 2)
                                            .foregroundColor(
                                                .white
                                                .opacity(0.7)
                                            )
//                                    }
                                
                                Image(systemName: isSelected == nil ? "checkmark.circle.fill" : "circle")
                                    .background(Color.blue0D1E62)
                                    .foregroundColor(isSelected == nil ? .yellow : .white.opacity(0.8))
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                }
                        }
                    }
                    Text("None")
                        .font(.headline)
                }
                
                Spacer()
                
                VStack {
                    Button (action: {
                        isSelected = team2
                    }) {
                        VStack {
                            ZStack(alignment: .bottomTrailing){
                                Image("ITA")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: isSelected == team2 ? "checkmark.circle.fill" : "circle")
                                    .background(Color.blue0D1E62)
                                    .foregroundColor(isSelected == team2 ? .yellow : .white.opacity(0.8))
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                }
                        }
                    }
                    Text("Italy")
                        .font(.headline)
                }
            }
            .padding(.horizontal, 45)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: 200)
        .background(Color.blue0D1E62)
        .foregroundColor(.white)
    }
}

#Preview {
    FirstTeamToScoreView()
}
