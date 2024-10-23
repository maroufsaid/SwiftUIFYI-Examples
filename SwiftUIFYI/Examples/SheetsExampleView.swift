//
//  SheetsView.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 23.10.24.
//

import SwiftUI

struct SheetsExampleView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        
        VStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("Show Sheet").font(.largeTitle)
            }.buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $isPresented) {
            MySheetView()
        }
    }
}

struct MySheetView: View {
    
    var body: some View {
        VStack {
            Text("Hello! I am a sheet")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.largeTitle)
                .background(.purple)
        }
        .presentationDetents([.medium, .large])
        //.presentationDetents([.fraction(0.5), .large])
        //.presentationDetents([.fraction(0.3), .fraction(0.7)])
        //.presentationDetents([.height(200)])
    }
}

#Preview {
    SheetsExampleView()
}
