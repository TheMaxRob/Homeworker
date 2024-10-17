//
//  HomeworkAppTabView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 9/4/24.
//

import SwiftUI

struct HomeworkAppTabView: View {
    
    // To set default
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            CalendarView()
                .tabItem { Label("Calendar", systemImage: "calendar") }
                .tag(2)
            
            HomePageView()
                .tabItem { Label("Tasks", systemImage: "pencil.and.list.clipboard") }
                .tag(1)
        }
    }
}

#Preview {
    HomeworkAppTabView()
}
