//
//  NavigationBarModifier.swift
//  UefaScreen
//
//  Created by Tejas Kashid on 03/06/24.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {

    var backgroundImage: String?
    var titleColor: UIColor?

    init(backgroundImage: String?, titleColor: UIColor?) {
        self.backgroundImage = backgroundImage
        let coloredAppearance = UINavigationBarAppearance()
//        coloredAppearance.configureWithTransparentBackground()
//        let navbarImage = UIImage(named: backgroundImage ?? "")?.stretchableImage(withLeftCapWidth: 100, topCapHeight: -100)
//        UINavigationBar.appearance().setBackgroundImage(navbarImage, for: .default)
//        if let imageName = backgroundImage, let image = UIImage(named: imageName) {
//                   let navbarImage = image.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
//                   coloredAppearance.backgroundImage = navbarImage
//               }
        
        coloredAppearance.backgroundImage = UIImage(named: backgroundImage ?? "")?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundImage ?? "")
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .tint(.white)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // handle tap
                    }) {
                        Image("three-dots")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .colorInvert()
                    }
                }
            }
        }
    }
}

extension View {

    func navigationBarStyle(backgroundImage: String?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundImage: backgroundImage, titleColor: titleColor))
    }

}

