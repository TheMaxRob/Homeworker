//
//  NewClassView.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

struct NewClassView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var viewModel = NewClassViewModel()
    @Binding var isShowingNewClassView: Bool
    
    var body: some View {
        ZStack {
            // Background to detect tap outside the modal
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowingNewClassView = false
                }
            
            // Modal content
            VStack(alignment: .leading) {
                Form {
                    Section("New Class") {
                        TextField("Class Name", text: $viewModel.selectedName)
                        TextField("Professor", text: $viewModel.selectedProfessor)
                        TextField("Location", text: $viewModel.selectedLocation)
                        
                        ColorPicker("Class Color", selection: $viewModel.selectedColor)
                        
                        Button(action: {
                            // Create new class and add it to data
                            let newClass = Class(name: viewModel.selectedName,
                                                 professor: viewModel.selectedProfessor,
                                                 location: viewModel.selectedLocation,
                                                 color: Color(viewModel.selectedColor))
                            
                            modelContext.insert(newClass)
                            try? modelContext.save()
                            isShowingNewClassView = false
                            print("New Class Color: \(newClass.color)")
                        }, label: {
                            Text("Create Class")
                        })
                    }
                }
                .frame(width: 300, height: 300)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                .shadow(radius: 40)
                .overlay(Button {
                    isShowingNewClassView = false
                } label: {
                    DismissButton()
                        .padding(.top, 15)
                        .padding(.trailing, 15)
                }, alignment: .topTrailing)
            }
        }
    }
}

#Preview {
    NewClassView(isShowingNewClassView: .constant(true))
}
