//
//  SwiftUIView.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 28/06/24.
//

import SwiftUI

struct ScrollToCenterExample: View {
    @State private var items = Array(0..<100)
    @State private var selectedItem: Int?

    var body: some View {
        VStack {
            // ScrollView with ScrollViewReader
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(items, id: \.self) { item in
                            Text("Item \(item)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedItem == item ? Color.red : Color.yellow)
                                .cornerRadius(8)
                                .onTapGesture {
                                    selectedItem = item
                                    withAnimation {
                                        proxy.scrollTo(item, anchor: .center)
                                    }
                                }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct ScrollToCenterExample_Previews: PreviewProvider {
    static var previews: some View {
        ScrollToCenterExample()
    }
}
