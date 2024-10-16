//
//  TimerExample.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 15.10.24.
//

import SwiftUI
import Combine

struct TimerView: View {
    
    let durationSeconds: Duration
    @State private var elapsedSeconds: Duration = .seconds(0)
    // For better interactivity precision
    @State private var elapsedMilliseconds: Int = 0
    @State private var cancellable: Cancellable?
    
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
            
            HStack {
                // Cancel button
                if shouldShowCancelButton() {
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
        isTimerValid ? pauseTimer() : startTimer()
    }
        
    // A few gotchas!
    // 1- Precision when toggling the timer is tricky. Made the timer fire every
    // 0.01 seconds to acheive higehr precision.
    // 2- Tracking milliseconds to avoid updating the UI every 0.01 seconds, and
    // still acheiving better precision.
    // 3- Stopping the timer at completion happens in the animation completion
    // block, to ensure the final visuals take place.
    private func startTimer() {
        
        cancellable = Timer
            .publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if newSecondPassed {
                    withAnimation(.easeInOut) {
                        if elapsedSeconds < durationSeconds {
                            elapsedSeconds += .seconds(1.0)
                        }
                    } completion: {
                        // inside completion to ensure the final animation
                        // finishes. Bettr UX, but less clean code..
                        if shouldStopTimer {
                            stopAndResetTimer()
                        }
                    }
                }
            
                if !shouldStopTimer {
                    elapsedMilliseconds += 10
                }
            }
    }
    
    private var progress: Double {
        // Using milliseconds for smoother animation
        let elapsed: Duration = .milliseconds(elapsedMilliseconds)
        return (durationSeconds - elapsed) / durationSeconds
    }
    
    private var isTimerValid: Bool {
        cancellable != nil
    }

    private func shouldShowCancelButton() -> Bool {
        return isTimerValid || elapsedSeconds > .seconds(0)
    }
    
    private var shouldStopTimer: Bool {
        .milliseconds(elapsedMilliseconds) == durationSeconds
    }
    
    private var newSecondPassed: Bool {
        elapsedMilliseconds > 0 && elapsedMilliseconds % 1000 == 0
    }
    
    private func pauseTimer() {
        cancellable?.cancel()
        cancellable = nil
    }
    
    private func stopAndResetTimer() {
        pauseTimer()
        elapsedMilliseconds = 0
        withAnimation(.easeInOut) {
            elapsedSeconds = .seconds(0)
        }
    }
    
}

#Preview {
    TimerView(durationSeconds: .seconds(120))
}
