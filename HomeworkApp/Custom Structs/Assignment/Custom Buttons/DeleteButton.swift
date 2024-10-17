//
//  DeleteButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct DeleteButton: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        Text("Delete")
            .foregroundStyle(.white)
            .font(.title2)
            .frame(width: width, height: height)
            .background(.red)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    DeleteButton(width: 150, height: 44)
}
