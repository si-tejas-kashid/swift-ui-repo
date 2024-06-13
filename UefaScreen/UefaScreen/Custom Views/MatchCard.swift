//
//  MatchCard.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 04/06/24.
//

import SwiftUI

struct MatchCard: View {
    
    @State private var textFieldText1: String = "+"
    @State private var textFieldText2: String = "+"
    @State private var blank1: String = ""
    @State private var blank2: String = ""
    @FocusState private var isFocused1: Bool
    @FocusState private var isFocused2: Bool
    @State private var showToast: Bool = false
    @State private var isSubmitted: Bool = false
    @State private var pred1: Int = 0
    @State private var pred2: Int = 0
    @State private var buttonsData: [buttonData] = []
    @State private var selectedButton: UUID? = nil
    @State private var selectedNumber: String?
    @State private var showKeyboard: Bool = false
    @State private var isBoosterApplied: Bool = false
    @State private var savedTeam1Pred: String = ""
    @State private var savedTeam2Pred: String = ""
    
    struct buttonData: Identifiable {
        var id = UUID()
        var pred1: Int
        var pred2: Int
        var percentage: Int
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    ZStack {
                        Text("15 June at 00:30")
                            .font(.subheadline)
                            .bold()
                        if showToast {
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.yellow)
                                    .overlay {
                                        Text("Prediction Saved")
                                            .foregroundStyle(.black)
                                    }
                                    .transition(.scaleAndFade)
                                    .animation(.default, value: showToast)
                        }
                    }
                    .padding(.top, 10)
                    .frame(width: 150, height: 20)
                    
