//
//  DismissButton.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/18/24.
//

import SwiftUI

struct DismissButton: View {
    var body: some View {
        ZStack {
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundColor(.black)
                //.frame(width: 44, height: 44)
        }
    }
}

#Preview {
    DismissButton()
}
