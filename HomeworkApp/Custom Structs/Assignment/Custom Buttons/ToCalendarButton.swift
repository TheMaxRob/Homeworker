//
//  ToCalendarButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct ToCalendarButton: View {
    var body: some View {
        Image(systemName: "calendar")
           .frame(width: 75, height: 75)
           .background(.red.opacity(0.9))
           .foregroundStyle(.white)
           .font(.title)
           .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ToCalendarButton()
}