                    Spacer()
                    Image(systemName: "chart.bar.xaxis")
                        .tint(.white)
                        .opacity(0.5)
                        .padding(.trailing,20)
                }
                .padding(.leading,UIScreen.main.bounds.width/3)
                
                HStack {
                    
                    //MARK: Team 1 Data
                    VStack {
                        Image("GER")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Germany")
                            .font(.headline)
                    }
                    
                    //MARK: Team 1 Score Field TextField
                    HStack {
                        TextField("", text: isFocused1 ? self.$blank1.max(1) : self.$textFieldText1.max(1))
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 50, height:50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 2)
                                    .animation(.default, value: isFocused1)
                                    .background(isFocused1 ? Color.white.opacity(0.1) : .clear)
                                    .foregroundStyle(isFocused1 ? .white : .yellow)
                            }
                            .onSubmit {
                                onSubmitActions(fromButtons: false)
                                isFocused1 = false
                            }
                            .focused($isFocused1)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 2)) {
                                    showKeyboard = true
                                }
                                
                            }
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundStyle(isFocused1 ? .white : (textFieldText1.isEmpty) || (textFieldText1 == "+") ? .yellow : .white)
                        
                        //MARK: Team 2 Score Field TextField
                        TextField("", text: isFocused2 ? self.$blank2.max(1) : self.$textFieldText2.max(1))
                            .keyboardType(.numberPad)
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 50, height:50)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 2)
                                    .animation(.default, value: isFocused2)
                                    .background(isFocused2 ? Color.white.opacity(0.1) : .clear)
                                    .foregroundStyle(isFocused2 ? .white : .yellow)
                            }
                            .onSubmit {
                                onSubmitActions(fromButtons: false)
                                isFocused2 = false
                            }
                            .focused($isFocused2)
                            .onTapGesture {
                                withAnimation(.default) {
                                    showKeyboard = true
                                }
                                
                            }
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundStyle(isFocused2 ? .white : (textFieldText2.isEmpty) || (textFieldText2 == "+") ? .yellow : .white)
                        
                    }
                    .padding()
                    
                    //MARK: Team 2 Data
                    VStack {
                        Image("ITA")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("Italy")
                            .font(.headline)
                    }
                }
                
                VStack {
                    
                    //MARK: Popular Predictions Buttons
                    
                    Text("Popular predictions")
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    HStack {
                        ForEach(buttonsData) {data in
                            VStack {
                                Button (action: {
                                    textFieldText1 = String(data.pred1)
                                    blank1 = String(data.pred1)
                                    
                                    textFieldText2 = String(data.pred2)
                                    blank2 = String(data.pred2)
                                    
                                    selectedButton = data.id
                                    onSubmitActions(fromButtons: true)
                                }) {
                                    Text("\(data.pred1)-\(data.pred2)")
                                        .padding(.horizontal,10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12.0)
                                                .stroke(lineWidth: 1.5)
                                            
                                        }
                                    
                                        .foregroundColor(selectedButton == data.id ? Color("blue0D1E62") : .yellow)
                                        .background(selectedButton == data.id ? Color.yellow : Color.clear)
                                        .cornerRadius(12.0)
                                }
                                .fontWeight(.medium)
                                
                                Text("\(data.percentage)%")
                                    .font(.caption)
                                    .opacity(0.7)
                            }
                            .padding(.top,1)
                            .padding(.bottom, (isFocused1 || isFocused2 && showKeyboard) ? (isSubmitted ? 10 : 140) : 10)
                        }
                    }
                    .onAppear {
                        randomPredictionGenerator()
                    }
                                   
                    if isSubmitted {
                        VStack {
                            Divider()
                                .background(.white)
                            
                            //MARK: First Team To Score Button
                            
                            HStack {
                                Text("First team to score")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 15))
                                Spacer()
                                Button(action: {
                                    //Implement FirstTeamToScoreView here
                                }) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .foregroundStyle(.yellow)
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical,1)
                            .background(Color("blue0D1E62"))
                            
                            Divider()
                                .background(.white)
                            
                            //MARK: Booster Button
                            
                            HStack {
                                Text("Play 2x booster")
                                    .foregroundStyle(isBoosterApplied ? Color("blue0D1E62") : .white)
                                    .bold()
                                Spacer()
                                Button(action: {
                                    isBoosterApplied.toggle()
                                }) {
                                    Image(systemName: isBoosterApplied ? "bolt.circle.fill" : "plus.circle")
                                        .resizable()
                                       .foregroundStyle(isBoosterApplied ? Color("blue0D1E62") : .yellow)
                                        .frame(width: isBoosterApplied ? 25 : 20, height: isBoosterApplied ? 25 : 20)
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, (isFocused1 || isFocused2 && showKeyboard) ? (isSubmitted ? 50 : 0) : 0)
                            .background(isBoosterApplied ? Color.yellow : Color("blue0D1E62"))
                        }
                        .animation(.default, value: isSubmitted)
                    }
                }
                
                //MARK: Custom Keyboard Implementation
                .overlay {
                    if ((isFocused1 || isFocused2) && showKeyboard) {
                            CustomKeyboard(currentEnteredValue: { number in
                                enterTextInTextFields(withNumber: number)
                            })
//                            .opacity(0.4)
                            .transition(.move(edge: .bottom))
                            .animation(.default, value: showKeyboard)
                    }
                }
            }
            .onTapGesture {
                isFocused1 = false
                isFocused2 = false
                
                if !isSubmitted {
                    textFieldText1 = "+"
                    blank1 = ""
                    
                    textFieldText2 = "+"
                    blank2 = ""
                } else {
                    textFieldText1 = savedTeam1Pred
                    textFieldText2 = savedTeam2Pred
                    blank1 = savedTeam1Pred
                    blank2 = savedTeam2Pred
                }
            }
            .background(Color("blue0D1E62"))
            .foregroundStyle(.white)
        }
    }
    
    //MARK: Functions
    
    func randomPredictionGenerator() {
        for _ in 1..<5 {
                    let newData = buttonData(
                        pred1: Int.random(in: 0..<10),
                        pred2: Int.random(in: 0..<10),
                        percentage: Int.random(in: 0..<100)
                    )
                    buttonsData.append(newData)
                }
    }
    
    func onSubmitActions(fromButtons: Bool){
        if !fromButtons {
            if blank1.isEmpty {
                textFieldText1 = "+"
            } else {
                textFieldText1 = blank1
            }
            
            if blank2.isEmpty {
                textFieldText2 = "+"
            } else {
                textFieldText2 = blank2
            }
        }
        
        if !((textFieldText1 == "+") || (textFieldText1 == "")) && !((textFieldText2 == "+") || (textFieldText2 == "")) {
            withAnimation() {
                showToast = true
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        isSubmitted = true
                        savedTeam1Pred = textFieldText1
                        savedTeam2Pred = textFieldText2
                        blank1 = savedTeam1Pred
                        blank2 = savedTeam2Pred
                    }
                    
                }
                showKeyboard = false
                isFocused1 = false
                isFocused2 = false
            }
            selectedButton = ForEach(buttonsData).data.first { buttonData in
                (String(buttonData.pred1) == textFieldText1 && String(buttonData.pred2) == textFieldText2)
            }?.id
        }

        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
            withAnimation {
                showToast = false
            }
        }
    }

    func enterTextInTextFields(withNumber number: String) {
        if isFocused1 {
            blank1 = number
            
            if !(number == "") {
                textFieldText1 = number
            }
           
            if (!(number == "") && ((textFieldText2 == "+") || (textFieldText2 == ""))) {
                isFocused2 = true
            } else {
                onSubmitActions(fromButtons: false)
            }
        }
        
        if isFocused2 {
            blank2 = number
            
            if !(number == "") {
                textFieldText2 = number
            }
            
            if (!(number == "") && ((textFieldText1 == "+") || (textFieldText1 == ""))) {
                isFocused1 = true
            } else {
                onSubmitActions(fromButtons: false)
            }
        }
        
        
    }
}

//MARK: Custom transition modifier
extension AnyTransition {
    static var scaleAndFade: AnyTransition {
        AnyTransition.scale(scale: 0.1, anchor: .center)
            .combined(with: .opacity)
    }
}

#Preview {
    MatchCard()
}
