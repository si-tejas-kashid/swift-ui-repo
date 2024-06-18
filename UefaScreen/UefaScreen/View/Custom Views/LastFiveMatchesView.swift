//
//  LastFiveMatchesView.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 11/06/24.
//

import SwiftUI

struct LastFiveMatchesView: View {
    var team1: String? = "GER"
    var team2: String? = "ITA"
    @State private var isSelected: String? = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Last 5 Matches")
                    .bold()
                    .padding(.top,5)
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "xmark")
                        .opacity(0.6)
                }
                //                .padding(.top,5)
            }
            .padding(.horizontal,15)
            .padding(.bottom,15)
            
            
            //MARK: Team Options
            HStack {
                VStack {
                    HStack {
                        Image("GER")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Germany")
                    }
                    .onTapGesture {
                        isSelected = team1
                    }
                    
                    Rectangle()
                        .foregroundColor(isSelected == team1 ? .yellow : .white.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width/2.2, height: 1)
                }
                .padding(.trailing,-4.5)
                
                VStack {
                    HStack{
                        Text("Italy")
                        Image("ITA")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    .onTapGesture {
                        isSelected = team2
                    }
                    Rectangle()
                        .foregroundColor(isSelected == team2 ? .yellow : .white.opacity(0.2))
                        .frame(width: UIScreen.main.bounds.width/2.2, height: 1)
                }
                .padding(.leading,-4.5)
            }
            
            //MARK: Match Details List
            
            VStack {
                ForEach(1..<6) {_ in
                    HStack {
                        VStack {
                        ZStack {
                                Circle()
                                    .fill()
                                    .foregroundColor(.red)
                                    .frame(width: 22)
//                                    .overlay {
                                        Text("L")
                                            .font(.system(size: 12))
                                            .padding(8)
                                            .foregroundColor(.white)
//                                    }
                                
                            }
                            Spacer()
                                .frame(height: 7)
                            .padding(.trailing,0)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Germany 0 - 1 Scotland")
                                    .font(.system(size: 16))
                            }
                            .padding(.bottom,-3)
                            
                            HStack {
                                Text("27 March")
                                VStack {
                                    Circle()
                                        .fill()
                                        .frame(width: 2)
                                        .padding(.horizontal,1)
                                }
                                Text("Friendly Matches")
                            }
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding(.vertical,5)
                }
            }
            .padding(.leading,15)
        }
        .frame(width: UIScreen.main.bounds.width, height: 360)
        .background(Color.blue0D1E62)
        .foregroundColor(.white)
        .onAppear {
            isSelected = team1
        }
        
    }
}

#Preview {
    LastFiveMatchesView()
}
