//
//  CompleteButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct CompleteButton: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .frame(width: 120, height: 44)
            .foregroundStyle(.green)
            .overlay {
                Text("Complete")
                    .foregroundStyle(.white)
                    .font(.title3)
            }
    }
}

#Preview {
    CompleteButton()
}
