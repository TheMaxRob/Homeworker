//
//  HomePageViewModel.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/20/24.
//

import SwiftUI

final class HomePageViewModel: ObservableObject {
    
    @Published var assignments: [Assignment] = []
    @Published var classes: [Class] = []
    
    // MARK: Assignments
    @Published var isShowingNewAssignmentView = false
    @Published var isShowingAssignmentDetailView = false
    var selectedAssignment: Assignment = Assignment(name: "", thisClass: Class(name: "", professor: "", location: "", color: Color(.clear)), dueDate: Date(), priority: .low, info: "")
    @Published var isShowingEditAssignmentView = false
    @Published var assignmentWasCompleted = false
    
    
    
    // MARK: Classes
    @Published var isShowingNewClassView = false
    @Published var isShowingClassDetailView = false
    @Published var selectedClass: Class = Class(name: "", professor: "", location: "", color: Color(.clear))
    @Published var isShowingEditClassView = false
    @Published var isShowingClassDeleteButton = false
    
    
    
    // MARK: Calendar
    @Published var isShowingCalendarView = false
    @Published var isShowingHomePage = true
}
