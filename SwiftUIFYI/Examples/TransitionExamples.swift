//
//  TransitionExamples.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 24.09.24.
//

import SwiftUI

struct TransitionExamples: View {
    
    @State private var showDetail = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            Button {
                withAnimation(.spring(duration: 0.4, bounce: 0.35, blendDuration: 0.8)) {
                    showDetail.toggle()
                }
            } label: {
                Label("Toggle Message", systemImage: "tray.fill")
                    .font(.title)
                    .padding(.horizontal, 16)
            }.buttonStyle(.borderedProminent)
            
            if showDetail {
                
                let transition = AsymmetricTransition(
                    insertion: .slide.combined(with: .opacity),
                    removal: .scale(0, anchor: .bottom).combined(with: .opacity)
                )
                
                MessageView().transition(transition)
            }
        }
    }
}

struct MessageView: View {
    var body: some View {
        VStack {
            Text("You have a new Message from **Said**!")
                .font(.title)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .padding()
        }
        .background(Color.teal.gradient)
        .cornerRadius(16)
    }
}

#Preview {
    TransitionExamples()
}
