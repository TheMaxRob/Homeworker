//
//  CalendarViewModel.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

final class CalendarViewModel: ObservableObject {
    @Published var selectedDay: Date = Date()
    @Published var isShowingDayDetailView: Bool = false
    @Published var date = Date()
    
    func updateMonth(increment: Int) {
        date = Calendar.current.date(byAdding: .month, value: increment, to: date) ?? Date()
    }
}
