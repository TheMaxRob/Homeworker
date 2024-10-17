//
//  TrashButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct TrashButton: View {
    var body: some View {
        
        Image(systemName: "trash")
            .foregroundStyle(.red)
            .imageScale(.large)
        
    }
}

#Preview {
    TrashButton()
}
