//
//  CircleProgressView.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 29.09.24.
//

import SwiftUI

struct ContentView: View {
    
    @State var completed: Double = 0.0
    
    private var progress: Double {
        return completed / 1.0
    }
    
    var body: some View {
        VStack {
            
            CircleProgressView(progress: progress, lineWidth: 16)
                .frame(width: 200)
                .padding()
            
            CircleProgressView(progress: progress, lineWidth: 12)
                .frame(width: 100)
                .padding()
            
            CircleProgressView(progress: progress, lineWidth: 8)
                .frame(width: 40)
                .padding()
            
            CircleProgressView(progress: progress, lineWidth: 3)
                .frame(width: 40)
                .padding()
            
            Spacer()
            
            Button {
                completed += 0.1
            } label: {
                Text("Update Progress")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.vertical, 40)
    }
}

struct CircleProgressView: View {
    
    var progress: Double
    var lineWidth: CGFloat
    
    var body: some View {
        
        ZStack {
            Circle().stroke(
                .secondary.opacity(0.4),
                lineWidth: lineWidth
            )

            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(
                    .green.gradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
            .rotationEffect(.degrees(-90))
            .animation(.easeOut(duration: 0.25), value: progress)
        }
    }
}

#Preview {
    ContentView()
}
