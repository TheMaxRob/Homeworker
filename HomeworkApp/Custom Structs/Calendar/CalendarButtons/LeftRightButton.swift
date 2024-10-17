//
//  LeftRightButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/22/24.
//

import SwiftUI

struct LeftRightButton: View {
    
    let direction: String
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 35, height: 35)
                .foregroundStyle(.blue.opacity(0.1))
            Image(systemName: "chevron.\(direction)")
                .foregroundStyle(.blue)
        }
        
    }
}

#Preview {
    LeftRightButton(direction: "left")
}
