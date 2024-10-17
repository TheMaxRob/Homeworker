//
//  ConfirmDeletion.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct ConfirmHWDeletionView: View {
    @Environment(\.modelContext) private var modelContext
    var assignment: Assignment
    @Binding var isShowingConfirmHWDeletionView: Bool
    @Binding var isShowingAssignmentDetailView: Bool
    
    var body: some View {
        VStack {
            Text("Delete Homework")
                .font(.title)
                .padding(.bottom, 3)
            Text("Are you sure you want to delete: ")
                .padding(.bottom, 6)
            Text("\(assignment.name)")
                .fontWeight(.semibold)
                .font(.title3)
            HStack {
                Button(action: {
                    isShowingConfirmHWDeletionView = false
                }, label: {
                    CancelButton()
                })
                Button(action: {
                    Assignment.deleteAssignment(assignment: assignment, context: modelContext)
                    isShowingConfirmHWDeletionView = false
                    isShowingAssignmentDetailView = false
                }, label: {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 115, height: 40)
                        .foregroundStyle(.red)
                        .overlay {
                            Text("Confirm")
                                .foregroundStyle(.white)
                        }
                })
            }
        }
        .frame(width: 300, height: 200)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 40)
    }
}

#Preview {
    ConfirmHWDeletionView(assignment: MyData.sampleAssignment, isShowingConfirmHWDeletionView: .constant(true), isShowingAssignmentDetailView: .constant(true))
}
