//
//  AssignmentListSubView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 9/8/24.
//

import SwiftUI
import SwiftData

struct AssignmentListSubView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var unfilteredAssignments: [Assignment]
    let day: Date
    private var assignments: [Assignment] {
        unfilteredAssignments.filter {
            Calendar.current.isDate($0.dueDate, inSameDayAs: day) && !$0.isCompleted
        }
    }

    @Query private var classes: [Class]
    
    @StateObject var viewModel = HomePageViewModel()
    
    @State private var showingDeleteClassAlert = false
    @State private var showingDeleteAssignmentAlert = false
    @State private var classSelectedForDeletion: Class? = nil
    @State private var selectedAssignment: Assignment? = nil
    @State private var selectedClass: Class? = nil
    
    var body: some View {
        ZStack {
            NavigationStack {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        // Assignment List
                        ScrollView(.vertical) {
                            LazyVStack {
                                ForEach(assignments) { assignment in
                                    if (!assignment.isCompleted) {
                                        if (selectedClass != nil) {
                                            if (assignment.thisClass == selectedClass) {
                                                AssignmentListItem(assignment: assignment)
                                                    .onLongPressGesture {
                                                        showingDeleteAssignmentAlert = true
                                                        selectedAssignment = assignment
                                                    }
                                            }
                                        } else {
                                            AssignmentListItem(assignment: assignment)
                                                .onLongPressGesture {
                                                    showingDeleteAssignmentAlert = true
                                                    selectedAssignment = assignment
                                                }
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width * 0.7)
                        
                        // Class Buttons
                        VStack(spacing: 20) {
                            ForEach(classes) { classItem in
                                ClassSideButton(Class: classItem, isSelected: (classItem == selectedClass))
                                    .onTapGesture {
                                        if (selectedClass != classItem) {
                                            selectedClass = classItem
                                        } else {
                                            selectedClass = nil
                                        }
                                    }
                                    .onLongPressGesture {
                                        classSelectedForDeletion = classItem
                                        showingDeleteClassAlert = true
                                    }
                                    .alert(isPresented: $showingDeleteClassAlert) {
                                        Alert(
                                            title: Text("Delete Class"),
                                            message: Text("Are you sure you want to delete this class?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                if let classSelectedForDeletion = classSelectedForDeletion {
                                                    modelContext.delete(classSelectedForDeletion)
                                                    try? modelContext.save()
                                                }
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                            }
                        }
                        .frame(width: geometry.size.width * 0.383) // Based hard coding of correct values
                    }
                    .padding(.trailing, 0)
                }
                .padding(.top)
                .padding(.trailing, 0)
                
                .navigationTitle(formattedDate(day))
                .navigationBarItems(trailing: Button(action: {
                    viewModel.isShowingNewAssignmentView = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                })
            }
            .alert(isPresented: $showingDeleteAssignmentAlert) {
                Alert(
                    title: Text("Delete Assignment"),
                    message: Text("Are you sure you want to delete this assignment?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let selectedAssignment = selectedAssignment {
                            modelContext.delete(selectedAssignment)
                            try? modelContext.save()
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .blur(radius: viewModel.isShowingNewAssignmentView || viewModel.isShowingAssignmentDetailView || viewModel.isShowingNewClassView || viewModel.isShowingClassDetailView || viewModel.isShowingCalendarView ? 10 : 0)
            .fullScreenCover(isPresented: $viewModel.isShowingCalendarView, content: {
                CalendarView()
            })
            
            if viewModel.isShowingNewAssignmentView {
                NewAssignmentView(isShowingNewAssignmentView: $viewModel.isShowingNewAssignmentView)
            }
            if viewModel.isShowingNewClassView {
                NewClassView(isShowingNewClassView: $viewModel.isShowingNewClassView)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}

#Preview {
    AssignmentListSubView(day: Date())
        .modelContainer(for: [Assignment.self, Class.self])
}
