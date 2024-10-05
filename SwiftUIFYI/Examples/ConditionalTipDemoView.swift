//
//  InlineTip.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 01.10.24.
//

import SwiftUI
import TipKit

struct CoinsTip: Tip {
    
    @Parameter static var isCoinBalancePositive: Bool = false
    
    var title: Text {
        Text("Coin Balance")
    }
    
    var message: Text? {
        Text("Your Coin balance will appear here.")
    }
    
    var image: Image? {
        Image(systemName: "bitcoinsign.circle.fill")
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.$isCoinBalancePositive) {
                $0 == true
            }
        ]
    }
}

struct ConditionalTipDemoView: View {
    
    let coinTip = CoinsTip()
    @State var coinCount: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    coinCount += 1
                } label: {
                    Label("Buy Coins", systemImage: "bitcoinsign.circle.fill")
                        .font(.largeTitle)
                        .padding()
                }
                
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }
            .onChange(of: coinCount) { oldValue, newValue in
                CoinsTip.isCoinBalancePositive = newValue > 0
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(alignment: .bottom) {
                        Image(systemName: "bitcoinsign.circle.fill")
                        if coinCount > 0 {
                            Text("\(coinCount)")
                                .bold()
                        }
                    }
                    .foregroundStyle(.orange)
                    .font(.title)
                    .opacity(coinCount > 0 ? 1 : 0.2)
                    .popoverTip(coinTip, arrowEdge: .top)
                }
            }
        }
        
        
    }
}


#Preview {
    ConditionalTipDemoView()
}
