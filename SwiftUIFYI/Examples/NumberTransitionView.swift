//
//  ContentView.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 19.09.24.
//

import SwiftUI

struct NumberTransitionView: View {
    
    @State var number: Int = 8
    
    var body: some View {
        VStack {
            
            Text(number, format: .number)
                .font(.system(size: 100, weight: .bold))
                .contentTransition(.numericText())
                .monospaced()
            
            Button("Increment") {
                withAnimation {
                    number += Int.random(in: 1...10)
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    NumberTransitionView()
}
