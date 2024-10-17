//
//  MockData.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct MyData {
    static let sampleAssignment = Assignment(name: "Derivatives", thisClass: Class(name: "Calculus", professor: "Hernandez", location: "Atwood 316", color: Color(.orange)), dueDate: Date(), priority: .high, info: "Information about Assignment")
    
    static let sampleAssignments = [sampleAssignment]
    
    static let sampleClass = Class(name: "Calculus", professor: "Hernandez", location: "Atwood 316", color: Color(.orange))
    
    static let sampleClasses = [sampleClass]
}
