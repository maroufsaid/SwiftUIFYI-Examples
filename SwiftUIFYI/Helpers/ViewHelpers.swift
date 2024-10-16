//
//  ViewHelpers.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 16.10.24.
//

import SwiftUI

struct ImageBackground: ViewModifier {
    
    let imageName: String
    
    func body(content: Content) -> some View {
        
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            content
        }
    }
    
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xff) / 255,
                  green: Double((hex >> 08) & 0xff) / 255,
                  blue: Double((hex >> 00) & 0xff) / 255,
                  opacity: opacity
        )
    }
}

