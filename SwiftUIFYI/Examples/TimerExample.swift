//
//  TimerExample.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 15.10.24.
//

import SwiftUI

struct TimerView: View {
    
    @State var durationSeconds: Duration = .seconds(1 * 60)
    @State private var elapsedSeconds: Duration = .seconds(0)
    
    @State private var timer: Timer?
    
    private var progress: Double {
        (durationSeconds - elapsedSeconds) / durationSeconds
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            ZStack {
                CircleProgressView(
                    progress: progress,
                    lineWidth: 6,
                    color: Color(hex: 0xFD8A06)
                )
                .frame(width: 240, height: 240)
                
                Text(
                    durationSeconds - elapsedSeconds,
                    format: .time(pattern: .minuteSecond(padMinuteToLength: 2))
                )
                .font(.system(size: 50, weight: .medium))
                .foregroundStyle(.white.opacity(0.8))
                .contentTransition(.numericText())
                    .monospaced()
                
            }
            
            let isTimerValid = timer?.isValid ?? false
            HStack {
                // Cancel button
                if isTimerValid || elapsedSeconds > .seconds(0) {
                    Button {
                        stopAndResetTimer()
                    } label: {
                        Label("Start", systemImage: "xmark.circle.fill")
                            .font(.system(size: 70))
                            .symbolRenderingMode(.hierarchical)
                            .labelStyle(.iconOnly)
                            .tint(.red)
                    }
                }
                
                Spacer()
                
                // Toggle timer button
                Button {
                    toggleTimer()
                } label: {
                    Label("Start", systemImage: isTimerValid ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                        .symbolRenderingMode(.hierarchical)
                        .labelStyle(.iconOnly)
                        .tint(isTimerValid ? .orange : .green)
                }
            }
            .padding(.vertical, 44)
            .padding(.horizontal, 24)
        }
        .modifier(ImageBackground(imageName: "background3"))
    }
    
    // -MARK: Timer Controls
    
    private func toggleTimer() {
        let isTimerValid = timer?.isValid ?? false
        isTimerValid ? pauseTimer() : startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1, repeats: true) { timer in
                if elapsedSeconds == durationSeconds {
                    stopAndResetTimer()
                }
                else {
                    withAnimation(.easeInOut) {
                        elapsedSeconds += .seconds(1)
                    }
                }
            }
    }
    
    private func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func stopAndResetTimer() {
        pauseTimer()
        withAnimation(.easeInOut) {
            elapsedSeconds = .seconds(0)
        }
    }
    
}

#Preview {
    TimerView()
}
