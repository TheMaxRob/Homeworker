//
//  NewHWView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI
import SwiftData

struct NewAssignmentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var classes: [Class]
    
    @State private var name = ""
    @State private var selectedClass: Class?
    @State private var priority = Assignment.Priority.mid
    @State private var dueDate = Date()
    @State private var info = ""
    
    @Binding var isShowingNewAssignmentView: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("New Assignment") {
                    TextField("Name", text: $name)
                    
                    Picker("Class", selection: $selectedClass) {
                        Text("None").tag(Class?.none)
                        ForEach(classes) { aClass in
                            Text(aClass.name).tag(Class?.some(aClass))
                        }
                    }
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(Assignment.Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue.capitalized).tag(priority)
                        }
                    }
                    
                    DatePicker("Due Date:", selection: $dueDate, displayedComponents: .date)
                    
                    TextField("Additional Info", text: $info)
                }
            }
            .navigationTitle("New Assignment")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isShowingNewAssignmentView = false
                },
                trailing: Button("Save") {
                    saveAssignment()
                }
            )
        }
    }
    
    private func saveAssignment() {
        let newAssignment = Assignment(
            name: name,
            thisClass: selectedClass,
            dueDate: dueDate,
            priority: priority,
            info: info
        )
        modelContext.insert(newAssignment)
        isShowingNewAssignmentView = false
    }
}

#Preview {
    NewAssignmentView(isShowingNewAssignmentView: .constant(true))
}
