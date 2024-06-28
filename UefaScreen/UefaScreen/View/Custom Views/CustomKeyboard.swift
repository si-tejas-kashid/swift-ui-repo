//
//  CustomKeyboard.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 05/06/24.
//

import SwiftUI

struct CustomKeyboard: View {
    let numbers = Array(1...9)
    var currentEnteredValue: (String) -> Void

    var body: some View {
        VStack {
            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        let number = numbers[row * 3 + column]
                        Button(action: {
                            currentEnteredValue("\(number)")
                        }) {
                            HStack{
                                Spacer()
                                Text("\(number)")
                                Spacer()
                            }
//                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.white)
                                .foregroundColor(Color("grey000D40").opacity(0.8))
                                    .cornerRadius(10)
                                    .font(.system(size: 25, weight: .bold))
                            }
                            .shadow(color: Color.black.opacity(0.14),
                                    radius: 10,
                                    x: 0,
                                    y: 11)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal,20)
                }
                
                
                HStack {
                    // Vacant left corner
                    Button(action: {
                    }) {
                        HStack{
                            Spacer()
                            Text("")
                            Spacer()
                        }
                    }
                    .hidden()
                    
                    Button(action: {
                        currentEnteredValue("0")
                    }) {
                        HStack{
                            Spacer()
                            Text("0")
                            Spacer()
                        }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.white)
                            .foregroundColor(Color("grey000D40").opacity(0.8))
                            .cornerRadius(10)
                            .font(.system(size: 25, weight: .bold))
                    }
                    .shadow(color: Color.black.opacity(0.14),
                            radius: 10,
                            x: 0,
                            y: 11)
                    
                    Button(action: {
                        currentEnteredValue("")
                    }) {
                        HStack{
                            Spacer()
                            Image(systemName: "delete.left")
                            Spacer()
                        }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(Color("grey000D40").opacity(0.6))
                            .cornerRadius(10)
                            .font(.title2)
                    }
                    .shadow(color: Color.black.opacity(0.14),
                            radius: 10,
                            x: 0,
                            y: 11)
                }
                .padding(.vertical,1)
                .padding(.horizontal,5)
            }
//            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4.5, alignment: .center)
            .padding(10)
            .background(Color.greyF3F4FC)
        }
    }
#Preview {
    CustomKeyboard(currentEnteredValue: {_ in 
    })
}
