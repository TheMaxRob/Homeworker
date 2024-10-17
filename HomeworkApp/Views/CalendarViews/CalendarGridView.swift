//
//  CalendarGridView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/27/24.
//

import SwiftUI

struct CalendarGridView: View {
    let day: Date
    let assignments: [Assignment]
    
    private var filteredAssignments: [Assignment] {
        assignments.filter {
            Calendar.current.isDate($0.dueDate, inSameDayAs: day) && !$0.isCompleted
        }
    }
    
    private var uniqueClassColors: [String] {
        // Use a Set to store unique class colors
        let classColors = Set(filteredAssignments.compactMap { $0.thisClass?.color })
        return Array(classColors)
    }
    
    private var colorCircles: [AnyView] {
        uniqueClassColors.map { colorString in
            AnyView(ColorCircle(color: Color(hex: colorString)))
        }
    }
    
    var body: some View {
        ZStack {
            Text("\(Date.formatDateDay(date: day))")
                .frame(width: 25, height: 25)
                .padding(.vertical)
                .font(day.isToday ? .title3 : .body)
                .fontWeight(day.isToday ? .bold : .regular)

            FlowLayout(items: colorCircles, itemWidth: 25, spacing: 1)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
                .offset(y: 30)
        }
    }
}

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
