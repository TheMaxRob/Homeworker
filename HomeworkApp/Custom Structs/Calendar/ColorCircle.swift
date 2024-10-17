//
//  ColorCircle.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/27/24.
//

import SwiftUI

struct ColorCircle: View {
    
    let color: Color
    
    var body: some View {
        Circle()
            .frame(width: 7, height: 7) // Fixed size for the circle
            .foregroundStyle(color)
    }
}

#Preview {
    ColorCircle(color: .blue)
}
