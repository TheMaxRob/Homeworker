//
//  HomeworkAppApp.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

@main
 struct HomeworkApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeworkAppTabView()
                .modelContainer(for: [Assignment.self, Class.self])
        }
    }
}
