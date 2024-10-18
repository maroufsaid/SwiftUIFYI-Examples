//
//  Test.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 18.10.24.
//

import SwiftUI

struct KeyboardDismissView: View {
    
    @State var input: String = ""
    
    var body: some View {
        
        ScrollView {
            TextField("Enter Text", text: $input)
                .padding()
                .background(.secondary.opacity(0.5))
                .clipShape(Capsule())
                .padding()
            
            Text("Swipe Down to Dismiss Keyboard".uppercased())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 44)
                .padding(.bottom, 44)
            
            Text("Here's how you do it 👇")
                .font(.title)
            VStack(alignment: .leading) {
                Text("**ScrollView {**")
                Text("    // Contents").foregroundStyle(.gray)
                Text("**}**")
                Text("**.scrollDismissesKeyboard(.interactively)**")
            }
            .font(.system(size: 15))
            .monospaced()
            .foregroundStyle(.blue)
            .padding()
            .background(.black.opacity(0.8))
            .cornerRadius(20)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(.black.gradient)
    }
}

#Preview {
    KeyboardDismissView()
}
