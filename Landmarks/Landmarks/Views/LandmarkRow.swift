//
//  LandmarkRow.swift
//  Landmarks
//
//  Created by Tejas Kashid on 06/05/24.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark: Landmark
    
    var body: some View {
        HStack {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            
            Text(landmark.name)
            
            Spacer()
        }
    }
}

#Preview("Turtle Rock") {
    Group {
        LandmarkRow(landmark: landmarks[0])
        LandmarkRow(landmark: landmarks[2])
    }
}

#Preview("Chikoot Trail"){
    LandmarkRow(landmark: landmarks[2])
}
