//
//  CancelButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct CancelButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 115, height: 40)
            .foregroundStyle(.gray)
            .overlay {
                Text("Cancel")
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    CancelButton()
}
