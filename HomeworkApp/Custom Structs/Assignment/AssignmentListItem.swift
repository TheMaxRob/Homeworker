//
//  AssignmentContainerView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

@MainActor
final class AssignmentListItemViewModel: ObservableObject {
    @Published var wasCompleted = false
}


struct AssignmentListItem: View {
    @Environment(\.modelContext) private var modelContext
    var assignment: Assignment
    @StateObject private var viewModel = AssignmentListItemViewModel()

    // Animation states
    @State private var backgroundWidth: CGFloat = 0
    @State private var isVisible = true
    @State private var contentOpacity = 1.0
    @State private var itemHeight: CGFloat = 100

    var body: some View {
        ZStack(alignment: .leading) {
            if isVisible {
                HStack {
                    Color.green
                        .opacity(0.7)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: backgroundWidth)
                        .animation(.easeInOut(duration: 1.5), value: backgroundWidth)
                    Spacer()
                }
                .background(Color(hex: assignment.thisClass?.color ?? "#000000").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .animation(.easeInOut(duration: 1.5), value: isVisible)
            }
            
            HStack {
                DatePin(assignment: assignment)
                
                VStack(alignment: .leading) {
                    Text("\(assignment.name)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.6)
                        .opacity(contentOpacity)
                        .foregroundColor(isLate(dueDate: assignment.dueDate) ? .red : .primary)
                }

                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        backgroundWidth = 600
                    }
                    withAnimation(.easeInOut(duration: 1.0).delay(1.0)) {
                        contentOpacity = 0
                    }
                    viewModel.wasCompleted = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        Assignment.completeAssignment(assignment: assignment, context: modelContext)
                        withAnimation(.easeInOut(duration: 1.5)) {
                            isVisible = false
                            itemHeight = 0
                        }
                    }
                }) {
                    CheckMarkButton()
                    
                }
                
            }
            .padding()
            .frame(height: itemHeight)
            .clipped()   
        }
    }
}

func isLate(dueDate: Date) -> Bool {
    let calendar = Calendar.current
    let currentDate = calendar.startOfDay(for: Date())
    let assignmentDueDate = calendar.startOfDay(for: dueDate)
    
    return currentDate > assignmentDueDate
}
