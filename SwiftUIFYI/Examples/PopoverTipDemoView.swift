//
//  InlineTip.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 01.10.24.
//

import SwiftUI
import TipKit

struct OnboardingTip: Tip {
    var title: Text {
        Text("New Note")
    }
    
    var message: Text? {
        Text("Tap here to create a new note")
    }
    
    var image: Image? {
        Image(systemName: "info.circle.fill")
    }
}

struct PopoverTipDemoView: View {
    let addNoteTip = OnboardingTip()
    
    var body: some View {
        VStack {

            Button {
                addNoteTip.invalidate(reason: .actionPerformed)
            } label: {
                Image(systemName: "note.text.badge.plus")
                    .font(.system(size: 80))
            }
            .popoverTip(addNoteTip, arrowEdge: .bottom)

        }
        .task {
            do {
#if DEBUG
                // clear store to force showing Tips every launch
                try Tips.resetDatastore()
#endif
                try Tips.configure()
            } catch {
                print("TipKit error: \(error.localizedDescription)")
            }
        }

    }
}


#Preview {
    PopoverTipDemoView()
}
