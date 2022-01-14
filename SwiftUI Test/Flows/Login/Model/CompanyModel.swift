//
//  CompanyModel.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 24.11.2021.
//

import SwiftUI

final class CompanyModel: ObservableObject {
    
    @Published var type: CompanyType? = nil
    @Published var name = ""
    
    func resetData() {
        type = nil
        name = ""
    }
}
