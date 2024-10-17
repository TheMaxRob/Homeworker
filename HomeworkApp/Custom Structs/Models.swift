//
//  Models.swift
//  HomeworkApp
//
//  Created by Max Roberts on 9/6/24.
//

import SwiftUI
import SwiftData

@Model
final class Class {
    @Attribute(.unique) var id: UUID
    var name: String
    var professor: String
    var location: String
    var color: String

    init(name: String, professor: String, location: String, color: Color) {
        self.id = UUID()
        self.name = name
        self.professor = professor
        self.location = location
        self.color = color.toHex() // Convert Color to a Hex string
    }

    // Convenience initializer with default values
    init() {
        self.id = UUID()
        self.name = ""
        self.professor = ""
        self.location = ""
        self.color = Color.clear.toHex()
    }
}

// Extension to convert Color to a hex string
extension Color {
    /// Converts a hex string to a SwiftUI `Color`.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        
        if hex.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        
        var rgb: UInt64 = 0
        if scanner.scanHexInt64(&rgb) {
            let r = Double((rgb >> 16) & 0xFF) / 255.0
            let g = Double((rgb >> 8) & 0xFF) / 255.0
            let b = Double(rgb & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(white: 1.0, opacity: 1.0) // Default to white if the conversion fails
        }
    }
    
    /// Converts a `Color` to a hex string.
    func toHex() -> String {
        // Convert to UIColor (iOS) or NSColor (macOS) to get components
        let uiColor = UIColor(self) // Use NSColor(self) on macOS
        let components = uiColor.cgColor.components ?? [0, 0, 0, 1]
        let r = components[0]
        let g = components[1]
        let b = components.count > 2 ? components[2] : g // Handle grayscale colors
        let hexString = String(format: "#%02lX%02lX%02lX", Int(r * 255), Int(g * 255), Int(b * 255))
        return hexString
    }
}



import SwiftUI
import SwiftData

@Model
final class Assignment: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var thisClass: Class? // Renamed to avoid conflict with keyword `Class`
    var dueDate: Date
    var priority: Priority
    var info: String
    var isCompleted: Bool

    init(name: String, thisClass: Class? = nil, dueDate: Date, priority: Priority, info: String) {
        self.id = UUID()
        self.name = name
        self.thisClass = thisClass
        self.dueDate = dueDate
        self.priority = priority
        self.info = info
        self.isCompleted = false
    }

    enum Priority: String, Codable, CaseIterable {
        case low
        case mid
        case high
        
        var color: Color {
            switch self {
            case .low: return .green
            case .mid: return .yellow
            case .high: return .red
            }
        }
    }

    // **MARK: - Formatting Methods**
    
    func formatDateDay() -> String {
        dueDate.formatted(.dateTime.day())
    }

    func formatDateMonth() -> String {
        dueDate.formatted(.dateTime.month(.abbreviated))
    }
    
    var priorityString: String {
        switch priority {
        case .high: return "High"
        case .mid: return "Mid"
        case .low: return "Low"
        }
    }
}

// **MARK: - SwiftData Operations**

extension Assignment {
    static func completeAssignment(assignment: Assignment, context: ModelContext) {
        assignment.isCompleted = true
        try? context.save()
    }
    
    static func deleteAssignment(assignment: Assignment, context: ModelContext) {
        context.delete(assignment)
        try? context.save()
    }
}
