//
//  TwitterComposeButton.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 10.10.24.
//

import SwiftUI

struct TwitterButtonDemoView: View {
  var body: some View {
    ZStack {
      Image("background2")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      
      VStack {
        Spacer()
        HStack {
          Spacer()
          TwitterComposeButton()
            .padding(32)
        }
      }
    }
  }
}

#Preview {
  TwitterButtonDemoView()
}


struct TwitterComposeButton: View {
  
  @State private var isLongPressTriggered: Bool = false
  @State private var isButtonPressed: Bool = false
  
  private let twitterBlue = Color(red: 29/255.0, green: 161/255.0, blue: 242/255.0)
  private let keyDistance = 150.0
  private let outerOffset = -20.0
  private let spring = Animation.spring(duration: 0.3, bounce: 0.35)
  
  private var shouldActivateMainButton: Bool {
    isLongPressTriggered || isButtonPressed
  }
  
  var body: some View {
    
    ZStack {
      
      RoundButton(bgStyle: twitterBlue, systemImage: "pencil.and.scribble")
        .scaleEffect(isLongPressTriggered ? 1.0 : 0.7)
        .offset(x: isLongPressTriggered ? outerOffset : 0,
                y: isLongPressTriggered ? -keyDistance : 0)

      RoundButton(bgStyle: twitterBlue, systemImage: "video.fill")
        .scaleEffect(isLongPressTriggered ? 1.0 : 0.7)
        .offset(x: isLongPressTriggered ? -0.7 * keyDistance : 0,
                y: isLongPressTriggered ? -0.7 * keyDistance : 0)
      
      RoundButton(bgStyle: .purple, systemImage: "microphone.fill")
        .scaleEffect(isLongPressTriggered ? 1.0 : 0.7)
        .offset(x: isLongPressTriggered ? -keyDistance : 0,
                y: isLongPressTriggered ? outerOffset : 0)

      
      // Main Compose Button
      RoundButton(
        bgStyle: isLongPressTriggered ? .secondary : twitterBlue,
        systemImage: "plus"
      )
        .rotationEffect(.degrees(isLongPressTriggered ? 45 : 0))
        .scaleEffect(shouldActivateMainButton ? 0.85 : 1.0)
        .animation(.spring(duration: 0.3, bounce: 0.6),
                   value: shouldActivateMainButton)
        .sensoryFeedback(.impact(intensity: 1.0),
                         trigger: isLongPressTriggered)
        .onTapGesture {
          if isLongPressTriggered {
            withAnimation(spring) {
              isLongPressTriggered = false
            }
          }
        }
        .onLongPressGesture(perform: {
          withAnimation(spring) {
            isLongPressTriggered = true
          }
        }) { pressed in
          isButtonPressed = pressed
        }
    }
  }
}

struct RoundButton: View {
  let bgStyle: Color
  let systemImage: String
  
  var body: some View {
    Image(systemName: systemImage)
      .frame(width: 30, height: 30)
      .font(.title)
      .fontWeight(.bold)
      .padding()
      .background(bgStyle, in: Circle())
  }
}

