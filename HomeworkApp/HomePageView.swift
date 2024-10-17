import SwiftUI
import SwiftData

struct HomePageView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var assignments: [Assignment]
    @Query private var classes: [Class]
    
    @StateObject var viewModel = HomePageViewModel()
    
    @State private var showingDeleteClassAlert = false
    @State private var showingDeleteAssignmentAlert = false
    @State private var classSelectedForDeletion: Class? = nil
    @State private var selectedAssignment: Assignment? = nil
    @State private var selectedClass: Class? = nil
    @State private var expandedAssignments: Set<Assignment.ID> = []
    
    
    
    var body: some View {
        ZStack {
            NavigationStack {
                GeometryReader { geometry in
                    HStack(spacing: 0) {
                        // Assignment List
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 3) {
                                ForEach(assignments.sorted { $0.dueDate < $1.dueDate }) { assignment in
                                    if !assignment.isCompleted {
                                        if selectedClass != nil {
                                            if assignment.thisClass == selectedClass {
                                                AssignmentListItemView(assignment: assignment)
                                            }
                                        } else {
                                            AssignmentListItemView(assignment: assignment)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(width: geometry.size.width * 0.725) // Based hard coding
                        
                        Divider()
                            .padding(.leading, 12)
                            .padding(.trailing, 12)
                            .padding(.bottom)
                            
                        
                        // Class Buttons
                        VStack(spacing: 20) {
                            ForEach(classes) { classItem in
                                ClassSideButton(Class: classItem, isSelected: (classItem == selectedClass))
                                    .onTapGesture {
                                        if selectedClass != classItem {
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
                            Button(action: {
                                viewModel.isShowingNewClassView = true
                            }, label: {
                                AddClassButton()
                            })
                        }
                        .frame(width: geometry.size.width * 0.21) // Based hard coding
                    }
                    .padding(.trailing, 0)
                }
                .padding(.top)
                .padding(.trailing, 0)
                
                .navigationTitle("All Assignments")
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
//        .onAppear {
//            // Delete all assignments where assignment.isCompleted == true
//            let completedAssignments = assignments.filter { $0.isCompleted }
//            for assignment in completedAssignments {
//                modelContext.delete(assignment)
//            }
//            try? modelContext.save()
//        }
    }
    
    // Custom View for each Assignment List Item with Info toggle
    @ViewBuilder
    private func AssignmentListItemView(assignment: Assignment) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            AssignmentListItem(assignment: assignment)
                .onTapGesture {
                    withAnimation {
                        toggleExpandedAssignment(assignment)
                    }
                }
                .onLongPressGesture {
                    showingDeleteAssignmentAlert = true
                    selectedAssignment = assignment
                }
            
            // Conditionally show the info with animation
            if expandedAssignments.contains(assignment.id) {
                Text(assignment.info)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .transition(.opacity)
                    .padding(.leading, 15)
            }
        }
        .padding(.bottom, 5)
    }
    
    // Toggle the expanded state for a specific assignment
    private func toggleExpandedAssignment(_ assignment: Assignment) {
        if expandedAssignments.contains(assignment.id) {
            expandedAssignments.remove(assignment.id)
        } else {
            expandedAssignments.insert(assignment.id)
        }
    }
}

#Preview {
    HomePageView()
        .modelContainer(for: [Assignment.self, Class.self])
}
