//
//  FancyGraphExample.swift
//  SwiftUIFYI
//
//  Created by Said Marouf on 13.10.24.
//

import SwiftUI
import Charts

struct ChartExample: View {
  
  private let revenueHistory = mockHistory()
  private let gradient = Gradient(stops: [
    .init(color: .teal, location: 0),
    .init(color: .teal.opacity(0), location: 0.9)
  ])
  
  var body: some View {
    VStack {
      
      Chart(revenueHistory) { revenue in
        // For gradient effect under the line chart
        AreaMark(
          x: .value("Date", revenue.date),
          y: .value("Revenue", revenue.value)
        )
        .interpolationMethod(.cardinal)
        .foregroundStyle(gradient)
        
        // Line chart
        LineMark(
          x: .value("Date", revenue.date),
          y: .value("Revenue", revenue.value)
        )
        .lineStyle(StrokeStyle(lineWidth: 4, lineCap: .round))
        .interpolationMethod(.cardinal)
        
        //Show data points on the line itself
        PointMark(
          x: .value("Date", revenue.date),
          y: .value("Revenue", revenue.value)
        )
        .annotation(position: .bottomTrailing) {
          Text(
            revenue.date,
            format: .dateTime.month(.twoDigits).day(.twoDigits)
          )
          .font(.caption)
        }
        
      }
      .padding()
      .background(.blue.gradient)
      .foregroundStyle(.white)
      .frame(width: 400, height: 400)
      .cornerRadius(24)
      
      Spacer()
    }
  }
  
  static func mockHistory() -> [Revenue] {
    return [
      .init(date: daysFromNow(1), value: 100),
      .init(date: daysFromNow(2), value: 200),
      .init(date: daysFromNow(3), value: 400),
      .init(date: daysFromNow(4), value: 600),
      .init(date: daysFromNow(5), value: 200),
      .init(date: daysFromNow(6), value: 300),
      .init(date: daysFromNow(7), value: 200),
      .init(date: daysFromNow(8), value: 500)
    ]
  }
  
  static func daysFromNow(_ days: Int) -> Date {
    Calendar.current.date(byAdding: .day, value: days, to: .now)!
  }
  
}

struct Revenue: Identifiable {
  var id: Date { date }
  let date: Date
  let value: Double
}

#Preview {
  ChartExample()
}
