//
//  CoffeeMug.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 05.10.24.
//

import SwiftUI

struct CoffeeTrackerView: View {
    
    @State private var coffeeCount = 0
    @State private var isAddingCoffee = false
    
    var body: some View {
        
        ZStack {
            if isAddingCoffee {
                AnimatedFillView(completion: { withAnimation(.easeOut(duration: 0.2)) {
                    isAddingCoffee.toggle()
                    coffeeCount += 1
                }
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            }
            
            VStack {
                Spacer()
                
                ZStack {
                    MugIndicatorView(fillPercentage: 60).frame(width: 140, height: 140)
                    
                    Text("\(coffeeCount)")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .contentTransition(.numericText())
                        .offset(x: -10, y: 16)
                }
                
                Button {
                    withAnimation { isAddingCoffee.toggle() }
                } label: {
                    Label("Caffeine++", systemImage: "heart.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.title).bold()
                        .padding(.horizontal, 16)
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundStyle(.black)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    CoffeeTrackerView()
}

struct AnimatedFillView: View {
    
    @State private var percent: Double = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    @State private var waveOffset2 = Angle(degrees: 180)
    @State private var waveOffset3 = Angle(degrees: 360)
    
    let completion: (() -> Void)?
    
    private let timer = Timer.publish(every: 0.015, on: .main, in: .common)
        .autoconnect()
    private let coffeeColor = Color(red: 111/255.0,
                                    green: 78/255.0,
                                    blue: 55/255.0)
    
    var body: some View {
        // 3 layers of waves
        ZStack {
            Wave(offset: Angle(degrees: waveOffset.degrees), percent: percent)
                .fill(coffeeColor)
            
            Wave(offset: Angle(degrees: waveOffset2.degrees), percent: percent)
                .fill(coffeeColor.opacity(0.6))
            
            Wave(offset: Angle(degrees: waveOffset3.degrees), percent: percent)
                .fill(coffeeColor.opacity(0.3))
        }
        .onReceive(timer) { _ in
            // 120 instead of 100 to account for the wave dips, and let the animaiton fill the whole screen
            if percent == 120 {
                timer.upstream.connect().cancel()
                completion?()
            }
            percent += 1.0
        }
        .onAppear {
            //Start wave animation
            withAnimation(.linear(duration: 0.5)
                .repeatForever(autoreverses: false)) {
                    self.waveOffset = Angle(degrees: 360)
                    self.waveOffset2 = Angle(degrees: 180)
                    self.waveOffset3 = Angle(degrees: 0)
                }
        }
    }
}

struct MugIndicatorView: View {
    
    @State var fillPercentage: Double = 0.0
    @State private var waveOffset = Angle(degrees: 0)
    
    let coffeeColor = Color(red: 111/255.0, green: 78/255.0, blue: 55/255.0)
    
    var body: some View {
        
        Wave(offset: Angle(degrees: waveOffset.degrees), percent: fillPercentage)
            .fill(coffeeColor)
            .mask {
                Image(systemName: "mug.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .overlay {
                Image(systemName: "mug")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false)) {
                        self.waveOffset = Angle(degrees: 360)
                    }
            }
    }
}

// Inspired by Hacking with Swift
struct Wave: Shape {
    
    var offset: Angle
    var percent: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(offset.degrees, percent) }
        set {
            offset = Angle(degrees: newValue.first)
            percent = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        let lowestWave = 0.1
        let highestWave = 1.00
        
        let newPercent = lowestWave + (highestWave - lowestWave) * (percent / 100)
        let waveHeight = 0.05 * rect.height
        let yOffset = CGFloat(1 - newPercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
        let startAngle = offset
        let endAngle = offset + Angle(degrees: 360)
        
        p.move(to: CGPoint(x: 0, y: yOffset + waveHeight * CGFloat(sin(offset.radians))))
        
        for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
            let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
            let y = yOffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))
            p.addLine(to: CGPoint(x: x, y: y))
        }
        
        p.addLine(to: CGPoint(x: rect.width, y: rect.height))
        p.addLine(to: CGPoint(x: 0, y: rect.height))
        p.closeSubpath()
        
        return p
    }
}

