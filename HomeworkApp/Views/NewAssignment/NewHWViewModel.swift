//
//  NewHWViewModel.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

final class NewHWViewModel: ObservableObject {
    @Published var assignment: Assignment = Assignment(name: "", thisClass: Class(name: "", professor: "", location: "", color: Color(Color(.systemBackground))), dueDate: Date(), priority: .low, info: "")
}
