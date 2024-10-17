//
//  NewClassViewModel.swift
//  HomeworkApp
//
//  Created by Max Roberts on 1/21/24.
//

import SwiftUI

final class NewClassViewModel: ObservableObject {
    //@Published var emptyClass: Class = Class(name: "", professor: "", location: "", color: CodableColor(Color(.systemBackground)))
    @Published var selectedName: String = ""
    @Published var selectedColor: Color = Color(.systemBackground)
    @Published var selectedProfessor: String = ""
    @Published var selectedLocation: String = ""
}

