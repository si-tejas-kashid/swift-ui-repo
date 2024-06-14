//
//  GeometryReaderPract.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 13/06/24.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Geometry Reader Example")
                    .font(.largeTitle)
                    .padding()

                // Using GeometryProxy to center a view
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)

                Text("Width: \(Int(geometry.size.width))")
                Text("Height: \(Int(geometry.size.height))")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct GeometryReaderExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExample()
    }
}
