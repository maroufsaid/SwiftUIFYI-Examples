//
//  TimeDateHelpers.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 16.10.24.
//

import Foundation

extension TimeInterval {
    
    static let minutesAndSecondsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var minutesAndSeconds: String {
        TimeInterval.minutesAndSecondsFormatter.string(from: self) ?? ""
    }
    
}
