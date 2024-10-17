//
//  HWButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct AddHWButton: View {
    var body: some View {
            Image(systemName: "plus")
               .frame(width: 65, height: 65)
               .background(.blue.opacity(0.5))
               .foregroundStyle(.white)
               .font(.title)
               .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        }
    }

#Preview {
    AddHWButton()
}
