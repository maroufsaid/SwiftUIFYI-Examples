//
//  Gradients.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 24.09.24.
//

import SwiftUI

struct Gradients: View {
    var body: some View {
        VStack {
            
            // Simple gradient
            Rectangle()
                .fill(.red.gradient)
            
            //Multi color gradient
            Rectangle()
                .fill(Gradient(colors: [.purple, .pink]))
            
            // Multi color gradient with custom stops
            Rectangle()
                .fill(
                    Gradient(stops: [
                        .init(color: .green, location: 0),
                        .init(color: .blue, location: 0.6),
                        .init(color: .black, location: 1.0)
                    ])
                )
            
            // Text with gradient
            Text("Gradient Text")
                .font(.system(size: 60, weight: .bold))
                .padding()
                .foregroundStyle(.purple.gradient)
            
            // Customize the direction of the gradient
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [.teal, .blue],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                )
            
        }
    }
}

#Preview {
    Gradients()
}

//            Rectangle()
//                .fill(Gradient(colors: [.purple, .pink]))
//
//            Rectangle()
//                .fill(Gradient(stops: [
//                    .init(color: .green, location: 0),
//                    .init(color: .blue, location: 0.6),
//                    Gradient.Stop(color: .black, location: 1.0)
//                ]))


