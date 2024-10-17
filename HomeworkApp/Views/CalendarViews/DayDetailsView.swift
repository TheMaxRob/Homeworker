//
//  DayDetailsView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI
import SwiftData

struct DayDetailsView: View {
    
    let day: Date
    @Query private var assignments: [Assignment]
    private var filteredAssignments: [Assignment] {
        assignments.filter {
            Calendar.current.isDate($0.dueDate, inSameDayAs: day) && !$0.isCompleted
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Your Assignments")
                    .navigationTitle("\(Date.getWeekdayString(date: day)), \(Date.monthString(date: day)) \(Date.formatDateDay(date: day))")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
            }
                
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(filteredAssignments) { assignment in
                        AssignmentListItem(assignment: assignment)
                    }
                }
            }
            }
            .frame(width: 300, height: 300)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding()
        }
    }

#Preview {
    DayDetailsView(day: Date())
}
