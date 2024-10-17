//
//  LoadingView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/20/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .controlSize(.large)
                .tint(.green)
        }
    }
}
