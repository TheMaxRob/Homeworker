//
//  DatePin.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct DatePin: View {
    
    let assignment: Assignment
    
    var body: some View {
        let formattedDateDay = assignment.formatDateDay()
        let formattedDateMonth = assignment.formatDateMonth()
        VStack(spacing: 0) {
            Text("\(formattedDateDay)")
                .font(.title2)
                .fontWeight(.bold)
            Text("\(formattedDateMonth)")
                .font(.callout)
        }
        .frame(width: 60, height: 60)
        .foregroundStyle(.white)
        .background(Color(assignment.priority.color).opacity(0.6))
        .clipShape(Circle())
    }
}

#Preview {
    DatePin(assignment: MyData.sampleAssignment)
}
