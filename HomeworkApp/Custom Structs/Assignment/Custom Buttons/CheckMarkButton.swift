//
//  CompleteButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct CheckMarkButton: View {
    var body: some View {
        Image(systemName: "checkmark.circle")
            .font(.system(size: 25))
            .opacity(0.3)
            //.frame(width: 50, height: 50)
            .foregroundStyle(.green)
    }
}

#Preview {
    CheckMarkButton()
}
