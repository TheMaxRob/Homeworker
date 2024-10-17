//
//  CalendarView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @StateObject var viewModel = CalendarViewModel()
    @Environment(\.modelContext) private var modelContext
    @Query private var assignments: [Assignment]
    
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    // Left and Right Arrows
                    HStack {
                        Button(action: {
                            viewModel.updateMonth(increment: -1)
                        }, label: {
                            LeftRightButton(direction: "left")
                                .offset(y: -4)
                        })
                        
                        Text("\(Date.monthString(date: viewModel.date))")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.bottom, 10)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.updateMonth(increment: 1)
                        }, label: {
                            LeftRightButton(direction: "right")
                                .offset(y: -4)
                        })
                    }
                    
                    // Days of week
                    HStack {
                        ForEach(days, id: \.self) { day in
                            Text(day)
                                .font(.system(size: 12, weight: .medium))
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    // Calendar numbers
                    LazyVGrid(columns: Array(repeating: GridItem(), count: days.count), content: {
                        let datesOfMonth = viewModel.date.datesOfMonth()
                        let firstDayOfWeekday = Date.getWeekdayComponent(date: datesOfMonth.first ?? Date())
                        
                        // Add empty cells before the 1st day to align the grid
                        ForEach(0..<firstDayOfWeekday-1, id: \.self) { _ in
                            Text("")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        
                        ForEach(datesOfMonth, id: \.self) { date in
                            NavigationLink {
                                AssignmentListSubView(day: date)
                            } label: {
                                CalendarGridView(day: date, assignments: assignments)
                            }
                        }
                    })
                }
                .blur(radius: viewModel.isShowingDayDetailView ? 10 : 0)
                .navigationTitle("Your Calendar")
            }
        }
    }



    
}

#Preview {
    CalendarView()
}

extension Date {
    
    func datesOfMonth() -> [Date] {
            let calendar = Calendar.current
            let currentDateComponents = calendar.dateComponents([.year, .month], from: self)
            
            guard let startOfMonth = calendar.date(from: currentDateComponents),
                  let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth) else {
                return []
            }
            
            var dates: [Date] = []
            var currentDate = startOfMonth
            
            while currentDate <= endOfMonth {
                dates.append(currentDate)
                guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                    break
                }
                currentDate = nextDate
            }
            
            return dates
        }
    
    
    static func formatDateDay(date: Date) -> Int {
        let calendar = Calendar.current

        return calendar.component(.day, from: date)
    }
    
    
    static func getWeekdayComponent(date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date)
    }
    
    static func getWeekdayString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // for the full name of the day of the week
        return dateFormatter.string(from: Date())
    }
    
    
    static func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        
        return dateFormatter.string(from: date)
    }
}


