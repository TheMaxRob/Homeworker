//
//  ClassSideButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/19/24.
//

import SwiftUI

struct ClassSideButton: View {
    
    let Class: Class
    var isSelected: Bool
    
    var body: some View {
        
        UnevenRoundedRectangle()
            .overlay {
                Text("\(Class.name)")
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 5)
                    .opacity(0.8)
            }
            .clipShape(.rect(cornerRadii: .init(topLeading: 20, bottomLeading: 20)))
            .frame(width: 85, height: 35)
            .foregroundStyle(Color(hex: Class.color).opacity(0.7))
            .lineLimit(1)
            .minimumScaleFactor(0.9)
            .shadow(color: isSelected ? Color.yellow.opacity(0.9) : Color.clear, radius: 10)
    }
        
}



#Preview {
    ClassSideButton(Class: MyData.sampleClass, isSelected: false)
}
