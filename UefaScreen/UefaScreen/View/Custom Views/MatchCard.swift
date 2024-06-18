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
    @State private var isFocused1: Bool = false
    @State private var isFocused2: Bool = false
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
    
    @StateObject var matchCardVM = MatchCardVM()
    
    
    var boosterApplied: (Bool) -> Void
    
    struct buttonData: Identifiable {
        var id = UUID()
        var pred1: Int
        var pred2: Int
        var percentage: Int
    }
    
    var body: some View {
        VStack {
            VStack {
                ZStack {
                    ZStack {
                        Text("15 June at 00:30")
                            .font(.system(size: 15))
                            .bold()
                        if showToast {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12.0)
                                    .fill(Color.yellow)
                                Text("Prediction Saved")
                                    .foregroundColor(.black)
                                    .transition(.scaleAndFade)
                                    .animation(.default, value: showToast)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .frame(width: 150, height: 20)
                    
                    HStack{
                        Spacer()
                        Image(systemName: "chart.bar.xaxis")
                            .accentColor(.white)
                            .opacity(0.5)
                            .padding(.trailing,15)
                        
                    }
                }
                .padding(.top,10)
                
                HStack() {
                    
                    //MARK: Team 1 Data
                    HStack(spacing:0){
                        Spacer()
                        VStack{
                            Image("GER")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Germany")
                                .lineLimit(2)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            //                                .frame(width: 100)
                        }
                        Spacer()
                    }
                    .padding(.top,20)
                    
                    //MARK: Team 1 Score Field TextField
                    HStack(spacing:20) {
                        ZStack() {
                            FocusTextField(text: isFocused1 ? self.$blank1.max(1) : self.$textFieldText1.max(1), isFocused: $isFocused1, submitAction: {
                                onSubmitActions(fromButtons: false)
                                isFocused1 = false
                            },
                                           font: UIFont.boldSystemFont(ofSize: 30), // Custom font
                                           textColor: isFocused1 ? .white : (textFieldText1.isEmpty || textFieldText1 == "+") ? .yellow : .white
                            )
                            .accentColor(!($textFieldText1.wrappedValue.isEmpty || $blank1.wrappedValue.isEmpty) ? Color.clear : Color.white)
                            .keyboardType(.numberPad)
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 50, height:50)
                            RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 2)
                                .animation(.default, value: isFocused1)
                                .background(isFocused1 ? Color.white.opacity(0.1) : .clear)
                                .foregroundColor(isFocused1 ? .white : .yellow)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1)) {
                                self.isFocused1 = true
                                self.isFocused2 = false
                                showKeyboard = true
                            }
                            
                        }
                        
                        
                        
                        //MARK: Team 2 Score Field TextField
                        ZStack {
                            FocusTextField(text: isFocused2 ? self.$blank2.max(1) : self.$textFieldText2.max(1), isFocused: $isFocused2, submitAction: {
                                onSubmitActions(fromButtons: false)
                                isFocused2 = false
                            },
                                           font: UIFont.boldSystemFont(ofSize: 30), // Custom font
                                           textColor: isFocused2 ? .white : (textFieldText2.isEmpty || textFieldText2 == "+") ? .yellow : .white // Custom color
                            )
                            .accentColor(!($textFieldText2.wrappedValue.isEmpty || $blank2.wrappedValue.isEmpty) ? Color.clear : Color.white)
                            .keyboardType(.numberPad)
                            .font(.system(size: 30).weight(.bold))
                            .frame(width: 50, height:50)
                            .cornerRadius(3.0)
                            RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 2)
                                .animation(.default, value: isFocused2)
                                .background(isFocused2 ? Color.white.opacity(0.1) : .clear)
                                .foregroundColor(isFocused2 ? .white : .yellow)
                        }
                        
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)){
                                self.isFocused1 = false
                                self.isFocused2 = true
                                showKeyboard = true
                            }
                        }
                        //                            .padding()
                        //                            .multilineTextAlignment(.center)
                        //                            .foregroundColor(isFocused2 ? .white : (textFieldText2.isEmpty) || (textFieldText2 == "+") ? .yellow : .white)
                    }
                    .padding()
                    
                    //MARK: Team 2 Data
                    HStack(spacing:0){
                        Spacer()
                        VStack{
                            Image("ITA")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Italy")
                                .lineLimit(2)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .padding(.top,20)
                    
                }
                
                ZStack {
                    VStack {
                        
                        //MARK: Popular Predictions Buttons
                        Text("Popular predictions")
                            .font(.system(size: 15))
                            .opacity(0.8)
                        
                        HStack(alignment: .center) {
                            
                            Spacer()
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
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20.0)
                                                .stroke(Color.yellow, lineWidth: 1.5)
                                                .background(selectedButton == data.id ? Color.yellow : Color.clear)
                                                .cornerRadius(12.0)
                                            
                                            Text("\(data.pred1)-\(data.pred2)")
                                                .padding(.horizontal,10)
                                                .foregroundColor(selectedButton == data.id ? Color.blue0D1E62 : Color.yellow)
                                        }
                                    }
                                    .frame(width: 55, height: 25)
                                    .font(.system(size: 15, weight: .medium))
                                    
                                    Text("\(data.percentage)%")
                                        .font(.caption)
                                        .opacity(0.7)
                                }
                                .padding(.top,1)
                                .padding(.bottom, (isFocused1 || isFocused2 && showKeyboard) ? (isSubmitted ? 10 : 140) : 10)
                                
                                
                                Spacer()
                            }
                        }
                        .onAppear {
                            randomPredictionGenerator()
                        }
                        
                        if isSubmitted {
                            VStack(spacing:0) {
                                Divider()
                                    .background(Color.white)
                                
                                //MARK: First Team To Score Button
                                Button(action: {
                                    //Implement FirstTeamToScoreView here
                                }) {
                                    HStack {
                                        Text("First team to score")
                                            .foregroundColor(.white)
                                            .font(.system(size: 15))
                                        Spacer()
                                        
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .foregroundColor(.yellow)
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical,5)
                                .background(Color.blue0D1E62)
                                
                                Divider()
                                    .background(Color.white)
                                    .padding(.bottom,0)
                                
                                //MARK: Booster Button
                                Button(action: {
                                    isBoosterApplied.toggle()
                                    boosterApplied(isBoosterApplied)
                                    withAnimation() {
                                        showToast = true
                                        
                                        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 1) {
                                            withAnimation {
                                                showToast = false
                                            }
                                        }
                                    }
                                }) {
                                    HStack {
                                        Text(isBoosterApplied ? "2x booster applied" : "Play 2x booster")
                                            .foregroundColor(isBoosterApplied ? Color("blue0D1E62") : .white)
                                            .bold()
                                        
                                        Spacer()
                                        Image(systemName: isBoosterApplied ? "bolt.circle.fill" : "plus.circle")
                                            .resizable()
                                            .foregroundColor(.yellow)
                                            .frame(width: isBoosterApplied ? 22 : 20, height: isBoosterApplied ? 22 : 20)
                                            .overlay(
                                                Circle()
                                                    .stroke(lineWidth: isBoosterApplied ? 3 : 4)
                                                    .foregroundColor(isBoosterApplied ? Color.blue0D1E62 : Color.yellow)
                                            )
                                            .background(Color.blue0D1E62)
                                            .clipShape(Circle())
                                        
                                    }
                                    .padding(.vertical,10)
                                }
                                .padding(.horizontal, 15)
                                .padding(.bottom, (isFocused1 || isFocused2 && showKeyboard) ? (isSubmitted ? 50 : 0) : 0)
                                .background(isBoosterApplied ? Color.yellow : Color.blue0D1E62)
                            }
                            .animation(.default, value: isSubmitted)
                            .padding(.bottom,0)
                        }
                    }
                    
                    VStack {
                        //MARK: Custom Keyboard Implementation
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
            }
        }
        .background(Color.blue0D1E62)
        .foregroundColor(.white)
        .onTapGesture {
            withAnimation(.easeIn(duration: 1)) {
                isFocused1 = false
                isFocused2 = false
            }
            
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
        
    }
    
    //MARK: Functions
    
    func randomPredictionGenerator() {
        for _ in 0..<Int.random(in: 1..<5) {
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
            withAnimation(.easeInOut(duration: 1)) {
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
            selectedButton = buttonsData.first { buttonData in
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
        if isFocused2 {
            blank2 = number
            
            if !(number == "") {
                textFieldText2 = number
            }
            
            if (!(number == "") && ((textFieldText1 == "+") || (textFieldText1 == ""))) {
                isFocused1 = true
                return
            } else {
                onSubmitActions(fromButtons: false)
            }
        }
        
        if isFocused1 {
            blank1 = number
            
            if !(number == "") {
                textFieldText1 = number
            }
            
            if (!(number == "") && ((textFieldText2 == "+") || (textFieldText2 == ""))) {
                isFocused2 = true
                return
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
    MatchCard(boosterApplied: {booster in
        
    })
}
