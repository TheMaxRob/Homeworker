//
//  AddClassButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct AddClassButton: View {
    var body: some View {
        UnevenRoundedRectangle()
            .overlay {
                Label("New", systemImage: "plus")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 2)
                    .opacity(0.8)
            }
            .clipShape(.rect(cornerRadii: .init(topLeading: 20, bottomLeading: 20)))
            .frame(width: 85, height: 35)
            .foregroundStyle(.blue.opacity(0.7))
            .lineLimit(1)
            .minimumScaleFactor(0.9)
    }
}

#Preview {
    AddClassButton()
}
